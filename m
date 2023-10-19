Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F592CDB482
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 01:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJSB3U (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 21:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSB3T (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 21:29:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73072EA
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 18:29:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so300107276.0
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 18:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697678956; x=1698283756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEf2lNnacXve83qAkaloNudJOIfzi8pDe0zDfmLilC0=;
        b=gS3TgqIMafMElvOr2Bq5D6088HbSzq3ybNc3GKWe0iIYd4KofmipI3G/zmeA0WmG7H
         uKtAS04lTdBlkoir4mN5c7lNiKl5P8CCrDHJWuLbceujcnFU6M/FjtPVNOb5dglIs+WG
         cU8uiq0yFk2Z//8ILUt3IzTAiu/aYusnXfVcHIgxewmaGxLttj1ZZEx7AqEjJ0qE1Rb1
         sVkAsb3r+1DS9Gz75bX5pRmiC3v/vj/w+Doxf2EvQhgg5ssD85SjU05N/wMhR3jwFAFi
         96H/L+2br6fausbA82vpfekkLfDyRs5vNwfvZoO9BfMAY8gv7kvK4624XIkOWTTFc3+5
         dBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697678956; x=1698283756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEf2lNnacXve83qAkaloNudJOIfzi8pDe0zDfmLilC0=;
        b=PRHHumzepc4slTI4nR+aZQy9RXZcTTIQ5gEIa8xE18ccykFdw6+GefAjfbbRuINypU
         acVGvD6zjWXHGnW/D4VVKc0EkvF8DuUypkDJ1DhB6H0Az8lw+PNw0C2riBXLPIRAY6xA
         ynUwNiCMtlQ7irNuo++OFG3pL/IchTBZnbsNHaXVMvj+LrCVDp/RK1fFaF6lNxmeHd9F
         keig/RgeqA3+TDXdXPy0jsmvLZovMKWIBD2D/JlrtFWCOlpIqiFoLZ9vuv+Z6xdtdVay
         dOG4ElS4UeJNb+JFI9y566oKjYNncE38kd1WAEsCc7hcvtfATILSm2CwAQkA3ngnCF4w
         eclg==
X-Gm-Message-State: AOJu0YxrhOk6IVEQvwrfZzCHZnyEtxZcyF7XJralPukYgDsXFC+FVkcW
        QioS6cP/LC4RWwHCR3ihEhFD9vsemtukjsoF7xSn
X-Google-Smtp-Source: AGHT+IFhqfMN1LAiPtxeWujf849I7Re+5SFlm/ghpu7CbUCv8czg/CkHEc2PmTDgXm+jJ0Um9w/up5d3+K4tblKVh0k=
X-Received: by 2002:a5b:182:0:b0:d9a:c79c:9367 with SMTP id
 r2-20020a5b0182000000b00d9ac79c9367mr1106777ybl.46.1697678956603; Wed, 18 Oct
 2023 18:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
In-Reply-To: <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 21:29:05 -0400
Message-ID: <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 8:22=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> >> The get_task_exe_file() function locks the given task with task_lock()
> >> which when used inside audit_exe_compare() can cause deadlocks on
> >> systems that generate audit records when the task_lock() is held.  As
> >> we should be able to safely access current->mm we can drop the call to
> >> get_task_exe_file() and get a reference to current->mm directly which
> >> we can then use in a call to get_mm_exe_file() without having to take
> >> task_lock().
>
> I don't follow what's the deadlock.
>
> You mean they hold task lock for current and then call into
> audit_exe_compare which takes it again?
>
> I would argue any calls into the routine with *any* task already
> locked are fishy at best (I'm assuming there is an established task
> lock ordering which may be accidentally violated).

A link to the original problem report is below, but the quick summary
is a capable() check in the do_prlimit() code path.

https://lore.kernel.org/audit/668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonica=
l.com

> >> While the audit_exe_compare() function takes an arbitrary task_struct
> >> parameter, all of the callers outside of fork/clone, call
> >> audit_exe_compare() to operate on the current task_struct, making it
> >> the common case.  In the fork/clone case, when audit_exe_compare() is
> >> called on the child task_struct, it should be safe to use the
> >> get_task_mm() function as no other task should be holding task_lock()
> >> at this time.
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare"=
)
> >> Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  kernel/audit_watch.c | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> >> index 65075f1e4ac8..fa3e6ea0e58c 100644
> >> --- a/kernel/audit_watch.c
> >> +++ b/kernel/audit_watch.c
> >> @@ -526,8 +526,20 @@ int audit_exe_compare(struct task_struct *tsk, st=
ruct
> >> audit_fsnotify_mark *mark)
> >>         struct file *exe_file;
> >>         unsigned long ino;
> >>         dev_t dev;
> >> +       struct mm_struct *mm;
> >>
> >> -       exe_file =3D get_task_exe_file(tsk);
> >> +       /* almost always operate on current, exceptions for fork/clone=
 */
> >> +       if (likely(tsk =3D=3D current)) {
> >> +               mmget(current->mm);
> >> +               mm =3D current->mm;
> >> +       } else {
> >> +               /* this can deadlock outside the fork/clone usage (see
> >> above) */
> >> +               mm =3D get_task_mm(tsk);
> >> +               if (!mm)
> >> +                       return 0;
> >> +       }
> >> +       exe_file =3D get_mm_exe_file(mm);
> >> +       mmput(mm);
> >>         if (!exe_file)
> >>                 return 0;
> >>         ino =3D file_inode(exe_file)->i_ino;
>
> Assuming concerns expressed above are moot, I would hide the logic in
> audit_get_task_exe_file or similar.

If there was any other caller I would agree with you, but
audit_exe_compare() is the only place where we need this logic and
considering the size of the function it seems silly to break out the
mm/exe_file logic into a separate function.

--=20
paul-moore.com
