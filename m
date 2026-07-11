Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D72BE7DD;
	Sat, 11 Jul 2026 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739298; cv=none; b=mviGpkwtUEmZdBwSJ4FHSI+T38iLgszyDeSrTolT5DZZZlbPG50UeOCxEMjvwS/+O+wMCej1f3xm4xA3DwKYEA1x2zZI2aZAxaCkJJ1YY9Nc7+UrBWbEJRzJCMkPBFVQx4owbgP8KzukNkebi9hdMRc9+uKXNiG656vlQbSAoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739298; c=relaxed/simple;
	bh=ZL955bvAMCidUf7YGk1jHBJKd4U2/e9EMBM/ebVw9mc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m0eX6PrFRtTJVvN2/JzWZLe3bl/bUwZgyuJ8Sb6V0d3xgK8unxnmbszLALSDXkaYgekx1DlkexNQephB0V/XEOGEa4VOwhZT1TbwpLbGIN00kkgdP7Ex9fDIJ2NCsnop9ghJtt7C99ncxL/UWfhLcTsl2BiLgkqiTVmCp6C1VSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRN8XUFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRN8XUFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125E1F000E9;
	Sat, 11 Jul 2026 03:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783739297;
	bh=/pfjzzxIaWcmqh8TRPmH49WJ5ehH890aWxOxahscmUU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=cRN8XUFrVVgWArCFBsw8Eix26zSLDEYCgoMuglP+EHl2w1kbfAcOD1NPoHQAgrCVd
	 FFD5oe3fM3rn8fWlh07vACdlEqs3N6KMzSMXhVRRohiW3R0YT1DagD16ayyZhVPBus
	 ApQlbg6RhVF1rIk0ca+ZsOa0BfoyiiCjqjxIWm3xYdcpMrZZYNABmAF8C1DymOiNwb
	 oS21zNQwH0WJEDPs3yDUxcniWu9QBsbXVL/syIwdPE8SPXWWMcX4Xzr3Dui7Zo5yW1
	 dGAffMmYFc1T9r4y+oA91sHUTgsOYdKnEQUv01yX2zv7h/R02PaG9fYBmv7kWohYB0
	 UsGUz/EoKcorA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8739244DF;
	Sat, 11 Jul 2026 03:07:55 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260710
From: pr-tracker-bot@kernel.org
In-Reply-To: <a307fda8417d3a1e3f6985535d4a62ae@paul-moore.com>
References: <a307fda8417d3a1e3f6985535d4a62ae@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <a307fda8417d3a1e3f6985535d4a62ae@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260710
X-PR-Tracked-Commit-Id: 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf124bae08c35cb8b5392ec8005f9890833b9056
Message-Id: <178373927451.966321.7227694651429361376.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jul 2026 03:07:54 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jul 2026 15:13:49 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260710

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf124bae08c35cb8b5392ec8005f9890833b9056

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
