Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354F423EB1
	for <audit@vger.kernel.org>; Mon, 27 Jul 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184030; cv=pass; b=QTMtTUNuVO6fAps4tpbczr2n9XK0Wz5FUdXEiVXQRYgGf/INwTIXFliCZnjWC10rfNQWfYrr6DLGYKyee2fcMUzHD9xam31VueG59Twur+bsR/dE0atNHoGq2VLJpFYBoYrdsR5zsQSZMi/RIS9j3VuMR424O5jBfeqKSt2pTDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184030; c=relaxed/simple;
	bh=zFOVl67qa5MCyqBcW/3Dl1wP3PbSI1NNI+2jJUkVovo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PssEzq4ej/cLePfG65FOFLqXga7zdL+GCeK/yyLDyQQYwmbf5CIQo4/fXqq7/WdJzZ7Fqk5DHDgHWPk3Lzw7IXx6hg+ZiifGFIdGu6ODUw2kopytOHlVzNNlCN7lo2mdOlewqhS9afl9FIxy08t9ZuT46Hk4cd84kWfSt2nJH/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E3JqjqsS; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E3JqjqsS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848479c9bd5so2400609b3a.3
        for <audit@vger.kernel.org>; Mon, 27 Jul 2026 13:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785184025; cv=none;
        d=google.com; s=arc-20260327;
        b=UreU1b61FIUlVrekVH6r2GxUxdCr5aXUwtkHX4UL4/3juNuPKDiCsCdRFEaZarsIXC
         iRX8ZXNfp5ieesZYg+dfGEFQh17BPq/qvcA5pyWVZNH9RuSjU2VwB1p2nKlH4X6w/asZ
         Crmds2wEd+aYNAYLbEKaugvZq5JjUKCLr/jhkNUY3u7VA9gNkG895OPKAOfFHyaLlbXS
         bj2t91RzXmP91B8dQHxMvzc/GcY2nYbkkj5I1g+bhOrvlSInzEa1GPoUbjYRyw0WlpHX
         PgSL2ZOjFayJaBLfkqBErtZs7etmPimRd7IgjZTcVxDXveshzePNb3cpYxaqI5HOs1EY
         J3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuCb9PxugWnefJSkZYfZtyMoKrtYAPjO/4t/ug+t2Cg=;
        fh=QBUvzydCXueJShwRyJoac18uuPW74t4ds85BWLuyne0=;
        b=HG9weZe62vx2cKMMrJMs2FEOlw30zJVJdK1u7ct4T4bPBm23fqF9L40ZpcaQUCgb38
         LEdOHbLYO/mHEhPMSfFL3Vt9x2uedRwFkZ4WiSdkbHYQHP1QhKNSxUgXVe2GqHfsl1Wd
         qxqOjE0PO/gB3uMrl2BYrk5sTlmYLvc1cMRBcVYw8e8PvLFoXnQh42UNcqpSIeCpCJHI
         Cn0MeBCceQTI/WXn2tV3iB95tU0GxDOV5HREBq9XotKGUagNf0hPOe/yZiLhJQgN6A8L
         0+siIbFaWXNUeloiDV6XZC7DSVt50gYgD8mOlP1qdOwOcbW/J+23D+kuC96KM2jT8dB3
         gY4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785184025; x=1785788825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuCb9PxugWnefJSkZYfZtyMoKrtYAPjO/4t/ug+t2Cg=;
        b=E3JqjqsS1oEw665DyhoA4Yskn1icGI6841G7/fiGiDqQAJ3oLY7tGYHx2EtpdQ5jvj
         tfIaE906Wg8EVmGGRBKnZKcjWAsaJY8Vzap2lfa9WRH/mlsTVvuIIyTNk/nHQHqMVtCY
         HTAE/brdA75QMqnbHBVb11DQe8ndckmaxQAhZHGb8kgYF3okHlTBhodOOtGg+iZoEzFU
         ZCrHc984ccesxQGbnpwoizSnshJzyMy8E8qzJg79ogYJtP6v5foKgs7CSj+FAGcB1hVO
         mwSJo0+WpHhNUF7/9BfrtOPAVZO70czkMOKkEj4KjBd3L+KDi+5flk49/CbVoNgkWp/i
         Pebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184025; x=1785788825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuCb9PxugWnefJSkZYfZtyMoKrtYAPjO/4t/ug+t2Cg=;
        b=keaCpRBVkWeX3AkjxQV85ni73Wd1ZM/n0imIlPy61cnmS0BnWbWIcqXwrtJgA2qP3v
         +IZvcutTfgYubf9OsUtVgMXcejiSXZRhvukj/Xb4q/D2PTp4ks45e+MekakNJ00SzYYE
         iA0XX3nJwkwnJGNXcchNv5g8vETkmLAOeacu/ghqddppXuZ3SmlvD3sx6Ef2m3amkV9d
         AezLbKRgQpK8X5RJLYTD17isPWOXf48O3gx5bsfnOPcVzgG0Bh1BcNFShlH3eSWLlrI5
         +lgPhoGaHvF6TpilV/7h+awPI7j5hhM3aC/Stn4pYmYpON7KYVGcdkNc11AnbUYxpI3v
         QfZA==
X-Gm-Message-State: AOJu0YxHy9uq0r0GE0vuph9AdHr0neFKRYfXxxolQ6TpR9oIMrDxv9Uz
	O5uc9DMEPti01gJfUxLUrFnoByqR73ZspiNZUnb7Ns/pnGqA63lsvXgfY1jIKL6zG+vsOHM2bWc
	AJfzKMk0S2i9GKZUwEfQG8SR/RFb82jJ5ZMEjLzSn
X-Gm-Gg: AR+sD136D4ZeJLEBv7mbJz04yHkJmgs7TaG9UEcqFBe9s2Lk5NpFYjWsqAQ0tWPWgO3
	gUY4Syx0QtkiX9nW1sn836K4pFggrLCVMRe01wv0+NSwVT7TeYTRytMhLuH2GD5VFOM/nH8BDQs
	TDcDtSUAvGyr/+HtcdY7Hj4Lt9t/KFbQz6OUf3KoHTAdg7PoBiifGNENChKKIsjntwI1HnDDpnp
	RmQUG6rWzQN6FIZnOnaD6vKJLS99YHi18JVXHEGdw5gxmOHUdsC7bpPfEva3ESrVuor+rC/Ldt7
	lQ3bHTkaMDueZ1f5kzfQoFxJ8Il6aOYOcvq6CvQrHEmS
X-Received: by 2002:a05:6a00:3a05:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84e59402894mr7292655b3a.6.1785184024645; Mon, 27 Jul 2026
 13:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630195242.367870-2-paul@paul-moore.com> <CAABTaaCG9xrLXsYoAx9QD85t8xkpveMXi_sBndz-7mbCmpZgBw@mail.gmail.com>
 <CAHC9VhQJicGZY_xAAQgD7jOC5qFAgqAYiw5q906ZHzTY4v+SKA@mail.gmail.com> <CAABTaaAMtUn5yxSGVa1LsCx1Hf=7ei7b3s0cPscN=G7gRoAhDw@mail.gmail.com>
In-Reply-To: <CAABTaaAMtUn5yxSGVa1LsCx1Hf=7ei7b3s0cPscN=G7gRoAhDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 16:26:51 -0400
X-Gm-Features: AUfX_mxaUUSkBPKYI6hi-hOCSSKpZpkx2hK2TAgMRHQqsfoj8Hagm-nBOARN9b4
Message-ID: <CAHC9VhQ29Civf6osD-kx1VDPEF8gXdSfNvbQZehEtUx1G=kU7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: drop BUG_ON() from audit_log_XXX()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 4:08=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Jul 23, 2026 at 5:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 1, 2026 at 9:20=E2=80=AFAM Ricardo Robaina <rrobaina@redhat=
.com> wrote:
> > > On Tue, Jun 30, 2026 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > We can easily drop the BUG_ON()s from the audit_log_XXX() helpers a=
nd
> > > > simply return to the caller as we do if we are passed a NULL
> > > > audit_buffer.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  kernel/audit.c | 9 +++------
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > ...
> >
> > > Hi Paul,
> > >
> > > It looks good to me. I agree that it was not worth panicking the
> > > kernel in these cases.
> > > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> >
> > Thanks for taking a look.  As an FYI, I'm dropping this patch as I'm
> > folding it into a larger patchset that I'll post as soon as I have a
> > chance to test it.  While looking at the overflow checks in the
> > logging functions I was "inspired" to fix a number of related problems
> > this afternoon and this BUG_ON fix fit well with the new patchset.
> >
> > > I was taking a look at other BUG_ON instances and noticed a couple
> > > that might benefit from similar treatment:
> > >
> > >   1. In audit_add_to_parent() at kernel/audit_watch.c:375:
> > >      BUG_ON(!mutex_is_locked(&audit_filter_mutex));
> > >
> > >      Couldn't we use lockdep_assert_held() instead?
> >
> > I believe so.  Nice catch :)
> >
> > >   2. In __audit_log_bprm_fcaps() at kernel/auditsc.c:2715:
> > >      BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS);
> > >
> > >      This could gracefully return an error instead of panicking.
> >
> > I'm assuming you meant audit_signal_info_syscall()?  If so, yes, this
> > would be another good improvement.
>
> You're right, I meant audit_signal_info_syscall(). I'll prepare a
> patch series addressing both cases, then. Thanks, Paul.

Great, thanks!

> >
> > > I can send patches for these if you think they're worthwhile.
> >
> > That would be great, thanks!

--=20
paul-moore.com
