Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824576;
	b=EIlm0LikB+6mXOoyfZsK3McnRD8/y3liT1J3Hu1O+c1Xlc7F/CcEHy5lOF98ZidSZ5qM
	 YzaXKCTKqyUTwys0Lgit8k+/dz8xEoauN5RdZpihUSx0kaE7uEP1345WSv5dPjsx/kc/u
	 SpFSBGwamMsZRSItagfH/vzMikQQN8hICsrnV4WQNgjd7JCQGdvwk0nJVeYy+XOJ8h/GP
	 oQba3Wsg+6i2OkIkx5IilKUiY2zr1LPW7mBYRfnzpkInRQrK/y3WQKlov9nZi79Pt0467
	 uP6DybaAk6hE4UcqQCFNocYK0SBjDSXPG4uqWtaP7cb3VDEKOxeUOXO0V7ILgmkPTWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
	b=DVDKeJbbnQ++fLp+uLOblSkuFxtphJw2lWDeLZ9f37WLLQhgg907G8ds7mDdwaFAcBxX
	 WID6I/MW/W0d0hktqgQ2c+fV14ewZOi2xhhJOH0MOE24vqtoBq8o0H0TTEXiy0JkmKKIx
	 /1bwjDGmJmZoxdW3b3IGqVqnLnOiEk+FueMJA/Td+VgGn2NCHFxNg2Xy1ToMzZN5FgwSH
	 /6jUK01xPwCNimsv4FznnwKxSSk3xLz8E4LSmDITJv5GZt243FHrL3K0lVNHJtEr1BeBT
	 INNN2aE+tYXmwuPeaKZULnC6FJcIeLCdwwgengFPeBt0oiIdu6Llh42tXDH+dQBO+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=awiKX9MW;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211D6075245
	for <audit@vger.kernel.org>; Wed,  4 Nov 2026 20:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D211D6075245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=awiKX9MW
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-537548b811aso8436831cf.3
        for <audit@vger.kernel.org>; Wed, 04 Nov 2026 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793824574; x=1794429374; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
        b=awiKX9MW+jQ/pdyMQdy5h1Kdt8Ffbv5vW1j2PVua0fdRVCyzRn/omf16XlmjmEm1ZP
         73LSi8BQEugNpgM5sLZtYBz7MnLwufSsK557NzaoyuzhS/B4FmyVGl3VtGXEoIyky50L
         9AE+frPji8xMLgNEJ276X4Hyo5FDkpUv2Hn+HkRPxxuULdYHsrAspFJCRM+zZPs771HG
         J0T0+AyqUejnXm+zJVP8iDGjzjB6fi145gQtY7lAEHXVqWqHEOgd9xWJDbx8gFrJRjDu
         t7dnNwY6Dmbj5fYjA/wOYbq5jUg/7x1SvaU7U2FOIb4i5lYriTnKXVzGZBS37Nmetr+W
         7sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824574; x=1794429374;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwPEOH6TnC9eq0kvN9U5QGgPY1fvhRUkSYpizPQPnRc=;
        b=b/Zsk2Ty/EFtKf3b7Ci7cn62MyaQKM7Y1dycsmFYISXjO9QY2QKMqLI7oIW0RVG58B
         uChVrexDoqymWm+V+T8MbMcbO3E0ICEUGlBP3XUfl3ZgtmKX8w+aBkd90Mtl9yw2z72f
         Dwl8ldXl+78ZnEcMLi5wf/FLAYMvb5ulnA1pm1iAF5OHdu+nR5oBAS+33PjAMXuvBFRm
         Il3n6pCBwdye3n/KrSd2E0EuEzn+Wy0D7s1LdJzN2JCBBRGIadbG38glnMwhYXgYmUYY
         TSJ3dvgpKsv6aBptgEtiJX9JUSVNv+s+dc9Kw/NBQ2JMXq7YeRKGpZEIKeTwxYrvBLnw
         yr1w==
X-Gm-Message-State: APuU4Z92zhyg9A+T4XtxV2YPr8tFj0DeJhtZaZ24lHWD156TZrk+HUPk
	3rxSzw7cVqs1KOcZzD6MxWIyk2P9DRB2Bf6OeeOxKsbpGdV2d1Vqqcxf6LmONYFKxw==
X-Gm-Gg: AYBFou1sgkyykedz0TwMJF8jXXwyrywS1t8q2ss1pBJA1MtsNXPyjSY3cTw3iq6bGtS
	hVPIh5+4LaWdV/8PUeYf6+aTtYtVyT+7dFcD2TkWW7lFV00zBdTxVn2runrHrpyB5P4C/fWqvA7
	2FF3nCnNJFe9TS9AOacgNsqcfw2GhKCUXs4FM01x1oE/NAk/MvNwWcO8uzhX3S385QAC1k9LSK3
	zRHYWRu7xck+2YzBFRsnzT+fQtMiQ/jyLxuKgBsj8t/ctVyCirZThPJw28Cfi2E1Wm/LuwddU1Y
	eSI2HFMr3WDUmMlahXF9+cdiImNySNNCK/VzBVSmfRhtL3wAQCnBdxZ668ojIa7fk4LKJ14iNHK
	0vJGNgyI8viMxltcFiJHSP3oTuHYbBSHqbl4fGK+9zzw36C3un8H+6OkRLi7dI/sjBuhaoNIUlm
	8dZwNnhYtrQ+0qCgHYxvadK1NFmp8hJ6W+frSRmsYlkoi8+7YaPLnw3N9g7HHOrt+Vi/Efd9NV4
	a6RupLImhD4ofwzIWNulnCgjIqwC1E/jb1HWoh1Gp038LskJgJZkim8wP7qUzcWQJunlgZb4ND4
	pk06MHcS01z42dpwmJsbBit038CMu7d4fmcRHrFNEX00cbqn+Zo4cjIVTvm6Y35YN5aOBnRl4mD
	+MGiPwIxPc0RNRtitr1ZirtOPoIfpBg==
X-Received: by 2002:ac8:5d46:0:b0:535:9798:3f0c with SMTP id d75a77b69052e-542b6a6d944mr300331831cf.34.1793824573629;
        Wed, 04 Nov 2026 12:36:13 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm33431391cf.20.2026.11.04.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:36:12 -0800 (PST)
Date: Wed, 04 Nov 2026 15:36:12 -0500
Message-ID: <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261103_1853/pstg-lib:20261103_1851/pstg-pwork:20261103_1853
From: Paul Moore <paul@paul-moore.com>
To: Bradley Morgan <brads@mainlining.org>, =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
> 
> kauditd_send_queue() grabs an extra reference to the skb header before
> netlink_unicast() since it may need to retry a failed send. If unicast
> delivery reuses that same header, the receive path stores the
> destination socket in skb->sk without taking a socket reference.
> Consequently, after the receiver consumes the skb and closes the
> socket, the extra reference taken on the skb header makes kauditd
> release a header whose skb->sk points to freed socket storage.
> 
> KASAN reports a UAF as:
> 
>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
> 
> Clone the header before netlink_unicast(), then use the clone for
> delivery and keep the original skb only for retries. If cloning fails,
> handle it as -EAGAIN so the send can be retried.
> 
> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in case auditd comes back")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  kernel/audit.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc..5e739fa606be 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  {
>  	int rc = 0;
>  	struct sk_buff *skb = NULL;
> +	struct sk_buff *skb_to_send;
>  	struct sk_buff *skb_tail;
>  	unsigned int failed = 0;
>  
> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  		}
>  
>  retry:
> -		/* grab an extra skb reference in case of error */
> -		skb_get(skb);
> -		rc = netlink_unicast(sk, skb, portid, 0);
> +		/* Keep the original header unowned for retries. */
> +		skb_to_send = skb_clone(skb, GFP_KERNEL);

As Bradley pointed out, this appears a little confusing as the existing
approach of skb_get()+netlink_unicast() should end up doing something
very similar to what you are proposing due to netlink_unicast() calling
into netlink_trim() which in this case should always end up doing a
skb_clone().  I'm sure I'm missing something, can you help me understand
why this proposed patch is different and solves the problem?

Also, do you have a reproducer for this?

> +		/* Preserve the connection on a temporary allocation failure. */
> +		rc = skb_to_send ?
> +			netlink_unicast(sk, skb_to_send, portid, 0) : -EAGAIN;
>  		if (rc < 0) {
>  			/* send failed - try a few times unless fatal error */
>  			if (++failed >= retry_limit ||
> @@ -827,7 +830,7 @@ retry:
>  			} else
>  				goto retry;
>  		} else {
> -			/* skb sent - drop the extra reference and continue */
> +			/* skb sent - consume the original and continue */
>  			consume_skb(skb);
>  			failed = 0;
>  		}
> -- 
> 2.47.3

--
paul-moore.com
