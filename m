Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998602EE611
	for <audit@vger.kernel.org>; Wed,  8 Jul 2026 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534936; cv=none; b=ZJK4cdIurt0I5KJZCZX5JfMOI9uZr0hBv40Oyh8THWV4WmvL7mVijkkUr5Tyo6kh3FTj50XohBXGUnelXFplENSCxhhL2fl5o1PMumDOojsuDJ6SXY0xjoOanddnPPDD67cMDTcNggooWcqQqXTcEp2gvhhMjtrgq7DCOP5sNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534936; c=relaxed/simple;
	bh=ET805bVdGS1zkjS8gMEQyUPVGOXKeqtwtnM/BLCiVXM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=u+zLPbMZqnZQG96iSr0ERFM6bEYG4GBwdH/7uzLNThtH3CLMkd4aYQI7QnJFMZmwStf+zeZiqbK+QytD1rQuZuho0cnyauzrJPJ7IATuwwHg/xY9UjeLNXDXPjQa7Ut7GcqL+5Nc28ENVaKdCjGuNv66sr13yE4YNfgbc3M0oFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PGNmTiQ5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PGNmTiQ5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e855da580so82733185a.1
        for <audit@vger.kernel.org>; Wed, 08 Jul 2026 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783534933; x=1784139733; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlii6ix2M2a5zOrDQVBlUrLvKVbK3cfMDLu39vPxD1A=;
        b=PGNmTiQ5n/vwCvnDVh//Y1+ziX5vs+hhFjY9ebl2K1jU20YBJBBOeJ9GJ/5AvY3wV2
         hUoQ1M2unNtwSmmsDUNY7HmQyL55u637YLfdu2q1uhUDz7PXHPZRvkXH5Hud9ZMqumoa
         Mmaw9MI5zZqymtilFU2D4u3pz8W/ylhpGhOR8+QwXZwVxShcIzH+Sqe1ORzHlcEE8ri2
         scwF7/9gBG5BYabWWt1l1LrGzbxH0seMTgycug23WCK2MlyHn7wrMVoerC76VN7221fY
         48qbuH1xcaoHeNBUhhq69iMIaLC8q2j9TylD3EssnuiCdFjGUY7tSH+grNHdBw23G0ja
         ZZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534933; x=1784139733;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlii6ix2M2a5zOrDQVBlUrLvKVbK3cfMDLu39vPxD1A=;
        b=GDqhaQBPPsx1IE1m43Q/zWLO4K+AYivZjfqM5OQlak8LWNrbUKVNCZEtbeEHpvwaDE
         6nZ/OQVDCq4zTDge/mlsTOuw2CVK9HfEZOZODiWiCnEWqjl/yaRSwcqZVeAhaI4DKVum
         u+0ko9cPS1ilzF9o/3RwTxQ13JheCuKzdgiOO8aT4PMCheuCmKfAXdF5AhaJHo/08opt
         IyiaQL5LyUnsnzJOe6kB6ROhDI2PnX4g8cShavrQICr/Q66nYGpNvJf+OGKLH0ol0zqp
         AwZacjqwyVuimC2EzJUaEGQCjh0PJ343V+zv+StfE4oTJ3R2XyNpg01QThMaorj1T5Or
         S+cA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5JqQtT72lCemht90OJy/hJkJ/JkcQdYiSip92c+KUrjDK2XELxOWlZjgcwR5KNk/lc8nioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJlr03xHAKP/kh8ACZ0sDqBkTWdBhtvqT3Uxat3QVMDCvL9b3
	bxAk8V+TX7sY/YjPBuqsjsiaMip2r31nVgFWRAluPS/y6tZBJDfqddLD1PvfMU2CV3+CwZyH0tt
	vkOQItA==
X-Gm-Gg: AfdE7cktFoYKDUVEAr8C+etM0yoIecxsfP7eWYzMrUoWjKL155wqXlCoUyPAIXxrNLi
	4K28tCyFcTpk5feF4sB7m763WhIPDCo8YnMEpowMbu7bX13eZa4K3Yrs0YrVrL7OTgdIrOThoNK
	uxQY2vv5QOM1il2tNHctLmPV7yCBP/Zyuqfvn1FFcEv8D2UanD40uBJKTLefQjIt5g7swODTfSZ
	eqdhzDkrFeKWCiizPKhAqnHSbBZ/coNISi5UzD0wvtuEcuXCHJ3Zt0btoI8JdQkN0hEOj2ZoCaA
	EIhx2S/yIrYPpgQnMgDzSXPPN8LHbD4P636ZiS29A2OwXmGCehcq30mKkoaLAzh1JbMNzAzIUM4
	EsMKlemIbKB9OvD7gwfR0RNN/1ZtIaFQyE9B2YAa31z4Wp8fQWKTrQ7HCJAx8tKfGiZBYwSf9xr
	9r5uhB0XtOuh+jGUIZT2w5S+XkZaRzvjqwxy8B4/+omfBbo+LC0kZa2zNyiA==
X-Received: by 2002:a05:620a:1994:b0:923:8612:f15 with SMTP id af79cd13be357-92ecf5c49eamr345917985a.18.1783534933540;
        Wed, 08 Jul 2026 11:22:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba4209sm1571492185a.12.2026.07.08.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:22:08 -0700 (PDT)
Date: Wed, 08 Jul 2026 14:22:07 -0400
Message-ID: <a0e1827116da6fc4c48a22957a0c6748@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260707_1504/pstg-lib:20260708_1328/pstg-pwork:20260707_1504
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v3] audit: fix potential integer overflow in  audit_log_n_hex()
References: <20260702140411.1021373-1-rrobaina@redhat.com>
In-Reply-To: <20260702140411.1021373-1-rrobaina@redhat.com>

On Jul  2, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The function calculates new_len as len << 1 for hex encoding. This
> has two overflow risks: the shift itself can overflow when len is
> large, and the result can be truncated when assigned to new_len
> (declared as int) from the size_t calculation.
> 
> Fix by using check_shl_overflow() to catch shift overflow and
> changing new_len and loop counter i to size_t to prevent truncation.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> Changes in v2:
> - Use check_shl_overflow() instead of manual overflow check.
> Changes in v3:
> - Log "?" before returning when overflow detected.
> 
>  kernel/audit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e1d489bc2dff..52eb3b511bad 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -62,6 +62,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <linux/sctp.h>
> +#include <linux/overflow.h>
>  
>  #include "audit.h"
>  
> @@ -2076,7 +2077,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
>  void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		size_t len)
>  {
> -	int i, avail, new_len;
> +	int avail;
> +	size_t i, new_len;
>  	unsigned char *ptr;
>  	struct sk_buff *skb;
>  
> @@ -2084,9 +2086,15 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		return;
>  
>  	BUG_ON(!ab->skb);
> +

I removed this added vertical whitespace as it wasn't really necessary
and could potentially impact anyone who wants to backport this patch.
Otherwise this looks good to me, so I'm going to mark it for stable and
merge it via audit/stable-7.2.

Thanks!

>  	skb = ab->skb;
>  	avail = skb_tailroom(skb);
> -	new_len = len<<1;
> +
> +	if (check_shl_overflow(len, 1, &new_len)) {
> +		audit_log_format(ab, "?");
> +		return;
> +	}
> +
>  	if (new_len >= avail) {
>  		/* Round the buffer request up to the next multiple */
>  		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
> -- 
> 2.53.0

--
paul-moore.com
