Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068A2116E0;
	Tue, 30 Sep 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253738; cv=none; b=GUVE7jJgzuAP7PNt2nyqPmcHXDhi0XsfV8kHWNBMtKPVfoPThbg9+zTjQWjGPaZ1uLblBja55z7GzxPu7lG5oU+2/K5fegdCQWPFmqdMuw/9gSY1MWZAkq3CMsimjgMLuOFx7O5TWUKjQFSQ84LKxcj+CZ2DSOw+7/Wg1aj4Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253738; c=relaxed/simple;
	bh=59wfMExYIP5EVRQ1V3GrGkXOlS0JTwjJjoAbiFkaTTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ojSGDoNlC4CaQDNoZp5ypLO261dlpitOVGdLgWeZ4WW+Ldmuf9ok40xOa0ldZMzJexBEpgU8wQLzCtnnWdvYiWdrWlDYUWyQUsyijkmhWKWClz3aNaaUiAmDxSowk+PHbXwfu3/9xaDjq41Enm5swUNFk9joSqlMJ9iCtrJmHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2N+oVAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2N+oVAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DB1C4CEF7;
	Tue, 30 Sep 2025 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253738;
	bh=59wfMExYIP5EVRQ1V3GrGkXOlS0JTwjJjoAbiFkaTTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t2N+oVAYAHeJd1gAVitoaWWUCVa2FGX82uMc+zixJSvNELDltCV/VdXSb87Fn9yB4
	 7rrMkb2zcn31PX0+80kFPa7m1XrEZgGJJ9beYiWUibei4pBrXUqWiJDeoVseWWTToq
	 LXChxsHgJpAFhMhYAwxRKk5do1rf4rwTTYGFqPrHKT0GOfvLP48ZCK5CcdHgOTkR0C
	 73OExAsF2t3sAp2VouyFj2pyx/SfIyfC4aPq9hCEWVaUzYTrNtY7vAHJCU+SnkAd4u
	 xDkg4WZsDOmSYPv3K5GTg3Ss6qUJ6yT9ptwrigvpqL8gObk8nULd4ZZ4XaYXpJ1cFM
	 iM76zhr6Dll0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8D39D0C1A;
	Tue, 30 Sep 2025 17:35:32 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250926
From: pr-tracker-bot@kernel.org
In-Reply-To: <3161e6addb7d3e6c8297ff058ad8236d@paul-moore.com>
References: <3161e6addb7d3e6c8297ff058ad8236d@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <3161e6addb7d3e6c8297ff058ad8236d@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250926
X-PR-Tracked-Commit-Id: d2c773159327f4d2f6438acf1ae2ae9ac0ca46a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56a0810d8ca406648fe01ec996ade1d61bf8ec8d
Message-Id: <175925373153.2087146.11875993188684861539.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:31 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 23:07:27 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250926

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56a0810d8ca406648fe01ec996ade1d61bf8ec8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
