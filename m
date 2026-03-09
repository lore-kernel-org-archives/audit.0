Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65251E3DED
	for <audit@vger.kernel.org>; Mon,  9 Mar 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061547; cv=none; b=TMkcPYn58ziZEIIQUGVkz37RRc/3KfKxCWixMe3yUbBCyhOytCI0+os2GO06Hw87HkAGSUC06qHKRt8UYMimq38XliEHT8IRooxrPFNjYc0rEo8Nb+lxPp5P9F+rP/cezRUclyprodxI5VXGr3GFYw3zRN9eXU/6FsBvMrrneQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061547; c=relaxed/simple;
	bh=BN6CNYDcs10KPHUi+3USETGYu398TkBNcKua7PLZ0nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tRCWML0ACtAypyWa5LEeYj9OHneWkQyHkRcoaeXlQy1rde+YZCK62DnA/WfE/jFQrlHKpgUeKPu4XXlO1/XjjHEi/8AudYQ2BkSodm+AxRdfO6wEa06KdA9Aypf85WP9WpYRQVLfnKATB7EjsInvzDnSBmNZYZ3TlCE3LbFPnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvAWi8eY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvAWi8eY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773061544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XwyqZ9Vx6kvwiEtIowwrQwuy7UsMOdl+r6xAE+z2X54=;
	b=fvAWi8eYTlfEIif/ELR9fb410QRsySNRY2SVeU/Ump+FuBO0RlIwTVYNbGn5vdc5iE6yRl
	XC/O3GzK6tfJF03dvrYpPxyoDwBOkKf+2cwHAy4Lq216ux5ubf/JRbCEtvWYoyDNZk65BK
	r89iSmT9Kzsrx/3BQU9Wt787Eg9+Zc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-5Q0AXoHVP5KcIfj9T2q1Aw-1; Mon,
 09 Mar 2026 09:05:41 -0400
X-MC-Unique: 5Q0AXoHVP5KcIfj9T2q1Aw-1
X-Mimecast-MFC-AGG-ID: 5Q0AXoHVP5KcIfj9T2q1Aw_1773061540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 524EA1956080;
	Mon,  9 Mar 2026 13:05:40 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A86883002D0D;
	Mon,  9 Mar 2026 13:05:37 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>,
	Steve Grubb <sgrubb@redhat.com>
Subject: [PATCH v2] audit: handle unknown status requests in audit_receive_msg
Date: Mon,  9 Mar 2026 10:05:33 -0300
Message-ID: <20260309130533.158095-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: xFb7hyP7C7nNSjMbrh3iaqJLCTNNDSZNCSSeX5G7PhE_1773061540
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
requests, incorrectly returning success to newer user space tools
querying unsupported features. This breaks forward compatibility.

Fix this by defining AUDIT_STATUS_ALL and returning -EINVAL if any
unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
This ensures invalid requests are safely rejected, allowing user space
to reliably test for and gracefully handle feature detection on older
kernels.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
v1 -> v2:
 - Moved AUDIT_STATUS_ALL from include/uapi/linux/audit.h to 
   include/linux/audit.h.

 include/linux/audit.h | 9 +++++++++
 kernel/audit.c        | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b642b5faca65..d79218bf075a 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -15,6 +15,15 @@
 #include <uapi/linux/audit.h>
 #include <uapi/linux/fanotify.h>
 
+#define AUDIT_STATUS_ALL (AUDIT_STATUS_ENABLED | \
+			  AUDIT_STATUS_FAILURE | \
+			  AUDIT_STATUS_PID | \
+			  AUDIT_STATUS_RATE_LIMIT | \
+			  AUDIT_STATUS_BACKLOG_LIMIT | \
+			  AUDIT_STATUS_BACKLOG_WAIT_TIME | \
+			  AUDIT_STATUS_LOST | \
+			  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)
+
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
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

