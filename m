Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354832701DA;
	Fri,  5 Sep 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103447; cv=none; b=aw99zfFx88xvpbi5/0D1lX3vVT8RKWHdSYalX/E3FSLWl4xbsiGLAOv+fIEMKOmKoobx5S5zNJiF2zDuCTrYxrIB5lGiBbHzqFGz6eaCQyDkmaT9o5YoPGNDFeTQ+bWsceCg6ZuYcnCdFRvYD7kTgamSYgX0Ei4CoNEazwEj8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103447; c=relaxed/simple;
	bh=59xDGMOg1rEZ3zUCEsQ8Srjr10q1wTcWWHQskQz2VLw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=glfWf7Iq71Nb4WfrRJ8VPvqoj1IuWWbGqt//EhUafgVEdaRQAH4LTl1V2ow2cJwOq2d+5amzX33BB9SQpCvmPXZBjCZLfEByD4u6Xy4Ly5VL89gjh797vr5ZMFSwMHcRN0JXWf0Q44+L32AyplJoIJQr8Yr/V6DL3rS5k2wI2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC/EMx7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC/EMx7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DCDC4CEF7;
	Fri,  5 Sep 2025 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103446;
	bh=59xDGMOg1rEZ3zUCEsQ8Srjr10q1wTcWWHQskQz2VLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BC/EMx7Fu1AGRz0ld6hfnaFAbFg7B+7i/ch+OVOHQ+wRkblXs9OxggmQSx4X3zRdd
	 rQBph5buPQpcS+XjlAHlatxD6XctuYhbMjCNoe2jQ0SOinTngsZh9yAoAYE8p6ESuy
	 11oxuDBsFEUk99TfrXrOlJ7QD/Y0HNCZgEJ97lU50xwqQeQlOJ1Ik5ZTpFA34VbWNK
	 HmpICBehIgRKDIL3KOHLNsfn/CXAwKaXt2BoXrF7VPdmAelPnAC+TE8BS9zIsG7zDS
	 SocfjYZDKkA4cnReunLzfJX9FU828ka9e81Bz6ldHvWD+8VMAQRj1PT19GmEd1RxKq
	 NMOWWy/TWJS7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE6383BF69;
	Fri,  5 Sep 2025 20:17:32 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250905
From: pr-tracker-bot@kernel.org
In-Reply-To: <6af833b45f68db4612ca52dd839d5662@paul-moore.com>
References: <6af833b45f68db4612ca52dd839d5662@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6af833b45f68db4612ca52dd839d5662@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250905
X-PR-Tracked-Commit-Id: 4540f1d23e7f387880ce46d11b5cd3f27248bf8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 730c1451fbc3942d434a4203bd4616ad0b71b23d
Message-Id: <175710345113.2676293.3387784958803581298.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 20:17:31 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Sep 2025 11:37:03 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250905

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/730c1451fbc3942d434a4203bd4616ad0b71b23d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
