Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273144483A2
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923018; cv=none; b=Vd9eOLJfvSgSOYNQTLb2ZlLdWiO0HES2vtPwDEF2wQw+TIniwoCXabMtktqE7ltt0GzV4gacOGm+lkXtY8vvQCPs25BW1tR/rYphZqAXPhzuroFr+/NofG/eHkqFhZ8mHuQdWiPZg5qOUe1Nrsf1oEL7Qo857y/OVAY8togGuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923018; c=relaxed/simple;
	bh=mjSH/K+hTsYO95TjfehGOS1qN3CAVCc+EyUGJf3Xxsg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tAzydEO0Rw5fn2a32reiqp8LMst/lLrbuZSL3cFQkrysjBMCX+Hmm6YuY03DEl1N9cgw3ddhEuy6IBY9xpC1gZGlT/dHcEevNdACcLkviw2tVEy4bZBxHvCqacdvag75JB4XvcYqRaevr4NA8goaVpa4cYOsfH7ll9O4uC6vVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gFstSk5w; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gFstSk5w"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0d6853360so8316246d6.0
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923016; x=1785527816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqcLPegislg7DeQ4y52im/u1rvBxCERW92Zqq3OXeLw=;
        b=gFstSk5wVzFDs8FBJz2+cBJs1LAr+Mi2gn0gxuFslUP9QNIdSKk1tsTVAQPy1VPXq1
         LM5zvJfGxuLB53BPvXTHKelTHyd0YshP+dJNT/xAVJpmDBqerIZeal9a4flwNbFb4vca
         n/p/X12/UL3IrCzkWMLoV3KGrUJMD7pkPWxecNZJZRCstmuI4GZZm/WOPcLggJa/TQRY
         kr3eRMnlO0UbWUMXEf6WVOke7ySBakQA8pOzLQrBg1XhrrJPIkvFiZeokPEnQeNX26Qh
         t8mh82WXrhJlQUeJJzo1haPuDzPw0ITTtNdZKeskpVdKKicYlZZ5MUtxzS5q1/VpLxid
         hbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923016; x=1785527816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RqcLPegislg7DeQ4y52im/u1rvBxCERW92Zqq3OXeLw=;
        b=hvzJnPTS4kryJNZG5aF9DtRjhjfDFM14diozKTBSLGvSV1byN7kN59zsGfqn9Ge4R/
         0GdRbx8fqmp3uuDeBZ3QoUTdD1uGJauoiyIz+4l/1SiiWKm12a5ew3V4y/+xdMf8roLT
         YTcOK0p2RXtDweK2lejc0IyVZq5fqSSMP0P/lvJRilg6To1/oVJAXI+JAqmwfU9mlSCU
         cf3/00tzGFBCBopT2Mhh9ymAKytjNBKDkRW+0OJfRSFjdQoBtHW6IxD0tMlfK4xjiC70
         rui4KC4e2eKY02ugien+XthN7yt99Bhg2dtGsF5qE0Sx4PKhmIA/2LgDcF3irxVK9KmI
         aHpg==
X-Gm-Message-State: AOJu0YxS9T4PiJOvgxxU9ADd+K55zsccXRmYxrVbZrdR78SqdurYUjs8
	oWh3ZxZEXfRnmOUy0Ql3Irdy3frFQmMwi8Z1cpaxaCCVh+AGbZ49SGjrq1wOtClX1QtEFprzgFR
	hpb0bNA==
X-Gm-Gg: AR+sD12RMmh7Bv8IcR1+TYtfetA2ypmkb/PfP825OlKSR025adjNgm0Gc039ww8+B7o
	iLWvNuC2q4dBjYD9RLeYMnAQ2cqGBMmTplC46SSktHsbUiKYNgXPLyZZHMItHAKDN8oy+Xun7lF
	OEJzk8E1a/9lDRnlZiZacPgFUqGyI6EbJhv77dKW6cY3Fehv6e3a+MnuR+RS8GHmkhBR0iQLEu7
	CDSRaTzFgDKbsG5p4sYWochC2hrkXx5av72ZgbltDOZlf0nGNAH01oaih/VTdelUdDB5HHznVhc
	nMwVu1zfkoh6ja0xOw+aLHCw125hpTaFdTbDsDsQebHKvvZkWxkkXDHd9aI18AuiqPBDy6OCr3t
	cFwZYUs6B8WOepz27JmGY4ri2Zo0/IAcvbotvJuATkG6Q7GBbUGRja079JXxIKsQcvFTM6dw4UY
	vlGbjXzICeMsEyzC8hgvDzn1aQtNGDJ6xxCnPlV0xAFSifTCk=
X-Received: by 2002:a05:6214:3a84:b0:8dc:ad48:70a7 with SMTP id 6a1803df08f44-907ca58fbb0mr100780346d6.26.1784923016013;
        Fri, 24 Jul 2026 12:56:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e854fe34sm5448656d6.14.2026.07.24.12.56.54
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:56:54 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 0/5] Cleanup code in and around audit_expand()
Date: Fri, 24 Jul 2026 15:56:18 -0400
Message-ID: <20260724195626.327253-7-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent audit match overflow patches caused me to take a closer look
at audit_expand() and how it is used, which unsurprisingly revealed a
number of things that we could do a bit better.  This patchset is the
result of that and aims to cleanup some of the ugliness while also
making the code a bit more robust.

Currently a RFC pending some closer self-review, but the patchset
compiles, boots, and passes the audit-testsuite and selinux-testsuite
cleanly.

--
Paul Moore (5):
      audit: only call audit_expand() once in audit_log_vformat()
      audit: convert audit_expand() to operate in multiples of
         AUDIT_BUFSIZ
      audit: move from a size_t buffer length to an int buffer length
      audit: add a missing function definition when !CONFIG_AUDIT
      audit: drop BUG_ON() from audit_log_XXX()

 include/linux/audit.h |   22 +++++-----
 kernel/audit.c        |   89 +++++++++++++++++++++---------------------
 2 files changed, 57 insertions(+), 54 deletions(-)

