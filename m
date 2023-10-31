Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AF10797
	for <audit@vger.kernel.org>; Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq/ZfgGP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86731C433C7;
	Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698733882;
	bh=VCIMtvdh0RRAVq8n1Hp3w02jxra4ep1zIp5/qHzsAKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pq/ZfgGPFITp9RZnd0lR/c/IcOjBIrT5foz7r6LT5uFegQAt/4sJFfXiTIY7IYVYI
	 ooJZvtcfAcGpEBzh5t5kRsA2+PyrMXtbiXcpkgL2BmtkudjWkmWXMBI4Sa82YU/a1O
	 4/XsfxcyQEQ5IofxxIhW63dbx07SsyJK8SWCi6LRw/KhhPGZVn308jrdEfLKQaPQ4P
	 RQ5yb6KNe/MK4DGC9eZZeWL9v+5fAtCCCLuDHKkJwi1XK9FmvYrgFn2l5hUVn5RlzO
	 Ll4x/l5ApRxoQJZUGmYOIT2AesUucfyuldCfwteGPvCgkxYGK2exnp0H/aGTM+uGhb
	 tfhpdNBFYLSdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72372C395E3;
	Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20231030
From: pr-tracker-bot@kernel.org
In-Reply-To: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
References: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231030
X-PR-Tracked-Commit-Id: 47846d51348dd62e5231a83be040981b17c955fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9886c976668cae1614b46922b56f14b467da7be
Message-Id: <169873388245.12768.16669076140366603002.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 06:31:22 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Oct 2023 22:02:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231030

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9886c976668cae1614b46922b56f14b467da7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
