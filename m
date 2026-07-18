Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5F43F0B5
	for <audit@vger.kernel.org>; Sat, 18 Jul 2026 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784351370; cv=none; b=LpmslkYHhrYl8NimYMMQJqghLPTgVnqFUNlUmVsSpWa2hZ6UQkClG4sVhG6Spp9qXNvJsKkCUw47sxwaoDNvPIxYJ39iUQ0IchNB8orKRsn8EJVF3kKO0AQ2sT16AqlUK7KHu3e4nKxV97mCj6CGwjlONUxU7gCCoYoKbkwlYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784351370; c=relaxed/simple;
	bh=m0ccft+gceUz3MPTqfWxpwD+GP4/rdsMkv/6QSxi0lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adh4zopt4W/scFIWyu8TZGNI85YhFZxkidofLGuLtiUALsWY71EXBYwpL7EK2K4w6NwKE2d0/hUewvkVfgMU7HqB/wzju0H6ZDnPOrm7kiNk2Z4++P7Tia+g7ynkdZ8MzB7pqluJvkWGq4hY+PJ/WAN0uZ6gu4MolVmN18wvrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKn+I1wb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKn+I1wb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so2368868b3a.1
        for <audit@vger.kernel.org>; Fri, 17 Jul 2026 22:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784351369; x=1784956169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGpAvn9E9sdeBFr4azx3JRFkGov7PU5BobgH3wDuOJg=;
        b=NKn+I1wbZuA/B9fCidmzfsUEB/JblJf4P1v5WooyeC54yXKFLKRXxnRdVBAXfodph8
         SchRMexgUtFgUXfm7FEfV9jXo2mGXKA3sZx6uB8TgKtrGSy+hGq75M0gshAHB3rBivOO
         1gXJxO61zCdY4kshgSOhSQ9F5DxFXG1XqYI1rt2oqoaMddMSKRbEQQENj8UbSDZETbi1
         XEo2z6jcXxWAE+F8OpTKyuusa7vsu2ZnBQdMclP4QWXZyaDANnIhzyVAx8bMA6z8QoLt
         Y3rggPYFJ6v+rG1PiEVtogr/EfuUAyQ8192zbnkYwER/4mpm9j1xfnWvHwYXIA480xah
         /REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784351369; x=1784956169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGpAvn9E9sdeBFr4azx3JRFkGov7PU5BobgH3wDuOJg=;
        b=U4IaC7rPERLEgGWSmP+CSPf/AmvmJl9D7PgSqyB6kC3PvsqntptCJR7mwfMVhK5T/W
         DMyolfiYczS5VwG2cQ72NB7stGWTpbvEOStmwU7NaB3Ya6RkolZpWF7vYkvtDTh3cbNa
         BRsFk5Lgjk48ixPaD/XFCbQFhVvFMga1ahZr3I0mIortz6zMqeihTii1+rmdckyAzATf
         vPMr5sKgHb8W1MFBM6bBWuccwJCd3R2f3yX2ikNKSYEeecIr9mFu0hhAICLVHKnaRdHN
         4ZmWckOgkXqJV825AaxxX5qT/2B2U3Vu5qich26hBRx+S369MD/w7ljnEXhsIrH8/Xew
         ZzUA==
X-Forwarded-Encrypted: i=1; AHgh+RpIK/jii3D6nZoQNC6CXsVvHS7pLpHpZg6tM/uaIM7qZbYeuBdQnqN02iDgm0uOYHs4m+Yfxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHhR3TdEUdQ8m41CxvbAb5bcB/tAu0WbwJtuxFoFH9ejbevVs
	YbBqdJVWRaExH3XjY4MoSyxbwcXW6RkMK9PoLIp3YKxxAzzwSQ1ykx0L
X-Gm-Gg: AfdE7ckZhwN6+p+CO7lDJzma6A/gdlAOKiN4IiM77Q4PqHy1EYBTvy4mu4gmZ4YtFX9
	5Fqi+n4D5Kx4R7Wd4ZTf5RuClJspun7VXaALVJXiifzZ4k90/kANvhysC8hHPPUsOPcyR+pp0lB
	vG3I09bH0P7sU/x6xNwg0RipSHjOrgflH8lMbMdMFms6pteSzgKqmNbc/2DTOAVhTXeYmQ/ZSIl
	H7yjlNX12O26vm+/QYnk/PPKKioft5E74R7Uu3kxgT7DwH3+Rk5DR7eekFrfXpM1U7Vyy9/qpZF
	KIFnB43EDKqcVDhwiBy9ULq5U6f4+VQziN+ntdTU8cHlJTlP7mS5eeE4uBY8j6WNoU/HuBnKKA9
	Y0Kfu+EfRjkmzZ9iDWkZdYnqZKmFZm/R0h9qZSj0k6TGGmBTbahCRkc1rDQeBGJzgFJSZHpWLQi
	fPmTKkQbjrjzI29w==
X-Received: by 2002:a05:6a00:1f14:b0:847:9803:ec6f with SMTP id d2e1a72fcca58-84beb187fc2mr9986170b3a.10.1784351368541;
        Fri, 17 Jul 2026 22:09:28 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afd07e2sm2205246b3a.61.2026.07.17.22.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:09:28 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] audit: fix potential integer overflow in audit_log_n_string()
Date: Sat, 18 Jul 2026 13:09:22 +0800
Message-ID: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
References: <20260715024635.25376-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_log_n_string() computes new_len as "slen + 3" (enclosing quotes
plus the NUL terminator) and stores it into an int, while slen is a
size_t.  For a sufficiently large slen the addition can overflow and/or
the result be truncated when assigned to the int new_len, so the
"new_len > avail" check can be bypassed and the subsequent
memcpy(ptr, string, slen) can write past the skb tail.

This is the same class of bug that was fixed for the hex sibling in
commit 65dfde57d1e2 ("audit: fix potential integer overflow in
audit_log_n_hex()"); both helpers are reached through
audit_log_n_untrustedstring() with the same length source.

Make new_len a size_t and use check_add_overflow() to catch the
overflow, mirroring the audit_log_n_hex() fix.  No functional change for
the in-tree callers, which all pass bounded lengths.

Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - drop the unnecessary (size_t) cast on the constant (Paul Moore)
 - emit "?" instead of "\"?\"" on overflow, matching
   audit_log_n_hex() (Paul Moore)

 kernel/audit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 562476937fa7..9412af9144bc 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2120,7 +2120,8 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 void audit_log_n_string(struct audit_buffer *ab, const char *string,
 			size_t slen)
 {
-	int avail, new_len;
+	int avail;
+	size_t new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2130,7 +2131,13 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = slen + 3;	/* enclosing quotes + null terminator */
+
+	/* enclosing quotes + null terminator */
+	if (check_add_overflow(slen, 3, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len > avail) {
 		avail = audit_expand(ab, new_len);
 		if (!avail)
-- 
2.43.0

