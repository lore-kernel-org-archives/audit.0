Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094A3DEAD2
	for <audit@vger.kernel.org>; Mon, 10 Aug 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366678; cv=none; b=FwzIVXMlS2AO95apNWKT6czt1Kv1d9bQp13J5YKvqZmB+ll7rJpP7crWBNZ7ReUjuUwILRtM1nN4URPcVJSiYbNFr1FaVvNjEHfw+/O+9UL9T4+lMCJ9cwZRniJ0+CnnJR5p7ctk2N7E8kPHGeSxux9prjwGFA2L/haSbZCbxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366678; c=relaxed/simple;
	bh=+510A7GiHY7/qcirOaoZ7N5SV3/7LwaxiNCTB+eM8o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=IP2FhBnMsI/UWUtz9Ce8h1zM+TV9h3JgylxoA3p0e55u0LKVviJkEDBOJQ0Z9DnZQYZkAK3P5Vb6zk2OVuFzIObZESl8kvQ+leZLuP5B+6E3gk9URDfGJ6N07aAoXJ+e/CEpVeKOMTeJtY6L+isOfIu3DA5btA8WraX+TKjyqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyunMvDb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyunMvDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786366675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=05myzdjIMIBk1m/LR62eqp2SB4flFPFKPkm3CMFSeYc=;
	b=DyunMvDbWRffMA+fSnGqW1h/HkoTsTRhZRIEX0qGg7WqIbtIddoKlDmuwDq12TBAHrdQ2R
	GZSEJ95AxW9GqPBexJwa0fQzqQDVfAyJ9/ExD63cjsa5ZlI7lJgQhehwE4pWStIdad3B7g
	+s1oxAevS4lhvr0csvrtpIOTQFH1KTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-QrB449cZMaGGSp6VPr_E5A-1; Mon,
 10 Aug 2026 08:57:52 -0400
X-MC-Unique: QrB449cZMaGGSp6VPr_E5A-1
X-Mimecast-MFC-AGG-ID: QrB449cZMaGGSp6VPr_E5A_1786366671
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593161800643;
	Mon, 10 Aug 2026 12:57:51 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.49])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BCC1422;
	Mon, 10 Aug 2026 12:57:48 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: use copied skb length in kauditd_send_multicast_skb()
Date: Mon, 10 Aug 2026 09:57:27 -0300
Message-ID: <20260810125726.775689-2-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: Jvu96PPf6HobDZcor1IzwmhPXJfPkqUKwfyi1gOaZ_4_1786366671
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The netlink header's nlmsg_len was being set using the original skb
instead of the local copy passed to nlmsg_multicast().

While skb->len and copy->len are identical at this point following
skb_copy(), it is conceptually cleaner and safer to use the length
of the skb being actively modified and sent. Thus, this is a minor
cleanup only, no functional change expected.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..631d6d4a23cf 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -871,7 +871,7 @@ static void kauditd_send_multicast_skb(struct sk_buff *skb)
 	if (!copy)
 		return;
 	nlh = nlmsg_hdr(copy);
-	nlh->nlmsg_len = skb->len;
+	nlh->nlmsg_len = copy->len;
 
 	nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
 }
-- 
2.55.0

