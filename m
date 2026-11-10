Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310706;
	b=a/jeQ8It0cQuexSZTp8jhqYvQ/AyP4SIuHCEghIV+6NbHMRRLxpDA4B1IK2G+Nu4/y3c
	 08x91Oz83Y61xWfM7JjeIZ4eKZGA8zeWrUXPYG7oEluWzogwlFPdqImYAttVZ3JVM65I+
	 h1MzLUWxbF968qISFynP8jy3q/fomLnHkv3bJzW7cdBiYJJv9NxaKhqUFOpJzuBqhRsOy
	 2uszvtEuHO+8+UZCpH7xBz9V4SMCWT4oZIsa8nI9iQEKjTCFF9bXPfYet6iT8yybWKonL
	 VYmQOLN6zmxsDv/DXkmKjVAlkOYzMnE3YwZ6G31suZlBYqhCv3FVajjT3i+PXkxstlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=loADPLCtnBO53+Lsor2CzGRBv3wArN+AInurgrNEg0Y=;
	b=O+6+5490BbDTd6CbjFsF/G7CDW4rKKrVNGQDOXB8uoJYMPU9x2U4ejVaCXNIGEoIaLao
	 t4u4ToEpKzbSiqKc02sKIVPF98qnqMD8KaBzSeMN8IsLahLXEdK5E/XOWDsMAKM5DfX4j
	 dOQNi7IUB2PyWw+p7BS45iu99fdXjxxrcc33RL1v/ewjpCHW7nmVeEUpufXACeQj8EjNg
	 XsHJvnpIvoQbvHRE2h1WM7mbMmjzdXy7Jul9akQT/hXEQpInY4U50QU50yUdYg9LEOXlG
	 XIPI6hshqN1mrFRjVr5SexApMOmRj1sfFVsj3nTC4UOju9LZ7D3yMfAKq5waj8i0+Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+5rvkR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC07606A32E
	for <audit@vger.kernel.org>; Tue, 10 Nov 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+5rvkR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CC1F0089F
	for <audit@vger.kernel.org>; Tue, 10 Nov 2026 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310705;
	bh=loADPLCtnBO53+Lsor2CzGRBv3wArN+AInurgrNEg0Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=A+5rvkR8z2q1lhVSU7RJTz6tUrjcMayQeCp4wcE4Nlg5M72nf92juO3+sdORaKuYu
	 EZEQw9KJ1HWhl4byXAjcNyGTV5ArBWwbZiqos3aObTTQ6TLDUioL/BYEPuRwksQaEn
	 kpfyaZR44xVYiVS9rw5HQoQFDYIGw/uXtxti/870I3YbhYWQxIjr5IfsRnSdBK2b1B
	 ap+Xp44Y5UIzTkB4pRyZJyfNMmWplfGPXawf1eu4w9Ri6hXWU/YOOAIMlgbCWa+CS9
	 1/C6YsVWu4OuHlHGjNBFvSaxVhCKbdSEglkzKUMU01sAjMR8ufTmNO7v34TpcTVi2c
	 dPLlod39rgPGA==
Message-ID: <sashiko-outbox-206944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: fix incomplete NETFILTER_PKT records and return
 void
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20261110122939.45373-1-jiangjiehua1@huawei.com>
References: <20261110122939.45373-1-jiangjiehua1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:38:24 +0000
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

> Commit f19590b07cb6 ("audit: add audit_log_nf_skb helper function") and
> commit 15b0c43aa621 ("audit: include source and destination ports to
> NETFILTER_PKT") introduced audit_log_nf_skb() and its transport header
> parsing.
>=20
> The helper returned early with -ENOMEM when skb_header_pointer() failed f=
or
> the network header, and the later port parsing did the same for the
> transport header.  Such an early return skips the remaining fields, so the
> NETFILTER_PKT record is emitted with only "mark=3D" and without the addre=
ss
> and protocol fields.
>=20
> Log the address and protocol once the network header is available, and
> route the error paths through placeholder logging: a missing network head=
er
> logs "saddr=3D? daddr=3D? proto=3D-1", as the pre-refactoring callers did=
, and a
> transport header that cannot be read where one is expected logs
> [ ... ]
>   after:  mark=3D0x0 saddr=3D10.20.0.2 daddr=3D10.20.0.1 proto=3D6 sport=
=3D? dport=3D?
>=20
> Fixes: f19590b07cb6 ("audit: add audit_log_nf_skb helper function")
> Fixes: 15b0c43aa621 ("audit: include source and destination ports to NETF=
ILTER_PKT")
> Signed-off-by: JiangJieHua <jiangjiehua1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110122939.4537=
3-1-jiangjiehua1@huawei.com?part=3D1

