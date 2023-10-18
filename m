Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132CCDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 22:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJRWWm (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWWl (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 18:22:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4D111
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:22:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9c7bba32beso1504068276.1
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697667759; x=1698272559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H5Kjrbp3RWUReVXdI4zGXiHrwnmNDbbBrQ3pcKetNo=;
        b=RR3+ugyUZXjXi5MeNo8NUPqrTpnQ78ChO3RyunnwEhsU3EjkVaL0k51cNvoCfqAFVh
         kc2L7GYNH3ukNGKRQLVhODv4sBBveCgd/mnIWcxnIjX2Z7Srnnc7svc1C5GsvxohbMCY
         6SwP5QaN6PD5RuU4ZX13/WJFlqIAuEnkmXrdwRnMyHZZFD782iZRIS9/w37/+XWsXFad
         uViYvcfLhp9rbSTwIcBOEOnm9qOVijDJufWGKT5Hb/6k7/HxWlonlfzaGtKspUjAZmEq
         qSOrLDWjeDF9ox5KmA+819PJZFO4aQcDTLk7xWCoSS+F9YB55/oRe7EBkaoiLkl670i9
         Srmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667759; x=1698272559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H5Kjrbp3RWUReVXdI4zGXiHrwnmNDbbBrQ3pcKetNo=;
        b=O+8K+w0g2YCZoXgzDcZC+/91VpdOqz8SDHSjFnwzD7wlf7HR91dj2z9hSPgXhTABH5
         OwYuAb5zhgxKIt5vXhz5MpAD9hV2q6FUP+So3L6rKHmrPcQOkKE5FPRXkQDJt4AChydb
         a0uNuxh+/kAQauya/mli4KeloJ/tLgm53VBdqBS1h/8AR7iG2dNhPNzWdLRj9gOVmwT3
         jl4oaPJhLQ24I3wNbI2Cu3LlYINLT7gzZBa0y6Eu5JKLAMEQrZflWUOL7gBi00GcqWZM
         EoNCA5NIMpxToOl1yfeth0de2O2p29BEN1xtP/T6FsOOc1xhUtbfDj/SMdsK+BTMGbGP
         AIlw==
X-Gm-Message-State: AOJu0YwBEW9ntqw2cvwQB9ab92PNRrzVSKp9ON31MUN5ENjA/MXCLaCJ
        usEqDLHNp9QeoUi8OngX25Vvq01xGi3N+0mH1APs7Zmbkl2Nuprspw==
X-Google-Smtp-Source: AGHT+IEQE0mbaO9fW4bzBibKdtTqgOudEFzQPDI7a2Yqj2nzAW/u4yoFeLktcjB+nEFrLTwR57xr2LnVGV2iyD8ysms=
X-Received: by 2002:a25:b52:0:b0:d9c:7c23:97bc with SMTP id
 79-20020a250b52000000b00d9c7c2397bcmr696051ybl.55.1697667758742; Wed, 18 Oct
 2023 15:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com>
In-Reply-To: <20231018222023.371274-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 18:22:27 -0400
Message-ID: <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     audit@vger.kernel.org
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>, mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Updating Mateusz's email.

On Wed, Oct 18, 2023 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The get_task_exe_file() function locks the given task with task_lock()
> which when used inside audit_exe_compare() can cause deadlocks on
> systems that generate audit records when the task_lock() is held.  As
> we should be able to safely access current->mm we can drop the call to
> get_task_exe_file() and get a reference to current->mm directly which
> we can then use in a call to get_mm_exe_file() without having to take
> task_lock().
>
> While the audit_exe_compare() function takes an arbitrary task_struct
> parameter, all of the callers outside of fork/clone, call
> audit_exe_compare() to operate on the current task_struct, making it
> the common case.  In the fork/clone case, when audit_exe_compare() is
> called on the child task_struct, it should be safe to use the
> get_task_mm() function as no other task should be holding task_lock()
> at this time.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
> Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/audit_watch.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 65075f1e4ac8..fa3e6ea0e58c 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -526,8 +526,20 @@ int audit_exe_compare(struct task_struct *tsk, struc=
t audit_fsnotify_mark *mark)
>         struct file *exe_file;
>         unsigned long ino;
>         dev_t dev;
> +       struct mm_struct *mm;
>
> -       exe_file =3D get_task_exe_file(tsk);
> +       /* almost always operate on current, exceptions for fork/clone */
> +       if (likely(tsk =3D=3D current)) {
> +               mmget(current->mm);
> +               mm =3D current->mm;
> +       } else {
> +               /* this can deadlock outside the fork/clone usage (see ab=
ove) */
> +               mm =3D get_task_mm(tsk);
> +               if (!mm)
> +                       return 0;
> +       }
> +       exe_file =3D get_mm_exe_file(mm);
> +       mmput(mm);
>         if (!exe_file)
>                 return 0;
>         ino =3D file_inode(exe_file)->i_ino;
> --
> 2.42.0

--=20
paul-moore.com
