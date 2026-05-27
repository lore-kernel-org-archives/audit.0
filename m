Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9C37648F
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910023; cv=none; b=nioj/vV6g2S5AUs1sO1b7b6ZyP0mot/GTnLkMV+TPYR3q4HWjNfWtebuLSOAx18t1Dk4z3b/uidRb/9V6ZqcCp+Zz+31FMSEK0uIJJzaV2zASlGTGjm+huPVzlW0UcPoR5wDH+vbmZXbJkkbYNSVt5EQ6unV0HuJwqkmgcMQ044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910023; c=relaxed/simple;
	bh=tRyD8S/7RSDfaZDKPuW63Y75gzxAnkDJsrt5x6tXdl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHiIP3IG2wor4XBkqAiiPjF3iOyqZ7a5W4Kgad5SJGUXTPCNqbUXWOH+RaAzF1AnzE064IEe0ubZuPSVGfoFxIOeHWMgHVeb4KzcLVwdghwVED9HuBdAESBEpAltSTLIqR+j+VGu7aMQeIyoZSAJuYy/ZFv3euyYBB5/ZKuChGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcY0Nv87; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcY0Nv87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
	b=gcY0Nv87hZb1UldloeylwUMle8Pvc9SOKvLOldstbb8SQLYFcaVAtlxrhOsBmLOCDGYjsc
	uTHCXfy3AE/D3AFPv3hrahIUYsojXe/8zvREDwdXahid3xft91XY7/PnULXbu8eW7igwPB
	Dp+eADtqJRh2QdJsaIVYheIUiOnwYkM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-BIwieAGoN7KApRXpjpfgnA-1; Wed, 27 May 2026 15:26:59 -0400
X-MC-Unique: BIwieAGoN7KApRXpjpfgnA-1
X-Mimecast-MFC-AGG-ID: BIwieAGoN7KApRXpjpfgnA_1779910018
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdaf3ed080dso857320966b.0
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910018; x=1780514818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDgC1+ol0lrg6Hw8wi9KK+95vBs3YsLQwxjbK9FkMtQ=;
        b=FuPXOX3eSO+JZBQous6iH5TWXTr3Nk2TcaCmSwoeP8PSTAs+8hzpK64bMhBmbNzS7p
         rcfcBlGr9Ge4YL70qBmFwnECb6EOUjMYcAzoVJbNdKFWlLFxnw7P9/gdk4c3C1sy4TIq
         Jc7kRNB2OyV3RpWuxwECqAKt6MBTqwhuJmlbJ8+jSF27mE3fMPVgO3BzoUwvMy1K1i+e
         WLnJStr5jz5oyjw2XC1PJMqsjzwoR+Zchli3Q1axquufNm15TKn9u9RAGl5TegiR/8su
         JMI4Zhn0SGsI10HiugRtCACdOuc1Ly8NecQ9nFwm2wgsyGh14psMZXGvX+tDLGtD7MAs
         Sh9Q==
X-Gm-Message-State: AOJu0YwbZWC8UIip7WhuHZdcL8MLeAMZfuFFsLtGrtufw2fXQ5UrFQ2s
	3tbzAquCbwlwSFaUcSa6ILMSHOQzjU97AFwNu9h/7kGlls8h2CebyWkq+z60lQxroDBcZFkhMkL
	MAVrK3UkYCjhxHWWUe6yncjk2H4r8E8T/z+K8tX2JJ1Vq1IBkQAP1xiWmnSUtPvigedl9BrUuv1
	gRfwKv1mvqV6NmqPn/DpMbEE3zMWgE3v4=
X-Gm-Gg: Acq92OGaDkK38jnOWOWVxoCyw1UI+rGMJf8LkPzo1THPo1ZvHyZu6ExUldw4wwTouYO
	UzQJmEwOEtNR4T1u4MxhJn54DmP4QoBQMCwKbtEmM+gf9pGIX1D3/rezHEt7nJx0ZSffId7YKde
	NV97A0YhYN8N4/K/JX6BZCl24q/ApPy0YwBDmInIDSUh27StS8Ptc7D24r+QacBIaMf+2bmFjOv
	nYqGUSjJIfYCGsaZRJ70B142NkAKNA5FExSA0DcQTtBinz/qAzoXn9QuJG5p56/f2iyjuH7EKSP
	cFn6AXAvNlq5d6+PBQrkwupV0zLjMOM6o1M=
X-Received: by 2002:a17:907:d40f:b0:bd5:7c2:70c9 with SMTP id a640c23a62f3a-bdd281aad31mr1622130866b.47.1779910018054;
        Wed, 27 May 2026 12:26:58 -0700 (PDT)
X-Received: by 2002:a17:907:d40f:b0:bd5:7c2:70c9 with SMTP id
 a640c23a62f3a-bdd281aad31mr1622129366b.47.1779910017620; Wed, 27 May 2026
 12:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518110345.497489-1-horms@kernel.org>
In-Reply-To: <20260518110345.497489-1-horms@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:26:46 -0300
X-Gm-Features: AVHnY4K-reI0086BeMjQSycAAft71q3cHtqRbjZQbDcDy0iRCMsusMf0JXZo2uE
Message-ID: <CAABTaaA-nzvY8Ki1Lx56BOei+ppgBRZ35Bn=zR1jJ77u=V9ZrQ@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Simon Horman <horms@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sgrubb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m9VLC2BdG1aeDtn47sY8-BnUk_dweaJQS0G97VwRsSM_1779910018
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> netlink, audit: prevent false ENOBUFS on timeout expiry
>
> This commit modifies netlink_unicast() to return -EAGAIN when a blocking
> sender's timeout expires. This bypasses the netlink_overrun() call to
> allow the audit subsystem to gracefully enqueue the pending event into it=
s
> internal backlog without falsely returning ENOBUFS to user-space.
>
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1351,8 +1351,18 @@ int netlink_unicast(struct sock *ssk, struct sk_=
buff *skb,
> >       }
> >
> >       err =3D netlink_attachskb(sk, skb, &timeo, ssk);
> > -     if (err =3D=3D 1)
> > +     if (err =3D=3D 1) {
> > +             /* timeo may have been zeroed by schedule_timeout inside
> > +              * netlink_attachskb. If the caller is a timed-blocking s=
ender
> > +              * (not genuinely nonblocking), don't re-enter with timeo=
=3D0 as
> > +              * that would misfire netlink_overrun on the next iterati=
on.
> > +              */
> > +             if (timeo =3D=3D 0 && !nonblock) {
> > +                     kfree_skb(skb);
> > +                     return -EAGAIN;
>
> Could this regression cause silent packet drops in non-audit subsystems?
>
> While this change prevents false ENOBUFS for the audit subsystem, other
> subsystems like InfiniBand's IWPM use rdma_nl_unicast_wait(), which sets
> nonblock=3D0 and operates on a kernel socket with a timeout.
>
> If the timeout expires because the receiving user-space daemon is
> bottlenecked, this new path will free the skb and return -EAGAIN without
> ever invoking netlink_overrun().
>
> Without netlink_overrun(), the receiver's socket error is never set to
> ENOBUFS. Would this prevent user-space from being notified of the dropped
> message, leading to permanent state desynchronization between the kernel
> and user-space?
>
> > +             }
> >               goto retry;
> > +     }
> >       if (err)
> >               return err;
>

Hi Simon,

Thanks for reviewing this patch!

You are correct that the timeo =3D=3D 0 && !nonblock heuristic in v2 relies=
 on
an implicit assumption about finite sk_sndtimeo. While RDMA/IWPM with
MAX_SCHEDULE_TIMEOUT would never reach this path in practice, your concern
correctly identifies that the heuristic is not surgical enough.

I've submitted v3 [1] with an explicit NETLINK_UNICAST_TIMED constant
(value 2). Callers must explicitly opt into this contract, leaving IWPM and
all other subsystems completely untouched:

if (timeo =3D=3D 0 && nonblock =3D=3D NETLINK_UNICAST_TIMED)

This ensures zero risk of silent drops or state desynchronization in other
subsystems. Does this address your concern?

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo

