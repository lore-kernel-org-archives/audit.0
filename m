Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CE3B232A
	for <audit@vger.kernel.org>; Sat, 28 Feb 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303298; cv=none; b=K1mHl1R2pbo9aJ91dG6EYHAISU/FOqRvPyY/CjoAq6Ib+kDuXX4yhyFN/qYye74QFrciKlrO9jiyyC335a9RbaJJfxD4r7xBfaTFrJlH7/mjphx3GeUiqNVA4jGcQ+tEx/8usRC701lQlC3aDL12oDIzBq7ubMy/Wd3KyvpFsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303298; c=relaxed/simple;
	bh=JK0WuN2W9e9vtsZTDx1aUaSC3joEllv3YfQdmUK5FOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ITQZ156icrPCf6nvXBxKVeBnHQ4nVxgQ5150I0gIScbLM6lqx9qKenzadObmALvxin71fV/O8GIgvfm4JctSOlxe5DxhadkyKTCHxVVKB/VfqZrlUB1k72zMJv0ToZsckXncAMlLF94FZW0hl30RG0czWGaFhH759ccJxuqOKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7RhawUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7RhawUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772303295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdUUSuhz4rUHhjIdCOjmR2mCL+qfpF5oQsqY8Qu1sxc=;
	b=E7RhawUbHi6PZ0AFKR+zlQonkkAU4K6C+/fiUeKRoRY1B6pfn+dFyM4FmxLNmCoNlypKKC
	CKUiNIElqdxKN66mO275BM/rYuJ4xAjkuHqpIUVDA3paIrWusopktPDLvnoWvBG/2G1l+S
	s0bVUY7OKsbt7JrcaonsV9/8AntqSDw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-TMnmMC0uNmeNydVTSkWD-w-1; Sat,
 28 Feb 2026 13:28:11 -0500
X-MC-Unique: TMnmMC0uNmeNydVTSkWD-w-1
X-Mimecast-MFC-AGG-ID: TMnmMC0uNmeNydVTSkWD-w_1772303290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43C7B1956095;
	Sat, 28 Feb 2026 18:28:10 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 942CF1800351;
	Sat, 28 Feb 2026 18:28:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/2] fs: Add a pool of extra fs->pwd references to fs_struct
Date: Sat, 28 Feb 2026 13:27:56 -0500
Message-ID: <20260228182757.90528-2-longman@redhat.com>
In-Reply-To: <20260228182757.90528-1-longman@redhat.com>
References: <20260228182757.90528-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 97--RCwhg2VgQqG4mGc72Azh5NW06XnQn2lwI9Mw_aQ_1772303290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

A simple and elegant solution to avoid this kind of performance
regression is to add a common pool of extra fs->pwd references inside
the fs_struct. When a caller needs a pwd reference, it can borrow one
from pool, if available, to avoid an explicit path_get(). When it is
time to release the reference, it can put it back into the common pool
if fs->pwd isn't changed before without doing a path_put(). We still
need to acquire the fs's spinlock, but fs_struct is more distributed
and it is less common to have many tasks sharing a single fs_struct.

A new set of get_fs_pwd_pool/put_fs_pwd_pool() APIs are introduced
with this patch to enable other subsystems to acquire and release
a pwd reference from the common pool without doing unnecessary
path_get/path_put().

Besides fs/fs_struct.c, the copy_mnt_ns() function of fs/namespace.c is
also modified to properly handle the extra pwd references, if available.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/fs_struct.c            | 26 +++++++++++++++++++++-----
 fs/namespace.c            |  8 ++++++++
 include/linux/fs_struct.h | 28 +++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..43af98e0a10c 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -33,15 +33,19 @@ void set_fs_root(struct fs_struct *fs, const struct path *path)
 void set_fs_pwd(struct fs_struct *fs, const struct path *path)
 {
 	struct path old_pwd;
+	int count;
 
 	path_get(path);
 	write_seqlock(&fs->seq);
 	old_pwd = fs->pwd;
 	fs->pwd = *path;
+	count = fs->pwd_refs + 1;
+	fs->pwd_refs = 0;
 	write_sequnlock(&fs->seq);
 
 	if (old_pwd.dentry)
-		path_put(&old_pwd);
+		while (count--)
+			path_put(&old_pwd);
 }
 
 static inline int replace_path(struct path *p, const struct path *old, const struct path *new)
@@ -63,10 +67,15 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 		task_lock(p);
 		fs = p->fs;
 		if (fs) {
-			int hits = 0;
+			int hits;
+
 			write_seqlock(&fs->seq);
+			hits = replace_path(&fs->pwd, old_root, new_root);
+			if (hits && fs->pwd_refs) {
+				count += fs->pwd_refs;
+				fs->pwd_refs = 0;
+			}
 			hits += replace_path(&fs->root, old_root, new_root);
-			hits += replace_path(&fs->pwd, old_root, new_root);
 			while (hits--) {
 				count++;
 				path_get(new_root);
@@ -82,8 +91,11 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 void free_fs_struct(struct fs_struct *fs)
 {
+	int count = fs->pwd_refs + 1;
+
 	path_put(&fs->root);
-	path_put(&fs->pwd);
+	while (count--)
+		path_put(&fs->pwd);
 	kmem_cache_free(fs_cachep, fs);
 }
 
@@ -111,6 +123,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	if (fs) {
 		fs->users = 1;
 		fs->in_exec = 0;
+		fs->pwd_refs = 0;
 		seqlock_init(&fs->seq);
 		fs->umask = old->umask;
 
@@ -118,7 +131,10 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		fs->root = old->root;
 		path_get(&fs->root);
 		fs->pwd = old->pwd;
-		path_get(&fs->pwd);
+		if (old->pwd_refs)
+			old->pwd_refs--;
+		else
+			path_get(&fs->pwd);
 		read_sequnlock_excl(&old->seq);
 	}
 	return fs;
diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..96d41f00add6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4272,6 +4272,14 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	 * as belonging to new namespace.  We have already acquired a private
 	 * fs_struct, so tsk->fs->lock is not needed.
 	 */
+	if (new_fs)
+		WARN_ON_ONCE(new_fs->users != 1);
+
+	/* Release the extra pwd references of new_fs, if present. */
+	while (new_fs && new_fs->pwd_refs) {
+		path_put(&new_fs->pwd);
+		new_fs->pwd_refs--;
+	}
 	p = old;
 	q = new;
 	while (p) {
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..f8cf3b280398 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -8,10 +8,11 @@
 #include <linux/seqlock.h>
 
 struct fs_struct {
-	int users;
 	seqlock_t seq;
+	int users;
 	int umask;
 	int in_exec;
+	int pwd_refs;	/* A pool of extra pwd references */
 	struct path root, pwd;
 } __randomize_layout;
 
@@ -40,6 +41,31 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+/* Acquire a pwd reference from the pwd_refs pool, if available */
+static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
+{
+	read_seqlock_excl(&fs->seq);
+	*pwd = fs->pwd;
+	if (fs->pwd_refs)
+		fs->pwd_refs--;
+	else
+		path_get(pwd);
+	read_sequnlock_excl(&fs->seq);
+}
+
+/* Release a pwd reference back to the pwd_refs pool, if appropriate */
+static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
+{
+	read_seqlock_excl(&fs->seq);
+	if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt)) {
+		fs->pwd_refs++;
+		pwd = NULL;
+	}
+	read_sequnlock_excl(&fs->seq);
+	if (pwd)
+		path_put(pwd);
+}
+
 extern bool current_chrooted(void);
 
 static inline int current_umask(void)
-- 
2.53.0

