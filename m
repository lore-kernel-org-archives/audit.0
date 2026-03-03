Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019C34C9A3
	for <audit@vger.kernel.org>; Tue,  3 Mar 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541777; cv=none; b=ceDahDkBHMAV8XCDQNVdOhEuyWrEwZOjWb/XTg8PZAB4GI5WwhqxsyD7eVvFHdfiD4p5KVIpxK89NBsaD97GOAkZTHHFvG10kvbYksEoeBK6icTHtaQ8Zvb7QPQJNug1DvbmLA8PiBqbE6VO59te/pZm6AYWntWc1EOXXiV6REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541777; c=relaxed/simple;
	bh=tgRcLlRr25RtwK7j91Rxht6tzcoptzSZ20+IdLZCyIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=X2PqEz3AyrZZCtmaHrrF7K0Dr6JUK+i3uTO5q2+8Mo0A03P7W6Ak3It0U4wlFm/uQvS3kNawEv2EqS9zoSHZ++oOasZA2YKTsiJsQ55/ZUDvYRNlhqIbfZPYGI+Y67wMR3PnhgykeloxQmkJc6peopWMg1PEFWLrUWpZwiMSy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2OREwO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2OREwO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2CrLl4FFEc4KtEmJ8pm2WRGeOHijmj5dBXHI72SXGrU=;
	b=e2OREwO5KwzxnOLSSQx1rz6VaUyuwY30BdURXsPxIQTVR44orS2faFZBsXFaoAuwa9R9uu
	2bZAjqkRuuP8a5iAIIs5yHbubE39SMb1ktlHeBHUzdEzfSK4ojovvbSMuwC+4XKBqPhjEx
	WLrRT8TW6rn8ivizFKnsD2ggfAntTWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-6mJb__nyO1irAcPN4shbFQ-1; Tue,
 03 Mar 2026 07:42:52 -0500
X-MC-Unique: 6mJb__nyO1irAcPN4shbFQ-1
X-Mimecast-MFC-AGG-ID: 6mJb__nyO1irAcPN4shbFQ_1772541771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FF0D19560A7;
	Tue,  3 Mar 2026 12:42:51 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9D541800348;
	Tue,  3 Mar 2026 12:42:48 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: handle unknown status requests in audit_receive_msg
Date: Tue,  3 Mar 2026 09:42:29 -0300
Message-ID: <20260303124229.700524-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 2Codn4mbh5vvMi-BxSSsBBrtPYOQnZup66d4IUsIMzk_1772541771
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
requests, incorrectly returning success to newer user space tools
querying unsupported features. This breaks forward compatibility.

Fix this by defining AUDIT_STATUS_ALL in the UAPI header and returning
-EINVAL if any unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
This ensures invalid requests are safely rejected, allowing user space
to reliably test for and gracefully handle feature detection on older
kernels.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/uapi/linux/audit.h | 9 +++++++++
 kernel/audit.c             | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 14a1c1fe013a..1d5122b9274a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -356,6 +356,15 @@ enum {
 #define AUDIT_STATUS_LOST			0x0040
 #define AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL	0x0080
 
+#define AUDIT_STATUS_ALL (AUDIT_STATUS_ENABLED | \
+			  AUDIT_STATUS_FAILURE | \
+			  AUDIT_STATUS_PID | \
+			  AUDIT_STATUS_RATE_LIMIT | \
+			  AUDIT_STATUS_BACKLOG_LIMIT | \
+			  AUDIT_STATUS_BACKLOG_WAIT_TIME | \
+			  AUDIT_STATUS_LOST | \
+			  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)
+
 #define AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT	0x00000001
 #define AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME	0x00000002
 #define AUDIT_FEATURE_BITMAP_EXECUTABLE_PATH	0x00000004
diff --git a/kernel/audit.c b/kernel/audit.c
index 5a0216056524..592383dce090 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1295,6 +1295,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		memset(&s, 0, sizeof(s));
 		/* guard against past and future API changes */
 		memcpy(&s, data, min_t(size_t, sizeof(s), data_len));
+		if (s.mask & ~AUDIT_STATUS_ALL)
+			return -EINVAL;
 		if (s.mask & AUDIT_STATUS_ENABLED) {
 			err = audit_set_enabled(s.enabled);
 			if (err < 0)
-- 
2.53.0

