Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD2C71153
	for <audit@archiver.kernel.org>; Thu, 24 Aug 2023 17:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbjHXRCr (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbjHXRCm (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 24 Aug 2023 13:02:42 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94710F9
        for <audit@vger.kernel.org>; Thu, 24 Aug 2023 10:02:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59254e181a2so1303087b3.1
        for <audit@vger.kernel.org>; Thu, 24 Aug 2023 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692896559; x=1693501359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTyH2Pa733qbbxMfLrK7WffNUetmNfwdk8lCtzoIDPM=;
        b=LzDvLRBerCdV9K0GlHWizCeUKEBdmugt9+25FzjJ7X1sX9gBZnKMb4JQNt/3v6rGeW
         rkhgRQkfUMbChkxLC7A6jN2rABhx3/mD8/cxJLM6jBDAlm/878tUCUBUlBknJ7OjPpHV
         ITclaTkCofPqHoZkORBuafHeCw/1k+qx/6g+wPD5+ykjRM1KYP3/BZS6DR82X8j4uttr
         htCIGu8ayWICX0ZBlItnZZ26+s2Z6okrgAx0gCOYcP16fPB0Qv3vwbTDGdCJH7cQKu3+
         35igPpBcuw7pnQlD7sWSeZfHD9iY+LbtrJuOKqFpoQn8yv6GtZ8Pdtz+iPwydpBv/XSN
         RBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896559; x=1693501359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTyH2Pa733qbbxMfLrK7WffNUetmNfwdk8lCtzoIDPM=;
        b=SPIdXZrYefA6DHo0JRPfqpGMUN3gi63x9Dak5x3jj2MtHXMhONqplUoXDfQ4thDV+i
         31i2yXerTyl0reRaIaT5EYwVr1vdUCfVit7/yk/zmPcXPM+UMyOHPD8R3v2nB2FMLunC
         DJP9KMafBEUAILha6ADhkaxTDAz+r5mTLdZXtZQ1RHwI+YfbpxD4JAwTeYroOzqkUpwS
         NDT2hOHYArnd9D+kJpIVwAcx9Ay9oORlDnX51mYAn5Vlmu9vSBJPxbz7wycxbr3EJDps
         CwEWEcod3TcyA93faGyD15qd6W/ROb+zRwwIi13KunzcTIvkN0hozei0fU97ikJ1eIvm
         OYxw==
X-Gm-Message-State: AOJu0Yy8IjSJG4kPYooghcbWj4DojV+U2i/3HkMyRObdhN7+eaEI+hHl
        X/pKB7x79s5Bf+LreDLWs1WS++QGkIC+erNRTCgkGuktpAdAsjEZFA==
X-Google-Smtp-Source: AGHT+IEKQMSprTGuRzIQiuY7eWIp8UKCKLurDjdMEkJhFN0ofdJczicTvl4yRJW4AcdDwtsI7aMxZUpHBq+gyHuAOm0=
X-Received: by 2002:a81:72c1:0:b0:577:606c:284b with SMTP id
 n184-20020a8172c1000000b00577606c284bmr15213438ywc.16.1692896559400; Thu, 24
 Aug 2023 10:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com> <5966626.lOV4Wx5bFT@x2>
In-Reply-To: <5966626.lOV4Wx5bFT@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Aug 2023 13:02:28 -0400
Message-ID: <CAHC9VhSa6XDoie1=ZcqDc9=F2q8JGn2bu6-AwMGcZ=HEzBYK5w@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Aug 24, 2023 at 11:55=E2=80=AFAM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Thursday, August 24, 2023 9:30:10 AM EDT Paul Moore wrote:
> > On Thu, Aug 24, 2023 at 9:21=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > On 2023/08/23 23:48, Paul Moore wrote:
> > > > We've already discussed this both from a kernel load perspective (i=
t
> > > > should be able to handle the load, if not that is a separate proble=
m
> > > > to address) as well as the human perspective (if you want auditing,
> > > > you need to be able to handle auditing).
> > >
> > > No. You haven't shown us audit rules that can satisfy requirements sh=
own
> > > below.>
> > >   (1) Catch _all_ process creations (both via fork()/clone() system c=
alls
> > >   and kthread_create() from the kernel), and duplicate the history up=
on
> > >   process creation.
> >
> > Create an audit filter rule to record the syscalls you are interested
> > in logging.
> >
> > >   (2) Catch _all_ execve(), and update the history upon successful
> > >   execve().
> >
> > Create an audit filter rule to record the syscalls you are interested
> > in logging.
> >
> > >   (3) Catch _all_ process terminations (both exit()/exit_group()/kill=
()
> > >   system  calls and internal reasons such as OOM killer), and erase t=
he
> > >   history upon process termination.
> >
> > Create an audit filter rule to record the events you are interested in
> > logging, if there is an event which isn't being recorded feel free to
> > submit a patch to generate an audit record.
>
> I'm not for or against this or a similar patch.

That was my impression based on your previous comments, my opinion
remains unchanged.

> The information Tetsuo is
> looking for cannot be recreated from logs. What if it were a daemon that'=
s
> been running for a year? With the amount of data you are suggesting to lo=
g,
> it would have rotated away months ago.

Just because it requires configuration and/or a way of maintaining log
information over a period of time does not mean it "cannot" be done.
I also suspect that the number of well managed, and properly updated
systems that have uptimes over a year are increasingly rare.  Yes,
there are systems with uptimes much longer than that, but my argument
is that those systems are not likely as security focused as they may
claim.

> To log all of the system calls you
> mention would be abusive of the audit system, hurt performance, wear out =
SSD
> drives, and ultimately fail.

Thank you for your input.  It is clear that we have different opinions
on this matter.

> There may be other reasons you don't like the patch and that's fine. But
> saying it can be done from user space after the fact is not helpful.

Arguably your choice to reintroduce arguments you have previously
made, which I believe I've answered, is also not helpful, yet here we
are.

--=20
paul-moore.com
