Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C691364AE
	for <audit@vger.kernel.org>; Tue,  3 Dec 2024 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195920; cv=none; b=RS6Xz/X7hI1Ul1CyLSneC/es+AFQl8jOdi0aTcrcI9juGodlbOj6jLzYmsVww2V6d+5kD7PAKByGVSV07kZjnk30hfDjNNduQCiVA7eQ37drZg4Uty+QLSTB5X1Ol0MClxuxvpfBHJCuBEsISZe9xqwKBltePUbAZBd9xVsrB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195920; c=relaxed/simple;
	bh=pBESehOlVOztmy7OpvqIuojMwaY3SGlPVe1Qbpm5Z2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kn+aDd8KDomzwX4l3sWhH66R/ICPbNx4+4HAAePBucT8CRdIzeee+DlP3RifMB9wRKFiQIpPIF4ujLmxVpauuTcespC1ohIfoywA5WYVfMEV3vjlAUaCF9lU+mh+o4DpDXh1NSt6bfxlX+reh6F/FDesnXttzS8+8ZwHEM4q+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZABT2F5n; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZABT2F5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o6wnr
	AnxXadBTsSr/dJONMpHmD6/CZwwGWOePYwfjbU=; b=ZABT2F5nM8YOgA5fmEnEO
	716nSJM4ySBRdOi/dQ5ve3eCiVnMhbOaKpm6FcCwPeVxj1bGZWFVdxwnr4I8dajq
	6oZ4IUTC6WotdFxxGHfDcav/7ogmhN8IudPgnw/F3gYOLJAnv2IBr9ux48O3lIq/
	mpZYwqcIJp9FJdKadfgTb8=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXj46BeE5ndS5NDw--.29531S2;
	Tue, 03 Dec 2024 11:18:26 +0800 (CST)
From: 15074444048@163.com
To: audit@vger.kernel.org,
	paul@paul-moore.com,
	eparis@redhat.com
Cc: lihaojie <lihaojie@kylinos.cn>
Subject: [PATCH] kernel/audit: Use __struct_size replace __member_size
Date: Tue,  3 Dec 2024 11:18:36 +0800
Message-Id: <20241203031836.639765-1-15074444048@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXj46BeE5ndS5NDw--.29531S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrykKFWxZw4fWw4fXw13Arb_yoWftrX_Cw
	n3tr18Cr4fX343tw1ftF90qr1Fka17Gryqgw1fZF12q34DJan8CFyrZrZ29rsrGw4kJryf
	X3WrW347Ja13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnAsqtUUUUU==
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/xtbBDgqpUGdNklvdRAABsG

From: lihaojie <lihaojie@kylinos.cn>

Size of destnation less of the size to be written will
make future warnings, the size of destnation should be
complete

Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---
 include/linux/fortify-string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..0504b2c8aab7 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -277,7 +277,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strsc
 __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
-	const size_t p_size = __member_size(p);
+	const size_t p_size = __struct_size(p);
 	const size_t q_size = __member_size(q);
 	size_t len;
 
-- 
2.25.1

