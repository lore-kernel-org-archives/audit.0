Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977640;
	b=B0cnsRC2tUFNm3hRSrTLUhnODeHdmM2087rLDn+yxH2DxuWQmrJRkgTtZI4BYEUr7OJ0
	 9iUpb8FNf0VY5orJDYc3wt+GG2ZwmUuKLEbXOaX74ep0/I/ot2W78T+cVYwx1z7VqLeS1
	 5zO2Nm3MprDLTb3xDq8GYTKeQcD1QBTUttSBdLiA1G2f7N08avuHrsGywvzz176KPH28q
	 icLA++7uRusG+a30LbQRYRSouzypLBBWAUwfJqb1hY/QWX/juJh5OeOpdJG27lut2i93g
	 eUN8NNacVsxu0bdEmJ2zaXuGgk0txU0arHiMiRaNHnoEwpCxBSjezijeqAWQXTCh+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=js7Ma7B+2083YNmmeAw2iXYfgp3H/1Gz0jM0xQtaEsc=;
	b=Y+0GrMy+gea8DAkvkIVBSFz3WfVtgHpZtdrply1v96qG2E5aI/i6yRRQ0QOj4h3ttki3
	 6QMAIAPomDH2MF/A2JuqPwb6CVUIN76vOJIzP8Jslw07GLVn8UCEpXeN7zdSutBaJ2Mej
	 kntE9R+Xo7S3d+uF/gsZ38liiAgP7UUmrtnchcBwCIx4mQ0DJRltywzEs+PgdHG9V18Kw
	 2ZhErVQpG+Asvl0zvz3gVDJSaZuHHe7nGFOre8eLjCFVdg6nnr2pl/u2vVYg7JS7cOmJm
	 dPpRFDQfZCulbgrRvKhqgV4fHx5e4rkDnuK8W2x/v/i34iHRwxiveyc+gQDnJja1yoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lP8cCJB5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6B606A326
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lP8cCJB5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA051F0089F
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977640;
	bh=js7Ma7B+2083YNmmeAw2iXYfgp3H/1Gz0jM0xQtaEsc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lP8cCJB5DHdi4wnS48ymI+LU0S0g9K6DrbgVOmfJsXLEILzAH7PhaOCxKUD5ioQdz
	 8U4PK22T1aTw2qdRwbEhtFyr6pDOlkH0bMLMgWtWq3ztjdKDHMICDLp8i3x3N4pGX4
	 7d3GvoCvWOpb4VzMmdqtUFdq4hCuC9OvtofCempmpUppvdbZ6iTKl6veUZW0/vg5RZ
	 fqrd5w7f9eOP6lK3G/FJp5GdYmvUji1wIz6kaW05Kl+2wdFbZQZf6yT79bCoKZN9+R
	 y0tu3aG+RF+JdLRVpQQ3/5m4bscRFHQepaRL8rsU2qeWrx5nWNf+rYjoAHfbzMNjeK
	 UzZJz9D6ugJuw==
Message-ID: <sashiko-outbox-201646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] audit: return the collected entry from
 __audit_inode()
Reply-To: sashiko-reviews@lists.linux.dev
To: audit@vger.kernel.org
In-Reply-To: <20261106150342.670199-2-cgoettsche@seltendoof.de>
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
 <20261106150342.670199-2-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:07:19 +0000
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
> Return the selected audit_names entry, or NULL when collection is
> skipped or fails, so audit_file() can attach descriptor-specific
> information reliably. The existing audit_inode() and
> audit_inode_parent_hidden() wrappers ignore the result, and collection
> behavior is unchanged.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106150342.6701=
99-1-cgoettsche@seltendoof.de?part=3D2

