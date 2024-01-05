Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A884360AE
	for <audit@vger.kernel.org>; Fri,  5 Jan 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BZ4Lb+nj"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd1fab03cso96436b6e.1
        for <audit@vger.kernel.org>; Fri, 05 Jan 2024 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704496854; x=1705101654; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7F9KPAP0CbxJji93UCZL9/5V8dtiJiTeci+Q8LXYc0=;
        b=BZ4Lb+njtZXNfrnZzJ4Uk91ee7H/5PkYFAYnY/a9obEhm9xQuSkz7iHLUZOMAMEN8p
         zAX33FZ8CFMsHmblipTsF20955XOCut7kRswZee85LmswwygFsbyFH8PX9Z05SVk/FFN
         VPPgRfduIkFYk9BkNi7hF+wt1I59NwqwgIxHiMjiHrClqpKqtF8JaUTOkT/Zhn+L+BZL
         1p+AGaBQosc6goQdG3a27BFqa9nFUwd94ix1E+2NoAHzeMWtBVCEIs5ZZm43cHKF6TiU
         xCF2lD7mogNQ0M7hRuewpMqu9G47ELpkIw1Lmec7QYr/CIGb1jdg0ldQqpmC378i0joc
         qzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496854; x=1705101654;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7F9KPAP0CbxJji93UCZL9/5V8dtiJiTeci+Q8LXYc0=;
        b=QURq3nXUV2uqLE4djuEajusHTdnJ+3JjMeT/Dy2QyQvXq6cQirsIqQmn+JUzFrZo5j
         71Wzb9u5tg9auLj5Z97RvR1MFuYb7Cz4BxJfrp3vulman+yfolHdHiH4K+f+J7lmOUb9
         c8EYSKARkT5SJDHMaTO+EvhvgIWz9sgv96bC95iFiFD6BJKnwW3nTAbzQnBTkBHOro9F
         f0VtZ0LKJCGlqv/p5YKCVNz1WSNLYBAeACmJ3hr6SCx876NP06vYg7RtqFi3r5zNz7gu
         PLWOck+EXI3aTT/lvK4AAoZA+/+XoMvATcNZMt/WWMKTEYTT0HU3wCrkxqhTJcYmVqn4
         GqTw==
X-Gm-Message-State: AOJu0YyjmcDqb6B1IIF303jJJN8vX//TFPT6SaIA6H0xEdwdV3d+Y8qO
	E+++jbsRVVyPLc+79GqhArVb0Ui72mkm8Xxh3wsrea4OUA==
X-Google-Smtp-Source: AGHT+IGU2VgW/g6B+ajhJWGJ17QbYBK0mYcGIATN1S1BJUy7sUprfFq8n+rVst04NExK+UZwcGCuPQ==
X-Received: by 2002:a05:6808:f10:b0:3bb:c863:7c23 with SMTP id m16-20020a0568080f1000b003bbc8637c23mr163240oiw.67.1704496853866;
        Fri, 05 Jan 2024 15:20:53 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q13-20020ad4434d000000b00680ce23bc29sm974621qvs.71.2024.01.05.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:20:53 -0800 (PST)
Date: Fri, 05 Jan 2024 18:20:52 -0500
Message-ID: <f88ee41d9615f7382f89f6a3fbc2f0db@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20240105
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Hi Linus,

I realize this is a little early, but my network access is expected to
be a little spotty the first half of next week so I wanted to get the
Linux v6.8 pull requests out now.  The audit PR is a fairly minor one
with only two patches:

* Send an audit ACK to userspace immediately upon receiving an auditd
registration event as opposed to waiting until the registration has
been fully processed and the audit backlog starts filling the netlink
buffers.  Sending the ACK earlier, as done in this PR, is still safe
as the operation should not fail at the point when the ACK is done,
and doing so helps avoid the ACK being dropped in extreme situations.

* Update the audit MAINTAINERS entry with additional information.
There isn't anything in this update that should be new to regular
contributors or list subscribers, but I'm pushing to start documenting
our processes, conventions, etc. and this seems like an important part
of that.

Thanks,
-Paul

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20240105

for you to fetch changes up to 4e8714b76613e6284b263274d6dddcfac24be262:

  MAINTAINERS: update the audit entry (2023-11-15 12:24:00 -0500)

----------------------------------------------------------------
audit/stable-6.8 PR 20240105

----------------------------------------------------------------
Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Paul Moore (1):
      MAINTAINERS: update the audit entry

 MAINTAINERS    |  6 +++++-
 kernel/audit.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 8 deletions(-)

--
paul-moore.com
