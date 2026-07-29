Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52FC3A16B9
	for <audit@vger.kernel.org>; Wed, 29 Jul 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347670; cv=pass; b=NN+JqTqoka/O1hyMmgJbC2cRDieDKX6Oel36w+TeuwK882HtnbQS88Spw5W+UI2pmaOjvyKH4IR1FHycQWUay2+co2f0XhQJuLqk6NsjvvY6lAq0A5cRqr5U24ZbokkAX3SAe0BFUGK9IC8IDlclIS/7V+MspupRiY9PsK6hN9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347670; c=relaxed/simple;
	bh=6foRPgcQEslNBFscPNEPG9I3ccn7/eLvNpa1/K1biMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjtTIYLIfu8efZcNlXlpL+/biSpHnBy9/F10Vb4EGWABYzeFmqgeSIs3Px+DhA1hxTzfoPCyUqdLQ5ie1Z9gChd5Z2Rxlm1ljDeFWDaiqNZ9XI4/X86dOtsq6HBgsteafQgGQ6wHaFE+1CKUIpAD8iBECWmepARhDdF3qq1HFBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E0RCz2dK; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E0RCz2dK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfff5f88dbso14719825ad.3
        for <audit@vger.kernel.org>; Wed, 29 Jul 2026 10:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785347659; cv=none;
        d=google.com; s=arc-20260327;
        b=Bxv872Swbp0hnIFxY87NFV7/iXuqjMNAubgFivotxlFvYDXVn0zA8N9aw7NOEh3Y89
         Da9fit8xLyc6dozIjVsQkPURSWSjZ/tkJoYSoFfvfK7RgxgxLflON9yZ8KbuYrsbLqMw
         dr5c9tBbaIecPhigbv26UJEbjaEOb9Q4Ca96l8/WyqSoidguzfk/zprk7URQAsZJl6c/
         Bmf1E/iW1myGsIqNsVLkOg5nKc1lGVUopW0BcGAfdsxanXA5MumuDKvo3R++iptEkppY
         aJd+i8dbLvIRAZBMH21+qqHT9Nd0WnMeF/zlDAyPFt3LQ7GEjiHOlLBHux5gs8pwEPyY
         LlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmGdt5Io4WXqOXdtwiF09bKELDwsm21C5P5pzyFwm2g=;
        fh=ePmt5QSlSOPFMVMqJ6QSuI1V82KQ5PB8L30QuKXu1M4=;
        b=Pn6vq5ndn7yEx+HXyuEns49aDiKbIEJfQwxn6xF7C+MbyACZU776yDoxZPqQ3wMSa0
         TD6CujxluwglJIheWlF4hVRgbEd8y52eU+3g50ZwvTRcGAJZZGB+JBr3X+9wxwSuwerI
         jNHqzFQyOKA/OLpNId5Qpg9X4y9why5jUbocqZOMzrH4+Xn7wCrLuwwlmsD+Sq7R6nQM
         JQ8e6+jowXDxsVtJb5Ohs/ZLiCVREZOct4xOYdTY1YSFVQpx0Dv8BiE3/xn29RPsyRL5
         JqufSz+lc/wMr3/XlScl7azcrn9FTAshIEY58Hf96qgXDuhKVklNv0p9kNB4i7UP11An
         z3Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785347659; x=1785952459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZmGdt5Io4WXqOXdtwiF09bKELDwsm21C5P5pzyFwm2g=;
        b=E0RCz2dKcgJyDHX09icJx8/hdX3aC9l+X8JBPVS1dI/iDfL3UZ/h98Em5vG80EUghK
         Qiw1XB8m7x8GvxtAVsMa18J6HWiUidcFL+EoA5TfenMR6V6GkgxtMnPeO+LGpcRLtcJC
         0WKo+PEo1s/RRjQv/d9qu9CdaJhrhIo495xD0kOmpP2Fh5ObRBEl2q+cDlMYHTu7wgoY
         ixBtW2gH0tvF5fOByExCZ7+O3euZ8bJWrL83SBCg7f/Au0PKZKHgWJHyg7B471wB73pi
         hZyxtQbXhAgdA+zTKPt1/ccrVj501Zaq+qqPdROU4e7dedT9z4Y92EIGWQCW+qwbRfmp
         0vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347659; x=1785952459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZmGdt5Io4WXqOXdtwiF09bKELDwsm21C5P5pzyFwm2g=;
        b=EyANQvg9w/ki7uP63OBcRoQ1NpNEgzn+tNnpx2n58JqoScwG+k3wQvuLgPojbsjo8y
         FjJa7gdZMfYSIlCIHeMJkrQrZvI7JgDK94g9wwqORW8X/vDDGM8MkTkLyKiWE1V8j7dg
         N433NU55UJs7m1gUG4daKtuGT2EyyHVUl5x4gIxTUD6HBV1V9cRpU2jb8ErJ7i1zP4a7
         43MJ3twP69VhG2YCxDi3v9cfL7XX0YiCi+cZ9bdYJm/9sAi6k2K88cFmwj4ijjPQa5Ci
         kJ8k8a71pneL/ffGxKhU1JiWnQIrEPjNOOauMrfHHC/LfDDDNBhbDTipnP2q2kYRiJCB
         N1gQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKwrEeJk+w7cMo7i9gARzllq7mBqOV3ODTjPx3E18HDaLQ6QR2o4PDyhpj59NhfPraFcdGfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztg7igJLZVlGfco+Mr4QlbFj57whBW0B37xsGOReKHi+VP0NCt
	H/jlbdKg8vMM6x4moXm6vZ2FVi/1030H9owd31Y43pTnUvwme7UbgiYSdE1YJ/Gjvx54tLXOOLI
	wJB+wgTT4nWXK+oxYSGBOSI6AkVStNRFfZZ33qWtg
X-Gm-Gg: AR+sD111VoWnrJRlCHn1aHvOuqlgGOM44RNXIIc+SPnOV/ORqSjGQqCmVHHfaP9vwsG
	p2UZgxkd8CtPYz72FjB8FiPLil16ZACBMq7LJOpRSH1ItjdDmNuY2ciRarFEV+xD2X8P4FckfWs
	TOfvFTmMfBUjyddA25pFm+3wf8kbvY2PrP7LhPsERTMmPeeC8dbJK89J+jVdZwNAs3VXS++kfHI
	Dnpu1qmHZNwERGEYAPTbsOmMQiOzveI4SRc6QTN8HRdDErdvjSEps9GOOF98Twk5lDQcACwPEWL
	UNfveuAfoVN6vrtU5XK6xuSs9le054ieVBQKZQY6afscZVfO3H+so3M=
X-Received: by 2002:a17:903:94d:b0:2c9:97a8:8c1b with SMTP id
 d9443c01a7336-2d015ee611amr76397685ad.46.1785347659214; Wed, 29 Jul 2026
 10:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721040118.1000554-1-ruanjinjie@huawei.com>
 <87jyqolqn3.ffs@fw13> <CAHC9VhSohbG8n5WW4VaEjU7nVA4WCrkJ1eD-=34ioaJOQ0-rCg@mail.gmail.com>
 <87mrvgjv68.ffs@fw13>
In-Reply-To: <87mrvgjv68.ffs@fw13>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Jul 2026 13:54:06 -0400
X-Gm-Features: AUfX_mzVBYhFObFmWn4bu9O3gNFkO-pLlJdokT1yaynw-xj0j6rqRPnP05cSGP0
Message-ID: <CAHC9VhSGV+XdCdfts7rf80JBa-Sap+9uSXd-XwXqT3T4ocv-Nw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Force audit_context() to be always inlined
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eparis@redhat.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:53=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
> On Thu, Jul 23 2026 at 13:21, Paul Moore wrote:
> > On Tue, Jul 21, 2026 at 3:59=E2=80=AFAM Thomas Gleixner <tglx@kernel.or=
g> wrote:
> >> On Tue, Jul 21 2026 at 12:01, Jinjie Ruan wrote:
> >> > commit 6f25517010dd ("entry: Rework syscall_audit_enter()") relies o=
n
> >> > dead code elimination to remove the call to syscall_enter_audit() wh=
en
> >> > CONFIG_AUDITSYSCALL is disabled. However, with s390 GCC 13.4.0 +
> >> > CONFIG_KASAN, audit_context() is not inlined despite being marked
> >> > inline, causing an undefined reference to syscall_enter_audit().
> >> >
> >> > Force audit_context() to be __always_inline to ensure the conditiona=
l
> >> > can be constant-folded and dead code elimination works correctly.
> >> >
> >> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> >> > Reported-by: kernel test robot <lkp@intel.com>
> >> > Closes: https://lore.kernel.org/oe-kbuild-all/202607181530.2nx8zb3J-=
lkp@intel.com/
> >>
> >> Obsolete. Is already in:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dcore/entry&id=3D6f25517010ddd3f8080d7e06b9b1cb1b64b73772
> >
> > It would have been nice to see that patch CC'd to the audit mailing
> > list for obvious reasons.
> >
> > Since I'm just looking at that tip tree patch now (perhaps there are
> > other preceding patches that affect this?), does it still compile
> > properly when CONFIG_AUDITSYSCALL is not defined?  With
> > syscall_trace_enter() calling out to syscall_enter_audit() that is no
> > longer inlined in the same header, and no dummy function/macro defined
> > for syscall_enter_audit() when !CONFIG_AUDITSYSCALL, it looks like
> > there might be an issue on some configurations, no?
>
> It compiles properly due to dead code elimination on everything except on
> old s390 compilers for whatever reasons.
>
> I'll bite the bullet and add the stub inline for syscall_enter_audit() ..=
.

Thanks.  Did you CC the audit mailing list?  I don't see it in my
inbox or in the lore archives of the audit list.

> though keeping audit_context() __always_inline makes a lot of sense as
> especially clang has a tendency to out of line the most trivial inlines.

That seems reasonable, but as you previously mentioned that Jinjie
Ruan's patch was "obsolete" I wanted to clarify that you are now in
favor of the patch at the top of this thread?

--=20
paul-moore.com
