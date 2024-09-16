Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CD15C136;
	Mon, 16 Sep 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498804; cv=none; b=bdeK302GttJ63N+vgGqkFcdfApi4BiA8uOjXOKEk0CZyUmqLbHkZW6A28+VvCa/z4XVHtaK7X4d1VGAyLQQc0itwv1qshEd8ZNu13lKH0p8b19MfhnkeNdnPAVtcv/yyQoObdkzX6kMVSI9yN3lUZhuA3G8FD+x9H/8Vo+JXG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498804; c=relaxed/simple;
	bh=ArcKy7p+aNHWxMNwnVx9b5KAI21+dDhFyAlyVicgLWI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U2zaZNUSHEgmsvqzR25Ecz8tOkX+lIREceM/Bp2aR0OPDF0S9fYDGrgaBOix5tago02FR6oP3gbciCi6dylqn+1KI3777rssB5eiwNEbn2RpJCgx/d9XS7Qw9Qa4Kx437sVa7GiBzsOV51u5QR/FXEJTBXAIbLm/CVmhT+9MC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA/TEC45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA/TEC45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE6C4CEC4;
	Mon, 16 Sep 2024 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726498803;
	bh=ArcKy7p+aNHWxMNwnVx9b5KAI21+dDhFyAlyVicgLWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MA/TEC457NaQN2R+q515ATJjr7Gt21Q4+vudtahue7GNbw2EKGYliZx5c/5vvj8XZ
	 +E2hKeGHW3ya52AIESH3uPovKqwTYiIRhI//hrJujv3z9CRNU5ZVJgY7qUrgKQFRTj
	 Z1EaW3+Ej7HSaKdMI9W+KC4zkMxeNFsrKiuc9Jb52XBOUXU/+90KWWfy+ueiFiRdBy
	 md/M02J8gkUU46BJnN4fMDxLi9VsqAx1EM1yeWZsANR1IGHtLvRyAPWzqxandTz6Mq
	 SiMcyTpq46NQa8ExNuCmzCpGrwrAUyEtcDpu841aVPfRDZ5e1VBYBDmxRZOtfzgHyL
	 Wey3vGQZ9AYpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24C73806651;
	Mon, 16 Sep 2024 15:00:06 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20240911
From: pr-tracker-bot@kernel.org
In-Reply-To: <5b03d15a5ff1840820e59d41ba1fc9c1@paul-moore.com>
References: <5b03d15a5ff1840820e59d41ba1fc9c1@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <5b03d15a5ff1840820e59d41ba1fc9c1@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240911
X-PR-Tracked-Commit-Id: 8c1867a2f0fd4235b84da6b204519e830b551988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc644fba3cf837f22d14991cab3c4c65af37ae21
Message-Id: <172649880565.3724525.14709311663316097457.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 15:00:05 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 21:15:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20240911

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc644fba3cf837f22d14991cab3c4c65af37ae21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
