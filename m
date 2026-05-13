Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161864DBD71
	for <audit@vger.kernel.org>; Wed, 13 May 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693112; cv=none; b=oPxVoxf7baUkr0VkV+OdmCN/QzcAB/Yw5qGIx/HpJzdf38I6Ua4c++9JIScQS8OxTUh7cAtDYzmaVhw8W45XaqORP6EOqauQ7yPQCnICNnq6xJC0OjgqTFCWO2jdhJvh/7q19/jo9QdV8LiH1rbrTKnCnOYuSmHm3W3tQ4oAvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693112; c=relaxed/simple;
	bh=0l3K1Vx6dDHrT4K/Ky69g1F83Rx5pkBVmYmgs7DnxK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=iEF6XUCFF0YDLgV5yjJg0WFxUziA1RbRgoCyOqdPnbBjGRF7wdml/og35xNNSX8n3xJzH3vXoQ3ZVBrZd8qzJvoXck0j5uzrJLbcmE5U02USzfGV6yb83Qcd8BeNrRNX2/mQ1p03afSeB1VICOdUuCylZqTi7GE+Xs0hCGYs9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XazGHxj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XazGHxj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778693110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P6Gxt0Syx0btkQxNHujdK6tAvcgI3DJpQWuCddcKTlE=;
	b=XazGHxj/SA0UoxoN2VotKCsjZ2/WcsJSgksa01hiDeXl6sp3ZP0VIjJywQ3pZeSpQwjbTp
	e/8s2a/UfWG1Dna3UxCQnfcmqGEClGtp5AdK0/6c4HOItodBQlcf6Vs8CE0mld33nV9UQS
	PXZyYxjGLowa/FReH3sa4I901Aonq+U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ajT9Fg5hMFel42STe0JZeg-1; Wed,
 13 May 2026 13:25:08 -0400
X-MC-Unique: ajT9Fg5hMFel42STe0JZeg-1
X-Mimecast-MFC-AGG-ID: ajT9Fg5hMFel42STe0JZeg_1778693107
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B84D1800372;
	Wed, 13 May 2026 17:25:07 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2678F300019F;
	Wed, 13 May 2026 17:25:02 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>,
	Steve Grubb <sgrubb@redhat.com>
Subject: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
Date: Wed, 13 May 2026 14:24:43 -0300
Message-ID: <20260513172443.1128496-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: At74HaA3D7l1i2bjP1EA-hWfQ76odGCkaFWynRoXFTE_1778693107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
the netlink socket. If the wait timeout fully expires (timeo == 0),
netlink mistakenly interprets the zeroed timeout as a non-blocking
request. It then triggers netlink_overrun that drops the event,
completely bypassing the audit subsystem's internal retry queue, and
falsely returns ENOBUFS to user-space, resulting in the following error:

 auditd[]: Error receiving audit netlink packet (No buffer space available)

Fix this by detecting when a blocking sender's timeout has expired
(timeo == 0 && !nonblock) in netlink_unicast(). In this case, instead
of retrying with timeo=0 (which would incorrectly trigger netlink_overrun
on the next iteration), safely free the skb and return -EAGAIN, allowing
the audit subsystem to gracefully enqueue the pending event into its
internal backlog.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Use the simple check (timeo == 0 && !nonblock) to detect
  expired timeout, avoiding adding a new NETLINK flag.

 net/netlink/af_netlink.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d..fdc3db74b178 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1351,8 +1351,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	err = netlink_attachskb(sk, skb, &timeo, ssk);
-	if (err == 1)
+	if (err == 1) {
+		/* timeo may have been zeroed by schedule_timeout inside
+		 * netlink_attachskb. If the caller is a timed-blocking sender
+		 * (not genuinely nonblocking), don't re-enter with timeo=0 as
+		 * that would misfire netlink_overrun on the next iteration.
+		 */
+		if (timeo == 0 && !nonblock) {
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
 		goto retry;
+	}
 	if (err)
 		return err;
 
-- 
2.53.0

