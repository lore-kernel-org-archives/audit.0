Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370B3CC7DF
	for <audit@vger.kernel.org>; Tue, 26 May 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836417; cv=none; b=TzMolhmfP7WnRAQbu8tw9BIk7ibkYaPFLWP0eKmW3B14KOdoPi1VFnBRVgoMsNkIcCj0wrzJ/vRyMfM/UBD57FcfF4rtvV9qzWBupaahwtz4nX8fPruBoB6Q0cxFC1CyUaKj8HNoigxpDzyrXG3+GMyomEAdipPaXnd1iRnGuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836417; c=relaxed/simple;
	bh=W5DlsZyeYpqjdkyQNds9guuPXTwo9ZOieL8yeN/+mSI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=p0BsCnylCcsXqcQHDwB3fUsVL+Qdx15cP1J3y3rnoHUNS6ksAm0Cyzun/TeOIAvwgmZXbZge2L20R/djB/oIDyxLFUFAK8FsD3iKHuvnypRoH8eRdQrnMHrwf8OJ5HqjPj2cd+jGvz/YMiAxByw/BMBsJkOUHTka3HzQF1kdWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q3xAaIY6; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q3xAaIY6"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8c921396e37so114282166d6.2
        for <audit@vger.kernel.org>; Tue, 26 May 2026 16:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779836415; x=1780441215; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9giLaLR6X98aXke7Jii/UyK4qMrI1WSJSF9Tlnf+vRM=;
        b=Q3xAaIY6ShDZ635mOXOIqYT+Qhg54FVGMcgGtD4pxg1ze6aIywNBJ5LWwM3fkb/nJ4
         CNfGwonDWS438ahLkpdYRVgsowKmDWJufVxLR/ctiE29XC0t/X9bZtt0udiqiBeyI7+N
         ke7TISNcIUos+nGLSunRCgtFcPvRnhu0x9kTX69pPxMc6F/EpiC47Ha/TFNrJHpBewfa
         SvcWBpvhLRrx48JSBYqbMJJiQ+t8IPTn26r152N5yZV7MjT0B/hCvJ2Lmn2bauWXNdRT
         8fMciBplZDt9+ujm+LfvkYa1tby2RZDq7iDjohPUwzmC7mJsPFJMrZlTR89ZwgccsBpe
         wm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779836415; x=1780441215;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9giLaLR6X98aXke7Jii/UyK4qMrI1WSJSF9Tlnf+vRM=;
        b=RTpszRmQAAyz+wdQLB8anO9BlJojet7Fn4dKp97rimq7dLlbJnE0jM7KNl1J0ahyVf
         0s+RdpGKwxbrxw+WKvRNwcnPwfAEv36qpPx5s3diXyxFjo4BfP99L+ARfUH08VH+Mo8I
         6whkyligqrK6PFPKzY9V3MKKYzhDlWPSUpZdc97SKf2rw9bDmbxw0R+/EbndGp0CF7Rf
         NEud03itQ787R3VojfiZSTl5z02m7oXysaxUFOB4/bYtZjwJcPmkJNHm9250Yix5MI55
         Sk0i8oRCHHzIUXs7oI8Sh7lfVIZVpbn/SBILq/cgKiuQUiMBt6KxXFG+a88ewM/tjkHt
         QlkA==
X-Forwarded-Encrypted: i=1; AFNElJ9UBGqDf7zwYguSE//GyykXDFsQYevjK0n90JbvPiZNSTbRO3aJQsgS8gw19EpYslEBxoy/AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5CYo950VeqX7AvTzET/NFcOLKFKzKbegx6dK0CebUS9Mfenk
	jwxkw3Kc3rvH+6go/vtFaQqWVIMIcFIIokrkThtMM9eDVCKmGdZSG7LFEAl/XMxS9A==
X-Gm-Gg: Acq92OFImVCupixXCwrCS60GyfrH8mQtmELYH5XUw628htvbASL5IvlgFet7PKCQGGQ
	gRGBy1ZOldV4a773qXTbrb9bawJ1TMfMASywKd0YSzirAshg+1KgpstUEYtbHg1qJTG+gEJjiHo
	PKV2hheEKpyQGz7f02/+aRRLzkfhzloT2nlv/Im9IwN+A7deRzZh1NWzoDRFH341E50aDaMopwn
	v+CsayvVXWKdwro3y/25Qg3/x1XyqMAROCu6l4YziEEHhgpj64ZLVKnHz8O1zRKZPmUVDQT9qyy
	sdMWFZiBVOeQQxy56Ttu4pOMaUqsH/XqdSth9+BjiqhQxyxhLgOYzKxQZGuOdQcCkT2FMsrIu0t
	Z3jvJeEtH9hNL/WPtyZszPATNDwF5v+QbMnra3qc4wK3EJD894sTCQz8p67GHSHPv3rkb0mRTzT
	w2px6m+PwllnDN8PQrL2ASxxLalxwHrPUcRx2fjJPWQvSaEvi1zpesZK0fTDOs39iWrkQH7V85O
	Cjsc6s=
X-Received: by 2002:a05:6214:410e:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8cc7b53d6eamr364680786d6.4.1779836414887;
        Tue, 26 May 2026 16:00:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca4705c62sm66159166d6.27.2026.05.26.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:00:13 -0700 (PDT)
Date: Tue, 26 May 2026 19:00:13 -0400
Message-ID: <4d6adf668c92044d509ccece53418bf3@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260526_1654/pstg-lib:20260526_1539/pstg-pwork:20260526_1654
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, longman@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2 2/2] audit: fix recursive locking deadlock in  audit_dupe_exe()
References: <bc39b14f9e0429e9a8ecbd069281d52ecbfc80d3.1778704210.git.rrobaina@redhat.com>
In-Reply-To: <bc39b14f9e0429e9a8ecbd069281d52ecbfc80d3.1778704210.git.rrobaina@redhat.com>

On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
>  ============================================
>  WARNING: possible recursive locking detected
>  6.12.0-55.27.1.el10_0.x86_64+debug #1 Not tainted
>  --------------------------------------------
>  mv/5099 is trying to acquire lock:
>  ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
>  at: __kern_path_locked+0x10a/0x2f0
> 
>  but task is already holding lock:
>  ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1){+.+.}-{3:3},
>  at: lock_two_directories+0x13f/0x2b0
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
>    lock(&inode->i_sb->s_type->i_mutex_dir_key/1);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>   6 locks held by mv/5099:
>   #0: ffff888112a9c440 (sb_writers#13)
>   at: do_renameat2+0x34c/0xbc0
>   #1: ffff888112a9c790 (&type->s_vfs_rename_key#3)
>   at: do_renameat2+0x415/0xbc0
>   #2: ffff888132846b58 (&inode->i_sb->s_type->i_mutex_dir_key/1)
>   at: lock_two_directories+0x13f/0x2b0
>   #3: ffff888132845358 (&inode->i_sb->s_type->i_mutex_dir_key/5)
>   at: lock_two_directories+0x175/0x2b0
>   #4: ffffffffb3a1fb10 (&fsnotify_mark_srcu)
>   at: fsnotify+0x454/0x28a0
>   #5: ffffffffaf886230 (audit_filter_mutex)
>   at: audit_update_watch+0x36/0x11e0
> 
>  stack backtrace:
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6f/0xb0
>   print_deadlock_bug.cold+0xbd/0xca
>   validate_chain+0x83a/0xf00
>   __lock_acquire+0xcac/0x1d20
>   lock_acquire.part.0+0x11b/0x360
>   down_write_nested+0x9f/0x230
>   __kern_path_locked+0x10a/0x2f0
>   kern_path_locked+0x26/0x40
>   audit_alloc_mark+0xfb/0x4f0
>   audit_dupe_exe+0x6c/0xe0
>   audit_dupe_rule+0x6c2/0xc00
>   audit_update_watch+0x4cc/0x11e0
>   audit_watch_handle_event+0x12c/0x1b0
>   send_to_group+0x5d0/0x8b0
>   fsnotify+0x615/0x28a0
>   fsnotify_move+0x1d8/0x630
>   vfs_rename+0xdcd/0x1df0
>   do_renameat2+0x9d4/0xbc0
>   __x64_sys_renameat+0x192/0x260
>   do_syscall_64+0x92/0x180
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0491fe8c4e
>  Code: 0f 1f 40 00 48 8b 15 c1 e1 16 00 f7 d8 64 89 02 b8 ff ff ff ff
>  c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 08 01 00 00 0f 05 <48>
>  3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 89
>  RSP: 002b:00007ffc7210bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0491fe8c4e
>  RDX: 0000000000000003 RSI: 00007ffc7210e6c8 RDI: 00000000ffffff9c
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>  R10: 00005575eb2dae2a R11: 0000000000000246 R12: 00005575eb2dae2a
>  R13: 00007ffc7210e6c8 R14: 0000000000000003 R15: 00000000ffffff9c
>   </TASK>
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
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> Changes in v2:
> - New patch order: now patch 2/2 (was 1/2 in v1) per maintainer feedback
> - Refactored audit_alloc_mark() to use local dir/child inode variables,
>   eliminating code duplication in the critical execution path
> - Unified fsnotify_add_inode_mark() call using allow_dups variable:
>   allow_dups=0 for manual rule additions (ctx==NULL, no duplicates allowed),
>   allow_dups=1 for fsnotify events (ctx!=NULL, temporary coexistence during
>   rename operations)
> 
>  kernel/audit.h          | 13 ++++++++++---
>  kernel/audit_fsnotify.c | 32 +++++++++++++++++++++++---------
>  kernel/audit_watch.c    | 25 +++++++++++++++++--------
>  kernel/auditfilter.c    |  9 +++++----
>  4 files changed, 55 insertions(+), 24 deletions(-)

Similar to patch 1/2, I want to give this some extra time in linux-next,
so I'm going to mark it for stable but merge it into audit/dev.

Regardless, good work here - thanks!

--
paul-moore.com
