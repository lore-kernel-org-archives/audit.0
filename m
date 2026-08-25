Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A683C07A;
	Tue, 25 Aug 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616962; cv=none; b=Eh0aGikFbg6H0HKWD27E80RZqKSvaaZQC459V7d+55t7BmSVFeWHiyupg1I3Z7bLtClNXk5nVNIBmlVgAURwY0f6DdZG4QI5NBebKjMQPfg6XH9GQCbOlTRcSBvfuR7AL+e28T2RTzAmi8eL+WSycXoCy46qS8Oly7/b1EdMQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616962; c=relaxed/simple;
	bh=jONtnxYk75aGVfwmzBqKx1AkfFntkZ6IyZfHA793fQs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZQS5nuzioo0xfvcDW6yb4qM2QionHS4FWVIVnxMAAR+xKKJVuuaM+WRu/Qf2PjMGSwpWjvkrU6TijnqSfHp8qOIQ4ip2nIXkkf24NXDEO7Nl7qJe93KZC0cdGDHP6sZsY3c1E1HLSkpJHTP0HFKT8mkdnZy+YRgWnWE1dgrDrqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=cen17zmb; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="cen17zmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787616951;
	bh=POV8b6jzp5zRlxqO9lHTXfMHrj1g2gcld18jFiU5KVQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cen17zmb4vm1JBJyw0KnoB0emVjhh4Of79Bv1jkQnWQ1K9K3/DsZPp8uOixNCes7u
	 Sgz/USBiWJqDRu3tkAJytrVAPbVmi1WHSyGggJh0qYHrCsjF7w1lqn6oaRks8qY3MG
	 0F7mybfLNmNQt1d/Tncz5ldzP47R7kgDDi5mH8WU=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hTSx35SLKz6vHm;
	Tue, 25 Aug 2026 00:15:51 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hTSx31SPdz4y6W;
	Tue, 25 Aug 2026 00:15:51 +0000 (UTC)
Date: Tue, 25 Aug 2026 01:15:49 +0100
From: Bradley Morgan <include@grrlz.net>
To: Paul Moore <paul@paul-moore.com>
CC: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_audit=3A_move_the_nlmsg=5Flen_fi?=
 =?US-ASCII?Q?xup_from_=5F=5Faudit=5Flog=5Fend=28=29_to__send_time?=
In-Reply-To: <552658f244965a3dca8081f0020155e8@paul-moore.com>
References: <20260814010153.14488-1-include@grrlz.net> <552658f244965a3dca8081f0020155e8@paul-moore.com>
Message-ID: <FB0B346E-BA48-4488-AC6D-D0827664EFE8@grrlz.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 August 2026 01:08:46 BST, Paul Moore <paul@paul-moore.com> wrote:
>On Aug 13, 2026 Bradley Morgan <include@grrlz.net> wrote:
>> 
>> Right now the auditd breakage (nlmsg_len gets set to the payload
>> length instead of the full message length) is applied when the record
>> is queued, in __audit_log_end(). That is why
>> kauditd_send_multicast_skb() has to deep copy every record and then
>> undo the length on the copy, just so the multicast group still sees a
>> standard netlink message.
>> 
>> So flip it: finalize the header with the standard full length at
>> queue time, and apply the auditd length at send time in
>> kauditd_send_queue(), right before the unicast. Records stay standard
>> netlink messages the whole time they sit in the queues, and the
>> multicast copy stops needing its own fixup. The copy itself stays,
>> because the rewrite still lands in the data region the listeners
>> already hold.
>> 
>> auditd sees the same bytes as before: the fixup is computed from
>> skb->len and that does not change between queueing and sending, so
>> records that come back around through the retry and hold queues get
>> the same value again. Reply and rule list skbs are built with
>> nlmsg_put() and go out on their own paths, none of that is touched.
>> 
>> This came out of reviewing Ricardo's "use copied skb length" patch,
>> where I suggested moving the fixup as the more interesting cleanup.
>> 
>> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
>> Tested-by: Ricardo Robaina <rrobaina@redhat.com>
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> Link:
>https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.com
>> ---
>>  kernel/audit.c | 30 +++++++++++++-----------------
>>  1 file changed, 13 insertions(+), 17 deletions(-)
>> 
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 9412af9144bc..bcfed6e3678e 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32
>portid,
>>  		if (skb_hook)
>>  			(*skb_hook)(skb);
>>  
>> +		/*
>> +		 * auditd wants nlmsg_len to be the payload length, not the
>> +		 * full length, so break it here at send time.
>> +		 */
>> +		nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;
>
>One of the reasons we set the length in __audit_log_end() is so that we
>only do it once, plus the multicast fixup.  In this patch we still set the
>length in __audit_log_end() as well as potentially multiple times in
>kauditd_send_queue().  This patch does drop the multicast fixup, but it
>isn't as clean a solution conceptually as the current code in my opinion.
>
>Ultimately, in this patch we still have at least two length calculations
>with the potential for additional unnecessary calculations/assignments if
>we need to loop through kauditd_send_queue() multiple times.  The existing
>code is capped at two calculations/assignments.  I appreciate the time
>you've put into this, but I think the existing code is the better option
>at this point in time.

Hmm, interesting, yeah that works.


>
>>  		/* can we send to anyone via unicast? */
>>  		if (!sk) {
>>  			if (err_hook)
>
>--
>paul-moore.com
>

Thanks!
