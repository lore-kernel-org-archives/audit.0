Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03E1ADC6E
	for <audit@vger.kernel.org>; Thu, 30 Jan 2025 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271875; cv=none; b=bkz6MJDangfqzjW+gAfPWWau+scF91Sv9u6CnaxsvcUVscrcV0Xe9TszkfQDc8qcRKuA56pRKF+G4jHla6yqF4wEuJaGuAtNsygC4K685xcrbPdyp8kH9ZuZ8/t7vRZT/VkzyPa5K1vU2mxZRQIZijnjntW3Lcar4EzZi8has+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271875; c=relaxed/simple;
	bh=tgWvnYH5oTM6dhjNm6f6hUcEJTgdrrI3vJk9q0sgdng=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sHd9QA7r4bIlgEegcffV7ZpX2QQgtp7bzRIFXCI5Qd9InqkfgIHYFUm37fUZnp/CTtJmDo23LFKYGvmHnX7X72DvnlBmqcH5+FWyYGE2kF/O7tktLKfwuBqDTut2UI7aDgbAeGX05wjTwvKfPf6KnOUyEe9sCDKO7pEGkJ3VJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rasuudn7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rasuudn7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be44a90468so155701185a.3
        for <audit@vger.kernel.org>; Thu, 30 Jan 2025 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738271873; x=1738876673; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh9tpkSxXMGf5zMqPOwexbkhnNo+uevpuh5cgFt0vpc=;
        b=Rasuudn7sf8SHKjjLmEqlYjIRgt+q05uouxBXWk1YbEHU71rhWG6XfStQIqml5YN/c
         ZniU4ZkJdroXePef/kp4WrzCqDW2baKnGlSeYUB49kAh2fBdrA6niteK0Bh+wS/CmL+1
         9cujTQb2+R/O1aOKxiuRb/6Coe77RyPgbIA4SqUVZoh0SZqrxxitf12/u9yEL4IytMS8
         D+FqB9iZpgQqphk/cmmlrJKRstkFVzP0PgZG7Y1vub98CqfQcamH7lR9jmdGmAXHHUAa
         SkfI++Fq7g7M92dsTT0UMkoVvbsAf00wVHnJXBtItQ1mJhPmRJiQYMeWzYUzUxATcVWk
         sLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271873; x=1738876673;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh9tpkSxXMGf5zMqPOwexbkhnNo+uevpuh5cgFt0vpc=;
        b=PgO64nO/zVTX6vsc85zfEbmDYpoOdCc+cm8vwD34jyn+x/J78i40272bOBJVkH1AXs
         m8zKnZModfVYFs7FBoeDgks5QtyWRcXpKFXj95xs3o+d4QzQsyxHzdYNnYb7GvkMvIaM
         FUls0SDa+/hWId6vVSkApZOIyIyl+FBDhK7UR9NuEOcYXlTaSGi/ToshzyMNIsCPzwk6
         ltlE0BsWLUSU+O1epnHbi9CWTbYAHjrJ0vuDRE5PRxkc1Moaq12fMT5OSo51NkNp5HNR
         b317n4ZaUeKYT06ArEhK0a3znX66rQkTWrg8mnyv1uYYmxhuAagssZw1GJKCJL7Cc5lu
         sm2w==
X-Gm-Message-State: AOJu0YwuV88whBtPDpFlIFE6jjTcD2uexJe7TWkKcGtZZ/wr2+2JqFvF
	oHTqJL7g596e61qQvZexdFH5/OxFVQD2Y6HoFgtHbcaWt5XqtWfJ3A/ZcrsEbhlERaQG7+9NvYA
	=
X-Gm-Gg: ASbGncs2iN6Mdo6n2GkdPXrQ9k8CsRUipD/bcqZwDpaR2Sns91iGaSVAZ+OHrKeWhlH
	s8GkF5qRoHsXVCceFr0NatZ77GIoaEnqZf707PYnC0XoooAkIOD1FWLICkgIZ50EOOh51ne+xWl
	z5CI5l7m2XxRugAbSy5JWzAo6FhDEJeEiJQRaBWxANRlNOFxiChicE7/hoj96ybR+CVeGbzcg77
	DlWq8bzvtgreZRDf2ORNZ8DlC4R1TRBoLLEpvWL+4dvQHE/69ZbWsPQpMh1eSDtikIxwOnxXw8p
	fGfx3qTfBA==
X-Google-Smtp-Source: AGHT+IELj2z3LPupY1AVQnEof2jW5O6yCfElWrWlnuDWP2hPXBb0Nkqj+lI95LnX5Xxohiw225+QiQ==
X-Received: by 2002:a05:620a:2723:b0:7bc:df55:2cd0 with SMTP id af79cd13be357-7bffcda869fmr1574885285a.48.1738271872671;
        Thu, 30 Jan 2025 13:17:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c00a8bc774sm114393685a.6.2025.01.30.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 13:17:52 -0800 (PST)
Date: Thu, 30 Jan 2025 16:17:51 -0500
Message-ID: <e2fd759e32633e07ac8ad2799cf22acf@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250130
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A minor audit patch to fix an unitialized variable problem, please merge
for v6.14-rc1.

Paul

--
The following changes since commit 72deda0abee6e705ae71a93f69f55e33be5bca5c:

  Merge tag 'soundwire-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire
    (2025-01-29 14:38:19 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250130

for you to fetch changes up to 35fcac7a7c25cc04f730b9570c737f31295fa92d:

  audit: Initialize lsmctx to avoid memory allocation error
    (2025-01-29 20:02:04 -0500)

----------------------------------------------------------------
audit-pr-20250130
----------------------------------------------------------------

Huacai Chen (1):
      audit: Initialize lsmctx to avoid memory allocation error

 kernel/audit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
