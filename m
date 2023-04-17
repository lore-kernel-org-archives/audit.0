Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF6C77B72
	for <audit@archiver.kernel.org>; Mon, 17 Apr 2023 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDQU1z (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDQU1x (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 17 Apr 2023 16:27:53 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBF422E
        for <audit@vger.kernel.org>; Mon, 17 Apr 2023 13:27:50 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so117604797b3.3
        for <audit@vger.kernel.org>; Mon, 17 Apr 2023 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681763270; x=1684355270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=603fxDNgME8lltID5rMAJWB1Mm6APJZHsFnhCBG8aPk=;
        b=TpC1Yp40ASMzRicb+mYwlYcdOXge/c6zxTt66I9F/TrkF1Nb5qc+5PXf6tZ4JwJLGt
         sPJ6ELltZNTucWg42/w1+480QGznbJTSKHtdcFhtqjT1Nx51KAtaRZ2Q3KAfdlnTqCaX
         TD58c2DoyXKs9wQj+tzbGpnFMun0JxUYGLfEMFm0y7VMd7W6OF1IO9/VIsTDeqN0NTJR
         ybaSNg1Mo+fQFzoGZnG13TAJBFW7/qTf17W11SOlbLExXK1CvTYOWDEEABQxjl0Ebs3t
         59IV5uX4woIO03S/kLyHxH97CAzCHl3IEjJAEuq5wNaSBKDIxKL/j3uERt5g4wCc2HA7
         y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763270; x=1684355270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=603fxDNgME8lltID5rMAJWB1Mm6APJZHsFnhCBG8aPk=;
        b=RA7XX+l8h+W/v7dEGUFSZUZC/WrJq2mdj0B+37bP7+tZ//2wiWVvWLfxjH62rboTt2
         /PNCZO/+0Q3CU76TYMICO1GmqvApu6011IMo/WxAO/dXC2EkQTsMu6pKBi7uKBLEwO75
         xozoMT6tYN0v1SIMhGPoKaXQSJkulNw8eloK5B3TM23tebzlvyKEw2bVlmZcxAcc4kko
         pk3T6ppn3LqV36Q26Whv6mQBsbwjOlYcdz985Pvyq7hBbmdCfh2alnIiWPHEJ06W3heO
         oIOzcqI/Anc8O6M7i614O7lLprYes3KB7voVXH4ryqaf+7/grQ9WTsEtMlS5+5IBQkBN
         RxDg==
X-Gm-Message-State: AAQBX9cYOptVSXPSYVo2Rjr9dgAZwx5SsPm+HibEokYhdP7gswdTliwC
        hQBs7FiUUNTHpoph8h5rkdBijKFLvvGMMDdqbEwF
X-Google-Smtp-Source: AKy350YrsqLYcx0ksF4fyEYq6/LoWTcdjMTVb2/aVsuPGVhAikaasV2Qdj6tHUzjQKIU1g0pUalli+i4tN181CGCFVg=
X-Received: by 2002:a81:ed06:0:b0:54f:bf72:7fa6 with SMTP id
 k6-20020a81ed06000000b0054fbf727fa6mr10335523ywm.0.1681763269741; Mon, 17 Apr
 2023 13:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com> <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
In-Reply-To: <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Apr 2023 16:27:39 -0400
Message-ID: <CAHC9VhTRXwrKkXMFJNiVgZbV=ZHExHa2VhBo6DKPEKZ8xcS=iw@mail.gmail.com>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, Apr 17, 2023 at 7:42=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On Apr 14, 2023, at 23:44, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Apr 13, 2023 at 11:14=E2=80=AFPM Eiichi Tsukata
> > <eiichi.tsukata@nutanix.com> wrote:
> >>
> >> auditd_test_task() is a hot path of system call auditing. This patch
> >> introduces a new bit field "is_auditd" in pid struct which can be used
> >> for faster check of registered audit daemon.
> >>
> >> Benchmark
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Run the following command:
> >>
> >>  dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
> >>
> >> With rule:
> >>
> >>  -a never,exit -F arch=3Db64 -S uname
> >>
> >> Result:
> >>
> >>  Base line    : 2.572 sec
> >>  /w this patch: 2.412 sec (6.6% faster)
> >>
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> include/linux/pid.h |  4 ++++
> >> kernel/audit.c      | 22 ++--------------------
> >> kernel/audit.h      |  3 ++-
> >> kernel/pid.c        |  3 +++
> >> 4 files changed, 11 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/include/linux/pid.h b/include/linux/pid.h
> >> index 343abf22092e..5fe38e254c9a 100644
> >> --- a/include/linux/pid.h
> >> +++ b/include/linux/pid.h
> >> @@ -68,6 +68,10 @@ struct pid
> >>        wait_queue_head_t wait_pidfd;
> >>        struct rcu_head rcu;
> >>        struct upid numbers[1];
> >> +#ifdef CONFIG_AUDIT
> >> +       /* registered audit daemon tgid */
> >> +       unsigned is_auditd:1;
> >> +#endif
> >> };
> >
> > Thank you for the patch, but I don't think we want to add an audit
> > specific field to the pid struct at this time.
> >
>
> Hi Paul
>
> I agree =E2=80=9Cis_auditd=E2=80=9D is too specific.
>
> How about having global =E2=80=9Cauditd_pid=E2=80=9D struct pid pointer a=
nd let auditd_test_task() use it?
> I mean:
> #define auditd_test_task(tsk) (READ_ONCE(auditd_pid) =3D=3D task_tgid(tsk=
))

At this point in time I prefer to keep the auditd pid in the
auditd_connection struct.

> By the way, it=E2=80=99s a bit different topic,  I may have found a race =
in usage of auditd_pid_vnr().
>  In AUDIT_SET handling, the variable auditd_pid is referenced outside of =
the spinlock so it can be changed while it=E2=80=99s referenced.
> So there is a TOCTOU race like this:
>
> CPU0                                        CPU1
> =3D=3D=3D=3D=3D                                       =3D=3D=3D=3D=3D
> auditd =3D auditd_pid_vnr()
>                                                   auditd =3D auditd_pid_v=
nr()
> if (auditd_pid) {=E2=80=A6}
>                                                   if (auditd_pid) {=E2=80=
=A6}
> auditd_set()
>                                                   auditd_set()
>
>
>
> If auditd_pid_vnr() returns 0, this case can lead to replacement of a hea=
lthy auditd, which seems to be prohibited judging from the code comment "/*=
 replacing a healthy auditd is not allowed */=E2=80=9C.
>
> Please correct me if I=E2=80=99m wrong.

Simultaneous AUDIT_SET operations are prevented by the
audit_cmd_mutex/audit_ctl_lock(), see audit_receive().

--=20
paul-moore.com
