Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28922372B50
	for <audit@vger.kernel.org>; Mon,  1 Jun 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319403; cv=none; b=IK0vALblIYSqKU+KZBgAh+OFNemzWxO+Pb2/XmKt2fKY2Ladyc3kEHiyMxqaLXSWutpyBbSULwaUkwg14Kfivgs7ZWME9x/C6VmQfv0AQBfTTkOjCGqzhNlzBLKwkGwUJO4hJ3ULlwOxWfmo9YRm6TMDd1x8L/vskA/0iNxb+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319403; c=relaxed/simple;
	bh=dUQMe8RYsEim0yflWr4RJYM7j+Usyeh0odWhq78B53M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rwCtZ9nKw7LYhHhnTUFfUZ7V9Eg/9vJwK5C/7lYz1iWjb+Ak/YoEemQEKxfhua2ki4QMXSSFuCpFrM6WtIVhdSiP1DQvTqVSQQXlOzKhw8CR4LutsTCEEmrg+i+QjE2cd/gIc0mnV4C8XpZD5Dihh/MVi2bUriWnRaPS09x5uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbEFEEhh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbEFEEhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780319401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AzlDbbWjoolDuJmhmsMNkl0Iw2s8twMo0nzg8/FUyF4=;
	b=XbEFEEhhAVhc0gFTU6pWjde5XhC3qbo4q6FNBruTJ7IHzrl0O7xbA/77+ocMa9rx+dqvtF
	NC2ht4VrhTNx+pgEe1m/Bcvd6abM2szUrZ8eHPSYCbCq4Q3FmAyhDq0lHvmE+Ip8FBlsOB
	Dn1947JJMS6buGv1lYqVudkrVdqhWD4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-CoIxfyLGOTeA0NJS29bSaQ-1; Mon,
 01 Jun 2026 09:09:59 -0400
X-MC-Unique: CoIxfyLGOTeA0NJS29bSaQ-1
X-Mimecast-MFC-AGG-ID: CoIxfyLGOTeA0NJS29bSaQ_1780319398
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9952618005B5;
	Mon,  1 Jun 2026 13:09:58 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70C501956095;
	Mon,  1 Jun 2026 13:09:56 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: fix potential integer overflow in audit_log_n_hex()
Date: Mon,  1 Jun 2026 10:09:51 -0300
Message-ID: <20260601130951.1418695-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: iFngtAkzojhJaB65eQA3Sfjv-mbQGR1kQx3iMXDRaUg_1780319398
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
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Use check_shl_overflow() instead of manual overflow check.

 kernel/audit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..8ca268610641 100644
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
 
@@ -2084,9 +2086,13 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		return;
 
 	BUG_ON(!ab->skb);
+
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+
+	if (check_shl_overflow(len, 1, &new_len))
+		return;
+
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
-- 
2.53.0

