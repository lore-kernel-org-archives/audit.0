Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745A19E96D;
	Fri, 14 Aug 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669318; cv=none; b=V2sN8fPePpHJpdA2kyaZRZVYc5RhBEi7RUePyaK+A0DDF+FsE4vwrXXo6wwNaVbDTIxz11N8QHjaOKO0M6u9q7efImXSq5f9SHdgKhdc0pKeEKlX2i0HET14oKNCwGvS9aFKKSKNB4pGqJJJr8w8EZi6n6pFNlKdo8Dmw2C8+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669318; c=relaxed/simple;
	bh=U+mSd5DHg9B8Hn2jMY8J2ssOVEwh2BWGi52gwmqVCtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDeFX22UcKXv4+ASdxQQDclLltrVG6/GmdrBr/UNlVUtDSmMG80hbgHV9G44ibRzrxrQ3vSFssNw+CqIeWdN718TSShbvpxooEkXoRwKtlSRR1BflAXF0YrLlHM5nBgyMllQ10zIkU/1BE5UUOiIzz4d+6vFSvVlwMTImLPNPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=FpVY+QIu; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="FpVY+QIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786669313;
	bh=68Ce3a4iVPeq7cxdQLaiKYY+kbBwOzThBP2M+XYXM4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=FpVY+QIuLWXwq4F+9DLpI/NsXXDwBMwypppKbRI7u0eXL+6U3tIlcp6UKBkeOMf+7
	 M/E4ixVHSFfFjkBSCXuOaRN7Mh8Z+W66PlXcLhBRVCIcG7atVIwxSZR4AMG4GG/85W
	 B+okpWQmlMEFvYDEvTcp1l7bfp+FzEhtV/E1cB4E=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hLkTF3KGGz6vGB;
	Fri, 14 Aug 2026 01:01:53 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hLkTF0V0mz4y6W;
	Fri, 14 Aug 2026 01:01:53 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() to send time
Date: Fri, 14 Aug 2026 01:01:53 +0000
Message-ID: <20260814010153.14488-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now the auditd breakage (nlmsg_len gets set to the payload
length instead of the full message length) is applied when the record
is queued, in __audit_log_end(). That is why
kauditd_send_multicast_skb() has to deep copy every record and then
undo the length on the copy, just so the multicast group still sees a
standard netlink message.

So flip it: finalize the header with the standard full length at
queue time, and apply the auditd length at send time in
kauditd_send_queue(), right before the unicast. Records stay standard
netlink messages the whole time they sit in the queues, and the
multicast copy stops needing its own fixup. The copy itself stays,
because the rewrite still lands in the data region the listeners
already hold.

auditd sees the same bytes as before: the fixup is computed from
skb->len and that does not change between queueing and sending, so
records that come back around through the retry and hold queues get
the same value again. Reply and rule list skbs are built with
nlmsg_put() and go out on their own paths, none of that is touched.

This came out of reviewing Ricardo's "use copied skb length" patch,
where I suggested moving the fixup as the more interesting cleanup.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Tested-by: Ricardo Robaina <rrobaina@redhat.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
Link: https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.com
---
 kernel/audit.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..bcfed6e3678e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 		if (skb_hook)
 			(*skb_hook)(skb);
 
+		/*
+		 * auditd wants nlmsg_len to be the payload length, not the
+		 * full length, so break it here at send time.
+		 */
+		nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;
+
 		/* can we send to anyone via unicast? */
 		if (!sk) {
 			if (err_hook)
@@ -849,7 +855,6 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 {
 	struct sk_buff *copy;
 	struct sock *sock = audit_get_sk(&init_net);
-	struct nlmsghdr *nlh;
 
 	/* NOTE: we are not taking an additional reference for init_net since
 	 *       we don't have to worry about it going away */
@@ -858,20 +863,12 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 		return;
 
 	/*
-	 * The seemingly wasteful skb_copy() rather than bumping the refcount
-	 * using skb_get() is necessary because non-standard mods are made to
-	 * the skb by the original kaudit unicast socket send routine.  The
-	 * existing auditd daemon assumes this breakage.  Fixing this would
-	 * require co-ordinating a change in the established protocol between
-	 * the kaudit kernel subsystem and the auditd userspace code.  There is
-	 * no reason for new multicast clients to continue with this
-	 * non-compliance.
+	 * skb_copy() rather than skb_get(): kauditd_send_queue() breaks
+	 * nlmsg_len for auditd, keep the listeners on a standard message.
 	 */
 	copy = skb_copy(skb, GFP_KERNEL);
 	if (!copy)
 		return;
-	nlh = nlmsg_hdr(copy);
-	nlh->nlmsg_len = skb->len;
 
 	nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
 }
@@ -2785,13 +2782,12 @@ int audit_signal_info(int sig, struct task_struct *t)
  */
 static void __audit_log_end(struct sk_buff *skb)
 {
-	struct nlmsghdr *nlh;
-
 	if (audit_rate_check()) {
-		/* setup the netlink header, see the comments in
-		 * kauditd_send_multicast_skb() for length quirks */
-		nlh = nlmsg_hdr(skb);
-		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
+		/*
+		 * Records are built without keeping nlmsg_len up to date,
+		 * finalize it here with the full message length.
+		 */
+		nlmsg_end(skb, nlmsg_hdr(skb));
 
 		/* queue the netlink packet */
 		skb_queue_tail(&audit_queue, skb);
-- 
2.47.3

