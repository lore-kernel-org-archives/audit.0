Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABA382F3C
	for <audit@vger.kernel.org>; Tue, 30 Jun 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848815; cv=none; b=LzwdKPpCVNNI9ZNP4HBMZmA2sqbxbsRXn4R7QJ5viThRvPkMM0r8tAmCXBNj4/gYX2VfGiw5T3C66UErw2dwWQaGCAc0CgHa7NPUVSRwblbIZThHCcmvJ3s2CudJwZTE7R/iOm5YsN0ZbiCEIMioIA8VK6mq2Bp05U6GPUIxJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848815; c=relaxed/simple;
	bh=oo2DUdrlDE0PU4oKO0uUS7jVlem8iaDzXKngY9bw0Hw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Kdqa6q/pN/qBftYjt+mGkXU9GOBuAHxl008C4SUDEbOB0EIFMD0IcMvWwc67jGWG7V4qis0U/9l3W/8CHFHiwyY+CMHiTVje4mL++ygKdLlvsenOccxox2RyWH028sv/i1jYicvboo90APNgd7E+iWYhLa/QbNbfi9j5emjArDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y9qjMo2q; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y9qjMo2q"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfa429aa6so7460691cf.0
        for <audit@vger.kernel.org>; Tue, 30 Jun 2026 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782848813; x=1783453613; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IWkyThjuf0szQuvYm61k7V37lNzelAOR916abTXoYg=;
        b=Y9qjMo2q/x+MO0Hd2z9jsVBGBwuANU9OOxwxqyGrOh4F7nMHhDe7bMzIwa0KRH9TJK
         tDfRL18EaH31s9WT5ovfWti3/m/oeBjtgFZmIuR3WbEkNVcAhxI79TsjKiZN9hy7P9rA
         RZQajIrn1uq156PEUUvGT/3WGfBEFomQ+orMyD4PwhYxtZPU8jwtuHsTzuNAn8qlFvlw
         7owJfZbCaDfLSHd6Hs5i6vMEd+dQdiSuHSgKDntjFYElcRISd0Zd54xkALgLt54bACIM
         S/9t0MR6jv1Z16fQy8SxhoArkL7UtqvT4DjJKzp4zYNkoU+q9rq08B9sOb1D/CRZBIpO
         Tmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848813; x=1783453613;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IWkyThjuf0szQuvYm61k7V37lNzelAOR916abTXoYg=;
        b=Y578OkeDU6avU0rQcAnCYUBZ2V393ydRDZuRzPnptH0hPf08dIEpte25fwwd/macQY
         fi1C8PkfnUiZU90u+r14vduKLYTRsEKazZzyEEUlCr50V7zwRygRX+aMiPO+Z/FSMoeV
         mAtvs8LumSOpIJaSHDC1rf2DEzrogZRFjTAI3xp6/1xe3DH3LbaP8tpJ601oiH84NV3N
         4njWEXmg3bMLYGLlmcxTOaibTmGgWLvuhEQGYd1LOjCemGWRxj1f4ghrjncGdwKtPfgM
         0RTiMpVn6M0n1was4+w7js6cNYP4ShUkcEYc/le+/odIEO9JQjwnx75MUWjieUPzNaHt
         PsgA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZFVFmmmOug+GfBcSdiTH65OR0CQVCkyxHU0hUTjH6yL8t8XES/LsLveAArTSsWynG+Eq6/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPysTlbhsTz2BF+u/ke8B++1c/kyT5Q63Yq+kMYYvEFz0RhW+
	/E7Hkq05rgqwfH/z69oK3iGwODzsAUGjozShtjrrs/LPvSdpC/h3Mbg1IVBoEW6fhw==
X-Gm-Gg: AfdE7cmFXvmbLvX+NTNgiI2GPzFTLaYoXB3SGgUxgowaLtr4uv/i13nU1zhKqrdNEdM
	79Kk5AEXbXqdliDI6P5k8Z2Y6/eJrmnAhHsvcO7h6ogzAveSJTpcOa1+gf4ynMjkRLkMZC/yqqT
	XD/6NUc3VNUXzmaU0FZeCpSra62M3VO7c9hctoCagVLFJuVLo26uYJJkvrqsv/0YPqFor/5VQ3r
	GPtEegfofxxW14j6ckGpCXPZjSDRJylJK3idoLaAPUmKHEwYANeB3ih2OcGSeOYaUSqmfuemQpy
	rMBkfdPGLME8QN37DBbi19207ht8BBfIXJFYLFfuFgBQgq8Y89RAfsKBRvc3hh2Mi05XW7bNkuZ
	nx+NI+IfNxQLsxKHEysCNlnCUtF9RkRGlJPGo8eEhfZ3+FAP6XnWR3nniAirbo/CoFU5i5XhNm6
	odec8lD9H0mADwFw1pXWuOVeSs2Qbh4ltcia8g1YfuebbtxS09Y/e+SRZBPA==
X-Received: by 2002:ac8:5915:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51c17ebc308mr37280171cf.28.1782848812991;
        Tue, 30 Jun 2026 12:46:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm24981701cf.5.2026.06.30.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:46:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:46:50 -0400
Message-ID: <51c2895ec46ea6df1b5763bb78c32fc3@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260630_1523/pstg-lib:20260630_1303/pstg-pwork:20260630_1523
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: fix potential integer overflow in  audit_log_n_hex()
References: <20260601130951.1418695-1-rrobaina@redhat.com>
In-Reply-To: <20260601130951.1418695-1-rrobaina@redhat.com>

On Jun  1, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changes in v2:
> - Use check_shl_overflow() instead of manual overflow check.
> 
>  kernel/audit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e1d489bc2dff..8ca268610641 100644
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
> @@ -2084,9 +2086,13 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		return;
>  
>  	BUG_ON(!ab->skb);
> +
>  	skb = ab->skb;
>  	avail = skb_tailroom(skb);
> -	new_len = len<<1;
> +
> +	if (check_shl_overflow(len, 1, &new_len))
> +		return;

By returning without logging a value I worry we could end up with an
oddly formatted audit record, e.g. "... A=foo B= C=bar ...".  Instead of
simply returning, should we log a '?' for the value and then return?

>  	if (new_len >= avail) {
>  		/* Round the buffer request up to the next multiple */
>  		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
> -- 
> 2.53.0

--
paul-moore.com
