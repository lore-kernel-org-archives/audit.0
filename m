Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF7284662
	for <audit@vger.kernel.org>; Wed,  1 Jul 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914116; cv=none; b=oQcd6aE14MUf4mhbD4gJewRnc0bWQ3LZgJsaMmoB0Rp7p/5PyyPgoB4qjebCb9KvAlNzQxnYdL6RSwbp3ZFwpFx5LldOLVmYZOyqsbWqemlOyJ6840KY5DMOO56UmmJb1+iQAb1FCjMS8FRTelhrCkj/KyePx3E5ebEG5vZWrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914116; c=relaxed/simple;
	bh=9gMIgBSK8AzbuUWOnc1kg3vKC8E7aF6rpMROxXcgLuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swEVe48T2UbmkEvkS+i/IQDw3wZvd/llADj+4U7SjdUHRPonCtYaLbjkgGJKCqiHXQGSGCEvNNdk5KN0rSz/r0l1OzZHFQjKJGRUTdcMr+seCKOaAW6mgQYwJ8N3yP91MxSXv0lfqVEcOG9huE4MpZJni+sIV92R857ynl9wS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkJj4gOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkJj4gOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782914114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bxdp6mr62qs3aRo7Zblr6lfZErmZkvpHmcI9vIEmWoE=;
	b=ZkJj4gORFQpS7I8WP+motPju7p4xLWTgE+JDmgzhMzzI3DyfIzVM56fomC+TCC+UzHJQEy
	Oq4n7nLn53YgKRHiLul+zD/uLo7Lb4LRbZYjB5fW+PbYCxsuWnS0n+1AhI51d21LJArsYd
	ZBgvj0Bo2xAonW/B80+jNcif/giPfDE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-uX0BiNUsNIGkzkEnu0TDBA-1; Wed, 01 Jul 2026 09:55:13 -0400
X-MC-Unique: uX0BiNUsNIGkzkEnu0TDBA-1
X-Mimecast-MFC-AGG-ID: uX0BiNUsNIGkzkEnu0TDBA_1782914112
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c126f9928f6so86377866b.0
        for <audit@vger.kernel.org>; Wed, 01 Jul 2026 06:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914112; x=1783518912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bxdp6mr62qs3aRo7Zblr6lfZErmZkvpHmcI9vIEmWoE=;
        b=bCt4EKFWT2c5eLCWQHA/jmbbbkI7LxhYxy9q2ldUbo4Eggut9ewHYP13syCv1IguZZ
         FOsylq568k6IOronAuvzoJ2aHWZqWDGj+B+L9UsNPLdtzYpnQF+vo3Lj6f4beyld13Xi
         oYvF0HwlYdOFE4ezFUPOuUi1sqYSrA1piC3UAxfAemv7puX7vpPcZ137lzkH9IYq8i7K
         T9YZ5jIwO/ck+n15gcO6KSeHdTwzgRhA3hrdNUTi/eE4ECG7lOMpcnpz3a4ZQIk9poyZ
         Qbo7eozAXGiBuLNqgiwhqNTCUXm8Zody9nBzKz0j87NFvDlO0pZPJBfi3RXodxIdykC6
         iAcg==
X-Gm-Message-State: AOJu0YyP/yuh5BnjQEMJCXfzgXRYt4QTHW9B5ErO3jIjSyMIDJ0j+JGx
	EQzjhx/4ehY244f3hMPaFdqA9sedtbp0MsZV/G6seauBsv4VroNeVmD3XZY0vAJfBwJBFXcD8u7
	Txz0fCKA8J9ER6QtzlZbFIhjNYmKiVR/ho2QOQ4CNWwH6ynf1it/nuXtlUYo68VdIXIvdkxm9+l
	Kyc4vxMe5v7qtzNhdnISIZTsH5fzhAYBs=
X-Gm-Gg: AfdE7ckedW4s/cNo/B+BZjTfaMjFOzsc21/n1DAoJtHoLxvipg2b+Tm0pYtw6WgQuwp
	hXgr6S8u77bGc99YvcO+AUKnO+V3UlGhuCh0JfiYX7zuj8paQqaPuLNCiKSe8kaP+pFSFJ77Zgt
	K41JKreb0vXrxs3Lja2HIMxRcs4sw+uR//ERetTz8owoqDNnXk99vgIFI+6pgkhEcjAoToYPHZ9
	0sCPdvxf1GwZsgocm2S6YAaR70+vphguZQTDn6/kQatFCyOHj1ZOGT6
X-Received: by 2002:a17:906:6a27:b0:bfe:ed06:5a20 with SMTP id a640c23a62f3a-c12aa19afa9mr96479366b.53.1782914111560;
        Wed, 01 Jul 2026 06:55:11 -0700 (PDT)
X-Received: by 2002:a17:906:6a27:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c12aa19afa9mr96477566b.53.1782914111126; Wed, 01 Jul 2026
 06:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601130951.1418695-1-rrobaina@redhat.com> <51c2895ec46ea6df1b5763bb78c32fc3@paul-moore.com>
In-Reply-To: <51c2895ec46ea6df1b5763bb78c32fc3@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 1 Jul 2026 10:54:59 -0300
X-Gm-Features: AVVi8CdkQ6Zcz95zFJ4LrBIW-QjcqnNpvhLhUM_v7-JBi1JptPH1t2xE5j-l2aY
Message-ID: <CAABTaaAXJRSws12G6ZF0YYvqMt6eK0WyxtRrC2mr4WkieQd0vw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix potential integer overflow in audit_log_n_hex()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A3zv4Cy8XZvmem1R_b8Pna_xFAB_pAIr19ql7DM4G98_1782914112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jun  1, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Changes in v2:
> > - Use check_shl_overflow() instead of manual overflow check.
> >
> >  kernel/audit.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e1d489bc2dff..8ca268610641 100644
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
> > @@ -2084,9 +2086,13 @@ void audit_log_n_hex(struct audit_buffer *ab, co=
nst unsigned char *buf,
> >               return;
> >
> >       BUG_ON(!ab->skb);
> > +
> >       skb =3D ab->skb;
> >       avail =3D skb_tailroom(skb);
> > -     new_len =3D len<<1;
> > +
> > +     if (check_shl_overflow(len, 1, &new_len))
> > +             return;
>
> By returning without logging a value I worry we could end up with an
> oddly formatted audit record, e.g. "... A=3Dfoo B=3D C=3Dbar ...".  Inste=
ad of
> simply returning, should we log a '?' for the value and then return?
>

It makes sense, Paul. I'll send a new version shortly.

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

