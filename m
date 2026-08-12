Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641A3845D5
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567433; cv=none; b=qCT35mdkTwgmPYxfkq2mfGPGpQG84w4UuVlZub6wEh6DHPCAQ5pQV5Nhkx7XedXrQuPcicLacqjVa3MiuYmF5e+3uQrwZOGOJ9eaG0cuiYzpVuMCS3r0WzdOFXUztvaIJoqBC7iNfyo+ukuuLOqC5CbDj6iyrtwQabLlT6gXpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567433; c=relaxed/simple;
	bh=9AoFaY+agksPLxPtM/tMGqdqBKUnb6DdpxFBPw1W7ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLy/iwHcUfLFNcTdTtZMKpnK0Uq8kLcFXUCTH/9mYemHY5BP/QdfIliIEpSQvEW3p/l11k+xOLC8W3z4DpXyzdLiW6XWRQFDqra8oWUhpjUfE0Fl8TZnygPphSNUKr9Rm7hRf5fCWGY4TFKCouPArJ4v8spNAE3abPaCze7N02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXP15CTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXP15CTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786567430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
	b=UXP15CTIiBXP7DsWbmfY2bP+Xo8Zj8vp67oKEQfKoi1v6EHDaTKkEI7ruA20LDzYJf/wSL
	e59d/syzmldrWh3fuAqA54yHXRH6eTChtIYJWOKySEVtwx6/qJ5seG8CaVCNWf20dx0DYs
	uCuUnFx3e4QPFx1ss9wKgQHmhyzo584=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Ayw22-HEPZaNfy9ov2e1LQ-1; Wed, 12 Aug 2026 16:43:48 -0400
X-MC-Unique: Ayw22-HEPZaNfy9ov2e1LQ-1
X-Mimecast-MFC-AGG-ID: Ayw22-HEPZaNfy9ov2e1LQ_1786567427
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c232fa136so28981066b.0
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567427; x=1787172227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
        b=fV5lz5oj+hf/4Ux3guFknxelr895jWAkJBFwU7PHoAomI8/Wmymc8lWTfV1r/ZYAXJ
         RB58udw6f5QTe9eF6tWysfLm7dxamNHoVOv6QXblIhf1UtmKh1dA5IXjCjzURx6s19Dj
         m5cCCZ2BzTVtpJ426e25/XwDceAySdzkOhXcNqkZCnP7IdQ/ha8ggbjsG7V80K7jO1Go
         NkZsxgCdIauU01ngzAkjRZp9wONSGUM8iWS0o9dDDA6MDz6bX8P6/zHM1Xk5aQpkA8s5
         SxfLNLEILwcTx7/GoqUhjFFyfMof8kGenwufyKuPrpzMO7DNyGQE5+hFHnslXEQfOUMW
         Ht3g==
X-Forwarded-Encrypted: i=1; AHgh+RqsJOFP6ESOjuGDUJcU1S2CmRNG1dI+sVV5n7Lrgz5dqwEr6eXApHc1mnfdYC9TVHypZEBTxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoH98HIBGYrfgtqjuCTFlOfHx1zGwHXKCA4mBU+6TH1hOTT2B5
	OCrVwXYi8bSMeW4+katbwqlXpz866W5Ghq/0+nfK+zdOpeh1nqr6Kj2E20Z+YoHt5fRmxAssGzq
	ATBGW2bSnq6cXKDfaWCFzTI4QuoUf+PWKA9sYKsvXnubd1LPzykCXeitAhH2t7hVIDt8nbvPPDE
	X0fX4NZXXa6G1XQOG+xPZCMXgcho5xsbk=
X-Gm-Gg: AR+sD13zOCpCa4ABRrBEH74zioYwlUevGwh/W5JFSecf98IKyodwQEJGI9JhgddKndP
	FSFK7glSHw6cjxZH/OwPjvhJy3pcZBHLclolfkndZbXfWCtut3s43ol9A0aNjq7//xx0te0Rk+R
	NsnLzrSRZ0xBhHVKop8WA+B/PZ7ct9MbGxfd/iLArVSN6lIsOPJaghchZTSfWFpErSFkaCC5zjo
	JB89wh0cbFk/MFOxqABgFV+UnSJ+eH1sZlnlEdHJGy8J800zkJ3KTd+O/zoWndgXGqDgde8f6Fs
	nhw=
X-Received: by 2002:a17:907:c491:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c2109e5c469mr20804666b.2.1786567427246;
        Wed, 12 Aug 2026 13:43:47 -0700 (PDT)
X-Received: by 2002:a17:907:c491:b0:c1c:2218:f317 with SMTP id
 a640c23a62f3a-c2109e5c469mr20801066b.2.1786567426866; Wed, 12 Aug 2026
 13:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
 <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com> <gKPBCNAOSa-tEF8t5Pm2xQ@redhat.com>
In-Reply-To: <gKPBCNAOSa-tEF8t5Pm2xQ@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 12 Aug 2026 17:43:35 -0300
X-Gm-Features: AUfX_mxMVj1sOxtB69ZMEGz1qrkl3qlQqT7KNuzmrL9G0kutGzunDJnJ50Zc9AM
Message-ID: <CAABTaaC6JHSQ6GJWLFdemC_jhv-5xZRBsEoZQQLd2PVcAQDYwg@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Steve Grubb <sgrubb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qSUIH4-OuYhm6-shbemvtr2ikVo32P8DNy4hN0wVNOY_1786567427
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 5:19=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
>
> On Wednesday, August 12, 2026 12:03:17=E2=80=AFPM Eastern Daylight Time P=
aul Moore
> wrote:
> > On Wed, Aug 12, 2026 at 10:40=E2=80=AFAM Ricardo Robaina <rrobaina@redh=
at.com>
> wrote:
> > > On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com>
> wrote:
> > > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy
> > > > > mount(2)
> > > > > syscall. The generic SYSCALL audit record logs the move_mount sys=
call
> > > > > but does not capture the flags argument, creating an audit gap fo=
r
> > > > > mount relocation operations.
> > > > >
> > > > > Add a MOVE_MOUNT auxiliary record that logs the flags argument pa=
ssed
> > > > > to move_mount(2). Pathnames and file descriptors are captured thr=
ough
> > > > > existing PATH records and SYSCALL record arguments.
> > > > >
> > > > >  ----
> > > > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:4=
1 ...
> > > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > > >  ----
> > > > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=
=3Dfc:00 ...
> > > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > > >
> > > > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > > ---
> > > > >
> > > > >  fs/namespace.c             |  3 +++
> > > > >  include/linux/audit.h      | 10 ++++++++++
> > > > >  include/uapi/linux/audit.h |  1 +
> > > > >  kernel/auditsc.c           | 13 +++++++++++++
> > > > >  4 files changed, 27 insertions(+)
> > >
> > > Thanks for reviewing this patch, Paul!
> > >
> > > > This is because we only log the first four syscall parameters,
> > > > correct?  To put this another way, if we logged all six syscall
> > > > parameters this wouldn't be an issue, yes?
> > >
> > > Yes, that's correct.
> > >
> > > > I'm aware of the argument for only logging the first four parameter=
s,
> > > > but I've always thought it was a rather foolish decision.  Perhaps =
now
> > > > is the time to spend to investigate adding those two missing
> > > > parameters to the SYSCALL record so we don't have to worry about ha=
cky
> > > > workarounds like this (to be clear, I know this hacky workaround is=
n't
> > > > your fault, you are just trying to make the best of a kludgy thing
> > > > <g>).
> > >
> > > I completely agree that's the right thing to do, and I'm happy to hea=
r
> > > that you'd be open to it.
> > >
> > > I did a quick check and there are 100+ syscalls (~18% of the total)
> > > with more than 4 arguments
> > >
> > >  --around 67 of which pass audit-relevant scalars (flags, sizes,
> > >
> > > modes) in the 5th or 6th position
> > > that are currently lost.
> > >
> > > I'll look into it. Please disregard this patch in the meantime.
> >
> > Thanks Ricardo, I think this would be a great improvement!
> >
> > I'm particularly curious to see what old/existing userspace tooling
> > will do if we add the last two syscall arguments immediately after the
> > first four.
>
> It would ignore them. During search, it grabs a0 and a1, then skips to pp=
id.
> In the output phase, it should also ignore them since there's no code to
> interpret them.
>
> > If we have to we can add them to the end, but if it
> > doesn't break anything it would be preferable to add them inline with
> > the other parameters.
>
> I'd also prefer inline. That's the most natural view.
>
> -Steve
>
>

Thanks Paul and Steve, I agree that inline would be better as well.

I spent the afternoon working on this and already have a working
draft. I'll do some extra tests and review it, but I believe I'll be
able to post it over the next few days.

-Ricardo

