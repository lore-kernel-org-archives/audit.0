Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF7280CFB
	for <audit@vger.kernel.org>; Tue, 14 Apr 2026 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196881; cv=none; b=USyrBa7TdIkmfXuGXd+ibSi/SyoTfpz8Q+llxH8ziVaqnjCfKYre+xU3s2EGdx/fSiWYXfFuRmcW4QKw0ngzHg0FjAqOY8G+ePlxPReB9gD3vAWLTO4C6MxfV3cZPWjGpEnZ3os+TIVrAm7rL+nQDDEnAsEJqinZrRmArer5+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196881; c=relaxed/simple;
	bh=tHwRROQJQv1SCwR1rkpjgSgWGfFe+84ZjOk3J0EZw6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BrxQYiz2Nw/sPocfzc4wa8yV4CX+O1Wd2mfXOH2EM5faSbcIW8PJCu4spu6R3I7aiTOr9rPeNEPY+PMfziZanafDiHSn/yTJ9xZkg+voLo3FOk6edmQRWP8Cg1dVP48FimK/1uLMBPp7o+T+sWsmDS+t+MEZpsZLOWY2df1lZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUMJ+lhD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUMJ+lhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776196879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ukOX5TmhseEpBnEt/b/d0Xbtf74mf5QAAlUpO5/5/s=;
	b=ZUMJ+lhDnSpxHcS8+/9zV+HtVy34bcuQVO1EI87Eg5rxL5au1Qh6HVSvF6sdL+fyeLWWsM
	KAo6RuKKyk6Pav50KRZ7kKKiWG0VWKKl8kfFyZ5SYx1aGmxm8dvT6Ie2wADfG4NIAOXBkr
	qt4hkNrqTg3saXRtpTU+nSOvl1053pg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-rbFKOfIzPPuWx2Ru5zRpYg-1; Tue,
 14 Apr 2026 16:01:14 -0400
X-MC-Unique: rbFKOfIzPPuWx2Ru5zRpYg-1
X-Mimecast-MFC-AGG-ID: rbFKOfIzPPuWx2Ru5zRpYg_1776196873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE40C1953958;
	Tue, 14 Apr 2026 20:01:09 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A372180058F;
	Tue, 14 Apr 2026 20:01:06 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	longman@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 1/2] audit: fix recursive locking deadlock in audit_dupe_exe()
Date: Tue, 14 Apr 2026 17:00:47 -0300
Message-ID: <7d47fb8371df34617c7ce3dd7550d03e1a962017.1776176104.git.rrobaina@redhat.com>
In-Reply-To: <cover.1776176104.git.rrobaina@redhat.com>
References: <cover.1776176104.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jgdm6Bpc2AQbIvWTCrA5rfvHLO2HzKukj3bzzay6Zro_1776196873
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A deadlock occurs in the audit subsystem when duplicating
executable-related rules.

When a file is moved (e.g., via do_renameat2()), the VFS layer locks
the parent directory (I_MUTEX_PARENT), which synchronously triggers an
fsnotify_move event. If an existing executable audit rule matches the
file being moved, the audit subsystem catches this event and calls
audit_dupe_exe() to duplicate the watch and update the rule. Then,
audit_alloc_mark() would call kern_path_parent() to resolve the path,
leading to a blind attempt to acquire the exact same I_MUTEX_PARENT lock
already held by the task, resulting in the following recursive locking
deadlock:

 [   60.521149] ============================================
 [   60.521164] WARNING: possible recursive locking detected
 [   60.521180] 6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
 [   60.521197] --------------------------------------------
 [   60.521211] mv/5099 is trying to acquire lock:
 [   60.521225] ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
 at: __kern_path_locked+0x10a/0x2f0
 [   60.521263]
                but task is already holding lock:
 [   60.521280] ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
 at: lock_two_directories+0x13f/0x2b0
 [   60.521313]
                other info that might help us debug this:
 [   60.521331]  Possible unsafe locking scenario:

 [   60.521349]        CPU0
 [   60.521357]        ----
 [   60.521365]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
 [   60.521384]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
 [   60.521401]
                 *** DEADLOCK ***

 [   60.521422]  May be due to missing lock nesting notation

 [   60.521445] 6 locks held by mv/5099:
 [   60.521458]  #0: ffff888112a9c440 (sb_writers#13){++++}-{0:0}, at: do_renameat2+0x34c/0xbc0
 [   60.521491]  #1: ffff888112a9c790 (&type->s_vfs_rename_key#3){+.+.}-{3:3}, at: do_renameat2+0x415/0xbc0
 [   60.521525]  #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
 at: lock_two_directories+0x13f/0x2b0
 [   60.521565]  #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/5){+.+.}-{3:3},
 at: lock_two_directories+0x175/0x2b0
 [   60.521604]  #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu){.+.+}-{0:0}, at: fsnotify+0x454/0x28a0
 [   60.521636]  #5: ffffffffaf886230 (audit_filter_mutex){+.+.}-{3:3}, at: audit_update_watch+0x36/0x11e0
 [   60.521670]
                stack backtrace:
 [   60.521687] CPU: 0 UID: 0 PID: 5099 Comm: mv Kdump: loaded Not tainted 6.12.0-55.27.1.el10_0.x86_64+debug #1
 [   60.521718] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
 [   60.521743] Call Trace:
 [   60.521754]  <TASK>
 [   60.521764]  dump_stack_lvl+0x6f/0xb0
 [   60.521781]  print_deadlock_bug.cold+0xbd/0xca
 [   60.521798]  validate_chain+0x83a/0xf00
 [   60.522465]  __lock_acquire+0xcac/0x1d20
 [   60.524073]  lock_acquire.part.0+0x11b/0x360
 [   60.528512]  down_write_nested+0x9f/0x230
 [   60.530038]  __kern_path_locked+0x10a/0x2f0
 [   60.532561]  kern_path_locked+0x26/0x40
 [   60.533018]  audit_alloc_mark+0xfb/0x4f0
 [   60.535295]  audit_dupe_exe+0x6c/0xe0
 [   60.536307]  audit_dupe_rule+0x6c2/0xc00
 [   60.537290]  audit_update_watch+0x4cc/0x11e0
 [   60.537759]  audit_watch_handle_event+0x12c/0x1b0
 [   60.538227]  send_to_group+0x5d0/0x8b0
 [   60.538683]  fsnotify+0x615/0x28a0
 [   60.540007]  fsnotify_move+0x1d8/0x630
 [   60.540438]  vfs_rename+0xdcd/0x1df0
 [   60.542176]  do_renameat2+0x9d4/0xbc0
 [   60.544870]  __x64_sys_renameat+0x192/0x260
 [   60.545299]  do_syscall_64+0x92/0x180
 [   60.554189]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 [   60.554562] RIP: 0033:0x7f0491fe8c4e
 [   60.554947] Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b8 ff ff ff ff
 c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48> 3d 00 f0 ff ff
 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
 [   60.555789] RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
 [   60.556237] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0491fe8c4e
 [   60.556683] RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 00000000ffffff9c
 [   60.557166] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
 [   60.557618] R10: 00005575eb2dae2a R11: 0000000000000246 R12: 00005575eb2dae2a
 [   60.558080] R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 00000000ffffff9c
 [   60.558518]  </TASK>

The aforementioned deadlock can be consistently reproduced by running
the script below:

 audit-dupe-exe-deadlock.sh
 --------------------------
 #!/bin/bash
 auditctl -D
 mkdir -p /tmp/foo
 touch /tmp/file
 auditctl -a always,exit -F exe=/tmp/file -F path=/tmp/file -S all -k dr
 mv /tmp/file /tmp/foo/file
 rm -Rf /tmp/foo

This patch fixes the issue by introducing struct audit_watch_ctx to pass
the fsnotify event context down to audit_alloc_mark(). By utilizing the
already-resolved directory inode provided by the event, we bypass the
kern_path_parent() path resolution entirely, safely avoiding the
recursive lock. Furthermore, it explicitly allows duplicate fsnotify
marks (allow_dups = 1) during the rename update, allowing the new rule's
mark to safely coexist with the old rule's mark until the old rule is
freed.

ps.: this issue was identified and reproduced during a comprehensive
code coverage analysis of the audit subsystem. The full report is
available at the link below.

Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Link: https://people.redhat.com/rrobaina/audit-code-coverage-analysis.pdf
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.h          | 13 ++++++++++---
 kernel/audit_fsnotify.c | 33 ++++++++++++++++++++++-----------
 kernel/audit_watch.c    | 25 +++++++++++++++++--------
 kernel/auditfilter.c    |  9 +++++----
 4 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index ac81fa02bcd7..2f988f6257d2 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -256,8 +256,13 @@ extern int audit_del_rule(struct audit_entry *entry);
 extern void audit_free_rule_rcu(struct rcu_head *head);
 extern struct list_head audit_filter_list[];
 
-extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
+struct audit_watch_ctx {
+	struct inode *dir;
+	struct inode *child;
+};
 
+extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+					   struct audit_watch_ctx *ctx);
 extern void audit_log_d_path_exe(struct audit_buffer *ab,
 				 struct mm_struct *mm);
 
@@ -280,13 +285,15 @@ extern char *audit_watch_path(struct audit_watch *watch);
 extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
-						    char *pathname, int len);
+						    char *pathname, int len,
+						    struct audit_watch_ctx *ctx);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
 extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
 			      dev_t dev);
-extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
+extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+			  struct audit_watch_ctx *ctx);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
 
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 711454f9f724..eee589bca86e 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -71,7 +71,8 @@ static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
-struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len)
+struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname,
+					     int len, struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
@@ -81,12 +82,14 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_parent(pathname, &path);
-	if (IS_ERR(dentry))
-		return ERR_CAST(dentry); /* returning an error */
-	if (d_really_is_negative(dentry)) {
-		audit_mark = ERR_PTR(-ENOENT);
-		goto out;
+	if (!ctx) {
+		dentry = kern_path_parent(pathname, &path);
+		if (IS_ERR(dentry))
+			return ERR_CAST(dentry); /* returning an error */
+		if (d_really_is_negative(dentry)) {
+			audit_mark = ERR_PTR(-ENOENT);
+			goto out;
+		}
 	}
 
 	audit_mark = kzalloc_obj(*audit_mark);
@@ -98,18 +101,26 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
 	audit_mark->mark.mask = AUDIT_FS_EVENTS;
 	audit_mark->path = pathname;
-	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
+	if (ctx) {
+		audit_update_mark(audit_mark, ctx->child);
+		ret = fsnotify_add_inode_mark(&audit_mark->mark, ctx->dir, 1);
+	} else {
+		audit_update_mark(audit_mark, dentry->d_inode);
+		ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
+	}
+
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
-	path_put(&path);
+	if (!ctx) {
+		dput(dentry);
+		path_put(&path);
+	}
 	return audit_mark;
 }
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 33577f0f54ef..2c72e13be42c 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -244,7 +244,8 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       u64 ino, unsigned invalidating)
+			       unsigned long ino, unsigned invalidating,
+			       struct audit_watch_ctx *ctx)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -280,7 +281,7 @@ static void audit_update_watch(struct audit_parent *parent,
 			list_del(&oentry->rule.rlist);
 			list_del_rcu(&oentry->list);
 
-			nentry = audit_dupe_rule(&oentry->rule);
+			nentry = audit_dupe_rule(&oentry->rule, ctx);
 			if (IS_ERR(nentry)) {
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
@@ -479,10 +480,17 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
 		return 0;
 
-	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
-	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+	if (mask & (FS_CREATE|FS_MOVED_TO) && inode) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = inode };
+
+		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0,
+				   &ctx);
+	} else if (mask & (FS_DELETE|FS_MOVED_FROM)) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = NULL };
+
+		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1,
+				   &ctx);
+	}
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
@@ -505,7 +513,8 @@ static int __init audit_watch_init(void)
 }
 device_initcall(audit_watch_init);
 
-int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
+int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+		   struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	char *pathname;
@@ -514,7 +523,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 	if (!pathname)
 		return -ENOMEM;
 
-	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname));
+	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname), ctx);
 	if (IS_ERR(audit_mark)) {
 		kfree(pathname);
 		return PTR_ERR(audit_mark);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 093425123f6c..587b46771fb9 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -589,7 +589,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				err = PTR_ERR(str);
 				goto exit_free;
 			}
-			audit_mark = audit_alloc_mark(&entry->rule, str, f_val);
+			audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
 			if (IS_ERR(audit_mark)) {
 				kfree(str);
 				err = PTR_ERR(audit_mark);
@@ -816,7 +816,8 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
  * rule with the new rule in the filterlist, then free the old rule.
  * The rlist element is undefined; list manipulations are handled apart from
  * the initial copy. */
-struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+				    struct audit_watch_ctx *ctx)
 {
 	u32 fcount = old->field_count;
 	struct audit_entry *entry;
@@ -875,7 +876,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 				new->filterkey = fk;
 			break;
 		case AUDIT_EXE:
-			err = audit_dupe_exe(new, old);
+			err = audit_dupe_exe(new, old, ctx);
 			break;
 		}
 		if (err) {
@@ -1414,7 +1415,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	if (!security_audit_rule_known(r))
 		return 0;
 
-	nentry = audit_dupe_rule(r);
+	nentry = audit_dupe_rule(r, NULL);
 	if (entry->rule.exe)
 		audit_remove_mark(entry->rule.exe);
 	if (IS_ERR(nentry)) {
-- 
2.53.0

