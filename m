Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B35C04E69
	for <audit@archiver.kernel.org>; Wed, 16 Aug 2023 13:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbjHPNyn (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbjHPNyM (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 16 Aug 2023 09:54:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE426B2
        for <audit@vger.kernel.org>; Wed, 16 Aug 2023 06:54:10 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58cbdf3eecaso6301517b3.0
        for <audit@vger.kernel.org>; Wed, 16 Aug 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692194049; x=1692798849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P8KQwRllSmi1NLwh9WWVFV2msAXlqeZx1gKCUEZWtc=;
        b=JNrdbub9jg3Rd1vE3Bi1EL+JyaxsfJTWgtAMd6rGkYTORXWJFutZk4/9puhZDee38s
         n17s1s6D2goi/JaT+FfDJko/LB6+OGmaGs3/tkJzaQajFx0qTcoMcY09nJQUL8vpmF70
         EuWgt1a98NXZBSQbsOSmPZC6dHo2gBvuD6b7tMH/qrE+kvumyoqgGotBLVzTl79DTf8R
         qGu5DOa02at1cXJUELd3D5qrv8AlJ/+e/9WnwyAw9CaBzeSb2pe/p6MoU/mvzDH2G3cB
         wbZ5CWEtzCfQsIJBfgl1IV+y9PyRQo5hfvX0NtVMEsR+auaafKKPo7TJooYpFjL6myUg
         0asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692194049; x=1692798849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P8KQwRllSmi1NLwh9WWVFV2msAXlqeZx1gKCUEZWtc=;
        b=JI2dlnE1Ea2+ukAfMTMnVReO6eWaOqyTgXypxsS6VYvhMZ5zqTPcsv7RDiVK9lpWk1
         YCLoLoRDoCAhq1mbIsfAsSt9A1oz9NEPjNXbOQ8PNBHw+t6OIIGCIRMmLPnQwodlYmi4
         TohBxnvF2KeBne88w6S+YGcfNiARFLKwHviAztJEPsO5Zs7Kg/1OJjMtfIt2QUOkPZST
         1yLdxFOA4mpzvg7oz1pv8PDIYs+JUwDGwhHbZcmEWX9Xkn4vWITh9j692B+j82iCACM+
         dIIsBsQL+7ybN7U0xK8rZHcb9lfKM6CL+tl4LoH3cnoVBXPv2QcTb4/aAVmoANOtqcXJ
         JodQ==
X-Gm-Message-State: AOJu0YwV1MSBWkXOmBvJqB0v3QLwPdASEHhTVCnFBar2ThadmgE6IOBZ
        ruRZaoZNj8KgYSnGJn7xBT0AMZf6AnyRUm6kFATm
X-Google-Smtp-Source: AGHT+IHB1ZhaV7FF5rurwVNAWtXSYkk01yX3izFX2omlCKCDMCSWprsPXt5C353QVqz40iBGAzxYwAswjfz2m7BehsA=
X-Received: by 2002:a81:4e0c:0:b0:58c:4fbb:1bb7 with SMTP id
 c12-20020a814e0c000000b0058c4fbb1bb7mr1465119ywb.5.1692194049253; Wed, 16 Aug
 2023 06:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com> <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
In-Reply-To: <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Aug 2023 09:53:58 -0400
Message-ID: <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Aug 16, 2023 at 6:10=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/16 3:44, Paul Moore wrote:
> > On Fri, Aug 11, 2023 at 6:58=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> When an unexpected system event occurs, the administrator may want to
> >> identify which application triggered the event. For example, unexpecte=
d
> >> process termination is still a real concern enough to write articles
> >> like https://access.redhat.com/solutions/165993 .
> >>
> >> This patch adds a record which emits TOMOYO-like task history informat=
ion
> >> into the audit logs for better understanding of unexpected system even=
ts.
> >>
> >>   type=3DUNKNOWN[1340] msg=3Daudit(1691750738.271:108): history=3D"nam=
e=3Dswapper/0;pid=3D1;start=3D20230811194329=3D>name=3Dinit;pid=3D1;start=
=3D20230811194343=3D>name=3Dsystemd;pid=3D1;start=3D20230811194439=3D>name=
=3Dsshd;pid=3D3660;start=3D20230811104504=3D>name=3Dsshd;pid=3D3767;start=
=3D20230811104535"
> >
> > While I respect your persistence, we've talked about this quite a bit
> > already in other threads.  What you are trying to do is already
> > possible with audit
>
> How?

If you configure audit to record exec() and friends you should have a
proper history of the processes started on the system.

> >                     and/or TOMOYO enabled and configured
>
> Wrong. Since not all LSM hooks allow sleeping, TOMOYO is unable to
> check sending signals. Also, TOMOYO is not using audit interface.

I said "audit and/or TOMOYO"; I believe the "and/or" is important.  If
I recall correctly, and perhaps I misunderstood you, you conceded that
a combination of audit *and/or* TOMOYO would solve this issue.

> >                                                          so I see no
> > reason why we want to merge this.
>
> This code makes it possible to record sending signals with TOMOYO-like co=
ntext,
> and we can avoid assigning LSM ID for this code if we can merge this code=
 as
> a part of audit.

If you want TOMOYO-like information, run TOMOYO.  If your preferred
distribution doesn't support TOMOYO, you need to either ask them to
support it, find a new distribution that does, or build your own
kernel.

> >                                    I understand your frustration that
> > TOMOYO is not enabled by your prefered distribution, but adding
> > additional (and arguably redundant code) code to the upstream kernel
> > is not a solution I am willing to support and maintain long term.
>
> Never a redundant code. Absolutely no reason we don't want to merge.

At this point in time, I obviously disagree.

> The only choice is which approach (a standalone LSM module or a part of a=
udit)
> to go. Casey suggests this code as a part of audit. You must persuade Cas=
ey
> if you don't want this code as a part of audit.

To be very clear, it isn't my duty to persuade Casey about anything
(although if you've followed the LSM stacking saga you know I've
definitely tried on occasion! <g>).  My role here is to maintain the
audit subsystem and LSM layer (along with others which aren't relevant
here) to the best of my ability.  A big part of that is ensuring we
make "smart decisions" with respect to what code we merge as things
like new LSMs and new audit records are things that we have to support
*forever*.  Because of this rather extreme support burden I need to
make sure that we aren't making our jobs (current developers, current
maintainers, and those that will follow us) more difficult than
absolutely necessary.  From my current perspective, the benefits of
this patch, both in terms of unique functionality and durability of
the design/code, are not enough to outweigh the support burden.

--=20
paul-moore.com
