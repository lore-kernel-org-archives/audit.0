Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADDC83F19
	for <audit@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbjH3S4j (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbjH3Qea (ORCPT
        <rfc822;audit@vger.kernel.org>); Wed, 30 Aug 2023 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BB1A1;
        Wed, 30 Aug 2023 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D7EA61FC8;
        Wed, 30 Aug 2023 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B541FC433C9;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413266;
        bh=UKUxifRXz9K6/DkjUlY6SBIYCA3GgsTRL12eXRZSzps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FoGMPTkhktSHe4dMJZbA5IOI0FPC8joGQrCmUZgzxzPWAtBPLj45/s5/Bs00oU3+t
         l39zGpH2AG3C3TDz5FW+MHb/BGHb7WYRh6LFtNU0Rp0z0swA9Ttjj0b0vwYcX7NeO5
         bb5pdAuo6XcanKECJLBdsDeWPB/sKGm7TJUH7jYJZ6iFdBUSykoJvOLLzrcGsvou9o
         JjS4e2etgdyfiusjidA8sZ5vYPf2kZSdKOt/W9eWEhKq7tsmNLhuv9j6D+FMhJRXFH
         FNqr821+W4w9Tb38uDMJ6gYIhC8iRKCYdvGp0WRUHoruH/PHvKNOPhqccJQNOLqalF
         TXwjNiPD2EYpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2C19E26D49;
        Wed, 30 Aug 2023 16:34:26 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
References: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230829
X-PR-Tracked-Commit-Id: b1a0f64cc65ea2ebfaae9e0ce623e993a7d24257
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ea67c4f462e1eab16ced755816143cbd1ebfc7d
Message-Id: <169341326666.28213.7014295122642174845.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:26 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 16:40:19 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20230829

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ea67c4f462e1eab16ced755816143cbd1ebfc7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
