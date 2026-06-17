Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08DF20D4FF;
	Wed, 17 Jun 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697566; cv=none; b=afYbm8gk//Eo8AdVogY3+XnKiN/WerddgeD9zr8+cBZKT6mXrSJRmqYPRTY4+XtlUVrduOBcdk+XyqEbzSh4+Yng5rqpk7EDp71LuLFMot8Gs5Sg7PjHLQDoXuL4kqSS/FWiaYhc+mdD9gB7/44jeyDzrxw8CzmqqvfLnDKljXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697566; c=relaxed/simple;
	bh=9k1bQReXJ5K10vHb9NU3h8VLRC76cfbmihiJ/F/lVPA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bwB2jMo0XZag8PpSBEZMULwj8TavwBrBG9b8rFgJC+YhFJ6T9mAkAciU+mN0lW9CBPohHCW2wffgiWFmtE4SuuEA5gxUuaHMNMWb+a4xN96gegzoWDP55cTEu6GjUVAST4D+qcy46TAtWoA7QpyF4eH8DQiGRa2YswWGMCMM81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6uFRZ3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6uFRZ3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C11F000E9;
	Wed, 17 Jun 2026 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697565;
	bh=ar9vGpeyJnVnQGuRA+BndMAWZ5MA3BflkgJRNjDxJv8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=U6uFRZ3G/6GBKYi0vyP2xG3YmxwAlwQhp8dLZ86xevlGR6sT+MI6osIuNPXDwiNu7
	 rQItA1LSCpRsVBlK0giukCdTYlXGbdIkeQcXdFMXpEmYSJh0GhArzM0Bzjicfa/nb3
	 tBZe2kKGsEEI5VjrD1NFmCpqbrsd04SZw51E+GcQzA6P/vIb6XJW920ua97fptKqEt
	 99duWnrcrrbdDWGrsErOthIid5/mrdXU1kKkZoR6W3zmBxxCu2luJVBOt8BVqEx84G
	 qUPRJpPgnBCC//RUKXZUJS/A9uLIgocRVvENy2KJby33axh9mbkSQKurdhMtclO4QL
	 uW8mxIFSMu9iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09723930E10;
	Wed, 17 Jun 2026 11:59:20 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260615
From: pr-tracker-bot@kernel.org
In-Reply-To: <ed67171da998240452617bc681ac0e48@paul-moore.com>
References: <ed67171da998240452617bc681ac0e48@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ed67171da998240452617bc681ac0e48@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260615
X-PR-Tracked-Commit-Id: 81905b5acbe77284734438df3fbec1158e6429a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66affa37cfac0aec061cc4bcf4a065b0c52f7e19
Message-Id: <178169755955.1583338.17070968626636696215.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:59:19 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 22:55:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260615

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66affa37cfac0aec061cc4bcf4a065b0c52f7e19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
