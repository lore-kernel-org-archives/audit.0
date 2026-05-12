Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899029A9C3
	for <audit@vger.kernel.org>; Tue, 12 May 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614509; cv=none; b=m+icUjB7BIonQnHWPpbRN5X/squHGzAQ6m1LjgvVtRCRXTmfj7nIAi1mhXeweVuUf90Oj2MhsWnPcfiwRMdMPNWXY9LEkXWNr8USurASQK0WrENne+bh8Gn7uza8kwgHlhTenv4x96/NIj6Y8tFPxximBal4OmNcfDJdd4atd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614509; c=relaxed/simple;
	bh=S4wW6/Y46Y0a4i8sGqOp4I9+omdyKdRc1kTvmuz5V0I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=iOG/f4NKxJsZG8I5UhbiwjtfVvoxkE5OCLXh6NgB+D5jiHvjMYZouAAU8n6IyC+vi+CxjJ4vJQwe0/2Y31yoiH5utb/m8md5wRvIXEIsOMBbwLCIPcRq3wu4Q3g80TtUE0RrwduTeP4j3k1zaCJ0KQ1NlaovSkTPS1QkpiVLk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FKG6n4/s; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FKG6n4/s"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d87c138e1so57869121cf.1
        for <audit@vger.kernel.org>; Tue, 12 May 2026 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778614506; x=1779219306; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/Q6Ou9TsmZSI0RfxJsraqfWm/exdDDGlYUlxSjoHfo=;
        b=FKG6n4/stcs+xDyEFzIcppeJ++pv7HdI8SDXlgzmHtyH5tCeB3CgJvFhsogleg5qpv
         m74z0mgRQlYQ63H1GjNx+nBBnNiT1ZZX97bp9YAm+qq0zRRyPVjwTP5GSyj4qCrM0mE9
         ESyOuhXt05wN/nAfoyax8yKST1vl0V90Jojzqv5ash2Wni1mHk6APVFDvx4Bw6udmbbT
         Y4UFNTnagBzev7ngkmR64G+mbbRlB/Y1xmaSTUvb/mG+zf1R1KFepB3I1YnczeX7Pdc3
         UMihh6bj6Fy8So8IaMfiENh2H1mADLMoWVOFCr6vDWyMH6Wc6qyB+wX9wtpageZGal8w
         UySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614506; x=1779219306;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Q6Ou9TsmZSI0RfxJsraqfWm/exdDDGlYUlxSjoHfo=;
        b=Tr+2QeuPQ12xTiiEcwUJec4CQc7xwH444IwSZN2P/qqoSiIlDvsESR0wMc7hZ7wlfW
         PvvMeub6ykzozXuVji0fhtVzvgWqb5b6aWM+Qf0QOJpxeQTLpUXl8eEeScvIuCruUK/H
         21HY4sbBneJLJBsMweChxx8FSWirICLlNCFX6xTMLKGolT3qEoa0XA7aMG6mi1HNcC7K
         kuWj+lp1VEpCMhzzugWoeZFHmA44HnixQ0iNtV6cgXNDAhVt9KCE9g5aZcw7m1kNk89g
         i1VqJiRNJ7+3r9Js57rao43G+vXLZW7Ix5iaSNLXmPwKI1WBIyKNxlThBdv7E10HmtrN
         qT8g==
X-Forwarded-Encrypted: i=1; AFNElJ85MexN/iJPDTAZjKPwvg9NL63Riul2nF8HAmOG6Kkpp6RygUb+dkN2XpHj1+G8R7aFJKOJ/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YysYpTJhYE6QjOVA8lLmldcGimGzSCUM0OzawfVpMpgSYxNN3xT
	6Fs87T6JFa+xF84f/qHN8CGqTzo+HsPhtQrfjHvL7YXoDyx7/LSf0j6gaxFhxfCI8A==
X-Gm-Gg: Acq92OHG/7MQsmcj0d2z/rtFGs+bgJhQAhdkEzQc75MQvMJoD+rrwuJUEgAcLbms0t5
	yT3CQk0d57CrSnrCiO9vV/dgl8E3YE5zbnQP2L/6INcIUqDZ6maFATkMJgoKQRCsYJ/OsCUAQKL
	6xT53TFFzLXpNF0BZkniTLJMRoHqPaJJzAJam/eLuCYVHxisaVnbe/K60wgVy8VeoLoNUykt6uC
	MLhO46y9sIKZf3Q/7yQJHwDkFAAyrKJj4aUmOg4AKtFLn9JIMm01UYVrgPXmPCroP+4oThXxgIe
	AIq0iVhS41Bjh9NzVUiaRxDBo9BGB3xTLkostu8WppbiZ65NZavGdQ8Vsq5PsnQESBRMjxlGupt
	QLpfFA4EIIIVpPYtK3bEikalMHjysn7PbtMX/ZPEGu9+UbAJ4OHDk5XSdrllgA3CHwTprBXKeTW
	N3Ur3t8oWsa2c0ghbnklw2WQRe9ogluAurk269hvo5/9XudciCYxv7gx0G0bK/088qvzJ3ptwRe
	3Datxg=
X-Received: by 2002:a05:622a:6185:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-5162f443405mr816771cf.2.1778614506439;
        Tue, 12 May 2026 12:35:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf34asm136319601cf.14.2026.05.12.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:35:05 -0700 (PDT)
Date: Tue, 12 May 2026 15:35:05 -0400
Message-ID: <9802a1edc2f809440603350047f202e3@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260512_1209/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: eparis@redhat.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, Ricardo Robaina <rrobaina@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH] netlink, audit: prevent false ENOBUFS on timeout expiry
References: <20260511184338.392420-1-rrobaina@redhat.com>
In-Reply-To: <20260511184338.392420-1-rrobaina@redhat.com>

On May 11, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> the netlink socket. If the wait timeout fully expires (timeo == 0),
> netlink mistakenly interprets the zeroed timeout as a non-blocking
> request. It then triggers netlink_overrun that drops the event,
> completely bypassing the audit subsystem's internal retry queue, and
> falsely returns ENOBUFS to user-space, resulting in the following error:
> 
>  auditd[]: Error receiving audit netlink packet (No buffer space available)
> 
> Convert the `nonblock` argument in netlink_unicast() into a `flags`
> bitmask and introduce NETLINK_UNICAST_TIMED. When a caller specifies
> this flag and exhausts its timeout budget, netlink intercepts the
> zeroed timeo state. Instead of defaulting to an overrun condition, it
> safely frees the skb and returns -EAGAIN, allowing the audit subsystem
> to gracefully enqueue the pending event into its internal backlog.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/netlink.h  |  5 ++++-
>  kernel/audit.c           |  8 ++++----
>  net/netlink/af_netlink.c | 17 +++++++++++++++--
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 882e9c1b6c1d..1888c8ee416a 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -226,7 +226,10 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
>  int netlink_has_listeners(struct sock *sk, unsigned int group);
>  bool netlink_strict_get_check(struct sk_buff *skb);
>  
> -int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
> +/* Internal flags for netlink_unicast (do not overlap with MSG_* flags) */
> +#define NETLINK_UNICAST_TIMED 0x80000
> +
> +int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int flags);
>  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
>  		      __u32 group, gfp_t allocation);

...

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2aeb0680807d..acaa96695981 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1325,14 +1325,17 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
>  }
>  
>  int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
> -		    u32 portid, int nonblock)
> +		    u32 portid, int flags)
>  {
>  	struct sock *sk;
>  	int err;
>  	long timeo;
> +	int nonblock;
>  
>  	skb = netlink_trim(skb, gfp_any());
>  
> +	/* Extract blocking mode: strip internal flags, preserve MSG_DONTWAIT */
> +	nonblock = flags & ~NETLINK_UNICAST_TIMED;
>  	timeo = sock_sndtimeo(ssk, nonblock);
>  retry:
>  	sk = netlink_getsockbyportid(ssk, portid);
> @@ -1351,8 +1354,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
>  	}
>  
>  	err = netlink_attachskb(sk, skb, &timeo, ssk);
> -	if (err == 1)
> +	if (err == 1) {
> +		/* timeo may have been zeroed by schedule_timeout inside
> +		 * netlink_attachskb. If the caller is a timed-blocking sender
> +		 * (not genuinely nonblocking), don't re-enter with timeo=0 as
> +		 * that would misfire netlink_overrun on the next iteration.
> +		 */
> +		if (!timeo && (flags & NETLINK_UNICAST_TIMED)) {
> +			kfree_skb(skb);
> +			return -EAGAIN;
> +		}

Is the new flag needed, couldn't you just check to see if a non-blocking
operation was requested and do the same?

  if (timeo == 0 && !nonblock) {
    kfree_skb(skb);
    return -EAGAIN;
  }

>  		goto retry;
> +	}
>  	if (err)
>  		return err;
>  
> -- 
> 2.53.0

--
paul-moore.com
