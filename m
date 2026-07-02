Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975754ADD87
	for <audit@vger.kernel.org>; Thu,  2 Jul 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001064; cv=none; b=ZMJN5tyQVVQDD3bu7gHbHBgd/QHH+VljZhJNWTCUi+ttGAzY3NudTHzcoZ1hThrwOj1tVBHEImZ8UF1w2XE/H0ksnt2S+sUuZNQaAKgr8Pm4z1QHHZMy9AiqntndVDxjrHqUzYaKWpLiP/fKBx1fB9upNFsg6W4QlpXIPf7PUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001064; c=relaxed/simple;
	bh=h7r4bj9XBmBGhZtZnRMqd0IcQyBJvh05nMqNpjkPEaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=I3Jm3qsGPAJz4Wq1hhC/4+wpLXxyw+cKrONns84rLhZvSm6fXk6GWxhn6amrYrL5wM3dFfa9320xRtjGaJHnzwtu6RHh6kJJuL8/E8DC+Q1DrLiUsVKMjU22C2JNFlwqKRy8U17LuyIzJKN8bbbc7ql4cOBWjDaSE6Wd61J19sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFOe4MrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFOe4MrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783001062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aNWsbqtUS5+uQXhPAE+XTy+9YZezBuU727X0UpkOd6k=;
	b=KFOe4MrDD69j8gmFTspMfBX/mTJ6ka41zMbPSrRsT8xvhusO86ibBNy9ryqY6ubiD344vz
	9+9bxUTJDDvKIQq4gLM/W5wn3oUbPBkTzNhRNU3mDGLYfvZ5AjTqGMiOYR5MjG/+9fkHYk
	6kdSB+eaXDJG+E7H0bE8S122e+62oTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-JFwXBTTxMt-NRHs9gCpKPQ-1; Thu,
 02 Jul 2026 10:04:20 -0400
X-MC-Unique: JFwXBTTxMt-NRHs9gCpKPQ-1
X-Mimecast-MFC-AGG-ID: JFwXBTTxMt-NRHs9gCpKPQ_1783001060
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA641944B2F;
	Thu,  2 Jul 2026 14:04:19 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.69])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C7A0180056E;
	Thu,  2 Jul 2026 14:04:16 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v3] audit: fix potential integer overflow in audit_log_n_hex()
Date: Thu,  2 Jul 2026 11:04:11 -0300
Message-ID: <20260702140411.1021373-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: w27JhgOQ08TOq6EsDaGiMOfXSvOqsUPtOOLEf6s598s_1783001060
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The function calculates new_len as len << 1 for hex encoding. This
has two overflow risks: the shift itself can overflow when len is
large, and the result can be truncated when assigned to new_len
(declared as int) from the size_t calculation.

Fix by using check_shl_overflow() to catch shift overflow and
changing new_len and loop counter i to size_t to prevent truncation.

Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Use check_shl_overflow() instead of manual overflow check.
Changes in v3:
- Log "?" before returning when overflow detected.

 kernel/audit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..52eb3b511bad 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,6 +62,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <linux/sctp.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2076,7 +2077,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2084,9 +2086,15 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		return;
 
 	BUG_ON(!ab->skb);
+
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+
+	if (check_shl_overflow(len, 1, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
-- 
2.53.0

