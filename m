Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FD36F41F
	for <audit@vger.kernel.org>; Wed, 18 Mar 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867326; cv=pass; b=DljhP4dYdo5f1br2XWDsX6SdCon2MAsz/JphBGuSiFk6M5g6GjtAFohyaiwZmIJHv1jXcxjIoQiEmNF665rEfrzE7vAI0kkhGABqMYH44OwREcYyd7ytsuxa8+TjEyMvtqmu9H6s4nnL0u1kIg1k6BxcKZnnMKWxlF8kF0DJmCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867326; c=relaxed/simple;
	bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQBbTO8JDqudi+8EJX84lE77AxO0tnAPfxl6lsEFP4Fiz4lToEODWdrW7jZHECXqioyN6ATL43OSBwI8QfZ0TnPlbb4wZ5237+wGy9h1p6zU7vgQp382d2YlugifwUopti+QTrK+GHj4RZ1k93r41mD65Csj8gpuoKtf6Q2Yl7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8LJKVM7; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8LJKVM7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso2365995e9.3
        for <audit@vger.kernel.org>; Wed, 18 Mar 2026 13:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773867323; cv=none;
        d=google.com; s=arc-20240605;
        b=HBXKZZ24687V2e1peMa0XdD6TH5cUHo5aaIrbMKmGi8KePLd0yhi9bB3Ev1AJtO0F4
         5S0u32qx865gjvtxczD0GgXvI92W/UtbMS5nh3R1UItglEbxvb1Bn8d1ufOGS/O89CPn
         8ymvWIXCqNGSgsGTcshrvKGk4H9M1bTqi7casTdjxs8vkgjYVa1UbEeJnc0iTWh78Ae2
         PN2OyU/N+mLi6BVB11idrycXd3p3aFwYJspPn4RSWjlMEWXTPRQsox/U1iRC370SO55a
         o/NBYjsGrD3d0zlIdTngmRDIKjhY1lOUwRizdZz4if0/GURZNLvIOph8gYId+paxnWgX
         2lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        fh=a2PWiXOfHMeJE+0DKUiOCSrjpe6wjJORdOpoQQbOmok=;
        b=DTdv8eo7567HoQRUZID6zUqBGTz3kXEcSWg+BFba8Ru+4WTKHKwyKWFexu/GGvxftU
         C5xLfhdAjxOHxaFeWavwLPXD4Iv4rf29Dxma+kIN9RHF7MTwVF82kABNq0pte80YdYMq
         5OKv+P+AmL0snMnIeqgInBGUL7kz8Nv+bcXd+2kmcsdoGJBmln2OHfVUxrvu3gk+m2We
         Va3k6zK7fJU+qIEaNTXNUTp91bmcpUrC9xVu63fUt02nf/1QsFxQwAV/fBCGPLeO1Kw5
         ma0hbHDQ+cdjz0ZCfEGjF7NkO+kKCHNCbqFFaf7s2Fciy03wZIhJzSzBpYOlIkmePYHN
         lhPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773867323; x=1774472123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=j8LJKVM7f+xyj0bLAmUHN3o6UGd5S76QQBs1GbDzIh3gzq7u3wNKaijkLom30QqaRa
         t8bzygh40P/SS2d3EYc63SL3W7yYcLbgEHTRFNPcnQ7/KcKonBguxs8ru8Yy2QAfk4Le
         GwNbvNbOMrk+qbkIKadQMr9dQIIAAF/vhqQQOZ+SHQztR1Ubl9VnKWbiUKNVQqxnwUkR
         bSblbLaZ24hT0toaeSW9sWgStYF7mjaI2u9+933c/fdnSQGjBHI7Uw2wK/Vk73L3HL40
         Dv2QT25gY18aDrNu26ZyHOBp/aoc8wf9CT7bdRJxIq416XysNt07Gk4r60GO9jViz0Sl
         hyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867323; x=1774472123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=Cnt6CxNOQafOcwkLTMvliZgX1G0ASjYS/BaizH4ix0qv9VpHNX6jJX9/KX7jyP4fJZ
         3R2jP/zYBTHmPpB84RNn+nV3nI/eOBz3hSHL28Z/a/22XVMv/IGjGklARW29WV5nNm0O
         QlPoQkRxXG2jnUVq1hbdSSblSpAc4/R3h3Sh5yPKdu5hJaabkitr0pFPyrniq6ubcuVv
         5/D00pbSptYw3dKRQy76aXXLAs4v1WTfZUiWudkRFkFtQY0hpKmXz3ogcAyB5NyPddu+
         kqFziKOvGoIgZHZlSDsQoU0X/8CO/XiUmpfwRsScypG3Z5r/9S8O3ubIxzLTamz7lJfv
         PhHw==
X-Forwarded-Encrypted: i=1; AJvYcCW16APH8NNX/fsu/MMS1Nj+04wLV8fDoDio/mGz6uj+dJDiMxgikrX7XRGab6UR0e4+vwjLIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2FEAr6CfuqH2VRaaYuu56wHC/oCXjcF7QAOupXh0nLuZATbM
	xc2W4dOxWslobepiJcQUy4hVocBBFDwiluVPElkdqRz8BD2CKeXVr7hddaX8uJnGs2w3KjT8vso
	wR2K2DIVMZM05wPuwNqLOk4ae59Gz0eg=
X-Gm-Gg: ATEYQzz2q9zolkVSkKTkRgKiCyG0/NOIMXIfuaMO4jtapisBR1BcZQwMl7lIVsvf9po
	QckKaKXDuy+9QU6lG9qiY8tKlGUg80T9aY1fPMdigfjm0OPp/3UtFbD2GFqTQ9ilreb4/6Htub0
	kewkzxpYXy7wVq8hthUICOcLxVBYX52UUqr3+ZRSpzzmMdpEnD9Vb9EhiUt5JHlL4OdcLi8AXdm
	VUbfI+SjQRgxyVV8LUTU80ZlBslSN6GHjV48pLyB/foce5X+wDSjCP9rzDAxiFOUvC4PnTnazB0
	IG1geHdw2Z33xdDXV3WTtvDyO58e76QoJBNadB7s8+NJmwYXr9mqXmhnKvfqtn7MnxK4BuMJFxe
	Vuink1f8G3iQ//5URmxIy9X8ZoDxO3UugjmfN
X-Received: by 2002:a05:6000:2204:b0:439:b62d:be86 with SMTP id
 ffacd0b85a97d-43b527d2d87mr8541610f8f.47.1773867323192; Wed, 18 Mar 2026
 13:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
 <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com> <abrlvEjQKUdAOcw5@CMGLRV3>
In-Reply-To: <abrlvEjQKUdAOcw5@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 13:55:12 -0700
X-Gm-Features: AaiRm51tc55ib07MZtLJnTRuXxmrfDK1FJuMhF5fp5fXwEvfz5MooV7eUnvCNQI
Message-ID: <CAADnVQ+hNWY2Xd85xHySLN1gJD2paxPne3fAzeXx=De9tA5JNQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:49=E2=80=AFAM Frederick Lawler <fred@cloudflare.=
com> wrote:
>
> Hi Alexei,
>
> On Tue, Mar 17, 2026 at 06:15:59PM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> =
wrote:
> > > >
> > > > The motivation behind the change is to give BPF LSM developers the
> > > > ability to report accesses via the audit subsystem much like how LS=
Ms
> > > > operate today.
> >
> > Sure, but bpf lsm-s don't need to follow such conventions.
> > audit is nothing but a message passing from kernel to user space
> > and done in a very inefficient way by wrapping strings into skb/netlink=
.
> > bpf progs can do this message passing already via various ways:
> > perfbuf, ringbuf, streams.
> > Teach your user space to consume one of them.
>
> Audit provides additional functionality by keeping messages close to the
> syscall, and in-line with other messages for that syscall. Aside from
> that, BPF is arguably too flexible. I'm sure it's already understood,
> but the idea here is to reduce bespoke logging implementations and reduce
> attack surface for violation reporting. Audit is already provided by the
> kernel and a well leveraged pipeline.

Sorry, I don't buy any of these arguments.
Nack.
