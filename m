Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7904848A3
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657133; cv=none; b=uGu7YA6ZeV4pL55hrCv4EoGBCphxJhuQeQvqZPgDDSLeTla1NYoPTcfkvv899bD8N1oQ9sa6c04/R7/JbSGWMz2l6S3x2fudtgy5sgbMebxfppUXhPB29CAChq+EB2ZadACC9hu1ypsnoaVOFKwq3J0gAukXh033uxnXT9wujlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657133; c=relaxed/simple;
	bh=qCCJr9pA/EyADUu13O091doSn8DSHp0m5zXYlVCQO1o=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJBUdJBnbCOmTKrPs6vTfyYdU/2Ve9G9BWJWl+6vimHOO6Eg4pUZn+B8f21543MB4F93EdL2odDV0190Gvq1m+Ue6WyrwKEegmsNx6scvB7AyOj2ZfTay/fu2jsF4T4dq9Hlirip549+5111LFJlWnB21RBAQOac8s9UcZRkN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXG8bbEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXG8bbEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3134C1F00898
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657113;
	bh=qCCJr9pA/EyADUu13O091doSn8DSHp0m5zXYlVCQO1o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HXG8bbEoBpE2M+C8qW9iAnIU8a5WtOSzwSVLNMx+m5zarCbQvnsVwnt7AP6IVg87f
	 DBtwCL0atgLWz28DT+NgbPk10YNOeDZxXCtUn4D7wk18SBc8ED8ps2UkWBshVyd6/V
	 e2t0q48rbmCWRXEE2AMf4Vt9IiEPqCEyB36tw48s7zMIm81f+/ZYWb1CrM9iEvgx23
	 Z2PE0FLhQIaNquZeZII12bTvDiaw/03r6ZKjaEnFgzEYtOprCQJeu96Wxk7eDSAfXc
	 YQqOAg5vPMOJR1DUmquu6o8E5det8T47euSKee35wuppdp1loiUaZ9svj/oyqsN9V4
	 EdNpcOcpAjKDg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] audit: retain file paths for descriptor PATH
 records
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260917143948.106603-4-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
 <20260917143948.106603-4-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:58:32 +0000
Message-Id: <20260917145833.3134C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> fchown() and the other audit_file() callers collect inode metadata but
> emit name=3D(null), even though file->f_path is available.
>=20
> Retain the path with balanced dentry and mount references, and use the
> existing audit_log_d_path() formatter when no filename was collected.
> Release references on context cleanup and entry reuse. Filesystem
> exclusions continue to skip entry creation.
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917143948.1066=
03-1-cgoettsche@seltendoof.de?part=3D4

