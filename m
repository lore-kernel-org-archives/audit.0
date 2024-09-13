Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86222646
	for <audit@vger.kernel.org>; Fri, 13 Sep 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190150; cv=none; b=c975fzBm1dGoKezWHn7kbiLDts4rfrE2tquHTcspiNihNKTXN30X0VFvjtL9EsUInRxMFjdtL43a5NS2a5+ZOR8qEbk69bPowyGhXq/GZtm+fdsYbDpszZa0ItHRkAYdzQdmYpGBlQMmKJtSB4tt9ypPRfg3WjaZp8CJhXrvpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190150; c=relaxed/simple;
	bh=rlzkBySVRuwmCtSDu/RMw8JwLzemasjwgXGF+1VZFVs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Hi7a7yOniZjcEXlH6MFeLFerJvSXvqO+wdtS5CBfZjIyjFG7GKXyTExyBhk2M6rtVG18oPLe0cl7UKNN7Rg3M/FUxGQsmoJ3PBcFoNZCDsAiFJ9s0Nnc97Ub3CrX1eqNpWGIp4M43br8hrV5WwFepJgHMpPZmBKDw/MuT52md20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Atcc0l6v; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Atcc0l6v"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso9665486d6.2
        for <audit@vger.kernel.org>; Thu, 12 Sep 2024 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726190147; x=1726794947; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQTH8yuvjn5x+BE563sk/xQZpgNg0CR2xe6GnbO5beQ=;
        b=Atcc0l6vDWRCuU93irXYCDD+xE42heUVBXaMyeMg1PtZuc0Q1ZciADrj7tggVuBwRB
         MRdopWp2fcdktSZ7oHuWsjqcC642Jrg8UBWLvJ6L4yf2nw+DpkvsPWbox/Z7Zk4UNXPJ
         Ic3a3W9yJTwbPdp18S+j6JjS3zQ83gc75QgKbEmllwKqaYenOgOaRTblUvihslq66ugj
         B1+AAjt3Pc9bQr1jsAkgKVp5fsVehTYrZeA9+YukmqTVV4SL0MpuQLcZMsjPO7cpsbQW
         b1s7cKoa136qBeztBO4HNqNzlT5d1Xep5kciudJ25RIth1k73JoE2fc4Z9KVkeIqWWsL
         +4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190147; x=1726794947;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQTH8yuvjn5x+BE563sk/xQZpgNg0CR2xe6GnbO5beQ=;
        b=PxGY0y1Po8bye0/p9cFvkwpdpCxDkbQq+OeltaCnjaxD1QXxlGphA3peOjvsAatL5N
         d+TbesAC1F8xUXRIkVMuXX1r3e+wa1AthOnjRBFtrTb1Fc8VTl3dc/htifNTRvSsu70M
         BjkBPdmR/Z0ltazWBr10RwsdAsL66IkroUFG7bsV71CmjCRHWpMWWF83mS09oz9oAZBC
         PGvadyQl8/PyU5s06Fhdyoz24pbYgkOtM7yWe+/e7+dsyeMpL/oqabXOboOuLrkGoMCe
         YAe6prDjU9OM9IOa5kn+lHPRFqzzUFWKHFGaZFntq3xASzcSKREyZq7+7I87yWXlwh08
         2lWQ==
X-Gm-Message-State: AOJu0YzYxjDI1cktgTvVl/bZTw5Df36C9pPmsmziK3SFJ67A4PiiXf98
	C6zOqnds0OmiGskRHU9MxHThX8bkM8euAHJugsfKSZ1W5tsluzP9HXwBCxU5PA==
X-Google-Smtp-Source: AGHT+IG58brN7hCe2TUxpiygIKcM0OSPhX0L+96LR9UDHec38zsCfwW21rqasL+X3Vh2daQ8D0ul8A==
X-Received: by 2002:a05:6214:1911:b0:6c5:7c2f:7376 with SMTP id 6a1803df08f44-6c57c2f75e5mr19748736d6.23.1726190147145;
        Thu, 12 Sep 2024 18:15:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d632sm60074496d6.89.2024.09.12.18.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:15:46 -0700 (PDT)
Date: Thu, 12 Sep 2024 21:15:46 -0400
Message-ID: <5b03d15a5ff1840820e59d41ba1fc9c1@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20240911
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Two audit patches for the v6.12 merge window:

* Fix some remaining problems with PID/TGID reporting

When most users think about PIDs, what they are really thinking about is
the TGID.  This commit shifts the audit PID logging and filtering to use
the TGID value which should provide a more meaningful audit stream and
filtering experience for users.

* Migrate to the str_enabled_disabled() helper

Evidently we have helper functions that help ensure if we mistype
"enabled" or "disabled" it is now caught at compile time.  I guess we're
fancy now.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20240911

for you to fetch changes up to 8c1867a2f0fd4235b84da6b204519e830b551988:

  audit: Make use of str_enabled_disabled() helper
    (2024-09-03 16:35:16 -0400)

----------------------------------------------------------------
audit/stable-6.12 PR 20240911
----------------------------------------------------------------

Hongbo Li (1):
      audit: Make use of str_enabled_disabled() helper

Ricardo Robaina (1):
      audit: use task_tgid_nr() instead of task_pid_nr()

 kernel/audit.c       |    4 ++--
 kernel/auditfilter.c |    2 +-
 kernel/auditsc.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com
