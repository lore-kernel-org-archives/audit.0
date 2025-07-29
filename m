Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908521772D;
	Tue, 29 Jul 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755864; cv=none; b=QMi4bz+JM0K3utE69vlD8pd8UuetkUlNjvKjSAYgmUHohtBQql70FGbsvRxprQH7+8sTTSTTVEfvMvN5IEt3IIsL62eNTQZ3j36/zhVygz2w4ICs6Kqlfwx35Hfa5ZJy402WUYhnZPXrn+uSCkH+8iJGrYhbYOKzOM2zDdG+SLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755864; c=relaxed/simple;
	bh=S3jiyTQHJMjfPTiPLVG77C7JkquNkrqo2ZB3t8ITUEI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dWuys6HeVLufqZBH4Y0OfLKC+yKDQuigvmtOLVgjEgfQNyNWtm0aE4VYcUl3OZs0hDmMj+EobNmcWcviwAXBsTNZDavkEGFl+BgJj2GNgSCOS+XzireY8ZVvaFLwduPA7K7PoyT9QkJ38K/nc2zH1gtk64/XrgVdl2EICj28k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwe6mMFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwe6mMFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C7FC4CEE7;
	Tue, 29 Jul 2025 02:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755864;
	bh=S3jiyTQHJMjfPTiPLVG77C7JkquNkrqo2ZB3t8ITUEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mwe6mMFQh8AGYtBhdyk+huUEkHQ4jGxfPZDkC2JpGX++GIK53Msi6alRVF9obh1q+
	 Tdj1j54lm33YZFdpOsA3lxOi812FYdf1WtMgJFH25FLYySn1M0huTluhX7aAak4lmq
	 umyzPk8WcuoWDWWa5kyo5C95RKrLuHn539y3nruLBgtN8k//5vU0g8BVCSLa+UvrSb
	 SLiVdyzfZZnZZrimInsGmoHCdnjP3ghuHEaBo6jbhZCBFfGx00fxrU4hPX8GVdDbsq
	 AUiNFFCaurl+WAulTrXF9JATfe1Lc9CoSjnzVvdgAA3QK8moX0LyRoR/Sk9Ey2ggsl
	 E4kIvddN7qHwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4F383BF5F;
	Tue, 29 Jul 2025 02:24:41 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250725
From: pr-tracker-bot@kernel.org
In-Reply-To: <9f09c9e0e1e911b43be267640e89f2a3@paul-moore.com>
References: <9f09c9e0e1e911b43be267640e89f2a3@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9f09c9e0e1e911b43be267640e89f2a3@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250725
X-PR-Tracked-Commit-Id: ae1ae11fb277f1335d6bcd4935ba0ea985af3c32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e833f7dfe3c9a6a254c56f2b92a78bab6128622a
Message-Id: <175375588039.935612.8369407609629719762.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 02:24:40 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 16:49:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250725

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e833f7dfe3c9a6a254c56f2b92a78bab6128622a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
