Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462D2459CF
	for <audit@vger.kernel.org>; Mon, 23 Mar 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278436; cv=none; b=jrYc6uIglml0NTNWlaB9VKVC3xfGDxuJMkHo91oYgGPj+SwlFFmju9sfMh2iZ53W/N2nuMBMMMHDcxoBMMfO8dQzmVSPfqQlbkkjeq0GLqQkw0u2PjACrWnXKEJpC0+B2D2nycTct2uZok+NfyfQ51E+nybs28KR/mMGay/kg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278436; c=relaxed/simple;
	bh=ctbSyjJhDK/6JMSb8se0VIfNJtyEXGfufGl45tNk+NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SgZlT7EC1e6F0Dc+s2WNMJwnwEk4yFBXTQlDSpbGZS1uk7ijlxHrhg/Q/CdJd4gjhoYD7nfIbFZWxoFCM7RP5SnM8T0Usaogapc5X754Q3jS7D5dAwgqlvJfKXpDZql7/IDEUCZUKcnGFtfXRuPqc9J6n6MxG1qWOoaZhXomWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gc+akwi4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc+akwi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xsX5cqha603gaYoG7s3kCY4RkygEZN0OAYZ9r1MQrvA=;
	b=gc+akwi42+wC/pl6K4ABrA0M4VaQynbg7dHqAL7QgcVSVz7UEw2u0E5KHRBZQP/N9cQTI+
	sXFjJmLqMd+YzDNBIviMTRJiaSDBjGoUQDknXHQZFQ2TwhgG6A/Qbqn8VJnYtRa+fb3IY0
	R6h0xWnNFlP58j5YqoLqvSmLkxdO9Bs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-Xz1nttAlM5azKEaCoZTLvA-1; Mon,
 23 Mar 2026 11:07:08 -0400
X-MC-Unique: Xz1nttAlM5azKEaCoZTLvA-1
X-Mimecast-MFC-AGG-ID: Xz1nttAlM5azKEaCoZTLvA_1774278426
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABB5C1955D78;
	Mon, 23 Mar 2026 15:07:06 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C04C18005AE;
	Mon, 23 Mar 2026 15:07:03 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add backlog high water mark metric
Date: Mon, 23 Mar 2026 12:07:00 -0300
Message-ID: <20260323150700.614139-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 23jwU8Ue-pcyNFGGZyy8k7k88GoTdpwMb88idfF3sR8_1774278426
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, determining the optimal `audit_backlog_limit` relies on
instantaneous polling of the queue size. This misses transient
micro-bursts, making it difficult for system administrators to know
if their queue is adequately sized or if they are at risk of
dropping events.

This patch introduces `backlog_max_depth`, a high-water mark metric
that tracks the maximum number of buffers in the audit queue since
the system was booted or the metric was last reset. To minimize
performance overhead in the fast-path, the metric is updated using
a lockless cmpxchg loop in `__audit_log_end()`.

Userspace can read-and-clear this metric by sending an `AUDIT_SET`
message with the `AUDIT_STATUS_BACKLOG_MAX_DEPTH` mask. To support
periodic telemetry polling (e.g., statsd, Prometheus), the reset
operation atomically returns the snapshot of the high-water mark
right before zeroing it, ensuring no peaks are lost between polls.

Link: https://github.com/linux-audit/audit-kernel/issues/63
Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/audit.h      |  3 ++-
 include/uapi/linux/audit.h |  2 ++
 kernel/audit.c             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index d79218bf075a..53132b303c20 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -22,7 +22,8 @@
 			  AUDIT_STATUS_BACKLOG_LIMIT | \
 			  AUDIT_STATUS_BACKLOG_WAIT_TIME | \
 			  AUDIT_STATUS_LOST | \
-			  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)
+			  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL | \
+			  AUDIT_STATUS_BACKLOG_MAX_DEPTH)
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..862ca93c0c31 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -355,6 +355,7 @@ enum {
 #define AUDIT_STATUS_BACKLOG_WAIT_TIME		0x0020
 #define AUDIT_STATUS_LOST			0x0040
 #define AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL	0x0080
+#define AUDIT_STATUS_BACKLOG_MAX_DEPTH		0x0100
 
 #define AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT	0x00000001
 #define AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME	0x00000002
@@ -486,6 +487,7 @@ struct audit_status {
 	__u32           backlog_wait_time_actual;/* time spent waiting while
 						  * message limit exceeded
 						  */
+	__u32		backlog_max_depth; /* message queue max depth */
 };
 
 struct audit_features {
diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..256053cb6132 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -163,6 +163,9 @@ static struct sk_buff_head audit_retry_queue;
 /* queue msgs waiting for new auditd connection */
 static struct sk_buff_head audit_hold_queue;
 
+/* audit queue high water mark since last startup or reset */
+static atomic_t audit_backlog_max_depth __read_mostly = ATOMIC_INIT(0);
+
 /* queue servicing thread */
 static struct task_struct *kauditd_task;
 static DECLARE_WAIT_QUEUE_HEAD(kauditd_wait);
@@ -1286,6 +1289,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		s.backlog		   = skb_queue_len(&audit_queue);
 		s.feature_bitmap	   = AUDIT_FEATURE_BITMAP_ALL;
 		s.backlog_wait_time	   = audit_backlog_wait_time;
+		s.backlog_max_depth	   = atomic_read(&audit_backlog_max_depth);
 		s.backlog_wait_time_actual = atomic_read(&audit_backlog_wait_time_actual);
 		audit_send_reply(skb, seq, AUDIT_GET, 0, 0, &s, sizeof(s));
 		break;
@@ -1399,6 +1403,12 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			audit_log_config_change("backlog_wait_time_actual", 0, actual, 1);
 			return actual;
 		}
+		if (s.mask == AUDIT_STATUS_BACKLOG_MAX_DEPTH) {
+			u32 old_depth = atomic_xchg(&audit_backlog_max_depth, 0);
+
+			audit_log_config_change("backlog_max_depth", 0, old_depth, 1);
+			return old_depth;
+		}
 		break;
 	}
 	case AUDIT_GET_FEATURE:
@@ -2761,6 +2771,25 @@ int audit_signal_info(int sig, struct task_struct *t)
 	return audit_signal_info_syscall(t);
 }
 
+/*
+ * audit_update_backlog_max_depth - update the audit queue high water mark
+ *
+ * Safely updates the audit_backlog_max_depth metric using a lockless
+ * cmpxchg loop. This ensures the high-water mark is accurately tracked
+ * even when multiple CPUs are logging audit records concurrently.
+ */
+static inline void audit_update_backlog_max_depth(void)
+{
+	u32 q_len = skb_queue_len(&audit_queue);
+	u32 q_max = atomic_read(&audit_backlog_max_depth);
+
+	while (unlikely(q_len > q_max)) {
+		if (likely(atomic_try_cmpxchg(&audit_backlog_max_depth,
+					      &q_max, q_len)))
+			break;
+	}
+}
+
 /**
  * __audit_log_end - enqueue one audit record
  * @skb: the buffer to send
@@ -2777,6 +2806,9 @@ static void __audit_log_end(struct sk_buff *skb)
 
 		/* queue the netlink packet */
 		skb_queue_tail(&audit_queue, skb);
+
+		/* update backlog high water mark */
+		audit_update_backlog_max_depth();
 	} else {
 		audit_log_lost("rate limit exceeded");
 		kfree_skb(skb);
-- 
2.53.0

