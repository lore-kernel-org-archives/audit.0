Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481732;
	b=Y6R9CSP1E03d5YXci4KehjyVcbfASA9CTqKOs9GyL/VkB2vIudmAf8uagOZvPoF2Pn0/
	 vqB2++E8bqJhboZjt9RIvUGXOOkySILtvr72lqI2h7D4MPqGbVGzU97M/GHFdiPppvvr/
	 lu5Todvt5QsUJKgW1ioeCiYkbgX9TOps4dxpoeXqDzlh959+JgW6ID5MijyetukWFcTF5
	 P06iM7IkpbheS8qF0CAPj8ONrAlSnrZLpZ7IwM6tB/XGISmhycAMGhb+9gDN93AjQaSzK
	 esKrsGt5Dgz1wSYrPcG4o4wWxp1X9rFd1NdG+nOhXuUWxRYHzRYUtpVGfaa4e33VHSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481732;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GsBeZWq1lacCaXH4j7QC7aF2wb1teDZk/FL0F6QwoUc=;
	b=ppv5qqVMok7akoDqZCmiWntpRMP0YqAKY56eMpKQH1XslHLbogjB47iMkhTms/ne+Kub
	 GWZU9RoOXCtloswsZsIIG8pViY6cF9osH8WsvXfH0zr1TdviZw4Z0OOfJwTUOtPRAJoyI
	 0/M7ssQzUHNAOVzIdgSGaPwaVi29u8r+nZH05l35wSR6yRAghrJ+ZjEC/nLFdO1A12Ocs
	 jnGh/YdXRxQF9wnYCthYr3IRMta44x2BYEeQ1o9vuw0BqEmHIqjVOk11msW5BtAge1hVh
	 ++BFHuqy8MKpy2FblGYeaMgxSrIioZPJB4FaMmxEKOAy044/KYGUY4Xp4vpUlE0SayA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnzDaqaN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831B606A31A
	for <audit@vger.kernel.org>; Sat, 31 Oct 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnzDaqaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486511F000C1
	for <audit@vger.kernel.org>; Sat, 31 Oct 2026 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481731;
	bh=GsBeZWq1lacCaXH4j7QC7aF2wb1teDZk/FL0F6QwoUc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SnzDaqaNMn8tTuhZIOnJv520Z9ZwKHLE8nliP7k2jMJNHzf10fK+HRl73vW4juVNz
	 cSA8+MGD4B6JbF1pQcJqOHiP5bHUM9+axxLOuJU2JNXMfobYu5I1l7cxcL1cNJ9MzN
	 y0wOgB0SlWIA+s5D8tgkDOdX0WJ27yE2quVWChdhfFFD2wW64GOkvPVBLDAruwnFP5
	 fktyUrrUdzEfHECZRGz/fEKdIWGRk/l8hVQ1sc2/BaAr3I3M6ZFvAXPrfSTn8KAXWm
	 /VAC0o4kkdhsdqUcWhVUDjQ32tRmBWJJ/XuVeLvxaOndTFg5xpq93ostsKi/7sd2mP
	 TT6VBjwTrbTlg==
Message-ID: <sashiko-outbox-192173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:22:10 +0000
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

> kauditd_send_queue() grabs an extra reference to the skb header before
> netlink_unicast() since it may need to retry a failed send. If unicast
> delivery reuses that same header, the receive path stores the
> destination socket in skb->sk without taking a socket reference.
> Consequently, after the receiver consumes the skb and closes the
> socket, the extra reference taken on the skb header makes kauditd
> release a header whose skb->sk points to freed socket storage.
>=20
> KASAN reports a UAF as:
>=20
>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
>=20
> Clone the header before netlink_unicast(), then use the clone for
> delivery and keep the original skb only for retries. If cloning fails,
> handle it as -EAGAIN so the send can be retried.
>=20
> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in c=
ase auditd comes back")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031211258.1626=
829-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

