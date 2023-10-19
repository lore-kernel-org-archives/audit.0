Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD4CDB465
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 18:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjJSSQN (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 19 Oct 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjJSSQM (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 19 Oct 2023 14:16:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEF11D
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 11:16:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ac9573274so993276.0
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697739369; x=1698344169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYU+Z1wsspB+GuefAjS7QTismwqcWDHJyOtJm2b4+Ks=;
        b=fjEmPuMzL8bMUO0nRTBrdp/icdS72h3INxu2SkiDftHPYPEnHG58N5ofefgTURVsGM
         Gwx7G0ctfbxlF6IQ7cFgmBaP5voKOIGTW2J7jy76H1UH71SBhAPXfyv55AxZJHGS5hor
         OldYaIcGODaUAaLTyQ/PDC6kfbH7zoU5VDBGF6+fgXFR1kmn1zHwmN3li2oUCkm2Qzrv
         m0zhFsRMK6B6y8X7+hVBGSeB6n5mjYSF2IfQTR+WETtoncoa3LSQe3YFwt5sUncKK+Ia
         CjSaYa+wwxmoT4aZioqWqelOeEBW4iE27Vd73zm83iaKh7exIgrODaMKkqj5cbIkPAMP
         XKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739369; x=1698344169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYU+Z1wsspB+GuefAjS7QTismwqcWDHJyOtJm2b4+Ks=;
        b=pspNtzXONvnudqfRsEayy8CCFMbtH/kyWXHsYmCr9G+ydSeVlpN0A3H9y9K68SrZ1H
         7iUE5aJQl0j+ymM3D1izFbRDqDp+aQSDA6MidtIjWTnudhcCT8ZSSMkk28cAVkicbCTF
         Cs91MwvB+mXhTKOvXBNGPXdVVqbtCV8aga9gXrc3dTJ8IsQz55IQcp4sH7U2xRcMV1rb
         d9OB3+iUXigpsuk+A9R8M+KMB3+Po0SICFvIxBjhikAAx4wQqzWcw2uMpVdbptM/o7z4
         xCEAcX9/EFM+ggSfogXLZqrY/HSAYz2eWaQGFJy6xoXVo1QvOJQYjW9sy1X8xIzLITMq
         iJmw==
X-Gm-Message-State: AOJu0YwnlXBZi4xyIdRzDk2gIHw+W+m/perTv27rc1hkYiP/WgNXIBw5
        60w1jSr+Bnt9NHnw0BW9WqWDbAbBaZtUTYpHRQeyOxqSdFtHwVo=
X-Google-Smtp-Source: AGHT+IEMdItHHpJPhVFRFc4WTGbWjuUky0FO2xEQQoNnCj6j19hY/FMQpV6QlVY6EDfEEtTvaau1/Afnos2jH4lz6xE=
X-Received: by 2002:a25:40d6:0:b0:d9a:e397:3b4 with SMTP id
 n205-20020a2540d6000000b00d9ae39703b4mr3010404yba.46.1697739369370; Thu, 19
 Oct 2023 11:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
 <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
 <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
 <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com> <CAGudoHH5R_zNf0uLPSB+_o0N8bU2g29L6Nrz8Yo-KhG2Vot_ew@mail.gmail.com>
In-Reply-To: <CAGudoHH5R_zNf0uLPSB+_o0N8bU2g29L6Nrz8Yo-KhG2Vot_ew@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Oct 2023 14:15:58 -0400
Message-ID: <CAHC9VhQy6w6=ndC-8nY+tjM_A3bfGFoeDqViaxeFokH0FF4XdQ@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Oct 19, 2023 at 12:56=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Oct 19, 2023 at 10:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> >> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> >> > Thinking about it a bit more this morning, I think we can safely
> >> > ignore the non-@current case in audit_exe_compare() as the whole poi=
nt
> >> > of the audit exe filter is to record the actions of processes
> >> > instantiated from that executable file; if the @current task is not
> >> > being logged/filtered, we shouldn't have to worry about the exe
> >> > filter.
> >>
> >> I did a quick stab at figuring out whether one can get there with
> >> non-current to begin with, but did not convince myself it is not
> >> possible.
> >>
> >> That said, should you repost, I think refing and unrefing mm should be=
 a
> >> voided.
> >
> > We have to deref current->mm to get the exe_file, but so long as we
> > get a reference with mmget()/mmput() it should be safe, no?
>
> For task =3D=3D current the very condition which allows you to safely
> mmget also makes the operation redundant -- current already has a ref
> on mm for as long as it executes.

I've been using the move_pages(2) syscall code as an example and in
the find_mm_struct() function the code either does a mmget() if
accessing current->mm or a get_task_mm() if accessing an arbitrary
task.

  -> SYSCALL_DEFINE6(move_pages, ...)
    -> kernel_move_pages(...)
      -> find_mm_struct(...)

What am I missing?

> >> The bug showed up with 18c91bb2d87268d23868bf13508f5bc9cf04e89a
> >> ("prlimit: do not grab the tasklist_lock") which converted that lock
> >> to task_lock. So I don't think pointing at my patch as "Fixes" is
> >> accurate, but I'm not going to insist. ;)
> >
> > Hmm, 18c91bb2d872 doesn't look like it adds a call to task_lock(), did
> > you copy-n-past the wrong commit or am I missing something?  From what
> > I can see, the task_lock() was first introduced back in 2009 with
> > 86f162f4c75c ("rlimits: do security check under task_lock").
> >
>
> Huh. That's some brainfarting by me, indeed with this in place it is
> my commit which regresses.

No worries, thanks for the confirmation.

--=20
paul-moore.com
