Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396161;
	b=LGdgvxKf2nsrhIyLVAe0D+dt7pgiSkRCmezPOrewVDuOwUI6X8+sCScxGQ02e0LHm+BJ
	 L7kLrpBm5fHFomCUETklOauvCEe0y3G5edLGJfwZ50d4ALLlQoGGU7kd0GF5GZnvyayV2
	 xb6SsOAeKb0xASbPVjgoWfr99nq6smK6kUNPkpwLrRPhOjBa8LVZ98vPBkgkuOLPzhmp6
	 0QzvkdvnTWuLPigAVZKZH0+Ub8L5plZtatqQizx1XM9YGpuGMtEXDf6DlqbZ/x5WJMdrw
	 g0SyAYxcr/8M6nxTEm6ipQ6oLrcLb8LiDGQxwfJDMDlt7YeNndwAxP6VixVTPqCXeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wjXPsmvTmMUd56ZLgunUdCRnK2sAAwUdN2O5QvH8JaA=;
	b=K98XutSP43kGAS31HA1edJEeZ3M6EweLze2Yj6LWG57Lo4cP5mIpebGjOasj1oEzwoQU
	 Nt0updWBoqmWPrheh+cKoATtkdYIg0MHkmb/lHW0Nu8p6JaDS/FzMU679K4FcpGJey8vl
	 dR5RRZKPkSZlYelPxOsii75VZOabu2eqYoPnmzN5DJ6F3DniAhAZWEuvxKn2iE5RkfFSO
	 dUjkWrFKPhGOHo3s+2AJvtxEXnWtYMc0xJiCQuAmqYnVK41Dxwydbl7cOA/+x+/UPEJ0V
	 Bh8WLJvw1IES/EEJh3BUGGdY62e44T6WmBLt3wgSnIX3+K5Iuirf/3u+vERitbXmRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qzo/TMZR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02702606A31C
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzo/TMZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786551F00A05
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794396160;
	bh=wjXPsmvTmMUd56ZLgunUdCRnK2sAAwUdN2O5QvH8JaA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Qzo/TMZR6oMzwWAh/eF5+3e6R0AJzJa9QgxXvsUddkPTh8ayyKQucCkhRq1nAmYfx
	 bnMR3jiKx3UMP157fm5DKBRdEaLp3cjpN1WXAPATCJshKDjbL4wGmHnSJepNAwjq5G
	 qswVZ0BiaDRecQK9Ol/4t0fjqKo7JbpWbYWwlHJhTa0XSNjWJ/trgNifjBey7G9IJt
	 MuEyN1jXPqGN6VVgudU6T3C4znb9/llun6sEgGKF3y3BYJHriz07ZT3UbgXZVKV8EC
	 e9rf2GZ3YnMdTd9x7vo8qIGiX2uJge/yo2RBSGUSqvxZHbMVKn/1+KKLzrCVrfMeh5
	 QzmqVRCyvzeTA==
Message-ID: <sashiko-outbox-208865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: add missing syscalls to signal class
Reply-To: sashiko-reviews@lists.linux.dev
To: audit@vger.kernel.org
In-Reply-To: <20261111110200.30415-1-jeff@bencteux.fr>
References: <20261111110200.30415-1-jeff@bencteux.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:22:40 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111110200.3041=
5-1-jeff@bencteux.fr?part=3D1

