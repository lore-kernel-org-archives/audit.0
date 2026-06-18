Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B563DBD41
	for <audit@vger.kernel.org>; Thu, 18 Jun 2026 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790053; cv=none; b=bkMpEVDwjtCK5lwwk2gSyDROHjOixxEqRtj6bAoIEHw1pGZSdZbyDkL8WAt8drZPMV28HYj9qcDMcfljIZ9pL7IdKR5mEyXzzF+en0YEduBfbnJeGgbmeGy1F/JDtTgFNxAiHqEfeaHq4s2dyzX40hRU1wIsMo9xgCc41FCCaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790053; c=relaxed/simple;
	bh=SF786acYLhuIc2+L75P1WNPnVxSx4c8UbhQ7jYlOK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KEuymlDjggXB0Y9L/PSHN0xWnEw6nLIoyAPJj2gR1VDWrTOzD00nCfLP3i8aQuIoi7XalFGPrcWTiXRa/Uas1Gqa3mlQ5P9tScz9RZmiMVUQRpsFS7tm10+CT2tvfw7mR9VoRc1ZNmd/+CUN9f9gA092tgCGeIk/vNdB1JMETUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaQGk9Me; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaQGk9Me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3nG9XDcmi2ze+UrzSq5/vn1j1f1IyubkYAyA70eq6o=;
	b=CaQGk9MeMLq9/poKVD/KdsxRjgj95oBC38H1+Mk+nSpZ/9VddkAvfrUX7fgEty4E2z6Jhr
	SNRI6BnegGk7VYmqXn6S5uZdzEuuf+XzQ3SOdZU8+9MBjkdl4Y9gUExygpDpScnvNbaf25
	rX8vfJI+yHgO6mK5Yl3phpie83iVD7s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-yAfvpms-N6i1VcoDDS4nww-1; Thu,
 18 Jun 2026 09:40:44 -0400
X-MC-Unique: yAfvpms-N6i1VcoDDS4nww-1
X-Mimecast-MFC-AGG-ID: yAfvpms-N6i1VcoDDS4nww_1781790043
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B301955F7C;
	Thu, 18 Jun 2026 13:40:42 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.92])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B58E364F7;
	Thu, 18 Jun 2026 13:40:39 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: wangchi@kylinos.cn
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: Fix data race in audit_log_start()
Date: Thu, 18 Jun 2026 10:40:05 -0300
Message-ID: <20260618134004.3398831-2-rrobaina@redhat.com>
In-Reply-To: <20260617130038.57465-1-wangchi@kylinos.cn>
References: <20260617130038.57465-1-wangchi@kylinos.cn>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: EanirexsUynlyFCkPnBVXE9adjzGEif40moRtScq2w8_1781790043
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Chi,=0D
=0D
Good catch, the patch looks good to me.=0D
=0D
However, I found three additional instances of the same pattern that=0D
should be included in this patch for completeness:=0D
=0D
  1. Line 953 in kauditd_thread():=0D
     wait_event_freezable(kauditd_wait,=0D
                          (skb_queue_len(&audit_queue) ? 1 : 0));=0D
=0D
  2. Line 1286 in audit_receive_msg() (AUDIT_GET handler):=0D
     s.backlog =3D skb_queue_len(&audit_queue);=0D
=0D
  3. Line 1630 in audit_receive():=0D
     if (audit_backlog_limit &&=0D
         (skb_queue_len(&audit_queue) > audit_backlog_limit)) {=0D
=0D
All three read audit_queue.qlen without synchronization while the queue=0D
is concurrently modified.=0D
=0D
diff --git a/kernel/audit.c b/kernel/audit.c=0D
index dcc657d35776..c074c3717946 100644=0D
--- a/kernel/audit.c=0D
+++ b/kernel/audit.c=0D
@@ -950,7 +950,7 @@ static int kauditd_thread(void *dummy)=0D
                 *       do the multicast send and rotate records from the=
=0D
                 *       main queue to the retry/hold queues */=0D
                wait_event_freezable(kauditd_wait,=0D
-                                    (skb_queue_len(&audit_queue) ? 1 : 0))=
;=0D
+                                    (skb_queue_len_lockless(&audit_queue) =
? 1 : 0));=0D
        }=0D
=20=0D
        return 0;=0D
@@ -1283,7 +1283,7 @@ static int audit_receive_msg(struct sk_buff *skb, str=
uct nlmsghdr *nlh,=0D
                s.rate_limit               =3D audit_rate_limit;=0D
                s.backlog_limit            =3D audit_backlog_limit;=0D
                s.lost                     =3D atomic_read(&audit_lost);=0D
-               s.backlog                  =3D skb_queue_len(&audit_queue);=
=0D
+               s.backlog                  =3D skb_queue_len_lockless(&audi=
t_queue);=0D
                s.feature_bitmap           =3D AUDIT_FEATURE_BITMAP_ALL;=0D
                s.backlog_wait_time        =3D audit_backlog_wait_time;=0D
                s.backlog_wait_time_actual =3D atomic_read(&audit_backlog_w=
ait_time_actual);=0D
@@ -1627,7 +1627,7 @@ static void audit_receive(struct sk_buff *skb)=0D
=20=0D
        /* can't block with the ctrl lock, so penalize the sender now */=0D
        if (audit_backlog_limit &&=0D
-           (skb_queue_len(&audit_queue) > audit_backlog_limit)) {=0D
+           (skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {=
=0D
                DECLARE_WAITQUEUE(wait, current);=0D
=20=0D
                /* wake kauditd to try and flush the queue */=0D
=0D
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>=0D
=0D
I hope it helps!=0D
-Ricardo=0D

