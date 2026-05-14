Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0D33EB10;
	Thu, 14 May 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776865; cv=none; b=qyHg/3r0G5DvTESlh1c00UWoT1UcP2QSiy33WYByAL/fvXWpbPYt8LycXWMbgwQ6FkBgCn0CsDINntiiTDoBVaAOI+LINSDFQj+cmOiVXqAvJwUvBMDbfbm8t2yBJdm2wUqDAxqWaECGAiOy2S4qef49IX7vdZMVnruYyd+YswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776865; c=relaxed/simple;
	bh=RXizr9ZJI8VDzy/hik44P+acPmtOO+n1UTTxwQCoaXE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=feoTAndfehPxS5lwy2ogD0f893ypr5QzjQj5HbJEBSgwXP4G49YtyUFC2dei3z+HapVDPGyJzBsNQqgWVRNA1T9Laxe5TWGdZP/pQhNAJeYtzi/MQ77asxVwUNC75ivPL495ubZCbb7R9/iXvVB3VVQiEjyHiew5KbWqu5DztsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1CKBqQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1CKBqQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796F7C2BCB3;
	Thu, 14 May 2026 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776865;
	bh=RXizr9ZJI8VDzy/hik44P+acPmtOO+n1UTTxwQCoaXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O1CKBqQRd8goSe33qTe6dsekorRxH7yuPWIwLoT5NJm+Wh6r+Xi1y/nCgiZtxCUQw
	 yluy+DMUEVQAJsniSdAUtzNNST6iUxR59dea7cz0+YxuxeHyuGrkHDjR5l3eufUdcs
	 hDvLdx6JkqbNjIRjf7wQJzx9GGLvGapTDbjqOObNqr1VrsnjFZsjiNxiGaQLVpa10u
	 XIY94gbMUoYUml1XH5Wu9WhHK6gXhBVk+AErrsefCgCi3iZ0KDgmxDYcaO4z9AOgFu
	 YxM5x8HKcL5s0vlhRLiJ/arObpirjx+6iuDREREIkGBBXIp50FvZe+9zIFTbb2usBx
	 EhKhJGjpiu/3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7DB9339D6579;
	Thu, 14 May 2026 16:40:11 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260513
From: pr-tracker-bot@kernel.org
In-Reply-To: <e4ad001116590340ea21e657830d31cf@paul-moore.com>
References: <e4ad001116590340ea21e657830d31cf@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <e4ad001116590340ea21e657830d31cf@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260513
X-PR-Tracked-Commit-Id: f9e1c1324b4d98d591a6f7568fdebf5cf456dfc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb5441518fba295bd97b59dc54914f89dfaa107d
Message-Id: <177877681059.7067.1665203212411249208.pr-tracker-bot@kernel.org>
Date: Thu, 14 May 2026 16:40:10 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 May 2026 18:53:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260513

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb5441518fba295bd97b59dc54914f89dfaa107d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
