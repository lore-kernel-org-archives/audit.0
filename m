Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DD46A607
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923031; cv=none; b=EhdmFDHy9bD+KOVBokzi0oZRHDbJWac1GpxeeBmG5lGgSJUCdIu3MwVxHGuQRDgebAveoGbGl9XHh152RXTJoDY59BgUwgIvtOqRwmhJvYK530BUdbDbNRnwsuzaxOjevja81sIxwTLcA/9/hc+nxaTEhd6UJV87XD0savLsj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923031; c=relaxed/simple;
	bh=KqPiLRgvEoOd+27umptgq2l1H+VnCUJmJ90oXyJpnNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZKU00SWyQ5eiLGGEvs6b3ThY2TnU1m9LXi4uZKdHaU9tCAvTG/U0u4Uo+36LiCPlorCput0s752eU6CmppV0VvuVmOVb7nhiG9Dr5v7+XjOZWacNoMnlh5I0j+Wg7m+O6ys2VwmHF6Ri9lRxe3YaFmnRecUPf0sB9O33W2pheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TbldCtkx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TbldCtkx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ea24a2dbfso78640485a.0
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923029; x=1785527829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=55xa3E9hx4b/BfAdDUZP7RS1hiIuq1nQupxdsyynk4k=;
        b=TbldCtkxDu6Lmu7f8jFhZUOIkRyngAlBX0dNiTYg0TkFLi8sDavfGaSMSwOdd3mq+D
         7JiiBbdnMJXbm8OiSYsbe+JETpWfYnhvS1R4RI0kCQiAi8nGdytkK7P/ZUPF7a/0eCVK
         l8EP2cbrQkrOk7/q0gq82nbfEO6qMJMxuLVHVuHYhVZ9LMeQkgh8Y362CF2fH6dDGY3+
         p3ZDlpPIe/2crEbW66Pe8Mwy+ohpfnetO8PxSKfxBmEZOiBFRRdJXZMBUkg9l1sGNUHh
         FRdVy/lmnjsf88WvxMQh8DRKcX5URjcIgmGhMIkm4G61HNG1OzUPs+e6DJf8WUZWrIrp
         yqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923029; x=1785527829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=55xa3E9hx4b/BfAdDUZP7RS1hiIuq1nQupxdsyynk4k=;
        b=Ri4dNE6vrZtIVS/3jQDPCvPqp5HHTDMyGAAACN4GloEJE0VporkjHoF4Y+k4wVQy95
         sPR6iXxEZ4Tiwf9nyVw2qDlSA4K18Q63aVcIFzk85kWMTDKFIiucpxY5wRmzFGV6QTCo
         ZwODYgnFXOvOJT0cdKn5ktkofTJzGSwivso+bI5y/phAYwty6u0USUpWI360mkssKXxc
         XzpWPC+BjTKLO9yX4xnvHdYdtzaJ5OR+Gqmgq67k5yLyyXjqFETrZbGfOjzUn7630zpg
         /QTFYbFWK64HTW0cqfJ9re4O6hKPICD8fTYQ2fGsKHQwopjhlv93w9VwwrW/1WV7I1qz
         TBYA==
X-Gm-Message-State: AOJu0YxPRZZcTZ9AraAzZ+DTGh10zZB4DP9htJcdRpe4T1/t+NAbI8H3
	cJ5UhkGC4MVrzFj/dr0ZE7EUpiBe8Na3GngTHtSJeQ6ANM4ZT3TamNDsP+BPeq0l16Php66Xd9S
	KFZRE+Q==
X-Gm-Gg: AR+sD13xNl/VzWBVyagNCGpoRMv0cHrY1sWEbet2jH2C+w2A9BuqCxzQNA07zbvwuhg
	6G4lSikhZwluJqTvkc6/aAJ2C5bXvMKAjzmZuN/hWwmpCHnSRSAtUzh9RF/9UdvY5rB01zEGDHj
	QEvU978V8KGnQ1nOHi6V0V95Wvg0mXJuO6ZO7+STWZw78RwDQm7CczSG9d3P08QHMaquQfgxhFu
	DwPzTq1iFxh44sTWln0qk41GPxts4Be8BNdWZCzO56+4rvWfovBT/kx7AT2EX/b9PZfbhnpqTn6
	NZOWRUN9zPKWaKEi0WjncMepyZbkbAaxukYNMKyyeFSh36rxB2Oo78aCyYLks8rj/ciJCbNKBoI
	MAJgYrUZaYfH+mdTbQTVA1z4bBYLj9uM00cH4yWQdf686YPV6L8iOQ967mQsCBeC4ngdWF3//HE
	SnxFnD3OEMpnMIJiEC2E9cr31O4sqg4O0uQIKHQD5v4LRuNlAvQ3zyoTJYmg==
X-Received: by 2002:a05:620a:4003:b0:92e:5501:9530 with SMTP id af79cd13be357-93103addc89mr956917385a.59.1784923029410;
        Fri, 24 Jul 2026 12:57:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a7f937sm725706085a.40.2026.07.24.12.57.07
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:57:07 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 5/5] audit: drop BUG_ON() from audit_log_XXX()
Date: Fri, 24 Jul 2026 15:56:23 -0400
Message-ID: <20260724195626.327253-12-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724195626.327253-7-paul@paul-moore.com>
References: <20260724195626.327253-7-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=paul@paul-moore.com; h=from:subject; bh=KqPiLRgvEoOd+27umptgq2l1H+VnCUJmJ90oXyJpnNI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqY8N+x0G+k35XDWhrbnCk0Vm3LApNUtRKRIE4E c2nzufU5y+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCamPDfgAKCRDqIPLalzeJ c8u2EADCrQFHv0KzcxA9w/8ts5glGWUkLL4QbnkSr93oxCNrmcZ9DuqwpfGdKQWJ++HySSW9h8Z hoWp5puJQIqZdZUi9pgCBFbe592poBWZ7BffVBtfk+dp5/47bTi85tTavwnMdLRny8YworfgpYn g1DS1aAfBPOeaehwZNITM1AwZNR1fc6xzKwQe0an8/Ms6PoYKW6tcg7lUHdKDSyVWC0zgXujw/K FU0U4wLraLXEBUsFtZbztmHZXdPWTQtzrNOv5melW8X9bPL20UCu0OAbRPWXMyWEnw7yVeuPaw/ C8GR5P01yveYw4ESoP9sFT8uzlgQ2CAZHjvje2dMY61AxtbU9ucyOyWWxW2yooMyesYqW48d/dK JbTLMFS3U0qrdfQ4NJh0EOLJbAdrm1z8PVIf9JeHnWiAzj/i6jRpS0UMURDB3MpVe78HQl04uUp N9M7wtPkP/sUxuTn+6WGj/ieHsySi7SkPxsRqXElf0soXIrs0vUNhbO/l/GjKVGfqCbEcfsSuT6 9Wawuea0ag5wXsq0y95mESq0x6zEQLEL0ZN2lG5AqPh0CgWTK/QWU5Hn7ApkbfeUlpFHlJH+oN2 wLhVFZDgK/fbg+v8D3t35HUS8qAptlbBsnV0+udvUVhopMMdhYIjR2BqQ5YESuU5hCyw+V69DrX tB9Kdgfy7TM/Ytg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We can easily drop the BUG_ON()s from the audit_log_XXX() helpers and
simply return to the caller as we do if we are passed a NULL
audit_buffer.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9e10adf21c76..f832c297fb33 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2027,10 +2027,9 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 	struct sk_buff *skb;
 	va_list args2;
 
-	if (!ab)
+	if (!ab || !ab->skb)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 	va_copy(args2, args);
@@ -2086,10 +2085,9 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab || len <= 0)
+	if (!ab || !ab->skb || len <= 0)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 
@@ -2122,10 +2120,9 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab || len <= 0)
+	if (!ab || !ab->skb || len <= 0)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 
-- 
2.55.0

