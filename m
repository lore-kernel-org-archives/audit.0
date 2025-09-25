Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0031CA46
	for <audit@vger.kernel.org>; Thu, 25 Sep 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832884; cv=none; b=nGaP8w3YC1g2t9wu9KPdm6JdGR6sPzr46gOr7No4kCpuud6mfYoN2n/TgLLBq7gd+c7m3azwksCj/j0U5iSy2QliHFnKpBVIQO20oYT6lHlNEMVl+3XZ/2qPvQMoATzojip3AqdQ8nfYuiStYxT7yTS7YaCxHLk+Rdxt0YxUnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832884; c=relaxed/simple;
	bh=5xpUyJ2gl48fAf8hgqBQ81QjAJ8R3hpi0dRccTCXKNw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=r15tw9Vp1nKqMgmDQXaiR9YrSrhFQbkcb7UnsAEulhwCQ489upPtmBh1KdL1qedB5Li0Qmezgh26fYxk/+YrQ00O4Y5Y7ILEa/8tDznKk6Pln/Fp2aSD/tCHKky+LpCYvhkO64lgUKUQE0ke8r/KmioQgBQ/f5cPWAzY3x4hN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UFXQ/kqP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UFXQ/kqP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8608f72582eso9525585a.2
        for <audit@vger.kernel.org>; Thu, 25 Sep 2025 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758832880; x=1759437680; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz8tMv7poCK+K+LZKXpitPO/IERpOcWNitjaxECk3cc=;
        b=UFXQ/kqPYvB2bJMrV4s63VaJ1plSKOk2E6ULSzAvJ2AruoYGwiKcOEmIT55i/wDEtV
         L/4pYbtv+v4m3sE4HdWnUtZBxBeKDpjEhrGl6FZfT8CNrmLavC2KkEtmKoTKv19grrXQ
         BuWwZ7MZ68oj/da++p+5zMQ8NiYULENHH82iv0u3Jr6kdkcbIu8qnNmBnM9JXiqAupxg
         lBnOQYKrsqJMcurddQfsg/ce5wMk/u90vjU5EE+QUVdAU1Vnoqo7HrTq6w68uFrkAsWo
         TtHaXu2P+/UOvfDleJAcVqnPH/JL5P5Gp2EtyEuoETEtMSX4ajRY9vb5yhBWIPRrtgS/
         R7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832880; x=1759437680;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wz8tMv7poCK+K+LZKXpitPO/IERpOcWNitjaxECk3cc=;
        b=LI0MdNZehTrKre+xKN0a/rbBCST1RMjy+F7rphM44R1n4taMahviTvjMSor1YLQYvs
         tB0arjP+y3E0cNa9EuGgSKYd6Mqc1tDGDD32oGebnrCDkBgOpEsUrqVi7BRLav18DM+1
         LriPX+SFUQm+z9JCMgltAPtNzfpADzDHjGorsWVyAmX0tz4y3jjhvB7SOxCGRjtSyiQW
         46PvbysiJEbTyTqh5VfmuAagntiaBhmzAV9NWrsXlyNWJ5GWudVLojfV1PI0YT/HEjjE
         Mw/wvCxY3ZdvL+5NaZAUTAevpARPuXScvz9l+6K9xrKH020MdHZXXe0OhMbKB9oePjHa
         R+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVoLVlpiBQc/UroRDUVDC2qElmXXSXRbBCxQx1pIJnLAS5iYt/BTZQY+OHzYFg5cwnu8uN0kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUojvCPrdrf/Lbptkzx0/oIccl5DpPYnwFr4FgZ9LQufBNxgh4
	YSl/gZBeGDcOph1G0SEtkdpyq9/5veSMEXvJUhndPVnvaDFv4GZEjPekw5KBPVIEXA==
X-Gm-Gg: ASbGncstlecEQDQdeAeIBANOA/Up/RgjSY1Nj4mPT8le4GlumE/l+0TwiqAxgM/FpYu
	gWZ7LqHLCtOdIpeLgK+/wWiSvBpPEg+Xg7TPMOv35LzYNn0SWUFv2/LggGyRlhS7BPs8EEUeiZm
	LAHzon9vv633IQLGgJrbG/+HQ8b0vOHM++KPkRlsez/xCB55IeON8VPlBxusNDYWdT8EAdHZJCM
	pk1nhdUZnk7/zXyrc2znFWc2flb8ayLagiB14Bccc+UymtNfDWmuEssJi0Xt922VMuITfGjlb/w
	zfh3KLnz+qn4BD1XVdnbf4lTma77l3iRsUI237f48ZiqyzRStYbj51UoAdXng5R8QNYXdy4SyiC
	CDGV2vWnexMoygMy4zqNd7rm1aaUl2vUJv3NfAvUxJvaSg+MSPyMBU6EpyYEwEln/fFY3
X-Google-Smtp-Source: AGHT+IFGQLFjIsyHXKrkMLf2hg2boloL2B947/OU1clxJUe5AMyIuuBuNbS2SxXWQLv1+YIsuUnJbg==
X-Received: by 2002:a05:620a:1aa9:b0:7e9:f81f:cead with SMTP id af79cd13be357-85ae95bb3afmr779265385a.71.1758832880002;
        Thu, 25 Sep 2025 13:41:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-85c2718e92fsm173048985a.9.2025.09.25.13.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:41:18 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:41:18 -0400
Message-ID: <c7a8d5f64e19f529a7595f26e150826f@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250925_1622/pstg-lib:20250924_1646/pstg-pwork:20250925_1622
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: eparis@redhat.com, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, ej@inai.de, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: include source and destination ports to  NETFILTER_PKT
References: <20250925134156.1948142-1-rrobaina@redhat.com>
In-Reply-To: <20250925134156.1948142-1-rrobaina@redhat.com>

On Sep 25, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> NETFILTER_PKT records show both source and destination
> addresses, in addition to the associated networking protocol.
> However, it lacks the ports information, which is often
> valuable for troubleshooting.
> 
> This patch adds both source and destination port numbers,
> 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> SCTP-related NETFILTER_PKT records.
> 
>  type=NETFILTER_PKT ... saddr=127.0.0.1 daddr=127.0.0.1 proto=icmp
>  type=NETFILTER_PKT ... saddr=::1 daddr=::1 proto=ipv6-icmp
>  type=NETFILTER_PKT ... daddr=127.0.0.1 proto=udp sport=38173 dport=42424
>  type=NETFILTER_PKT ... daddr=::1 proto=udp sport=56852 dport=42424
>  type=NETFILTER_PKT ... daddr=127.0.0.1 proto=tcp sport=57022 dport=42424
>  type=NETFILTER_PKT ... daddr=::1 proto=tcp sport=50810 dport=42424
>  type=NETFILTER_PKT ... daddr=127.0.0.1 proto=sctp sport=54944 dport=42424
>  type=NETFILTER_PKT ... daddr=::1 proto=sctp sport=57963 dport=42424
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/162
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  net/netfilter/xt_AUDIT.c | 42 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> index b6a015aee0ce..9fc8a5429fa9 100644
> --- a/net/netfilter/xt_AUDIT.c
> +++ b/net/netfilter/xt_AUDIT.c
> @@ -19,6 +19,7 @@
>  #include <linux/netfilter_bridge/ebtables.h>
>  #include <net/ipv6.h>
>  #include <net/ip.h>
> +#include <linux/sctp.h>
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Thomas Graf <tgraf@redhat.com>");
> @@ -32,6 +33,7 @@ static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
>  {
>  	struct iphdr _iph;
>  	const struct iphdr *ih;
> +	__be16 dport, sport;
>  
>  	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
>  	if (!ih)
> @@ -40,6 +42,25 @@ static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
>  	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
>  			 &ih->saddr, &ih->daddr, ih->protocol);
>  
> +	switch (ih->protocol) {
> +	case IPPROTO_TCP:
> +		sport = tcp_hdr(skb)->source;
> +		dport = tcp_hdr(skb)->dest;
> +		break;
> +	case IPPROTO_UDP:
> +	case IPPROTO_UDPLITE:
> +		sport = udp_hdr(skb)->source;
> +		dport = udp_hdr(skb)->dest;
> +		break;
> +	case IPPROTO_SCTP:
> +		sport = sctp_hdr(skb)->source;
> +		dport = sctp_hdr(skb)->dest;
> +	}
> +
> +	if (ih->protocol == IPPROTO_TCP || ih->protocol == IPPROTO_UDP ||
> +	    ih->protocol == IPPROTO_UDPLITE || ih->protocol == IPPROTO_SCTP)
> +		audit_log_format(ab, " sport=%hu dport=%hu", ntohs(sport), ntohs(dport));
>  	return true;
>  }

Instead of having the switch statement and then doing an additional if
statement, why not fold it all into the switch statement?  Yes, you
would have multiple audit_log_format() calls, but they are trivial to
cut-n-paste, and it saves the extra per-packet checking at runtime.

  switch (ih->protocol) {
  case IPPROTO_TCP:
    audit_log_format(ab, " sport=...",
                     tcp_hdr(skb)->source,
                     tcp_hdr(skb)->dest);
    break;
    ...
  }

... considering how expensive multiple audit_log_format() calls can be,
it might even be worth considering consolidating the two calls into one:

  switch (ih->protocol) {
  case IPPROTO_TCP:
    audit_log_format(ab, " saddr=...",
                     ih->saddr,
                     ...
                     tcp_hdr(skb)->source,
                     tcp_hdr(skb)->dest);
    break;
    ...
  default:
    audit_log_format(ab, " saddr=...",
                     ih->saddr,
                     ...);
  }

--
paul-moore.com
