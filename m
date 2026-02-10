Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16226E702;
	Tue, 10 Feb 2026 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684612; cv=none; b=VD4SrVBHTVeQXMnO7xKtU7jqvjvGzAxVw9wBfRclUYFIgdqg42I6JladLZlUGxNs1CwiVb/yoEoL6OARGjVKUsMsXaoc2SksPNyiS7gZ55Zz6mYSj7ujbYgTOaQFXW0a8QO0IzDXZJjUS2z1OV7pCPsbedKNIR3xGWV1uxWufyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684612; c=relaxed/simple;
	bh=FSaGNbyfQxNk67ZPFCVep8DPUfscQAF99mLk5sZgULQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KHCo8VDvIIhkub4klDtERoCPnRCQuHlVi69cacZtNR/qyO+AdzMLTRUqYmWXcnWp8jq7xNVUcVccFDFDMeMGhGA5xpPfJB0EUJzfnrFV0pesj19EgZ+HytPTrn5KGKTj/OoDLj+4RkJVl3lfUDcteZW3/saKFYHgZmBEuOLmRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srACoW5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srACoW5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC8BC2BC87;
	Tue, 10 Feb 2026 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684612;
	bh=FSaGNbyfQxNk67ZPFCVep8DPUfscQAF99mLk5sZgULQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=srACoW5ZcAdkZYaIYrYhkOFQGoRj/W9hboCV7iLhNAKrOLd9Xwm3/R1Q6lvz45bFa
	 kZubHTRXAktrhVcYp6Y5nqXISE+JWts/S2nPfYnerrbQc8MAf8Y4T+6RwTiGSnEBNU
	 gVqvfv8adreo4D75ddzWVfVRzgFeZPihPvUJozmCW/2zYPHS4ZEu1juneXm9aCACkx
	 fkiN1TniKCG1B38wacxWb3U2radGJ2jw3q5LwyiYrzQnk1R22DhcvkyD7luMmaGSqu
	 kD9rNV+U7lcqGzBz7Q7rsfuzpC5f7VWzgHfl0LQ0iL0Dr05STOecEfWHCBk15/6Zxr
	 9ug/+alTT6zyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71821380AA4A;
	Tue, 10 Feb 2026 00:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260203
From: pr-tracker-bot@kernel.org
In-Reply-To: <4d8d54dd3db528deba7eddf05201b1df@paul-moore.com>
References: <4d8d54dd3db528deba7eddf05201b1df@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d8d54dd3db528deba7eddf05201b1df@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260203
X-PR-Tracked-Commit-Id: 76489955c6d4a065ca69dc88faf7a50a59b66f35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 698749164aa53cc313248efd2dc1c25dcf25c99c
Message-Id: <177068460835.3270491.17744028566142916648.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:08 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 03 Feb 2026 23:10:33 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260203

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/698749164aa53cc313248efd2dc1c25dcf25c99c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
