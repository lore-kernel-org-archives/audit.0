Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BAFCDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 20:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjJRUvA (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRUu7 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 16:50:59 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC55111
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 13:50:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d84c24a810dso8474004276.2
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697662256; x=1698267056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN6f1Ml7961JRQwvUIDIpjC4WOraH1mCSiOZgezmG1w=;
        b=SKmtbmeGcCiaZt9+EpHYteYKBca3GveGEShayNINlKFY1tWeqHC8N6bfLJEitkhtOi
         UfTpcNKr0PBPz01NH9Ped9w7AZw1RP6dpbdMKxuSmbPt17BHp7erbUCcpbmyHxVrmY4+
         QoBQ3gJMuRs1InFMSA6iozF9f7HAEA7sQ7Y/AzU5zHT0i3t1vqKWFliSEvs9TIfdVESP
         orFv7Qv8lSfms8YaTxgiBMrPV/JY9AVoQZ4SuQDu7fCY0WgOkWWHjlkWAWCp71SiF9SJ
         XyxPO0WQ3Qz2isfTQbm8jyJJZwxLeV4mERxupAU/mGSrN/tmDbGo13rtMvKVfjYPwKUM
         NqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662256; x=1698267056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN6f1Ml7961JRQwvUIDIpjC4WOraH1mCSiOZgezmG1w=;
        b=o3CE6wfnCSGzek/rmnEUj4EAIWq6l1YOxg1Y3dwL8l53om2J6FE912H6WwK0k8ASi1
         LWRYZeFvIu/SYCWsQdDQdixQRSwPzbaQ4xAAGLL0oiMJ67eLOAaphOQjOHuIvCMfYFSb
         Bl6bSm/Dc8kkzj24M0DgSMFIKJhbNL44gfJwe92i8FiPBjM4h1dqHUQnlGAIh9GbZHch
         bLjddZIr/RhKTd57JXCQHeWhHIYp19iZg2CmemuvgiePIuwsQDihYhY0lHzGmPnq0Jmu
         n+s+p1o3Z0zqNFkNz8a3kpkuUULg4KVFMmweYKenEFlySlSbvOCSzWG+XV0s5BDwIvzX
         UHXg==
X-Gm-Message-State: AOJu0YyXGWCoeughWE9oGLgkTVO8DulZwRsdF2ICeqUlWwgqhW8TNqHR
        NmUofkNLFVPMt++uMTGuK/hiRGPh2QRV7yaO0k//
X-Google-Smtp-Source: AGHT+IG3PJnwxGdeZMAqqvIUieMyj7asoX9P3m88scMV3ga8Q6/nF1ZoYSHGn3OqTzUWhVrUfJ1uIPJiHVos7jK9X2I=
X-Received: by 2002:a25:818e:0:b0:d77:e338:1b6b with SMTP id
 p14-20020a25818e000000b00d77e3381b6bmr567749ybk.14.1697662255939; Wed, 18 Oct
 2023 13:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
 <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
 <6da3d0b6-aaae-4586-bd71-749d6fb38708@canonical.com> <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
 <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com> <740fe39c-dab5-4ec9-b717-f5168e689985@canonical.com>
In-Reply-To: <740fe39c-dab5-4ec9-b717-f5168e689985@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 16:50:45 -0400
Message-ID: <CAHC9VhQTbTkQzCdicPtj7WfEhJgmkX=zxPNu9cGVmHhbbzBzcg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     John Johansen <john.johansen@canonical.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Oct 18, 2023 at 4:34=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 10/18/23 13:03, Paul Moore wrote:
> > On Mon, Oct 9, 2023 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >> On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM John Johansen
> >> <john.johansen@canonical.com> wrote:
> >>> On 10/9/23 10:06, Paul Moore wrote:
> >>>> I don't think anyone is objecting to resolving this, it's more a
> >>>> matter of *how* we can resolve it.
> >>>
> >>> currently I am see four crazy/stupid paths forward, each with their o=
wn
> >>> pain points.
> >
> > ...
> >
> >>> 4. caching a reference in the audit_context as paul has suggested.
> >>
> >> I don't like this idea, but I'm struggling to come up with something
> >> less awful.  Below is a quick, untested patch to describe the concept
> >> with code.  It is worth noting that we don't take a mm_struct
> >> reference in the io_uring entry point because I'm not sure filtering
> >> on the executable file makes much sense there given the async nature
> >> of io_uring, however I'm open to comments here (as well as pretty much
> >> everything else in this pseudo-patch).
> >
> > Looking at this a bit more, I'm now wondering if there is a fifth
> > option: call mmget() directly and skip the task_lock().
> >
> > Take a look at the move_pages(2) code path:
> >
> >   SYSCALL_DEFINE6(move_pages, ...)
> >     -> kernel_move_pages(...)
> >       -> find_mm_struct(...)
> >         -> mmget(...)
> >
> > In find_mm_struct(), if the task being manipulated is *not* the
> > current task then get_task_mm() is called, which takes task_lock().
> > However, if the task being manipulated *is* the current task then the
> > task_lock() can be avoided and a direct call to get_mm() is used;
> > get_mm() does a simple atomic_inc() without any additional locking.
> >
> > What do you think of this approach (untested, copy-n-pasted patch):
> >
> hrmmm, I like the idea but the task !=3D current path still suffers from
> the issue. If we can verify this case never happens great, otherwise
> we either bail on that case or still need to come up with an
> alternative.

It shouldn't, the only time we ever really operate on something other
than @current is when a fork/clone happens and we are filtering on the
new child process.  At least that used to be the case, I can't imagine
someone would audit something other than @current (not sure you could
with respect to this stuff?), but I guess it couldn't hurt to double
check on the current code base.

> otherwise it looks good

It just passed through the audit and SELinux test suites without
problem, so I'm hopeful this might be a viable solution.

> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> > index 65075f1e4ac8..ffd17ad97324 100644
> > --- a/kernel/audit_watch.c
> > +++ b/kernel/audit_watch.c
> > @@ -526,8 +526,19 @@ int audit_exe_compare(struct task_struct *tsk, str=
uct audit
> > _fsnotify_mark *mark)
> >         struct file *exe_file;
> >         unsigned long ino;
> >         dev_t dev;
> > +       struct mm_struct *mm;
> >
> > -       exe_file =3D get_task_exe_file(tsk);
> > +       /* almost always (always?) comparing @current, but handle both =
cases */
> > +       if (likely(tsk =3D=3D current)) {
> > +               mmget(current->mm);
> > +               mm =3D current->mm;
> > +       } else {
> > +               mm =3D get_task_mm(tsk);
> > +               if (!mm)
> > +                       return 0;
> > +       }
> > +       exe_file =3D get_mm_exe_file(mm);> +       mmput(mm);
> >         if (!exe_file)
> >                 return 0;
> >         ino =3D file_inode(exe_file)->i_ino;
> >
> > --
> > paul-moore.com

--=20
paul-moore.com
