Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F73644C1
	for <audit@vger.kernel.org>; Thu, 20 Aug 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241452; cv=none; b=l9hyHnOQ7WVHB4gDvXLbvsHWDWpMqkjcFHzesIoyj3ySDgQV4+EhpyMnuiwpLneecUXlRB6XC3BWJLj05GyRwHyNw5924ERHf8z3NYlMGvFaXYdhqphcxMsupCYZ3mUL/2AGff2/YEIeCysXt3UG8a/CFsLkhZuvpDNkNF+aN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241452; c=relaxed/simple;
	bh=oU+e6N91B4lXufPzUwCMXoWrD1xXgu5a1M/gvkGIhG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqqkbjJCSHBTXZrt5td1/K7MedbUN2YYmNVN3L4kqA9WoAfQnigNbs1dbKSsyXMN3pgkGRAOshp9SQgZMEwB+d6dK+9+HpisQqh4kBCQCMz6fw4WUm+8f2YTXq+Mg5IsIux/oSx9uqXm0KT0OK9BFeIAZQZDHbGwY6MDQwjJSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3rPnR1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3rPnR1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787241449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vB1Fol27V4dnu8ufIZVDLrOwX9QII5zGqzHkX5z6Pcg=;
	b=B3rPnR1U/rvz/mKqwAqtbnoMQ9DGhaaKtUrc+ZNNZ+DV+czE7NoK50OHIOMIcNkJF4yHk+
	hTt0GoE82nfugLhUAZQpbDvSutKzF+bJ/N4G1Sx+W3/Rc95ece7zbbtCbosqbhUam4jXKO
	n4Rwgj0w/MQq/n3y1g3lDlQOo08HJn8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ObNWqG-FN86SSZukFjcpRQ-1; Thu, 20 Aug 2026 11:57:24 -0400
X-MC-Unique: ObNWqG-FN86SSZukFjcpRQ-1
X-Mimecast-MFC-AGG-ID: ObNWqG-FN86SSZukFjcpRQ_1787241444
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c20262b5e10so264709666b.1
        for <audit@vger.kernel.org>; Thu, 20 Aug 2026 08:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241444; x=1787846244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vB1Fol27V4dnu8ufIZVDLrOwX9QII5zGqzHkX5z6Pcg=;
        b=bb+PODOJtnpLNjkD43ZUPYG1NN0UbUwNwDIlTEK7ejdjuwZkyhEPFpMhzoxU5FKKP0
         Dxy6+Co+zdDNWp0rPJ8Yo49sMaHxH1F0wh77kzWOg/AN3UFB8U6YevKUEyV1Ycx1ikrD
         UzGMlpZpVPhzgXmAs45YKQ+c7y9rjaiB6FFzldWepmahrwpdGQNUg9jdK6hsxIKwytC/
         BQNWaf1SoEfNVfq0NaNbXsR7WfqtW1PgLyiU8BzQmXG7eilGjKenGHS2wZyLiWRJx3tT
         hQu6nbl5Ok0rc4Ne0atnLBS34MgXl9UDL+O+7Z09nIE2dqz+Amy5hZid0OyeHUNN39aG
         /Dcg==
X-Forwarded-Encrypted: i=1; AHgh+RosX5dZp9HBhYSfWS75ckWdEg8kOEbgmWulG3E4hUDC2K/vZeItmHPRH9UP0wZHQWaNmoixhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk22AFl651h1vzLtMDDw4XnMeNORD9l0JNSqwJypCnIt3Qk7Yq
	bohpCrZzdfmT4EVES1KZ6S3if+LbAJk5STv6YDHdbo8TOzQLB6rzZDAbU1JSqb56P4KdN1BI8hP
	brofz9QxX956h0JcSxI1ZPjxxIxxoYHxGQGC4UJ+I0jaYcCn9/5IrxXZQjWa4t9rP5clOdaH6Kb
	BSUMUcfhzCYcSNk9mDP/UubRrfX4Sy65I=
X-Gm-Gg: AR+sD130m7Ar9N9UKhnLqcDz/UUgpqkW2+72jreuJt5dX44GqhD11F++EyABOwHQpFi
	0RrLz31xMOaj9s7aXVuMmQQ5gW/nWjz0MPIJ0sxjGubukrU9o2AyImD2O8+PgCtwReU6/vFgaQT
	9DoZ1LVrM4uZXfJYXb5l5TNP/fQEmfXLzyMSwyPw3DtJyxXpESmuljN+/qCr1wiZslk8Sq+/yii
	1RAI6gSf1Zek3uxIbE1nXy67z9m3AKiU47TQfgAAAfy1+EsAEtozbIcf7FS2P0AGFblL19ai2Qz
X-Received: by 2002:a17:907:3ea8:b0:c21:3fa7:5a6f with SMTP id a640c23a62f3a-c242e3eadf0mr949737866b.24.1787241443761;
        Thu, 20 Aug 2026 08:57:23 -0700 (PDT)
X-Received: by 2002:a17:907:3ea8:b0:c21:3fa7:5a6f with SMTP id
 a640c23a62f3a-c242e3eadf0mr949734866b.24.1787241443362; Thu, 20 Aug 2026
 08:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814010153.14488-1-include@grrlz.net> <9A205207-E0C7-421F-97D3-D37684F14C09@grrlz.net>
In-Reply-To: <9A205207-E0C7-421F-97D3-D37684F14C09@grrlz.net>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 20 Aug 2026 12:57:12 -0300
X-Gm-Features: AcwNN1WIdGQ1AE7rYSvdf-OfWMJBOa2Opu6lSVoMZLtVFTLZ0Nd5RJHTAaKLGRE
Message-ID: <CAABTaaCoekpRhmugkNsu+YuAfN9oO4aSZZttW=a_-t_YD1vqNw@mail.gmail.com>
Subject: Re: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() to
 send time
To: Bradley Morgan <include@grrlz.net>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Omr-ZSvHCarXoiQjundi1hDf5u1KchHxWGT5k0LpcRY_1787241444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:14=E2=80=AFPM Bradley Morgan <include@grrlz.net>=
 wrote:
>
> On 14 August 2026 02:01:53 BST, Bradley Morgan <include@grrlz.net> wrote:
> >Right now the auditd breakage (nlmsg_len gets set to the payload
> >length instead of the full message length) is applied when the record
> >is queued, in __audit_log_end(). That is why
> >kauditd_send_multicast_skb() has to deep copy every record and then
> >undo the length on the copy, just so the multicast group still sees a
> >standard netlink message.
> >
> >So flip it: finalize the header with the standard full length at
> >queue time, and apply the auditd length at send time in
> >kauditd_send_queue(), right before the unicast. Records stay standard
> >netlink messages the whole time they sit in the queues, and the
> >multicast copy stops needing its own fixup. The copy itself stays,
> >because the rewrite still lands in the data region the listeners
> >already hold.
> >
> >auditd sees the same bytes as before: the fixup is computed from
> >skb->len and that does not change between queueing and sending, so
> >records that come back around through the retry and hold queues get
> >the same value again. Reply and rule list skbs are built with
> >nlmsg_put() and go out on their own paths, none of that is touched.
> >
> >This came out of reviewing Ricardo's "use copied skb length" patch,
> >where I suggested moving the fixup as the more interesting cleanup.
> >
> >Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> >Tested-by: Ricardo Robaina <rrobaina@redhat.com>
> >Signed-off-by: Bradley Morgan <include@grrlz.net>
> >Link: https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.=
com
> >---
> > kernel/audit.c | 30 +++++++++++++-----------------
> > 1 file changed, 13 insertions(+), 17 deletions(-)
> >
> >diff --git a/kernel/audit.c b/kernel/audit.c
> >index 9412af9144bc..bcfed6e3678e 100644
> >--- a/kernel/audit.c
> >+++ b/kernel/audit.c
> >@@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32 =
portid,
> >               if (skb_hook)
> >                       (*skb_hook)(skb);
> >
> >+              /*
> >+               * auditd wants nlmsg_len to be the payload length, not t=
he
> >+               * full length, so break it here at send time.
> >+               */
> >+              nlmsg_hdr(skb)->nlmsg_len =3D skb->len - NLMSG_HDRLEN;
> >+
> >               /* can we send to anyone via unicast? */
> >               if (!sk) {
> >                       if (err_hook)
> >@@ -849,7 +855,6 @@ static void kauditd_send_multicast_skb(struct sk_buf=
f *skb)
> > {
> >       struct sk_buff *copy;
> >       struct sock *sock =3D audit_get_sk(&init_net);
> >-      struct nlmsghdr *nlh;
> >
> >       /* NOTE: we are not taking an additional reference for init_net s=
ince
> >        *       we don't have to worry about it going away */
> >@@ -858,20 +863,12 @@ static void kauditd_send_multicast_skb(struct sk_b=
uff *skb)
> >               return;
> >
> >       /*
> >-       * The seemingly wasteful skb_copy() rather than bumping the refc=
ount
> >-       * using skb_get() is necessary because non-standard mods are mad=
e to
> >-       * the skb by the original kaudit unicast socket send routine.  T=
he
> >-       * existing auditd daemon assumes this breakage.  Fixing this wou=
ld
> >-       * require co-ordinating a change in the established protocol bet=
ween
> >-       * the kaudit kernel subsystem and the auditd userspace code.  Th=
ere is
> >-       * no reason for new multicast clients to continue with this
> >-       * non-compliance.
> >+       * skb_copy() rather than skb_get(): kauditd_send_queue() breaks
> >+       * nlmsg_len for auditd, keep the listeners on a standard message=
.
> >        */
> >       copy =3D skb_copy(skb, GFP_KERNEL);
> >       if (!copy)
> >               return;
> >-      nlh =3D nlmsg_hdr(copy);
> >-      nlh->nlmsg_len =3D skb->len;
> >
> >       nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
> > }
> >@@ -2785,13 +2782,12 @@ int audit_signal_info(int sig, struct task_struc=
t *t)
> >  */
> > static void __audit_log_end(struct sk_buff *skb)
> > {
> >-      struct nlmsghdr *nlh;
> >-
> >       if (audit_rate_check()) {
> >-              /* setup the netlink header, see the comments in
> >-               * kauditd_send_multicast_skb() for length quirks */
> >-              nlh =3D nlmsg_hdr(skb);
> >-              nlh->nlmsg_len =3D skb->len - NLMSG_HDRLEN;
> >+              /*
> >+               * Records are built without keeping nlmsg_len up to date=
,
> >+               * finalize it here with the full message length.
> >+               */
> >+              nlmsg_end(skb, nlmsg_hdr(skb));
> >
> >               /* queue the netlink packet */
> >               skb_queue_tail(&audit_queue, skb);
> >
> add akpm:, I seem to be getting ignored on these kind of patches, very
> annoyingly, any reason why in particular?
>
> I'm getting slightly, could say angry, could say annoyed, either one.
> Thanks!
>

Hi Bradley,

Paul will probably explain better, but see the seesion "Don=E2=80=99t get
discouraged - or impatient" in [1], in the meantime. There was a merge
window going on recently.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
don-t-get-discouraged-or-impatient

-Ricardo

