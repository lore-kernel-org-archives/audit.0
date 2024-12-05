Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A519048D;
	Thu,  5 Dec 2024 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441262; cv=none; b=mQTojSGELCUJmizzOaarzzJr2pJbyb7mIT3/gYLj7UbPb4wUJLnkFAIX/sB02p4nClmfp2dvSMFttM88pJOKmAUlzdspZnYJPG19yIE6IoO0mv//VCamlIqJYPq3xgzm8mD43ZnwFhEiOh9QpHs9vMMpoSwlQ4E1oeWuKVD1ZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441262; c=relaxed/simple;
	bh=1ScEfXlTHeZwy3XlJwe28ZVAmVZnICzxliopjJBnIqE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pCmzIh+tyP6jbVvdQeG1za+4C9xBiDbIBfPh54/1Wx8ICG/X5zgibqcSmiPnbMgF61ntEgs9ul2f8UsJpy0kOkLqngQpcjQT11M7ukePeCjrATI5wXErEGHFdDYfhURNlhty5XV4CGoTu//VVcpqBL1CTyj02FYpuIRaS5MTKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ7Dwomh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ7Dwomh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328F3C4CED1;
	Thu,  5 Dec 2024 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733441262;
	bh=1ScEfXlTHeZwy3XlJwe28ZVAmVZnICzxliopjJBnIqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fJ7DwomhQoWWsA3QsUIS6w4EOFkP3XPQdT0F6aoAkhSs+2byvgh9LYxB8zxeG5q8l
	 JEtMXr0gmzdx0w0pEz8xbXB+/FmEtR2KVxUfHNMhephf7vnlMeML7vmtEC1NMGFchZ
	 dSA3OjDksS+HCtglQElMXsiiK2z4dggA72kICDwdNNHqQtRbnlTvRgyOpF9vl/gu2B
	 meCN3xieyqf5GgoODIKL/IIwjHOYy6vso3l0UGQjQumhCzpOw/6CFD5o3MrCQMuQ6M
	 KtL0ACe6tuqzAQWji1A2M8S2PVUipzY6X1mvwga4fRigoXf8Pcl/OWxcRqnysJWm1O
	 ugCao5kENejpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 359B0380A952;
	Thu,  5 Dec 2024 23:27:58 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20241205
From: pr-tracker-bot@kernel.org
In-Reply-To: <70abed262882f79e63e747ef56a0379c@paul-moore.com>
References: <70abed262882f79e63e747ef56a0379c@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <70abed262882f79e63e747ef56a0379c@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20241205
X-PR-Tracked-Commit-Id: d9381508ea2b590aff46d28d432d20bfef1ba64c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8f52214c61a5b99a54168145378e91b40d10c90
Message-Id: <173344127686.2101722.3970437290028838247.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 23:27:56 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 05 Dec 2024 18:06:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20241205

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8f52214c61a5b99a54168145378e91b40d10c90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
