Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FC28B4F0;
	Wed,  3 Dec 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790517; cv=none; b=NqHn0eMMST1rYBsIujuR2flRpxyY/Pdbkxs+1EnujOOLsaEavGyA0rQEPE275/3wzQHWtQfg6w+8BRndWw9xseWxSvRgcM3fuv0R+eKS6bEv5pjinu9s/SHO7qvD1Z8NmgPmscP7zug4qDie/0FkPJZeu4smXhrrkGSI+O2aR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790517; c=relaxed/simple;
	bh=L7/dpMdRaZbc53U8sBNW6e8oeKaGkvuhfVCI/+W0CuY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sCCRcWbbVk6mrzBGNIApoQRWpzSkY3mgzmE+NklhbSWx0KXuUy+HXoj+lNsVPJ7VMLRo4sjB8iFhUdkj1zrHIK3IfwZKsV0R71RvWP0JAXky3m/GxhG9wj57SYgpX/hBCtJmNgZG3iMksAPGI/KNV+NxheKKrQs5Q1LYFRUGog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJpPrKF/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJpPrKF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE914C4CEF5;
	Wed,  3 Dec 2025 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790516;
	bh=L7/dpMdRaZbc53U8sBNW6e8oeKaGkvuhfVCI/+W0CuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJpPrKF/MZ7JzXFDfC01zYar0rlR697+NXAeYDcjNpfHU3D1xfzV+mZe0/bi/TcoW
	 mAG9Uz9esybJKAmgFY67rx1IHWTrDpBPAPkbSnVBNWqxkk6Gj0R2F17Tz7CuY7V9p1
	 /Xaz9+BTqSeU/beTqhqAB0OVL/iXTV5VYanVSol4uXU+HQ6k6xVuhRbVLv4YGsdGbt
	 muMXQh8R18r836oiN/mea0KBhu2I6wx102bP6wjNlQktpKLl+AJtD1KGuEZkw4akhP
	 SMrS/1U0M1LsKvuKxQQC1Bt//f5jkH7Czh7AKsE1T9SkXUVOSH9UfOFsGOgp08DOTG
	 mHL1FJgaAHtCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5ACC3AA943C;
	Wed,  3 Dec 2025 19:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20251201
From: pr-tracker-bot@kernel.org
In-Reply-To: <4dec81096fb34aae6b383a151dba1ce7@paul-moore.com>
References: <4dec81096fb34aae6b383a151dba1ce7@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <4dec81096fb34aae6b383a151dba1ce7@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20251201
X-PR-Tracked-Commit-Id: c8a3dfe7315945ebcc80ed5be8267920b609649a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eae3283c3024d576623736eeafcde75135ad585
Message-Id: <176479033535.47894.14041066492247166971.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:15 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Dec 2025 21:00:48 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20251201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eae3283c3024d576623736eeafcde75135ad585

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
