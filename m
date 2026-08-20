Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950023D7E6;
	Thu, 20 Aug 2026 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187369; cv=none; b=WTZUSnyxTU0EZtJ1QqFWM7GvJwCxmfZzQWrxFLl/uicdtmNrRGujJILPLZZkC32NeBbopT6S7Fn162Oq325eIA6gSFWQPy4K9gCSazmhCaTxttYQb0IEbexHfhuwwT0BH3h5EZN6ukToifkP/xvGMZXzlg0uVw0ZxK5bYc23Vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187369; c=relaxed/simple;
	bh=sJ5Ogi+fsUFcVbK5q8VvxArOmXxfLVCHOHpeYw1M4dM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BdPQ1uZ/6r18P5kkeSdPym99g3xG9etbGboobWeMI0pOqRbC9KiVaP3z10Cly50eb3biHiDspFESdkmTYIVn93Jb4PfFcImWSZTQGqlUwP+fX/ej77UuS5O+Ss8z5zfByDyLaQzJkcWvFoHTOGfYyjdwnpYe5F1X4EFtylAejnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8w8HnNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8w8HnNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C3B1F000E9;
	Thu, 20 Aug 2026 00:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187368;
	bh=snibsRKNcbiQRCv/tu7XxxfAxx0ovzwsQEMiHXATBAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n8w8HnNKhyCPupg5Z/edj9iURy3+xryBXui3n4hqtlPl3KmxQ7lGR4PbwZLb6W7Ck
	 Hph5vs18WYbmhNjIQjB3LL+MiSM4lMXlvqfywztUKTA/+ISfwLXMa8gK6SzcEPvO2d
	 3uqcWCGW5bSF3xtbjFo8lY6mAwmigHasMO1jJKQhkdX8otz5BV7DIeGbBFpUk9N1sN
	 +zkviQoTaLzObNH4kFI9BPkTpABkHh+BXdPbOXiRuo56SqQxWDBrpZH2YpnqNWNKPh
	 GKhwmw7VrEiHujeOOvjRIOFLB7DfDntcisvCGLeLTswnRVUGYqIaHYyHtEwIx7ajyH
	 mXA9XqrLQrY9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568733811A50;
	Thu, 20 Aug 2026 00:55:20 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20260814
From: pr-tracker-bot@kernel.org
In-Reply-To: <d226b8d2ddfb61be0e6a096f31049de0@paul-moore.com>
References: <d226b8d2ddfb61be0e6a096f31049de0@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <d226b8d2ddfb61be0e6a096f31049de0@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260814
X-PR-Tracked-Commit-Id: 783f0f0974c156aca630f4ffff248671082a098d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83453b6f5131a83af7b2a4df28bc776353ac56c5
Message-Id: <178718731884.3758847.3446144095474155345.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 00:55:18 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 19:16:30 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20260814

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83453b6f5131a83af7b2a4df28bc776353ac56c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
