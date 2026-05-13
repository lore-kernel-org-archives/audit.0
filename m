Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FA2D29C8
	for <audit@vger.kernel.org>; Wed, 13 May 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712827; cv=none; b=V2sKJCreosS93pKYId/+MNmAdL7l7ixgdTJqNcJCkOSeLXPt+elPhkir2Srvcu+OeHwXFb2sa69cF0lf5niGLaPf8DXcQRcYZP2VcKu2dGFgnAdnLqfpekTi2X06h98bj9E9+s6JljRe9HJcDSWQiG2hEx1uuo6Fgc191HCnd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712827; c=relaxed/simple;
	bh=FZqT8nXlsK+eZWe1EaYW28XC5L4LRJE6tQObnuJ1VTo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FwXmAkp1W0rcudpDk9jhbfJFY1jve/k/RUURGRAtloD8xXo6EYTvr2IomIhYY+9KilRx7bXsxM0DDYEczYYfIe3tCFAMDJIigR5w3LmD2S9knFuDMOfKqour7nk8iO3qBgfbZOgYnbm0DPcvsXcPV1HMlgTL5eB9/y5sExP5hTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YWgL4jQl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YWgL4jQl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5ad864a6so72026071cf.0
        for <audit@vger.kernel.org>; Wed, 13 May 2026 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778712823; x=1779317623; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ll82cg69qLapmgKBcA6NGIW8Yuj+yxdk0vJiMEsPzI=;
        b=YWgL4jQl4vCI9gBepVNmeC20fnjDBFumqsc4V8LnaRpUr7304CqIM4udaZhgW2Jcxm
         7wPfuTtX3eFKtReC2inzhasM/mDwl2qhn8Fg7tXh0YFNLrIHwj2pr43E5aIUmpisxYpq
         7bZn5MEAs4b2IybUSswPTHSt5TGa6ICK4oDGV0ZODZq7nN1GrQfSov3DfRX1X3qvZQYX
         H6w4AZc31wzYNmebyQhc6Q/zZGVvnBho/xg/1/Dvx6Erwmq/UhD7Mvtbrn4pRMnyJLOf
         LkTSfMVrrm5j1nKejb9x2jFl+R1lkzc2V1KfkUPs1kBUotO9h/u2ZfHByz1bcUqKvRg7
         mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712823; x=1779317623;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ll82cg69qLapmgKBcA6NGIW8Yuj+yxdk0vJiMEsPzI=;
        b=G2Lq57CUsJovqE9pl5BWep+0OzCAWtgP9LPhh2F9Z6drL1pBL7r6bYyh+tIjuu68cc
         vFjvwL3ltyvsfEufAvQCYPU7ihLhbsFRsM+AhJ62inBnSKw91l61Y4Gh6BbfqkQokWCe
         I0vPmgeJqHefN0YCydNN4eE2evTW1T1oKbOxFKuERK6p+IWcSeG9nxX2pytuayZBqIEj
         9RrbKicuU4jCtjkTGNUz/KZ8HIdQ2DnNk2oXLmXamI/aIXLeVEpW6H0O7/OETsj/7h0V
         3YDoTMvC2bKu1tmMo47kCPtgYNAw32g2A9i1EOyFSe/EXUH3xAzf1G+2EuhYZXGJb4JR
         SEpA==
X-Gm-Message-State: AOJu0Yxn88DKMFXrSmO/exq2iCkRUT4naCOoQSCogWa0y4BNi39clZRN
	KIWW9c9rdGBfCWXSFz5jue558iFDNYPfRizhAzu9+k0C/UPlrju0/7uiYaoyv7R5sg==
X-Gm-Gg: Acq92OEygEFyvih84IX/jauCL8pcV7beUI4z0OjY+oheg1UKAOGHadUnWVJBpAWg5lb
	6XrwvRVFf+lFpYDYWyOkEiunYr6EDXhaQzDHtyv/r/RmrWPsmGhtrOKSXWvJBC+KOcNmuihKPSc
	Jlc9vT8kwyjOkRSES69BDkAkBtP/XoVdx4NS+lWRAR5jtuLzbpG4pJ+4pvpNMclwdSL6hgXJiA5
	gJSQabNVHINnXo6IlbplyY48BAduq4qps2sK4yLv6hACi071pqg3Fko9TcEylX0HQTnbS2SQGgC
	dIlrOtoxVaTFF1lf5fGhOMCmsRhOCQv65GGAFXLqyWExnStcQUeO2usPxXIoNGNiCZ6dRVW3FIS
	32K+v0+3xjn+TuRZoEsG89Zwh1W2U6953JmPqY3rY+svein0tW4y+g19jUyQJJ0yOlryAK4vfWj
	03TJmSBCey8COJ45O1VuwWALbLwgPKSt/aLnkjsu+XnkeEedTTLg7HoEdcy+IdvB4bI+FR
X-Received: by 2002:a05:622a:1a82:b0:50d:af3a:d8ed with SMTP id d75a77b69052e-5162f5f13ebmr78533031cf.41.1778712823572;
        Wed, 13 May 2026 15:53:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm2142431cf.9.2026.05.13.15.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:53:42 -0700 (PDT)
Date: Wed, 13 May 2026 18:53:42 -0400
Message-ID: <e4ad001116590340ea21e657830d31cf@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260513
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Two small audit patches for the next v7.1-rcX release:

- Correctly log the inheritable capabilities

- Honor AUDIT_LOCKED in the AUDIT_TRIM and AUDIT_MAKE_EQUIV commands

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260513

for you to fetch changes up to f9e1c1324b4d98d591a6f7568fdebf5cf456dfc2:

  audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV
    (2026-05-12 16:10:38 -0400)

----------------------------------------------------------------
audit/stable-7.1 PR 20260513
----------------------------------------------------------------

Sergio Correia (2):
      audit: fix incorrect inheritable capability in CAPSET records
      audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV

 kernel/audit.c   |    4 ++++
 kernel/auditsc.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

--
paul-moore.com
