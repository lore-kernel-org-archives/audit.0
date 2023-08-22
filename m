Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E81BEE4993
	for <audit@archiver.kernel.org>; Tue, 22 Aug 2023 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjHVR7A (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHVR7A (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 22 Aug 2023 13:59:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563793
        for <audit@vger.kernel.org>; Tue, 22 Aug 2023 10:58:58 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58dfe2d5b9aso64991667b3.1
        for <audit@vger.kernel.org>; Tue, 22 Aug 2023 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692727137; x=1693331937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJNO4DpweFGif48FgwOo4h5q6LSFLw60E3Noa2q77zU=;
        b=KTg31816iKC6kEjBHhkRZwr3bVmVVJuXP1dMG4pvwFHoFmaeHlPlj3TAOd48RvmbIu
         iBOOjNe7u7kaHitFcfk9RTd97mBX0yVmKRc1ATDw4MhU68YqUoKt4GzYk5A0S5BrRyQy
         xztYIe8GJvP5ULvGIWcPly/RfYgEfZQYcn86DmvvwAeg2N/sSALhX0J/v64ygz5E5rrT
         2XNid796ZuX3xw1EjQmo2yy3xb/IvxsPj4ZgpLVeZ4SOmZJVBkWAYPUULwMfytvJkBC8
         qYcfMv7vpCY+djWX/gjjOA9ngLF7wtOWwbNv28EZiS60457GmpRnWO5DVD0IybgoDnql
         Bevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727137; x=1693331937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJNO4DpweFGif48FgwOo4h5q6LSFLw60E3Noa2q77zU=;
        b=b1SRVSbBn8SRLDJrA+9Z9uMSFbXWrlo4IHyHOysmFGZPf++dQZxiiSR3fJxBL9p60M
         0+OSh5lw6FxSsqU7hsSWYlCAI8Q+slQcQ7YpeU+KnaQ56igrnjKyt8AEJvmSrnNGjT+S
         VGB3VXDZWIdOdGiPQ0oh9EZmMV8awcU3wR51OegOLY1dmSpQxvdmWeuQL9FXZvmnE+IN
         9ut8SAQz7+MUXHFzuPV3nVoFRZHWRd62MBLKbzMVpDVmSGyvZaAgg1q+M3HuJXuTW2Dr
         H/huUuOT2EO16B4TaicjYLDius5QQkAlmqsSPupS/IohgylpBle+f4pZ9yH2sPlRaLpI
         mGcw==
X-Gm-Message-State: AOJu0Yw66xhUi/MlLrkJZur1Jnuzw/WWTkRiuM7lf2w10J+GzZu81tGa
        yZigR46f2NAQHOfIbZLQXIph1cAtcEmKt3RXFTc6
X-Google-Smtp-Source: AGHT+IEyDfy0CMSqPUd439p96k1PQIF8AF7NcYT6/KkkAcqmqIDP4pgMgV538sua5wmJ8oyoG1MTh7ku1JPl8x1envE=
X-Received: by 2002:a0d:e206:0:b0:583:9db5:7e89 with SMTP id
 l6-20020a0de206000000b005839db57e89mr9299641ywe.24.1692727137183; Tue, 22 Aug
 2023 10:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com> <4865772.31r3eYUQgx@x2>
In-Reply-To: <4865772.31r3eYUQgx@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Aug 2023 13:58:46 -0400
Message-ID: <CAHC9VhTGQ7LF8BjZDJMj7F8Uo0AYsWtyce98kyQrsRYK1Ui1xg@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, Aug 22, 2023 at 12:29=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Wednesday, August 16, 2023 9:53:58 AM EDT Paul Moore wrote:
> > On Wed, Aug 16, 2023 at 6:10=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > On 2023/08/16 3:44, Paul Moore wrote:
> > > > On Fri, Aug 11, 2023 at 6:58=E2=80=AFAM Tetsuo Handa
> > > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > >> When an unexpected system event occurs, the administrator may want=
 to
> > > >> identify which application triggered the event. For example,
> > > >> unexpected process termination is still a real concern enough to w=
rite
> > > >> articles like https://access.redhat.com/solutions/165993 .
> > > >>
> > > >> This patch adds a record which emits TOMOYO-like task history
> > > >> information into the audit logs for better understanding of unexpe=
cted
> > > >> system events.
> > > >>
> > > >> type=3DUNKNOWN[1340] msg=3Daudit(1691750738.271:108):
> > > >> history=3D"name=3Dswapper/0;pid=3D1;start=3D20230811194329=3D>name=
=3Dinit;pid=3D1;s
> > > >> tart=3D20230811194343=3D>name=3Dsystemd;pid=3D1;start=3D2023081119=
4439=3D>name=3Dssh
> > > >> d;pid=3D3660;start=3D20230811104504=3D>name=3Dsshd;pid=3D3767;star=
t=3D202308111045
> > > >> 35"
> > > >
> > > > While I respect your persistence, we've talked about this quite a b=
it
> > > > already in other threads.  What you are trying to do is already
> > > > possible with audit
> > >
> > > How?
> >
> > If you configure audit to record exec() and friends you should have a
> > proper history of the processes started on the system.
>
> This is not a practical solution. Yes, technically this could be done. Bu=
t it
> would be a huge burden on the system to keep up with this. And it would b=
ury
> events you truly wanted to see effectively DoS'ing the audit system.

If the audit subsystem can't handle the load, that is a separate issue.

--=20
paul-moore.com
