Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA927470;
	Mon, 13 Apr 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120534; cv=none; b=S8drO/0fFli03m0bPpQk8LnlGKftQmWYHQiD39x4ndfGWvo7kxU2qNXi5yk2ey/g+J33NhFfbXRfAtit7Yby8b9FbTQySNEWQZe3Gh0RRIU8NVFbu8WWKtNtFQuK+7c6OCo1A3cMTwJ7o99gPp0CJzShM1Dg4VaycW784tJwZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120534; c=relaxed/simple;
	bh=Tj+Z0m0YJbzfxEoMvBzXgKvlEdkRCTvytE26wfYCXgU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uhDBeQSaqHdb4x/JUx4cyviV0e1z+plJdccQJ4W67gXZdEvSaOS55bVGU6Sw8zUKH7V8Hh9tCr4PvRH9V8hkDUJECRkOnrffakNW4jyQNzwfswD3MvOVq2ohJCx2PtqP1c9+Ues173bg/wuEi/2KXDeiCQ1b3g8qzmQfHCZ3gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDrlaePn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDrlaePn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8941EC2BCAF;
	Mon, 13 Apr 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120534;
	bh=Tj+Z0m0YJbzfxEoMvBzXgKvlEdkRCTvytE26wfYCXgU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bDrlaePnBlrT5oXgmP9S/dAuwr/tj6iAJcOF63f8n95eiitV1DU/r+5rKbIDFe5v2
	 OIyiT9FoHjIg4sUsXRRg2uCbjpUoQ1rfQVE1KiNXxRdGzfTIWWFKCU80SjF1dLtkLb
	 xLnT+D10PnDXkkiW7/FDCDhQujJGKrr2fhiDrLYKmoUU3oMtoncEelLvvpGB4Hx4Tl
	 IYmMaWE3c+yWxNNCnh4BZnnJ36Yi7I897D7Pb8uoRC6+CTEffR1VfvsiD+SlITlJc5
	 TWfaf62HglHbM/CD1o8mkKBvhQ0OMCZ7CnwBIcmLuM7Dcb5qvOY3x8CPZpcq05PxHp
	 9pc49mhBmIEIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CFD3809A0B;
	Mon, 13 Apr 2026 22:48:27 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260410
From: pr-tracker-bot@kernel.org
In-Reply-To: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
References: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260410
X-PR-Tracked-Commit-Id: 360160f75592bdc85edba8fe78fb20d90924c7e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de639344bbe962985e3de22cc8d1388b016c1e54
Message-Id: <177612050557.584243.15486539214866421978.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:25 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 19:26:18 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260410

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de639344bbe962985e3de22cc8d1388b016c1e54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
