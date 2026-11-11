Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414439;
	b=QEpUMZcWE/pRNsvukd+7gO1j3/6qcXG9/yGepH20WQNlt+pcQyZFt0bgAyvzMsT6LaSp
	 aYkirh+TQborXkEoAYYbtQp8CYL1n5W1Bb/2nTr6NMchkZSwV9FQLGGwEsaVI7U7SO0xm
	 CMr07pCama/P3i6zdk9ufwtRrCXgkVwX3Zap/T1iOA3oGBwaAR2bGSKlgcjEve9c0vhA6
	 FyYvfwmLOFZyXhjsQNwOoFOPvo/dUMLOwKvD8jOZGPUWMZ/sI4oQNy531I6O0gda2mvPC
	 Ux8dC+nHTpIhol/4rc8GGJEHKiDS+N+awu48A4bHdH+zbTBv808dlIp9MbBCmtLSqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=19L6lY+Nj3bXDc4fkgOTMmZjbFzRGMFBM9Lv01QBabY=;
	b=YVbTcqrhqeXgb8kIbm7qih3XlcdSxFU5vzMKGsVvlcF2sq5v5T2/kvW4ztL2Pc+oFxUU
	 0qU/KWCOpZuy+lAVNK6tetpOb8MbZoUFJhVuzK1pBXFehORsXfRCG2nxh0k+AKvT2DOyG
	 OzUxupZPIaoEFqbUlT6gv6oa0iAzg0Sosr2NyGfGgJCRN8r2vWs4/uN7F83YS+fjKJrp6
	 NMXTSdU2nogpO0ZJl0oqMap7dA+uXeXC+MpNbWO+r8wFX4jPIZhVqxglVH96ngDw+iLt1
	 XTTzqTblsBHkpyPFAo+t0muD1s6Fe7u7bTdZP77MQ1O/tgMTGdrSETaYwuYy2yR1gHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZLeiyx1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E2606A326
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZLeiyx1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B0B1F00A05
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414438;
	bh=19L6lY+Nj3bXDc4fkgOTMmZjbFzRGMFBM9Lv01QBabY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mZLeiyx1ZMjd8P3/3+19UXkSApkaWReia4fuhBQFo/J8CrqOgIGXxOg53KmTdVvU4
	 Mdj0M/FSEyiaqR6JahTmnxe8tVnNyxzmk8+wQ/AKkdzHZSmiqkwqnA7e23HbJfnWaY
	 4gMgymWEhZRt8Pmvw/x9H4b7mKJXZBd4FLRYaZArJajDKwEsZGM8q4H1zALM9E9lyM
	 GPv4iXGXBVUegDaS8vD2pTTKNwtrUskUkFPunpgCrkuCV/VDBxwIpfD8nTvEvTqG7+
	 PGZcjMqEPTyaD/ZH9x3u2jyW7Hp/Gbel16yCZdvLI724i+P2+fiHprJnacbku8ZQNc
	 kG/AvesdYUypQ==
Message-ID: <sashiko-outbox-209282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] audit: add missing syscalls to signal class
Reply-To: sashiko-reviews@lists.linux.dev
To: audit@vger.kernel.org
In-Reply-To: <20261111152057.59798-2-jeff@bencteux.fr>
References: <20261111152057.59798-2-jeff@bencteux.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:27:17 +0000
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

> The pidfd_send_signal(), rt_sigqueueinfo() and rt_tgsigqueueinfo()
> system calls are missing from the AUDIT_CLASS_SIGNAL* class. It seems
> to be used only in kernel/auditfilter.c to increment the audit_signals
> counter.
>=20
> This counter is used to determine if information related to a target
> process of a syscall audit rule using signals, such as its pid,
> should be logged (e54dc2431d740a79a6bd013babade99d71b1714f).
>=20
> Information related to signals sent via these system calls are
> currently not correctly logged. The current patch adds it to the
> AUDIT_CLASS_SIGNAL* class.
>=20
> Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111152057.5979=
8-2-jeff@bencteux.fr?part=3D1

