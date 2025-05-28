Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F628D843;
	Wed, 28 May 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446894; cv=none; b=lvc4c78yVZQFGV7i+0cbUIexP8UQC6LYBQIBrpOL9yCb9SWvNR7T7gFtXwGVzw4XqrpCC6ZrukrfiUqf+YrSsPmBRcwzsJ9qm01FF6X1jzkaN423LwTbncwE55Ee64AE31hE8Zkgfhbf9VE/Fg6Z1iT8AEpihA6iJuJtKIKnfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446894; c=relaxed/simple;
	bh=Zf4Vz1X0gHcV9fxu1GsSCqVdmgjVwphYtInC9iPo02c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oWM17bBPPybGXfpABWTII4IKBhQW4y24xmW/72hAlBVK2GUO1/evGs4GIOutA3qpdIGRL7ICWGwktHeMX6hIfhJzpv4Eu6OGzAK3mY+qPaiLOO8/AjMCTIzOU6Mdse0sgQQVJk1BQJYFY1SlrtqD7fiOyXwuAuvp1fMZxfoGPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnpR+1bW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnpR+1bW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D4CC4CEF0;
	Wed, 28 May 2025 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446894;
	bh=Zf4Vz1X0gHcV9fxu1GsSCqVdmgjVwphYtInC9iPo02c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mnpR+1bWcq530JySFnJNFdnDXkVAeATHkuCUyMWhLzje/AxGIdAxJLIXqX+odQaHY
	 J1+1GURofeFA6unJFV08cZHMBY7RtZRodpn3eSx9lTnDT8jUB6sEy9SbyE2if/c98O
	 g0C8TdPRkPegiVKtm5tS2YxUXz4niGJIYmFnA5uCtQWufsNOJk6o1kzwPgMVRA47Uv
	 d0wyoVGq66B48hz9Xom2MFlCaoR267f7nb0XpJwUN0w8Uf8/lD29D/iRjpbYP2MAKK
	 jKrNwWZ2fgU+TZDBPWgpdNz02Z+bp3Vh6eGUq6YnN/8vpABpOj87nrQnUICvxP2kca
	 bEJs6FAHxoHYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F333822D1A;
	Wed, 28 May 2025 15:42:09 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250527
From: pr-tracker-bot@kernel.org
In-Reply-To: <2d7b064b34bcff7a6a8926cc29cae659@paul-moore.com>
References: <2d7b064b34bcff7a6a8926cc29cae659@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d7b064b34bcff7a6a8926cc29cae659@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250527
X-PR-Tracked-Commit-Id: 654d61b8e0e2f8b9bdea28a9a51279ecdacafe3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d413f0cfd7ef0fe478e98fafcc084209520abd0
Message-Id: <174844692807.2441113.15130489872839846062.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 15:42:08 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:57:45 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250527

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d413f0cfd7ef0fe478e98fafcc084209520abd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
