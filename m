Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A17299A81
	for <audit@vger.kernel.org>; Fri,  7 Nov 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555584; cv=none; b=b0kF6gTMtxLd302eQq785MStfxnYAD+deyxsN+MollN1rdlGwvlEuaoQWSI9+AYvSd+NieKyYyoHwd5cZ6Iqozi9x34vQ2NqdjyR1muUpX0aQJpOeOs2S4qCwtGLycRdGoUpKzIqxCcygfrVd333Ira8c/AzFSPBbav7lgDK2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555584; c=relaxed/simple;
	bh=Iw0djrGj0E1EeAmzCQwmf4P9quCFdn1G1qnajo2IswA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bs+FhupRuNPJ4REBxR8ntPpKnURVstCn6YluIIglewlEnXTQhBI+KXcVFnwBlpxCRzQFE5tGScekwSV1ZGeCdKwGoiBXB2LSKLmuevpQj6ZyYK1IfZRjJ7n5ITOAgPfrsMa9DmHtYj2p+wS60EQyMdjgStYKBnR4PS4L2jWVKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y37ErSiH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y37ErSiH"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed8e22689dso7642321cf.1
        for <audit@vger.kernel.org>; Fri, 07 Nov 2025 14:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762555580; x=1763160380; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLmOflXkVRsPG430Y/bM1DxcagZMiyutQotB6mJKGqY=;
        b=Y37ErSiH4Isan3caNYKDLIEIsV77MBpWe/YiN+tvF/g0CpXXvUE3DSr4FHkaDjvm37
         HU25KiqHTNV60ZiCsYzOMvS1HJruZknV8Pwwfro4xSXUV/nWQg8uSd7UfWvLjYOq58bF
         yQUClq9RlHRYpObM41GxH9NnxWe+wMg2j77RDBWG1zExYLuh+dPNWC9Lj3U2AOqK+DMx
         KVknOFKG3FceXGCpSQEYE0ux3POONuMPreTSV2q+q1D29sc5EBuoOMRJfAzVGR0mWKvL
         LpYT1KBfsIpV3HbpzGgZAtVseewMON6p3Kog9y+tFzi5/hzsn1B+/O5Noe/OqS6ngot1
         tshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555580; x=1763160380;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLmOflXkVRsPG430Y/bM1DxcagZMiyutQotB6mJKGqY=;
        b=jcWf5GMgTp1FyrS7gv5mKZoUcUYQS52MCXn5QcEf6zUmiBmyEg1V/BPV9UbtsgiVpN
         nA6DgJLYn4Uw/OfMYzpANY9dKa/BMXS3UarjFUPil4DL0Y1NV++nXKQXwQkjf+zv0LFx
         eYo6bGdXewgUV90ja7zJirkllwHgTa9Jt7PNymdvt7n9o6ptw+litpmoZquxJM5kp26C
         VrJTsu5tw58NKZuY7gvtK+ejmDFSvrTKiqrDi9hkZBvXzMWHrC4bG0OTBxjx8OuLWyBz
         G9VPUcZjWJxUsztu8VgRlSFAg9MpDIh6Pq7s4MV0rlLap55IWGapj4JGHIWtiNnv6INc
         7XDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWqWXhoHbrnJ4IXX+rvai8t+QgdQZLa2CKziM7QP7OLkXKxFJXwNNh6+bTvGLeg0ZP2TAyhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94l8sCKoutotxpgUrdjqBmJ2toVEGx+SsbEU3GqfRgApCCnKd
	EsMHCEpKKZh4A5Eni1UsyJh+pTkfVv3c3VOV9feHsx526vGwxWJ+6nnjl1hHs3XxUg==
X-Gm-Gg: ASbGncvGazAe3h8N7KuQDr/+6rTYFT2Masxm7XMWpa2dLmjYpokm4EsE+KY8G+JRVd4
	I3r9W9gd0eBvHlq5Zm1qkhZdY7oZ075MAN8u/ameL5ohAAwgnYC6npLQ2nDilmJlTk9UXNa2jL5
	994OAcRXBC05RByJqLIjUhpcidK0O7qIfLssEV7FElFBqEYdYc1UmlGjur5z7E8sjDJ2TuUtO8J
	DQ0xVJVfk7YaklGkb1fAXQMVmd7DiG5JiVh71QXSTy4gH4P+jmKMHre2oiOAL3bfljMliTR8H38
	oeTVJUad5srFSa+w9cZG5SFWwBlIeTUp9PHT8mpdhrmLni9bzaLwBeBAuLRtayfhh4ivU2cMjPY
	n0ucvkzOK+904VEGl64yJxhs+Y1kVnm49ZUOGi+ifucOj4RHuia60JV1MihRxhyqgpyo3ugqD3E
	4Lja/bh8971IDA6h6HGJ6nnWCBhwh+zmMIQ8MKRKnTnrLQkQIX5QCXU5sG
X-Google-Smtp-Source: AGHT+IHrQn8HXQkHpkHyR17I/vgJvQDZ3PvcxfyB/9NyJzEb8+tk8bEQSW8kbFzruHMF1M4pLru8Dw==
X-Received: by 2002:a05:622a:1455:b0:4eb:a2ab:4175 with SMTP id d75a77b69052e-4eda4fa3eebmr10623901cf.39.1762555579930;
        Fri, 07 Nov 2025 14:46:19 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda56132c0sm3554831cf.7.2025.11.07.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:46:19 -0800 (PST)
Date: Fri, 07 Nov 2025 17:46:18 -0500
Message-ID: <e92df5b09f0907f78bb07467b38d2330@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251107_1737/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: eparis@redhat.com, fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v5 1/2] audit: add audit_log_packet_ip4 and  audit_log_packet_ip6 helper functions
References: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>
In-Reply-To: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>

On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Netfilter code (net/netfilter/nft_log.c and net/netfilter/xt_AUDIT.c)
> have to be kept in sync. Both source files had duplicated versions of
> audit_ip4() and audit_ip6() functions, which can result in lack of
> consistency and/or duplicated work.
> 
> This patch adds two helper functions in audit.c that can be called by
> netfilter code commonly, aiming to improve maintainability and
> consistency.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Florian Westphal <fw@strlen.de>
> ---
>  include/linux/audit.h    | 12 +++++++++++
>  kernel/audit.c           | 39 ++++++++++++++++++++++++++++++++++++
>  net/netfilter/nft_log.c  | 43 ++++------------------------------------
>  net/netfilter/xt_AUDIT.c | 43 ++++------------------------------------
>  4 files changed, 59 insertions(+), 78 deletions(-)

...

> diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
> index e35588137995..f53fb4222134 100644
> --- a/net/netfilter/nft_log.c
> +++ b/net/netfilter/nft_log.c
> @@ -26,41 +26,6 @@ struct nft_log {
>  	char			*prefix;
>  };
>  
> -static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
> -{
> -	struct iphdr _iph;
> -	const struct iphdr *ih;
> -
> -	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
> -	if (!ih)
> -		return false;
> -
> -	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
> -			 &ih->saddr, &ih->daddr, ih->protocol);
> -
> -	return true;
> -}
> -
> -static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> -{
> -	struct ipv6hdr _ip6h;
> -	const struct ipv6hdr *ih;
> -	u8 nexthdr;
> -	__be16 frag_off;
> -
> -	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_ip6h), &_ip6h);
> -	if (!ih)
> -		return false;
> -
> -	nexthdr = ih->nexthdr;
> -	ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(_ip6h), &nexthdr, &frag_off);
> -
> -	audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
> -			 &ih->saddr, &ih->daddr, nexthdr);
> -
> -	return true;
> -}
> -
>  static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>  {
>  	struct sk_buff *skb = pkt->skb;
> @@ -80,18 +45,18 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>  	case NFPROTO_BRIDGE:
>  		switch (eth_hdr(skb)->h_proto) {
>  		case htons(ETH_P_IP):
> -			fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> +			fam = audit_log_packet_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
>  			break;
>  		case htons(ETH_P_IPV6):
> -			fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> +			fam = audit_log_packet_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
>  			break;
>  		}
>  		break;
>  	case NFPROTO_IPV4:
> -		fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
> +		fam = audit_log_packet_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
>  		break;
>  	case NFPROTO_IPV6:
> -		fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
> +		fam = audit_log_packet_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
>  		break;
>  	}

We can probably take this a step further by moving the case statements
into the audit functions too.  I think this will make some of the other
changes a bit cleaner and should reduce the amount of audit code in the
NFT code.

If we don't want to do that, it might be worthwhile to take the
NFPROTO_BRIDGE protocol family reset shown below in audit_log_nft_skb()
and use that in the nft_log_eval_audit() function so we aren't
duplicating calls into the audit code.

[WARNING: completely untested code, but you should get the basic idea]

diff --git a/kernel/audit.c b/kernel/audit.c
index 26a332ffb1b8..72ba3f51f859 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2538,6 +2538,59 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
        audit_log_end(ab);
 }
 
+int audit_log_nft_skb(struct audit_buffer *ab,
+                     struct sk_buff *skb, u8 nfproto)
+{
+       /* find the IP protocol in the case of NFPROTO_BRIDGE */
+       if (nfproto == NFPROTO_BRIDGE) {
+               switch (eth_hdr(skb)->h_proto) {
+               case htons(ETH_P_IP):
+                       nfproto = NFPROTO_IPV4;
+               case htons(ETH_P_IPV6):
+                       nfproto = NFPROTO_IPV6;
+               default:
+                       goto unknown_proto;
+               }
+       }
+
+       switch (nfproto) {
+       case NFPROTO_IPV4: {
+               struct iphdr iph;
+               const struct iphdr *ih;
+
+               ih = skb_header_pointer(skb, skb_network_offset(skb),
+                                       sizeof(_iph), &_iph);
+               if (!ih)
+                       return -ENOMEM;
+
+               audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
+                                &ih->saddr, &ih->daddr, ih->protocol);
+               break;
+       }
+       case NFPROTO_IPV6: {
+               struct ipv6hdr iph;
+               const struct ipv6hdr *ih;
+
+               ih = skb_header_pointer(skb, skb_network_offset(skb),
+                                       sizeof(_iph), &_iph);
+               if (!ih)
+                       return -ENOMEM;
+
+               audit_log_format(ab, " saddr=%pI6 daddr=%pI6 proto=%hhu",
+                                &ih->saddr, &ih->daddr, ih->protocol);
+               break;
+       }
+       default:
+               goto unknown_proto;
+       }
+
+       return 0;
+
+unknown_proto:
+       audit_log_format(ab, " saddr=? daddr=? proto=?");
+       return -EPFNOSUPPORT;
+}
+
 /**
  * audit_set_loginuid - set current task's loginuid
  * @loginuid: loginuid value
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index e35588137995..6f444e2ad70a 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -75,28 +75,7 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
                return;
 
        audit_log_format(ab, "mark=%#x", skb->mark);
-
-       switch (nft_pf(pkt)) {
-       case NFPROTO_BRIDGE:
-               switch (eth_hdr(skb)->h_proto) {
-               case htons(ETH_P_IP):
-                       fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-                       break;
-               case htons(ETH_P_IPV6):
-                       fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-                       break;
-               }
-               break;
-       case NFPROTO_IPV4:
-               fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-               break;
-       case NFPROTO_IPV6:
-               fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-               break;
-       }
-
-       if (fam == -1)
-               audit_log_format(ab, " saddr=? daddr=? proto=-1");
+       audit_log_nft_skb(ab, skb, nft_pf(pkt));
 
        audit_log_end(ab);
 }

--
paul-moore.com
