Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649C23A9;
	Fri, 31 Jan 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288770; cv=none; b=OcngnAOdw3r04RDh83TgMXtFBKoNvkMRKd0dq/yQ/UUGLecf9yyndOsgmXwZPB0WWJo/ECtUJoiQpa4REUBhRvD/2tc5p9KRj+lY658RXn1K7VPfRFxfotSxfdwuvt6SRbMNJjBdqhFBetdEF62xTST69//zamDIqPy7TAWo6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288770; c=relaxed/simple;
	bh=Q1GKUWEjLaYVKphPM+rWeriA7aHz+oBCp5W0dlnVZ+A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mn8qCXPKFo9KCTi56vPUDFzs0KNtuSl9bh04f3i3wzcyNcZOeM9Be0lIBuaGbUFXyB8HD9pjDhNk2jPFCHpWMFA+HNTDZcveJfZaQLHvp0pkpx9wFdnAo8R/aZ1g9ScotGO/wbI3CxTOVvbPH77Sio6l346qn895NdWxwitro1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN7OeM5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN7OeM5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A49C4CED2;
	Fri, 31 Jan 2025 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738288770;
	bh=Q1GKUWEjLaYVKphPM+rWeriA7aHz+oBCp5W0dlnVZ+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eN7OeM5Icxx3Yr1q6ZwF+NN6omkZKaLDsAO1v3kMqe13rDE5iAEkC95yRv71zINUB
	 jUzieluz1JjE7yeR5NNZE1RrvIdjKeCApJ81GgY3YtxsRxSgYds1866MwY6b5JY+nO
	 XzVAYC563Xnv5b+y6wFnbIOqthyTw/beiPnQAcVLobhe2Vx2515kE/t6zQuDx4Q/kO
	 4amPajblaNFwu9iqUl+z9fcNHot0q/ncAXhfJfhPDAzw+l6JpAVJWFHukhD78rwjHP
	 NBZx42UrWWIs7JK+UcpiIUiR090A38TXbUdqw2e8GRGLofQWDRDLvpFpiii4tBkY7R
	 bEsaxjM+PT+Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D49380AA66;
	Fri, 31 Jan 2025 01:59:58 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20250130
From: pr-tracker-bot@kernel.org
In-Reply-To: <e2fd759e32633e07ac8ad2799cf22acf@paul-moore.com>
References: <e2fd759e32633e07ac8ad2799cf22acf@paul-moore.com>
X-PR-Tracked-List-Id: <audit.vger.kernel.org>
X-PR-Tracked-Message-Id: <e2fd759e32633e07ac8ad2799cf22acf@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250130
X-PR-Tracked-Commit-Id: 35fcac7a7c25cc04f730b9570c737f31295fa92d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e20f2bb8b7b6047182066dde0a101e0660519f6a
Message-Id: <173828879688.1145982.8350251866833885244.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 01:59:56 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 16:17:51 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20250130

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e20f2bb8b7b6047182066dde0a101e0660519f6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
