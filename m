Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3472E3706
	for <audit@vger.kernel.org>; Sat,  5 Jul 2025 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751701752; cv=none; b=q65h05lgfE9kzRQiW3oV8yA6Iaiqxfn+0rsr8iXUtAw2xBTNca7YKwudIGaDiNqFbb7Ux2TbpRWlGCfX4lI3+V6rD7sLqYtH0ZaVzTzahtNlOJPbcvfXObDlDtQnuh9VQFg8D/XbbhBt87tjaHwjyghzC5ZwIIk2wMWcrPD7C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751701752; c=relaxed/simple;
	bh=4kfAnSyK04lC69a1aTdPrd7hqVYChDsmYV6ePBGBejw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjEZQyFmjML55xUNN8+1WM3iyGfT37ZYqJdYOXKPtOBd+2TiFsgqM0Hpf5nmZcgQ6YKmzhgNiXcEpcuzFnYgUbcjss+iRZWjRnh2yySMYrTmWV1mu9rwY0C9FUOXfd0Ek3FOcif/X2CrXxt8CEERiOnAPH0TZNDDrUA2fT3oZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUGiywfa; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUGiywfa"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234d3261631so11412665ad.1
        for <audit@vger.kernel.org>; Sat, 05 Jul 2025 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751701751; x=1752306551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vINumRgZxVyy8+ay6M54z4eWjquLFhUI2CetavUIIIA=;
        b=hUGiywfa2lzEabiSZsQSLcCfn6UD28q7xl5CRnYXDIU3cJXzEodN3Cl6zYLor1EiR+
         71KgFWYCKMRM2gLqh0UQ0yPqWrrtl3/XBKPw53mEP9XbbpbmHGWhEjoLvFyg+qqEDg/8
         C5RVMPRvc//CoQ0xLZR6mftWnaWqqUfnQOmvuaKJym0K5lV1XlAjLeiXxX3O7Jzc+xxx
         uVZcw59IE0zMRhzvBFfLln+xnfTfrDQB6hifwZlDcfnD3LXkg0KWI33WYkaTjF3SgmM8
         /i5Nw1HFbFGeqpUgHb9cJJLpPezgWHFt/scGUViISD7VjdLU3On69WCZNr7eNHFLvj2B
         Y9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751701751; x=1752306551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vINumRgZxVyy8+ay6M54z4eWjquLFhUI2CetavUIIIA=;
        b=id2VQF53EU/8pcI5mYp0/rM2lUJmC5hJMMdhrtdR1odlZ8e+kVzTPSkiYI5HphRWHU
         3IwdrJMS3xPQ/muAQ4/V/nU8GzadkxC5BpxWgnRQLMc1Pv2q+1WKOkYG0va1qalYJsn9
         6fyC9qt4uhCoT9yzwOl10e6xuZOVa2Xv7+uQLnjmTQ2QdlwJq5qMM/MMqojWQ5yeXBVY
         UgHawU3h9rno77GE4loFfj2dFAoINXUQRrxo7Jj2HRYfcujT9BZfAWamtN91OtBzMQqm
         OPdneXCF2ZDMH9pDAYP9Rx1Cx41v/kQZC51p9wsSB5wYoTaxcaIMEjcUd3rgkgSQTNsj
         5Gag==
X-Gm-Message-State: AOJu0YwvyN94U5yOF1ZaXCoYSu9UXn+bTrK+YV5TRtlEOZjXxuSNaIn4
	ZjMSenKCM9gmldlAaE3i8DjdpU0Og/D8xKsWbc1LAj4GEe/x8yJY+ceU
X-Gm-Gg: ASbGncsHU4NregYoJF9BU5qS0/oI9VOLPEyQn3M4N8xQBT/1jsLLASwnnsy2vVLEvvl
	2hizX1/jvtygMLa61Lac6jTluaqxfMk2x01pZeDGcELqdIMXC98MVoqV2OKtXyG2RkPaElP0KJi
	e5O5QyrP2yRaV+Pfmkm99jVmKwm70JJzn7qdKR+OSeDCB64v1jVvIhFceWwldRR8IWusUdt+uNI
	3gIq34KJpYH2rA2X9dSTHXFrOEfkwFSOeCFjbbadH2RJzqR5+9ql3CkO/nHl6xOgihbv5YQ0NkB
	iIIFjV9wtcL2h00UlXwBxUMvUlRDaoNU/AwweO6B4flHSQ==
X-Google-Smtp-Source: AGHT+IGAGyvepSZuQXh0uiecLuZAG+Qp2LJlQLgEXapnHkwwNp3vkapXBznAbYpEDAQPeiqH0vNwBQ==
X-Received: by 2002:a17:902:db0c:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-23c90fc9aa5mr20208095ad.25.1751701750483;
        Sat, 05 Jul 2025 00:49:10 -0700 (PDT)
Received: from archlinux ([2a09:bac5:6388:123c::1d1:b4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c843519cdsm35706705ad.65.2025.07.05.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:49:10 -0700 (PDT)
From: kfatyuip@gmail.com
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH] audit: fix typo in auditfilter.c comment
Date: Sat,  5 Jul 2025 15:48:10 +0800
Message-ID: <20250705074810.102784-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kieran Moy <kfatyuip@gmail.com>

Correct the misspelling of "searching" (was "serarching")
in the function documentation for audit_update_lsm_rules.

Found via code inspection, no functional impact.

Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
---
 kernel/auditfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index e3f42018e..4ed0e10e2 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1440,7 +1440,7 @@ static int update_lsm_rule(struct audit_krule *r)
 }
 
 /* This function will re-initialize the lsm_rule field of all applicable rules.
- * It will traverse the filter lists serarching for rules that contain LSM
+ * It will traverse the filter lists searching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
  * updated rule. */
-- 
2.50.0

