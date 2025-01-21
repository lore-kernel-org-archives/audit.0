Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB11F1912
	for <audit@vger.kernel.org>; Tue, 21 Jan 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502840; cv=none; b=KR8JJjMIwOTIPU/FsDHn2tFY9Yza0WcLj8cFgaAdNd04IOgr6C+xX3JZYyXmTBhKSwnKovmuHP4w7TZUC/rjoSopOLfv3JW7dsanS0YbFPD3AOBfyeW+BedCSeaD/oPpG17/9NoCqHG+JztrMr93QSSuTtPh/KysWZtTDQgsY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502840; c=relaxed/simple;
	bh=dVhEbFZ3hn5mIIzSJur88ELuLKWzdf/SodSl9Vv0wQc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=bhNNISl3GNElCoHAgZXhy2ktWyKABfsk73AesTgcHbkKYjJjtb3kpXqJMI+WZrVLFDi+xX4dGe2iD8unSJAgodU+BFrnOFj14yi+YVvNgqo2WCc3q9ycKtMDK6m5too4TASItlm9Yzut4Vmx8usiXtNffVNQrGcwOzeYXtuID+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GAyfSL8l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GAyfSL8l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467b086e0easo35040131cf.1
        for <audit@vger.kernel.org>; Tue, 21 Jan 2025 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737502837; x=1738107637; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8qKaMvklOxumXZ+sYzwJZ7YTcDoTElXytH3htbQ1GE=;
        b=GAyfSL8lIwddZT4YDulEbn5vY9k/DNW9TLnUhJAuEPKToviDhkMhfLCSxfrSwRmocb
         6rOI0nrHmxF2C2Cekb/QVr2wnsIlHUMDB7DcL/JziZON0cQ2Y/xMFb6Dd0e2vTv1kd16
         1TyCLfiA12RA+CJ0oPINqsuhCGfgGbM0H+zvFosIKx8tdrj/6sXQtJ0Gub3qzLM+a79+
         KjEPd2eoWDSWm6d5e4wkeu52+OFEe4205TI6DrFJDf1DkQJ27Otx2MBU4EOpwCLHO5fq
         QvgxRUGUCCOFLduI5Q6XWwY8Ta9YmLpiRNUarP++hfgcI4A0APA8XyardNchJGNVpDq0
         Ox3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502837; x=1738107637;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8qKaMvklOxumXZ+sYzwJZ7YTcDoTElXytH3htbQ1GE=;
        b=ij8KJzbA+Q0XClADkHvriAw4jsya57AehUMRn75rbHjhFYhubFcHUvWC/+xmayJTCz
         VOcQFTb2p/ejVsWcTTC5BeROm6SPXR4lAI/xBJQZCRffL+Q6leMHyHTbQufOfThRAK4H
         pj7TL1jiufMJQIZyOnW/XbK9MZm8OfAJcsosyo4DBOCGTMb452Y1N03RtymdtH7mkRrg
         5Q4InkwUAuQvD8l6GNWMo6tBYVnZ2SPMj/7v9oJizsDV3kq7b77Y8rZ84d8fvhWpe2ll
         XbqCcRTw6B01juLZT22qNgE4QZe1CsZBqqch8kNwpEKRoQjktFHSSkKrh9psc9cQrjcO
         jazg==
X-Gm-Message-State: AOJu0Yztps7/pEHNM9jdkqPRVFR36wtoY6P063qCjN8XqUXb/XBBmXIH
	cwDvanxQNxLUZ1a6BdsEdGuqGHpN/GIHgyXhnSo5aHPf+vDpf1e+8MlU8UPAuw==
X-Gm-Gg: ASbGnctp9u89korfDVwW1Ti6noAoAHrhsRp6H6phJzaBP/kFz1nj4F7kM7MBgmsAl4n
	epCs0roQr4s2W9O/TAGTxEQgLKJGPpNp4zhtClCAPbTI758cQtG8YbgFl5nAnkhOc0NJ0C64Y54
	E/hFRKSmLjdtTtPYQfOXjp/eI7NTSweeCPX8kXcPNJfHDwnBjky8YSM0cZLU50frclFabDu/VgV
	Ns9dJ10/PepazNErLjh0HptgkywJIpHDNNwKI+4vBhYIOE5oZYGR752Xof645pI
X-Google-Smtp-Source: AGHT+IElyqT0VyDSDvKk3/iFTl2iC0ybUUWmIuvgsxZwCT+yLarh4F3Ssw5d/7a4bb6YxK+yiM5BmA==
X-Received: by 2002:ac8:7dd0:0:b0:467:4f0a:1b5d with SMTP id d75a77b69052e-46e12b6db1cmr246433301cf.42.1737502837597;
        Tue, 21 Jan 2025 15:40:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e102ec47fsm58106001cf.14.2025.01.21.15.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 15:40:37 -0800 (PST)
Date: Tue, 21 Jan 2025 18:40:36 -0500
Message-ID: <dabb743aa8b30916ef82bf8295573da8@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250121
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A single audit patch for the v6.14 merge window that fixes a problem
when collecting pathnames for audit PATH records that was caused by
some faulty pathname matching logic.

Paul

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250121

for you to fetch changes up to e92eebb0d6116f942ab25dfb1a41905aa59472a8:

  audit: fix suffixed '/' filename matching (2024-12-05 19:22:38 -0500)

----------------------------------------------------------------
audit/stable-6.14 PR 20250121
----------------------------------------------------------------

Ricardo Robaina (1):
      audit: fix suffixed '/' filename matching

 kernel/auditfilter.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--
paul-moore.com
