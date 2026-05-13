Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DD429831
	for <audit@vger.kernel.org>; Wed, 13 May 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686791; cv=none; b=dOxoxBlUAGzGIG9dluoXLG98iZ0VJLO3wPSLgBLiJyGql8MEKhNRM5MoYoqath6qe7Isr4JsrC5G0fBDd5ZyOOva0x65rIkUcrSIYc+lD16tHn7ow0OH0j5cuGCWWqBUebH6z9kGxOUuLHRejMuo/ZD5KSS6IzUPjPpUZP8Zphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686791; c=relaxed/simple;
	bh=I6CRyv67nDUME5VvRLFuqsc58wOTMq7M6YaCgoHOEwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVIvzhXLfAqgDIxbMW9rI8QezUuHosWz9kCM49Jv6I3Ruf0tygRfCp2MXLFC6Pay/PHFg4n9+qq37ZaToerr+1Unxmh0eMNhiMO/X8mqS2j04WqYstJKDuMqKHSJW6Yh3V0um0AOpGnj+7tTLLcpuUTsWz+dSioza2/HuNEI+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wpz6TKW5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpz6TKW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778686789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
	b=Wpz6TKW5c92MLIegUQzKAuoITmu3CaYxr1eMf1YVyzIzzSW2wicUumyR5IPKQckYBp96VJ
	kyLHECUiv3oMZYNSI+FVlGeimfZ5q3Ln7+32bY8jlBBJSk9lxQhOXpZ/uolLUXFanc9xC3
	tOWFWQ9g5RzJ5xv7DGjea4EqpIxt5co=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-hpffnR8GMRC0eEvgfoJHCQ-1; Wed, 13 May 2026 11:39:48 -0400
X-MC-Unique: hpffnR8GMRC0eEvgfoJHCQ-1
X-Mimecast-MFC-AGG-ID: hpffnR8GMRC0eEvgfoJHCQ_1778686787
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bcf0db7c5b3so329337266b.1
        for <audit@vger.kernel.org>; Wed, 13 May 2026 08:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686787; x=1779291587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
        b=mq+rKeonH2g1O0yUm77vj9gNM3gQWeCoGAcGgHNW7wSjt09bktEmUQONxFgWM+EWSC
         sN2mjQA5zBOgiMKFfqYhpqw8NcUAaqW4yRV69Wcao/WN7YoXdHbins7T1EO3iAlrJdHC
         eMFjIbsFnCs2e49qNPXCCbYHMBNk0TenEZyDIHX+dKWMDfgG+J8KTmfQeoGGj3Mtvfvb
         K92TPNsIAb3cdyLDQ68LlU6kRqvLYg0jDht8ctH/dtot26LGlNFFVFRUuAWVrHKBvgxl
         0VYqJ0X3VoTjjPD3s5PwrAM7DqTTp9jaJB2yTQUwTUFeTRJwKPwkkWMU3BFQCfPWIGId
         EBiw==
X-Gm-Message-State: AOJu0YzHNaGhluVqPVimN1OX/T8qet/cRUB+8AfNDp2dvNfsqKP/UNg3
	De14xq3MJVge+JifQSbr5TZzaHBZbSNiXUuO48iN700psMyDkLP2UQEuVEZN9LMJiR3YT9hDjTo
	+tPOX5O3PI2Q7RuR9czIZ5taT8YlEgmmgrszzuAMQ30oPpMjur5GiCFmV/8Xe5W7poj5K7WX1rc
	wUCSea37CEwl7k54BJ/yYDWpfr7B5gZCg=
X-Gm-Gg: Acq92OHFs9ShAPmfh4MBJ0aG/+b36saQyhTJhWbVctN5L/oakbOG308OG0E2G0y61Hp
	qSIQmcoaZLIwDtQFPYTf4TO+4p12jLEwyShAb9Rv2PMERLPgyNQreXGfAE84nW5QSzrLOQxz3J2
	HYYZH/OH9LqGANEZkDdQI17+T9Y1nqSoed6uYypJcT/4IQNDzGxdZJA9Ax3nxcuYJPrEZ5fo0gZ
	Mz5WL2NE2PsBTL+ViNXopbatAzeLNEHpT8wuAxgshJFVKzG6knHCGk+0FBx9Fn7+h2XkMzJy7u+
	E2ejEq8O2NCXCXi6Lgy+GJo=
X-Received: by 2002:a17:906:730a:b0:bab:b930:474d with SMTP id a640c23a62f3a-bd3dfb5e659mr240249266b.1.1778686786785;
        Wed, 13 May 2026 08:39:46 -0700 (PDT)
X-Received: by 2002:a17:906:730a:b0:bab:b930:474d with SMTP id
 a640c23a62f3a-bd3dfb5e659mr240245466b.1.1778686786238; Wed, 13 May 2026
 08:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511184338.392420-1-rrobaina@redhat.com> <9802a1edc2f809440603350047f202e3@paul-moore.com>
In-Reply-To: <9802a1edc2f809440603350047f202e3@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 13 May 2026 12:39:34 -0300
X-Gm-Features: AVHnY4LvvCa0_cKymVrIA8eBbpHhIGvAvi3Lc-Gh0oHKmJHppjzn0OwWfWOkiZ0
Message-ID: <CAABTaaAPx62gWTwMAa-O6bKXihv6eDHQFQq7D2=vrNhAO5gLrg@mail.gmail.com>
Subject: Re: [PATCH] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, eparis@redhat.com, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PBE4NgwdEF1PLsdjxMt1xuHMw72v7CXOxH-TuASaEJw_1778686787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 11, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket. If the wait timeout fully expires (timeo =3D=3D 0),
> > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > request. It then triggers netlink_overrun that drops the event,
> > completely bypassing the audit subsystem's internal retry queue, and
> > falsely returns ENOBUFS to user-space, resulting in the following error=
:
> >
> >  auditd[]: Error receiving audit netlink packet (No buffer space availa=
ble)
> >
> > Convert the `nonblock` argument in netlink_unicast() into a `flags`
> > bitmask and introduce NETLINK_UNICAST_TIMED. When a caller specifies
> > this flag and exhausts its timeout budget, netlink intercepts the
> > zeroed timeo state. Instead of defaulting to an overrun condition, it
> > safely frees the skb and returns -EAGAIN, allowing the audit subsystem
> > to gracefully enqueue the pending event into its internal backlog.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/netlink.h  |  5 ++++-
> >  kernel/audit.c           |  8 ++++----
> >  net/netlink/af_netlink.c | 17 +++++++++++++++--
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> > index 882e9c1b6c1d..1888c8ee416a 100644
> > --- a/include/linux/netlink.h
> > +++ b/include/linux/netlink.h
> > @@ -226,7 +226,10 @@ void netlink_ack(struct sk_buff *in_skb, struct nl=
msghdr *nlh, int err,
> >  int netlink_has_listeners(struct sock *sk, unsigned int group);
> >  bool netlink_strict_get_check(struct sk_buff *skb);
> >
> > -int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 porti=
d, int nonblock);
> > +/* Internal flags for netlink_unicast (do not overlap with MSG_* flags=
) */
> > +#define NETLINK_UNICAST_TIMED 0x80000
> > +
> > +int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 porti=
d, int flags);
> >  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 por=
tid,
> >                     __u32 group, gfp_t allocation);
>
> ...
>
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 2aeb0680807d..acaa96695981 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1325,14 +1325,17 @@ static int netlink_unicast_kernel(struct sock *=
sk, struct sk_buff *skb,
> >  }
> >
> >  int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
> > -                 u32 portid, int nonblock)
> > +                 u32 portid, int flags)
> >  {
> >       struct sock *sk;
> >       int err;
> >       long timeo;
> > +     int nonblock;
> >
> >       skb =3D netlink_trim(skb, gfp_any());
> >
> > +     /* Extract blocking mode: strip internal flags, preserve MSG_DONT=
WAIT */
> > +     nonblock =3D flags & ~NETLINK_UNICAST_TIMED;
> >       timeo =3D sock_sndtimeo(ssk, nonblock);
> >  retry:
> >       sk =3D netlink_getsockbyportid(ssk, portid);
> > @@ -1351,8 +1354,18 @@ int netlink_unicast(struct sock *ssk, struct sk_=
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
> > +             if (!timeo && (flags & NETLINK_UNICAST_TIMED)) {
> > +                     kfree_skb(skb);
> > +                     return -EAGAIN;
> > +             }
>
> Is the new flag needed, couldn't you just check to see if a non-blocking
> operation was requested and do the same?
>
>   if (timeo =3D=3D 0 && !nonblock) {
>     kfree_skb(skb);
>     return -EAGAIN;
>   }
>

Hi Paul,

Thanks for reviewing this patch. You're definitely right, it seems I
overengineered the fix.
I'm just doing some final testing, and I'll post the V2 shortly.

> >               goto retry;
> > +     }
> >       if (err)
> >               return err;
> >
> > --
> > 2.53.0
>
> --
> paul-moore.com
>

