Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF32FFDDC
	for <audit@vger.kernel.org>; Fri, 26 Sep 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911355; cv=none; b=NQnzYAH1mmlTZqRU9hKhkRx+uHrTJnqr5zXuj41EuFH+9qWN3Qzq16uBAie+6asiH5B7nQkGCmZtchWCDSlrFjMjIF7DZNySDWL41q5ahGB5Z+9BXyRaqOs3wvgZF0ibJbRKmibBLjFDlEEBsYdgyfpNg+u4XXTe36kEef0jnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911355; c=relaxed/simple;
	bh=Fdtvwdou0j/HPLsynKl5haCoT9J7J98Gr4teoaFv51w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxGosMsrA6goT9V/g8l+zha/vNyRgmAasvTjEqgsSp7uIxX7wDI/Btv1yshEEKV3I5PZ2NEIVssPAjtsuGpAxU6Gim/D20ppQCD8aZfMvzK1I1NDOlTimsiMYof2/H0j8nFYvdy2d2KrfcLEuCA8TchaJOEoPFyzwLi6yxYconk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud+glv4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud+glv4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758911352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVK5hqYxqrcHg6x0vzf6zc77p/zTjdplz2xbifw60rg=;
	b=Ud+glv4wUhkuLSHv7FjFH+xxx3y30nzqiwCURVDnlRt9Y2iAXWHHDLiGrc+Ls/WeRJO3DC
	qJHptrBTwEL2NkuBVZpIKHU3UPORNB2ti5TOO3CO3KTn62YSgqclEnl0v0xWOrNKAiqlcf
	3fIZpD7FdW1pv1C/41WJyEnu/4rjtso=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-PbIrpITUOCWUL_jgFTsz2Q-1; Fri, 26 Sep 2025 14:29:11 -0400
X-MC-Unique: PbIrpITUOCWUL_jgFTsz2Q-1
X-Mimecast-MFC-AGG-ID: PbIrpITUOCWUL_jgFTsz2Q_1758911348
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b35543aad5cso211907066b.2
        for <audit@vger.kernel.org>; Fri, 26 Sep 2025 11:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758911348; x=1759516148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVK5hqYxqrcHg6x0vzf6zc77p/zTjdplz2xbifw60rg=;
        b=mJvVF+sVnFJ1WCwXg8F2Rz79r0CptbNQiV5UhRsyHuIyWvsT6vC6VbnFAogTXASB7n
         +KsfCRyEj+zeeTDkDg7Bz9VGCtoUIJ7e867vsERQbbAae3p7YXk+pmPFNa0bKfDGohK6
         XAJK52QWbAjdJWjxFKPtKN/nMixSgbHQ1/Qekb9m914u2L05EsLhFcmE/Izu0dIiJ6Bm
         AMGxKYHJm1sSDEaPmCMgR8vwC/YjxpI+xGZzSTMSNA0POVuXJJ/PqLAqZC0gbVIBm8uV
         EdAhQyd/gwQtHF4jOI9sgdBQJu7egVKqZ9CctckVpEbFhBDce/j6mjqOhFjxmQgenj3y
         guMA==
X-Gm-Message-State: AOJu0Yz+pcpiyAgwC6mjuyxOqPK75xU+7oKNDdTKV2TWRASESVIHPqqH
	olf7n7TaPOgLSeojrbNN0PtUuBDQf1Kjb2W0HJloJnSY8EPHfRF6jT2QpmXlwKAL0LHMo3OEzoH
	CN4nBvZhthPKgT3mQHAV3bf5gIbLV5qV1T5UmuPkR3xOfe1+h2ZCruKq4KAYUz387CT/mJxsUxc
	rBtnQELVw1orOkXxGCzrMQQggQHuEk03M=
X-Gm-Gg: ASbGncveTSgVlIad82I93N8WlnlUMNrlEQ9NlqKkxJUzXtMORAFYchKkRyEj0kIvUw1
	PV86TqzPW9JMKo1UBPbLKwF3kdssrDiJgAODRhjiXTx08DGC3h4F9K7I5XQs9aaQzpXvk/FmW5L
	DPaFdj3HmtTJ8q3z9eTXhS7XR+wTWlgebyPPzRnbRuGUihnKjWCMWo1A==
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b34ba93ce11mr909046666b.39.1758911348362;
        Fri, 26 Sep 2025 11:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8NPueb5nCMT5DuPssEE6Gyfl/L/QQSo2uJ/kLrAnQWxWWz6E92b3DZ9NPm4ViF0aNX+BwD71pWnwRFHvSZHo=
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id
 a640c23a62f3a-b34ba93ce11mr909043066b.39.1758911347929; Fri, 26 Sep 2025
 11:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925134156.1948142-1-rrobaina@redhat.com> <c7a8d5f64e19f529a7595f26e150826f@paul-moore.com>
In-Reply-To: <c7a8d5f64e19f529a7595f26e150826f@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 26 Sep 2025 15:28:55 -0300
X-Gm-Features: AS18NWDStEem2dFQRSusMMoOLIwVwIMaAYTG9PMRNMPg6ucZ8NhwQ2lffaOUJ4g
Message-ID: <CAABTaaC9tSJ2Say6RHiQ3Ffm-xo4g-Ld3r83GwUBYZ5STs-hCA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, ej@inai.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tq9sL4oXIqC8rbBjmInWJp7IuO_QW81fdx0KaBchyK0_1758911348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing this patch, Paul! Sounds great, I'll work on the
v3 shortly.

On Thu, Sep 25, 2025 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep 25, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > NETFILTER_PKT records show both source and destination
> > addresses, in addition to the associated networking protocol.
> > However, it lacks the ports information, which is often
> > valuable for troubleshooting.
> >
> > This patch adds both source and destination port numbers,
> > 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> > SCTP-related NETFILTER_PKT records.
> >
> >  type=3DNETFILTER_PKT ... saddr=3D127.0.0.1 daddr=3D127.0.0.1 proto=3Di=
cmp
> >  type=3DNETFILTER_PKT ... saddr=3D::1 daddr=3D::1 proto=3Dipv6-icmp
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dudp sport=3D38173 d=
port=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dudp sport=3D56852 dport=
=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dtcp sport=3D57022 d=
port=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dtcp sport=3D50810 dport=
=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dsctp sport=3D54944 =
dport=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dsctp sport=3D57963 dport=
=3D42424
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/162
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  net/netfilter/xt_AUDIT.c | 42 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> > index b6a015aee0ce..9fc8a5429fa9 100644
> > --- a/net/netfilter/xt_AUDIT.c
> > +++ b/net/netfilter/xt_AUDIT.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/netfilter_bridge/ebtables.h>
> >  #include <net/ipv6.h>
> >  #include <net/ip.h>
> > +#include <linux/sctp.h>
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Thomas Graf <tgraf@redhat.com>");
> > @@ -32,6 +33,7 @@ static bool audit_ip4(struct audit_buffer *ab, struct=
 sk_buff *skb)
> >  {
> >       struct iphdr _iph;
> >       const struct iphdr *ih;
> > +     __be16 dport, sport;
> >
> >       ih =3D skb_header_pointer(skb, skb_network_offset(skb), sizeof(_i=
ph), &_iph);
> >       if (!ih)
> > @@ -40,6 +42,25 @@ static bool audit_ip4(struct audit_buffer *ab, struc=
t sk_buff *skb)
> >       audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D%hhu",
> >                        &ih->saddr, &ih->daddr, ih->protocol);
> >
> > +     switch (ih->protocol) {
> > +     case IPPROTO_TCP:
> > +             sport =3D tcp_hdr(skb)->source;
> > +             dport =3D tcp_hdr(skb)->dest;
> > +             break;
> > +     case IPPROTO_UDP:
> > +     case IPPROTO_UDPLITE:
> > +             sport =3D udp_hdr(skb)->source;
> > +             dport =3D udp_hdr(skb)->dest;
> > +             break;
> > +     case IPPROTO_SCTP:
> > +             sport =3D sctp_hdr(skb)->source;
> > +             dport =3D sctp_hdr(skb)->dest;
> > +     }
> > +
> > +     if (ih->protocol =3D=3D IPPROTO_TCP || ih->protocol =3D=3D IPPROT=
O_UDP ||
> > +         ih->protocol =3D=3D IPPROTO_UDPLITE || ih->protocol =3D=3D IP=
PROTO_SCTP)
> > +             audit_log_format(ab, " sport=3D%hu dport=3D%hu", ntohs(sp=
ort), ntohs(dport));
> >       return true;
> >  }
>
> Instead of having the switch statement and then doing an additional if
> statement, why not fold it all into the switch statement?  Yes, you
> would have multiple audit_log_format() calls, but they are trivial to
> cut-n-paste, and it saves the extra per-packet checking at runtime.
>
>   switch (ih->protocol) {
>   case IPPROTO_TCP:
>     audit_log_format(ab, " sport=3D...",
>                      tcp_hdr(skb)->source,
>                      tcp_hdr(skb)->dest);
>     break;
>     ...
>   }
>
> ... considering how expensive multiple audit_log_format() calls can be,
> it might even be worth considering consolidating the two calls into one:
>
>   switch (ih->protocol) {
>   case IPPROTO_TCP:
>     audit_log_format(ab, " saddr=3D...",
>                      ih->saddr,
>                      ...
>                      tcp_hdr(skb)->source,
>                      tcp_hdr(skb)->dest);
>     break;
>     ...
>   default:
>     audit_log_format(ab, " saddr=3D...",
>                      ih->saddr,
>                      ...);
>   }
>
> --
> paul-moore.com
>

