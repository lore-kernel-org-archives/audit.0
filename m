Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258A46AA70
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923029; cv=none; b=DxVFkhE2qwE00gWGlnEuA7+poDDeZSWySCHcFoo2I6stijlCm39og4b6azqm+ud+VxhwO2GNUsTU94QrSHtuXQKLoFOHgLAVRlQObZUfk24nzMhnoa5s9+NOFel0VZJMqgsty8j/VizSdHT4DXRlba4omOLUuRt8z0BV87UmL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923029; c=relaxed/simple;
	bh=4Gw2IVpOgdOocYHCdFRUnlNX3/NmZtXx4/liPKcEjpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO5G6jpR98/bWGwYcDHQcFqyAfGqkopZ7BhwJKECaSu5f4eS10M+LBvaH2lb+QiFmpHUr1N4Kf1a9MWDRnJbvk2igyGe7XQAuDUtLDlTQHpTZGEUOS3Tzu2noWFHLkYPWQVTu5ddvvs9aSuF3mZcDEiOn0wzqXGD3klAMseJ35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6jq7fUd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6jq7fUd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5d6f35c1so73888485a.0
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923027; x=1785527827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J1xOVJdNWZxLH3pJJpSzgXR5mOmV4K5H7JFDWUSjYEo=;
        b=Q6jq7fUdIKylMeu3tI+U0qX6QJ0cJcrK8Y+b+Lf++/f6EBjogQFYtOOosMoclNJ3H+
         8PhEzig18Kud/ou0BauciFq6uXY4dlwcp3k5RkR4Buov2joi0Alz5/P33ckG/5Opw2NH
         icoCWuVRGqsaDySiPCqDJzRsFhm7Fl5WBFrbdpHe8te3VnoABXwKoZI8G2eeQjGkaBOg
         Oq1cJrGzZxWFBDEGg7CGwicFjhyQT9K8ckUu95AX5zMfcIAQ8LbqUDE8oJDJfWBuYddW
         qM1QY44TyW+1BxpzGMR9jgjY7d7YeQK4RcCqBU+hcc2wMZZ6RfO/8yVF+0k8FJ9PJfbU
         AHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923027; x=1785527827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J1xOVJdNWZxLH3pJJpSzgXR5mOmV4K5H7JFDWUSjYEo=;
        b=eWvroG0zJoLm4Mm9OsrXd3aF9qDY7vgFid7e/CyUbXCc9A3lbC8Smb/YoDyNABnoM4
         ETqPVdjimFwRvQaFTfs3hX76nI+odG01I956ALOQbzKvmugH84SvH0F8G4wZycfP5qW9
         ODuudJFBMPhZPLHejtsUug0j7rAYIzJf7HEsFJ+EOB2aCz7Ts77ZOYYlFUWAZhJlmQKq
         XEGJ93MaMq4GMSmB0RJZWeqr1gMFa5RHvFuO+MH/pM21KQTX/9jAh0fmi4yiN/I+qYhI
         21/h3fX+4vlKuELE6El6EnyQFpVOhosAm0CVMnaKyhD37eRubgX1olaSVk1HDjEgW6th
         FUSw==
X-Gm-Message-State: AOJu0YyAo8JO51Chhb80ZKgS2t0NRlA1mT8WoG5fyUid0M4yaxG/1Guh
	GI00HS8lJ7ODwRwYd37yVPym30B3uMJeEZfUala7cCS4ydrTgl5I59gSuFFyugjGSuWd+ASfg/L
	4wOsXeg==
X-Gm-Gg: AR+sD10wCQdOYeA+4p9pWGKHqI/8imdVS/EYHCHu0sAoia4B+moLO1Xm+Up3sHWLgwx
	vpTUulfF3RgoVVpbw+up+g8/VTX2uZ1+toTorsJ1Xniur3aQAiE7jKGTGu1bx4YbMMkA8NwCBZo
	s8TCoi9Q+XXvRG+0V76XYxBA+oJYIirQZPhE+eGuGGJ+jxBC01XByBDUdy7/4dUUgc9X+KuH4bB
	i8uXE4onbd7KWUnOPWz0Cfi2C2F4agbEKUQAcFN3B+h/fI/Dt7rS8BWOph7DCSFZzD6T7UVGAJ8
	mJp8MhHECrEdzKYW5EyP7E+WmoCSLo9gFK9HAH1wZx2F5IwcPBboXJFvRb1OcIXcZHfqmgCuxEN
	7IkPIOtT+OC9/LKKDtPdow4dp1OlbweVc9ikELBH9NkjQPyWjDURHCZjc9yVi9t5Sn/7Mzrvqsb
	YUB3hxFp7GUSCmYfdiTEtWjHNBcotgBOFa4gj9cGPkGiTQIeo=
X-Received: by 2002:a05:620a:711b:b0:930:ffda:b05e with SMTP id af79cd13be357-93103b6862fmr913932485a.86.1784923026998;
        Fri, 24 Jul 2026 12:57:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68a7fffsm727106285a.11.2026.07.24.12.57.04
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:57:05 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 4/5] audit: add a missing function definition when !CONFIG_AUDIT
Date: Fri, 24 Jul 2026 15:56:22 -0400
Message-ID: <20260724195626.327253-11-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724195626.327253-7-paul@paul-moore.com>
References: <20260724195626.327253-7-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=paul@paul-moore.com; h=from:subject; bh=4Gw2IVpOgdOocYHCdFRUnlNX3/NmZtXx4/liPKcEjpY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqY8N7criaFO+YStzssHPYdmE0opwojE8VP46pq 0kXZu66+C6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCamPDewAKCRDqIPLalzeJ c4ycD/9OnFwttmGF6UUW/pEHRdOYjyI5Q6R2szZF275vARVpgRymRQYGl2uMFpl2TeXZwpUy9iL 80tA5efshu6uIt9YbKROpbqOU2C5LNzWnZ8he4I6ERqM4TwA5RRNcK33wGSSdmWQHMOGs0ZlC/z ztlrnJPV8rfDqVmrJZV3kMXkaM5RlxVd7dL9RU70vvzb46i91Oi3hoGz9LWd26kTqo8vFVTc0/N TSMfP2oMSrcVFJa3o0w9J+bhTeEzL1iEEupUPeo6E0lD3HKPBzpMUExtaBbwx9dkmyism1G6Pge SOHYau4tzrBl0/JQJwGB5L3Ke9hL8hnkKiAcp1xWEXaw9wFXk2BQa9P686eXsIMvLoHN1VdOak9 uXZmSbCDdzab0RfE7DlP/7rTNcYHIoN7sztvIS8Z8+gl+ZCXNn0vmxR2KcdrYvd+jVWDyqAgkBv 1Wod2izGpMjEgARJepQ06BzfhTFxQ+Kf+mzU4yBDxru38TeU7NTCZQD3f0+xRf0lmgOOtTa26Gd m4jO8qmIhDflDBUHjRgVluh23Qy0Jsc+QD+8ERAftXxzXDwIu9BQel6nnj/kQcSYjcAP2B3MT+K h7eCMpvQFbxXX7z0qAzxF9siSAwk+9RwDF3mXG3sal8gyLM6H3H8FUQzNVz5T4zvPOXKU6cTC+p R1xc1WqGcXjrPTA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The audit_string_contains_control() function does not have a dummy
function definition in the !CONFIG_AUDIT case.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index d327113c913d..ac8f5f77d442 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -237,6 +237,10 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 { }
 static inline void audit_log_end(struct audit_buffer *ab)
 { }
+static inline bool audit_string_contains_control(const char *string, int len);
+{
+	return false;
+}
 static inline void audit_log_n_hex(struct audit_buffer *ab,
 				   const unsigned char *buf, int len)
 { }
-- 
2.55.0

