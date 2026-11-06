Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977799;
	b=QuFdhQdLgbj40seydudhT67KUZrFP83yzMongnbl7iOz5+kjKQ6oEXv1u/dpNJCmhViM
	 sDoIWx69knxcey5VIOIAbwnuGaeMKoM92rMTuRO8kEUqrC2/z9M2sFLCIplJh+z4BZzCw
	 vgWVz1xtPxSychERFWhjMSaspgf9cjqW11dVhVEotVCeBW71vmJmZSU+lqS+ho7+RhatB
	 uwJ+eybyY++hmYxmteuHJbgeFFPEmGZDSputptWJTCHELC2bHElH2w1kWtk56nYcg6Bjv
	 GhJDD1CaRBBV0usgR+kMIFRiFAhgKvSIjJw2ntqbMtWHvwm+87KNjJfhE2FWTVOITiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977799;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jTlDAR/AjbjPvRGrVRNJ6oHxoklf3viAzXkQYgjySDU=;
	b=PL/WdS7Qe8GyjuICZQv8QLBH5Q+DZI6cyBGE05vVbzg9bwy5WfpQ57cevvpY2Ngb1a+b
	 JPU4aHSXt/rEiwMk82btbNWZaAAIC+XVxfj6y8tu1oits9t/i8Ak7GgnLSxP7SdcWk3Ba
	 +ArjrJesm9d7GUiwxBab+HdVXSHsnjFt5VLTL/CV0AOHE3HU63v1kM2AszaemjAEKR8ep
	 BkdL2eNv1VCvAL955DH7N2EEoYy35st+ocnKw758j8+DQ337Zbia/Tn/RmOjLaSal6k3g
	 Gmqvm6YkwDtyUVTaHWkrLD64lWJcLjHlPPVFSg0bCddzwJKTgADSGtlLAZzBBFR4Q2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VshfzU+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB5606A32C
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VshfzU+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E661F008A5
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977798;
	bh=jTlDAR/AjbjPvRGrVRNJ6oHxoklf3viAzXkQYgjySDU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VshfzU+XfLpm4WsjbFPbsgdiNYUWJ3+dPgVB/kvu9uX9ogEEg/DD8F/qHB1oqQABN
	 48Cnfoj+mIt1n9SoVXuOSu/Y+NoObeu0r74I+4weUy1Stir8oYYBL7LfF1ZRgZrWTU
	 QbmSX+z1yBOA//64xh+to4afPUl210JP0psBaTgMQOss71BiOm3BwTXmOKjQA/Nviy
	 pk+FaL9bOg7/+26TXcNDu7uwjz/RPMmrsU8/mugODpmRbf7KLK0v6suI9EH/mYrBNy
	 O1+fpfZUL/3ISBOejpolTBv5205Tf1/hV4PY61L4ut+9RrpVOUb8fgZ6/+iXrcUGZ+
	 VIvLLwEFYWzDQ==
Message-ID: <sashiko-outbox-201647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] audit: compact name entries and context fields
Reply-To: sashiko-reviews@lists.linux.dev
To: audit@vger.kernel.org
In-Reply-To: <20261106150342.670199-1-cgoettsche@seltendoof.de>
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:09:57 +0000
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Group the inode metadata and the small scalar fields of audit_names to
> remove padding, while keeping the pathname next to its length and the
> file capability revision next to the file capabilities. Store the
> per-name file capability revision in s16: it must represent both the
> eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Keep
> the existing formatter and its unknown-capability output unchanged.
>=20
> Move name_count ahead of the embedded name slots to remove two alignment
> holes, and place personality before the task credential scalars.
> Preserve the first int dummy member required by audit_dummy_context(),
> all five embedded name slots, and the existing allocation and reference
> lifetimes.
>=20
> On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
> leaving room for descriptor paths while staying below 1 KiB. On the tested
> arm64 configuration without property-bearing LSMs it falls to 872 bytes.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106150342.6701=
99-1-cgoettsche@seltendoof.de?part=3D1

