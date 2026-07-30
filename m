Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED063CBE91
	for <audit@vger.kernel.org>; Thu, 30 Jul 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446411; cv=none; b=S0zD3tkR2Zz8u1MjiEB32msXAZKRBiQOTe9L6TpznChMb3X25iRRI/jd7g2zdml28Ah/RdRpB7AD7mvfrPpEeq0zP526JtSQsyxl9V7XpO11zzujXMFE/Vi36mGIFEri2OP5mDDpYlO3pBAoCu8fqgB/Jl2qBadTanNfpS+y9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446411; c=relaxed/simple;
	bh=TJZQmzpvOPYMB8oMev3jnarl4RWN4g3L4KRSNvd1Ch4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=PXAzFt4X5/VBDSm6H6pV04N1uuEAKONfV9bwEUpoLkTV0EuryiIy7CumwGo1kSz2iwGJL5kHjTFhrIRV8kIp2vxrgIPm8g9FllfxJlgEXuH3/545GCvgURQeLkLL5RoSUh7cpxcQwRnUk8hxWQP3MDq1K31vaKytgztVfda8jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gq831MUN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gq831MUN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5c92c389so16927485a.3
        for <audit@vger.kernel.org>; Thu, 30 Jul 2026 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785446409; x=1786051209; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5A7AP1svwbEhmCOURMuvWPCYr+ofpR+/WH0AipsaUY4=;
        b=Gq831MUNhFTseLIpbHmavA1m3A7StaPmIP8rwlGfvnT3Zy5FBlgc+9IAQXK38Gp0V4
         ENF0AWOg78p2bEqUodGv8xdtyAsy24rftVfEKTCYRQi6NdmTuE3KEB/tzYwd7azWLQ6r
         phyh2p74u7Zxt6JBrTivKL5RB93ZVf9ibtDv4qbEa5EiEEFLACXX092ptIuLJ+xn+91F
         n6m7B6hg+khQ+AEaTx5HMaEaa9/VGhULvDNebXIDsgmQnBCEJMnM1XIkxgmhJLYhHl9R
         j6y6/ou0kimtJtk0RHFcDbQheFp8RpajnQ0td2eW0y0fmNzpU0mqgZijOwvd8UIVOQWI
         QRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446409; x=1786051209;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5A7AP1svwbEhmCOURMuvWPCYr+ofpR+/WH0AipsaUY4=;
        b=EGlDMtTyQgnPBMGtg/AiI9HMuTbmRUuVo6zIEoLozPWALXzTVLcodUOzFu10resOrC
         X6nLIfdK4LNEswUyAChBuBUaW7wXu7oASQK6XyDroB0JO3DltjgddFOfzq0F27pSiTUO
         nzgbeysJFb1Iam2oQWlS5kLPm5gkpwFN8KXjeQ/EEicNaESQDb3wJuqopnaBhRHjpvkI
         xLJw1CVlHvzkF7AB/xF3pn8knbcmei2maaOrWtaSSN6sEy/c8f2hoDLUc+znwlLjAPF/
         yTKfP3O7l6sweCtxsbPH0cZR1ZJO51J7fVuqz5Ajbc4fsk/GfNPDvwXMajR3WDd+hPfj
         6KwQ==
X-Gm-Message-State: AOJu0Yz6JnUV67jTnGaDwki3KYolXQ4gRVuUdF4l4YX6eZSrf3UDeKxT
	sL/rvUoreHjys96qC5wXl7uqwpSMCG81Y6xxnTMcsqdgO3dv6Xl+tDVPE7CJQlns5A==
X-Gm-Gg: AR+sD11vmdPuGq8jSjacoQAq3UOQXO1vVan/O42sDE+bMWGRZz+hHRyOsaY6EYszOCr
	sJShEgiWLrA/xeaiq0vdfgCt3BRzuUKW9UlbCBzKYzAV5XVAYJ7SI2mBilxF9C12x//fMvotOk2
	2dwlgp4MhZInKt8HeQZ96kdXiFZUx4gt1ErKx2I8Bz+f3DlySoRI5JQKyvYJTsgBsaHVCSOkhUu
	sCs2WBRF69136Z+O64jvJOnm/hlc1PgV7ec3GOoKpcuYkM+bYHJEFDU/yTpiHfkncVOEAklwM/3
	44jmUvJhYxOZOoDHVfJvR9utJdV6b7vEZhT4Zd9zRFpEzLQ74YtilDsz0oY2ZlX82DnnbM+NHvU
	i4E6CP1SKxeiAp9hUcHIucWCe6xCWXFKWKwFwnNKWhe/1Uq5WRKu/wXPEKYYHpmZRylDPLBMvQn
	jvvI1rmMeoFphLm1+tQ2klG/8TnXX6KgT8ziPFUBXS8LxF7fxmmisxUB+62t3YkwUwkG2S0l8r4
	AjucBk+fKkvWaZDSKB/XAaJb4hZCkldEm4=
X-Received: by 2002:a05:620a:a40b:10b0:92e:c117:5ecb with SMTP id af79cd13be357-93486f07fc8mr362158585a.75.1785446408733;
        Thu, 30 Jul 2026 14:20:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d325f441sm503493785a.15.2026.07.30.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:20:08 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:20:07 -0400
Message-ID: <c551862a4b55c930fd56840d2b30d495@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260730
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Two audit fixes for the next Linux v7.2-rc release:

- Fix potential integer overflows in audit_log_n_string()

  Similar to the earlier fix to audit_log_n_hex() that you merged earlier
  in July.  Expect a cleaner, and generally better fix for these
  functions in an upcoming merge window, but this addresses the problem
  in a small patch that should be easy for people to backport.

- Fix potential use-after-free in audit_del_rule()

Paul

--
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260730

for you to fetch changes up to 246df90b5f1a8a6e6abbd2f058b029558720adec:

  audit: fix potential use-after-free in audit_del_rule()
    (2026-07-29 16:19:06 -0400)

----------------------------------------------------------------
audit/stable-7.2 PR 20260730
----------------------------------------------------------------

Luxiao Xu (1):
      audit: fix potential use-after-free in audit_del_rule()

Zhan Xusheng (1):
      audit: fix potential integer overflow in audit_log_n_string()

 kernel/audit.c       |   11 +++++++++--
 kernel/auditfilter.c |    6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

--
paul-moore.com
