Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EE1B6CE9
	for <audit@vger.kernel.org>; Fri,  5 Sep 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086628; cv=none; b=DnqnTQGGWZpv3FnGPrh9XrQefqsIhenEki6BWq4uMoasGTGLPwOn+gn6DcpMHeSPXeiiGTVEQOnv802hVTsTFPld1NWkmW1Y9QhMQ34Qd9n7ewNnWPvgPqoi1EHEkmoKaojVTH0TVG8LNUzcEya1eSfDUIvvjCojzyYR/aziYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086628; c=relaxed/simple;
	bh=Kg1vnljwk728S3xcpj5uPtZq0cPx87y/XAxf6Mbkg0w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ESXYqlFqVy97zjo9AMMmN4+S21NBgrpPVmEPijHiLnGM4WICHTf/Tc1TbCJGM7eNsq7B9Xt+96lNGpmoEJTV/jkQyhA3R+FTt7+5dltsppRQzCT2mULF1yeNifKGe2kfDKD15/p2cgyp+eKBbUvfDwbIapYC9xle3ntJj1ycFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Adxer/jb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Adxer/jb"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b33945989bso40313181cf.2
        for <audit@vger.kernel.org>; Fri, 05 Sep 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757086626; x=1757691426; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8H2BgOZaIRqj4/CcuEuveM9YTYIhVsemNvoFOFsf3o=;
        b=Adxer/jbSeczynoeFKEXClu7cZMZCpAF3YLWX+s0HTBWs6TBpLyV2vLRrfiKsaIL+D
         ZhqpWBTavn9Db2BIGlnBvqmcOzF+JUsAekaEgCeJUNaUOhJSFPDZvzVMOHvs1SgKpkc+
         AqHd2pYm09ShlOUEubo9sDUSMc4cOwing3C7JUwsdbz9IWkiKFgSsczRcOMLXwytPuxi
         KuenPdohzMQWfiTAL9YTg/4MvUnlnFc0fLVwKC4ejK9wCe8q+XtUUpJyJojGjuaO+QO/
         807AVC+9b2a8UsjoH8Ki4j2CCxzj1IJMBp5zP1w9YFfVis/G07DkxoN6TNdR/fngx0cu
         tqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086626; x=1757691426;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8H2BgOZaIRqj4/CcuEuveM9YTYIhVsemNvoFOFsf3o=;
        b=ppN9i/8zHGLI8NURaIied2RGbTz9hkfJ7eZ6FW4wv6zh8/mrFwUUccNoTZ+vuFZfOF
         ZoWlYomfJwuYC8itAo21R/cpaImmhINizrG/2TGsO19XhCGsq9W2W3Xg+fyG+KRSmel6
         00iyt2nqtkeefRArTRQdXN2z9pPGDLk/lQGZpjaNEkiHRoeuJVsdaVieyXKcj5QHBWK5
         7RSVYAd2J7nSkZgslApaxeo0DJFTl8QCosqS2LNLB8Hwn7BQZ+nxBlVzs4En1scbDbZT
         KFc3oYjsRj3G0HQ3WjFxY3B5B3HYcmR2txvoWdIUsArW44ymKnk3eyajyYtihsYPoVbK
         aFSg==
X-Gm-Message-State: AOJu0YxeN6XNlZZfe+pqqhS1QXkU7Frf04h2hCle1/b6KPe+tF++DTyK
	vBgx2qVsd2BsQwGuRnZtt4LCJmfPMuIZhobOSUqAIsHYyY+j50Cs3X/7ix0c0Lf27lGpOJfC9PT
	F3og=
X-Gm-Gg: ASbGncuFE9FTCyXgO/nb858e0cpN8A8QqIzUzFpo4SgOsehVG1b4q8g3iuB13++llO5
	uGejBUbdNoa06bQqzGwRHqK+T1GR1Nv/yLPQKNPHy8KytoA02Za3qVQXVvTHQiYTbeYibKEpcE8
	cnwPF2T8tNgOT5+CzdRL2qi8iZaNn710NEGlBi1FlrUfOD6xvJXvVvz6W7DH8AR363SC1+i9NFx
	l3MKWsGb0ROGD5AcZJ3XAcdexgsWhV0uOy0wTxVoKewKQHDqkIWT1bd0uEtBizuiJ6SIpDh77NV
	ZozZ3UtbyN7If+TptywuzQvyIn7y5NC3zyfwrUjTJ5vW10l2ee0Af5nWUR+jEg/vfwtY3rXtdLg
	DYc+lz/c5ttuFp4qDViFckEmWnWV2DLAEhF02n7ChnJdPV++Nu0Szx/5Ds6Mf9bweUcd+TT1X/d
	JYdQo=
X-Google-Smtp-Source: AGHT+IHso3j+0e//Z9vqXwH7srvuoY144d5Q5A5/ORbPudxl8GItsfJbG1VzD6dz0JwkeY/cN1Uv6A==
X-Received: by 2002:a05:622a:5e1b:b0:4b4:56a6:42b1 with SMTP id d75a77b69052e-4b456a6498cmr110458451cf.47.1757086625566;
        Fri, 05 Sep 2025 08:37:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b5d57c6e0asm33881781cf.51.2025.09.05.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:37:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 11:37:03 -0400
Message-ID: <6af833b45f68db4612ca52dd839d5662@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250905
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A single small audit patch to fix a potential out-of-bounds read caused
by a negative array index when comparing paths.  Please merge for v6.17.

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250905

for you to fetch changes up to 4540f1d23e7f387880ce46d11b5cd3f27248bf8d:

  audit: fix out-of-bounds read in audit_compare_dname_path()
    (2025-09-03 16:46:23 -0400)

----------------------------------------------------------------
audit/stable-6.17 PR 20250905
----------------------------------------------------------------

Stanislav Fort (1):
      audit: fix out-of-bounds read in audit_compare_dname_path()

 kernel/auditfilter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
