Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED54238C3A
	for <audit@vger.kernel.org>; Tue,  2 Sep 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810858; cv=none; b=AzpIi3KwcUaAkfZ0HWqmumDN1dRnjbe5UGSIJKvu6TByH72FDbyDuCDLPMnYbHSQut9TyXX308H+nK+bO0W/5bNTVaFmplJrRYyxKGrZaJVqeo4I5KYcF7ZtrGqdyFkWTYgpjbRvidU6BZrv4nlhe3uh8JmAmsGFbnKnuQEkhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810858; c=relaxed/simple;
	bh=TGflyUFEOFiUqx8BIfQsPKxLGuTGYKbRxXEMzKyG68g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olvH5jFCC5ts0pH5D5TfNEJG0BIyOm3AKiok0UL0Z2/INANSc8AaqCbG27Lduu5yQ9RRwPOpXDyLEUvNx1Jyi98yXD4f8//f3xiKSH/B6fr94tDz2MW8opBeDCgeODxrrbyecL52EwavMEa+e0AV4eHhbdrFLlbEJCnxj2occlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=mPAyu8sX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="mPAyu8sX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso33488235e9.2
        for <audit@vger.kernel.org>; Tue, 02 Sep 2025 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756810854; x=1757415654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hUXNYxsmPHfvn2ncRV+JurxIcEZ24THJsmI/NLywYI=;
        b=mPAyu8sXxX8dMXRDUYlp0r5QAxgB60I86Z9VMAwyIjRO0E4xhlAjrfhfJBk920YmIL
         MX+eFrffVzPUTCiSgmcStLMTiKdCfMOGFh4Jpaa0r2fSZflOXl48li/fF3z9J612npZp
         A018fg4rjbqsRSPn8y+ASnTEfECQtweJfJLLz6xj95a17lfz8mUkwZWUSgzGYRgqcZiC
         lamfF3cESeKWMCPDOudrWdqOkR8zggQN8LBU5XwLbbdUN8NqQaUqQuSgU9xYZFeTDG49
         olsqNOBF1cFgJpQJG3KctyKMXIijQhnjhJaGhyvWKri5/QvhCTK/R7p9Dje5gZnYs0Q8
         teaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810854; x=1757415654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hUXNYxsmPHfvn2ncRV+JurxIcEZ24THJsmI/NLywYI=;
        b=dfMXHua65RlUeicICsCt9qadSdPdTh+P4hDd/ARZlmfnJdX2RR0Yya2zK62KouLOTZ
         +qhNT3us/DqSqIRzTmAhmS8b+QxMNKSb0sEma+o3HpFXGTN4Gd5yFjW4ctvmEGtVCia/
         Pb8pH0m7XirEMW+B+r8nJ4Fj8fQbYBNvYYEQOKI1p4RptUG1Mzd40pEEi851aJ2fbxIS
         MliWcpjJDURG/dhElgr/SuIhkr75pudsAAOTUWR+25ROF0ZnYJNd74Dcy7vnW/MnGTad
         n7v+2e0MrDWG6H2nAF8DY/UsYcoCfk5/cuQ5RhcQcdn4PYeOVgoKv78rH/JSG8cPzu6q
         uLeg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqVnzFStYF0f/sghZ4elmgwpw7dLMOfxrw/iPaGAQ0EiKR/F90zEmDcxWoUApMuy8Js3Jyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7anuhlqBmbdxQWj9g7vUgsY0yB6MbdzzdUK5Gaj1m/Sgk7Ic
	BXixij5uQKg4mzDIZqwTh7jUXH9vljcwufGLIXzaVXeUZnZWtEEC5icXKQGN0qv/b+w=
X-Gm-Gg: ASbGncskj1yC9dFpwS/z8pQER4HT1Pm9cEdNapRfnQTDyG0y/NAG+DZMg3i77WFPWOM
	9zpx3Tiu7KON/KN3uUMyXY+BCFt+c6b4BryvT5ztqDvj2a96WI2FGYWbLZc5dmLf8oVqxtxL2+r
	vI1wM38ihheF4d/NwdqoVwKGaoSx4yAp8lV8K+9hlbV6QJgncO0hU1VrwskSGaabgqHrj/5AUKS
	P0zXqNUgdBv0GdW4Zu2Nl2IrNDqhFXBCTUoC38yN2BFZsJMZjJ1q+za2WNzolNbSjB995CVdCke
	K3Dqgsvezy3ef2Uki3/y7QKba0SEaDxBVamZNwafkcv4K1OUhcds2DTCry/5kumzQ8TTbyRha18
	wrLHeMyEpGryTaOCT+/YoCMCd03im5mo5wKo1V2cFtE1e0EcLy9REA2QA/9fMhB89um5DQdKpMg
	UogPvQCDBTEIslYCj5W/9AuJ6/FiM4zQ==
X-Google-Smtp-Source: AGHT+IHM3xDjBaDs993Sm3AD7Y8PW48gckpE6MbRpRa9a5y0fBrOMm+jxslbINuLX/D1S6JiqV9eTg==
X-Received: by 2002:a05:6000:420b:b0:3d0:9781:6e50 with SMTP id ffacd0b85a97d-3d1dc5a2b8dmr10911493f8f.13.1756810853911;
        Tue, 02 Sep 2025 04:00:53 -0700 (PDT)
Received: from localhost (static-23-234-110-88.cust.tzulo.com. [23.234.110.88])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-723a85aac02sm4211777b3.73.2025.09.02.04.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:00:53 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: paul@paul-moore.com,
	audit@vger.kernel.org
Cc: torvalds@linuxfoundation.org,
	eparis@redhat.com,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
Date: Tue,  2 Sep 2025 14:00:49 +0300
Message-Id: <20250902110049.4437-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a watch on dir=/ is combined with an fsnotify event for a
single-character name directly under / (e.g., creating /a), an
out-of-bounds read can occur in audit_compare_dname_path().

The helper parent_len() returns 1 for "/". In audit_compare_dname_path(),
when parentlen equals the full path length (1), the code sets p = path + 1
and pathlen = 1 - 1 = 0. The subsequent loop then dereferences
p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.

Fix this by adding a pathlen > 0 check to the while loop condition
to prevent the out-of-bounds access.

Reported-by: Stanislav Fort <disclosure@aisle.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 kernel/auditfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index e3f42018ed46..f7708fe2c457 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
 
 	/* handle trailing slashes */
 	pathlen -= parentlen;
-	while (p[pathlen - 1] == '/')
+	while (pathlen > 0 && p[pathlen - 1] == '/')
 		pathlen--;
 
 	if (pathlen != dlen)
-- 
2.39.3 (Apple Git-146)

