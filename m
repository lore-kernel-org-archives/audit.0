Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB93348C70
	for <audit@vger.kernel.org>; Wed, 10 Jun 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113263; cv=none; b=cZetCNXefM3obkwUbsi2lvogc5h1VSBxgoysyUG8YwA042ZGz2oDJxfDOrov++i0jbTMIOc7iVGgq16Z7njmtm6VkE0/6vTVWt4H5QrOUMSexI/lptICWI0a7iF0dcNa79vuzJ31qaApQWfx07NZM2jSglpekijGMlujBaJki7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113263; c=relaxed/simple;
	bh=1AxItsFe16jGeUOX9ul3gEcPkmr5Ky6rSQxHxc9GX+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtUgvHuQqrGMIXZWXuXsXTxfEdBeBQAAfa+Se5blnfn49A/cnKBbQUrcXw7sgTsB693eazuOQB8POQ8KpovUl2GuL0NB7tVzHS3lVXU0YwmLCAyTOo5qULIPG9NGkMye1izfHExMt35uYImnyzFB3TKW9VWn4P00KZWyoPatWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXjZ8L6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXjZ8L6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781113261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
	b=AXjZ8L6N5UATgOpEHw9EHVlDYzFTEEyXN7p8dO81hfGqyGfkqyOPK2H6cd7ZAFZjFnVPJ9
	P+QZUnZ85PilhwVChnvjvkcNZcRoqS/SIzM+ChAWIHwctaEiGVG0CAAhog2btkkPqzErBH
	vZSSRkXJLLH3XISOUaIBcKKu33roFco=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-cpKPTCVpO024lbwLyMEdKw-1; Wed, 10 Jun 2026 13:41:00 -0400
X-MC-Unique: cpKPTCVpO024lbwLyMEdKw-1
X-Mimecast-MFC-AGG-ID: cpKPTCVpO024lbwLyMEdKw_1781113259
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bdad545342aso976270466b.0
        for <audit@vger.kernel.org>; Wed, 10 Jun 2026 10:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113259; x=1781718059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
        b=PrKpkZixutSfVfzNVg0MTjdtK9Zj8XvJmINNHroMf0l7/Gbi5OhqY4zLQhvzjOlEPt
         dmvGALqnuvl4AJsem2gLaa54I2tCeGQ22ww7EccSAXAFXCni9v+s0f6D2cnT3m5qgxQv
         R391atFW1qWvVuYc78xOIoBkuMOXStlBEc0cipWevi58w+MbLpjUUYKsZun/RkqyOxxB
         vr7ubqGU6UV7qDbQ+41HDByA5/c9iC8KFmxfDvh7jX+zbSWaCRogYLnoMDe5ujMXQcFO
         YIlPcYO3fJ9ITPYSEi5G5xj7/4JNnax9DqiKdJKgqo67v56lMn0g0YFD2QPZzsz73xhz
         9StQ==
X-Gm-Message-State: AOJu0YxuKnv/fqhvRTAeKLioi8vSNCh92f9M893NLSCnfkM8MBogniNn
	4RAICR6bB2wiuz7f3XvfbQPgm8W6Th1HBOqOF+TXO6V0UZM/apmc0VHmj3Uspp20b1EkBOkiIp7
	BNVBvE+LdYfLDFkQaMtvZ1g0NouYXdw0x81M0sN6jdkxNvixA1+e3lH3lswyh2GodVGnPFMKKQ+
	YdGZRAZudNFmhtOk5QQ4yTupDIlOYccOU4ANzFYpxJrw==
X-Gm-Gg: Acq92OF7aDi68LUe7oPwwjs+CDYRaMvJtFrZslyf+zaEEGU0/zwnviU5QXqHNS1dJvw
	Db/VeMFQEuhkJxoFTeh3fRQizYbi2vh3c5s+20Mg0HZT55GofF4NKpr2EVbgatYAevPfA6eVk8x
	Ufvsk9d/NX56pTU9VfLHvfDY7iu+JTb9QP1Yxt4/o/RdBvBjWLIVVSnTSSS0/MS19wv+JZ7duVo
	OGUN+z+f0DlhHb/KiiKPQdTHNJdL3lV3ogSzyfrhqp3iJCKmtNeKXgOHSBOqVk8UolRx+jPbezH
	JxQ1NEZsUnmAhq5Odt+kX4Mseh179qc9Q+A=
X-Received: by 2002:a17:906:6a01:b0:bed:87c:b24e with SMTP id a640c23a62f3a-bf3721513damr1253746266b.29.1781113259330;
        Wed, 10 Jun 2026 10:40:59 -0700 (PDT)
X-Received: by 2002:a17:906:6a01:b0:bed:87c:b24e with SMTP id
 a640c23a62f3a-bf3721513damr1253744866b.29.1781113258996; Wed, 10 Jun 2026
 10:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
In-Reply-To: <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 14:40:47 -0300
X-Gm-Features: AVVi8CeUHfgLiWmp9hQn1L3Vkdm96Ld0E64v1VlTaEQSS5bJm1lcsISDAQPRmA0
Message-ID: <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Arnd Bergmann <arnd@arndb.de>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QRi5rC-5gsN2bPGJdkt4WY4rFJztpz8nr72-unGlloo_1781113259
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> > diff --git a/include/asm-generic/audit_read.h
> > b/include/asm-generic/audit_read.h
> > index fb9991f53fb6..8feebc5b4c50 100644
> > --- a/include/asm-generic/audit_read.h
> > +++ b/include/asm-generic/audit_read.h
> > @@ -18,3 +21,19 @@ __NR_fgetxattr,
> >  #ifdef __NR_readlinkat
> >  __NR_readlinkat,
> >  #endif
> > +#ifdef __NR_file_getattr
> > +__NR_file_getattr,
> > +#endif
> > +#ifdef __NR_stat
> > +__NR_stat,
> > +#endif
> > +#ifdef __NR_lstat
> > +__NR_lstat,
> > +#endif
> > +#ifdef __NR_fstat
> > +__NR_fstat,
> > +#endif
> > +#ifdef __NR_newfstatat
> > +__NR_newfstatat,
> > +#endif
> > +__NR_statx,
>
> There are additional variants of 'stat' that I think you need
> to cover here:
>
> scripts/syscall.tbl:79  stat64  fstatat64                       sys_fstat=
at64
> scripts/syscall.tbl:80  stat64  fstat64                         sys_fstat=
64
> arch/x86/entry/syscalls/syscall_32.tbl:18       i386    oldstat          =
       sys_stat
> arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat         =
       sys_fstat
> arch/x86/entry/syscalls/syscall_32.tbl:84       i386    oldlstat         =
       sys_lstat
> arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64           =
       sys_stat64                      compat_sys_ia32_stat64
> arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64          =
       sys_lstat64                     compat_sys_ia32_lstat64
> arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64          =
       sys_fstat64                     compat_sys_ia32_fstat64
> arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64        =
       sys_fstatat64                   compat_sys_ia32_fstatat64
> arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat         =
               sys_osf_stat
> arch/alpha/kernel/syscalls/syscall.tbl:225      common  osf_lstat        =
               sys_osf_lstat
> arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat        =
               sys_osf_fstat
>

Hi Arnd,

Thanks for reviewing this patch! You're right, it seems all these stat
variants should be added as well. Steve and Paul, correct me if I'm
wrong here, please.

> Not sure about ustat/fstatfs/statfs, I suppose those are a different
> category, right?

Yes, I believe these would fall under a different category, since they
are related to filesystem stats. Audit PERM classes are specifically
for file metadata and access operations, not filesystem statistics

>
>        Arnd
>

I will work on v2 shortly.

Thanks,
-Ricardo

