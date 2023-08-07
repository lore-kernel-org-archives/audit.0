Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131F9C001B0
	for <audit@archiver.kernel.org>; Mon,  7 Aug 2023 18:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjHGSUP (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHGSUO (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 7 Aug 2023 14:20:14 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88898F
        for <audit@vger.kernel.org>; Mon,  7 Aug 2023 11:20:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583f65806f8so52703157b3.0
        for <audit@vger.kernel.org>; Mon, 07 Aug 2023 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691432413; x=1692037213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G/ExPX+XYb7roizCAdZtPh6OqV1aIpZD3TDUpTMbik=;
        b=P3f+WsP/Nricu8vomEM6zhZ2JZyX0l+1DB7cqpwrD/lrSHESCsIZ1XdN3BtjmvwUql
         73lgaFKn+WtR3KZ2tyK6oMLzlyFBCrSl2YjCw4T42eWI3XnZpBNY2Ax/oXR+njgUzQP0
         Vp87AV11iLNSC4kmCOuWt8zsigKD49KmA3d6PEEtA+1nEOPFafRPJaVKH6R0QiWkSijv
         /ZndTkse8rTSySPNN6cdxnarMotPBUsDRfNYaS5HoexzeDagvaICurr0MDBTLlZrNA4h
         JoZanfBcZrrN5qUikgJ9vN29ttU+UwPZY0gFboJYzeu3UmuGJWoTXaCLZ5sUL+qeYGL9
         Rqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432413; x=1692037213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G/ExPX+XYb7roizCAdZtPh6OqV1aIpZD3TDUpTMbik=;
        b=T8kvsbFNzQeTnly5zVz1NydUq1cEO8AfKMjxImOVe3f/otgCr7aD/UtcCiUi9gyJEO
         zOp64Pjfo5uwLW8iUNkgDfSV9/1j2c+0ooEwD6d5ZHU3rF7SjNJj8m7giyMk3kXw1hzN
         dBBDtagcgF5eF5I9WZtk2xRxcMfnLAf3uHEHGtp+VNcchdDUneyEYC5nvy/9idzDRyRB
         Z0Z9fu7tM0fVktW7XItXwD1VaVvoQpxibKihlLTeqX3JY9VY8vD2W79i2ZwsQw1LujBJ
         Sh/LXbssEVluiJ0upip3tGHWK7cx6t50D90qBJhAKRg7dMLUxX5O4WWR2Ohmav4MAfAe
         nbsQ==
X-Gm-Message-State: AOJu0YzFMlnjVRwGJnPu29VwMeOunf+rPK57Rd8WaJjRZvlXWeDXFIXZ
        3wGWER8qrk/ajtsLnbxy+WvMr6bB9N+PJXiDk75A
X-Google-Smtp-Source: AGHT+IGpiCXwiotHMbXR65hE/7KMf6MqHCsioVCgC/d9GTLsJbl+GYCPVxNLdxuj57o6YUtnj+Og8Z2hlV6v4up8S/M=
X-Received: by 2002:a81:720a:0:b0:576:d65d:2802 with SMTP id
 n10-20020a81720a000000b00576d65d2802mr10986339ywc.3.1691432413143; Mon, 07
 Aug 2023 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230804094155.283766-1-xiujianfeng@huaweicloud.com>
In-Reply-To: <20230804094155.283766-1-xiujianfeng@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 14:20:02 -0400
Message-ID: <CAHC9VhRLzd5Qimc-Q3xe8RRXM=6CCFkWbh5=fJObhaZWhPSpcg@mail.gmail.com>
Subject: Re: [PATCH -next] audit: remove out-of-date comment in auditd_reset()
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Aug 4, 2023 at 5:43=E2=80=AFAM Xiu Jianfeng <xiujianfeng@huaweiclou=
d.com> wrote:
>
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> Since commit 48d0e023af97 ("audit: fix the RCU locking for the
> auditd_connection structure"), auditd_conn is changed to a global
> pointor protected by RCU, and doesn't call auditd_set() here, which
> makes the comment don't match the code, so remove it.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c | 1 -
>  1 file changed, 1 deletion(-)

The comment is still relevant, look at the
`rcu_assign_pointer(auditd_conn, NULL)` call in the auditd_reset()
function immediately before the spinlock is unlocked.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 45b2fb1e45af..0905750779a4 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -640,7 +640,6 @@ static void auditd_reset(const struct auditd_connecti=
on *ac)
>         struct sk_buff *skb;
>         struct auditd_connection *ac_old;
>
> -       /* if it isn't already broken, break the connection */
>         spin_lock_irqsave(&auditd_conn_lock, flags);
>         ac_old =3D rcu_dereference_protected(auditd_conn,
>                                            lockdep_is_held(&auditd_conn_l=
ock));
> --
> 2.34.1

--=20
paul-moore.com
