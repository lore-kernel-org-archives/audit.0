Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E3224B04
	for <audit@vger.kernel.org>; Wed,  1 Jul 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912011; cv=none; b=dysjp4Yt/BmCo7qR1vpsb5Pk+0dQU93P1Iu6KykTPWrhBZbSv7Ln2hEUtrjscNr//r8f7x+8ro1BXnzFU9naKjEqLO2LaTHHoVEyDSGHRGPjE8ctXBY2unWMuSCPHu/oXWo0jqhlON/J6+Hq4ri+5o/3OnJUG8mZztelkVyzEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912011; c=relaxed/simple;
	bh=NMzxxg7ZgLCOKsY+USMeby7o9dFCZTquK2xGp6K4vfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOwKvc6A9dffPX7yVaikxYPDb08XJA5O9P/OfMvmjxn65QxdMvORi5u4p2DhrLGJt9L4jayMeE/QzLYH08bw9nENilkEgkjAykncG0G4iOUkgL8LeryhSphKd7Eud7Y+TBz62alE/vTvCb1Y2jKcmV+UQ+6/+s2XEFz73Pg6sXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZecgZAwe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZecgZAwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782912009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkyHBx8qc3TZHAZdVcz1ygge0E0qA4+vhFJQ0TyghSU=;
	b=ZecgZAwei7LabqCYUYFgc3ySg1toJ2FR85NcvdSvH/Jx8xz+JW2ct3Yipz3nrT+85ARaZT
	qoVNUwKQK1mKqc45zO9Lzk3Zph/90AUwHvsSyOZujcvWtggc1qMbjoyiqlBE7lrOq9EPg0
	jnKqZpkA4qYPFOFvKEr35uOB7POXiF4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-oL-WeAF5PT21di1wlGTLCQ-1; Wed, 01 Jul 2026 09:20:08 -0400
X-MC-Unique: oL-WeAF5PT21di1wlGTLCQ-1
X-Mimecast-MFC-AGG-ID: oL-WeAF5PT21di1wlGTLCQ_1782912007
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c128c8c345eso95500566b.0
        for <audit@vger.kernel.org>; Wed, 01 Jul 2026 06:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912007; x=1783516807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkyHBx8qc3TZHAZdVcz1ygge0E0qA4+vhFJQ0TyghSU=;
        b=Au0p//4KeNDVzFvjlgchHumc+upmw89CDTUzwzvpK+AEeQCrwmm+Nq9bYnyDqavFHi
         r3BgCoC4Y3ZS9FD8LaQ4qN0OG2g2RmJmR36OqS/mgziV3nThQ44eaVrt4wCFFgBCcY9X
         YbtTkh2tr/MSKFJkS0plFXAjUzzRk/tAdqIAN9JkZmoK4Y5HNo9V/vnT58/ssR9WCXLI
         qVxbIgYwi6qp8ZWIxX+ty/q6CUwfszmvW7/ez33eBn43oLpHYhEHtan5hKwsVRQECflY
         iJxeFrKby2mMJHHLYtVKriSLR2is2O6ev1JResQjUJP3cFtdVqDHgUYRlCruUcytxgGn
         a7Xg==
X-Gm-Message-State: AOJu0Yz2ERRn+ertRjtRky3jUqxpa4mqcPjnzD0WpUUmwPiZ6RfKbe2c
	xLtdX5bTCEs8dLj2Qe97gJTlrfDoholPsyKkTb8nzBxZQADAEPdwTjSUne7PdHocpDIeFvgTYL7
	r4Sg664XP9NRNfRI0P5amJvuR6uEbd82hk2XOJA+2IyYtbJ4VQSsi6v25HYdYEGi5WJ1FgZCwT9
	7J/qFsdaKiQyd3w/CQx1Jp0XE2qIJNwQOxkP5bUnBhpQ==
X-Gm-Gg: AfdE7clgp5yUT/JeplkAvuy01B4kC+7WaZfifLvzk59WC8/SyWdqb9L2ygI7uVt7VU0
	i8rTtxQbOJ/wTw45ad0zPb0zhV5xS8yYqH3AzrZjhFihEySolaqCmvsS0sppKc5/sR4MRqZc0Ko
	CKbWyWvN3KsRmRksCqnbYmCZ1fb9r/0Tjp2nOg2HRFZM1PI1GbrTngvnFCjDK2PdBbSZiDIqg3F
	/1POS8YR2x5gLpy/en5C10i66N+vunjIX9qteGi3bVJIhCiWOWOW1tT
X-Received: by 2002:a17:907:3c82:b0:bd2:15b5:bf60 with SMTP id a640c23a62f3a-c12a79b3ee4mr88566566b.3.1782912006963;
        Wed, 01 Jul 2026 06:20:06 -0700 (PDT)
X-Received: by 2002:a17:907:3c82:b0:bd2:15b5:bf60 with SMTP id
 a640c23a62f3a-c12a79b3ee4mr88566066b.3.1782912006564; Wed, 01 Jul 2026
 06:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630195242.367870-2-paul@paul-moore.com>
In-Reply-To: <20260630195242.367870-2-paul@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 1 Jul 2026 10:19:54 -0300
X-Gm-Features: AVVi8CdFni7dW1oIHQKDxp_uBxO7NsEqbjOT4q8HVkTqQf1YHsUS9DNTnga5hBM
Message-ID: <CAABTaaCG9xrLXsYoAx9QD85t8xkpveMXi_sBndz-7mbCmpZgBw@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: drop BUG_ON() from audit_log_XXX()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oqc2q7uae7FD2VE5xBDtS9eGfwOXU-EqDjpa2OfrtwY_1782912007
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> We can easily drop the BUG_ON()s from the audit_log_XXX() helpers and
> simply return to the caller as we do if we are passed a NULL
> audit_buffer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/audit.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index dcc657d35776..d05c92d74361 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2016,10 +2016,9 @@ void audit_log_vformat(struct audit_buffer *ab, co=
nst char *fmt, va_list args)
>         struct sk_buff *skb;
>         va_list args2;
>
> -       if (!ab)
> +       if (!ab || !ab->skb)
>                 return;
>
> -       BUG_ON(!ab->skb);
>         skb =3D ab->skb;
>         avail =3D skb_tailroom(skb);
>         if (avail =3D=3D 0) {
> @@ -2084,10 +2083,9 @@ void audit_log_n_hex(struct audit_buffer *ab, cons=
t unsigned char *buf,
>         unsigned char *ptr;
>         struct sk_buff *skb;
>
> -       if (!ab)
> +       if (!ab || !ab->skb)
>                 return;
>
> -       BUG_ON(!ab->skb);
>         skb =3D ab->skb;
>         avail =3D skb_tailroom(skb);
>         new_len =3D len<<1;
> @@ -2117,10 +2115,9 @@ void audit_log_n_string(struct audit_buffer *ab, c=
onst char *string,
>         unsigned char *ptr;
>         struct sk_buff *skb;
>
> -       if (!ab)
> +       if (!ab || !ab->skb)
>                 return;
>
> -       BUG_ON(!ab->skb);
>         skb =3D ab->skb;
>         avail =3D skb_tailroom(skb);
>         new_len =3D slen + 3;     /* enclosing quotes + null terminator *=
/
> --
> 2.55.0
>
>

Hi Paul,

It looks good to me. I agree that it was not worth panicking the
kernel in these cases.
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

I was taking a look at other BUG_ON instances and noticed a couple
that might benefit from similar treatment:

  1. In audit_add_to_parent() at kernel/audit_watch.c:375:
     BUG_ON(!mutex_is_locked(&audit_filter_mutex));

     Couldn't we use lockdep_assert_held() instead?

  2. In __audit_log_bprm_fcaps() at kernel/auditsc.c:2715:
     BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS);

     This could gracefully return an error instead of panicking.

I can send patches for these if you think they're worthwhile.

-Ricardo

