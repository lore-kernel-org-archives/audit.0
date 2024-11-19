Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244619DF99;
	Tue, 19 Nov 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983016; cv=none; b=Fajex7KWTS9q3feptIlQJjzJMwaMFLbdAGs8mbj4JspDW16eW5BdHI7PP0ClXII7u0UPyjHb+JpaHiFbjVh+xPQmCjKCZUphsv/+WXOxxO7JInbvyV7Cw9jsdiLieTuzoOk4gBdNqm1kOsYJGANpPPNdEAKomATJFPZsqvGDbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983016; c=relaxed/simple;
	bh=MOSsfs2FaX3O9mJNMXBwA6+Mc6kGGXxmP6Hgj4ZLQ0k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h+YTwQ4+esFO5AD+QxJq7llqilP+iEHPqcL2gFXicUCaOaJTOgUSeZNN0K9H4TQvyRXPmukFQjQ9ptX0sXLdgHd+3Ux2x38zGaXNBEUDm+MeARS4q1S/Z03zTBiU0e0gulFMHC4pg7V4Li1qc2WqwVGXrJGQi8KJ891P1HvR2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkYI3h10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkYI3h10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB27C4CECC;
	Tue, 19 Nov 2024 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983016;
	bh=MOSsfs2FaX3O9mJNMXBwA6+Mc6kGGXxmP6Hgj4ZLQ0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qkYI3h10OgewT4ds1QH0XcT1T2urs4p5uq43V1fV8/e5AzkgLg1MapXQw1PmWo71y
	 FNcoxsKGt68BPEp3d0K2nR2AYCaGj6KPzHGLHtDKzyHmqiaawLzKEpJSI7N93CkRFs
	 UYVyFv0nDfCGPepXl9p7lSlOuInhhmcSF52wSoDB+xPmXnbOnv0sMZJvbFs3VU9dG9
	 GiVmm3iuIGGQfcxrb8Dx3+PoyzHmvl+mmysE95WQ5YLZ60PJOVd7hPfJfKm3HKaE9Q
	 Jxglf7rKYh4gej7k1wiJ3MYd/eb3xT9EEe4chuJai622EiTKaYmV5EInn9h89Vy9Bw
	 lfmv//3MP4fNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0483809A80;
	Tue, 19 Nov 2024 02:23:48 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20241112
From: pr-tracker-bot@kernel.org
In-Reply-To: <454ead68c33bd0ec6297a6931451f174@paul-moore.com>
References: <454ead68c33bd0ec6297a6931451f174@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <454ead68c33bd0ec6297a6931451f174@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20241112
X-PR-Tracked-Commit-Id: 89282beaf75d81c9e04da7bc7c97bb261c2a0204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8220b0ca79844bf5abb40ff067fb1db18eb79f0
Message-Id: <173198302726.73657.15818512109972331671.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:23:47 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Nov 2024 18:02:06 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20241112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8220b0ca79844bf5abb40ff067fb1db18eb79f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
