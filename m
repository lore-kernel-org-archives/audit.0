Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793752864;
	b=Bi/2ojATUFtV9ximFQzly7Aq3OxkqNIs4XHbldiaHNqIo/7nDnf4FNpdIwtUz2zqTC/f
	 JafXHtRwFcGPoIWOTh0xT9fPlevYpCAWkwc5NWutZTNVbrt0flTKO9yFMdLp/kxeWT2tU
	 d2bHLLQQUsd707IGdkcBj9L9+jDjcwwmLaDlXtMZGHQhzobZkd+TxdvYdn54xhIl3FwrF
	 kr97a6J7iff2Hq/U5hPn0I+fBcXkS5nnPjGDX2QhUrawi10p8yU8VNs9FKOykDQo/d2I/
	 5wxTBbOdZ4x64d3izgiWsCfc3PlnBAGJkSgifXMfgnP7i7sVZWqC3vQLIq9kxD/VzQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
	b=fsbl24lleMPWi0UitnsusMwxYlx3INVMWRpBusFjdwGhGly3iFA92lbCGo+5ZwKAAwo+
	 xoBl4ssYC5CPFZ2ydSUtG1vLL3K+vlwi1+zFKg+oSomX5We65XglM9vF8CsPeIXhDbSUR
	 D/BgHaJ3Lajpy5DAVrIonTy2VL0U0EIIvvLLlyCkyE9nCVAZ+sUVpckXae082VkNup6qm
	 GxnhbMF3NxGZXG92Fe8hBRhYFHHEnwx8m6EA8SJysqRpHPIVp/PnZawJZXK9xyR72rn3+
	 qOUHTHcJQpbtdZVH24BubmBeyZuEBZAXJ6Swbey1icjOUhI+jl06GPbbAfkSZuUHUZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw;
	arc=fail smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544D606A32F
	for <audit@vger.kernel.org>; Wed,  4 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E544D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso80815b3a.2
        for <audit@vger.kernel.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=h1OGeKwzIunmdMHXqCRVFVD/1XVOES11HvAozPwxcKAqxRuuyJelAhkA6u8jSsQzR1
         7I9Digff2DPRJCwK5EEmcYTrgLYWAaJezV80MPE5wtt5e/bsvxzM9+C9Dox7VMexWqqH
         V7azyPUkz2Hz8eUi2dhXjQmuWbCgv05JURkmxAocZ6lop2dNv/Ttt2ftwP1erU1WK6ZD
         +Nfasim09hPP+91jpuq6S5Q4GtHmstRoLrEUji0MTmvzwBwK8+aLFL/dVlE1GTjWcuxF
         dKrwcCWtY/3ArlsfCmfuTutJpP4eiCULBz/rROpJeoh9Vrdvgmx820/rLNIDmcYnabNt
         QZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=b8NH310RuesssRCaAmnBQdPTqvz9avNnbX9wpmAPCkU=;
        b=NSilHOmBLom1zU84KJn2PZc2a6k8UVIWF7h0YI7H7RMgEndfgIsT0B4vz9Z3/5iIk7
         8FeLCENA+UiBy42Wt+DzUDWxnhjlSqGLT7kH309GoJR0F4fQNICLZgwZ9NJnX+AjEEmB
         H3xOX541YqIQLLqF3DcdPBBfAHKxlPABo6VLLG/ef7Y9IrS2/XoaDXY75HNvLhNoKvMt
         Obn7hmZTj7FDVuCqGK25V2lvFlVSB58X4KJNWJu5s+NPbbDpb4oxH0bnhfhjq6xBfmCd
         sJ+hVDb8Bvq/81hwa/nQQ7dSj9doQYQyNicFhNser/6WBsK/znoOBrhOjhtUq6pbtPaM
         UtSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=PTPniKxw8lSLWSxMbmhmXVodXffwfFqC3M3cDEPYPvY1SsBjNOjXXv95CLFg3rVQFu
         x1tdyRAr0bqYQ6HVqsjHpfPPU10/1FhE3kd/CHXKlKRa2s8Jf9/RWGaRvSd9s3tWp3+h
         Tji6Btj/3XlTUrwGPe+aphN7moDM3Ujmyews2MtwEsOdhWo9d1B27IQnIAXxeCj/AgoF
         TwCZd9YYNW98ENSoBC4GvFAhash4XN0WeHulLfX/snYculqtKEVgWcaAWPf68LjYBfvq
         i5NzGzwAog4kKLckyYK3n2IY4tOHLEWiT5cJSG6dbW9SW1FZ4MjXmEMstZ0yw7BaSVW5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=LlFz2g4OS5NJtMAewP8GOfxhXYq4qHaREdNcr7Jg1ES0I5m2gB4KuGKj0rSPCnfvn0
         shpgeISuJTbJf7O/mfDqM8MFp+kkD0j1gnWK68TAWE1FnDwqnct20asuevNNMnKsOBZK
         KLiMca7sWXxPc8ygK0ni6Bl4yv4/FVkzxiNsl4wCK9XdU7H9IzA0VM+bbtxAE1ZtmCCW
         zhf+u26hgMb1F2c8gERWLjH5s6Mp6Gzgp7tQtSlxQVcx24WmnADCvSuD0Y1LvUrBkb+i
         Dx8xhWou6gH2kefC5/ffIbLHPfstvi1nEKt1xmiLSzLKpaEElDq1ZNPVrjYSrSC0LpZ0
         Synw==
X-Gm-Message-State: APuU4Z8Q2rNf2V+nLd/BxrqMde4Sidbd+J0unJGrCxlfTO7eijbPdI6l
	JlTu0BnsUN8WpN3jExvyOxcSB6hNVrM85RjN6J35iYQCDCHHlboveYYyIjCwzItVClfOOQe++P4
	acac7JudO0HiE/2F0IpDfMOAfR/4+0bVlA30VhHkA
X-Gm-Gg: AYBFou1iTbViYKwwh9DC6NRZlArYMui/p9vKWImBWhgTQwomwXfl1eQs3acktezuRyO
	PXMkJeRIJ89gUgRWANgSOEei6izbYhwCLl4lbLE//F0iS81BHS/X2vr86nADMd5iODjejHN81Cn
	WFsd9S/5OyI6SvhZO4mU5Wx6eEssIqExv8uGLWl36fTMOsjfSg/lbxilozB6niyHkhPlJmF+z/x
	1GPdL6YfKUbTVomDiuL0Draccuz0RnDoESw6ebMSSwAN0UMrKegdxcknGKhCbcBKUHL7/5MF5CU
	mYqYaUrI2e/AFJGCNM49WFOb/QBUmvssjRNEY8pTjGMgpo6j16kQ1cYeZQ6RHXk4jeuHlinY2rx
	+jG8dnycI+JEpx5SDtsTFolSQtTb6ZjRV8io3Q06XM3flGpOT20kknIHwwHpO7XzMjM7N
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com
