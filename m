Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5390395D98;
	Thu, 30 Jul 2026 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449774; cv=none; b=RknEN+coqZJ8xZfU3G0O+Zve3Q4j8hsID1ZmfrsJbRMoN+mvHzS06XGOLT2NKw73Y15qtIT9TPXBfjDvwtRHosJIsyeXV049tUHY/4A2HYXamQalUV+Eo8k6EFCTEcM2mVMZtrdccSMoFWE3JfHD4eL71QrLdpaByveWT1XnOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449774; c=relaxed/simple;
	bh=TwYljratU15wKX1exz0UFny8wK4WdDfvBlmLWkds4dk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ti6BWqR2Epby2ScB2L5g+QeI52+RZa0c0k+6pmd/bPoGRvj/5HtqSKiiZ9Ek0aH59S9O/mQn67yyWpdDHjJCQQ+3ydi1ogRs3Ye49vuzZ91dinmsMvEpxg9ZrACYP133bwSr+vvqz2TU/1NKEynEq2xArh5OVTP+c+VeBS25vxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVk/A0PZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVk/A0PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA5D1F00A3A;
	Thu, 30 Jul 2026 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785449770;
	bh=7WuSMF0Os5fJKozc3FJBjE5l9eMSMuMZkDi6/uiEVCg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gVk/A0PZEkIlpf0vKL7V8N74oBpc8F+lZUEFmMe8GMRWCoLaWU/+Lf1CZCkAem8Jx
	 nHdt23wXe7yVTZzTC2yxg9M+sIx0kH5IvpfQth9CGc/dP1d2ybckoXLLJm4ryQqodj
	 eg8TfdOwpmmXeVLHWRicDrYTexuhXSO3xyMq967R8rx03WaFmJcBEvCwdnaq4syyUt
	 seUjq8zPUm1RhxWtrvAkYYvFy74f511Wdsj7ZX9IDwpLoAM3s+ksoH8+Xlx0NQYKet
	 vXXquWl9a2q56dtp8wyoK+UucvdZkLb6+B9M1v5tYf0ZQy3WO2+mNG1+yAjUWgcG93
	 QeljbS47JDTaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199EE3924459;
	Thu, 30 Jul 2026 22:15:35 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260730
From: pr-tracker-bot@kernel.org
In-Reply-To: <c551862a4b55c930fd56840d2b30d495@paul-moore.com>
References: <c551862a4b55c930fd56840d2b30d495@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c551862a4b55c930fd56840d2b30d495@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260730
X-PR-Tracked-Commit-Id: 246df90b5f1a8a6e6abbd2f058b029558720adec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e2e9da4de7518f65063607209744e5b77dc0450
Message-Id: <178544973383.11712.2712611141151089296.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jul 2026 22:15:33 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jul 2026 17:20:07 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260730

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e2e9da4de7518f65063607209744e5b77dc0450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
