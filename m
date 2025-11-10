Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4930CD89
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777011; cv=none; b=cz816D16H/pWFKRW4cwPqkWGkd5df0IxGVVvvIBo7WY2ppAmV6+ONQfA6BL8Qv94b+jEZOL+Aupuim+4Od8IAztp0WvU4KuxPRI8zgjt0CCoG7gf7CkXPtHyjEVgFKvoQPUOw1pQEzyoOp3twmKOGObd9U+r4BQ8Prq+7jLfdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777011; c=relaxed/simple;
	bh=V4af1rYT9OtrMAix1yJfCa00gTPi64G1CMZK/upk2k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBNe9riSvA4uWTxXLWgFZKwGtOJqERoKrQDbjabTSMeDNdwALKBIHyFhjSVA14ogGSC9Xar/y3c/GhQreYnH944P9QnRsUhRiNLW3x+EvjGdwpyLPfqW3CeEgl0DUaYj6J58x2goLMoaGuhsY4Dz67xMl3iu+ybJbXUe1ebU5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPcnxLvo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPcnxLvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762777007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74+HnH+rhIexyx6g5es8cFazSWzppP2vcLxSnUPEPvM=;
	b=OPcnxLvoICRjU/sp0du/U/L8bw/AW/w7QRhl/yNsr84gew90uw+0kn5FnRscTKIFutQeR+
	TmCtlnVT898SysOVsgccFR+WhmQJzCiAoxM0OQNk+6pbfCwK4cvn6VwTBhieSMHdDCsNIG
	s2G+syo1AWArr9jn1eSwuCSTqw3X3Q0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-zMqTk2LDOwC9HLTk9njPWg-1; Mon, 10 Nov 2025 07:16:46 -0500
X-MC-Unique: zMqTk2LDOwC9HLTk9njPWg-1
X-Mimecast-MFC-AGG-ID: zMqTk2LDOwC9HLTk9njPWg_1762777005
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b72de28c849so241111366b.1
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 04:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777005; x=1763381805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=74+HnH+rhIexyx6g5es8cFazSWzppP2vcLxSnUPEPvM=;
        b=psn5gHbr8HhMCpGnP3KVhyBMASR+e06gekTiweYbuJAYdZw5fujRV9kUt3CNrDkF6g
         8pNf4w6Jn034Vc2513nkfCCqfIntEr6hfyOSz0ZE3qTQUZn4As/Vr2WZfksnHdNtabB2
         sWAkEV1rB26zZugZO814lsfpLMUfHHO8DZD39hWU77ytlTKSgqymi0ZvCg7PvtJAHCmm
         3S5Rbi3qRTdD/NVZKaJ+kEIy7zT0UDz5FlJfKIpCyKZLZOspz5zUmOz5y4RSPtS2bjhN
         RUguYu1EBng0GIR1yawf19wxnHQtMaIVGAXLF9zO99b41KJOo7BZ/+ZM1P4Qc0tEwm3X
         J+5A==
X-Gm-Message-State: AOJu0YzOC6olHXJ55ktXfeIJ9N+tzdLibhVSSsQqSumHnoGXp8vLIU6Q
	EHHqYZBEIyx7uL1cjMqAf2FGyCUQD++eKjhL+YXM9wLvLWulCWMzCJAgcPCAfrXfVMRXeWK0bWu
	+E0yfX3uGZZDfOW9wsyJQt+w5toOrk6uPDzYVHz2rUuh/ZOl5XMal8FRapVdhX7d2oLQMAO/s3s
	cicU4fJ8LDbLlIa1EayhoxCK7nphhDqTc=
X-Gm-Gg: ASbGncs6T9B1sevo/EZ9HRWxbXQLBUhLXdX0BJZOft8iB61IadskYG5wzETcOOFYORN
	q666PCrcvMxtP8Rp8SR9CEwPzyJa3AWxlcOD1OWqLfqoe0R0mbq2SM3F0iSHuBKEoZp+GPLzqN6
	oTa+doqSQ3YpEQo9OISuQGIj8WNmLL0xWYjFYD9gcmfUKmG7XkGuGUksg7HAqcUqBP/4G2f5okf
	aoN68GWvJzqWzfx
X-Received: by 2002:a17:906:ee8e:b0:b71:1164:6a7e with SMTP id a640c23a62f3a-b72e003924bmr875329866b.0.1762777004782;
        Mon, 10 Nov 2025 04:16:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhlJwu++LA0y6rHYS/X7Tkcx19E/oD+HEnPU1cI7qBA37rwKLUdQWUCTDNq1VIndy2ptAzXROTIVyAJWm7Ev0=
X-Received: by 2002:a17:906:ee8e:b0:b71:1164:6a7e with SMTP id
 a640c23a62f3a-b72e003924bmr875322766b.0.1762777003918; Mon, 10 Nov 2025
 04:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>
 <e92df5b09f0907f78bb07467b38d2330@paul-moore.com>
In-Reply-To: <e92df5b09f0907f78bb07467b38d2330@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Nov 2025 09:16:32 -0300
X-Gm-Features: AWmQ_bncMcE9PB4nKORFD7uOEDM8kBtbm971Ai2s5IVLXxLujIHjE41gMiPa2LI
Message-ID: <CAABTaaCVsFOmouRZED_DTMPy_EimSAsercz=8A3RLTUYnpvf_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] audit: add audit_log_packet_ip4 and
 audit_log_packet_ip6 helper functions
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7PazZdTtIRFdSDFsxeil7wt1z7OL8-xnOsPoVLa65lc_1762777005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Netfilter code (net/netfilter/nft_log.c and net/netfilter/xt_AUDIT.c)
> > have to be kept in sync. Both source files had duplicated versions of
> > audit_ip4() and audit_ip6() functions, which can result in lack of
> > consistency and/or duplicated work.
> >
> > This patch adds two helper functions in audit.c that can be called by
> > netfilter code commonly, aiming to improve maintainability and
> > consistency.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Acked-by: Florian Westphal <fw@strlen.de>
> > ---
> >  include/linux/audit.h    | 12 +++++++++++
> >  kernel/audit.c           | 39 ++++++++++++++++++++++++++++++++++++
> >  net/netfilter/nft_log.c  | 43 ++++------------------------------------
> >  net/netfilter/xt_AUDIT.c | 43 ++++------------------------------------
> >  4 files changed, 59 insertions(+), 78 deletions(-)
>
> ...
>
> > diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
> > index e35588137995..f53fb4222134 100644
> > --- a/net/netfilter/nft_log.c
> > +++ b/net/netfilter/nft_log.c
> > @@ -26,41 +26,6 @@ struct nft_log {
> >       char                    *prefix;
> >  };
> >
> > -static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
> > -{
> > -     struct iphdr _iph;
> > -     const struct iphdr *ih;
> > -
> > -     ih =3D skb_header_pointer(skb, skb_network_offset(skb), sizeof(_i=
ph), &_iph);
> > -     if (!ih)
> > -             return false;
> > -
> > -     audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D%hhu",
> > -                      &ih->saddr, &ih->daddr, ih->protocol);
> > -
> > -     return true;
> > -}
> > -
> > -static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> > -{
> > -     struct ipv6hdr _ip6h;
> > -     const struct ipv6hdr *ih;
> > -     u8 nexthdr;
> > -     __be16 frag_off;
> > -
> > -     ih =3D skb_header_pointer(skb, skb_network_offset(skb), sizeof(_i=
p6h), &_ip6h);
> > -     if (!ih)
> > -             return false;
> > -
> > -     nexthdr =3D ih->nexthdr;
> > -     ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(_ip6h), &n=
exthdr, &frag_off);
> > -
> > -     audit_log_format(ab, " saddr=3D%pI6c daddr=3D%pI6c proto=3D%hhu",
> > -                      &ih->saddr, &ih->daddr, nexthdr);
> > -
> > -     return true;
> > -}
> > -
> >  static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
> >  {
> >       struct sk_buff *skb =3D pkt->skb;
> > @@ -80,18 +45,18 @@ static void nft_log_eval_audit(const struct nft_pkt=
info *pkt)
> >       case NFPROTO_BRIDGE:
> >               switch (eth_hdr(skb)->h_proto) {
> >               case htons(ETH_P_IP):
> > -                     fam =3D audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> > +                     fam =3D audit_log_packet_ip4(ab, skb) ? NFPROTO_I=
PV4 : -1;
> >                       break;
> >               case htons(ETH_P_IPV6):
> > -                     fam =3D audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> > +                     fam =3D audit_log_packet_ip6(ab, skb) ? NFPROTO_I=
PV6 : -1;
> >                       break;
> >               }
> >               break;
> >       case NFPROTO_IPV4:
> > -             fam =3D audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> > +             fam =3D audit_log_packet_ip4(ab, skb) ? NFPROTO_IPV4 : -1=
;
> >               break;
> >       case NFPROTO_IPV6:
> > -             fam =3D audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> > +             fam =3D audit_log_packet_ip6(ab, skb) ? NFPROTO_IPV6 : -1=
;
> >               break;
> >       }
>
> We can probably take this a step further by moving the case statements
> into the audit functions too.  I think this will make some of the other
> changes a bit cleaner and should reduce the amount of audit code in the
> NFT code.
>
> If we don't want to do that, it might be worthwhile to take the
> NFPROTO_BRIDGE protocol family reset shown below in audit_log_nft_skb()
> and use that in the nft_log_eval_audit() function so we aren't
> duplicating calls into the audit code.
>
> [WARNING: completely untested code, but you should get the basic idea]
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 26a332ffb1b8..72ba3f51f859 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2538,6 +2538,59 @@ static void audit_log_set_loginuid(kuid_t koldlogi=
nuid, kuid_t kloginuid,
>         audit_log_end(ab);
>  }
>
> +int audit_log_nft_skb(struct audit_buffer *ab,
> +                     struct sk_buff *skb, u8 nfproto)
> +{
> +       /* find the IP protocol in the case of NFPROTO_BRIDGE */
> +       if (nfproto =3D=3D NFPROTO_BRIDGE) {
> +               switch (eth_hdr(skb)->h_proto) {
> +               case htons(ETH_P_IP):
> +                       nfproto =3D NFPROTO_IPV4;
> +               case htons(ETH_P_IPV6):
> +                       nfproto =3D NFPROTO_IPV6;
> +               default:
> +                       goto unknown_proto;
> +               }
> +       }
> +
> +       switch (nfproto) {
> +       case NFPROTO_IPV4: {
> +               struct iphdr iph;
> +               const struct iphdr *ih;
> +
> +               ih =3D skb_header_pointer(skb, skb_network_offset(skb),
> +                                       sizeof(_iph), &_iph);
> +               if (!ih)
> +                       return -ENOMEM;
> +
> +               audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D=
%hhu",
> +                                &ih->saddr, &ih->daddr, ih->protocol);
> +               break;
> +       }
> +       case NFPROTO_IPV6: {
> +               struct ipv6hdr iph;
> +               const struct ipv6hdr *ih;
> +
> +               ih =3D skb_header_pointer(skb, skb_network_offset(skb),
> +                                       sizeof(_iph), &_iph);
> +               if (!ih)
> +                       return -ENOMEM;
> +
> +               audit_log_format(ab, " saddr=3D%pI6 daddr=3D%pI6 proto=3D=
%hhu",
> +                                &ih->saddr, &ih->daddr, ih->protocol);
> +               break;
> +       }
> +       default:
> +               goto unknown_proto;
> +       }
> +
> +       return 0;
> +
> +unknown_proto:
> +       audit_log_format(ab, " saddr=3D? daddr=3D? proto=3D?");
> +       return -EPFNOSUPPORT;
> +}
> +
>  /**
>   * audit_set_loginuid - set current task's loginuid
>   * @loginuid: loginuid value
> diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
> index e35588137995..6f444e2ad70a 100644
> --- a/net/netfilter/nft_log.c
> +++ b/net/netfilter/nft_log.c
> @@ -75,28 +75,7 @@ static void nft_log_eval_audit(const struct nft_pktinf=
o *pkt)
>                 return;
>
>         audit_log_format(ab, "mark=3D%#x", skb->mark);
> -
> -       switch (nft_pf(pkt)) {
> -       case NFPROTO_BRIDGE:
> -               switch (eth_hdr(skb)->h_proto) {
> -               case htons(ETH_P_IP):
> -                       fam =3D audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> -                       break;
> -               case htons(ETH_P_IPV6):
> -                       fam =3D audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> -                       break;
> -               }
> -               break;
> -       case NFPROTO_IPV4:
> -               fam =3D audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> -               break;
> -       case NFPROTO_IPV6:
> -               fam =3D audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> -               break;
> -       }
> -
> -       if (fam =3D=3D -1)
> -               audit_log_format(ab, " saddr=3D? daddr=3D? proto=3D-1");
> +       audit_log_nft_skb(ab, skb, nft_pf(pkt));
>
>         audit_log_end(ab);
>  }
>
> --
> paul-moore.com
>

Thanks for reviewing this patch, Paul.

It makes sense to me. I'll work on a newer version addressing your suggesti=
ons.

