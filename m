Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFF255F52
	for <audit@vger.kernel.org>; Fri, 25 Jul 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476590; cv=none; b=CqRHITgMiW0eIHdXfejhWDMaIQM0rwv651POBiwgNCUtAnktqKK7RGr/zAhltX0tPLm8vHGDEruzxRlo18cfG9+hgSB8GWzn3ge+w4plPAlYNThk6WpSovoRNxUx5qQ6ZogQIee/aCVTCpQrVU8madK8fhNLiOlXrwJmmTdnWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476590; c=relaxed/simple;
	bh=p2GNyAjE7iXApZkamXq7ckrswvmu22VaokMFBYbyKJ0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sMuVqU+0oM1eNSazfwMhtHH0adk1vRpNSlQDXvCdS+ijD+d8Iz/cIwdDmIF7afErI3oF/OOiu/LmDHgJpx+oAGVCof2GgOYNHzdbU5qrS4EtIpxENXMXwIls83NU9xXhI5lGbh+qG4nJ2ipRActg3lFgosuINrbTNZmwHmRWMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O5Pbwc7F; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O5Pbwc7F"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e050bd078cso242174885a.3
        for <audit@vger.kernel.org>; Fri, 25 Jul 2025 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476588; x=1754081388; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZIIxY6ABSv8z81ahgfn3koGHJXTOfKyAKvLEaDaLS8=;
        b=O5Pbwc7FA7JZ4c40+pDWCcwmx23Rq9srEclzrEOn5POgcnuZnLMKJPEysR9XkqSDzI
         qdH0Z4PMVnDGvnsMMbl0pGhDNpzQoHWM/XUmYEcO+ewrHHZNIcnS1Hdc7lJcdAOfQ53X
         quE3LcTtGL6cvK5sWh3kJaSeCeZbrvRl0MXcPrSfnht4/Nmw3M351lmFjrwvrDfCHoM/
         0XQA7rabXfZuUmJDtnrDOvh04cgcK4TXaZAtBVYyiga5HflFYq9semF3zMMevTwAN7mm
         N5Z5PY/SUs78FuTBnFZe/HWwRr0g34+3DvTLTLdu9M70IghIslZj4yh2CiRaDu+4IZrj
         hM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476588; x=1754081388;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZIIxY6ABSv8z81ahgfn3koGHJXTOfKyAKvLEaDaLS8=;
        b=EOsTn12oqjk8RMmrHVxAcey0ESpaHDDbVunxJAIW5iGta3Qbp6EuTVU7ijC8Ct9L/F
         1u3uOuuiTTtNxKlMcydCl52nDpLaEev42fttpnWoursA6FbtuFARIRGwJg0sKx8HtiTP
         EEVm77oQJeeI7tT6TTVlJe8UHip2JUSmhHw1FbuS1cfyOoLN+igyoytqZoy8v8aDkfLP
         oi5+rOulxWUpT0POogLB0eO+lOWNkO+yJBu2TJnQ8kmxgAp4ZJJ6F7gL9GlPV8dKS9AB
         ol8CMdP3vLuRMJsX64TTYmtw1QE2Qz0PHt7vStrs6vZLAkK0VR4L7ytvW6aaD/EjFvDF
         vKwQ==
X-Gm-Message-State: AOJu0Yz4VgngPZRxKi+V1wSjHnrlpP9brbJZsnJCg7XXZS0G5j+sKcAH
	JuZDyer40Ghttotdh3LADOOYVDcwNkYjn93jWBuGOoavzCV4gVk90o0yG8Sq7uWeZA==
X-Gm-Gg: ASbGnctMfaVderm2ls9zwnqCQ+h/RuefagDunJFHlPCa30c3UMBZNJcwSuCTPMkJFS+
	MzEPV6Q7EXzNPdxFy6ekSK+/8CTB1a83gItMUeuzNtRlW0340b2bu+yL+hNA4OGkl9VoUnrzCXJ
	mdw2CoVP6yECvuZW6M/WnHy9rZMGxwDSXqfZSjmo7jntMwxY6NEkFPoAYd/8T5bUTrq06yhJgqy
	lc1ULS1t2BlBdeKcro/NFn9ZSTSZX9h7ZIIIvm0p8uM1WQsgUhTcePmK4LUmEsUU9OPTAX5nA0s
	+RJHnbHgPXgGANJcsNcea4PAFVlM49/aWWa5E5LiGfjQOy9xBCTtxrEHekGt+DLJpZrwjFiUqXB
	6FT0xYvd8bY2XJGgM2uuNvECIWHmpg8rRHTXwmoIlQxO94teeuFTonrtKCz58h1VfiMs=
X-Google-Smtp-Source: AGHT+IGs1tp0h7Q9zEdF3FGJM/PEgCbtWDjUvz3/6PFOrimy1pC4YXH5BKmWx16MOmz4ZbnQctmj1Q==
X-Received: by 2002:a05:620a:1d95:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e63bfba1dcmr340213685a.47.1753476587890;
        Fri, 25 Jul 2025 13:49:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e64388fa6fsm38402885a.76.2025.07.25.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:47 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:46 -0400
Message-ID: <9f09c9e0e1e911b43be267640e89f2a3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250725
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A single audit patch for the upcoming Linux v6.17 merge window that
restores logging of an audit event in the module load failure case.

Paul

--
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250725

for you to fetch changes up to ae1ae11fb277f1335d6bcd4935ba0ea985af3c32:

  audit,module: restore audit logging in load failure case
    (2025-06-16 17:00:06 -0400)

----------------------------------------------------------------
audit/stable-6.17 PR 20250725
----------------------------------------------------------------

Richard Guy Briggs (1):
      audit,module: restore audit logging in load failure case

 include/linux/audit.h |    9 ++++-----
 kernel/audit.h        |    2 +-
 kernel/auditsc.c      |    2 +-
 kernel/module/main.c  |    6 ++++--
 4 files changed, 10 insertions(+), 9 deletions(-)

--
paul-moore.com
