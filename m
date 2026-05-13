Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8878379C2A
	for <audit@vger.kernel.org>; Wed, 13 May 2026 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706170; cv=none; b=a8UPuajozeBY404RHvqTrtLQRiRlPljEQ+X0S5U2jqTSjYOWckskl+hM6ML7hnTo40tfgLdQ6KV6z07F4lXi8H92FwIbndyjWFXdBeIXt6a5Py2H35/eEdsqa7AaI5ne339xTzVwMJbvzN5z82aROd4lCBa3n6VdTKlSM6jzpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706170; c=relaxed/simple;
	bh=F8h+HyNr8RQpzVkjSJoU6mjQor99ILZLyEIgeuMKdcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlMGcuZMVl5QbeP2rkqXQ0ji4GFVablXSITH9O7WjtToEMUHnv/Jd8HXWdug8etXV5cjpredbS5DpPEA/l/QEYBayFET3BdIBDKVr7zNQ30HTh2x0LhzjMDGY6FVUf+6p4HDmOSr5xseYYspTIi4m4z8fecU30lMftnXjkJo5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWEV8DfM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWEV8DfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778706168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv9skw6+g9lXYmlDVTByeeO7zkYPMZU/tMo3xIfrZsk=;
	b=MWEV8DfMEb0ckNT84Blhun4sCgtiXEeKX2EYgu1I07R0yXsLnfnUyjcsEMnSOwZWj/qHRS
	+lUx+wwx2QdQvLJvWuO2VW67S3NryfJLg07DQY9vy454uZ7YDijdYFVERDUcIjtWAI0Ras
	mpzs6Y55r96fhu36YlTYM2FMOpDcLbI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-qlOcy4NLPfWLQKqSDHCONQ-1; Wed, 13 May 2026 17:02:46 -0400
X-MC-Unique: qlOcy4NLPfWLQKqSDHCONQ-1
X-Mimecast-MFC-AGG-ID: qlOcy4NLPfWLQKqSDHCONQ_1778706165
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b94062e85f9so789438766b.2
        for <audit@vger.kernel.org>; Wed, 13 May 2026 14:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706165; x=1779310965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv9skw6+g9lXYmlDVTByeeO7zkYPMZU/tMo3xIfrZsk=;
        b=dtbNXdAzxijpVU3hpO/qmWHxeFjecjd6yHaKZ2ZpSEknODI+y3ldh7XR5wV7vqXhqt
         iCarcGQ2rAMVyz/SkQOI2cmM6rHn81Dwe4ejdq0UyczpVEQPb0Y/cK0LI3hmooBuYoJ3
         CnDhZPnWjgeTaDnHhsl+P9/S+8rZTVGJWAr3sGATT97PqGQcozM6dGnI87d36Zfu4G3s
         MRLCej6x4u0sCBfGRpVyft6+E8dllvsw0T9YfzZXLshGR3mbh93gAzcD80SMba25Jilg
         qJVH9HGDedD+OjIpmruURb1laCJHZRdLWF4qfMrn//tLQ6rD2X2xHNSHjVneA8CcrOw6
         x9cw==
X-Gm-Message-State: AOJu0YzHmqTNnMgFaaZ0nZGk9mi73qvwsyIfkf4LB++oajBGFObSq8+f
	rxapnb0jA5cD+9Vpp7hGjjKlpavolpDYOqj1Ie3rQoNhBBuaBncZ9Ief/KeIxcpNrsbpIwNK09y
	ScpHHPOFfAM3SArpuXYiEiukK16+eQf6p1xOybvfd65Uhzy+ieIDxbyfauPzUXBvyFQc1pyYiWw
	2MD63r7O/PCadnr9bwjogjTJRQv6m89CLcY0tNzBugy59o
X-Gm-Gg: Acq92OE540wbQDuIjZQsYHkW62o2y31+g2TNtlXF5s/MHv0r93ClyrpIjmKOJs9MTO8
	BL5AsCfsqd1skpHi0FprWlZ6sMAOjP2pbhKxxmDgr3+BSs+Z8hPS9v8iZI7QcrNjMtDlxE6v0mD
	COJDUD/XaBurb3gJcSgcbWDjDuxC3UIZno0eBija1rVxy+y9hOeB/awgmRox056oL8uO2EaxYH0
	0ny8+au9MdB7EuHbAJRsM0lhMcObSJyjgJslCIrSE9WeDfJcEt/0nKXKe8Mz8KLW/8hAPZTVtpM
	+ZGAl5LpQv+2ZL02WI1PEyE=
X-Received: by 2002:a17:906:6a12:b0:bba:5bc9:534a with SMTP id a640c23a62f3a-bd3c181d40fmr348232966b.31.1778706164520;
        Wed, 13 May 2026 14:02:44 -0700 (PDT)
X-Received: by 2002:a17:906:6a12:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bd3c181d40fmr348230166b.31.1778706164003; Wed, 13 May 2026
 14:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d47fb8371df34617c7ce3dd7550d03e1a962017.1776176104.git.rrobaina@redhat.com>
 <8fc7c79a550a8088cbc8c066c0f5f449@paul-moore.com>
In-Reply-To: <8fc7c79a550a8088cbc8c066c0f5f449@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 13 May 2026 18:02:32 -0300
X-Gm-Features: AVHnY4JV46zqHfoZaouxCj8XQdBHdgjFdkfevtlvzZZyLb-IU_t4nXW-fhXEvrQ
Message-ID: <CAABTaaD227x56LxB5vgVoRSHrZ41v+039tyL7Xv3-A7sCc0Lhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: fix recursive locking deadlock in audit_dupe_exe()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pqoPJCwE_vl7dBv0JA2_O7R_xgCL_ItXSWHkmdjCn4s_1778706165
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Apr 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > A deadlock occurs in the audit subsystem when duplicating
> > executable-related rules.
> >
> > When a file is moved (e.g., via do_renameat2()), the VFS layer locks
> > the parent directory (I_MUTEX_PARENT), which synchronously triggers an
> > fsnotify_move event. If an existing executable audit rule matches the
> > file being moved, the audit subsystem catches this event and calls
> > audit_dupe_exe() to duplicate the watch and update the rule. Then,
> > audit_alloc_mark() would call kern_path_parent() to resolve the path,
> > leading to a blind attempt to acquire the exact same I_MUTEX_PARENT loc=
k
> > already held by the task, resulting in the following recursive locking
> > deadlock:
> >
> >  [   60.521149] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >  [   60.521164] WARNING: possible recursive locking detected
> >  [   60.521180] 6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
> >  [   60.521197] --------------------------------------------
> >  [   60.521211] mv/5099 is trying to acquire lock:
> >  [   60.521225] ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key=
/1){+.+.}-{3:3},
> >  at: __kern_path_locked+0x10a/0x2f0
> >  [   60.521263]
> >                 but task is already holding lock:
> >  [   60.521280] ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key=
/1){+.+.}-{3:3},
> >  at: lock_two_directories+0x13f/0x2b0
> >  [   60.521313]
> >                 other info that might help us debug this:
> >  [   60.521331]  Possible unsafe locking scenario:
> >
> >  [   60.521349]        CPU0
> >  [   60.521357]        ----
> >  [   60.521365]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
> >  [   60.521384]   lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
> >  [   60.521401]
> >                  *** DEADLOCK ***
> >
> >  [   60.521422]  May be due to missing lock nesting notation
> >
> >  [   60.521445] 6 locks held by mv/5099:
> >  [   60.521458]  #0: ffff888112a9c440 (sb_writers#13){++++}-{0:0}, at: =
do_renameat2+0x34c/0xbc0
> >  [   60.521491]  #1: ffff888112a9c790 (&type->s_vfs_rename_key#3){+.+.}=
-{3:3}, at: do_renameat2+0x415/0xbc0
> >  [   60.521525]  #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_di=
r_key/1){+.+.}-{3:3},
> >  at: lock_two_directories+0x13f/0x2b0
> >  [   60.521565]  #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_di=
r_key/5){+.+.}-{3:3},
> >  at: lock_two_directories+0x175/0x2b0
> >  [   60.521604]  #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu){.+.+}-{0:0}=
, at: fsnotify+0x454/0x28a0
> >  [   60.521636]  #5: ffffffffaf886230 (audit_filter_mutex){+.+.}-{3:3},=
 at: audit_update_watch+0x36/0x11e0
> >  [   60.521670]
> >                 stack backtrace:
> >  [   60.521687] CPU: 0 UID: 0 PID: 5099 Comm: mv Kdump: loaded Not tain=
ted 6.12.0-55.27.1.el10_0.x86_64+debug #1
> >  [   60.521718] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-2.fc40 04/01/2014
> >  [   60.521743] Call Trace:
> >  [   60.521754]  <TASK>
> >  [   60.521764]  dump_stack_lvl+0x6f/0xb0
> >  [   60.521781]  print_deadlock_bug.cold+0xbd/0xca
> >  [   60.521798]  validate_chain+0x83a/0xf00
> >  [   60.522465]  __lock_acquire+0xcac/0x1d20
> >  [   60.524073]  lock_acquire.part.0+0x11b/0x360
> >  [   60.528512]  down_write_nested+0x9f/0x230
> >  [   60.530038]  __kern_path_locked+0x10a/0x2f0
> >  [   60.532561]  kern_path_locked+0x26/0x40
> >  [   60.533018]  audit_alloc_mark+0xfb/0x4f0
> >  [   60.535295]  audit_dupe_exe+0x6c/0xe0
> >  [   60.536307]  audit_dupe_rule+0x6c2/0xc00
> >  [   60.537290]  audit_update_watch+0x4cc/0x11e0
> >  [   60.537759]  audit_watch_handle_event+0x12c/0x1b0
> >  [   60.538227]  send_to_group+0x5d0/0x8b0
> >  [   60.538683]  fsnotify+0x615/0x28a0
> >  [   60.540007]  fsnotify_move+0x1d8/0x630
> >  [   60.540438]  vfs_rename+0xdcd/0x1df0
> >  [   60.542176]  do_renameat2+0x9d4/0xbc0
> >  [   60.544870]  __x64_sys_renameat+0x192/0x260
> >  [   60.545299]  do_syscall_64+0x92/0x180
> >  [   60.554189]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  [   60.554562] RIP: 0033:0x7f0491fe8c4e
> >  [   60.554947] Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b=
8 ff ff ff ff
> >  c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48> 3d=
 00 f0 ff ff
> >  77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
> >  [   60.555789] RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000108
> >  [   60.556237] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f=
0491fe8c4e
> >  [   60.556683] RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 000000=
00ffffff9c
> >  [   60.557166] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000=
0000000001
> >  [   60.557618] R10: 00005575eb2dae2a R11: 0000000000000246 R12: 000055=
75eb2dae2a
> >  [   60.558080] R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 000000=
00ffffff9c
> >  [   60.558518]  </TASK>
> >
> > The aforementioned deadlock can be consistently reproduced by running
> > the script below:
> >
> >  audit-dupe-exe-deadlock.sh
> >  --------------------------
> >  #!/bin/bash
> >  auditctl -D
> >  mkdir -p /tmp/foo
> >  touch /tmp/file
> >  auditctl -a always,exit -F exe=3D/tmp/file -F path=3D/tmp/file -S all =
-k dr
> >  mv /tmp/file /tmp/foo/file
> >  rm -Rf /tmp/foo
> >
> > This patch fixes the issue by introducing struct audit_watch_ctx to pas=
s
> > the fsnotify event context down to audit_alloc_mark(). By utilizing the
> > already-resolved directory inode provided by the event, we bypass the
> > kern_path_parent() path resolution entirely, safely avoiding the
> > recursive lock. Furthermore, it explicitly allows duplicate fsnotify
> > marks (allow_dups =3D 1) during the rename update, allowing the new rul=
e's
> > mark to safely coexist with the old rule's mark until the old rule is
> > freed.
> >
> > ps.: this issue was identified and reproduced during a comprehensive
> > code coverage analysis of the audit subsystem. The full report is
> > available at the link below.
> >
> > Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> > Link: https://people.redhat.com/rrobaina/audit-code-coverage-analysis.p=
df
> > Acked-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Acked-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.h          | 13 ++++++++++---
> >  kernel/audit_fsnotify.c | 33 ++++++++++++++++++++++-----------
> >  kernel/audit_watch.c    | 25 +++++++++++++++++--------
> >  kernel/auditfilter.c    |  9 +++++----
> >  4 files changed, 54 insertions(+), 26 deletions(-)
>
> Thanks for looking into this, reporting the bug, and providing a fix!
>

Thanks for reviewing this patch series, Paul. Sure thing, I'm happy to help=
.

> I've got some relatively small comments below, but in the future please
> ensure that your commit description when viewed with 'git log' fits
> nicely in a 80 character wide terminal without line wrapping.  Feel free
> to wrap backtrace lines and trim non-critical information to help long
> lines fit.
>

Ack.

> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index ac81fa02bcd7..2f988f6257d2 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -256,8 +256,13 @@ extern int audit_del_rule(struct audit_entry *entr=
y);
> >  extern void audit_free_rule_rcu(struct rcu_head *head);
> >  extern struct list_head audit_filter_list[];
> >
> > -extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
> > +struct audit_watch_ctx {
> > +     struct inode *dir;
> > +     struct inode *child;
> > +};
> >
> > +extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
> > +                                        struct audit_watch_ctx *ctx);
> >  extern void audit_log_d_path_exe(struct audit_buffer *ab,
> >                                struct mm_struct *mm);
> >
> > @@ -280,13 +285,15 @@ extern char *audit_watch_path(struct audit_watch =
*watch);
> >  extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev=
_t dev);
> >
> >  extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule=
 *krule,
> > -                                                 char *pathname, int l=
en);
> > +                                                 char *pathname, int l=
en,
> > +                                                 struct audit_watch_ct=
x *ctx);
> >  extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
> >  extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
> >  extern void audit_remove_mark_rule(struct audit_krule *krule);
> >  extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 in=
o,
> >                             dev_t dev);
> > -extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule =
*old);
> > +extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule =
*old,
> > +                       struct audit_watch_ctx *ctx);
> >  extern int audit_exe_compare(struct task_struct *tsk,
> >                            struct audit_fsnotify_mark *mark);
> >
> > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > index 711454f9f724..eee589bca86e 100644
> > --- a/kernel/audit_fsnotify.c
> > +++ b/kernel/audit_fsnotify.c
> > @@ -71,7 +71,8 @@ static void audit_update_mark(struct audit_fsnotify_m=
ark *audit_mark,
> >       audit_mark->ino =3D inode ? inode->i_ino : AUDIT_INO_UNSET;
> >  }
> >
> > -struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule=
, char *pathname, int len)
> > +struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule=
, char *pathname,
> > +                                          int len, struct audit_watch_=
ctx *ctx)
> >  {
> >       struct audit_fsnotify_mark *audit_mark;
> >       struct path path;
> > @@ -81,12 +82,14 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct=
 audit_krule *krule, char *pa
> >       if (pathname[0] !=3D '/' || pathname[len-1] =3D=3D '/')
> >               return ERR_PTR(-EINVAL);
> >
> > -     dentry =3D kern_path_parent(pathname, &path);
> > -     if (IS_ERR(dentry))
> > -             return ERR_CAST(dentry); /* returning an error */
> > -     if (d_really_is_negative(dentry)) {
> > -             audit_mark =3D ERR_PTR(-ENOENT);
> > -             goto out;
> > +     if (!ctx) {
> > +             dentry =3D kern_path_parent(pathname, &path);
> > +             if (IS_ERR(dentry))
> > +                     return ERR_CAST(dentry); /* returning an error */
> > +             if (d_really_is_negative(dentry)) {
> > +                     audit_mark =3D ERR_PTR(-ENOENT);
> > +                     goto out;
> > +             }
> >       }
> >
> >       audit_mark =3D kzalloc_obj(*audit_mark);
> > @@ -98,18 +101,26 @@ struct audit_fsnotify_mark *audit_alloc_mark(struc=
t audit_krule *krule, char *pa
> >       fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
> >       audit_mark->mark.mask =3D AUDIT_FS_EVENTS;
> >       audit_mark->path =3D pathname;
> > -     audit_update_mark(audit_mark, dentry->d_inode);
> >       audit_mark->rule =3D krule;
> >
> > -     ret =3D fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d=
_inode, 0);
> > +     if (ctx) {
> > +             audit_update_mark(audit_mark, ctx->child);
> > +             ret =3D fsnotify_add_inode_mark(&audit_mark->mark, ctx->d=
ir, 1);
> > +     } else {
> > +             audit_update_mark(audit_mark, dentry->d_inode);
> > +             ret =3D fsnotify_add_inode_mark(&audit_mark->mark, path.d=
entry->d_inode, 0);
> > +     }
>
> Generally speaking, I dislike when critical code paths are duplicated and
> conditionalized like this when the only differences are a small number of
> variables/parameters.  It makes it all to easy to introduce small bugs in
> the future.  I would suggest a small change list this to unify this
> split:
>
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index eee589bca86e..5069ba758aec 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -77,6 +77,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct aud=
it_krule *krule, char *pa
>         struct audit_fsnotify_mark *audit_mark;
>         struct path path;
>         struct dentry *dentry;
> +       struct inode *dir, *child;
>         int ret;
>
>         if (pathname[0] !=3D '/' || pathname[len-1] =3D=3D '/')
> @@ -90,6 +91,11 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct au=
dit_krule *krule, char *pa
>                         audit_mark =3D ERR_PTR(-ENOENT);
>                         goto out;
>                 }
> +               dir =3D d_inode(path.dentry);
> +               child =3D d_inode(dentry);
> +       } else {
> +               dir =3D ctx->dir;
> +               child =3D ctx->child;
>         }
>
>         audit_mark =3D kzalloc_obj(*audit_mark);
> @@ -103,13 +109,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct =
audit_krule *krule, char *pa
>         audit_mark->path =3D pathname;
>         audit_mark->rule =3D krule;
>
> -       if (ctx) {
> -               audit_update_mark(audit_mark, ctx->child);
> -               ret =3D fsnotify_add_inode_mark(&audit_mark->mark, ctx->d=
ir, 1);
> -       } else {
> -               audit_update_mark(audit_mark, dentry->d_inode);
> -               ret =3D fsnotify_add_inode_mark(&audit_mark->mark, path.d=
entry->d_inode, 0);
> -       }
> +       audit_update_mark(audit_mark, child);
> +       ret =3D fsnotify_add_inode_mark(&audit_mark->mark, dir, 1);
>
>         if (ret < 0) {
>                 audit_mark->path =3D NULL;
>

Nice, the refactored code looks much cleaner. One quick catch, though:
hardcoding 1 in fsnotify_add_inode_mark() drops the -EEXIST check for
standard rule additions, which would allow duplicate rules.

In the v2 I'm about to send, I used your exact structure but added an
allow_dups flag to preserve that protection.

> >       if (ret < 0) {
> >               audit_mark->path =3D NULL;
> >               fsnotify_put_mark(&audit_mark->mark);
> >               audit_mark =3D ERR_PTR(ret);
> >       }
> >  out:
> > -     dput(dentry);
> > -     path_put(&path);
> > +     if (!ctx) {
> > +             dput(dentry);
> > +             path_put(&path);
> > +     }
> >       return audit_mark;
> >  }
>
> --
> paul-moore.com
>

