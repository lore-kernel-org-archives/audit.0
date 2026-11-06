Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977957;
	b=PByz1Fh3WxQ/6G825gsTipJ7U10rT+ddUF/UwgYcvBf4oiE7ewbXEgV7eiyH2vJp73Av
	 +ou3BR4wsy8JmQ7Nu11L7MFdHLTNTp4IfPNqya33Bg/4UvL7UX3RbMd42efV57NzYb9Q8
	 9vxLz4a7qzwIFEkuFl0pDaedg6fv1nK+wlN9JlPgtQJbaSpcKruQaV0VTFYl4Hj3hysMs
	 GAQClAAAc6npayit5G8rUTGSGz6YhjjEY23xi3VxTjXUNEYJqRn1HrTvUDFHGADwZUAQs
	 wobwpvzN8oRlU4mzWKSWD9d7DcDXQJjDi5Ac7849V+f2xgFpBb+8Bxei5GUyH4/YLlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5mOVC8cNNP4owsUC1vfS+MGiLfTTddjP6ksyESIX4/c=;
	b=sCy9S9OzZ+82PszghrTgprJ/sb+M56VqNisdQowWjbD5fWRrhZP6+ZeR9Y58NSwOynqd
	 u4YHzQTOhc1rfgmJ4dgQDzeV6BBhT4qSsAkjS+mKUqSFh1VbatFPM5HgYPPhODDEBIZfA
	 wVXddwhTWfGxPRw7nkqUsYyNsTg0GZS038X3m2K5i8d5s2NeKArkic8Bqu3pmFN7jW3a8
	 W3qHNQkGtb3F9S4w7V9iXC7GcEpSWuLXOyaln5+tkJQ7eJEo09OtInlPyFOTifocyKwBR
	 21WuD3xu6df6EuldPFRyYbzqzFDEJJQOysIQOhMaFyT+TO8D4Ywev8Nr6Rhai3q1gxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/PJ7WAT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937D606A326
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/PJ7WAT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE01F0089F
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977956;
	bh=5mOVC8cNNP4owsUC1vfS+MGiLfTTddjP6ksyESIX4/c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S/PJ7WATiAb7KREdc28qw9T8g9UCXhvOcblLD3fSbDUjmTTBWYazCXUVZZO9ndoUp
	 Q7AwKt9+RVDx68oP5U4s10XZwNqLI4FvHdgUOdnyeQSkH3cYArWpKD4Go5yIWvEURi
	 mccP4J0Q/Ib+mKNHfOJVVhRPaClWTBwLkHIC/3AZd2TkuMmJFurqod6Z4o0az1Wa1j
	 At2dBuZKhTAiVuAPvCQ9QD/BIQIcz9qOyAGIhqO+ySVjIPVCdkwJ/rnmldQ0x//AHz
	 6tUR+cRqkwKXEhxy2BtI0upZcrOVKXuTJPigmOBJw4sy0DlNLFrqHeMIa/4P4l93Iu
	 VnmTYrajx5FQw==
Message-ID: <sashiko-outbox-201652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] audit: retain file paths for descriptor PATH
 records
Reply-To: sashiko-reviews@lists.linux.dev
To: audit@vger.kernel.org
In-Reply-To: <20261106150342.670199-3-cgoettsche@seltendoof.de>
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
 <20261106150342.670199-3-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:12:36 +0000
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
> fchown() and the other audit_file() callers collect inode metadata but
> emit name=3D(null), even though file->f_path is available.
>=20
> Retain the path with balanced dentry and mount references, and use the
> existing audit_log_d_path() formatter when no filename was collected.
> Release the references on context cleanup. Descriptor entries carry no
> filename, so they can only be reused by a later lookup that matches the
> same inode; keep the retained path then instead of falling back to
> name=3D(null). Filesystem exclusions continue to skip entry creation.
>=20
> The name reflects d_path() at event emission: concurrent renames and
> unlinks can affect it. Original lookup names retain precedence.
>=20
> This adds sizeof(struct path) to each audit_names. With the preceding
> capability and layout changes, audit_context grows from 880 to 960 bytes
> on the tested x86_64 SELinux configuration and remains in the 1 KiB
> kmalloc class. Other LSM configurations can have different object sizes.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106150342.6701=
99-1-cgoettsche@seltendoof.de?part=3D3

