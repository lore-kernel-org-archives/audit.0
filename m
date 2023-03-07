Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B4C678D4
	for <audit@archiver.kernel.org>; Tue,  7 Mar 2023 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCGMZ4 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCGMZy (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 7 Mar 2023 07:25:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624C7389A
        for <audit@vger.kernel.org>; Tue,  7 Mar 2023 04:25:29 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWF3D40HQzKq9N;
        Tue,  7 Mar 2023 20:23:20 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 20:25:24 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <audit@vger.kernel.org>
Subject: [PATCH -next] audit: refactor audit_log_cap to improve performance
Date:   Tue, 7 Mar 2023 20:25:24 +0800
Message-ID: <20230307122524.2341659-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

By testing the performance of snprintf on qemu, I found that
snprintf("%s", str) performed much better than snprintf("xx%s", str),
the former takes 2ns while the latter takes 60ns.

Based on the test results, using audit_log_format(ab, "%s", prefix)
instead of audit_log_format(ab, " %s=0", prefix) will get better
performance, so refactor the audit_log_cap() to improve performance.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/auditsc.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d..d04d0a57a603 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1295,11 +1295,12 @@ static void audit_log_execve_info(struct audit_context *context,
 static void audit_log_cap(struct audit_buffer *ab, char *prefix,
 			  kernel_cap_t *cap)
 {
+	audit_log_format(ab, "%s", prefix);
 	if (cap_isclear(*cap)) {
-		audit_log_format(ab, " %s=0", prefix);
+		audit_log_format(ab, "0");
 		return;
 	}
-	audit_log_format(ab, " %s=%016llx", prefix, cap->val);
+	audit_log_format(ab, "%016llx", cap->val);
 }
 
 static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
@@ -1308,8 +1309,8 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
 		audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
 		return;
 	}
-	audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
-	audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
+	audit_log_cap(ab, " cap_fp=", &name->fcap.permitted);
+	audit_log_cap(ab, " cap_fi=", &name->fcap.inheritable);
 	audit_log_format(ab, " cap_fe=%d cap_fver=%x cap_frootid=%d",
 			 name->fcap.fE, name->fcap_ver,
 			 from_kuid(&init_user_ns, name->fcap.rootid));
@@ -1450,10 +1451,10 @@ static void show_special(struct audit_context *context, int *call_panic)
 		break; }
 	case AUDIT_CAPSET:
 		audit_log_format(ab, "pid=%d", context->capset.pid);
-		audit_log_cap(ab, "cap_pi", &context->capset.cap.inheritable);
-		audit_log_cap(ab, "cap_pp", &context->capset.cap.permitted);
-		audit_log_cap(ab, "cap_pe", &context->capset.cap.effective);
-		audit_log_cap(ab, "cap_pa", &context->capset.cap.ambient);
+		audit_log_cap(ab, " cap_pi=", &context->capset.cap.inheritable);
+		audit_log_cap(ab, " cap_pp=", &context->capset.cap.permitted);
+		audit_log_cap(ab, " cap_pe=", &context->capset.cap.effective);
+		audit_log_cap(ab, " cap_pa=", &context->capset.cap.ambient);
 		break;
 	case AUDIT_MMAP:
 		audit_log_format(ab, "fd=%d flags=0x%x", context->mmap.fd,
@@ -1726,17 +1727,17 @@ static void audit_log_exit(void)
 			struct audit_aux_data_bprm_fcaps *axs = (void *)aux;
 
 			audit_log_format(ab, "fver=%x", axs->fcap_ver);
-			audit_log_cap(ab, "fp", &axs->fcap.permitted);
-			audit_log_cap(ab, "fi", &axs->fcap.inheritable);
+			audit_log_cap(ab, " fp=", &axs->fcap.permitted);
+			audit_log_cap(ab, " fi=", &axs->fcap.inheritable);
 			audit_log_format(ab, " fe=%d", axs->fcap.fE);
-			audit_log_cap(ab, "old_pp", &axs->old_pcap.permitted);
-			audit_log_cap(ab, "old_pi", &axs->old_pcap.inheritable);
-			audit_log_cap(ab, "old_pe", &axs->old_pcap.effective);
-			audit_log_cap(ab, "old_pa", &axs->old_pcap.ambient);
-			audit_log_cap(ab, "pp", &axs->new_pcap.permitted);
-			audit_log_cap(ab, "pi", &axs->new_pcap.inheritable);
-			audit_log_cap(ab, "pe", &axs->new_pcap.effective);
-			audit_log_cap(ab, "pa", &axs->new_pcap.ambient);
+			audit_log_cap(ab, " old_pp=", &axs->old_pcap.permitted);
+			audit_log_cap(ab, " old_pi=", &axs->old_pcap.inheritable);
+			audit_log_cap(ab, " old_pe=", &axs->old_pcap.effective);
+			audit_log_cap(ab, " old_pa=", &axs->old_pcap.ambient);
+			audit_log_cap(ab, " pp=", &axs->new_pcap.permitted);
+			audit_log_cap(ab, " pi=", &axs->new_pcap.inheritable);
+			audit_log_cap(ab, " pe=", &axs->new_pcap.effective);
+			audit_log_cap(ab, " pa=", &axs->new_pcap.ambient);
 			audit_log_format(ab, " frootid=%d",
 					 from_kuid(&init_user_ns,
 						   axs->fcap.rootid));
-- 
2.25.1

