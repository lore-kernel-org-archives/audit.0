Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864D136351
	for <audit@vger.kernel.org>; Tue,  2 Dec 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641328; cv=none; b=o1Ni3Auz0Q4vAyPPJ73e2WXeVW2SC4ZfJXJfL3uL46sq+Ha07EShsGMJ72Dxzmk9VsdfZQD963Hc0Ak+nCTTTSKfvMgWnbICCB4R6vzOwTv2ob0xVBv3gGUJ67QpV9dCF03ADCxLlj7zo9ciXb3sRZi+WqXBqnvu66WE30mIds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641328; c=relaxed/simple;
	bh=oyKHKV1JSu02gylS/hnCLKp920M6hdu0MI+8K1bFm58=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Brj8rAlGgHHQ0T/ddsYscKHzh0icxiNClQZ6+wZuxDZbHcfgeuM7aKHn8wqT8zRAOju5A9Wz7tSEBO+WYuZktKm5oODMsExdpHBLijs8Ut2BvmTPhAAr3sMAB/cHTEubJZYEDm1nrhrvzY0+vqrZ0wPUJ60C49SHBK/SczaNiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7owu9NE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7owu9NE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so6048054b3a.2
        for <audit@vger.kernel.org>; Mon, 01 Dec 2025 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764641326; x=1765246126; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYwisWEMSD4f913sGd8iaoZcUQngeIHuH5eWFrEyKMY=;
        b=E7owu9NE1doYWc4O6U4acBNgTACfI/ErVr2TSqRXtUhhMv+ym4WswhZmW9KMTqa5BG
         bajKSQSRiNVlSXWO4X76fPHc0KiA0gE4vQSfJYIbl1MMmFRLFEV+8fSdNrjK1yczmfi/
         2lmCd6PaZBMupEFjrK84e9GXdJWAcWzb2yx2F2mRg4cjHjj2Fdh0cbDcy54xPm9JITi5
         aHa9adenHbQAo3Wqt7DblkNl3Dk21TYn4Y47BoVAafqWeNgwVNVPNdw8czZsfBJgnr1b
         q9jmYvRnN8rlBV2s7ZU1TsZTCo5lpfcPLtFm04vi5+hi4mpJFiIxqA57XKsL5fTHCqeg
         dzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764641326; x=1765246126;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYwisWEMSD4f913sGd8iaoZcUQngeIHuH5eWFrEyKMY=;
        b=VCuMF+n1WXWv2bKQOU/GONOHlLkWCip3sAj7wIjPCHA3ecm0PGJ1hOY7zEiGJtkuyA
         5fO+w5hvy46M4+poJ/8Bv5TJS5xuiSODXl+uQs8ujOsDmVPdEOgOa8GhhXC6r59qI/SV
         y0n9BXD4tsaxim5uPBjASJ7OCZlk8OwUxyWaH8eCnaYOKy2cU7ys/mCzzSqKVuDqWO4r
         40vxo55L5fc4gA4MYRvvchQ4WUQc8F08aK3zuZc9t9sbSLnU3kVAlJtV4x85RpAnEBwe
         7qAY3Ml2gj6gicSg8dpoMRz9HB14t3FDaPeJQYL+wNY1FvaQogGhinvr+rCedrViBC3f
         RFbA==
X-Gm-Message-State: AOJu0YwOkpOOYtlbRWVcKX/6pAIk8phGD4TyE/WWeT9hUGuhTnmjyDfE
	IiGl31ZdNH/hMuawBxOAP/MK6CJ3m1c16n7fqqVwXLIaH7gc8Uo8MJPZ00ZC4ddVwGNwhVNSsnA
	9Z9o=
X-Gm-Gg: ASbGnct4zNd8tQ039o5TPWEjmELw9tCikJQ2lYebROFgpw/yYr7Xt/twEW5d5Fqw8LQ
	HUJgBrwnl1fR6JmGfzYMGXGA6Og8xTC4C5jq6YZP/j8HP09RNufpfhuYq2ol939sSCjpQAJAcoT
	d/mfVWpQOJdKzaVX0tdMgkmA/peci20X4J1RqugA6opz8s03s7hLTpiWwNwiiTRMfG9hjVqD1u4
	+GcpsnWh+gSpYqENymDHnjyMbnnJCiBAB2GnLdTw20/EJpfQ6Ec/frEXSn8hJ6eK0fgf0+SiNZN
	T6eBN+1SU87fCmPCQjLJ+GwIoGTr6yngQrR4dOv97grIRdNmwxWQnChS216x30X8JEnMSf4GB4o
	mq3l7QF6mS0Dhs0gHP5H2C+3tXvfCeOPwpXv2RjSOJTsC3WGkriHpG8U3AnWeKhSL/z/nxtv6S0
	4XpqvKwyL3cvIRHLGj/s1geGu8A5CWQ0OCI/iOFuROLw+q6k8/0up0VlFA
X-Google-Smtp-Source: AGHT+IFhXXdbEkmVv+SYDVFPV6qFkoTdqhUA1a+wW+gyi5dmXGHdmH1I0eLpu836/U0vJ2zsR4mr+A==
X-Received: by 2002:a05:620a:1910:b0:8b2:ed4f:5c38 with SMTP id af79cd13be357-8b33d1efb9emr5300885785a.37.1764640851012;
        Mon, 01 Dec 2025 18:00:51 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299938b5sm988752485a.4.2025.12.01.18.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:00:49 -0800 (PST)
Date: Mon, 01 Dec 2025 21:00:48 -0500
Message-ID: <4dec81096fb34aae6b383a151dba1ce7@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20251201
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A small set of audit changes for v6.19, the summary is below:

- Consolidate the loops in __audit_inode_child() to improve performance

  When logging a child inode in __audit_inode_child(), we first run
  through the list of recorded inodes looking for the parent and then
  we repeat the search looking for a matching child entry.  This pull
  request consolidates both searches into one pass through the recorded
  inodes, resuling in approximately a 50% reduction in audit overhead.
  
  See the commit description for the testing details.

- Combine kmalloc()/memset() into kzalloc() in audit_krule_to_data()

- Comment fixes

Paul

--
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20251201

for you to fetch changes up to c8a3dfe7315945ebcc80ed5be8267920b609649a:

  audit: merge loops in __audit_inode_child() (2025-11-07 16:50:42 -0500)

----------------------------------------------------------------
audit/stable-6.19 PR 20251201
----------------------------------------------------------------

Gongwei Li (1):
      audit: Use kzalloc() instead of kmalloc()/memset() in
         audit_krule_to_data()

Ricardo Robaina (2):
      audit: fix comment misindentation in audit.h
      audit: merge loops in __audit_inode_child()

 kernel/audit.h       |    2 -
 kernel/auditfilter.c |    3 --
 kernel/auditsc.c     |   47 +++++++++++++++++++------------------------
 3 files changed, 23 insertions(+), 29 deletions(-)

--
paul-moore.com
