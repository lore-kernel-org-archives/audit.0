Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC6C00528
	for <audit@archiver.kernel.org>; Sat,  5 Aug 2023 02:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjHECjj (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 4 Aug 2023 22:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHECji (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 4 Aug 2023 22:39:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016A14EDB
        for <audit@vger.kernel.org>; Fri,  4 Aug 2023 19:39:37 -0700 (PDT)
Received: from kwepemd500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHmt23nH8ztRtN;
        Sat,  5 Aug 2023 10:36:10 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd500002.china.huawei.com (7.221.188.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.16; Sat, 5 Aug 2023 10:39:34 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <cuigaosheng1@huawei.com>, <paul@paul-moore.com>,
        <eparis@redhat.com>
CC:     <audit@vger.kernel.org>
Subject: [PATCH] audit: fix possible soft lockup in __audit_inode_child()
Date:   Sat, 5 Aug 2023 10:39:34 +0800
Message-ID: <20230805023934.347828-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500002.china.huawei.com (7.221.188.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Tracefs or debugfs maybe cause hundreds to thousands of PATH records,
too many PATH records maybe cause soft lockup.

For example:
  1. CONFIG_KASAN=y && CONFIG_PREEMPTION=n
  2. auditctl -a exit,always -S open -k key
  3. sysctl -w kernel.watchdog_thresh=5
  4. mkdir /sys/kernel/debug/tracing/instances/test

There may be a soft lockup as follows:
  watchdog: BUG: soft lockup - CPU#45 stuck for 7s! [mkdir:15498]
  Kernel panic - not syncing: softlockup: hung tasks
  Call trace:
   dump_backtrace+0x0/0x30c
   show_stack+0x20/0x30
   dump_stack+0x11c/0x174
   panic+0x27c/0x494
   watchdog_timer_fn+0x2bc/0x390
   __run_hrtimer+0x148/0x4fc
   __hrtimer_run_queues+0x154/0x210
   hrtimer_interrupt+0x2c4/0x760
   arch_timer_handler_phys+0x48/0x60
   handle_percpu_devid_irq+0xe0/0x340
   __handle_domain_irq+0xbc/0x130
   gic_handle_irq+0x78/0x460
   el1_irq+0xb8/0x140
   __audit_inode_child+0x240/0x7bc
   tracefs_create_file+0x1b8/0x2a0
   trace_create_file+0x18/0x50
   event_create_dir+0x204/0x30c
   __trace_add_new_event+0xac/0x100
   event_trace_add_tracer+0xa0/0x130
   trace_array_create_dir+0x60/0x140
   trace_array_create+0x1e0/0x370
   instance_mkdir+0x90/0xd0
   tracefs_syscall_mkdir+0x68/0xa0
   vfs_mkdir+0x21c/0x34c
   do_mkdirat+0x1b4/0x1d4
   __arm64_sys_mkdirat+0x4c/0x60
   el0_svc_common.constprop.0+0xa8/0x240
   do_el0_svc+0x8c/0xc0
   el0_svc+0x20/0x30
   el0_sync_handler+0xb0/0xb4
   el0_sync+0x160/0x180

Therefore, we add cond_resched() to __audit_inode_child() to fix it.

Fixes: 5195d8e217a7 ("audit: dynamically allocate audit_names when not enough space is in the names array")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d..fce37545644b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2454,6 +2454,7 @@ void __audit_inode_child(struct inode *parent,
 			found_parent = n;
 			break;
 		}
+		cond_resched();
 	}
 
 	/* is there a matching child entry? */
@@ -2473,6 +2474,7 @@ void __audit_inode_child(struct inode *parent,
 			found_child = n;
 			break;
 		}
+		cond_resched();
 	}
 
 	if (!found_parent) {
-- 
2.25.1

