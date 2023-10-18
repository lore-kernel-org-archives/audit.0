Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C1CDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJRUDp (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRUDo (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 16:03:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8999DB8
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 13:03:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4574865276.1
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697659422; x=1698264222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4Gxw1C8KcIs53WSGBMfXhJG2TCDEjZFtIERU3MURUA=;
        b=AqLmMTR275PRlL14wlX+zNx219wtGPfi8WCfHcW+xLZAn+nIG8/vjC92WPNZBR8aTo
         LtVu5amlfy9JDhQ6pOaNBkA4D+tf63ig0SNbjkgrPvyDB+zu3p7vPdsFMENZHkVXR8P1
         TCpQuhz5C+oPEimHy7aR59mQHoHldLHaOe9m0Y36rIeympRfUo55r/XfuJShcK/JrNhC
         g0R/GUFj8NR4Ipy6Hd3e62LGLMnX2IXhERVHsUtOOXed6gkJkymx6oMTyFS2WRGJDSVW
         gF2hsOkwNl1oa1riUiTA755NhhSwX7DPGre43joSVhrwmslGHC4UjZU97OUztX1mJZAz
         ACKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659422; x=1698264222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4Gxw1C8KcIs53WSGBMfXhJG2TCDEjZFtIERU3MURUA=;
        b=pzHClLKWEDkHjCvMel84tIx/Umcf8+SibPkabiWG281UbGoq4QYdZuxuq3tfNUbspy
         83b3PNONrrdULWFNlKN8kbXulCQYG8Mk356EppYAl5bY8lOJXa33ZlVVU5WOlbu+Zy7C
         9z/7lnslps6uilIEVY3KXPSAvsltBQxog3IziMl1MJeXZ0yarGxGkdM2dM0EiwlRkKnI
         rgHZ2ny6b6AORDR6EJ1hOP1SqU1ZEBp5BmHCOfeNIM+yyOHLRyrcwOjWrHAG1uOCTDMg
         tFc8q0wu4UDkB/CotrEAYaUdBsNKUQKdZ4DJhmVaje+ExLf/K8r88rYJw15DkebgbHCY
         uf9Q==
X-Gm-Message-State: AOJu0YycCZhmaEXwpjUm4OiGY5I0zAxsSlA1OMfmV6vh35upM3urMxVs
        btkm5ydsr9LKNKL/8FBMfAM9vTpVg3lb3VJjslSR
X-Google-Smtp-Source: AGHT+IG+JHFLaubNRx8yq+mgVsUfH7/oin1xEPgvhRmNHownjZYLVap7Gi16lGJ+fOWv9Oft51bGkuhMW93w8m7l84w=
X-Received: by 2002:a25:abf2:0:b0:d9c:66d1:958f with SMTP id
 v105-20020a25abf2000000b00d9c66d1958fmr391386ybi.55.1697659421574; Wed, 18
 Oct 2023 13:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
 <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
 <6da3d0b6-aaae-4586-bd71-749d6fb38708@canonical.com> <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
In-Reply-To: <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 16:03:29 -0400
Message-ID: <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     John Johansen <john.johansen@canonical.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, Oct 9, 2023 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM John Johansen
> <john.johansen@canonical.com> wrote:
> > On 10/9/23 10:06, Paul Moore wrote:
> > > I don't think anyone is objecting to resolving this, it's more a
> > > matter of *how* we can resolve it.
> >
> > currently I am see four crazy/stupid paths forward, each with their own
> > pain points.

...

> > 4. caching a reference in the audit_context as paul has suggested.
>
> I don't like this idea, but I'm struggling to come up with something
> less awful.  Below is a quick, untested patch to describe the concept
> with code.  It is worth noting that we don't take a mm_struct
> reference in the io_uring entry point because I'm not sure filtering
> on the executable file makes much sense there given the async nature
> of io_uring, however I'm open to comments here (as well as pretty much
> everything else in this pseudo-patch).

Looking at this a bit more, I'm now wondering if there is a fifth
option: call mmget() directly and skip the task_lock().

Take a look at the move_pages(2) code path:

 SYSCALL_DEFINE6(move_pages, ...)
   -> kernel_move_pages(...)
     -> find_mm_struct(...)
       -> mmget(...)

In find_mm_struct(), if the task being manipulated is *not* the
current task then get_task_mm() is called, which takes task_lock().
However, if the task being manipulated *is* the current task then the
task_lock() can be avoided and a direct call to get_mm() is used;
get_mm() does a simple atomic_inc() without any additional locking.

What do you think of this approach (untested, copy-n-pasted patch):

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..ffd17ad97324 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -526,8 +526,19 @@ int audit_exe_compare(struct task_struct *tsk, struct =
audit
_fsnotify_mark *mark)
       struct file *exe_file;
       unsigned long ino;
       dev_t dev;
+       struct mm_struct *mm;

-       exe_file =3D get_task_exe_file(tsk);
+       /* almost always (always?) comparing @current, but handle both case=
s */
+       if (likely(tsk =3D=3D current)) {
+               mmget(current->mm);
+               mm =3D current->mm;
+       } else {
+               mm =3D get_task_mm(tsk);
+               if (!mm)
+                       return 0;
+       }
+       exe_file =3D get_mm_exe_file(mm);
+       mmput(mm);
       if (!exe_file)
               return 0;
       ino =3D file_inode(exe_file)->i_ino;

--
paul-moore.com
