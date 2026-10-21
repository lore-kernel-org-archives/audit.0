Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564138;
	b=ilVw0dTL7wVt4W+2TOcHaExsjdRDskCTtRWKLu3H7OYavBq7FZEQKsCdFShzE3Rmbtnn
	 5+VW0+Q6Ep5p3aXd5Yo/rOtONW3qSJDasINmiKj9XWXiLiAyTsDNSEAoDe6i1Q+7mJ6g2
	 9M93Vmfmk5hG9B1Shlwg6qEkEZqSDA5h/gmYJoBBt/R0pKz2a7CQeR/77xU2FzQgPFi3U
	 ZyxUkP2U9LYZbTBZewtkwPLu6poFbZ78bNRxOqNqO/o2IkdZRy/A/+Wek1tT8/LbJomQA
	 nIGYj5OT9efkBfK0kGT4d6A3JlQQ5CMK7dxDIdvbQ6nylvylOF4SPXKwUpP0aAb1pTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564138;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=6/OziuoL3V4HJJ64x6vODHHnFPlbWodMe45KORMIh6k=;
	b=JE9nTipMgcIDKEG2RJMNduo03nsxeIY0vUD/gWF8HYLS4DEe9osxOX5C2qF4Dck8zoOs
	 zLWEQ8QTnJfAMznL9Z4W3lIk+mYfZuX+2ELJJl2PMRNnwxjimNiYD4fRXrcya+7+5y66V
	 7OamlQKfiNlEXpbpyPS2QtAxkp2hZipPWQjXB8YRon9lkv3h+jQ/9Kjqap5MvQyWiyFMA
	 so/jU9wgzhXKpYmOn8sHjw3OBSLl6WHduXevQ+N2A4S38re51DUmoIv2F91xsfNaIHlOV
	 5J8cb9LZmmtKH+drei4kN/bRZBpNSTyih+cBcsYDVyoYRgOpqHFN86rpcOgFxYHVOfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFCpkuDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218A606A323;
	Wed, 21 Oct 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFCpkuDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8011F000CD;
	Wed, 21 Oct 2026 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792564138;
	bh=6/OziuoL3V4HJJ64x6vODHHnFPlbWodMe45KORMIh6k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oFCpkuDtYZIbRw2jBbLGJFTl9LPVQZH2wyXfnKwsy0wAjiLZo5qDGUGlHXY8kXvWu
	 it+W4LODSu1pimYwtakDoh44FNfL9IpCMJTrUO9VeTadkHKVw2qVdHw+fvNF8I9dS8
	 JbmX/KuDhqESnbKsjv4+v1g8rbCmoC0x6Wrr8in+0c4p/c/PLYD2FaT4fdhy6K0hOF
	 /toZiX9UiN6wmume3jGu6bfgqsiSrZBdyG4E0RNd8B+v6TEhU3fTpx8pmdTwMizfu3
	 zVdCC+Z+aoFW4fXtoJIvA/3467D6VB33bO+SeVKpYAIz9ufKZ+sYrm7V/gmNLrl2GI
	 tb8MoEhJDX9BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772C83809A24;
	Wed, 21 Oct 2026 06:28:58 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20261016
From: pr-tracker-bot@kernel.org
In-Reply-To: <58518dd02336a6018abb7fb8b34f5212@paul-moore.com>
References: <58518dd02336a6018abb7fb8b34f5212@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <58518dd02336a6018abb7fb8b34f5212@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20261016
X-PR-Tracked-Commit-Id: 5d59024a6cc9aa9300da59fbf7e2c29f1f2393c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7eef953fa66b559f374d0dfc426d7a89fe7f426e
Message-Id: <179256413712.425997.17714008150798570099.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 06:28:57 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 22:59:58 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20261016

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7eef953fa66b559f374d0dfc426d7a89fe7f426e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
