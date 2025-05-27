Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429F219302
	for <audit@vger.kernel.org>; Tue, 27 May 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386668; cv=none; b=j/c4xflNrouoZBm0Nlf29sa5/1XQSzAHvQxZQsLyK9cxFl1/Gub3q+Dwn95KNmhMVcMC9+Evimke/hj+hpHenpZ8hV3Qr7Caue1NBTO6VEj5WLzZZwRNDd1CI/dw3ac/temOfPyFpuj42YDDSWSq78RXKlwZK+kerw54xu05l8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386668; c=relaxed/simple;
	bh=j3QNcdS4V59Xqq4eU4UD9az3wgeOL2zUuq5vazjY6dE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=fh/UIrxutdkoQlH2MC3/6i/7LDo8wYFyNrU/+6k4ApYKvq5MHyMdhyMHmAyCBOacF9vh4cuB1gTBuGt7dvvkR9ujOejS3xKiM5kaXztGGHPhG7OjUq4OGOj+uIaF1N+uXkfp2/lDc7fu+0nlb+R/rX5z2eHl9Kpcy5AKVKSgsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F2vMqcfe; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F2vMqcfe"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b04a6169so41264086d6.1
        for <audit@vger.kernel.org>; Tue, 27 May 2025 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748386666; x=1748991466; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPNmNPNc+pY81cghuXZlK0sCX3b691BE7Vpx2A+nLfw=;
        b=F2vMqcfep13hyWWCXutleqh8Lrjb40B5vSMIxrA09HPkeTYJzsOfrm9RtU5M6i+ed+
         kFgjpHqBsnZv7JyEf+hRZZNzASDVrAV/86A8FnefDUJbpF/qvIPiwza+ucSUUhrdgIk1
         m69qWYn7K6ReBbTz3ZO3isiougj+IBW44yhb/QCheqafQtJ6KD2kfkqtRHhhvxqj6z+s
         TgfmllRtR0Nbu02O0Djh0ARbgo8YSXsGXuBV4m5sEcRqeYJwZvW6A5t493dVOOYSCSpT
         E1vfQIb+B6+IqrhQwE8IGPjwxX80cV43zIw2fK23/T7YRtfb4O4xOvM99RvbAcDAEYFf
         Zf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386666; x=1748991466;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPNmNPNc+pY81cghuXZlK0sCX3b691BE7Vpx2A+nLfw=;
        b=H8weZvx6gMypn3E3GGP+DKtSauV03QYfXqvPYKdH+jFTVeHkgh3/T1DhyZVepAaoaP
         N49dFEqbopuSD6nQSrwpjiTBwL+Tz/Rkk2YcoJGEZDlceRmIm5C8c8x+WApk7mR1fe2R
         Dbc3/na4HNH2r8maznOPWOTzzYSbKkUJZXPGcEZLnNXs510ZHxok6jzbyOX+EPxAR4wi
         aWHiouUA7kmCI8aSoVDD5LGt+iKAFP7P0yw8RW6ykEldvuw4JIbaREdPP4BrcPmidXed
         yhih1Cvq8PPp2jwof+E9jlaORWNm5YRb2pvceqFghzqHDuB4aCiF1sJ2+L6+BODyEKiy
         lBXQ==
X-Gm-Message-State: AOJu0YxSH9U93Wuz69Dw9nIz2g60d0BGNkNwGHWUk9i/PspGdAoElmFI
	hYrKq0EMRgeZukj3ltNCiUhKPjTCfSBW0bCReP7wUeE7KWnmtkW/TFDuQkzyEo/wHQ==
X-Gm-Gg: ASbGnctghzT6enYbXV4FcKyPxCnSnmMN46JQjQ/XJAHmH9mh1tFQrwrD1NRh7CKtPX2
	hZ5ugXrhI8SVDDBjmJXBha7sb3lIdKW3C5mWHt34i/+g2eqRhur97XgSYb51TZTN4p4AxQ2Q2+D
	jM3KOemw199jwj+qENVrkPJ3jv8wQ8TjiFMq8S8E6Jcxy8GcG7q5cC6hDhwzsJfNkq3IY7YA696
	VEa/wzgTqNeXfB9zv6z/+WmDdyDpiVzh3Yc9Tk6wBeGoyNq90u3tPGiqfof87w2Td+8BQHK3DM6
	OY5Qh76QJ9EciV41HDTjnjB4b0fWxN91nu25vqi1eYf5SkRWvqhOekF4E712uFirwugvVee0BN3
	I6Y9QtIbKJjNWr+hDqQN+
X-Google-Smtp-Source: AGHT+IFT4FIOfgMllv4Iuu5x2xg+Iwc8jNfLVPxqVaQrznP+8UGTjMEdIvaFifL73PGGja+zWBJ1IQ==
X-Received: by 2002:ad4:5bad:0:b0:6f2:c88a:50c5 with SMTP id 6a1803df08f44-6fa9d28772fmr254815266d6.32.1748386666020;
        Tue, 27 May 2025 15:57:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fabe4f5b6csm1316066d6.63.2025.05.27.15.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:57:45 -0700 (PDT)
Date: Tue, 27 May 2025 18:57:45 -0400
Message-ID: <2d7b064b34bcff7a6a8926cc29cae659@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250527
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Two audit patches for the Linux v6.16 merge window:

- Always record AUDIT_ANOM events when auditing is enabled.

  Prior to this patch we only recorded AUDIT_ANOM events if auditing was
  enabled and the admin/distro had explicitly configured audit beyond the
  defaults.  Considering that AUDIT_ANOM events are anomolous events
  considered to be "security relevant", it seems wise to record these
  events as long as auditing is enabled, even if the system is running
  with a default audit configuration.

- Mark the audit_log_vformat() function with the __printf() attribute
  to quiet GCC.

Paul

--
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250527

for you to fetch changes up to 654d61b8e0e2f8b9bdea28a9a51279ecdacafe3c:

  audit: record AUDIT_ANOM_* events regardless of presence of rules
    (2025-04-11 14:14:41 -0400)

----------------------------------------------------------------
audit-pr-20250527
----------------------------------------------------------------

Andy Shevchenko (1):
      audit: mark audit_log_vformat() with __printf() attribute

Richard Guy Briggs (1):
      audit: record AUDIT_ANOM_* events regardless of presence of rules

 kernel/audit.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
paul-moore.com
