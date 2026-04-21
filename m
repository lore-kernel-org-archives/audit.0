Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873D3A641E
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811811; cv=pass; b=K30T7012M9AFWxtKgDooaiXA7oSuZYdS5R+HsLcauY2flXQqR0rO/YkWI9IMhlEMd8qoFf7PizSy9gQq8utmmbMQs9CjMHtvZ5NOq67batL6N5TUA3nDjfJRa2VaR26h3wSsLuUFzj0gyIXVhJbgkhW9Tgb4Lhn9hI8A0oWqeM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811811; c=relaxed/simple;
	bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scyP2N4N5JenLd2tZ6UMt03A773EqG5WDcnfPVnqXJQRmjOCxCW0ZhrbqEbF9JHB1w+WcJcMgvDddOEf0rhgh6JkGNEA/mNYVln2U0Yp0BvefX6dcBfVoJfM7gIhyQ0xDuURb7emMqxR0lqm4ofWmkV1mJWneP+x7cbi3Z9BCG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T75RJCJi; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T75RJCJi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b4650d5f5cso17845995ad.0
        for <audit@vger.kernel.org>; Tue, 21 Apr 2026 15:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811810; cv=none;
        d=google.com; s=arc-20240605;
        b=kOQw6/Qis/Vc+BRaadY6fzp8HuutDReI8X9ztSl9ozPyy+LDlWcnXOEmPUJE31xbYL
         xImoB83I6DBO+8TOLgrS55ihATcai1d/AsRMw7R8cu2ayTd2YPdVDsTK795gB5N5uSpU
         hvK1htMBj+YWFBK9Y9oVWzQHYR8JK+MTHyBPv+tCBg5LY3g8FzF8LjpwMqpElUoI0emh
         tCLq5o+nOmWAx8MYCewFIVpSUEe9nP8rmaK4DLf/O301rbBUItBGRhqyxGIsVKCNDFbo
         2ehch3HhZZzYRbb0Ryty52OR821suakYDcyl6xu5bbpP/KQCf/K684RRYgMw8u+MW8ei
         kwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        fh=wfOywqJysDS3fxzkqhbGfWGpvTaJcwRHFE4Nib8zdUY=;
        b=eNIKJn3JXTEFG0O3mzvcYcaOm4+IlPLerrEZLyAOgLceDuPNoK0y55VqPV3EMS/lV2
         EE8HKnF6epba5dWoHK1aR1IP0+IG7uTWXM0e3LMA3KBCYeYCpLP4zQW4VXETAhJkw22+
         6lz1GcB23lEpdO3Zrprkb8H5rGoUrGqGx+HTS+kO1RjkGGI0V/SsFdQMMRQ302FB88zL
         zGkFAyvwoSmQRYfCsp1C9gCEMMGq6DruamHLw9fUb9P9Pw692cW/QOlPuw+m+5kuX9oH
         gQO7MjOhk8K9KsiqEXtGuDnBVxlh4QkeExtgGzJM23GqEXFMPN5CeudBuzKwhP+ca8d3
         pZlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776811810; x=1777416610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=T75RJCJi/8g+lGjFoandwtXi2tVESI3/UIugg6CRYqICGsXnA9F0jWXhxoqU8IWIix
         UUL1wb9ZPHEFuoCB2QNnaCXPyBEmsUoQ5MFscAFA9HtA0KQ2MMZsGK2/EgFFLhXx00io
         bW6Bj7J/heMT7bxY3FrLeZFRmAE+WjVebBYr38MRBfNrf5nYqEJpja8Kl+XDGoopdYY7
         l2omqBX4MIBqbMIeVia3qbeIx1X/VPODFuQ77ZgOtL3PLa3dtg4VrPzniZrXba79Du/m
         nLZLwwz76lyTwSQHVYHkg1IXngrYczlDySkLNVsfgoZUcXrT+/GTwHT8DKX83WEk/Yyq
         2rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811810; x=1777416610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=CrC2VkveSPrWHt77PvxNtwWvaqJleiu9GJAIUa48lT6SjShvZod7RquOjkuNaIwxsC
         Be0TZnWzcu/Dzad2/js5CVSJ0ECUB9XLm1g1k4pTVPldOwBmZq1XicyH0Su9lZnf3Nqk
         ceuqnRlB2+sJDDjI2pH79km+aWjxj7gOuOMMj+NLfiOrhiOY5VH9TNhM3JhIsMT9os3O
         uavOGm45L5pJUNtWiKm2sgzPZ8mWzYHycLgDNUHsM4GCiN6TRgY3Vz7SjLstlFNOaEUf
         7Ra9d4rZGp7zbLt+gEjKtWeQwUnmLprYSeNVOb8YqaZQceDzb11SD6TlPIImQMEAGAKz
         vaTA==
X-Forwarded-Encrypted: i=1; AFNElJ/hHONIUVifqDwHWN4VNaLkmKMwLwduqi8Jh2TGRLjL1GKtAEBpT0McifgCoXsII74Q2r+jJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtJ/mzQjTNoeUSDYs8wYsBiFrIp7u7ZOiFPZiIB6Y7P7h9JZ/
	I1vYlvy4+0fWWJ6rWAHl8CBEYs4zA68eDzuihuyp+Lfs0fn3VDJAutVkmIqsIhuQNuXweZKxGgB
	28DBQbutiQLoAGVtXJVl5K0B1VZPxkrdAgAF5H0Rj
X-Gm-Gg: AeBDieu2d1xd2N8pRe3X/vwkuGXrVXA8d4XapwHNcIbvxm3YhK6m9RMJ0FuBoHrbdzT
	KB/1HZ4g0juCUqRJO+zkTcL1LMkq455EMLuSHhw4Me2JQOsaITHob9u3nvBrAJ9WmWUcTSal+tC
	XOT/Xq4Wg1dsfmJO+qjLU2mdir9pZdCuQO4Mz2ymjnC+kpZcgkPly3VRPFKQ8Hcc6CDUyocnmmE
	kBKFb6KVUn4KTPMvVn748mQWxvX++xjqekZFOZb+gobwNVa8OnuKaOX+sStPKadL3TOkfLZzz6/
	JwQnmMNMPsBaNbm/cw==
X-Received: by 2002:a17:902:be0a:b0:2b2:481b:de68 with SMTP id
 d9443c01a7336-2b5f9f8f446mr154652785ad.35.1776811809715; Tue, 21 Apr 2026
 15:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com> <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
In-Reply-To: <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:49:57 -0400
X-Gm-Features: AQROBzC8n0JJ9DjsWU-7Puv6JCDhA7IZFjxayYVxpNJDKTQHihIrjlR17p1FK3w
Message-ID: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
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

On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > > It's still Nack.
> >
> > Based solely on the diffstat and a quick look, this appears to be an
> > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > but they are LSM/audit kfuncs and not core BPF functionality.
> > Regardless, I want to see how the LSS presentation is received before
> > worrying about this too much, but your NACK has been noted.
>
> Paul,
>
> told you countless times LSM cannot touch BPF bits without
> explicit Ack.

Based on a quick glance it doesn't appear that Fred's patches touch
BPF bits, they simply supply kfuncs for users to use in their BPF
programs.

> So, no, you cannot add bpf kfuncs in random places in the kernel

I see plenty of places outside of kernel/bpf that define kfuncs.

> And, no, you cannot call bpf internals through bpf_map_ops, etc.

It doesn't appear that Fred is doing that in his patches.

--=20
paul-moore.com
