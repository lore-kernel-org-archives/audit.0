Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4E37F742
	for <audit@vger.kernel.org>; Tue, 12 May 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613158; cv=none; b=EWbvgGNx7OdqaUL8i7UnuVplYCsKyVKOWmid/DYflmUTvqeWE8vFujuLfVO9k/up0cyTEE/osQK4q1meAhi/x3I2+8LXI9DSus5BuioX7yHHp0/2jjxb6kyzTrTU3VyUQJ3LLqdOY9YB6DSzS27AfLptKCvONt/gN+jQcYI5QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613158; c=relaxed/simple;
	bh=2KP4NetvRe83b/2i1D9XeKNkefLpLu2iLyAMgl1GTeM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=vCNsPYeKfPRpNzDzXunCCI6ZBcWJFCzN1p1jsTrerJuX/SSQDV3l39yqdsCP67ePSuHmGm+4hOOSxf0U4N4Py/OgW07MsYJjfJ79rjCW/Zxoh7mgm7GkyiP/k2kPevBccXpG++Dfji0XJzc/ZDeU4i4W/BGyGg35SRGau9UA710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d5QDEoK3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d5QDEoK3"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b701756684so64333266d6.1
        for <audit@vger.kernel.org>; Tue, 12 May 2026 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778613154; x=1779217954; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6tkJINc+jUBp+8ATJmT4ular1Svy1kosOCHbSk/i0A=;
        b=d5QDEoK3iQoaTznudoUNl3lspCkjuYU2RQyVB3scBkGRIh7EjOke2GY1g+nSstXNXs
         EYc4upZti+Rc9EJlhEFbKCz+MeG7tc5383c1TC1cQm1LTnlPejtAXxFJU8POVyT5sSsR
         Kh1OOYkH1JdgfW4nngey14BfyQPZ1CrsFP2fWQPddMtr9n8agfvf1QfDfEiKM21rpp4Q
         tiSLYE5Y4Fg6gbnhI4oPLGthmHyDFbIvuHPth4dpgh2ogDdOrffSzrEmny488Y2TtiDb
         I8gb/USgN6nIJ2xXIFiXPII3LW1l1p4bEr3bagemEyWY14Vb1cRaszOyWJ6QBZiGnxQN
         ubdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613154; x=1779217954;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6tkJINc+jUBp+8ATJmT4ular1Svy1kosOCHbSk/i0A=;
        b=bs8L7im9QnwU2Y3lhSJVXFhydhWdTXxUV7t0AZT7q3hrEqbPkmabsUt986rxv6+7BJ
         te+pf5r0rp8JW/3Ys7i7tIOuuPDUiPRdroG3AR9tWAq1DlOMVBBUkgDtRwDAhpFCgBUS
         dSH+K048rld/GE9cBRoTbD2xXn0w2gK36Jq/x4WngYC2Yki/aODMo0C6LX40DlQ5hW0p
         0pE5S4NwgVZkIu466wAiT2xfi8B4q9zzr5HtcmoYHgYQP2PsbQdfAQoWr0P6w+87WJiz
         YvxBQOkrmTpllLhkW7Rphnjpp0sbvZEdYOUoSmQKfNYM5bA86lbl9Iq7F7/NdtZdpw57
         yFVQ==
X-Forwarded-Encrypted: i=1; AFNElJ82Wtp7mbu+R64Hvn0h/buxWXm01O5XX2rp0N3ccchc4gNCzIjCpxOjnDRGYCUElxkNIYXb0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYk7/jhvq4d2zvgsEFCroJu9/oDZM2o5019TmEuI6hGpYCVRv
	FvjVjafZsSZRkcUobuyj3hxXBehozU94BTvTDJoux/5lBqQ4XeZzq0moemyC042nUA==
X-Gm-Gg: Acq92OF9NRyCy7ONE2kw7F4iTzw+KUvvvXKAb9yD8TTLL92LJ9VTzBsFrjYSzqO38vt
	CZFZHgxEusvkrLkjAvJLPxBcaqB/8+UtKQYW/A3fNEUdUQn7CI3bCWD5/WVlnRYVEZgA4GRwiV/
	J6WgNK801Y0KQWcs0Y8GPPiXAx/yrKcpMC6pw6G0kAgGum5dDkY6sk2fEt1inkTIHQt81TDeSJK
	fpCiUm3gp+B1PTayOTAKjhGqVbLsBWiLezkV3h5KgSfbgGpLcUnbMWrtFfGCqMYEs3YSeFQU7AP
	X2g8+nZOX8r7GoHb8tim8qLF6b7U/sDBgx30QefKyawxWK8Vkp9saAQU2X6h4fPxVlh9ORQTdjC
	YTRxl8Qrxl+zZ+TCBpM2RBXs/ud4YOTxGvsWgbS18qHGLva/4f/Rz/2idrvsa2pcV1iPboQRVIh
	XI5YzxvxlXfPlvnLYlbSZEoESsd6REOtl7LYaBvgnA0j7ro/4iCU//iPHU5m/pCoPvu6nkbMclt
	4QChjo=
X-Received: by 2002:a05:6214:1c88:b0:8a7:164c:d5c8 with SMTP id 6a1803df08f44-8c7b29a5ee8mr4687796d6.24.1778613153987;
        Tue, 12 May 2026 12:12:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a906e65sm131745886d6.16.2026.05.12.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:12:33 -0700 (PDT)
Date: Tue, 12 May 2026 15:12:32 -0400
Message-ID: <8fc7c79a550a8088cbc8c066c0f5f449@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260512_1209/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, longman@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 1/2] audit: fix recursive locking deadlock in  audit_dupe_exe()
References: <7d47fb8371df34617c7ce3dd7550d03e1a962017.1776176104.git.rrobaina@redhat.com>
In-Reply-To: <7d47fb8371df34617c7ce3dd7550d03e1a962017.1776176104.git.rrobaina@redhat.com>

On Apr 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> A deadlock occurs in the audit subsystem when duplicating
> executable-related rules.
> 
> When a file is moved (e.g., via do_renameat2()), the VFS layer locks
> the parent directory (I_MUTEX_PARENT), which synchronously triggers an
> fsnotify_move event. If an existing executable audit rule matches the
> file being moved, the audit subsystem catches this event and calls
> audit_dupe_exe() to duplicate the watch and update the rule. Then,
> audit_alloc_mark() would call kern_path_parent() to resolve the path,
> leading to a blind attempt to acquire the exact same I_MUTEX_PARENT lock
> already held by the task, resulting in the following recursive locking
> deadlock:
> 
>  [   60.521149] ============================================
>  [   60.521164] WARNING: possible recursive locking detected
>  [   60.521180] 6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
>  [   60.521197] --------------------------------------------
>  [   60.521211] mv/5099 is trying to acquire lock:
>  [   60.521225] ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
>  at: __kern_path_locked+0x10a/0x2f0
>  [   60.521263]
>                 but task is already holding lock:
>  [   60.521280] ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
>  at: lock_two_directories+0x13f/0x2b0
>  [   60.521313]
>                 other info that might help us debug this:
>  [   60.521331]  Possible unsafe locking scenario:
> 
>  [   60.521349]        CPU0
>  [   60.521357]        ----
>  [   60.521365]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
>  [   60.521384]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
>  [   60.521401]
>                  *** DEADLOCK ***
> 
>  [   60.521422]  May be due to missing lock nesting notation
> 
>  [   60.521445] 6 locks held by mv/5099:
>  [   60.521458]  #0: ffff888112a9c440 (sb_writers#13){++++}-{0:0}, at: do_renameat2+0x34c/0xbc0
>  [   60.521491]  #1: ffff888112a9c790 (&type->s_vfs_rename_key#3){+.+.}-{3:3}, at: do_renameat2+0x415/0xbc0
>  [   60.521525]  #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
>  at: lock_two_directories+0x13f/0x2b0
>  [   60.521565]  #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/5){+.+.}-{3:3},
>  at: lock_two_directories+0x175/0x2b0
>  [   60.521604]  #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu){.+.+}-{0:0}, at: fsnotify+0x454/0x28a0
>  [   60.521636]  #5: ffffffffaf886230 (audit_filter_mutex){+.+.}-{3:3}, at: audit_update_watch+0x36/0x11e0
>  [   60.521670]
>                 stack backtrace:
>  [   60.521687] CPU: 0 UID: 0 PID: 5099 Comm: mv Kdump: loaded Not tainted 6.12.0-55.27.1.el10_0.x86_64+debug #1
>  [   60.521718] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>  [   60.521743] Call Trace:
>  [   60.521754]  <TASK>
>  [   60.521764]  dump_stack_lvl+0x6f/0xb0
>  [   60.521781]  print_deadlock_bug.cold+0xbd/0xca
>  [   60.521798]  validate_chain+0x83a/0xf00
>  [   60.522465]  __lock_acquire+0xcac/0x1d20
>  [   60.524073]  lock_acquire.part.0+0x11b/0x360
>  [   60.528512]  down_write_nested+0x9f/0x230
>  [   60.530038]  __kern_path_locked+0x10a/0x2f0
>  [   60.532561]  kern_path_locked+0x26/0x40
>  [   60.533018]  audit_alloc_mark+0xfb/0x4f0
>  [   60.535295]  audit_dupe_exe+0x6c/0xe0
>  [   60.536307]  audit_dupe_rule+0x6c2/0xc00
>  [   60.537290]  audit_update_watch+0x4cc/0x11e0
>  [   60.537759]  audit_watch_handle_event+0x12c/0x1b0
>  [   60.538227]  send_to_group+0x5d0/0x8b0
>  [   60.538683]  fsnotify+0x615/0x28a0
>  [   60.540007]  fsnotify_move+0x1d8/0x630
>  [   60.540438]  vfs_rename+0xdcd/0x1df0
>  [   60.542176]  do_renameat2+0x9d4/0xbc0
>  [   60.544870]  __x64_sys_renameat+0x192/0x260
>  [   60.545299]  do_syscall_64+0x92/0x180
>  [   60.554189]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  [   60.554562] RIP: 0033:0x7f0491fe8c4e
>  [   60.554947] Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b8 ff ff ff ff
>  c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48> 3d 00 f0 ff ff
>  77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
>  [   60.555789] RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
>  [   60.556237] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0491fe8c4e
>  [   60.556683] RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 00000000ffffff9c
>  [   60.557166] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>  [   60.557618] R10: 00005575eb2dae2a R11: 0000000000000246 R12: 00005575eb2dae2a
>  [   60.558080] R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 00000000ffffff9c
>  [   60.558518]  </TASK>
> 
> The aforementioned deadlock can be consistently reproduced by running
> the script below:
> 
>  audit-dupe-exe-deadlock.sh
>  --------------------------
>  #!/bin/bash
>  auditctl -D
>  mkdir -p /tmp/foo
>  touch /tmp/file
>  auditctl -a always,exit -F exe=/tmp/file -F path=/tmp/file -S all -k dr
>  mv /tmp/file /tmp/foo/file
>  rm -Rf /tmp/foo
> 
> This patch fixes the issue by introducing struct audit_watch_ctx to pass
> the fsnotify event context down to audit_alloc_mark(). By utilizing the
> already-resolved directory inode provided by the event, we bypass the
> kern_path_parent() path resolution entirely, safely avoiding the
> recursive lock. Furthermore, it explicitly allows duplicate fsnotify
> marks (allow_dups = 1) during the rename update, allowing the new rule's
> mark to safely coexist with the old rule's mark until the old rule is
> freed.
> 
> ps.: this issue was identified and reproduced during a comprehensive
> code coverage analysis of the audit subsystem. The full report is
> available at the link below.
> 
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Link: https://people.redhat.com/rrobaina/audit-code-coverage-analysis.pdf
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h          | 13 ++++++++++---
>  kernel/audit_fsnotify.c | 33 ++++++++++++++++++++++-----------
>  kernel/audit_watch.c    | 25 +++++++++++++++++--------
>  kernel/auditfilter.c    |  9 +++++----
>  4 files changed, 54 insertions(+), 26 deletions(-)

Thanks for looking into this, reporting the bug, and providing a fix!

I've got some relatively small comments below, but in the future please
ensure that your commit description when viewed with 'git log' fits
nicely in a 80 character wide terminal without line wrapping.  Feel free
to wrap backtrace lines and trim non-critical information to help long
lines fit. 

> diff --git a/kernel/audit.h b/kernel/audit.h
> index ac81fa02bcd7..2f988f6257d2 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -256,8 +256,13 @@ extern int audit_del_rule(struct audit_entry *entry);
>  extern void audit_free_rule_rcu(struct rcu_head *head);
>  extern struct list_head audit_filter_list[];
>  
> -extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
> +struct audit_watch_ctx {
> +	struct inode *dir;
> +	struct inode *child;
> +};
>  
> +extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
> +					   struct audit_watch_ctx *ctx);
>  extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  				 struct mm_struct *mm);
>  
> @@ -280,13 +285,15 @@ extern char *audit_watch_path(struct audit_watch *watch);
>  extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
>  
>  extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
> -						    char *pathname, int len);
> +						    char *pathname, int len,
> +						    struct audit_watch_ctx *ctx);
>  extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
>  extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
>  extern void audit_remove_mark_rule(struct audit_krule *krule);
>  extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
>  			      dev_t dev);
> -extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
> +extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
> +			  struct audit_watch_ctx *ctx);
>  extern int audit_exe_compare(struct task_struct *tsk,
>  			     struct audit_fsnotify_mark *mark);
>  
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 711454f9f724..eee589bca86e 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -71,7 +71,8 @@ static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
>  	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
>  }
>  
> -struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len)
> +struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname,
> +					     int len, struct audit_watch_ctx *ctx)
>  {
>  	struct audit_fsnotify_mark *audit_mark;
>  	struct path path;
> @@ -81,12 +82,14 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  	if (pathname[0] != '/' || pathname[len-1] == '/')
>  		return ERR_PTR(-EINVAL);
>  
> -	dentry = kern_path_parent(pathname, &path);
> -	if (IS_ERR(dentry))
> -		return ERR_CAST(dentry); /* returning an error */
> -	if (d_really_is_negative(dentry)) {
> -		audit_mark = ERR_PTR(-ENOENT);
> -		goto out;
> +	if (!ctx) {
> +		dentry = kern_path_parent(pathname, &path);
> +		if (IS_ERR(dentry))
> +			return ERR_CAST(dentry); /* returning an error */
> +		if (d_really_is_negative(dentry)) {
> +			audit_mark = ERR_PTR(-ENOENT);
> +			goto out;
> +		}
>  	}
>  
>  	audit_mark = kzalloc_obj(*audit_mark);
> @@ -98,18 +101,26 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
>  	audit_mark->mark.mask = AUDIT_FS_EVENTS;
>  	audit_mark->path = pathname;
> -	audit_update_mark(audit_mark, dentry->d_inode);
>  	audit_mark->rule = krule;
>  
> -	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
> +	if (ctx) {
> +		audit_update_mark(audit_mark, ctx->child);
> +		ret = fsnotify_add_inode_mark(&audit_mark->mark, ctx->dir, 1);
> +	} else {
> +		audit_update_mark(audit_mark, dentry->d_inode);
> +		ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
> +	}

Generally speaking, I dislike when critical code paths are duplicated and
conditionalized like this when the only differences are a small number of
variables/parameters.  It makes it all to easy to introduce small bugs in
the future.  I would suggest a small change list this to unify this
split:

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index eee589bca86e..5069ba758aec 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -77,6 +77,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
        struct audit_fsnotify_mark *audit_mark;
        struct path path;
        struct dentry *dentry;
+       struct inode *dir, *child;
        int ret;
 
        if (pathname[0] != '/' || pathname[len-1] == '/')
@@ -90,6 +91,11 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
                        audit_mark = ERR_PTR(-ENOENT);
                        goto out;
                }
+               dir = d_inode(path.dentry);
+               child = d_inode(dentry);
+       } else {
+               dir = ctx->dir;
+               child = ctx->child;
        }
 
        audit_mark = kzalloc_obj(*audit_mark);
@@ -103,13 +109,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
        audit_mark->path = pathname;
        audit_mark->rule = krule;
 
-       if (ctx) {
-               audit_update_mark(audit_mark, ctx->child);
-               ret = fsnotify_add_inode_mark(&audit_mark->mark, ctx->dir, 1);
-       } else {
-               audit_update_mark(audit_mark, dentry->d_inode);
-               ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
-       }
+       audit_update_mark(audit_mark, child);
+       ret = fsnotify_add_inode_mark(&audit_mark->mark, dir, 1);
 
        if (ret < 0) {
                audit_mark->path = NULL;

>  	if (ret < 0) {
>  		audit_mark->path = NULL;
>  		fsnotify_put_mark(&audit_mark->mark);
>  		audit_mark = ERR_PTR(ret);
>  	}
>  out:
> -	dput(dentry);
> -	path_put(&path);
> +	if (!ctx) {
> +		dput(dentry);
> +		path_put(&path);
> +	}
>  	return audit_mark;
>  }

--
paul-moore.com
