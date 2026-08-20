Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF546D091;
	Thu, 20 Aug 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243922; cv=none; b=pyuEuy+jH69r+o0i7KjRyQts48S34cpMhX0yb5J6Pg7IXYe1qo1uypr8IYLoh/y/L+3Gd1dghVLg6xne5+fkS0KvaiU2q97YWv4qE8OjxRbcLUIDTGw8Z5OsnYIY2/i9kHjTLzfm+/OQI67vBRF1uBZAPCK7McA+Dgcac9dxN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243922; c=relaxed/simple;
	bh=LAYCwluoo+wrrefRRofCAS/dwBWG4wmy/ipxVTQ9PGc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f/WDFwDGJqVq2le40a5f4/tUaBMlPy+ci/KeGVqxV/93oe76YIRZQv4/8q6FfGwkdbOG7oCkc0BSfh8FQASlI2J7YssTpT5uIZfFtZ8/+N3E1x1/AMTLglbpEhck/zV106AnUBX9Rb3+j4hQw4ZARAh3QrUPVyOsq3R6vRvtQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JkIyoDo4; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="JkIyoDo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787243915;
	bh=N9HGP/2bePlZLrZTabcQzvO6LBhe7rjFOnZRODlyXBE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JkIyoDo42uB7h9wb/FMaEjddHM6wDLsB90HXqArLIyiuRfdv+hnS1AfPXbgwNONaP
	 JNbHqsHvPdNLZwR8AYD6yK5vzsoN3JxD0fI1yble8dxRWOG2Us1q8V3bK3YNvfSOX5
	 yTdZGToX5k/7PWXUFWrax1ehWWP22jVfP4CJTqDE=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hQpzH6j7CzGpC5;
	Thu, 20 Aug 2026 16:38:35 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hQpzH3njnzGpBG;
	Thu, 20 Aug 2026 16:38:35 +0000 (UTC)
Date: Thu, 20 Aug 2026 17:38:34 +0100
From: Bradley Morgan <include@grrlz.net>
To: Ricardo Robaina <rrobaina@redhat.com>
CC: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_audit=3A_move_the_nlmsg=5Flen_f?=
 =?US-ASCII?Q?ixup_from_=5F=5Faudit=5Flog=5Fend=28=29_to_send_time?=
In-Reply-To: <CAABTaaCoekpRhmugkNsu+YuAfN9oO4aSZZttW=a_-t_YD1vqNw@mail.gmail.com>
References: <20260814010153.14488-1-include@grrlz.net> <9A205207-E0C7-421F-97D3-D37684F14C09@grrlz.net> <CAABTaaCoekpRhmugkNsu+YuAfN9oO4aSZZttW=a_-t_YD1vqNw@mail.gmail.com>
Message-ID: <FCD78CD2-B9C0-4B47-872A-C0A2C8611985@grrlz.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 20 August 2026 16:57:12 BST, Ricardo Robaina <rrobaina@redhat.com>
wrote:
>On Thu, Aug 20, 2026 at 12:14 PM Bradley Morgan <include@grrlz.net> wrote:
>>
>> On 14 August 2026 02:01:53 BST, Bradley Morgan <include@grrlz.net>
>wrote:
>> >Right now the auditd breakage (nlmsg_len gets set to the payload
>> >length instead of the full message length) is applied when the record
>> >is queued, in __audit_log_end(). That is why
>> >kauditd_send_multicast_skb() has to deep copy every record and then
>> >undo the length on the copy, just so the multicast group still sees a
>> >standard netlink message.
>> >
>> >So flip it: finalize the header with the standard full length at
>> >queue time, and apply the auditd length at send time in
>> >kauditd_send_queue(), right before the unicast. Records stay standard
>> >netlink messages the whole time they sit in the queues, and the
>> >multicast copy stops needing its own fixup. The copy itself stays,
>> >because the rewrite still lands in the data region the listeners
>> >already hold.
>> >
>> >auditd sees the same bytes as before: the fixup is computed from
>> >skb->len and that does not change between queueing and sending, so
>> >records that come back around through the retry and hold queues get
>> >the same value again. Reply and rule list skbs are built with
>> >nlmsg_put() and go out on their own paths, none of that is touched.
>> >
>> >This came out of reviewing Ricardo's "use copied skb length" patch,
>> >where I suggested moving the fixup as the more interesting cleanup.
>> >
>> >Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
>> >Tested-by: Ricardo Robaina <rrobaina@redhat.com>
>> >Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >Link:
>https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.com
>> >---
>> > kernel/audit.c | 30 +++++++++++++-----------------
>> > 1 file changed, 13 insertions(+), 17 deletions(-)
>> >
>> >diff --git a/kernel/audit.c b/kernel/audit.c
>> >index 9412af9144bc..bcfed6e3678e 100644
>> >--- a/kernel/audit.c
>> >+++ b/kernel/audit.c
>> >@@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32
>portid,
>> >               if (skb_hook)
>> >                       (*skb_hook)(skb);
>> >
>> >+              /*
>> >+               * auditd wants nlmsg_len to be the payload length, not
>the
>> >+               * full length, so break it here at send time.
>> >+               */
>> >+              nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;
>> >+
>> >               /* can we send to anyone via unicast? */
>> >               if (!sk) {
>> >                       if (err_hook)
>> >@@ -849,7 +855,6 @@ static void kauditd_send_multicast_skb(struct
>sk_buff *skb)
>> > {
>> >       struct sk_buff *copy;
>> >       struct sock *sock = audit_get_sk(&init_net);
>> >-      struct nlmsghdr *nlh;
>> >
>> >       /* NOTE: we are not taking an additional reference for init_net
>since
>> >        *       we don't have to worry about it going away */
>> >@@ -858,20 +863,12 @@ static void kauditd_send_multicast_skb(struct
>sk_buff *skb)
>> >               return;
>> >
>> >       /*
>> >-       * The seemingly wasteful skb_copy() rather than bumping the
>refcount
>> >-       * using skb_get() is necessary because non-standard mods are
>made to
>> >-       * the skb by the original kaudit unicast socket send routine. 
>The
>> >-       * existing auditd daemon assumes this breakage.  Fixing this
>would
>> >-       * require co-ordinating a change in the established protocol
>between
>> >-       * the kaudit kernel subsystem and the auditd userspace code. 
>There is
>> >-       * no reason for new multicast clients to continue with this
>> >-       * non-compliance.
>> >+       * skb_copy() rather than skb_get(): kauditd_send_queue() breaks
>> >+       * nlmsg_len for auditd, keep the listeners on a standard
>message.
>> >        */
>> >       copy = skb_copy(skb, GFP_KERNEL);
>> >       if (!copy)
>> >               return;
>> >-      nlh = nlmsg_hdr(copy);
>> >-      nlh->nlmsg_len = skb->len;
>> >
>> >       nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
>> > }
>> >@@ -2785,13 +2782,12 @@ int audit_signal_info(int sig, struct
>task_struct *t)
>> >  */
>> > static void __audit_log_end(struct sk_buff *skb)
>> > {
>> >-      struct nlmsghdr *nlh;
>> >-
>> >       if (audit_rate_check()) {
>> >-              /* setup the netlink header, see the comments in
>> >-               * kauditd_send_multicast_skb() for length quirks */
>> >-              nlh = nlmsg_hdr(skb);
>> >-              nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
>> >+              /*
>> >+               * Records are built without keeping nlmsg_len up to
>date,
>> >+               * finalize it here with the full message length.
>> >+               */
>> >+              nlmsg_end(skb, nlmsg_hdr(skb));
>> >
>> >               /* queue the netlink packet */
>> >               skb_queue_tail(&audit_queue, skb);
>> >
>> add akpm:, I seem to be getting ignored on these kind of patches, very
>> annoyingly, any reason why in particular?
>>
>> I'm getting slightly, could say angry, could say annoyed, either one.
>> Thanks!
>>
>
>Hi Bradley,
>
>Paul will probably explain better, but see the seesion "Don’t get
>discouraged - or impatient" in [1], in the meantime. There was a merge
>window going on recently.
>
>[1]
>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient
>
>-Ricardo
>
>
Sigh, [1]


This ignoring seems to be a deliberate thing, NOTE THAT THAT WAS MY FIRST
PATCH ever after studying for god knows how long. I have the right to be
annoyed


[1] https://lore.kernel.org/all/20260619130305.27779-2-include@grrlz.net/
Thanks!
