Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8537A498;
	Thu, 20 Aug 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238854; cv=none; b=IABdnCqtusQ1J+KEqv0NWF/RbgLKer8eqou//vI+ANyhxUk8jeb4OXul192KGtRuJ91vX1XP0volN7+s+x7g+fQHUITnLBXtQXN4lJL/Oy0dgLsNFcrYAaJgq52N475m8d3LfhQaPPbax4ECvnFgUz34QaWc/bJ1pmRsVa6INk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238854; c=relaxed/simple;
	bh=PRG7ClyvCpA8nJ/xwY9E4jc1OWzYgJ3c1PfFdtczgOs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RGvWVXxgHHb5yNQQfFYS88iZgWbsCj9uZfYwPc0jyblxd5nxGxEPjxNSBerBJft8EMyl5ZXFoihEdOoRMnmif/MDzW2vUbK3e/VqOVmO7rs61KImdHhfKhVRFJutDhRybBVJvB0PYipcV93ISCYxts7rWhORNUZvFPXO7HfnjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Pv1fI/j2; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Pv1fI/j2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787238848;
	bh=aq03/QqStUekA59GCcODzGe1XWKnnLqP+r2/JpoIYPo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Pv1fI/j2hKLY7zl2eYEZMgkQhVoZAEwwKEpBt9CsiUEqNRp1ow0mCpwtqcUnnHrvG
	 1lTCZg05Wx1qXthoyF/cIXMR7EyjlH3b+ADe/kDp1+yDZFjJJTV5fCs7fWmzQSLhhD
	 veySd/IzVRAO1/y0sXmpmrPKrQtgT/1MxpOQyo7E=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hQn5r3CRvz110g;
	Thu, 20 Aug 2026 15:14:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hQn5r06jYz110G;
	Thu, 20 Aug 2026 15:14:07 +0000 (UTC)
Date: Thu, 20 Aug 2026 16:14:08 +0100
From: Bradley Morgan <include@grrlz.net>
To: Paul Moore <paul@paul-moore.com>
CC: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_audit=3A_move_the_nlmsg=5Flen_f?=
 =?US-ASCII?Q?ixup_from_=5F=5Faudit=5Flog=5Fend=28=29_to_send_time?=
In-Reply-To: <20260814010153.14488-1-include@grrlz.net>
References: <20260814010153.14488-1-include@grrlz.net>
Message-ID: <9A205207-E0C7-421F-97D3-D37684F14C09@grrlz.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 August 2026 02:01:53 BST, Bradley Morgan <include@grrlz.net> wrote:
>Right now the auditd breakage (nlmsg_len gets set to the payload
>length instead of the full message length) is applied when the record
>is queued, in __audit_log_end(). That is why
>kauditd_send_multicast_skb() has to deep copy every record and then
>undo the length on the copy, just so the multicast group still sees a
>standard netlink message.
>
>So flip it: finalize the header with the standard full length at
>queue time, and apply the auditd length at send time in
>kauditd_send_queue(), right before the unicast. Records stay standard
>netlink messages the whole time they sit in the queues, and the
>multicast copy stops needing its own fixup. The copy itself stays,
>because the rewrite still lands in the data region the listeners
>already hold.
>
>auditd sees the same bytes as before: the fixup is computed from
>skb->len and that does not change between queueing and sending, so
>records that come back around through the retry and hold queues get
>the same value again. Reply and rule list skbs are built with
>nlmsg_put() and go out on their own paths, none of that is touched.
>
>This came out of reviewing Ricardo's "use copied skb length" patch,
>where I suggested moving the fixup as the more interesting cleanup.
>
>Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
>Tested-by: Ricardo Robaina <rrobaina@redhat.com>
>Signed-off-by: Bradley Morgan <include@grrlz.net>
>Link: https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.com
>---
> kernel/audit.c | 30 +++++++++++++-----------------
> 1 file changed, 13 insertions(+), 17 deletions(-)
>
>diff --git a/kernel/audit.c b/kernel/audit.c
>index 9412af9144bc..bcfed6e3678e 100644
>--- a/kernel/audit.c
>+++ b/kernel/audit.c
>@@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
> 		if (skb_hook)
> 			(*skb_hook)(skb);
> 
>+		/*
>+		 * auditd wants nlmsg_len to be the payload length, not the
>+		 * full length, so break it here at send time.
>+		 */
>+		nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;
>+
> 		/* can we send to anyone via unicast? */
> 		if (!sk) {
> 			if (err_hook)
>@@ -849,7 +855,6 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
> {
> 	struct sk_buff *copy;
> 	struct sock *sock = audit_get_sk(&init_net);
>-	struct nlmsghdr *nlh;
> 
> 	/* NOTE: we are not taking an additional reference for init_net since
> 	 *       we don't have to worry about it going away */
>@@ -858,20 +863,12 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
> 		return;
> 
> 	/*
>-	 * The seemingly wasteful skb_copy() rather than bumping the refcount
>-	 * using skb_get() is necessary because non-standard mods are made to
>-	 * the skb by the original kaudit unicast socket send routine.  The
>-	 * existing auditd daemon assumes this breakage.  Fixing this would
>-	 * require co-ordinating a change in the established protocol between
>-	 * the kaudit kernel subsystem and the auditd userspace code.  There is
>-	 * no reason for new multicast clients to continue with this
>-	 * non-compliance.
>+	 * skb_copy() rather than skb_get(): kauditd_send_queue() breaks
>+	 * nlmsg_len for auditd, keep the listeners on a standard message.
> 	 */
> 	copy = skb_copy(skb, GFP_KERNEL);
> 	if (!copy)
> 		return;
>-	nlh = nlmsg_hdr(copy);
>-	nlh->nlmsg_len = skb->len;
> 
> 	nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
> }
>@@ -2785,13 +2782,12 @@ int audit_signal_info(int sig, struct task_struct *t)
>  */
> static void __audit_log_end(struct sk_buff *skb)
> {
>-	struct nlmsghdr *nlh;
>-
> 	if (audit_rate_check()) {
>-		/* setup the netlink header, see the comments in
>-		 * kauditd_send_multicast_skb() for length quirks */
>-		nlh = nlmsg_hdr(skb);
>-		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
>+		/*
>+		 * Records are built without keeping nlmsg_len up to date,
>+		 * finalize it here with the full message length.
>+		 */
>+		nlmsg_end(skb, nlmsg_hdr(skb));
> 
> 		/* queue the netlink packet */
> 		skb_queue_tail(&audit_queue, skb);
>
add akpm:, I seem to be getting ignored on these kind of patches, very
annoyingly, any reason why in particular?

I'm getting slightly, could say angry, could say annoyed, either one.
Thanks!
