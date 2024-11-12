Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF221A4D0
	for <audit@vger.kernel.org>; Tue, 12 Nov 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452530; cv=none; b=fmFgkvu7fK2EPhpGogi5eaih/rk2uZaJ8ln74pLbvTai5Xzx2E7avJxgVWFWtBFSW48ymkZBCUDg0usaWGde3XC5xDCuMNo7OoAIMCa6yIZuHctePIRHQNR3KmiqBi7Yd3c4i+ut+2hgOGCWk/K+2o44Ic2cU2gFDdRou7cfLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452530; c=relaxed/simple;
	bh=oXE/JCUWwOWdH1ArXUKVHZt/YMdSbhxhDdtUen0sUJc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FiqZoaf9XTuDCcXZ+5dB02TuzmGjZjb56O/ERCgy12G2UeMnaS8aQBe3ZmFWmknlTYa44ysKLG8K5vFVqy2RyciAhmNUGXw7Tdd9IAUZvpUN236ZrrbDAiMmzrkotJP4wYHnwsYXqbHslEz3njE9S3j86PubUPFBC62ie/ti9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W+LJZjGn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W+LJZjGn"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so1524866d6.0
        for <audit@vger.kernel.org>; Tue, 12 Nov 2024 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731452527; x=1732057327; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7xEoBRAFYilH4gOtSGNPMLQUcKTFHiJXH7d62mAZnI=;
        b=W+LJZjGnxx9+eHtPlLqOJ6cmqrikUYMLzdY2jBmbvbxb6NYTubChiP4fPmKXbmdwsM
         UwuRRW5OZXoGwcoZIitXFn1/x1Z9KesBD85YUT0uDrk9kYktA1kRlmuPsGrMg/uwcR2D
         glLDm5/DBS90mbZscwRu+ItTvlqOTlT/Z/CbUVAjAdwKIMplLK6cd8XHlL+eNtL+dXnP
         LueoOQYg9OlKDG9x3Dlz6oUW8+F+GRZ9ta8ZzXjCuzNZjwMuR3t6K+nuJVmgUYsj8THR
         kboI4NGntSzycBbAzcvG/JsQnvcz+6zS1yWrvcMlL2y3Hnbdub+ouFu9dj18lmJH2RgP
         yp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452527; x=1732057327;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7xEoBRAFYilH4gOtSGNPMLQUcKTFHiJXH7d62mAZnI=;
        b=vTg/GhHlZzx1booixunDUue7GzpikEvs09v/hlpT0FaMRY1XrufndzbQa41b3O21jk
         5iJhHziQUBxo8TnUcHMR5jenAGedN4D5ukRN9Cil5WFtkKIDAD+ccN/uA6+yN4Efv09u
         oSSorLewZSPXpyW1lvkWizYDVipFsgJtwtdxPboqrx2dqAFpRDWvbLWtcpGuv8qz5ZLp
         YHUh7ACl76f8gCoiWnSYcJZCxtgUcUGVMltf7w7bWsm4sSd//Kj6SMUdlLGfZJIefbgT
         /MDv04OwgLOdasGXLc48lt6UGDm7RJ5I+olM/WaHXAJNFHJVE9Mu+YP+XX5HEp3EZSSC
         q5zw==
X-Gm-Message-State: AOJu0Yx7h7XUai18CAgyy30ZJolOhFWg3CI5j4+xKJozNVva8jyqtVr4
	Px3FYgs6ZIQuYZsSQX94fZAA1nzvlaF++HVkVHe3MnNO8TpC6veq6x3MAG4Spg==
X-Google-Smtp-Source: AGHT+IE8XaRudr0FHcnzEs2CiXPkIf+iQYeUtcxKDuo5WOIofga5lhyAVyTfz/1Bzfrk9SW5Rr9A9A==
X-Received: by 2002:a05:6214:202b:b0:6c3:6477:16e7 with SMTP id 6a1803df08f44-6d39d58a359mr307643696d6.11.1731452527325;
        Tue, 12 Nov 2024 15:02:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ab8d35dsm641236085a.0.2024.11.12.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:02:07 -0800 (PST)
Date: Tue, 12 Nov 2024 18:02:06 -0500
Message-ID: <454ead68c33bd0ec6297a6931451f174@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20241112
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

I'm expecting to have spotty network access later this week and early
into next so I'm sending my v6.13 merge window pull requests a bit
earlier than normal.  The audit patches are minimal this time around
with one patch to correct some kdoc function parameters and one to
leverage the `str_yes_no()` function; nothing very exciting.

-Paul

--
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20241112

for you to fetch changes up to 89282beaf75d81c9e04da7bc7c97bb261c2a0204:

  audit: Use str_yes_no() helper function (2024-10-22 19:16:50 -0400)

----------------------------------------------------------------
audit/stable-6.13 PR 20241112
----------------------------------------------------------------

Julia Lawall (1):
      audit: Reorganize kerneldoc parameter names

Thorsten Blum (1):
      audit: Use str_yes_no() helper function

 kernel/audit.c   |    2 +-
 kernel/auditsc.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--
paul-moore.com
