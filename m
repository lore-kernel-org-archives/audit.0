Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC0361943;
	Mon, 10 Aug 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379258; cv=none; b=hDYWTEBu80LzcjQ+nX7f5QHGza8b0c+TbQdyd8wtpgT9J8wZpqajuqg9LpfZAH7J2tJOsjszXdG6soWingZAiaoG6gYBws3uSTap7SkH4Fkx3lOF54oZkhgBXrspCE74kDOz8aS4EyEIx6wem7WYDjGtxo6V6kBL2N9jcjDPnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379258; c=relaxed/simple;
	bh=/0DsenQ4SsuriWJghAWRpvM9+MW61hukSojkWxIUdsI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fKeTx4POZ6GtvVdf9Djc3dMIb5ossEWeAFCuajxaRy1A4rIAVBCN2b6YIqHyG0kE1/JbqHUyGI78S1r5LnZqde8+OmJ/aXWxPubZ0ssIq0U6wr/kcIAoCIjECAs+4he4iyE0IP7U7hrdEhjjRxlOhjt9pF3IXh5zduDCzc+0IZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=pn6Mloix; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="pn6Mloix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786379253;
	bh=uPQ/dDQs102CXgd0GjW3HTYMhbLO5XGfpLdIKlKy19E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pn6MloixeQfGsMFkcqJi0mG8nSF6VhwHmNd0qg6hKNrMnIIP93Wb9i4iZTSGocTQq
	 TTp/cXscEy5sqG0MsFGNBOM90mGgXcaWJBqftZKEEiooBfX8MM74BNIY5GqpETLQut
	 9r3KsD8ki2w1rlsjuQpDP6Kjpp7ggzTeyhIDkqIc=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hJgC90cFWzGpGr;
	Mon, 10 Aug 2026 16:27:33 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hJgC850YlzGpGq;
	Mon, 10 Aug 2026 16:27:32 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:27:30 +0100
From: Bradley Morgan <include@grrlz.net>
To: Ricardo Robaina <rrobaina@redhat.com>
CC: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org,
 paul@paul-moore.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_audit=3A_use_copied_skb_le?=
 =?US-ASCII?Q?ngth_in_kauditd=5Fsend=5Fmulticast=5Fskb=28=29?=
In-Reply-To: <CAABTaaDWFgz=kJr8YHx8NpKwuWnkCfjf==3noP36x83Zxv5APQ@mail.gmail.com>
References: <20260810125726.775689-2-rrobaina@redhat.com> <D8FC4B83-AC7B-4ECC-AA70-17DCE5AB2AD6@grrlz.net> <CAABTaaDWFgz=kJr8YHx8NpKwuWnkCfjf==3noP36x83Zxv5APQ@mail.gmail.com>
Message-ID: <93F6051A-4D51-4887-AED1-4BED3881FF72@grrlz.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 August 2026 16:19:10 BST, Ricardo Robaina <rrobaina@redhat.com>
wrote:
>On Mon, Aug 10, 2026 at 10:32 AM Bradley Morgan <include@grrlz.net> wrote:
>>
>> Hi Ricardo,
>>
>> > -     nlh->nlmsg_len = skb->len;
>> > +     nlh->nlmsg_len = copy->len;
>>
>> Fine. skb_copy() does skb_put(n, skb->len) and nothing touches
>> copy->len in between, so the two are always identical.
>> Which is also why "safer" is a bit of a stretch, it prevents nothing.
>> Feel free to bikeshed the changelog wording on that.
>>
>
>Thanks for reviewing this patch, Bradley. I agree with you on the wording.
>

np.

>> If you ever want a more interesting cleanup here, the real quirk is
>> the line above: the unicast path sets nlmsg_len to skb->len minus
>> NLMSG_HDRLEN, this one uses the full length.
>
>That's interesting, maybe moving the nlmsg_len fixup out of
>__audit_log_end() would be better. I'll look into it.
>

Hmmm.. perhaps it will. I will suggest a fix:

From 776375d625cd9cb138f7a6f876861bf428ae1e6c Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Mon, 10 Aug 2026 16:26:06 +0000
Subject: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() to
 send time

The auditd breakage (nlmsg_len set to the payload length instead of
the full message length) is applied in __audit_log_end() when the
record is queued. That forces kauditd_send_multicast_skb() to deep
copy every record and undo the length on the copy, so the multicast
group still sees a standard netlink message.

Instead, finalize the header with the standard full length at queue
time and apply the auditd length right before the unicast send in
kauditd_send_queue(). Records stay standard netlink messages while
they sit in the queues, and the multicast copy no longer needs its
own fixup. The deep copy itself stays, since the auditd length
rewrite lands in the shared data region after the copy is already
handed to the listeners.

auditd sees the same bytes as before. The fixup is computed from
skb->len, which does not change between queueing and sending, so
records that come back through the retry and hold queues get the same
value again. Reply and rule list skbs are built with nlmsg_put() and
sent on other paths, none of those are touched.

This came out of the "use copied skb length" thread, where moving the
fixup was suggested as the more interesting cleanup.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/audit.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..5b6528fc6eb5 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -802,6 +802,15 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 		if (skb_hook)
 			(*skb_hook)(skb);
 
+		/*
+		 * auditd expects nlmsg_len to be the payload length rather
+		 * than the full message length.  Apply the breakage here at
+		 * send time so the record stays a standard netlink message
+		 * while queued and while it is copied for the multicast
+		 * group above.
+		 */
+		nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;
+
 		/* can we send to anyone via unicast? */
 		if (!sk) {
 			if (err_hook)
@@ -849,7 +858,6 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 {
 	struct sk_buff *copy;
 	struct sock *sock = audit_get_sk(&init_net);
-	struct nlmsghdr *nlh;
 
 	/* NOTE: we are not taking an additional reference for init_net since
 	 *       we don't have to worry about it going away */
@@ -859,19 +867,15 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 
 	/*
 	 * The seemingly wasteful skb_copy() rather than bumping the refcount
-	 * using skb_get() is necessary because non-standard mods are made to
-	 * the skb by the original kaudit unicast socket send routine.  The
-	 * existing auditd daemon assumes this breakage.  Fixing this would
-	 * require co-ordinating a change in the established protocol between
-	 * the kaudit kernel subsystem and the auditd userspace code.  There is
-	 * no reason for new multicast clients to continue with this
-	 * non-compliance.
+	 * using skb_get() is necessary because the unicast send in
+	 * kauditd_send_queue() rewrites nlmsg_len to the payload only length
+	 * that auditd expects.  The copy shields the multicast listeners from
+	 * that historical breakage, there is no reason for them to continue
+	 * with this non compliance.
 	 */
 	copy = skb_copy(skb, GFP_KERNEL);
 	if (!copy)
 		return;
-	nlh = nlmsg_hdr(copy);
-	nlh->nlmsg_len = skb->len;
 
 	nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
 }
@@ -2785,13 +2789,15 @@ int audit_signal_info(int sig, struct task_struct *t)
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
+		 * The record was built by appending data after nlmsg_put()
+		 * without keeping nlmsg_len up to date, so finalize the
+		 * header here with the standard full message length.  The
+		 * payload only length that auditd expects is applied at
+		 * send time in kauditd_send_queue().
+		 */
+		nlmsg_end(skb, nlmsg_hdr(skb));
 
 		/* queue the netlink packet */
 		skb_queue_tail(&audit_queue, skb);
-- 
2.47.3




>>
>> Well, why not, please add:
>>
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> Thanks!
>>
>
>-Ricardo
>
>

Thanks!
