Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D554394785
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656661; cv=none; b=ZpFX6XSFSFVDmHJcTfEip4Z7tYWDL0KcWVPMSXm+aVoyPAW160CIuWxpDNPht8Pe5XU4BdLLRVjkv6FTKrnMpJHJ4Qi5sL5hH+SkQLOQxOMWl4G7CfkwowOBCJ5z+/dUFdqzzVyRf/rkVQ53tgmfl5iRU7gkRTOBMBJKC7ctlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656661; c=relaxed/simple;
	bh=Ld4Dqf5/QUVAkHnEBng3HZ/QCbOlJM4U/sUOrjOitLo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eT6R+nuQJaDyhOQtOx4DQexe80N2dwSkztJnfvp6ggJ8K5nzgYEnywgZcVeaF+18lveVjHrTs7ys2PwZpNfZUdpQrEahAAweVWtb1L+pXnYCXyBTI7CafDcY6kiAtpmi7nUO3b6TLKPomp8ZowTmJskU3RKYrDN8j3vzXC96JbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl8Eknox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl8Eknox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C358C1F000FF
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656652;
	bh=Ld4Dqf5/QUVAkHnEBng3HZ/QCbOlJM4U/sUOrjOitLo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hl8EknoxxL3X9H7mac9Tox21/uRfzouAoS/D4a0Yy+AgLQYDiLGUuD4mnerR+AAoq
	 GKvDZK6TZOD15tW0mFKqazUNkIJHI7GzWvF952os067s0/YIBzlQpGIpyLtUL0XN3E
	 gQPZ1bdbAQSXgA2T//YVjhhzP8uoydn5P0K/iyMVrhi660MP+jbYtXNVYVfJz68Rc8
	 MGKN72F2g/38xpeXV/k1mHJSzxe5ca4sjLRsbOjJRVvwO8JcM5xNsPRT/0FL0/zi+2
	 FFHaL+/E4FoM4l8VHUsq+ptl49uRhIWPgIAjLkwI3w2YuhAfLb4TeMh53+LNbFn5+0
	 aqTmMtxko7oFg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] audit: separate file and process capability
 storage
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260917143948.106603-1-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:50:52 +0000
Message-Id: <20260917145052.C358C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> File capabilities need permitted and inheritable sets, an effective flag,
> and a root UID. Process capabilities need four full capability sets but
> neither a file effective flag nor a root UID. Give file capabilities their
> own type instead of storing both representations in audit_cap_data.
>=20
> This reduces each preallocated audit_names entry by 16 bytes on the tested
> 64-bit configurations, saving 80 bytes per audit context. The BPRM
> capability auxiliary object also shrinks from 144 to 112 bytes. Retain all
> logged fields, including file root IDs and process ambient capabilities;
> record formats and collection behavior are unchanged.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917143948.1066=
03-1-cgoettsche@seltendoof.de?part=3D1

