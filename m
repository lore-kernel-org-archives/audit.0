Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B5283C93
	for <audit@vger.kernel.org>; Wed, 21 Jan 2026 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962947; cv=none; b=jD7QiXujhHeuXIjkKCrWVgzFSsN49nUDFvCeCUEAzSg2tFSa/dy0wJSWsnD8JYZ1HZE8t4h912hbQ9gm/HbmOQ/fs6zedo9Ap77FRBJByh2f37l5eH0Q5NNKUEJRAm+K22RslnuXyPCmZ6k7UNZ4AyHNs7TNDkYgsfaBLHdh5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962947; c=relaxed/simple;
	bh=5xGOAArs75FvY/ZNW3LzRkTwqr0HM7pe2D1wj2GqmpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgArGi/96MA9BJO9b72wj+bt+2GVtVOq4Zzxc5/sstWAqEvoy28nJvtTMHmMB2bMCg0RWPO9lY2k+/zSK7DMgSTE8rcSqbs42H0IoMggI/F5KnuxRrScQS7X8vIQTYOHOdaa7ygj3ZPbwnIJ5/9qJ40jEWGTd5MYnrjSzl+Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCGVs4MQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCGVs4MQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768962944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX4CoZ1xAbX7uNYE4d/bcN7YE1X4zCkyo4pqXPwKols=;
	b=YCGVs4MQg/4O6JQms37BIL/Fh9QG0P7/V9Ji2TZKM6lb+QxSetNwh3Dl7dtrnXIEEdzzLK
	fr422lVqmlKfV+bX65LYuBfLZ3VfmJxe//T4ttpaM8Z34gOUbfFcJDufM6ktdeEQuL9uJ9
	dQExohdsYhym+X/386mWCJm1f+D69x8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-_lB-VEE7MkqYyTU3HYS_VQ-1; Tue,
 20 Jan 2026 21:35:39 -0500
X-MC-Unique: _lB-VEE7MkqYyTU3HYS_VQ-1
X-Mimecast-MFC-AGG-ID: _lB-VEE7MkqYyTU3HYS_VQ_1768962938
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9827D1956048;
	Wed, 21 Jan 2026 02:35:38 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.122])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0893618001D5;
	Wed, 21 Jan 2026 02:35:36 +0000 (UTC)
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
Subject: [PATCH 2/2] audit: Call path_{put,get}() in audit_alloc_name()/audit_free_names() only when necessary
Date: Tue, 20 Jan 2026 21:35:09 -0500
Message-ID: <20260121023509.410423-2-longman@redhat.com>
In-Reply-To: <20260121023509.410423-1-longman@redhat.com>
References: <20260121023509.410423-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Another get_cond_fs_pwd() helper is added to fs_struct.h to conditionally
put the old references back and get the new ones if fs->pwd has been
changed.

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
 include/linux/fs_struct.h | 14 ++++++++++++++
 kernel/audit.h            |  7 +++++++
 kernel/auditsc.c          | 17 +++++++++++------
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..f173b49ad47e 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -40,6 +40,20 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+/*
+ * Conditionally get the current fs->pwd if it differs from the given pwd
+ */
+static inline void get_cond_fs_pwd(struct fs_struct *fs, struct path *pwd)
+{
+	read_seqlock_excl(&fs->seq);
+	if ((fs->pwd.dentry != pwd->dentry) || (fs->pwd.mnt != pwd->mnt)) {
+		path_put(pwd);
+		*pwd = fs->pwd;
+		path_get(pwd);
+	}
+	read_sequnlock_excl(&fs->seq);
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
index 824b6fd98561..30d931d9b9a4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -942,9 +942,7 @@ static inline void audit_free_names(struct audit_context *context)
 			kfree(n);
 	}
 	context->name_count = 0;
-	path_put(&context->pwd);
-	context->pwd.dentry = NULL;
-	context->pwd.mnt = NULL;
+	context->pwd_reset = true;
 }
 
 static inline void audit_free_aux(struct audit_context *context)
@@ -1091,6 +1089,8 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_reset_context(context);
 	audit_proctitle_free(context);
 	free_tree_refs(context);
+	if (context->pwd_reset)
+		path_put(&context->pwd);
 	kfree(context->filterkey);
 	kfree(context);
 }
@@ -1522,7 +1522,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 			/* name was specified as a relative path and the
 			 * directory component is the cwd
 			 */
-			if (context->pwd.dentry && context->pwd.mnt)
+			if (context->pwd.dentry && context->pwd.mnt &&
+			    !context->pwd_reset)
 				audit_log_d_path(ab, " name=", &context->pwd);
 			else
 				audit_log_format(ab, " name=(null)");
@@ -1770,7 +1771,7 @@ static void audit_log_exit(void)
 				  context->target_comm))
 		call_panic = 1;
 
-	if (context->pwd.dentry && context->pwd.mnt) {
+	if (context->pwd.dentry && context->pwd.mnt && !context->pwd_reset) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
 		if (ab) {
 			audit_log_d_path(ab, "cwd=", &context->pwd);
@@ -2167,8 +2168,12 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
 	list_add_tail(&aname->list, &context->names_list);
 
 	context->name_count++;
-	if (!context->pwd.dentry)
+	if (context->pwd_reset) {
+		get_cond_fs_pwd(current->fs, &context->pwd);
+		context->pwd_reset = false;
+	} else if (!context->pwd.dentry) {
 		get_fs_pwd(current->fs, &context->pwd);
+	}
 	return aname;
 }
 
-- 
2.52.0

