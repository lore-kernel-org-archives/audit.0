Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA14E9413B
	for <audit@archiver.kernel.org>; Sat,  7 Oct 2023 00:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjJGAHh (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 6 Oct 2023 20:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJGAHh (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 6 Oct 2023 20:07:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD7BD
        for <audit@vger.kernel.org>; Fri,  6 Oct 2023 17:07:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so3039596276.2
        for <audit@vger.kernel.org>; Fri, 06 Oct 2023 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696637255; x=1697242055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHD+x7Oh+0e4y3jkxNsQUc1AqCuOyOBHea4bJSZQ5Jc=;
        b=QdTmXTj9GkRqPDqGd9OHXbWCnHpAbaEkvId78QvuecWo79DhoWOFYGOZY4dBlS46to
         3LBrKannIf4DREUSzq9E7e6scnPzfqYBOBEIYF//eu/8RpDk1fH1ms7eAxyp0rH/EZfi
         nGU7I7ixpiCKJ+syfTQk2I/K7TUMJF7nmJRKKqMvIO1arotT+8iJ2mbEQ0Y7r9T1PIct
         IVo3c/6XAQQ3CIJ6b9NYRYmNpmMVfP22teZndtiCJ0RbKKoK4w8oCPh5OHKxAsb7ObRd
         OBopPI6jNlpxxzPg86rO1HGBstS6Hyy9MpEfxxyPGzcoo6LoVOs1A4BK4ZKx+bIS+0IU
         cDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696637255; x=1697242055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHD+x7Oh+0e4y3jkxNsQUc1AqCuOyOBHea4bJSZQ5Jc=;
        b=i92kWBF4WXTWU3Aj1QSK2ptPKw32hr022Qq5rUGCUPMAKMVdcPxcnC07YwEti1Qqu6
         IuClLv3tcbhggIeDZzBfWueCllbFgX5i92tU/zCi7xt3/rNXePKGchNEwl70JEZw7RnG
         Ztj8dygY8Wqi94CQXXx6BVrjcTv5bOnuL73oyjfsRy9zJ3aV9BvzVi143IxqzwpwV76/
         h0EddEf32DcdagaLkpQz+KHAAEukhGEwmRzvp4no4LDLtWbM2iVyYsiePIfZjgkVI5vm
         L0sHhIkD9yMy8P4woqagsAjqLBfbZalAmx7tPfXUrzdK4/MylfPpiuf0myG79edaGXuA
         QIzA==
X-Gm-Message-State: AOJu0YwEOFOPbTUltuOToYps6pBV/Uxa1ksNlMtzVqlO06bVhv5aVy66
        iUD0g+4p6XoD2qiURmNmm25gtZnZYH4fco3p/aOB
X-Google-Smtp-Source: AGHT+IGMbcbhKR5JWKZAHYDpunJnIyLxNHlcgtMmlQpupe+9la3RMBig2mWSjPeHiH2RjFQs83sxugLVXPbrudQtIXk=
X-Received: by 2002:a25:1502:0:b0:d81:5d5a:25a3 with SMTP id
 2-20020a251502000000b00d815d5a25a3mr8294959ybv.43.1696637254733; Fri, 06 Oct
 2023 17:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com>
In-Reply-To: <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Oct 2023 20:07:23 -0400
Message-ID: <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     John Johansen <john.johansen@canonical.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Sep 27, 2023 at 8:20=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> adding paul and the audit list
>
> On 9/26/23 05:56, Andreas Steinmetz wrote:
> > Hi,
> > it happen from time to time while setting up AppArmor properly that
> > instead of creating an audit message AppArmor locks up the system. In
> > most cases I couldn't even get any information, but this time I got
> > some.
> > I don't yet know if this is the case here but in case of "systemd
> > --user" it was a missing grant of cap_sys_resource that caused the
> > lockup. I don't know the exact capability causing the below problem
> > but granting cap_sys_admin, cap_setuid, cap_setgid and
> > cap_sys_resource prevents the lockup so it is definitely capability
> > related. dmesg output follows. Kernel is 6.5.3, distro is Arch Linux.
> >
>
> just to double check, you are using auditd and have some audit filters
> loaded, the code trace indicates yes.
>
> so at a first pass it appears this come when the task calls prlimit64,
> the capability check is denied and apparmor (or really any lsm).
> generates an audit message. The audit message goes into the audit
> subsystems, and there an exe filter which tries to get the task_exe_file
> resulting in deadlock.
>
> do_prlimit()
>         task_lock(tsk->group_leader);
>             ...
>                         if (new_rlim->rlim_max > rlim->rlim_max &&
>                                 !capable(CAP_SYS_RESOURCE))
>                                         ...
>                                         case AUDIT_EXE:
>                                                 result =3D audit_exe_comp=
are(current, e->rule.exe)
>                                                         ...
>                                                         struct file *get_=
task_exe_file(struct task_struct *task)
>                                                                 ...
>                                                                 task_lock=
(task);
>                                                                 ...
>             ...
>         task_unlock(tsk->group_leader);
>
>
> I am not sure how best to handle this.

My apologies for the delay in responding, unfortunately this email was
a bit buried in my inbox and it took me a while to get to it.

Unfortunately, like John, I'm struggling a bit to see how we might
resolve this.  Unfortunately, we don't always know the context in
which audit_filter() is going to be called; in some cases we would
need to ensure the task_lock() was held, in others we may already be
holding it on the current CPU.  The only thing I'm reasonably certain
about is that audit_exe_compare() can't safely use
get_task_exe_file().

I imagine we could think about grabbing a reference to the mm_struct
and stashing it in the audit_context so that we could access
mm_struct::exe_file with only a RCU lock, but then we have to manage
the mm_struct reference in audit_context and I worry that will be ugly
and/or expensive (likely "and").

Does anyone else have any bright ideas or crazy thoughts on this?

--=20
paul-moore.com
