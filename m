Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B1456DF6
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923027; cv=none; b=P2H0R2DqfWxLIzH9DH8p5M+m6CnTv0+LYe3RiZ/XMPsipuDqd4pf/gp+lkkNBvMX2+Zs/OYk3BM8VGj1BPG8MCrpfIAsXpLpTr8UqXZ4c0hFF4/Qv2dhZqafzcBQEa36eJAXXY1VyYHfCMQzShATIkSMk8lMakU/XylnC+c/t5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923027; c=relaxed/simple;
	bh=NazMhb2KHGSWbXp+tBNRkQOva9cSeFcWCES359dd9iI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui4utlBuVyWYviSIebsUA2lDaemxWLk5YhJQQs6H6qEr+T03agM8VqGvUMtgcfRRkLBGm0w105Ve+8Evq1WVr8ZQF/HZ4DyNxLykW7d3v/ktjSCSmZJ70atThVp7vO2dFykzNpyyOCDmvoYfi0RF1Y6LdCGQ8/Ma8h9UJ/ADB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QKfCokK5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QKfCokK5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfad59921so8020721cf.0
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784923024; x=1785527824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s3aQRJ9pWNGfFHIIohOKEOmVkaPLpONl6pYlOBOPmeA=;
        b=QKfCokK5CcN4qZFv4ZKrYN7s70vnvCM+CuJxxrXoGfxEq9LMGwVO/qzPiYve2hVCqU
         WcRRxlbQcfkDOnR2TgFz7TFIZVv24ywMjhnIvzbxBtmV5PtNCktS4nCpSYrQtrmgLHAy
         kMBF22f8dBRTU2o6THyLTb3f3OvEJvN2GxcljTx+u3I48P9sMFWB9jCEtxnB30U1elIr
         IWia0XufQSDbojpvX0Qqm4HsIVLx+rXcoHlg1ylsdZ95J/DEidA0iVZ7uFt/IOAw1ADM
         7SjD4Znwey0W7acDhSaX34Dj9hZLq+Uz/psaHDiLpLK2V1dUBX/Ni8bbDd4eEMl86vrn
         V/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784923024; x=1785527824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s3aQRJ9pWNGfFHIIohOKEOmVkaPLpONl6pYlOBOPmeA=;
        b=GOlNRONNTkj5AZG1f2kYb9UHbNYscRPorxtH+3eqMz1SHnjx7Qtd7BSjLrTAUXiAHc
         7AQ7Ux+Ybr7kzQfK1kP2qx+8x6kl70X9l9H4YhHKwP28bMnsURBN3inCA6gED09wFdph
         gCHxvvzHrHuA1GOQ4jmgGK0NvVEUNWGwuQj+K19yNjw5JGJiT73piSfe55RLWl/ryNN2
         e26JnL7bmK+WWAO4T644ihmtfzeHbXKLbYjCtQqMn0FZvBNJ+5+bfIaENWORC5nfvNnu
         dDnblR2jmyxfJGg7wlvSpyJ97iYJbomX0SKp3vYlsphxy/K6iRPRQ3r+W5p/9V2ve2QZ
         BA5Q==
X-Gm-Message-State: AOJu0Yz5Gdx4uaeNHJfyMp9vwaOImEjGRD8CpkDgADDb/IJdMfEKOiLI
	LXUBTUFrf2pJKQDveQyI3INcq73POHVs/z8vHlKCjKEVUPPMOXCud5Q/NWUSw/BHdY3FQoGmusN
	iwpA=
X-Gm-Gg: AR+sD11Dpb0Fsi6zcuVABgAQ4skfXNc2y4MuJrFjPiAwaFMYtpe/cbX75YpbLN9VFSt
	JFd9p0wy228fqhtuJ4PDPfrW4Byr6kXg51QuP89WcPUUm1QsvFROkVAkq9skgYwonjYjZ/lpd1I
	1sR1OQfQK8R2r2zSIfmMnWtf7fCwQ/NaDfCWhioYVnhYECTnRVHsqYfIszkPVeo/XEfcOiWsL0K
	fc5QpzVLxUM3Yu4fjwE5J7msvJzUVEhAeHhVqO6VeWzoGZIsu+n2HjWpWWuPt9gEdfXv23To6wP
	cGnbohkaFtI4pDj/RDOxB6bDdtFneSvpSEYSQ4q9MicnqTrkoW3YQwJlwemlv5tGJCxfeBfs+Yy
	+fxkUDxqu8T7TguTwARfOoLq8nDAoZVwAnAU1SMBol1LN7of5aL3Aqq/9y+veFmkSZRwhfV7g0y
	rHcm/iojFATxCOER11/lBMkF2oxaDzZ4LmPq1zsQbNjgLOUUo=
X-Received: by 2002:a05:622a:411a:b0:51a:8c9c:7f45 with SMTP id d75a77b69052e-5283df5304cmr82454491cf.72.1784923024321;
        Fri, 24 Jul 2026 12:57:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29cf8f6sm7167231cf.20.2026.07.24.12.57.01
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:57:02 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH 3/5] audit: move from a size_t buffer length to an int buffer length
Date: Fri, 24 Jul 2026 15:56:21 -0400
Message-ID: <20260724195626.327253-10-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724195626.327253-7-paul@paul-moore.com>
References: <20260724195626.327253-7-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5537; i=paul@paul-moore.com; h=from:subject; bh=NazMhb2KHGSWbXp+tBNRkQOva9cSeFcWCES359dd9iI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqY8N3OrilBfQfmmDlBOwlmxtl61Zo2B0mnsbxp N7ddUKnqiWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCamPDdwAKCRDqIPLalzeJ c3dyEACRSydQhdIOxOTohdBMPzmhMQzHTm7D4i5Jd1yAJB8peFbuTt3KPE5UEKNZTltBddTTcVl K/uNvvbnZOSVXwzyeYsd9/jQkNAdhDpZp3TAn3Hlm/PUQJnZZM/OMwW6viT0Iq+r1xB6XYjdyZh W8xqkIAuUArspEYBY9NnxP4B/TMZkkhpyNhw4oFhZGBwUZnp+tFOoQqdhWn5PKJnVziRJPfZQMJ gHk6u2LuNa0LVYDU7DrBicrP/Qr7zWUHBGpPh6d3+XYGRqkqP/s27Tugl61OO8lO9MIdsSYS38a VcynF4HFPRmpq/CREQ55rinHUSxoSHreAttyNgy63cN1dWGkvh5jW2qkeIqOuDOT0w5V67Kren9 rHZ27+OaTQ/krwZx26yz1uXDWQ8NES3TEX9a7exqRKdHfpnatyX6UsDDQvFQUoYpWBs9/t3swd4 oFzzBXxqmj3G+5GQlk2aLfaCLHFtDSVPspcfP85KnuWFURW3X2foJle/VP3Q3hVYAHiWZDVpDA/ nlsRDJQ9iLAuBLagrPx53hjRSfzULp+7cXxWi6RF2RC5KPLOcsZCRCQ+G1Km8lwkD0wJiM9nLgL SHy6nY4qRcId92IY7cegILuK7I2ollnHNAC2pct4HW1jqLF/m8LryNQC0gyzNclWCgarukRLW/6 dvtNVH9ZxFH+fMg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Currently the audit buffer is simply a sk_buff which is limited to an
unsigned int in length and we rely on pskb_expand_head() to grow the
buffer which is limited to a signed int for incremental growth.  Since
a 32-bit signed integer length value should be far more than we would
ever need (or want!) for an audit buffer, move all of the buffer length
types from 'size_t' to 'int' to reduce the potential for conversion and
overflow problems.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h | 18 ++++++++----------
 kernel/audit.c        | 37 +++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..d327113c913d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -172,16 +172,14 @@ extern __printf(2, 3)
 void audit_log_format(struct audit_buffer *ab, const char *fmt, ...);
 extern void		    audit_log_end(struct audit_buffer *ab);
 extern bool		    audit_string_contains_control(const char *string,
-							  size_t len);
+							  int len);
 extern void		    audit_log_n_hex(struct audit_buffer *ab,
-					  const unsigned char *buf,
-					  size_t len);
+					    const unsigned char *buf, int len);
 extern void		    audit_log_n_string(struct audit_buffer *ab,
-					       const char *buf,
-					       size_t n);
+					       const char *buf, int len);
 extern void		    audit_log_n_untrustedstring(struct audit_buffer *ab,
 							const char *string,
-							size_t n);
+							int len);
 extern void		    audit_log_untrustedstring(struct audit_buffer *ab,
 						      const char *string);
 extern void		    audit_log_d_path(struct audit_buffer *ab,
@@ -240,13 +238,13 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 static inline void audit_log_end(struct audit_buffer *ab)
 { }
 static inline void audit_log_n_hex(struct audit_buffer *ab,
-				   const unsigned char *buf, size_t len)
+				   const unsigned char *buf, int len)
 { }
-static inline void audit_log_n_string(struct audit_buffer *ab,
-				      const char *buf, size_t n)
+static inline void audit_log_n_string(struct audit_buffer *ab, const char *buf,
+				      int len)
 { }
 static inline void  audit_log_n_untrustedstring(struct audit_buffer *ab,
-						const char *string, size_t n)
+						const char *string, int len)
 { }
 static inline void audit_log_untrustedstring(struct audit_buffer *ab,
 					     const char *string)
diff --git a/kernel/audit.c b/kernel/audit.c
index 520244544907..9e10adf21c76 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2080,14 +2080,13 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
  * ascii hex digits. The new string is placed onto the skb.
  */
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
-		size_t len)
+		     int len)
 {
-	int avail;
-	size_t i, new_len;
+	int avail, new_len, i;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab)
+	if (!ab || len <= 0)
 		return;
 
 	BUG_ON(!ab->skb);
@@ -2109,22 +2108,21 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	for (i = 0; i < len; i++)
 		ptr = hex_byte_pack_upper(ptr, buf[i]);
 	*ptr = 0;
-	skb_put(skb, len << 1); /* new string is twice the old string */
+	skb_put(skb, new_len);
 }
 
 /*
- * Format a string of no more than slen characters into the audit buffer,
+ * Format a string of no more than len characters into the audit buffer,
  * enclosed in quote marks.
  */
 void audit_log_n_string(struct audit_buffer *ab, const char *string,
-			size_t slen)
+			int len)
 {
-	int avail;
-	size_t new_len;
+	int avail, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab)
+	if (!ab || len <= 0)
 		return;
 
 	BUG_ON(!ab->skb);
@@ -2132,7 +2130,7 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	avail = skb_tailroom(skb);
 
 	/* enclosing quotes + null terminator */
-	if (check_add_overflow(slen, 3, &new_len)) {
+	if (check_add_overflow(len, 3, &new_len)) {
 		audit_log_format(ab, "?");
 		return;
 	}
@@ -2144,11 +2142,11 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	}
 	ptr = skb_tail_pointer(skb);
 	*ptr++ = '"';
-	memcpy(ptr, string, slen);
-	ptr += slen;
+	memcpy(ptr, string, len);
+	ptr += len;
 	*ptr++ = '"';
 	*ptr = 0;
-	skb_put(skb, slen + 2);	/* don't include null terminator */
+	skb_put(skb, len + 2); /* don't include null terminator */
 }
 
 /**
@@ -2156,9 +2154,13 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
  * @string: string to be checked
  * @len: max length of the string to check
  */
-bool audit_string_contains_control(const char *string, size_t len)
+bool audit_string_contains_control(const char *string, int len)
 {
 	const unsigned char *p;
+
+	if (!string || len <= 0)
+		return false;
+
 	for (p = string; p < (const unsigned char *)string + len; p++) {
 		if (*p == '"' || *p < 0x21 || *p > 0x7e)
 			return true;
@@ -2181,8 +2183,11 @@ bool audit_string_contains_control(const char *string, size_t len)
  * or may not be the entire string.
  */
 void audit_log_n_untrustedstring(struct audit_buffer *ab, const char *string,
-				 size_t len)
+				 int len)
 {
+	if (len <= 0)
+		return;
+
 	if (audit_string_contains_control(string, len))
 		audit_log_n_hex(ab, string, len);
 	else
-- 
2.55.0

