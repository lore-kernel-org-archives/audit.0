Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC94DD3C9
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656317; cv=none; b=JyeRG86OmhpUz09g/d9f1xlJayxTgD/dNHQxV1out451nKr4rLwWNgYZ5MgRWIzTi2J4tgWSXtxMyjuTDNJw0rnmHzt0RdudAUBmA0TfjNoxs/gk9y/E4+6VbN8Li6tTR4k6l/P/Od/7v/2QrXH2gm914B18ptYZ7rgjPl5MUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656317; c=relaxed/simple;
	bh=iUa0emxGIM3scHFdf+3ANUJV9iHbu/nP+00F/RwZ598=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UcXlAvnQOfro+K/5Fldu9DUhyT3mG65Knnjh/50xfYpfanQcEwBOwWiQGKDSWjmjB+AABnSt/qlrCETAdTmQtKbeLtEmiAV53u8Z70Ag69mvOLkURPnUF8hh7p2sdCM9fM2b8IlV0NvmNsSS+ce/tcF8Y6cgmyyySjQ00wyy0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF27/a9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF27/a9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A691F000FF
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656307;
	bh=iUa0emxGIM3scHFdf+3ANUJV9iHbu/nP+00F/RwZ598=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MF27/a9bQKfkRRqEt5oT1n5OJBzLVH6e+6kDExVNVMv1aDbbWd53EKcxPqlRX4fvx
	 lVp2Hg5WZtpuSoyb5V0hStOce058DurUzHG/bvyw5ftnu4P4+T2GlJ2Qamx1EDqPIK
	 jEagM+gtnAFI1oJjmvAWdHGcN04tdSkGpiL87nKq6FxmLoKcazQJFDd8S8wz7rSzT8
	 fI7YH7IsPTlfh4iEWrPgKC993vjz5uOWDsq7PdqGk5n+k4FBuR/JUaMwreXZYNXIYF
	 d+ip5iAZeLs+DVT1oMCl9JIo9va/5N9H4alWZn0XfKiYqP8ZI46kMh4SyXQvvaLSwM
	 bR/gstpyoVLaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] audit: return the collected inode entry from a
 private helper
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260917143948.106603-3-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
 <20260917143948.106603-3-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:45:06 +0000
Message-Id: <20260917144507.71A691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Keep the __audit_inode() interface and collection behavior unchanged.
> Return the selected entry, or NULL when collection is skipped or fails,
> so audit_file() can attach descriptor-specific information reliably.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917143948.1066=
03-1-cgoettsche@seltendoof.de?part=3D3

