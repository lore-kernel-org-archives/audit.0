Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91936B1A
	for <audit@vger.kernel.org>; Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaJoBV6N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F2B4C433CA;
	Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700231342;
	bh=I1XhoPZtPxXF01V98MdcLMnFAzO+5biFg2g20krFUFA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YaJoBV6NeCP1BpvkKget2wnvzIZtwCPI65xMLdVGpSL75sSyeOHyHHmEOgjG40EIt
	 cYuwa6bXQ+3DQs5ypjFqucnNMe6tYNbgaY/tRTHEuLSKVGDbCSq5p0j7/BvFjzdsQH
	 sOrlo0kcJj1ZUtDtxPkuO4lhiUnPPC/FSko2u1XlMsduJF5k/KLCYEA9NcCW8zUsSR
	 kvHlnC2s7Am4Q7D/DlRYAtpehrFmQUi3f0H6MvTqv37qnvgz16Bnmc9BQIuJ5AO9dC
	 bdrDDHvuyE0Js9b9O0yZDVhogS77n5R9ebuTdff+k82Zv/lVHxAJXLYFhXdQW8+d3a
	 IM0a8lU8hRvyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DFBEE000A4;
	Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20231116
From: pr-tracker-bot@kernel.org
In-Reply-To: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
References: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231116
X-PR-Tracked-Commit-Id: 969d90ec212bae4b45bf9d21d7daa30aa6cf055e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf786e2a78d4d3cfc87469c3b31ade257df14fa0
Message-Id: <170023134218.28622.4308618844091006554.pr-tracker-bot@kernel.org>
Date: Fri, 17 Nov 2023 14:29:02 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Nov 2023 13:36:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231116

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf786e2a78d4d3cfc87469c3b31ade257df14fa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
