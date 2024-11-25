Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C51B87CD
	for <audit@vger.kernel.org>; Mon, 25 Nov 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563323; cv=none; b=t3nrA7jGN3em0jddx8FZYiN0l45PuORm2XSvHOHmMhCMgGADNfJ0tE/7LVedleeV0AxmpRAo7sncOXZXG2QUERGLuOJ2txr382d9A9LeXzqB8lcv8okczU9ZOQjh4Kz6FIKlXBOItQJyXvKBoslRK62krU2JpgIHfqhYfnZ/m6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563323; c=relaxed/simple;
	bh=54RqcZIEYDefe8bmhEgsgV8Um5TmPfMXzPvftggRdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9DB8QgucC2DBs68uBqfNNTOQUSMCQox3wT3kHuVPYjFNahTszwrclh53Ho/wjRq+B2h0Ue8rF/I+XagbvNSzZypfpwWEphyZ6YjO1Bj8HwNxG4CpNoKSFHxjuRePg81bSF37rOvR8FYAXLdJuCRZcMnrcds+q1YayYvcpnrOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcpSLoEN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcpSLoEN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso6301480a12.1
        for <audit@vger.kernel.org>; Mon, 25 Nov 2024 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732563319; x=1733168119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWhH05Bm9KZ7sByGo33urKUrEncVx+V1FdurLN08RYI=;
        b=BcpSLoENfybDxiUzVMPvrlVVCOCvvyiUSgj5hZOcseXTNxKolmQ4BHkreWdv4fkOFe
         7inys9jZeTMk6Etx2qSNbxyj0YDMZaMpux3Sq8n4DNX94+aBiP2TVOJjTn0eyGU0tb1E
         xLwhRQ0qkjjI08cukiF14ca23ak+Xm0RYdMFR2dHZtcWtEK9vZiiZTzo6gVutb8ySj3b
         F6YODdQazmtTCeQtRI7eQ/u62/fzenxKT2S+YcHYqINYy83o1eM1QDaJFj/CUg0qvBnu
         KhJ9vydpwq7uIiUTdkX2bSGl0FLwtGHey533QAESrnRD6ON77BagwLiAJWK7sTx8Nb1B
         R8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563319; x=1733168119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWhH05Bm9KZ7sByGo33urKUrEncVx+V1FdurLN08RYI=;
        b=ghTdr3qszJAY+Z8wBFbjWA3rXqh9cU9jnW4bzUKmy7G8mBW608j9SrPaTlXy6JbXhn
         cqgMvxHBJfvSeHTre2mxuVzHyOsbTFLGl9Af7TIZsnRm3eAGvFE1QF0NJ8KRH9CdCNMU
         1cW/rCkZVj8M16W236H5Gich52YRxKqDyjPk1FhZT2ZNcYYTR054T7YgNLnn+tFGsJwJ
         vpTPK1vCTVM+Rlq3bKSXD05ixzABGmeRySnrCN5QfiGu42A9GC1PTM+M8rqJAMjd2Nov
         HadWZC1FOXEBkuvL6w20pWXEZRpQlzKSjsHPYRrPQ9CkLp8fzmQLTtNWQxN2NH4r29do
         7dLg==
X-Forwarded-Encrypted: i=1; AJvYcCV8h1C0eTwcBTZrFOdu5ab9zc7wNVd10+qXOMkKvGQG/sj8HeKHu60g+EGvm81iB7TqaLTVmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcv70JBSqADVR+UkYb8XlKT1Xwyik5ltbJlIoqK6CxU2m3gEsq
	TwVF6IlzTeC15PhV+OxM0SvGX3nhj4kq1IOu81NKaXjAlBGFdXpfqAQMnbMXyA==
X-Gm-Gg: ASbGncsqhWATSe0X3MBV5CrNUHTgKO61xRZ06aW++QoxneBOoRoXW/vd9AiZivbyhoy
	NPRYQLpa9YmGL0F0n/hS0yRfE45Nra5G6dZ1VYnpXtny536AZKL6yvMxTFW0OW9TOMDpBFdutIf
	zE9xoktrdB45ptpFd7ASzmvcOeFJtaneUpTEtGYqZPJkb/3k1OFeLjaGWFHmD74kI4RkGiv79EA
	EvYjDiG48Ix91I5PAFx4l5HuffU2niretPxTY5YaRa58wslbzIi7uUtcO9Sx2HbL0ikNLdBV984
	LYELRk3wGcJsVsyEjnw=
X-Google-Smtp-Source: AGHT+IEOPvAAr+8PRfHA1PcyllOYQjEhFE9OlwV7vpKSDmpIC7O4Fv+Vu++U2fhwJG2qbtsaRMl7MQ==
X-Received: by 2002:a05:6402:274b:b0:5ce:fa47:18b6 with SMTP id 4fb4d7f45d1cf-5d0205ff1cemr11001676a12.12.1732563319336;
        Mon, 25 Nov 2024 11:35:19 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm235348666b.62.2024.11.25.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:35:18 -0800 (PST)
Date: Mon, 25 Nov 2024 19:35:15 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, audit@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
Message-ID: <Z0TRc0A6Q8QUxNAe@google.com>
References: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
 <CAADnVQ++-VwPnem-xY+Urec0=zi71s-Pmzox+TXYgaVpshHtEA@mail.gmail.com>
 <a77471ed-1c18-4469-be4c-c9e00f8a3b80@t-8ch.de>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a77471ed-1c18-4469-be4c-c9e00f8a3b80@t-8ch.de>

On Mon, Nov 25, 2024 at 09:25:24AM +0100, Thomas Weißschuh wrote:
> On 2024-11-24 15:45:04-0800, Alexei Starovoitov wrote:
> > On Sat, Nov 23, 2024 at 2:19 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > >
> > > The hooks got renamed, adapt the BTF IDs.
> > > Fixes the following build warning:
> > >
> > >   BTFIDS  vmlinux
> > > WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> > > WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> > >
> > > Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  kernel/bpf/bpf_lsm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9e4c14812a11aad2 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
> > >
> > >  BTF_ID(func, bpf_lsm_syslog)
> > >  BTF_ID(func, bpf_lsm_task_alloc)
> > > -BTF_ID(func, bpf_lsm_current_getsecid_subj)
> > > -BTF_ID(func, bpf_lsm_task_getsecid_obj)
> > > +BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
> > > +BTF_ID(func, bpf_lsm_task_getlsmprop_obj)
> > 
> > Maybe we can remove these two instead?
> > I couldn't come up with a reason for bpf_lsm to attach to these two.
> 
> Personally I have no idea about bps_lsm, how it works or how it is used.
> I only tried to get rid of the warning.
> If you prefer I can drop the IDs.
> 
> In my opinion this is a discussion that would have been better in
> the original patch, if the CI would have caught it.

I agree with Alexei here, we can probably just remove these
instead. ATM, I don't think we could do anything useful with them from
the context of a BPF LSM program anyway.
