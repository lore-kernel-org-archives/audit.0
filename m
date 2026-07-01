Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9043CEFE
	for <audit@vger.kernel.org>; Wed,  1 Jul 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912281; cv=none; b=mLiLqmFBeJz1bvTepMJjuuXUqxESFnpfkJAMLNLHTyjT0JMBpBbd9zfl4LcDeMYKPjxfJ07PhV2qh2eFhRykh2//0a3D5jKv1GbuLH55pYM31x9xtrE9Js9da52e6BCTLuzTYHBMpL1KXUkCePvwXyJiSRROJO69SEZ4Lih83P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912281; c=relaxed/simple;
	bh=ici8yNXnB3gpVN7apDYOV7smMCz4wI/KHevs80PKr20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=qoRwLG2ams6kMjpVnMrSFg4VC+uqoEzgp3p0N4md9tJ4KboekR2Hzcg1yE7t54efpoUbBNbM7i6d0NSbBx1ZYh5ocNUQGsRN2dAjpi2W0OPWiaDydaxoaF4K6sMQKcL1qpyE3FK0QjPW8AMW4H1dUqctZTlMGkMn5hcOWCfOuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atzMlYAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atzMlYAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782912279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qb9iA84rqAqSmFrq0wPj5mg0126cHARBoB7HeqhLUc8=;
	b=atzMlYAFkxwLJIpmCYx4lEErTzYvGxuDGj9EfHZTZ+PhsK9l5frk7u9XvdnIZA+kJwDe7D
	wH5ZI81upHemBM6yyjf+e2LJrKMWrVkHbOntdh9lFTRJnL1WO3xM6n9pEKzNC+JNSktjKm
	shpsHkdDN7Jvsjn3WZO+DghB4vhFcTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-_6kSB2JfPk2pm9yOsUsnAA-1; Wed,
 01 Jul 2026 09:24:36 -0400
X-MC-Unique: _6kSB2JfPk2pm9yOsUsnAA-1
X-Mimecast-MFC-AGG-ID: _6kSB2JfPk2pm9yOsUsnAA_1782912272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BCDA1977027;
	Wed,  1 Jul 2026 13:24:29 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7510195E486;
	Wed,  1 Jul 2026 13:24:25 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add FSOPEN record to log filesystem name
Date: Wed,  1 Jul 2026 10:24:10 -0300
Message-ID: <20260701132410.711205-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 1pjLvrs-T8gQ5SP6KezcumFbWXJupGJ_onraRfXm8YU_1782912272
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Modern mount tools (util-linux >= 2.39.1) use the new mount API
(fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
syscall. The generic SYSCALL audit record logs the fsopen syscall but
does not capture the filesystem name string, creating an audit gap for
filesystem mount operations.

Add an FSOPEN auxiliary record that logs the dereferenced filesystem
name string passed to fsopen(2).

  type=SYSCALL ... : arch=x86_64 syscall=fsopen ... a1=FSOPEN_CLOEXEC
  type=FSOPEN  ... : fs_name="tmpfs"

Link: https://github.com/linux-audit/audit-kernel/issues/152
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 fs/fsopen.c                |  3 +++
 include/linux/audit.h      | 10 ++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           | 13 +++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index ae19e5136598..8b07f9d42be2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/file.h>
 #include <uapi/linux/mount.h>
+#include <linux/audit.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -150,6 +151,8 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	if (ret < 0)
 		goto err_fc;
 
+	audit_log_fsopen(fs_name);
+
 	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
 
 err_fc:
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..077b2667180d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 			      enum audit_nfcfgop op, gfp_t gfp);
+extern void __audit_log_fsopen(const char *fs_name);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 		__audit_log_nfcfg(name, af, nentries, op, gfp);
 }
 
+static inline void audit_log_fsopen(const char *fs_name)
+{
+	if (!audit_dummy_context())
+		__audit_log_fsopen(fs_name);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 				   enum audit_nfcfgop op, gfp_t gfp)
 { }
 
+static inline void audit_log_fsopen(const char *fs_name)
+{ }
+
 #define audit_n_rules 0
 #define audit_signals 0
 #endif /* CONFIG_AUDITSYSCALL */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..abae0524746e 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -122,6 +122,7 @@
 #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
 #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
 #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
+#define AUDIT_FSOPEN		1340	/* Record showing fsopen fs_name arg */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..c82fd5606de5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2882,6 +2882,19 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 }
 EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
 
+void __audit_log_fsopen(const char *fs_name)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSOPEN);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "fs_name=");
+	audit_log_untrustedstring(ab, fs_name);
+	audit_log_end(ab);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
-- 
2.53.0

