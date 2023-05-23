Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E22C7EE26
	for <audit@archiver.kernel.org>; Tue, 23 May 2023 21:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjEWVCq (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 23 May 2023 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbjEWVCp (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 23 May 2023 17:02:45 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B7126
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:02:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba81031424dso286297276.2
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684875762; x=1687467762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqYu2kG5xNu6n0LsPQ2y+Hn9CqO07QzD6a31cQFnFZg=;
        b=RDGN8oh67okemzzbGB26nSaBtKdF1uA4bAnZXDDKRWTRvgpXw9siHajY2l5TldDPFK
         8q17RZJdGq156wB2Y4vWX4zYnnQD08fHBVQdxdugUMSXzlH2nhXQ+nESzi7Z1GoRWzNY
         7KGVgdgW4KhKhbAiVmWYy0h6jUKF67D3ivYKBiEz+Kzab+rzsg7pzQ3hcMIygr1Ys2W/
         KBGqmW5ARTDL4gk72T7uJrky94iLJHHHPO2Pz9gDYBcQKUnSZZz800Xhz8bIssjEJtp0
         DwKN0tfGaE5Go7Vus7W61LTrpciE+jusU07S/nc5Sn3pvw1nsgx+Rk5V1lCQltemqXzP
         k1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875762; x=1687467762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqYu2kG5xNu6n0LsPQ2y+Hn9CqO07QzD6a31cQFnFZg=;
        b=EG5W8WpBBQI057zkF0NUhXy5Wb/8FBM8opIgDqB1cWe95XKc6GMMGX3zEEx2saPdIu
         EPMqsoYxTnEIQvuckhp2EyapaQvvhpizUv1y0fxEhIEuM8yzV7Gdoj3Ky+3w7nQkcMvs
         nVckaVlpz0JqscRzj2zn1CITlVPmxDHaU8tIiFpNOjp0zd2pu9N58QXty0upsKRK5T0s
         4QwJa+MdY/029cIOve/OHqDXlBQsGh2hShAYSS6l+5X/0F9ejnU5pgD4IpxUzT67iBg5
         ix4hZBycCFSb7/R066uvnbiRrMpNGMdAlvV7EV9yM4DgVLxBeuVuc7YEvC61Pw4KPb0P
         KUeA==
X-Gm-Message-State: AC+VfDy2bKiHil84BAirctggmPcs/BSxcWvu3FRXWmMkWZwz3RhzYaHT
        AQd2jhRs4QKffKC327n/tF/MqlSG/WClXIHNZkHU
X-Google-Smtp-Source: ACHHUZ65SJfuq0V/FHHNcH0cR+Hwp3609WEhUnTS8CyVuEWu3e5N3J5NMtidlcC8+4PmQudZYS+a9E2yFTxPf7OoSIE=
X-Received: by 2002:a0d:de81:0:b0:565:3da9:2bc1 with SMTP id
 h123-20020a0dde81000000b005653da92bc1mr3735984ywe.1.1684875762379; Tue, 23
 May 2023 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
 <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com> <368B6D67-26A0-4A05-B404-395C5990A9A2@nutanix.com>
In-Reply-To: <368B6D67-26A0-4A05-B404-395C5990A9A2@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 17:02:31 -0400
Message-ID: <CAHC9VhS1dNV2NE7F9mgfLuWVeK8P_KYqNd3m_2U_vrq670sNiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] audit: check if audit_queue is full after prepare_to_wait_exclusive()
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, May 22, 2023 at 12:28=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
> > On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >>
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
> >>  @audit_queue is full
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
> >> the race, this patch adds @audit_queue full check after
> >> prepare_to_wait_exclusive() and call schedule_timeout() only if the
> >> queue is full.
> >>
> >> Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK=
_RUNNING)")
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> kernel/audit.c | 12 ++++++++++--
> >> 1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > I discussed my concerns with this patch in the last patchset, and I
> > believe they still apply here.
> >
>
> Please refer to the implementation of ___wait_event().
> It checks the condition *after* prepare_to_wait_event().
>
> Another similar example in the kernel code is unix_wait_for_peer().
> It checks unix_recvq_full() after prepare_to_wait_exclusive().
>
> I=E2=80=99m assuming this is a logical bug needs to be fixed.

I disagree, see my previous comments.  The fixes you've presented do
not eliminate the possibility of rescheduling which could result in
some of the issues you've described.  The proper fix for systems which
are sensitive to long scheduling delays such as this is to adjust your
audit runtime configuration so that audit does not block userspace.
Suggestions include removing the backlog limit and/or shortening the
wait time.

--=20
paul-moore.com
