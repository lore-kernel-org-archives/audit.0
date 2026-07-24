Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE33D9DDE
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905425; cv=none; b=VR1lahexJEI5X6/KuuQksL1BxTtsP7IOyeUI/4LtzmLCAlz5BjDFKu8+ZEW7bq42fA2n0FFEy4+ibNPv33oMXN9/vsF81BolKhnXbxUP+KxBBVpQ5RKK68zEPuqHbHMBvV0B/7bsAzjGYtfNHk1CksAq8ZsyRn6df8KnA3XUf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905425; c=relaxed/simple;
	bh=WAgDDePxRbNzo95S0T4oCMtij9uVeiX2EuJ/RfCFP9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=hrTH2M6+3cyPGlMNOOdfd0gYICiJ+vcm3GjCucSe72pvlM0EM9VTLcUozzsS7iZy6HRxyi1/bbaaLSBgSEl/sOhXLbVLOiyZhTGXmiJ1ttuVLA6TUyqskdhlgAE5mEIH3bYHV8uX/URlGYQ/JdN894goSLNOs46lJVG+OWxu1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gc8TcsBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc8TcsBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784905422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c0ViCeYIvDvbmJchKqAuBa754g93eEZt4PnUI1bl52Q=;
	b=gc8TcsBO4TqrgwoDZD0MWWeZ/IeR/br2lJcJAJ/btu+lJNZIpNqlWNSR3g9fZAEn3LUacX
	c+fKVMziUsXzIF9urWWUtORAsiX9ZTm11/IZvO/7Fm/fvid/5hHPW8cCI/pxA0iR44Ttr1
	Mn3JuWZipsP2L/mMSA6IwjK0D2t8sm0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-P1r0y-izPyOZOjBHnfPl1Q-1; Fri,
 24 Jul 2026 11:03:39 -0400
X-MC-Unique: P1r0y-izPyOZOjBHnfPl1Q-1
X-Mimecast-MFC-AGG-ID: P1r0y-izPyOZOjBHnfPl1Q_1784905417
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1050A19775FC;
	Fri, 24 Jul 2026 15:03:37 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C82F330002D5;
	Fri, 24 Jul 2026 15:03:31 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	brauner@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add CLONE3 auxiliary record to log process cloning
Date: Fri, 24 Jul 2026 12:02:59 -0300
Message-ID: <20260724150258.560396-2-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 5-ymRGu9xta1JoIb6KOGGlwv7zkIQXs459cQjIHH9kg_1784905417
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The clone3(2) syscall moves most parameters to struct clone_args.
For this reason, the generic SYSCALL audit record does not capture
the structured arguments.

Add a CLONE3 auxiliary record that logs: flags, exit_signal, cgroup,
and pidfd fields from struct clone_args. When CLONE_PIDFD is set and
the syscall succeeds, the resolved pidfd is logged; otherwise
pidfd=(null).

 ----
 type=SYSCALL : syscall=clone3 a0=0x7ffe7f1ec640 a1=0x58 a2=0x0 ...
 type=CLONE3 : cl3_flags=0x1000 exit_signal=17 cgroup=0 pidfd=3

Link: https://github.com/linux-audit/audit-kernel/issues/151
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/audit.h      | 10 ++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           | 20 ++++++++++++++++++++
 kernel/fork.c              |  4 +++-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..833f349bf415 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 			      enum audit_nfcfgop op, gfp_t gfp);
+extern void __audit_log_clone3(struct kernel_clone_args *kargs, int ret);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 		__audit_log_nfcfg(name, af, nentries, op, gfp);
 }
 
+static inline void audit_log_clone3(struct kernel_clone_args *kargs, int ret)
+{
+	if (!audit_dummy_context())
+		__audit_log_clone3(kargs, ret);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 				   enum audit_nfcfgop op, gfp_t gfp)
 { }
 
+static inline void audit_log_clone3(struct kernel_clone_args *kargs, int ret)
+{ }
+
 #define audit_n_rules 0
 #define audit_signals 0
 #endif /* CONFIG_AUDITSYSCALL */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..37357e17adbf 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -122,6 +122,7 @@
 #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
 #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
 #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
+#define AUDIT_CLONE3		1343	/* Record showing clone3 args */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..c0106bb71c19 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2882,6 +2882,26 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 }
 EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
 
+void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)
+{
+	struct audit_buffer *ab;
+	int pidfd;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_CLONE3);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "cl3_flags=0x%llx exit_signal=%d cgroup=%d",
+			 kargs->flags, kargs->exit_signal, kargs->cgroup);
+	if ((kargs->flags & CLONE_PIDFD) && ret >= 0 &&
+	    !get_user(pidfd, kargs->pidfd))
+		audit_log_format(ab, " pidfd=%d", pidfd);
+	else
+		audit_log_format(ab, " pidfd=(null)");
+	audit_log_end(ab);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a9a5..0f52e8c0e900 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3047,7 +3047,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 	if (!clone3_args_valid(&kargs))
 		return -EINVAL;
 
-	return kernel_clone(&kargs);
+	err = kernel_clone(&kargs);
+	audit_log_clone3(&kargs, err);
+	return err;
 }
 
 void walk_process_tree(struct task_struct *top, proc_visitor visitor, void *data)
-- 
2.53.0

