Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36474280018
	for <audit@vger.kernel.org>; Wed, 13 May 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677738; cv=none; b=QYkQqgrtb1le6N+VK9VGRgAg9e8z+ByFJL+wjJ3M8dvqQF4Q2jsCv5eGUYnmYsIGl926Gg4KBSkV8sP66rD2hVIzRN0WdGgx/moEeWrhXJ9p8GRuN2oVhjPgq1El4up/CVOpA1xOkI3hnkVTvTa2+Z0/sRWG4txgpSz2JvRvXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677738; c=relaxed/simple;
	bh=CziVjmmpWOJL9teb/NgjnK52j5fN7O0SUD+zzjOT3Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=WFalJgDMr4xhfeJvd8yUkAXQQj6tqA77geT0wspNuHCZ6/YzQ04lGHMmQEi56lrW8GTWQhRVXVoukMPSFlhP+zuAZ1tIFyp04bXRPDkTvaLWBRrkQbzptlf+nlivovbocEDmO/K/nITvQtW0Ut6bJAelFxaeHGQlsgsDkvq8Shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inmv7UKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inmv7UKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778677736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwog4+kBzFchlLFOSm4JLyZbbRXhurwsOUlD9WLqcHw=;
	b=inmv7UKVsuqBVQmpmLSDPstzdIMJlpefaHf4DU5Ni/iDp9aaKCYOuqBHZmeYWGIUEtP5lN
	gm1nxx9i0buB6MXwtPZC2WdPOV3OOab6cW2GPy3fpCe+fyzrvaHEZ8nmFBVcQKV/qWA/cb
	QuoHAWM4CKuRotXN2I89K+0KlB1ENoM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-vcxpttZeP--FYSu6K_5rfQ-1; Wed,
 13 May 2026 09:08:51 -0400
X-MC-Unique: vcxpttZeP--FYSu6K_5rfQ-1
X-Mimecast-MFC-AGG-ID: vcxpttZeP--FYSu6K_5rfQ_1778677729
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A02B018005BA;
	Wed, 13 May 2026 13:08:49 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.76])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EC1B1955D84;
	Wed, 13 May 2026 13:08:47 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: fix potential integer overflow in audit_log_n_hex()
Date: Wed, 13 May 2026 10:08:43 -0300
Message-ID: <20260513130843.790380-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: GUpMpokQjeAYEFgila48tEdrDUGJ7RLnXEpJdKfCKzc_1778677729
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The function audit_log_n_hex() calculates new_len as len << 1 to
account for hex encoding, where each byte becomes two characters.
However, when len is passed as size_t but new_len was declared as
int, this could lead to integer overflow for large values of len.

Additionally, the bit shift operation itself could overflow if len
exceeds SIZE_MAX / 2, leading to incorrect buffer size calculations
and potential memory corruption.

Fix this by changing new_len and loop counter i from int to size_t
to match the len parameter type, preventing signed/unsigned mismatches,
and by adding an overflow check before the bit shift operation that
calculates len << 1.

Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..32ac50996451 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2076,7 +2076,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2084,9 +2085,14 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		return;
 
 	BUG_ON(!ab->skb);
+
+	/* prevent new_len overflow */
+	if (len > SIZE_MAX / 2)
+		return;
+
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+	new_len = len << 1;
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
-- 
2.53.0

