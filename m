Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC823ACEF3
	for <audit@vger.kernel.org>; Tue, 18 Aug 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078343; cv=none; b=edy85l+KFsLXKoDPn4E/DYitsJDMtOZym7j7oZE0MO9pCpdnU5IZVcx1U8oAKl+iKJkHDUTChFAKMXMvX9+eM8+LhS5ToqKo+5w8K/yvKR2ipvtXcFwsbDSAwTSE5OsNETDmouDcekE0hMNg91MqhQukpOMjBpFDO4GErO3q9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078343; c=relaxed/simple;
	bh=0wf4kIDL3CxXcgkP2klLlVoIFlKzaxy+EiIaTj8F/dY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LivZ8K71tDQmdsFUYlnyOpqhbehD6v03gP3Q21NauGWGLU/erBkx79RmK0y3TiGizCthjooVnbv0AGlGY5RYmMrr8IQF1La26/7cnjtYxrY7YB5o0ayuIVxkupNhD1JHeNPV9KLF+/W94ezNSSwfolun82N4tMAPLz3lNZ9td6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIyWB9ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIyWB9ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DB31F000E9
	for <audit@vger.kernel.org>; Tue, 18 Aug 2026 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078342;
	bh=0wf4kIDL3CxXcgkP2klLlVoIFlKzaxy+EiIaTj8F/dY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YIyWB9ibZmmJEj/UOXV/p+kYZh8w742Vw3yzFgzkV+6tQtUreaq2H0zYhfXP26JwG
	 kKVswEjElIFxPrnBmvtsgsWU40LT8F0SM3kUmnSTd43/ODXjK48bLJkxIWe7JlLKfW
	 UFfQ2QMcqLNykVc5rj76SCyQYR4rv3ubLClq86+vWYNPtP+DuMXXmPF6ueLOy02FDF
	 RVqHKQdnpLZr5LZNcUw8fh3ZS3kvqsLB6x6By5wkTY5Ol7r68Hep+HwZCs3bdTqpqr
	 c/65N8JSft9BxhjJY43Kc/2QJF9TCDf6DAQGxfuiXS0Hb+ldGPaAzLcEhUvk0DDBi/
	 Fa+4T84AuvUEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260818183139.f2v-HukfL5PLCOxXeJQYhoWurram5LBUy_vFSp37pU0@z>
References: <20260818183139.f2v-HukfL5PLCOxXeJQYhoWurram5LBUy_vFSp37pU0@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:39:01 +0000
Message-Id: <20260818183902.37DB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
>=20
> Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> Link: https://github.com/user-attachments/files/20751461/fix_audit_procti=
tle.txt
> Link: https://github.com/linux-audit/audit-kernel/issues/170
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818183139.f2v-=
HukfL5PLCOxXeJQYhoWurram5LBUy_vFSp37pU0@z?part=3D1

