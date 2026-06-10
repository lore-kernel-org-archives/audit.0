Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360603002D1
	for <audit@vger.kernel.org>; Wed, 10 Jun 2026 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117675; cv=none; b=IZhBc83kOJli1TXYAEsS1JnosNSPRFm7Sw8s6ZcT8+DYK1Lya1KalRrusvDdAbUuSMmrmt8U73JiXOGGUepeevB+DK8Gy4wGepIP/YfwX3rl+OprYL67wyaSHqB0rCmleF3xTxE4d9+8W5+z5ji0w4xCWIQEgcc1wJZj+fsd+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117675; c=relaxed/simple;
	bh=cgzuUt7ncEeJkZLZeGVj0VRwA/zEB/YALvzUchYaIoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH1+WEc6VVNI+pdiKQ9xZCkUW+J2cM2QEUyypU7va2DAFkq/hEed5s4VcQHmcI6VscFo8s1AXd47TatzGbpArEe7vxymFzytK7vMBoasQcja38ath8Ix5GgPCXEdEBAm2FCGawINWnwU8yHSd3N5bJMYyTAkkc34vcIKiUtLUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sbfms+K0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sbfms+K0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781117673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
	b=Sbfms+K04d8KLVzemBg5WCQyPGJRVi1qRHsGi5mH7WO5JUaydfZZPYo7a1JfXNFjK6yQ/u
	d39eJnlKDSUtW2ZPx+MSvCsMPuUY9JH/FRPo9mhjevjYk8NvJcBWnQyYJNnuoTrSTRx01q
	hb3WPNGWZtlzbwoAjtlExxeytOMRLH4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-KnE9X_NNMq-3-zR-cPZ-8A-1; Wed, 10 Jun 2026 14:54:31 -0400
X-MC-Unique: KnE9X_NNMq-3-zR-cPZ-8A-1
X-Mimecast-MFC-AGG-ID: KnE9X_NNMq-3-zR-cPZ-8A_1781117671
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bef1e83c990so688669766b.1
        for <audit@vger.kernel.org>; Wed, 10 Jun 2026 11:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117671; x=1781722471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
        b=TIcZhKWPKbQTQ9xZhCr/JbNtjDcnXW++KED0eUOk22WqbYENcFEhoM1ULa/bnzRBUj
         /biIjTapmvOYxvqfYU/AYTxF+0tkJ3FBFXad9FWoyp+yZIMPLr0dL/5uxO2cGaIFUwQD
         YUQRDoDHKClUK8gtj2t7NOIqNFTPyA1RSzSebag5bVa/hvK38Tfiv3cpwRicytWpTXvA
         AN2YQCrtu4ell44QC1FWxELZa0nCGJzsom5PNs/dbtn03AipUVtmamBQdz2m/svVDh5Z
         /4SlTYMYxClzceBeH24mGFXCCXydsXehdW68oVQn26lnQ/ggePNafa2uVxAn6Ge6Q16T
         LzTw==
X-Forwarded-Encrypted: i=1; AFNElJ/CXhqVfhJJBKBh6I//GfJi9956F6YaN6mW1g21ys5fnMK3ctlT2NOtKi5txP1wgUkjltwqGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYg5VeL9vCvYOg0M9qBrDoLuU4EbnHfe5rDkoxYuohruGTIBs
	ktVopM4pKb9xhiypbLQDoVh3foepd1H7M1oW8Fwx4R14oirZ2gRMvZOsldagZea4ZNhCFp/NZYB
	AxIiWOd8+4OgSOKaeQNVpn7venLiBYA7Z4KdGK3jpBQB2rgTS0OrLCbmbTy63BHt0qT1Z0jZMco
	VPmaS3Qrw7zAeN1grsOm53dyDYwqAbU20=
X-Gm-Gg: Acq92OFYeVqVDo4ZXHSHruik3rtdqgj626LAvmMqZwTeJG+F37B3FcugyXCU8C0rFHR
	xVwNk4Hcg0F8IoEIoBCZE3jfVygnS8mu05VDxi23K6M28MchNuS9GYtr4WqhruRhBHijdKoyzD9
	M/8/6PzqdRPK0zMEdwrxdRium9IHwye+hEvXtIQrOt0lzqHl+RXkpP5loPUgkL5/o3RapV44UzE
	wpj0NWLE+c4aM+ZbEerrZhW7Ztwyn2CZkBtxkQ22EV8ZbkMaUH1nV/pRR9mACoM2Rz4avJPDbfW
	QRlTFhEcW5DKVMvcA73VvJJPVy8K6KCttts=
X-Received: by 2002:a17:906:4fd6:b0:bd8:f776:6980 with SMTP id a640c23a62f3a-bf9366be1a2mr537539666b.10.1781117670694;
        Wed, 10 Jun 2026 11:54:30 -0700 (PDT)
X-Received: by 2002:a17:906:4fd6:b0:bd8:f776:6980 with SMTP id
 a640c23a62f3a-bf9366be1a2mr537539166b.10.1781117670362; Wed, 10 Jun 2026
 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com> <2021591.7Z3S40VBb9@x2>
In-Reply-To: <2021591.7Z3S40VBb9@x2>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 15:54:15 -0300
X-Gm-Features: AVVi8Ce8xxpRaTWMyB7SeZgDc5i1KVJQZnVyycI-Lojf1NSNcrzCog82htkEkFQ
Message-ID: <CAABTaaB8QRmVKyzRz6r4VaKOAkOxdHV62HxzYHu_Fx8WKs-ZZw@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Steve Grubb <sgrubb@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uh8lThXB5FuxWLVXzoRFxIIUYEqEQg64k-aeGlmi9os_1781117671
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:13=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
>
> On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time Rica=
rdo Robaina
> wrote:
> > On Wed, Jun 10, 2026 at 2:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> > > On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> > > > diff --git a/include/asm-generic/audit_read.h
> > > > b/include/asm-generic/audit_read.h
> > > > index fb9991f53fb6..8feebc5b4c50 100644
> > > > --- a/include/asm-generic/audit_read.h
> > > > +++ b/include/asm-generic/audit_read.h
> > > > @@ -18,3 +21,19 @@ __NR_fgetxattr,
> > > >
> > > >  #ifdef __NR_readlinkat
> > > >  __NR_readlinkat,
> > > >  #endif
> > > >
> > > > +#ifdef __NR_file_getattr
> > > > +__NR_file_getattr,
> > > > +#endif
> > > > +#ifdef __NR_stat
> > > > +__NR_stat,
> > > > +#endif
> > > > +#ifdef __NR_lstat
> > > > +__NR_lstat,
> > > > +#endif
> > > > +#ifdef __NR_fstat
> > > > +__NR_fstat,
> > > > +#endif
> > > > +#ifdef __NR_newfstatat
> > > > +__NR_newfstatat,
> > > > +#endif
> > > > +__NR_statx,
> > >
> > > There are additional variants of 'stat' that I think you need
> > > to cover here:
> > >
> > > scripts/syscall.tbl:79  stat64  fstatat64
> > > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64
> > >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i386
> > > oldstat                 sys_stat
> > > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat
> > >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i386
> > > oldlstat                sys_lstat
> > > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64
> > >        sys_stat64                      compat_sys_ia32_stat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64
> > >        sys_lstat64                     compat_sys_ia32_lstat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64
> > >        sys_fstat64                     compat_sys_ia32_fstat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64
> > >        sys_fstatat64                   compat_sys_ia32_fstatat64
> > > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat
> > >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:22=
5
> > >    common  osf_lstat                       sys_osf_lstat
> > > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat
> > >                sys_osf_fstat
> > Hi Arnd,
> >
> > Thanks for reviewing this patch! You're right, it seems all these stat
> > variants should be added as well. Steve and Paul, correct me if I'm
> > wrong here, please.
>
> Alpha is unsupported. Those are True64 compatibility syscalls. You can
> include it and #ifdef will filter it everywhere else.  But, yeah. I guess=
 the
> rest are ok. I don't pay much attention to the 32 bit arches.

Thanks, Steve.

>
> -Steve
>
>

