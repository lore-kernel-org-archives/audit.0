Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042743A1A43
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809707; cv=pass; b=Uy3Q2UakTKn/Vpo2VpvKg6rKGlva3yyXrBuyLUoZIqFK/tkwEUw1Up79FqxOHCOJ31/9F3rJhQDU2byF4voJIpAJJJhia4/lEHY7Y1VjnEKUt+y1DBzu4iZoQYkqP0W5e0GzEFYxukXI1kchhGtu3NeNxnZuyf0LEhqn4pJqIzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809707; c=relaxed/simple;
	bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI+wkxUaZ1prxGGyltB1v8UZNI77WJK4YaTy/b1UMSpc0EANuWuJ5EcYOzQuA54QZHaff+eu0sd9cR1rHLmVkce/ARMH7vwAI7DB/4lY4HtVlBWp1tLwY2r5vzz7tOnbX/xBAsqMeAanHYnO3dMCErvU3wORAg89fECHgnXoK6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyW40bs3; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyW40bs3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7650202fso3701491f8f.2
        for <audit@vger.kernel.org>; Tue, 21 Apr 2026 15:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809704; cv=none;
        d=google.com; s=arc-20240605;
        b=I6mcdvykVyWM+R3yO82MX6Wyc3bsV74ksm67las1ag6q4C7MdZTuWY1tMBnDF+tZJc
         BU6BIRGO5/DVNaut4X5j2MvOd8Lk6k5KYayxceGhCPTwQDf9lpmWdBk6fS//sLU7G7tE
         ICLurdZpg1OhLI/It8zYrQavjPhs20XlUKYriFP5cDpcNd1xI1jS99KfHgfmnJ4Bf35G
         BCDJ/VS+xXyzwBE+4UEgp6KpNEUJHh/d1b7vOYkeX6idjp/kYK2SogRD2wxLElRnGCqj
         g5b35yA+K5HZJQZ4K/u2mRqoPebbiNJ9J9mQ073ZYK0DGEmZkmzJePrcp9GSb/4b0IaS
         LSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        fh=yaDKUyA49ZpzG86XP5jnuYE3yGgQNgEfeU2n/LS5G5E=;
        b=McoHMNud1Xt/yEorDBI5LKn+1ILrzWNQ+JA1/gFecHhuOgH+UmmHt/SqHRgiqOqnsC
         WOp7xm9RF5jzwsIZFmNBB3NXue+9mBUqqY9viSj5LK8I7aGbOIUP8c2M0t+gijLcgtvu
         bqlUR9GjlbyHwJLZI1SRM+cQNZwFYaMz3WNI5twxXOzwVmPYBzAC2cul4m3izQ9x4D+I
         D5BsW/Na1Iq+XW1LXBBpW1UqeaURlUm3kA82zihZ3de47j+QVBie/gkm5X+yTC9FBMIn
         gmG7dtInuGAHosc23OWrq2RHXQnrEKSfgCsCLSQwaxZJ5JOuEDTu6YKn7g2owozaU0Gv
         4TTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809704; x=1777414504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        b=SyW40bs3pvYSD6Zxq35BIsvasL9iCLeKK8i6S7Q3M4KBXnv6E49eW6UMlqGKayZPg/
         fh7emUQW+vCw6/DICpkj7Dxzt5rA9b5TwgfO5SKnzLxf1UmRwalNMDOeI0h/15qxkuW7
         w9FUloddTQJ8X4DGmkhCVrf3K/VEjEf84O7WmlukVbEVw8/BvqHQWI05UtVWPhYpCqwk
         QJxy90OskjJgOGHh9pVTbIHbV8T6UAzNzv8a/DCpL1pN+WYLN5vb4dxU9888FyuFCV2g
         tCbIuwVt74wcfrqRAFASm1oCamBQlMseOBSCfXePu6iO3RK86zV801og3mKEcLhr30QD
         J/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809704; x=1777414504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9YiUiySMiRJh9aThR6CiNe12ewJmvjGzxDuXa4PXJI=;
        b=OukMnhKh3Ki3uhPOB0f3i4Z9Q56figd9zILcdmwk3EzBFB/GcbTpJJCmQsDXrMSTzI
         xaYdyzILlm5u5FPSujwdDSLmpMdfaayrwWRQ1KOEdYg2n+WjRYdNWpuWIm6sL6MXwRc0
         tIhZ+42ZWVUCAi4IhSpr7fnf4CldsUn9Vs7DG9tmQU1Rjvpl0FXEf/Y0AmNi9Db+nEy4
         bYdDSfPErxwJuR9RwIJN4/nVw6fWV2XuORME5ASS4yiO8sdF7rW35NaiTgsm0LUrgczm
         vu047LJ8mLNLBcTxGW5iZRohe0as6ObEgu3XMx6X25UnSE5LUP3m5PXXgmSe7JWIWYkS
         veGA==
X-Forwarded-Encrypted: i=1; AFNElJ+5v9h0IQ9a/Auc1mLr+9dkGhYBclo2vfvqJFouDoRx3abnkdBzJ3kuC51ASERwW6NQEsCGNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTH+STPpIA17GDXB69voa2EjF4UhqJ01W2qK2UDJZ6Xf/NPcb
	/s8/OfmWTuxJi9RuO3OIvlwhe5VdH6ieBbQE4rne5Zs/ioM7CUVMjiDLsRxyIN0TkTbjqF2i/oQ
	Hpl3mBVtKutH7jQBfmPN/K/pvrzrMOCM=
X-Gm-Gg: AeBDiesXqov7AHKGl39pqQ2bYY/dVkpIQGzz9PAus2IG4hJRI3Ar0q9Hb0Zj/w2t3pD
	SW5DY9rJoJNjMPhJc3WPfKDWrT+8ewo5P2Tu7YsTbHSozDmuZy+ibdGF4ABmJrdxfD+6YcnRFiv
	6epB87OvIQFavNGY06rrCWnlXHafQHBlctsk+36EA0T00v68e2DZX5nCeO4AqwQXF/oWdbgE7iZ
	Aiv6vdzw1lwkqE3Q6R9bslSlcCc7J5Bsp89EQKldzk39XXEe2LefQLua/vv1tHhaL7FcUIDuGvH
	CrZMuLimn6PdjRZa89lT1WgDoSqz0/evm7L06s0X44jlKfTdFS+hvre3SwMDVpN156/OX7YZFHh
	dEtfWKyFb4S850XcoGi9qgiAkSUOPfnTxaPcG
X-Received: by 2002:a05:6000:1a86:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-4411df54848mr8169717f8f.42.1776809704286; Tue, 21 Apr 2026
 15:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 15:14:52 -0700
X-Gm-Features: AQROBzBdesRGwaAbHppflZu2UlSyoGakl7XBoNVRSXZffbkUa2RMfex5iK5obzM
Message-ID: <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frederick Lawler <fred@cloudflare.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
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

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> > It's still Nack.
>
> Based solely on the diffstat and a quick look, this appears to be an
> LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> but they are LSM/audit kfuncs and not core BPF functionality.
> Regardless, I want to see how the LSS presentation is received before
> worrying about this too much, but your NACK has been noted.

Paul,

told you countless times LSM cannot touch BPF bits without
explicit Ack.

So, no, you cannot add bpf kfuncs in random places in the kernel
And, no, you cannot call bpf internals through bpf_map_ops, etc.
