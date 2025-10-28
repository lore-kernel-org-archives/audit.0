Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF632857EA
	for <audit@vger.kernel.org>; Tue, 28 Oct 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664710; cv=none; b=fAzV/TzMc2/t+sqbvfrGd8vlSZwZuc2eg1aa2vDEGRoS7+EURFiLUAJfgAcrpB/xT4N3Xd5+BysYAbhZ4pEzpmn1UQQ3rDVzBgW81mIvQ8s1BiVraX/Zf8mP9x/b7sIUvbH2aAlPSDaYy8oYOsIatGjSDbfHteA6UK0MdyKlsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664710; c=relaxed/simple;
	bh=F8e8WmGYtiSIz2ZPl4Tlwz5ZEbUBxeuWsXenRkSuRIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIcKpH0QR9I+iYJ76ZP+h9U4LIt6JKY7VoOhfbYanLOdggqscc8ETtToQesuwUhnQ9+lLMMGIV/LwVUsh5CwZCqfRbKSxAV5PLJeWqbH6ZeQ3RcM2eH3h72r2oc5XHB3Mi17OHrZoLup25OLJ0x8vQxyGbE7rldb/2RQ037JNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aPgIESFU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aPgIESFU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso6547509a91.1
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761664707; x=1762269507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyP7cdj89rMrrTPrjzZN0zWB9L8ktToD2ZCaFwPw6WM=;
        b=aPgIESFULDDgUYkTMzXh1LVWLZXkfPhgmMC0b6JL04+T71TF8ZT5auySl1c1TC+gRs
         OG6oHowTlgk8T7SzC/oeFOM1D9jNW68FrgJXrPTnleZf6ZVe+TdjYW0OhjqvwGuDP5sX
         hQks2fRbRuaLcPDeBd45qRIzb/V8rtE9sIhZDgIGmTD6H77c90jLcU81CrBgc7o36j3X
         Pds5HTbNrwbtUJbsQ48AHX3o2I6ke98XuwTvrqFeEdQfZ/1mY29GoedIt/erHpRp1RaL
         CHfz08y6LpQ1OKI4g+ZdqzFYNmJF7FujXPmbMPdMrfibSFId4ofgfXcVWnWTCkBaUuPE
         A4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664707; x=1762269507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyP7cdj89rMrrTPrjzZN0zWB9L8ktToD2ZCaFwPw6WM=;
        b=SSiuV/rtDWPCVujqycMyh6P1jgmLqmi4xAozPKNuOhROiwafNc0DqvJKxUH7uJ4De1
         mqdTpvm9eX9plXOEms+cyg5UUUHcc9JiolqYtK3JF0drpRyfmAEFHRBg5KUKvA0D8arK
         lg8HeQOrIcizVQnQoe5bka6i6TFOWAb8r5vE+GXv6D6INhSDGET7MWe5IygqfFXSap+s
         nQQOvYx1fNVs7nAnHDQJKo6sk2WVPK8Q5SgCtn8EDYCnogAAApYRSRxGW3X0pBVFOt3M
         qg+Hms7CIk77nK9aS5c5N4m81/WMfWnJG995c562MC74nixyOHwLDnIJ4f/3udjgXxwi
         X4og==
X-Forwarded-Encrypted: i=1; AJvYcCVj7PK4Q+AEU5H47AOSBRPae9gJb2wfeaq7g3CUrbsZj5MH4TJg45+rluJ04p9anCU5ki0ZwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7tYkHxGdBwkPgRiGc6fc+Y0jZsEKVpFWthvzney5kQBRdMfd
	wh9DRim/Db1lyL7GUlocRKVKHIQWGfZua3Yotg8gS5bHBikkROQIBy8nLkMVT+YLq8Hr4BhpaDr
	MWHeqXJ/dcq9veBQ4wU14XX9CktcIJfReqbTlZpqJ
X-Gm-Gg: ASbGncuzl5oqBxwlvXBa/VcU3ZCQMpz4v+6WnCfxFyznvWT6Q9lEBKNpR2JqTm3OFxy
	QAM/+GKeqxZoclpM+eM1eR0jG8xPlSCdGbqE45RK95p9nKcZh8gxvzl8BygnI5gT3LAD6kvAcq6
	Jx/vMhhnFEkF4Y88ydsNQ38SenpxV9euCvTdUJGFHpPqdpqkUHsQ0DHwl7kOCKidGXBr0PKht9R
	gNgtCApjEUtSJ3hx56BFYzpUpM6MqfuS7tv1kTuluRHJnU8PRHDAHWLrnQgbiTOwhxrfTc=
X-Google-Smtp-Source: AGHT+IGlNBZmXJK4qpsxQZzDRtVN03T2ZwyYcgh4TjwsGO4aVJnWhY7BZRGZ5o3S/2uKbp5fs3jAsBMy6IWDGwXqTfc=
X-Received: by 2002:a17:90b:5825:b0:33e:30b2:d20 with SMTP id
 98e67ed59e1d1-34027c0528dmr4786413a91.33.1761664707233; Tue, 28 Oct 2025
 08:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org> <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com> <aQCE0WwGlOADI5xT@google.com>
In-Reply-To: <aQCE0WwGlOADI5xT@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 11:18:15 -0400
X-Gm-Features: AWmQ_bmm4t5z9CNEiMIeS2ttD9ySj8RRIc6jeSHuj0OZ3k34EbYuCM5QR53_mCE
Message-ID: <CAHC9VhRTN_PD9f4gNdwZFk2QjYZ3_Vc6Jfmircr2cS49CZ005A@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, kpsingh@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com, 
	eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:54=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
> On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> > On Mon, Oct 27, 2025 at 6:45=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Mon, Oct 27, 2025 at 2:14=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> =
wrote:
> > > > >
> > > > > lsm_prop_bpf is not used in any code. Remove it.
> > > > >
> > > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > >
> > > > > ---
> > > > >
> > > > > Or did I miss any user of it?
> > > > > ---
> > > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > > >  include/linux/security.h |  2 --
> > > > >  2 files changed, 18 deletions(-)
> > > > >  delete mode 100644 include/linux/lsm/bpf.h
> > > >
> > > > You probably didn't miss any direct reference to lsm_prop_bpf, but =
the
> > > > data type you really should look for when deciding on this is
> > > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_pr=
op
> > > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > > struct/field in the lsm_prop struct a BPF LSM will be limited compa=
red
> > > > to other LSMs.  Perhaps that limitation is okay, but it is somethin=
g
> > >
> > > I think audit is the only user of lsm_prop (via audit_names and
> > > audit_context). For BPF based LSM or audit, I don't think we need
> > > specific lsm_prop. If anything is needed, we can implement it with
> > > task local storage or inode local storage.
> > >
> > > CC audit@ and Eric Paris for more comments on audit side.
> >
> > You might not want to wait on a comment from Eric :)
> >
> > > > that should be discussed; I see you've added KP to the To/CC line, =
I
> > > > would want to see an ACK from him before I merge anything removing
> > > > lsm_prop_bpf.
> > >
> > > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > > with his Reviewed-by?
> >
> > Good to know, I wasn't aware that Matt was also listed as a maintainer
> > for the BPF LSM.  In that case as long as there is an ACK, not just a
> > reviewed tag, I think that should be sufficient.
>
> ACK.
>
> > > > I haven't checked to see if the LSM hooks associated with a lsm_pro=
p
> > > > struct are currently allowed for a BPF LSM, but I would expect a pa=
tch
> > > > removing the lsm_prop_bpf struct/field to also disable those LSM ho=
oks
> > > > for BPF LSM use.
> > >
> > > I don't think we need to disable anything here. When lsm_prop was
> > > first introduced in [1], nothing was added to handle BPF.
> >
> > If the BPF LSM isn't going to maintain any state in the lsm_prop
> > struct, I'd rather see the associated LSM interfaces disabled from
> > being used in a BPF LSM just so we don't run into odd expectations in
> > the future.  Maybe they are already disabled, I haven't checked.
>
> Well, it doesn't ATM, but nothing goes to say that this will change in
> the future. Until then though, I have no objections around removing
> lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
> place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
> harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
> context storage mechanism.
>
> As for the disablement of the associated interfaces, I don't feel like
> this warranted at this point? Doing so might break some out-of-tree
> BPF LSM implementations, specifically those that might be using these
> associated LSM interfaces purely for instrumentation purposes at this
> point?

Okay, let's leave things as-is for right now.  The lsm_prop struct is
an important part of those APIs, and if there is a need for those APIs
in a BPF LSM then we should preserve all of the API, including the
lsm_prop component.

--=20
paul-moore.com
