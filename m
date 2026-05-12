Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A750383986
	for <audit@vger.kernel.org>; Tue, 12 May 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592530; cv=none; b=VOoL78HlYbjNKgEIvmn0maMGcw7oxpVqzELVQ0N80Mr8pLUycnHSenU6+AcgZyNgAMJEq3oQwQG9A31+2eLZdIw9f5fgFwNRkT/qgknSOwDXxh9tLuqJuLhded3c8qkVFpx8q9/vp91S0CBdPrZaGJBYqzpW/ycZEChyQ2L8bjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592530; c=relaxed/simple;
	bh=wV05HjV39evQntHLn5vEg/D3uJKZymKcIup65dVA9Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=r+NrUTbSWVK0rBP5wunpIil1Yj3SiI99W+D78wnxYynHh2dHngA03z/B0diyUFVyakTQFyokB8VZOa5K4oVRMW0ADfY/GM5NkHzSA/8l/HZe3mbuPWdS3wtp8n4GG0sUH7np2qEE94N5TRgBdHyffvsKG5Z94GVVFsvI3Wbw4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcNyvYts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcNyvYts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778592528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G5qbU9ydLa2q0Fon5A8FvE5NNe2p30zXRxlDNHlo9Pc=;
	b=gcNyvYtsN6YhymMPFkjuxFYsZwgQLRfhEQklzERaawv+ABKKOcXRE7pbXYGbxKFc84WbUt
	hYeHDLe+ItHSYtEj9E5kkcj2rS7IEZrdYimdykSLxzqPOdMJtayLiJetI8Jhgxj5ObBk1/
	gToFsCoR5JMQlXfczm6muJXmLwTTM2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-kF_Pkk8dN-6qVNvz8FmZ9A-1; Tue, 12 May 2026 09:28:47 -0400
X-MC-Unique: kF_Pkk8dN-6qVNvz8FmZ9A-1
X-Mimecast-MFC-AGG-ID: kF_Pkk8dN-6qVNvz8FmZ9A_1778592526
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44696b11265so6336308f8f.0
        for <audit@vger.kernel.org>; Tue, 12 May 2026 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592526; x=1779197326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5qbU9ydLa2q0Fon5A8FvE5NNe2p30zXRxlDNHlo9Pc=;
        b=CkLuCzlDwM5yPLaMCscco/15uE7T9fCSgeL6I25TJ2IbpamDdP6DCdBuMneK3udPAD
         t77M45rmUA8+Lc/3VG8CmP0ERneJBc3rLBIrextHCJ/r/CGfaPdUHPCKq6oWRl0wh4yS
         Einc3pkxpHzr4pkkYQP9NLYc3IjE32hsd6mQjaQwmR2MfAt+4MpqkPBfReKGp2saXpKG
         dfLnJXST3RUxYqmrBPEK2dVjMzSqOnOxZGI0Wbini5tFC85NfzmfiWhMUEQ5hV3i3AI0
         4sTc7ZeV3WTK7FwkPEmhllXgwiW1AUYpZyfWGmmgJIsQmA7YzTHwu4CHL89/fUqfJM74
         PNzA==
X-Gm-Message-State: AOJu0Yzz2bYhxy5hx6Z1lIdHMjS9j5EwCeoUD/V6Xpoxio/MgRlR1nUg
	KfvRBZ0L9C05i6o/T7NiO7MEpu1E+iRwf2t0oPl3keCdzqO0mAXj9p05PW6BVPYjLJui1RaG0vQ
	NzRhA1pmUNyXy1T5/DUyXRPgyPgjYwZkcf2FzJcQwVIcheUGsDdqgypBk/6Z0DxcFMneNY+8erC
	Z5yEqsnVqNYlAocrvcDHDW3hl/10M8hxTgToNem6P1uxM=
X-Gm-Gg: Acq92OHcydI0d0VyNkIFXwpCrr0H2GfrtQWSEV9IyJdV8HCv0z55LZkJwNim+kYu3Ns
	kxj+tvXM2IX3zZ8LhroYZSMHcdFWFIMSg2mUY4ei/IcD02Sf4J1S19ZpFOiLzcy2VTavl6/wHOJ
	0IyHwOCrvfin3CbhUKl3JX5Bi4gAR6/9zchQi54GiMYCemUCbW0tBUZF8Y6tajvgqhboUCNomJZ
	ErIM5IpvGQ0RptcAcGmGQFfdxjENnv5im7K+el8QCkQUkvkANossfNUaeamb7yNA9IYgXAyQafM
	eaBpE5M0Bxy4LkmjWoY+RXYmz/mEYYUXGVXWFNnuA0p2JrAEZzrguubKyY9/MVF3/AHkTohMH2c
	DgMr7pjjP24hQEr3TBDGw6GQjpmNaiS9lR9gHC5X3UCQj0s5yrKS/K9Rc9gYF5KFa+WlyNzNOm+
	Q=
X-Received: by 2002:a05:6000:144f:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45b1547c783mr4431996f8f.43.1778592525977;
        Tue, 12 May 2026 06:28:45 -0700 (PDT)
X-Received: by 2002:a05:6000:144f:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45b1547c783mr4431948f8f.43.1778592525548;
        Tue, 12 May 2026 06:28:45 -0700 (PDT)
Received: from localhost (bl15-153-58.dsl.telepac.pt. [188.80.153.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm31816958f8f.0.2026.05.12.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:28:45 -0700 (PDT)
From: Sergio Correia <scorreia@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sergeh@kernel.org,
	jmorris@namei.org,
	rrobaina@redhat.com,
	Sergio Correia <scorreia@redhat.com>
Subject: [PATCH] audit: fix incorrect inheritable capability in CAPSET records
Date: Tue, 12 May 2026 14:28:33 +0100
Message-ID: <20260512132833.1304542-1-scorreia@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXBA1TvMi6lh5-MwYdpR12UxqSViTn7_EJWcvFHpRVc_1778592526
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__audit_log_capset() records the effective capability set into the
inheritable field due to a copy-paste error. Every CAPSET audit
record therefore reports cap_pi (process inheritable) with the value
of cap_effective instead of cap_inheritable.

This silently corrupts audit data used for compliance and forensic
analysis: an attacker who modifies inheritable capabilities to
prepare for a privilege-escalating exec would have the change masked
in the audit trail.

The bug has been present since the original introduction of CAPSET
audit records in 2008.

Fixes: e68b75a027bb ("When the capset syscall is used it is not possible for audit to record the actual capbilities being added/removed.  This patch adds a new record type which emits the target pid and the eff, inh, and perm cap sets.")
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sergio Correia <scorreia@redhat.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ab54fccba215..abdf8da3be93 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2786,7 +2786,7 @@ void __audit_log_capset(const struct cred *new, const struct cred *old)
 
 	context->capset.pid = task_tgid_nr(current);
 	context->capset.cap.effective   = new->cap_effective;
-	context->capset.cap.inheritable = new->cap_effective;
+	context->capset.cap.inheritable = new->cap_inheritable;
 	context->capset.cap.permitted   = new->cap_permitted;
 	context->capset.cap.ambient     = new->cap_ambient;
 	context->type = AUDIT_CAPSET;
-- 
2.54.0

