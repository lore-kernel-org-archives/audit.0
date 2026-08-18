Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5303DB630
	for <audit@vger.kernel.org>; Tue, 18 Aug 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078202; cv=none; b=Jhmvw9ZxoOVOUK2RAC+B28ZMIIAyZvGXeMx9nRvtCm8tYBM/G5IkFe3HviXU/YI/tEDb7DBBaAIeO8/CWBjvrcrzifd25dNHXmG6jjq+DQDBXIOU3uLigfOYcc13sICggVe3Ih373LSkjXJTzh4vG9nJpxtMwafOndejS7M4haE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078202; c=relaxed/simple;
	bh=Vb02eEvUg1cGzjxFFjCDDNNZ03zJsUc1e32XCzZzB44=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f1GI/cya+HCnDdxd1jXGbBvn9P0KKpZ93PIyfiN3FYKtU3AblJh1QizXIkT6uO0wjunDA4zVuC0tXzwlEQIYiHjXyZbMTRq6eKvhTUjBFtx1uYJpkTS/+2H799DQ7wX8bZ5wF6nE5xavM6ZKaf+RBAKHzDP6PmHF8lumOPSIcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6LVasUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6LVasUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5370C1F000E9
	for <audit@vger.kernel.org>; Tue, 18 Aug 2026 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078201;
	bh=Vb02eEvUg1cGzjxFFjCDDNNZ03zJsUc1e32XCzZzB44=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E6LVasUH3FEr3f/gCVa3ywxMgNvnmqTfDaEWnVsox5W6SYr16O++oXddDWfzRhbvR
	 yyt9ukqSbtav8+6JMi32Q4SNF7MMrutLN2Fdo3msWL76uSnMn1Zq8+aWe9EfJsyLPR
	 ese6WAozEv2/ImfxPNuhVRUAYfQHM0BxNMbexQXZexHTu9VcME2ByGb0kZ9Lam4Iio
	 SfFgLylvQp4cXAemUsS6uNfo/Lb99pRD0sTOPGfF71X3746yfxIWamMGZMlkWXDnN7
	 XZDffmPmpslScL1cniEAVKVm+2BAX5a5KxSQoLODkOWgzWEmNEmOdpGxt38S8fSdjD
	 9t2TEwa0ycyQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:36:40 +0000
Message-Id: <20260818183641.5370C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ef5bf18a4b3805ec0fe=
5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com?part=3D1

