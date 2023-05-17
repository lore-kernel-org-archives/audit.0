Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AAC77B75
	for <audit@archiver.kernel.org>; Wed, 17 May 2023 16:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjEQQD5 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 17 May 2023 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEQQD4 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 17 May 2023 12:03:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F181BC7
        for <audit@vger.kernel.org>; Wed, 17 May 2023 09:03:53 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba8151a744fso1271668276.2
        for <audit@vger.kernel.org>; Wed, 17 May 2023 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684339432; x=1686931432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLN4hR+vf8IV6dL3Yiybxphtk3K6xzfKOo/BEcKtKBw=;
        b=Yq9wGZwPNMMn7yE/Yf6dY6pidAcCw00N2b3QmZC4+PN9CqWT6VmtZzgyg1CNAnrgNp
         LAzlMPfReQpA12tjyEYpoTW9f3AqNuKdwlTpjc5QEO8m6TeH98PMHnfih1q/5APngpFb
         igUsbbGctuHXRZF+wpWQbZw9diz3Cab2JEvy8YkRL/Fs5Qh97lnkCvoDKKZ+moON6O6m
         MP4E84Et5yR3ZX780yrZ2fMflKsBZZSnCscNhFXdv7ZCF+2HslTC+B95mGFVLThW6mGW
         4rHGOSJDACw5BeIUr/LcqwuVKtGc4kIoIQEcpHl4QwmB0XtBEXtf+kq1dF8LfEqVHgMC
         IhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339432; x=1686931432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLN4hR+vf8IV6dL3Yiybxphtk3K6xzfKOo/BEcKtKBw=;
        b=J6j0qKcROnQNcxaCTf4gTGWkpPIe46saldFCYGIc/2NwY1uFK0qBBmtbxMP9LAZkq9
         Wf3d6cmqdTT2pcwL0LcenHwTU+N+VpHpNjseM2xRFMCkG8uI23NhVNPgU7Eyi6DKTuYC
         QLbKoo5rITpC9T52Ff2ZnaEfU2K15fXVi+P5g1yp3ozH4YHOAoENaQGBjxfKDpjuXw/k
         iXCRmrRYWDEVf+1mfVpf31UHJ3wjXa4zmGhMA6YfPhPyqcY0BvgPvbZnqwM4J3F/GOZM
         nA05NMC9fbU6mLf2ptRZ6KkHVXOx3blLPCeVgivscvrEOFKVkuNocTffG2o5bQM5mGtJ
         gbJg==
X-Gm-Message-State: AC+VfDzhpyJFsNJMYMUNLut1DFWrpqYNV1lt8d6mCoj4FwawFm1dX/5W
        w3AJsK8kSRKlWobe1smJdOUi0riUolTSBWIiSLe5
X-Google-Smtp-Source: ACHHUZ4+IsvnlJEX2APNGtVxoy8mXlTEJbRZACJCN1aFcwjRqrckilVZgTSgsbJNap+PfCiYLX0Zgk5BP8qfmOjvE/k=
X-Received: by 2002:a25:31c2:0:b0:ba8:1d2a:8096 with SMTP id
 x185-20020a2531c2000000b00ba81d2a8096mr4859580ybx.31.1684339432131; Wed, 17
 May 2023 09:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com> <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
In-Reply-To: <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 May 2023 12:03:41 -0400
Message-ID: <CAHC9VhQg6aF_MKgkfY5RxgBgfVpUrU=xOTHenob++nmW5=aWug@mail.gmail.com>
Subject: Re: [PATCH 0/4] audit: refactor and fix for potential deadlock
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, May 8, 2023 at 9:49=E2=80=AFPM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 8, 2023, at 23:07, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, May 8, 2023 at 3:58=E2=80=AFAM Eiichi Tsukata
> > <eiichi.tsukata@nutanix.com> wrote:
> >> Commit 7ffb8e317bae ("audit: we don't need to
> >> __set_current_state(TASK_RUNNING)") accidentally moved queue full chec=
k
> >> before add_wait_queue_exclusive() which introduced the following race:
> >>
> >>    CPU1                           CPU2
> >>  =3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=3D=3D=3D=
=3D
> >>  (in audit_log_start())         (in kauditd_thread())
> >>
> >>  queue is full
> >>                                 wake_up(&audit_backlog_wait)
> >>                                 wait_event_freezable()
> >>  add_wait_queue_exclusive()
> >>  ...
> >>  schedule_timeout()
> >>
> >> Once this happens, both audit_log_start() and kauditd_thread() can cau=
se
> >> deadlock for up to backlog_wait_time waiting for each other. To preven=
t
> >> the race, this patch adds queue full check after
> >> prepare_to_wait_exclusive().
> >
> > Have you seen this occur in practice?
>
> Yes, we hit this issue multiple times, though it=E2=80=99s pretty rare as=
 you are mentioning.
> In our case, sshd got stuck in audit_log_user_message(), which caused SSH=
 connection
> timeout.

Sorry for the delay, I was away at a conference last week.

Regardless of how we tweak the wait, there is always going to be a
chance that rescheduling the task with a timeout is going to impact
the application.  If you have sensitive applications where this is
proving to be a problem I would suggest tuning your backlog size, the
wait time, or removing the backlog limit entirely.

--
paul-moore.com
