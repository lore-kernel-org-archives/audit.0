Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20EE3921C6
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911841; cv=none; b=qVyK0dFYWUFz9h6aksiZ41pxglnM4UL7NYQ7cS/Mccd2U8eWlaRDHF4IxJ8ODpDP4BFC91GAEr8uuh/hRQQuwMTAXdL9uSnL6wB4CAVGLpdjWmyhHXQtW9Nv+oBEFvfokXJJOJHvOfOToM10sc2eJ6sVvoN/kOfeGcrmDoimPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911841; c=relaxed/simple;
	bh=aruSpNODQaLSQH/pzlnyL4L+ZnwUDSiamvqLiEAfghs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6kO5lkBlecXFXmaiR2+AZh77G0PD6D8UpiAWqvPHxRIki6y4ip/60Ix4hblCciMfM7WBjj3B1B1Q7CKfYjopI/sDSRq0fCZP7l8+b0ZoL2VrUM4Cw50/2nKEDvsHzCnTfclIcA7lcdIDsZWZDjtMX0RgUn2z1RdxTeeq3w8wwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2ReOwa3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2ReOwa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779911838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOYi3rvWWHyooYs/4UGsZJ5J8qhxTlsyZLp9S1gGCik=;
	b=Z2ReOwa3zKjsSen+ue25Y17tjs0AftliW39u6h4FpQmxcjCqb1NTitnhRx2/tMH+r6KAZV
	QWvRZXjR7xGn9ZiCYUIAY2YvQByNFTe27FyLQJTFMND2/5JmuvCVyShBj9V2OpOkCI1CtX
	Jkby4zeCo1m7zHcpzG8Sf73Nrm6TObc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-mMXDS1RyPIGSodf455gk_w-1; Wed, 27 May 2026 15:57:14 -0400
X-MC-Unique: mMXDS1RyPIGSodf455gk_w-1
X-Mimecast-MFC-AGG-ID: mMXDS1RyPIGSodf455gk_w_1779911833
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-be11d23cff4so356803166b.3
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911833; x=1780516633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOYi3rvWWHyooYs/4UGsZJ5J8qhxTlsyZLp9S1gGCik=;
        b=eAcQPx7R9pvVHw16L/Gju1HHmuGgaaopWJ98aFXqzKQ+Qg/1k28fsqjYN4U2mf6zmm
         Yl3mn+2B3UfAIFe9+oez6UuDGXw9a00c5wQ5hFNwPMyAFvk5i4Lrp9Dico0WaLcNPkMS
         3DasQUUvrrVMMUIkM59v8TC4EJ40vUBkniVuRd93MMogGA9q4k1olxpTH4XL93EO1Qwr
         LcoQHqEfOypctNseBGY5oEp0Mdntbgo5URVNBYOOHuJBo2EOYJDt7HHZ7XmJ0DgSskvi
         l9bjkk6ochBzUrFQtl/0l69bpq8fV9NtNFx7kwyKUlNbxOnZVMjih9EgSNUgT4IIGEWN
         NDOg==
X-Gm-Message-State: AOJu0YwqBG68LE9Ve3uC7jdTyci8J9wo/U1hjVIYl9bmV9MFxZbsGR8W
	k5T50oHYwbHdOzqriaIpp5xGVWp8Me+Osd7blHxHBrhVx92PuTRUQRy0O4K7DgbzCQr/AhZxCWd
	IbsrUCYkgJSELKGF7wf7OdNaoMxV2FOUNQKu+NhZ4OWUoEmU/z2T3y6Hm7aR9FepLzTP1nqsaNj
	sxvjmwKBNci3Ov7wPdvz8bKB5Bqp1PORM=
X-Gm-Gg: Acq92OGk7tEbl4mZpPhrpEvd6MESDoKeFZymx+k2Ea3uYqknyiq+JTfjeM7rMI9oueA
	PJQAI6T00wx7tY4OK2ugu+6kubh6f5YiHYhlT+lHAXNtNKYsRpWa57Eepp1dQ1Kr89Vs9HygmmO
	9z+JQQEjxENXBk2gKAGO60mgn4kWWdolfFx9vVqdvtSqJ9mlVM3gLaFbSyhPx7oc/fZCAkrmQUo
	TDzEB8YzzeW6Nlo/lu2rG2QVXSdNcW4WgFQAdNe5GrfYqA6VP4FZsyB+0Go5THFtM0+rcgVKLlH
	6+E7Nxu3aq4Mwteb62q6WAEuZ67jHEXidFg=
X-Received: by 2002:a17:906:c112:b0:bd4:4593:33bb with SMTP id a640c23a62f3a-bdd269b6a60mr1636524966b.43.1779911833211;
        Wed, 27 May 2026 12:57:13 -0700 (PDT)
X-Received: by 2002:a17:906:c112:b0:bd4:4593:33bb with SMTP id
 a640c23a62f3a-bdd269b6a60mr1636523566b.43.1779911832763; Wed, 27 May 2026
 12:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513130843.790380-1-rrobaina@redhat.com> <c94ce54e232d50dcfc7cef9ada654ed7@paul-moore.com>
In-Reply-To: <c94ce54e232d50dcfc7cef9ada654ed7@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:57:01 -0300
X-Gm-Features: AVHnY4Jb7QeXuTJuHg4XqkTuDPTwC64RSHcxE8Kig2D0e7N0mC17KX_js3wS360
Message-ID: <CAABTaaCKdD3xncfsQG7BZCiaNsvjpRV2RYk-pH9fPNuCo8Oy6A@mail.gmail.com>
Subject: Re: [PATCH] audit: fix potential integer overflow in audit_log_n_hex()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3lZML5GSSqV4I_LcJZHIBpCXKe_k49bt4dXSTWWFlVI_1779911833
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The function audit_log_n_hex() calculates new_len as len << 1 to
> > account for hex encoding, where each byte becomes two characters.
> > However, when len is passed as size_t but new_len was declared as
> > int, this could lead to integer overflow for large values of len.
> >
> > Additionally, the bit shift operation itself could overflow if len
> > exceeds SIZE_MAX / 2, leading to incorrect buffer size calculations
> > and potential memory corruption.
> >
> > Fix this by changing new_len and loop counter i from int to size_t
> > to match the len parameter type, preventing signed/unsigned mismatches,
> > and by adding an overflow check before the bit shift operation that
> > calculates len << 1.
> >
> > Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/audit.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e1d489bc2dff..32ac50996451 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2076,7 +2076,8 @@ void audit_log_format(struct audit_buffer *ab, co=
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
> > @@ -2084,9 +2085,14 @@ void audit_log_n_hex(struct audit_buffer *ab, co=
nst unsigned char *buf,
> >               return;
> >
> >       BUG_ON(!ab->skb);
> > +
> > +     /* prevent new_len overflow */
> > +     if (len > SIZE_MAX / 2)
> > +             return;
> > +
> >       skb =3D ab->skb;
> >       avail =3D skb_tailroom(skb);
> > -     new_len =3D len<<1;
> > +     new_len =3D len << 1;
> >       if (new_len >=3D avail) {
> >               /* Round the buffer request up to the next multiple */
> >               new_len =3D AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) =
+ 1);
>
> I might suggest using check_shl_overflow() instead, mostly because it
> helps document a shift that could potentially overflow.
>
> --
> paul-moore.com
>

Thanks for reviewing this patch, Paul. Sounds like a good idea, I'll
work on a v2 shortly.

-Ricardo

