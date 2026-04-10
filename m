Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D731326B
	for <audit@vger.kernel.org>; Fri, 10 Apr 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863582; cv=none; b=VA7Yi9dBRcAC6yz/CA6zkLKUkT8FX9llc4NdN9oxdj7Rjp0q8Wv+qrzy3oNbe97+6R9+zOkbqKIkjPah043qarrYLaVOw64NRMs04O/Qe4iBqUtUP25z9gBuYbH6Y1Bk9yi8ORsr1yUknFATZxfiyN+Ikrl6r7p+p1p+d808BYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863582; c=relaxed/simple;
	bh=KA7uUOnhRww9b4GyvkYPCc05eBfyeVHZOYeTqjsjtf8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=SCcV8Gb9Q/ePlFYHrYVP7H6gjVaC/HUWKxg51fFddlWWQt1w7JCDY0+p89WeMRvN6B7CIjYRpiVNCCtovaN66ZcKtXBpw9r3lLkOvIbfe2WaJdZr6Fua5BdkL7eX3Z00hVZ9+46pb0709RcYo8EI9blodAO352vpC5BgPYA2Vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a3OI1ZAJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a3OI1ZAJ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d424af6282so287377685a.0
        for <audit@vger.kernel.org>; Fri, 10 Apr 2026 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775863580; x=1776468380; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tuuWDfVqo3HnwaiRO7L8wSSM192dD/oFR/YejEl62Q=;
        b=a3OI1ZAJyWemcJ1/0PmcAun4ixME1Z0WFva6RblBDZiMnFd4r+s9Qq1Wi2q1ZpA46g
         z2ya5zB1+Dp5h/pp7TCWQXMcLtDasskpQlbRPdCsAPp8bkO2QdAE8XUUfrqsrQYjHY51
         8iQQJsUcmzvnxl/xgjit4XQkSqtaERuShq/OFWoGRQxBJ48E44zsxmD+GjmyVcQFFtx8
         C/QvNg29CU18nvsSmzeAIeBfIdvvMScBDwO+HXmWobH1ox844LGDKaMVVA6v+5tfu/20
         aE3bS41WfIoKvqVXTgWpSSZAfpb5hNIcR6mGwTIeIzKaIZy+e7UKkjPylRQnGXu4iiUR
         Xhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863580; x=1776468380;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tuuWDfVqo3HnwaiRO7L8wSSM192dD/oFR/YejEl62Q=;
        b=ZB69RTP9p+wtKSZSeY2cthfHG0nabwcI9wE7Qrbj/rBstkRkh5wCZAGLwNwDqMJZRm
         qBfrDQbcAWElahYbP/NCzLO1bTWdhXcLtFshtBGc/e5LpLUI9FBlFIbqbouk/Bolg5GS
         YlLT/axPViVlOZWdKuHcaNprJHH3GhAAXmX4FaBKzxhmWxn+x9KtXoArd4HheyKyRgKW
         n7fGFqRX7CE0EMnLi1YxbwBA8WEuQVN92GOYHFgU5tL75kLwvD32OvsD+uctvz/plJ67
         gkfVvj69GGo1iwvTiLIyxCc7dOSPXC9pDxp0iUQR7UnF4ekLmNvI/EY8J66YWKNCe+A1
         8OXw==
X-Gm-Message-State: AOJu0Yy+5fCbUA9XOkiD9E5sshq55/PkhbhvqEaiBLkwRku6rCr+drDj
	1XD84WhdtESk2XDUgRMY6D2t3vkFQqMhrss7KZlOrWuUkWGjlkYtdYzuf2zYpVS3Hg==
X-Gm-Gg: AeBDieuLWR4sBmngCTsQsB1QzuMc/2193Ao7xM/cakhXYddcqq3jj75nXvT6to6O0JY
	F4kG5csdNk+sjvB2duh47Oo7jo+GzD5m82/XA7b/hLQjf2TaHtxrw1Jj+FmofYnY5hZd+Q0QbZK
	DD6p5P0AGIgi5ZbTidGCsEVKNx2a6qZgd0ZoxmgcxNr405Baz8OKtSzanxjMJh+OF67AsU7lpxb
	WlEqOC/6ZqblzRanrYNjbmM5UpGy7NxuSconrZqu7pSwoTr8Z8b9cB6XcyRohyeFOSI3BUfspm5
	/tYSzvwYeXFkou2Nt23O1Jfy4VR+aBvsrleo/3/bjGV3THYPaKizhjA0oFOKzrcUQdv03/XrVlE
	RlnQ/vCP25RIdZ9fX5SnQzIO0mojPyVAkaWc3CDnCEkavceiNinkbHShiT0cBa6yDCQLO9Lezvv
	cd55CxjIG2IobHlyP1SSK80QpVjpD6Ynu+vB0yDm4QZywCGQXptkHUkSqhXJFcE5B2gayS
X-Received: by 2002:a05:620a:294c:b0:8d0:162:31b with SMTP id af79cd13be357-8ddcf2b18cemr727439985a.32.1775863579812;
        Fri, 10 Apr 2026 16:26:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb6469c60sm330001085a.14.2026.04.10.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:26:19 -0700 (PDT)
Date: Fri, 10 Apr 2026 19:26:18 -0400
Message-ID: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260410
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

We've only got a few audit patches for the v7.1 merge window, the
highlights are below:

- Improved handling of unknown status requests from userspace

The current kernel code ignores unknown/unused request bits sent from
userspace and returns an error code based on the results of the request(s)
it does understand.  The patch from Ricardo fixes this so that unknown
requests return an -EINVAL to userspace, making compatibility a bit
easier moving forward.

- A number of small style and formatting cleanups

Paul

--
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260410

for you to fetch changes up to 360160f75592bdc85edba8fe78fb20d90924c7e8:

  audit: handle unknown status requests in audit_receive_msg()
    (2026-03-10 15:22:43 -0400)

----------------------------------------------------------------
audit/stable-7.1 PR 20260410
----------------------------------------------------------------

Ricardo Robaina (4):
      audit: fix whitespace alignment in include/uapi/linux/audit.h
      audit: remove redundant initialization of static variables to 0
      audit: fix coding style issues
      audit: handle unknown status requests in audit_receive_msg()

 include/linux/audit.h      |    9 +++++++++
 include/uapi/linux/audit.h |    8 ++++----
 kernel/audit.c             |    8 +++++---
 kernel/auditfilter.c       |    3 +--
 lib/audit.c                |    2 +-
 5 files changed, 20 insertions(+), 10 deletions(-)

--
paul-moore.com
