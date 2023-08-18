Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7AFC7115C
	for <audit@archiver.kernel.org>; Fri, 18 Aug 2023 15:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377913AbjHRPAG (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377942AbjHRO7c (ORCPT
        <rfc822;audit@vger.kernel.org>); Fri, 18 Aug 2023 10:59:32 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18897CD
        for <audit@vger.kernel.org>; Fri, 18 Aug 2023 07:59:30 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56ce156bd37so643671eaf.3
        for <audit@vger.kernel.org>; Fri, 18 Aug 2023 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692370769; x=1692975569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3FWbfaq9oYxDMdoSRqO3/ZCBS86gjkbKF54xuC3zVs=;
        b=EtfF3xOq2UX6ghrQ5r6nfgWRwQRKIz8VldriDKs86h4Uzww371L1Hb4H1Z5i1IIaJG
         Mr8B4Tew0Rlx8SJJ3GPXOB79IxkZqfxvdrdkgMudGBfo18HyLemqchqS/ppqBgvuZwIU
         PNFQGjzRdHJ77ovcJXWucPNNKN+sjjjESlbVc2LOnAdLoL5VwAmcPNJJRz4t5N2CufaU
         iuHdgpphL2rvFDXIZ9VOADQJtEHA1FXUS5CH81tF2P42ygVwb3M6iMCk8tuSI0gNyUf2
         Y/HHryIB3HNjOct3lFb2rjNlbZN6RwKNQVWUrfyEZ2Oi90XuNVHQ0z1aJ8BpGL2+B+2f
         Bo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370769; x=1692975569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3FWbfaq9oYxDMdoSRqO3/ZCBS86gjkbKF54xuC3zVs=;
        b=Vc1GJcy0o+IzcKiQnJ07Eqt2RxFiiXxsP4mtFNvaBQ09HZR+SgVNzOwimR9cO9L/95
         X3VeVxkq+M7d6NuFy5sORaQ3SqbF2ABdRhlQFKniE4p6pwShtskCPPNW/fGEaZh/zKTD
         Ejz5esrTC85NEc/ahzSQMuOs2ejrqVYvpdgtkS5gEaI/KzhhkLtuiuTyGkfkJj8x2zfV
         +unb+cfXz7iHkXxCgLSEqpP6aWbR62WyKghdy2epCrWTqhxlEKZ5p1K8kRDCjLR4P1y7
         +8lv1WgrBwHE8vGEJ9j8EFUgm365+yRpbGAKqISanfqZdY66siYViYPqX4vFptM1bCbB
         HnDg==
X-Gm-Message-State: AOJu0YyZLY0M/0AvNWSSoOBwA79ntgQjQTwk+GQdVSY1eGKWJimw9wnE
        ORY2JX8VL8h9B0ILsLXU6EzbssjaydtfCmBgrXum
X-Google-Smtp-Source: AGHT+IFu1PEVIIyQi5YbuVUSDUoupB9Osv+vX2oO+RpB4setRkl+Jp9v7ufQDzVf/0yw9cbQmvv/7Xb8o/3w9ZNNk68=
X-Received: by 2002:a05:6358:2791:b0:12b:da97:aba6 with SMTP id
 l17-20020a056358279100b0012bda97aba6mr2728127rwb.24.1692370769230; Fri, 18
 Aug 2023 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com> <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
In-Reply-To: <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Aug 2023 10:59:18 -0400
Message-ID: <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Aug 18, 2023 at 6:30=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/16 22:53, Paul Moore wrote:
> > On Wed, Aug 16, 2023 at 6:10=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2023/08/16 3:44, Paul Moore wrote:
> >>> On Fri, Aug 11, 2023 at 6:58=E2=80=AFAM Tetsuo Handa
> >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>>
> >>>> When an unexpected system event occurs, the administrator may want t=
o
> >>>> identify which application triggered the event. For example, unexpec=
ted
> >>>> process termination is still a real concern enough to write articles
> >>>> like https://access.redhat.com/solutions/165993 .
> >>>>
> >>>> This patch adds a record which emits TOMOYO-like task history inform=
ation
> >>>> into the audit logs for better understanding of unexpected system ev=
ents.
> >>>>
> >>>>   type=3DUNKNOWN[1340] msg=3Daudit(1691750738.271:108): history=3D"n=
ame=3Dswapper/0;pid=3D1;start=3D20230811194329=3D>name=3Dinit;pid=3D1;start=
=3D20230811194343=3D>name=3Dsystemd;pid=3D1;start=3D20230811194439=3D>name=
=3Dsshd;pid=3D3660;start=3D20230811104504=3D>name=3Dsshd;pid=3D3767;start=
=3D20230811104535"
> >>>
> >>> While I respect your persistence, we've talked about this quite a bit
> >>> already in other threads.  What you are trying to do is already
> >>> possible with audit
> >>
> >> How?
> >
> > If you configure audit to record exec() and friends you should have a
> > proper history of the processes started on the system.
>
> That is a "No LSM modules other than SELinux is needed because SELinux ca=
n do
> everything" assertion.

Except we are not talking SELinux or LSMs here, we are talking about
audit and the audit subsystem is very different from the LSM layer.
The LSM layer is designed to be pluggable with support for multiple
individual LSMs, whereas the audit subsystem is designed to support a
single audit implementation.  It is my opinion that the audit patch
you have proposed here does not provide an audit administrator with
any new capabilities that they do not currently have as an option.

There are also concerns around field formatting, record length, etc.,
but those are secondary issues compared to the more important issue of
redundant functionality.

> People propose different approaches/implementations because
> they can't afford utilizing/configuring existing approaches/implementatio=
ns.

From what I've seen, both in this thread as well as the other related
threads from you, these recent efforts are due to a lack of TOMOYO
support in mainstream Linux distributions.  My advice is to stop
trying to duplicate the TOMOYO functionality in other subsystems/LSMs
and start working with the distributions to better understand why they
are not supporting TOMOYO.  I believe that if you can determine why
the distributions are not enabling TOMOYO, you should be able to
develop a plan to address those issues and eventually gain
distribution support for TOMOYO.  I understand that such an approach
will likely be time consuming and difficult, but I think that is your
best option for success.

> Your assertion is a fatal problem for merging "Re: [PATCH v13 00/11] LSM:=
 Three basic syscalls"
> at https://lkml.kernel.org/r/CAHC9VhQ4ttkSLTBCrXNZSBR1FP9UZ_gUHmo0BS37LCd=
yBmUeyA@mail.gmail.com .
>
> Please please allow LSM modules like https://lkml.kernel.org/r/41d03271-f=
f8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp
> to obtain a stable LSM ID

We've already discussed that in the TaskTracker thread.

> if you don't want to support something that possibly have an alternative.

We've already upstreamed an alternative approach to TaskTracker: TOMOYO.

--=20
paul-moore.com
