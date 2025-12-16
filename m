Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D316288D6
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900868; cv=none; b=hj6ejsLK0dm/g3FMILeJYLgtzjml+ktlIwc+jOntmNzUtgVzH37VqvlksMBp3MuLMgNCkdsf2d4Q5dOOoRbxBwU8RMOE2wLZBvrm07JCiOFZpQYQA2O9BtUFWTgnXVrO1uJySBiU5Gc8BPnyEbVOrBZvHw305O3KDmuwIcB/ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900868; c=relaxed/simple;
	bh=VqqFmaNCd1ig7we7/9HrA258XcH7P++i0cO7k49LyNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aCzNnY0+o+ZmVVrzf10cfcv8FRl5moojk80MxRDuh/AYJHPZ922LUCzhkaxX9YrClDf6XCzPtsNuAT54cTCp4AvZFsYKo4E25CoMAyaJnzL5GzONIFcpOu584oLz1QyTPakUR4uhOllcfBSdTBR351JFIEqKz33zOp2eFhQB4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eXDe4zUS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eXDe4zUS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b29ff9d18cso530631285a.3
        for <audit@vger.kernel.org>; Tue, 16 Dec 2025 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765900862; x=1766505662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wQTpDQXYur2UuWN58TLGVcF/XqrpLHy5GWu7xZwefg=;
        b=eXDe4zUSaDedwl2s7kDuAeIwYDxRGtmVXLLFad2nioSUSOHguQZ1st3xear7lXGpON
         b+fVA9VOIvY1vHV5hSaRef/Tulur9M3+Fz8lqHd7pNR6i7WBH2+dwC9vHkQ7ByYLvgwV
         y/zgFdH3Xjk5E2KhAkahEs2KvcKgCyaqgVb1nMOoMPE+R1m20jjXOmab9H0SDK/DDvFz
         jcpPn7pacqAAbvBjc0gHsTJjB15yxdGQbGZfJwsqiA4GO9zHNp0lKbjM+A2D9GPbA6p4
         h+Mb3jOlmNpC8ktRp3CdIUsLhnXauKQ4nlTzTqIM9CS4nUtOH+LyUTsGxCCetmWjvRL7
         FWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765900862; x=1766505662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wQTpDQXYur2UuWN58TLGVcF/XqrpLHy5GWu7xZwefg=;
        b=GlUoqv8Tlk8KJXixeN8nXWpI62VJv/M7uYnllD2aMu+d3zY1yKHKWecGHHTS8Z5xVU
         hFY3I7NIBstTFQDfli31w1Z/9BGqWHPOFgTk3KmajCZpxvQYGOVDKDTa5ts52amiB40h
         IO/85AS0T8yzdGZpS/eD97jLyRg1eV9wUwXXptBvEjqzVQS1NnAmoS9rrwS3k4Zro3yP
         /UwojLGyhrVst+fALpo8mAy3kjdzgQfELNOWVP7aqWjOcIusbqhpR0eNBikE9/ofFtg8
         qWfVzpNHaeVgNVmmYecYxXH3TluJ3SPGqayPvUcV/oMM1sLiF31FnseF+8aDyXkGUaJr
         sESg==
X-Gm-Message-State: AOJu0YzRHUThTpWg1ILOUdql2rI857bKFn0cmi840LrwIDq1EBumzUkV
	Xqgn5AnWOrnHJpRFHef972TY/4HupJ3NsqEyRfomG91vI63kQKim0SsMvB30ZKZspQL2ODKOsp+
	JyRU=
X-Gm-Gg: AY/fxX6/rNyZF6AnJDBFQiKlkwgQimdVZlAhU/gvX2NFnx3IoAgr2+as9I43ErqBzdy
	YCORmPywwqUCkOFkUwjGQ3IDjwiMungNNKdyqBAC636CGimpf82F5wpGq7+/S5tP56JG4/fSk7R
	kIjERTOmXllwa7ashILseY8OU05Bfj2Ss19Dz3pQh3tfUanyNl/63SluqMFn5L0ay8iJF7ELm30
	rsDccCFQ996VH+Nb598VQpKSD28S2LoDgp6t79HSI9iCdgGuiOuApkB5Nda6CddC0uLR5acv46C
	K4C98gCoqPznc5xMTx7/ukXB8thoDrXjfzxBDjFz8v/RHK/fO2SiknJAiJg+RD+cAEAAMOFKNKM
	kP1dbtBZTnOWYppO6b7/BdLd7A1cWlwKkmo66ADL+UacZjlqpdpsyZPGowwAOIDrM4K0F/YVrck
	F5XoG8LhvXSYKa9A3IWecL379pJn9NwqfG5/Hjv6qGPzj3imVyepa/KDnz
X-Google-Smtp-Source: AGHT+IHp4Dy3LsnvyAAwG7fo7jQuq3WR+FXX8lZTdRs2Adaus0PE5zErMHubKaXtv6iSOQsQAkryuw==
X-Received: by 2002:a05:620a:170e:b0:8b2:7224:b254 with SMTP id af79cd13be357-8bb399d973amr1844971985a.13.1765900861216;
        Tue, 16 Dec 2025 08:01:01 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b669desm201664585a.39.2025.12.16.08.01.00
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:01:00 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [PATCH] tests/netfilter_pkt: allow for a greater number of netfilter fields
Date: Tue, 16 Dec 2025 11:00:59 -0500
Message-ID: <20251216160059.58230-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current in-development kernels include source and destination port
fields in the NETFILTER_PKT record, adjust the test so that both
old and new formats are supported.

Future work could include verification of these additional fields,
but put this quick fix in place now.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/netfilter_pkt/test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/netfilter_pkt/test b/tests/netfilter_pkt/test
index 7530e9d80308..f9e586a660bc 100755
--- a/tests/netfilter_pkt/test
+++ b/tests/netfilter_pkt/test
@@ -147,7 +147,7 @@ for ( 0 .. $#tests ) {
 }
 
 for ( 0 .. $#tests ) {
-    ok( $fields[$_] == $fields );    # $_ Correct number of fields?
+    ok( $fields[$_] >= $fields );    # $_ Correct number of fields?
 }
 
 ###
-- 
2.52.0

