Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2531E0DE8
	for <audit@vger.kernel.org>; Wed, 27 May 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885822; cv=none; b=IWyFyoqO2WwI04wdfwbFqKCKNpNf4paChLNa7xiK49cXsz85m7trSpxKrPZH/Jgz3jjpcmaU1CKg2lY4RsZVOEZW8oXKt1H06pM1M7SYgFvbCZykFzWmAWRyK1cRbq/GJB9dtvGgHKuCqqm1TzCQY4ZdV/n+iJspZD1YUIne40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885822; c=relaxed/simple;
	bh=dd1McBHqhbkDktCUtFmHUmCpNMddb5ZIp2EAcOZl2Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JA7aUlUlmGxy8HLgvSwvqWI3W15/hQCnVaryvHBxzkAo0wPKZ8AOroXzWCrthd+TMkkX41veNJcadZWMRyfQBQEoJrkfjrHJxFgCm/kpLCN+gAXJA5VmF9f6HNBHDv5A3fQ1RGZFC/AnZyeWPitA7y7TncG6ake5F+ntzEPHuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d55IJYSp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d55IJYSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779885817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIVhDKUnl3izdZiw2i/B6yNnJU3Mvf4kaQLy0ORdZPY=;
	b=d55IJYSpQvy92BzxT5NYEo6Zur7M9yspsMyyMag2mmvJsmHdpSI/HWQniDWX+/23GXIMAZ
	ja2uOrJvnu0WRZyKCqrKf+NCT0svpft0lj9zZ6HMF8CciaCKtJJLUpDuFoLGVJkC+TLuAG
	OMFGkBUuLz8Lm1LwwfxVxeUK6W8CN44=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-D3MK6d8iN7-6G4rjb3joyw-1; Wed, 27 May 2026 08:43:35 -0400
X-MC-Unique: D3MK6d8iN7-6G4rjb3joyw-1
X-Mimecast-MFC-AGG-ID: D3MK6d8iN7-6G4rjb3joyw_1779885815
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bdad545342aso239347666b.0
        for <audit@vger.kernel.org>; Wed, 27 May 2026 05:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885814; x=1780490614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIVhDKUnl3izdZiw2i/B6yNnJU3Mvf4kaQLy0ORdZPY=;
        b=Z6QGNc+nehux1iR7Fm+UWMaDHjpA80TZybc6c2+VvCU6g9lW4w1DPGxE8voiRE/dfF
         AlhAHjACyMaLLTc/3IPI7Af/qo8qxpzDH1rJD94yhHh0gmOn05Y8Q5fNIfILyV9XF8Dc
         F6ce2gk3hZAGDLBNjLdJwHvaYj0ccD5WD6djycypihu/YYRLWP+h3HLLpdm8/akTxaOW
         1CR3lKglj6EZdjSeY9D3A6p9FGYtTECY2031RySOg7uIHuwbq3y5o5Gq6gKRtP+yfdF/
         uPfXsjlo4hhiS/WgPFrSRoSc83kYzLEa3buwXIrYwH9EGzaEAae/G+N/A4G/1Uf3b+aY
         nqWw==
X-Gm-Message-State: AOJu0YwoF9n8AamPcNZx/acrO0ulLYnx+yT63AIMCwCKKfgbqup2Zbvw
	a1QoIvMaAl+2MqCKHV1e/EJUJQuFa5rtKDl007uJS79NGK91EEnWJw4mtWvZdkAuQXnq1Rjio2y
	KVaH/TezGFCQ4P1HKoUnz4HgKZ/UcDdpZobMq3tJo+kagTPKws4N0vRfiA3ViaWH/tEPkmoJoQN
	CyTcWcVL2TvzcG97NwjfIm94HLnLm7K4A=
X-Gm-Gg: Acq92OFCc5uK8xGRT4r8KpkR1Nf6lKs/FMkClz3GpWvm7YbeDYhGJs70Azomg8meT82
	Mbb55vGeGj8z4BMWZqO2MaYLSCjPSJGKuARt7DUPPHd4T83wH7i75gUXMOtWj8oEdLltoqFHaYX
	/96K1Cu4th/IoOx/6qwXoOD/KeqZE9ia5wY+3M+0I3JHMnZ4ifxiL2Ms6LYoY6pBqLiliiEeZUt
	myvx+Gtj/iL0ohsSsDZWBTj5D7h9I0V+XlcAfkv9vKKlv/dL7+D/HTt+Wu8EqC2FbxqsEDYWUFa
	WlnF6htGtl363ijofECDipdg
X-Received: by 2002:a17:907:b14:b0:bd8:1c88:cfef with SMTP id a640c23a62f3a-bdd2293182amr1005585466b.5.1779885814543;
        Wed, 27 May 2026 05:43:34 -0700 (PDT)
X-Received: by 2002:a17:907:b14:b0:bd8:1c88:cfef with SMTP id
 a640c23a62f3a-bdd2293182amr1005583966b.5.1779885814076; Wed, 27 May 2026
 05:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc39b14f9e0429e9a8ecbd069281d52ecbfc80d3.1778704210.git.rrobaina@redhat.com>
 <4d6adf668c92044d509ccece53418bf3@paul-moore.com>
In-Reply-To: <4d6adf668c92044d509ccece53418bf3@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 09:43:22 -0300
X-Gm-Features: AVHnY4LJkUuyz4o5cOVA5nK1MNBKX2vz6byGnejZOSbfnpHlRlRAPPHOtYJoZaI
Message-ID: <CAABTaaBO6TiCTgP=fYVW3Zo=8M9kda7wouwsWt45FWne5vL68Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] audit: fix recursive locking deadlock in audit_dupe_exe()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 86s6IRZZMEIaw1aTwTtXeD1kMsN-sPHQl2a8f0xNUz4_1779885815
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  WARNING: possible recursive locking detected
> >  6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
> >  --------------------------------------------
> >  mv/5099 is trying to acquire lock:
> >  ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3}=
,
> >  at: __kern_path_locked+0x10a/0x2f0
> >
> >  but task is already holding lock:
> >  ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3}=
,
> >  at: lock_two_directories+0x13f/0x2b0
> >
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
> >    lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
> >
> >   *** DEADLOCK ***
> >
> >   May be due to missing lock nesting notation
> >
> >   6 locks held by mv/5099:
> >   #0: ffff888112a9c440 (sb_writers#13)
> >   at: do_renameat2+0x34c/0xbc0
> >   #1: ffff888112a9c790 (&type->s_vfs_rename_key#3)
> >   at: do_renameat2+0x415/0xbc0
> >   #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1)
> >   at: lock_two_directories+0x13f/0x2b0
> >   #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/5)
> >   at: lock_two_directories+0x175/0x2b0
> >   #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu)
> >   at: fsnotify+0x454/0x28a0
> >   #5: ffffffffaf886230 (audit_filter_mutex)
> >   at: audit_update_watch+0x36/0x11e0
> >
> >  stack backtrace:
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x6f/0xb0
> >   print_deadlock_bug.cold+0xbd/0xca
> >   validate_chain+0x83a/0xf00
> >   __lock_acquire+0xcac/0x1d20
> >   lock_acquire.part.0+0x11b/0x360
> >   down_write_nested+0x9f/0x230
> >   __kern_path_locked+0x10a/0x2f0
> >   kern_path_locked+0x26/0x40
> >   audit_alloc_mark+0xfb/0x4f0
> >   audit_dupe_exe+0x6c/0xe0
> >   audit_dupe_rule+0x6c2/0xc00
> >   audit_update_watch+0x4cc/0x11e0
> >   audit_watch_handle_event+0x12c/0x1b0
> >   send_to_group+0x5d0/0x8b0
> >   fsnotify+0x615/0x28a0
> >   fsnotify_move+0x1d8/0x630
> >   vfs_rename+0xdcd/0x1df0
> >   do_renameat2+0x9d4/0xbc0
> >   __x64_sys_renameat+0x192/0x260
> >   do_syscall_64+0x92/0x180
> >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  RIP: 0033:0x7f0491fe8c4e
> >  Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b8 ff ff ff ff
> >  c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48>
> >  3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
> >  RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
> >  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0491fe8c4e
> >  RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 00000000ffffff9c
> >  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> >  R10: 00005575eb2dae2a R11: 0000000000000246 R12: 00005575eb2dae2a
> >  R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 00000000ffffff9c
> >   </TASK>
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
> > Acked-by: Richard Guy Briggs <rgb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> > Changes in v2:
> > - New patch order: now patch 2/2 (was 1/2 in v1) per maintainer feedbac=
k
> > - Refactored audit_alloc_mark() to use local dir/child inode variables,
> >   eliminating code duplication in the critical execution path
> > - Unified fsnotify_add_inode_mark() call using allow_dups variable:
> >   allow_dups=3D0 for manual rule additions (ctx=3D=3DNULL, no duplicate=
s allowed),
> >   allow_dups=3D1 for fsnotify events (ctx!=3DNULL, temporary coexistenc=
e during
> >   rename operations)
> >
> >  kernel/audit.h          | 13 ++++++++++---
> >  kernel/audit_fsnotify.c | 32 +++++++++++++++++++++++---------
> >  kernel/audit_watch.c    | 25 +++++++++++++++++--------
> >  kernel/auditfilter.c    |  9 +++++----
> >  4 files changed, 55 insertions(+), 24 deletions(-)
>
> Similar to patch 1/2, I want to give this some extra time in linux-next,
> so I'm going to mark it for stable but merge it into audit/dev.
>
> Regardless, good work here - thanks!
>
> --
> paul-moore.com
>

Thanks, Paul. I appreciate it!

