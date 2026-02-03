Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F628750C
	for <audit@vger.kernel.org>; Tue,  3 Feb 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147887; cv=none; b=Rcp6Vs6d/XGAGOWKeSPFlNJAxcVaxRsoqLWapFF3QOaTJUGeQ1SfsNcFHZ8xy3Krjjjn5andSOD/We9u9IC7tPWSQQGPAaCHAreCe+rU1FB5psgqQSgrD0ozdOheaM0qn7OXulsHZmXZ/lubDUmqnb0uIipElKrvd14Ajcb+7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147887; c=relaxed/simple;
	bh=tZ28kcNd3CWIYNARgvxeIvdBE7Jb3hFrkE9h1EX8+yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSoCo4p3We50JCxfM7ymLnNkm/oLACThO1Sw5EqdJjOGQWMr8T6BLuJ1rwL9hza19+8lPVMsCbiucKGYE+o3C8tZlZpObYuJTaPihzkQerQr/2lbQk6XSk89Ca1LCCaYM9LivrU31GhXFXGpterXWBOOTYqKiSmiJAjhcveRnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZQs9F/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZQs9F/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770147885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yfzzs+1dbo1+eEbCWDiVIGjOqU63Vf6bm27r39E62mA=;
	b=HZQs9F/tIVvxXwvGf7+B/+UQSme8GAtV9sU3Jw4LePgvsJlIj6Rr5iy6iV6lwnUNmF82U0
	jqfibbF319l6fL74bGNNnpLLwXmJnH7fV5v+Vrp5DW7nX1fq3nRWOX4TaZTrYMt7dq+OIz
	1YqPtwEwbulsoDbtrSYjzVC9dTlN2hc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-pF134hgBPJ-M83QHR3jU2A-1; Tue,
 03 Feb 2026 14:44:41 -0500
X-MC-Unique: pF134hgBPJ-M83QHR3jU2A-1
X-Mimecast-MFC-AGG-ID: pF134hgBPJ-M83QHR3jU2A_1770147880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F81180034F;
	Tue,  3 Feb 2026 19:44:40 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.151])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E37519560B4;
	Tue,  3 Feb 2026 19:44:38 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] audit: Avoid excessive dput/dget in audit_context setup and reset paths
Date: Tue,  3 Feb 2026 14:44:33 -0500
Message-ID: <20260203194433.1738162-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

It is found that on large SMP systems with a large number of CPUs and
auditing enabled, workloads that generate a massive amount of syscalls
(like open/close) in parallel on the same working directory can cause
significant spinlock contention of the lockref.lock of the working
directory's dentry.

One possible way to reduce such spinlock contention scenario is to
keep the pwd references in audit_free_names() and reuse it in the next
audit_alloc_name() call if there is no change in working directory.

A new pwd_reset field is added to audit_context to indicate, if set,
that the pwd has been reset but still hold mount and dentry references.
A new fs_pwd_equal() helper is added to fs_struct.h to check if the
fs->pwd has been changed. When audit_alloc_name() is called with the
context->pwd still valid and the fs->pwd hasn't been changed, it can
return without calling get_fs_pwd().

By adding test code to count the number of effective audit_free_names()
and audit_alloc_name() calls and the number of relevant path_put() and
path_get() calls after rebooting a patched kernel with auditing enabled
on a 2-socket 96-CPU system, there were about 30k path_get()/path_put()
out of a total of about 1 million audit_free_names()/audit_alloc_name()
calls. It is about 3% of those before the patch for this particular case.

After resetting the counters and running a parallel kernel build,
the new figures were about 202k path_get()/path_put() out of about 56M
audit_free_names()/audit_alloc_name(). That is about 0.4%.

As auditing is increasingly used in production systems due to various
legal and commercial compliance requirements, it is important that we
should try to minimize performance overhead when auditing is enabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---

 [v2] Merge 2 patches together & defer the path_put() call in
      audit_alloc_name() to workqueue to prevent might_sleep() in atomic
      context problem.

 include/linux/fs_struct.h | 11 ++++++++
 kernel/audit.h            |  7 +++++
 kernel/auditsc.c          | 56 +++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..3a3dda8adc11 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -40,6 +40,17 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+/* Return true if fs->pwd matches the given pwd */
+static inline bool fs_pwd_equal(struct fs_struct *fs, struct path *pwd)
+{
+	bool match;
+
+	read_seqlock_excl(&fs->seq);
+	match = (fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt);
+	read_sequnlock_excl(&fs->seq);
+	return match;
+}
+
 extern bool current_chrooted(void);
 
 static inline int current_umask(void)
diff --git a/kernel/audit.h b/kernel/audit.h
index 7c401729e21b..03f3539b10e7 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -133,6 +133,13 @@ struct audit_context {
 	int		    name_count; /* total records in names_list */
 	struct list_head    names_list;	/* struct audit_names->list anchor */
 	char		    *filterkey;	/* key for rule that triggered record */
+	/*
+	 * pwd_reset is set if audit_free_names() has been called from
+	 * audit_reset_context() to reset pwd, but pwd is still holding dentry
+	 * and mount references to be used in later audit action without
+	 * the need to reacqure the references again.
+	 */
+	int		    pwd_reset;
 	struct path	    pwd;
 	struct audit_aux_data *aux;
 	struct audit_aux_data *aux_pids;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dd0563a8e0be..e2e8bdb06185 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -123,6 +123,11 @@ struct audit_nfcfgop_tab {
 	const char		*s;
 };
 
+struct audit_pwd_put {
+	struct work_struct	work;
+	struct path		pwd;
+};
+
 static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 	{ AUDIT_XT_OP_REGISTER,			"xt_register"		   },
 	{ AUDIT_XT_OP_REPLACE,			"xt_replace"		   },
@@ -931,6 +936,9 @@ static inline void audit_free_names(struct audit_context *context)
 {
 	struct audit_names *n, *next;
 
+	if (list_empty(&context->names_list))
+		return;	/* audit_alloc_name() has not been called */
+
 	list_for_each_entry_safe(n, next, &context->names_list, list) {
 		list_del(&n->list);
 		if (n->name)
@@ -939,9 +947,7 @@ static inline void audit_free_names(struct audit_context *context)
 			kfree(n);
 	}
 	context->name_count = 0;
-	path_put(&context->pwd);
-	context->pwd.dentry = NULL;
-	context->pwd.mnt = NULL;
+	context->pwd_reset = true;
 }
 
 static inline void audit_free_aux(struct audit_context *context)
@@ -1088,6 +1094,8 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_reset_context(context);
 	audit_proctitle_free(context);
 	free_tree_refs(context);
+	if (context->pwd_reset)
+		path_put(&context->pwd);
 	kfree(context->filterkey);
 	kfree(context);
 }
@@ -1519,7 +1527,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 			/* name was specified as a relative path and the
 			 * directory component is the cwd
 			 */
-			if (context->pwd.dentry && context->pwd.mnt)
+			if (context->pwd.dentry && context->pwd.mnt &&
+			    !context->pwd_reset)
 				audit_log_d_path(ab, " name=", &context->pwd);
 			else
 				audit_log_format(ab, " name=(null)");
@@ -1767,7 +1776,7 @@ static void audit_log_exit(void)
 				  context->target_comm))
 		call_panic = 1;
 
-	if (context->pwd.dentry && context->pwd.mnt) {
+	if (context->pwd.dentry && context->pwd.mnt && !context->pwd_reset) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
 		if (ab) {
 			audit_log_d_path(ab, "cwd=", &context->pwd);
@@ -2144,6 +2153,19 @@ static void handle_path(const struct dentry *dentry)
 	rcu_read_unlock();
 }
 
+static void audit_pwd_put_workfn(struct work_struct *work)
+{
+	struct audit_pwd_put *pp = container_of(work, struct audit_pwd_put, work);
+
+	path_put(&pp->pwd);
+	/*
+	 * The audit_pwd_put structure can be safely freed here without UAF
+	 * as all the workqueue related data have been copied out and processed
+	 * before this function is called.
+	 */
+	kfree(pp);
+}
+
 static struct audit_names *audit_alloc_name(struct audit_context *context,
 						unsigned char type)
 {
@@ -2164,6 +2186,30 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
 	list_add_tail(&aname->list, &context->names_list);
 
 	context->name_count++;
+	if (context->pwd_reset) {
+		struct audit_pwd_put *pp;
+
+		context->pwd_reset = false;
+		if (likely(fs_pwd_equal(current->fs, &context->pwd)))
+			return aname;
+
+		/*
+		 * Defer the path_put() call of the old pwd to workqueue as
+		 * we may be in an atomic context that cannot call path_put()
+		 * directly because of might_sleep().
+		 */
+		pp = kmalloc(sizeof(*pp), GFP_NOFS);
+		if (!pp) {
+			if (aname->should_free)
+				kfree(aname);
+			return NULL;
+		}
+		INIT_WORK(&pp->work, audit_pwd_put_workfn);
+		pp->pwd = context->pwd;
+		schedule_work(&pp->work);
+		context->pwd.dentry = NULL;
+		context->pwd.mnt = NULL;
+	}
 	if (!context->pwd.dentry)
 		get_fs_pwd(current->fs, &context->pwd);
 	return aname;
-- 
2.52.0

