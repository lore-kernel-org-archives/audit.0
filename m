Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FE43800D
	for <audit@vger.kernel.org>; Wed,  8 Jul 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535298; cv=none; b=C3V438k52hzQDXS/ypK9o48jXeiptPHJJ85tG4itvFK61+ZifiwIXqZL0DpdJJjfyYtUtQEseicC/6SE/XhJmA4i2smAXC0X7xZVOxmrnOYftKG/55ObveJvYi6zuAR+2ZwfYrIu27SHm1WzdHBfvYKyquHrYHrGWNS9sTSfoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535298; c=relaxed/simple;
	bh=/X9GXlqC0r4eyLIsmlyI0d4nG6zxhWJBQPdDC1a1rPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7UFwhXjBs9X8XjZQZcQJeppAkn8ZC7WaD1V/P+6/DUV7mWkelMJfvy5DGFdAPCRSw6PeKxnX8V69jqsrFvIBXqT2QzXbz+F03gIYfrx/6tVb5/I44dKBAlXXBZ4YeIwYuV4lS6nsFXKui2clP2MAh97l4FkmP+kvbseF2Cg1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+BrIzdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+BrIzdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783535296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjPUR/fBEQnSxUmu91cPfm7bBDoRx+HXFLWGKfkBsZc=;
	b=I+BrIzdksS6n8EIt06zwhaJ7M/QHc5pfUYcag0in1lxjJ2YN2q1Xtn9ygwPi9ZzFjXuS4Z
	8uesUMd8rpKT/CAJDNjHnHLSd/Om2it47qn/3g5+noVrsuk1eLUIxEnAa8UWBiZv7FnAr+
	vwfFQbgYTbCQVxtm97bvU3JpgM4xURg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-thcErLqJOA6HLF99ozZv-g-1; Wed, 08 Jul 2026 14:28:15 -0400
X-MC-Unique: thcErLqJOA6HLF99ozZv-g-1
X-Mimecast-MFC-AGG-ID: thcErLqJOA6HLF99ozZv-g_1783535294
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c126399a328so17255066b.1
        for <audit@vger.kernel.org>; Wed, 08 Jul 2026 11:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535294; x=1784140094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjPUR/fBEQnSxUmu91cPfm7bBDoRx+HXFLWGKfkBsZc=;
        b=XyKfIHN4SiCQ0vCy3Fkj8rUUeX0Bp7r4Y59s/Ena/ytTGYDImEXbSKvWarT9DV7d4o
         gscBazDxpDx5Mq3VBd3O99im7K1nfy6faYgORtS9B4bNDtdVk239xKj0EsQwAV1JugI6
         CcXtsj+YL8my/HYWsVQKyupQ1vFdboamp+XAuY9G9jN6W+xno8wRJXF6bAENBfYv9FGR
         8S+G5P128P8owO7ok/VZ8P/TkYsdamUZm3w6XCLjPqspb3B14Gw7Z7V10Lf6xTT+DGOd
         6D6FV31/yBG0lARyt8tE1VtLowNiv60urAT2p2osGIKME8RG5VJjzQXhSSqj2i+Zbd6g
         OG7Q==
X-Gm-Message-State: AOJu0YxR5HvpVEdgydNZSKF6Q2hWjakUr53EdEr265uce1AL9Aget7gZ
	OBDijlN7f/7WF5n2fkRv+oHvDlnrHzUssuXPXqTesToF6olKbmztxn+D6pauSEkwdsXSW4o0sGm
	Az+nSRkyXy77sBKzHWwYXXklUjQsx8pi4annKNR7eKjaQneASFAjOeuJ4gJ64+l245/oxyt6K4q
	WWerZTHlPnSFIhZb05SiEDAKXCXKe9RW0=
X-Gm-Gg: AfdE7cnUQTeWLaKLdKzoRQl6r2Cn41BoeaP5c2STuRo6hlrZETHoOsMZpA+J5tBeA5Q
	l+D5+zUO6odux3N+L3/nyh5gUlwHqeiAT2QvN4sN6Rxq1RqBgswUipPLggzdJI06RZR3nu1A+LB
	Xs0kzxEXvezQKjtFi0/ZwXtIubQ6CajvrxURXS8gHdZjt068g9ZqddJ7bHEdZhLa4EcVuznsbCj
	E6IfD847DxN6M2pIBtAymfO4+vuq9+yOvek2CHWHjf8J2ViwtzfhkZlxO42KGhVUD0UeSckWsp4
	4rlpcPZw9/Jf
X-Received: by 2002:a17:907:a43:b0:c12:1c2a:16e6 with SMTP id a640c23a62f3a-c15ce0b2f35mr167361066b.23.1783535294072;
        Wed, 08 Jul 2026 11:28:14 -0700 (PDT)
X-Received: by 2002:a17:907:a43:b0:c12:1c2a:16e6 with SMTP id
 a640c23a62f3a-c15ce0b2f35mr167360066b.23.1783535293734; Wed, 08 Jul 2026
 11:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702140411.1021373-1-rrobaina@redhat.com> <a0e1827116da6fc4c48a22957a0c6748@paul-moore.com>
In-Reply-To: <a0e1827116da6fc4c48a22957a0c6748@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 8 Jul 2026 15:28:01 -0300
X-Gm-Features: AVVi8CcsWLPuvbbbi3BYXWUhnYpt-Qzch2fW03-gOCJ1Nds75vsil90Qf08CGtI
Message-ID: <CAABTaaChPTar2ZyE6H3NYrP9sAJc6yaQb9D1TMWd5ULy23shTg@mail.gmail.com>
Subject: Re: [PATCH v3] audit: fix potential integer overflow in audit_log_n_hex()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	Richard Guy Briggs <rgb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FAWWzGS8ZylE-CoA0wLq0OOpuBMs3siUJN0IGOQhXMY_1783535294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 3:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Jul  2, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The function calculates new_len as len << 1 for hex encoding. This
> > has two overflow risks: the shift itself can overflow when len is
> > large, and the result can be truncated when assigned to new_len
> > (declared as int) from the size_t calculation.
> >
> > Fix by using check_shl_overflow() to catch shift overflow and
> > changing new_len and loop counter i to size_t to prevent truncation.
> >
> > Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> > Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> > Changes in v2:
> > - Use check_shl_overflow() instead of manual overflow check.
> > Changes in v3:
> > - Log "?" before returning when overflow detected.
> >
> >  kernel/audit.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e1d489bc2dff..52eb3b511bad 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -62,6 +62,7 @@
> >  #include <net/ip.h>
> >  #include <net/ipv6.h>
> >  #include <linux/sctp.h>
> > +#include <linux/overflow.h>
> >
> >  #include "audit.h"
> >
> > @@ -2076,7 +2077,8 @@ void audit_log_format(struct audit_buffer *ab, co=
nst char *fmt, ...)
> >  void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf=
,
> >               size_t len)
> >  {
> > -     int i, avail, new_len;
> > +     int avail;
> > +     size_t i, new_len;
> >       unsigned char *ptr;
> >       struct sk_buff *skb;
> >
> > @@ -2084,9 +2086,15 @@ void audit_log_n_hex(struct audit_buffer *ab, co=
nst unsigned char *buf,
> >               return;
> >
> >       BUG_ON(!ab->skb);
> > +
>
> I removed this added vertical whitespace as it wasn't really necessary
> and could potentially impact anyone who wants to backport this patch.
> Otherwise this looks good to me, so I'm going to mark it for stable and
> merge it via audit/stable-7.2.
>
> Thanks!

Thanks, Paul!

>
> >       skb =3D ab->skb;
> >       avail =3D skb_tailroom(skb);
> > -     new_len =3D len<<1;
> > +
> > +     if (check_shl_overflow(len, 1, &new_len)) {
> > +             audit_log_format(ab, "?");
> > +             return;
> > +     }
> > +
> >       if (new_len >=3D avail) {
> >               /* Round the buffer request up to the next multiple */
> >               new_len =3D AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) =
+ 1);
> > --
> > 2.53.0
>
> --
> paul-moore.com
>

