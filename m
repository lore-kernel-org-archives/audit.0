Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8983988E3
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656596; cv=none; b=Sh9TurAILcfzwAoqSQmQfqgVIsSHIJW9sElmAMO+4sYeLsHMQxL2TYYpYL3cznK4kskKTWa2PFxcTLDZNy6jqSIXwM6+h7LEkWOqn4gSeLKblItPzw3MfcCOJDwT3QaOW//IJI0mv4w8iICvt4vAdsGyD7T/nk3XcWYQhlItFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656596; c=relaxed/simple;
	bh=HLrm94cXHC0sRpLD8u/fXztRqob6aWOEprm3VWr9kMA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kgrme+qYINJd4TZpMsI2rhz95p//KZQo3BM8LlBJBuKR3JF7Ktvw1YWtdHKKrvrTRQnYwWYHH3z91Mb0K2xdVqolxQNLLvsjKsvTVL0tIdKzuVB6e/3rNhh2xhfAO3WXYsisTL4FfTkvSHKW376clHa0XQE6XCL1sVJ+WeD2l+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKT71I97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKT71I97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C5F1F000FF
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656582;
	bh=HLrm94cXHC0sRpLD8u/fXztRqob6aWOEprm3VWr9kMA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VKT71I97BM8HAgEIXgQ4yST7Lbb+/aUXNd3b5S9vxo1yRKpfu3fF5MJqEXMgbJcxN
	 RTnpXoVo8sp43cAthjtbGQipFAcoFNxGHpNojit+jN+BSQ5/jgw61Ow0ujkH926DUv
	 FWwQKOuGgCknGkNbvtvflWs/9eW14ptrcGdoxFg5xJxkEw61AX0lFvhaJvYwk0sCPD
	 cvKGEza4YD/twcC3vEEfWQLmuvASUVDtM7NF5C/u0hAE8Pk3S44DmQiNfvp+ErL8Mi
	 g7qtIBm5Fd6OsrX8fBfwiJacqht6KGI6d70MatkwppSRPKZmrv+/ox5jXZ+6ozx/La
	 0TzPOvnhQ5KWA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] audit: compact name entries and context fields
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260917143948.106603-2-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
 <20260917143948.106603-2-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:49:41 +0000
Message-Id: <20260917144942.15C5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Group aligned name fields and small scalar fields to remove padding. Keep
> file capabilities last so they do not separate inode and pathname metadat=
a.
> Store the per-name file capability revision in s16: it must represent both
> the eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Ke=
ep
> the existing formatter and its unknown-capability output unchanged.
>=20
> Move name_count beside return_valid to remove two alignment holes, and
> place personality before the task credential scalars. Preserve the first
> int dummy member required by audit_dummy_context(), all five embedded name
> slots, and the existing allocation and reference lifetimes.
>=20
> On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
> leaving room for descriptor paths while staying below 1 KiB. On the tested
> arm64 configuration without property-bearing LSMs it falls to 872 bytes.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917143948.1066=
03-1-cgoettsche@seltendoof.de?part=3D2

