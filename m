Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B477187FE4;
	Wed, 22 Jan 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519313; cv=none; b=Ba3aFuTds+iK8i/vbUtlblw3UrigQpk9YvPdbkYJHxGOUx4l7WFxNx6pkOcHsIYKl6sjdkEOFhXPCByLQqaHeWQ9M4uI5Xe06xR1ESSo5JZTQgBD7/nJy8jGgBrsARhwNX/65xRJXRqlpQVk/GMg/V8HmJGiruImkFXKsY0brRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519313; c=relaxed/simple;
	bh=W6YXeoDvNfKgrBftY+7qNNqAOfRMOUcYIR+XfTbGAtk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rzBzww9Y7kaDeSxuqA/bDAgfGjpdhE064Ok7nHAWUp4M2/DyPrykG9Q/d7HmIWeEvWFHmn8wfFXYIve4C60JXxa2vUMooWK0OL3CxXqXXntmOcaMMeg1q6l3K3ecyjjyseX1tAO9v31nv+jrvodo4m1rzKI9leRNyjFyJ6Y9NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwVhbp4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwVhbp4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E487C4CEE6;
	Wed, 22 Jan 2025 04:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737519312;
	bh=W6YXeoDvNfKgrBftY+7qNNqAOfRMOUcYIR+XfTbGAtk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SwVhbp4VbitPT35a2V0v5SUSU0TAWsw7V/I+FKYh1WYej4aGgM7pMZp5p3iB3us+u
	 lfMsIjUlXlRKE7XakaqAWWxNxkdJNTzwn7oPmjz1dPOHvGafIOeY2cvSEMsxpDp7PD
	 U6xE5YLybPiKdMfB0h6DMYQ6lrDKjyZKWWERl5aSclq3Iqp6EJMrc0F0V78ySUGGBF
	 lbhTpDM6pPCNmIyczWANBmvgrFPTtvfNtTrDKUxCj33XwRxVhjeBJ4bTWZCZx8nkHZ
	 vJD8s3+Yt/VyHtlataPP+zO9zNe8IFv8J+LU+u7jXjamCm2G7ytZU0Nqq49mbMfDkw
	 bDwvzR8iH7eCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF82380AA6B;
	Wed, 22 Jan 2025 04:15:37 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250121
From: pr-tracker-bot@kernel.org
In-Reply-To: <dabb743aa8b30916ef82bf8295573da8@paul-moore.com>
References: <dabb743aa8b30916ef82bf8295573da8@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <dabb743aa8b30916ef82bf8295573da8@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250121
X-PR-Tracked-Commit-Id: e92eebb0d6116f942ab25dfb1a41905aa59472a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4b9570cfb63501638db720f3bee9f6dfd044b82
Message-Id: <173751933655.229101.4469813102780726815.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 04:15:36 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 18:40:36 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4b9570cfb63501638db720f3bee9f6dfd044b82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
