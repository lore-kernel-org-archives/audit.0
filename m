Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679335E1BA;
	Thu,  1 Oct 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871913; cv=none; b=USpMzMhyWioZFfGhIJB3IeHEUtm5Q7BH3hV18py4gWFUh9+90jnOGuQ75SFJFNEaPBBU8V7b5ME6yaD03wyjt7Kd5kYS7NKBJNK8dehGii0Fza1woh+QQXYWn6pVQsv8LqoJhXs/R4TJ3ctyKC0TRVf/bZaXpdq3+eyzDnGNVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871913; c=relaxed/simple;
	bh=2pMKX4BZ6CNM50s/NAP/Vt5caM+tDn5GBe96zp7ecek=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MHeQXSLtXaocVihbb27pOQxd7GZxAe7bWTDt9ixo/04Bc+dLuIdb05hvWwRpqrMo9bNFOLsTYH7d1isuWnfFeFAWIjh/80jYcqv5FjaDQQt3n6LRZd2rptiaE3siQ5Bui0VN3rVdZt5PLRZw9SmHhlAKvFDMmuIgo4CxQcS75DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJSsFBsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJSsFBsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DD01F00898;
	Thu,  1 Oct 2026 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871911;
	bh=P3MIqRDFiYl7vH7tu8gaJ3m/JlpON5bUYXEWJIlcJs4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GJSsFBskkrqyRkkbuOOnVGk47SaP4yHBvGWwzUCm8vWXvFhMurl3lWt68CRexZS8q
	 EXM1AYvWGo/0rB5T1FVxcjIuvOzQnbUu9UXeEsKWANLJ0Ph2wz2S37mE2sNrjLhH+g
	 qgq+HXdhf9R08PiHEyvir0mLTVZDzD19ZIzeXOdyF47780cYLQ4zhQHMGimaeHU/Vy
	 +i+J0oZ0TcMV08SuryEPsaIrC7ux9Hbstg9HbrBLqzZ8NKVdVtmun0XCt4zT+HK5u5
	 Ch6APyWgL0bmlWeDAdhsq/8LeG74ZcVlYc/nCI2yKnzoAlE8bNE8ZsS/eff6ZfMwSo
	 mluwvEieZbZIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A023811960;
	Thu,  1 Oct 2026 16:25:11 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260930
From: pr-tracker-bot@kernel.org
In-Reply-To: <ff3a2b285345da0c7aaece963e136aa9@paul-moore.com>
References: <ff3a2b285345da0c7aaece963e136aa9@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff3a2b285345da0c7aaece963e136aa9@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260930
X-PR-Tracked-Commit-Id: aa650d87a498844060eecb1d336f4d46f4d1b0b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cd9813d848d6565f0ca7825a8405c4e48441cf9
Message-Id: <179087191025.2557118.9688519629265531042.pr-tracker-bot@kernel.org>
Date: Thu, 01 Oct 2026 16:25:10 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Sep 2026 21:36:09 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260930

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cd9813d848d6565f0ca7825a8405c4e48441cf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
