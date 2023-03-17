Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD3AC74A5B
	for <audit@archiver.kernel.org>; Fri, 17 Mar 2023 03:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCQDiK (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 16 Mar 2023 23:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQDiI (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 16 Mar 2023 23:38:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9893710433
        for <audit@vger.kernel.org>; Thu, 16 Mar 2023 20:38:06 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pd8vT06nhzrTc5;
        Fri, 17 Mar 2023 11:37:08 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 11:37:34 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <audit@vger.kernel.org>
Subject: [PATCH -next] audit: let the caller of audit_get_sk() ensure that net is valid
Date:   Fri, 17 Mar 2023 11:37:33 +0800
Message-ID: <20230317033733.1450702-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

The caller of audit_get_sk() must ensure that net is valid, otherwise
there will be null-prt-defer, for example, in the netlink_unicast().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/audit.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..6a42a3801d01 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -285,16 +285,13 @@ static pid_t auditd_pid_vnr(void)
  * @net: the destination network namespace
  *
  * Description:
- * Returns the sock pointer if valid, NULL otherwise.  The caller must ensure
- * that a reference is held for the network namespace while the sock is in use.
+ * Returns the sock pointer. The caller must ensure than net is valid and
+ * a reference is held for the network namespace while the sock is in use.
  */
 static struct sock *audit_get_sk(const struct net *net)
 {
 	struct audit_net *aunet;
 
-	if (!net)
-		return NULL;
-
 	aunet = net_generic(net, audit_net_id);
 	return aunet->sk;
 }
-- 
2.25.1

