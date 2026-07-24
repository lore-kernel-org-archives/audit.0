Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2444D6A1
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923023; cv=none; b=FW5w3xGmbJ9iYjLCg+HQci02A2221vtV4k2dxABuharqwiTiO641Yp+dNetQ6ILDm1NBgOSx+jReTNUAGzlMQRyKOuheFiSJ1qv0srhZKLg9TPeRx/Gzzy9k2xFGqgbhKXLEkeQrEV0sY8DKheTvjEdpm8h0Rik6JpZs9z+n5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923023; c=relaxed/simple;
	bh=bWKXZ7Z234bs17R3O83L/XesdxXak5dx9aa1xtaII/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6LUfqg3AT7NNU9f+eiM3kbncGlCrTkTY5c1wWMfJ5NCUi1bdcxHNdjNeviMT2MS+8M4piCfurRuGYFxQNc5Mp2f1RjvzjfstaaSh+zei0W6VCVrOikraxeQjClsDgT2mKNZE3eXvNGBM6GZn1sDjloiTL2MB/3fqsZ168zanq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ULD5da2N; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ULD5da2N"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930f618435cso85196085a.3
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923021; x=1785527821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9iz0XxiHqHs9NUArpZM5IunP97Asdk5iuaKThr50XIg=;
        b=ULD5da2NSMYehzgwmfDSRU/74zqCc50Z7PvlizG03qCsSQsaiqEpYGwD2pWg+b4+B6
         a7eA2W/Z197C8k4QT0Ezanf/ys4g81Z7Kq2GBlv4MPFktoESuPszYXWwYGtH18PfSC+w
         eTVbiZYCQUc6pWSZIJLOGRsSDwTGxOoXx10ymH8eCrMEhneO0diNYYbnSfi0N0WYKNdn
         R2v18g1hOSEFAKPmzf+8MB5teILADCZkfY0fiiMbUyAiUWigDdimwdAmBI2D1U26+p26
         +RvmnIOd/PSXNMUYfpMr4A1Slc0e26zg26e69kVaWxShNCIUfwYxY5MYOBSjBGWnN2H3
         DxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923021; x=1785527821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9iz0XxiHqHs9NUArpZM5IunP97Asdk5iuaKThr50XIg=;
        b=cO0/EJiTNP14xRM01iGgjmpBY5ZkQ0MPfEULfvnkGq/zRB0uOvnNO1FJwYiRhKmbDw
         CUy/8UiSEkqIwo4uErFAikJBVQZRBKtt74W9c/PPzPmAs5n8777u0GWMBx9uf13ApXLj
         HRhL4Qij0xBxtPrGOXXJPWzyLQIpRqQ1mOirgu8dbKZSuDonxc4BSB3z2y/gkVnmGD5Y
         XMsdAi2eepXjexaVgoq+eN27+kFuSHMd6MZxHyecc0AW7Uy6EthgR2TUFvb8GeRDeIVv
         7n0kFflzI3dcHZwmkcJJHwpwM+hWCxs/R/au++tYvm3TOLaIDd5lXbo4+rrJU09Skjq0
         VVRA==
X-Gm-Message-State: AOJu0YxkFI+y7F7DD75YeE003JDtRC/k49BoovPckC89B8jCxucPzO71
	XqushwJFIfIa4jjhP1YMNV7T3sYu2WhfVD99GzE0t2byIDThA8NstANwTkmvN8JnuVLZWeOWja1
	JsLPLng==
X-Gm-Gg: AR+sD13HhXhMYlvF408XDIn8MUFnLF5A4TIJ5swEWvBkQkpPTsaI+dAo4+q88MKpEw+
	Lp+XMPlf6vBcG2KU2yn5d67SlU3QXYuXa7yMJkcGNPv2vt26/H8zLLHYNPu+I9Kl6NMln/1OLbM
	ewl7ln+2zfefEG7ZfS188KB17RKZbxUXUzcP8yOCkpgcGk8Hb1E37C2a0cdbQFNU1saxOMhv/9u
	GP3AQXYt6iRxH7OtNklhrRRs8avaIJqxhc3ub16WcYSC5EfVqOZ6ea19qyRvVed1uKZroKGK1Mw
	szS+b7Ylk04RK6CiOEERnn2hnJLiOC+kLvmeRjw9GNvDMiwUZ1o5LOhZmtf2qdKpYOVkaaMjGn3
	qRouWxZXJU8wF5fyb5R3XVemZKac1oKvYCjt9GMydh5921crmufNErWUnM1vHbaNrBmf1y+w0PG
	m3HH3CduYpcFUnHUkDG8OVMlrpf0yCjths1Pt5Xd+xu/19sUo=
X-Received: by 2002:a05:620a:370c:b0:931:35f:660f with SMTP id af79cd13be357-931038a8555mr1000935785a.32.1784923021290;
        Fri, 24 Jul 2026 12:57:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f669e26dsm730331085a.0.2026.07.24.12.56.58
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:56:58 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 2/5] audit: convert audit_expand() to operate in multiples of AUDIT_BUFSIZ
Date: Fri, 24 Jul 2026 15:56:20 -0400
Message-ID: <20260724195626.327253-9-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724195626.327253-7-paul@paul-moore.com>
References: <20260724195626.327253-7-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=paul@paul-moore.com; h=from:subject; bh=bWKXZ7Z234bs17R3O83L/XesdxXak5dx9aa1xtaII/k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqY8N0AyjvNKu+2BcaRM0IRHki9OEOJ5gcDDvVD uSd3pIp/tqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCamPDdAAKCRDqIPLalzeJ c6YaEACoFd4FTgXoixTMdinRf9iNPDeQOXiKLxT7Z0BnjpIdgcq1V8Y/VG5GWMXgTwXh2mbLAKL 6Gr8g3BJew95eBboeU+KwhCu01N+hTfzqKRmLdgUXNKMAXkcKhr26mH4CN098sVqSur1gVs+OEY NjVNhq4zFwmgNs1GZ/HUD32ETaojZah7c5OrbQ+79iPBPvOWydanb7foIgyhuJztBG3eBwVu0Sf GnK7TeVlTfDbzOKn6I2ZVD/+vj/2T96yV20+r2hqBfR5/Pbzc7z5x1NyLsSvgZOxADtToNkIuD7 MIUUpfBVvTHB9JEK4yQpWqGNJ2iw1ofpYD5sxBXzFmqYqfT61t/trExTRn4OIB6xrlSBPomRMP6 V5UHYfkZY8vwzgPZTjdqTRVbTJ5pK+1a7JAffqrjeQ0Svq9BKczfd8rr4xv4gqMjDMnXGO5NDuN aL3feHWaHCaSPM1liMhuADlhi+nod7y/vT0N2/GIUS5i3HK+YKbsNfeuxUzHl+xh9gQ6eNtu0Ke teAb3HDOBpn6f9ujYChswoXKvjp0qSNnmffuOHT51idS4ffh5aZSfbMpHSoeXkpvOn6yOfwN9cC BKl3D2JR/IHmowBvfTVcHJbVzGITpwDa8ivi39L1Z/TEIHcoUGoVvV4zPYaCb/dRfKWmtOsh9I5 jBVwneAN+Fyftpg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

All of the audit_expand() callers grow the audit buffer in multiples of
AUDIT_BUFSIZ so we're going to simplify things by allowing callers to
call audit_expand() with arbitrary lengths and move the AUDIT_BUFSIZ
buffer calculations into audit_expand().

We also take this opportunity to normalize how/when audit_expand() is
called across audit_log_vformat(), audit_log_n_hex(), and
audit_log_n_string().  When the requested buffer size is at least as
large as the remaining buffer size, expand the audit buffer such that
the request buffer and an extra byte can fit into the newly expanded
audit buffer.  This should support callers regardless of if they
specify a NUL byte at the end of the string being logged, as well as
any audit buffers that might be empty (not curently possible, but who
knows).

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index ec88dd10eb79..520244544907 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1983,25 +1983,35 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 /**
  * audit_expand - expand skb in the audit buffer
  * @ab: audit_buffer
- * @extra: space to add at tail of the skb
+ * @extra: space to add to the end of the buffer
  *
  * Returns 0 (no space) on failed expansion, or available space if
  * successful.
  */
 static inline int audit_expand(struct audit_buffer *ab, int extra)
 {
+	int old, new;
+	int expand_bufs, expand_bytes;
 	struct sk_buff *skb = ab->skb;
-	int oldtail = skb_tailroom(skb);
-	int ret = pskb_expand_head(skb, 0, extra, ab->gfp_mask);
-	int newtail = skb_tailroom(skb);
 
-	if (ret < 0) {
-		audit_log_lost("out of memory in audit_expand");
+	old = skb_tailroom(skb);
+	if (extra <= 0)
+		return old;
+
+	/* expand in multiples of AUDIT_BUFSIZ */
+	expand_bufs = (extra / AUDIT_BUFSIZ) + 1;
+	if (check_mul_overflow(expand_bufs, AUDIT_BUFSIZ, &expand_bytes)) {
+		audit_log_lost("size overflow in audit_expand()");
 		return 0;
 	}
+	if (pskb_expand_head(skb, 0, expand_bytes, ab->gfp_mask) < 0) {
+		audit_log_lost("out of memory in audit_expand()");
+		return 0;
+	}
+	new = skb_tailroom(skb);
+	skb->truesize += new - old;
 
-	skb->truesize += newtail - oldtail;
-	return newtail;
+	return new;
 }
 
 /*
@@ -2026,11 +2036,7 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 	va_copy(args2, args);
 	len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
 	if (len >= avail) {
-		/* The printk buffer is 1024 bytes long, so if we get
-		 * here and AUDIT_BUFSIZ is at least 1024, then we can
-		 * log everything that printk could have logged. */
-		avail = audit_expand(ab,
-			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
+		avail = audit_expand(ab, len - avail + 1);
 		if (!avail)
 			goto out;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
@@ -2094,9 +2100,7 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	}
 
 	if (new_len >= avail) {
-		/* Round the buffer request up to the next multiple */
-		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
-		avail = audit_expand(ab, new_len);
+		avail = audit_expand(ab, new_len - avail + 1);
 		if (!avail)
 			return;
 	}
@@ -2133,8 +2137,8 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 		return;
 	}
 
-	if (new_len > avail) {
-		avail = audit_expand(ab, new_len);
+	if (new_len >= avail) {
+		avail = audit_expand(ab, new_len - avail + 1);
 		if (!avail)
 			return;
 	}
-- 
2.55.0

