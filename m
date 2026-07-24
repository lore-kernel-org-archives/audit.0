Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A54483A2
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923020; cv=none; b=O5UtcqtJI94K6b67M9ImbFEMP7x3omTjBIilxJLP7NbhydMzZYvRQa9E0LYss5oi4X7UJZzsbDNJCx0sQhm4Rvax/6EmUq50HKP07hmTz06kHbhUOHalrhR2HLOV+wgch6goU25emXIzUciJpvzWShmIXQg9U/QOhTYykvdPinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923020; c=relaxed/simple;
	bh=wSOrLDSFCvO239YsvUer29HL8aiczOkKLkUbHqs4uEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBtaX0IRutZFoKs7l0Oji8LssJsltdR26bzu9vMCwVrjkg7nnwIFSUftRwzsKljcTysinJAiXMkHDR+p7H4MjfimN6fBnntEPrn85adu4Go+lR3Xk52psTXFGmZw6YMk/R9MGeh74NVBCFXgKFyFpJ+rhGIvWFzyasXOZrqJUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VKi9gDte; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VKi9gDte"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e99ef0902so66271785a.2
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923018; x=1785527818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Uo2hRh8j88yxpJczD1x2hXmindmOLbb0iF6bMlvOiE=;
        b=VKi9gDteobdulOidkaKLHYeJ8jdwqAnnaS7cm0y2goEiowR29tRuFnXEHJF8xWN6YN
         SvEHgrWRO8jL+7JxAPfM6NuhSYVB7+d2vIyjUsMZqfOM2KLNT4/djcQ7cO6O5m3QgV9Q
         seMSa9DYVf0V80qaA0tRoPtNmx/zYacn54l/sv/6B76JzNyNE5fvn/gb6Sv87pOlXNAE
         FNkJ6jSo0lmSZBTLQs/kHlRS1iYohyWbWIP9o8zeALjr4IKWcNIkd0Y2UuO0TRLeM3XR
         VWtXVkGmD7GMZbYQqauEQyRPa7Q5t9U8CmGUE31rtxXctGkr7LGm+4gHwVSX7dK193IQ
         BC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923018; x=1785527818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Uo2hRh8j88yxpJczD1x2hXmindmOLbb0iF6bMlvOiE=;
        b=MZnEM7B5cbKSIxYGUaooWr9T1qSqMd4jaldOzr0h0tG+kzhJcpTRGHwmAg1bCHi5t4
         qnOmW6Mb3a5+ysXRDLXX0x6lRSWItk+N5DtOS/7ccY3rouKClGuVZ6uCnp62G/pEiqK/
         Ba88mqFiYLyE9y8vgja4Y/4UCzVr9xOcOrcKDKwsjYT7tDrlaiBFMtNA3MHN/XxtC6/N
         J+1KNZLhBhbb6ATEsId14kBQ2oZbNJ+YjDWAXgONJfwLnNurNCp/LyWbtlfiS99yUrsv
         oUouEtjtDse5daBgqLsEjh6+W2hIPXCBFnUfR7IORclhMVgEcX9joZpa4/w9hn3cGr1l
         NsBQ==
X-Gm-Message-State: AOJu0Yz0i9GjGS0C2DhwwbV2H+jCDIIykG3+AsPDO91BH3x+uipoio6N
	XBnaa6bfdpNuYJa0ZnGKCCHtz/53ryZPXj2XKWuGciVd4SJ2Ope/17jajqJZ0rQ3Senz5oFsFQj
	9buhrmg==
X-Gm-Gg: AR+sD11mQllexyHav5GtM7XtrhmjwRqtOknHAuvvwexr6uBqZl8f5S4ywqBpxd5Slgr
	QAPSGI0dUPuSN5gnKu49+uhvVMd3Z7ClFNM6dqKfgBaW2XcX/ZactVOeKNCPGzyiuegBx7LoaOR
	10TprVGdr7dqLgQOCeU76y3IaYCQBotremBp1JidHLd1TKn4t3THOo1ZAwAXuPIJMJ2Y2BXWdar
	ut6qzK+JUGpqOQ6+QzSHpJjw+da3v6WAN5w17J9LHxIjdd9ibJnxQ8sN9ez1XqDPluaZQBtBT2q
	cZtd3d+qyrgTPiElo/aqGEHCiZI3oEhSm2cOAOfoNO1VICQjD1oHB8eCJqBAbq75aoT504QGaIG
	wOrPB9dxf8OV9GVbDQDwgGJptvoCxKhUMjcM0Et2Xc02Z/NPSIki4pD3+vIaLIrLre9j3OoRb4c
	0psNqqNy79PLCrk4CzCFsniUZtwNXUIp76IkRgv2nb2X7SJoroS2sNNgWUaA==
X-Received: by 2002:a05:620a:a0c1:10b0:92a:bbf6:717e with SMTP id af79cd13be357-93103637eb8mr741170185a.34.1784923018054;
        Fri, 24 Jul 2026 12:56:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6872a59sm713500085a.3.2026.07.24.12.56.56
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:56:56 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 1/5] audit: only call audit_expand() once in audit_log_vformat()
Date: Fri, 24 Jul 2026 15:56:19 -0400
Message-ID: <20260724195626.327253-8-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724195626.327253-7-paul@paul-moore.com>
References: <20260724195626.327253-7-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=paul@paul-moore.com; h=from:subject; bh=wSOrLDSFCvO239YsvUer29HL8aiczOkKLkUbHqs4uEw=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqY8Nr6l/hvst9l5dAZ2GIpW3b88BsxRMKsV5e0 k0YX7pOKfCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCamPDawAKCRDqIPLalzeJ c8y9D/9W6W+BPxmZABz/+d/+CNzCGk6yoKHHat6PZkyruA+57vk7ag9IinqYFKvMxg9+DjxsXdo jX3nwp7B7KuAzEQGcASwMBbalD3aY8IMkp170h2QwGytgixCQyFIk7+3RI1JKWaJPPx5s2gRD/r L4rDW3SOPgj3td0NTIjpPsGikRmVUx4ftBwPAWPb12vgvmUr2E5YcGhxFTXPbK3l35A1e+tl7Vb pLj4SJt/MvINI3E/fJeIjAiw8PgynA8b3AfGG2bQi2z3+C4Jd0wu0ijLrbqsUJLdxEkmzL+Ftue eCxrW4SZHXSBl4VpZPKIH1Bx+afIEQ0s1I6GHh/3UN8bnCa2QIe4b2Rk+ZTz6tCbxutYfyNltbc SeK1R61IlnbrpxkwiXTDmlkZbYd/FFd3TG9ng2Ko8GEXW6XMrJ6f6OiEyy8fw1akqlyh9ynNkxQ QR+N5QeDf4n16p11RlScvaF+7TgLh5dnDyuaUVTKi70uLwG5bUto8jfDuG5MzvCMPj+A+42WpgG TWo2+3pmsmf87wjuXTNugjZITvwQOPhJQTNfVNmh/DSrzRPHwBAbDDg+EsfRLrl8JArTaSjxx3w ok5g7U+GC4YqVByTsnlfy/wrHB+kqUc49sN+U3Ku7lYf4Ag12xpjc6xUm5TWhNi2szj1tm3LTYK ygVyMKPMTP9L/xQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The audit_expand() function ends up calling into pskb_expand_head()
which does a non-trivial amount of work.  Limiting the number of times
we call audit_expand() is a positive from a performance perspective.

We also know that audit buffers are originally allocated with a size of
AUDIT_BUFSIZ (1024 bytes at the time of this patch), which makes it
very unlikely that an audit buffer would ever be fully depleted and in
need of expansion.

With all of this in mind, don't call audit_expand() in
audit_log_vformat() until we know how much buffer space we need,
cleaning up the code and potentially dropping one audit_expand() call
from the audit hot path.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..ec88dd10eb79 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2023,11 +2023,6 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	if (avail == 0) {
-		avail = audit_expand(ab, AUDIT_BUFSIZ);
-		if (!avail)
-			goto out;
-	}
 	va_copy(args2, args);
 	len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
 	if (len >= avail) {
@@ -2037,14 +2032,14 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 		avail = audit_expand(ab,
 			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
-			goto out_va_end;
+			goto out;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
 	}
 	if (len > 0)
 		skb_put(skb, len);
-out_va_end:
-	va_end(args2);
+
 out:
+	va_end(args2);
 	return;
 }
 
-- 
2.55.0

