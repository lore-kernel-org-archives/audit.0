Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF92E859
	for <audit@vger.kernel.org>; Fri,  6 Dec 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445908; cv=none; b=b70xDwpbIDJsw/1DQpC/Hajcb8FlAeNSBI69COUKaygzkHtDTS2xHDMybI/jnlQjlr7n1jZyGV4s/PAegaR9WR+5jMRk0WQfECGN6joJAu55aA1r/5x5SFjPpNPngdMi+ySPmlSMdNwLNOOUf4FOK0ALRnCtr36eYiN1qIGMzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445908; c=relaxed/simple;
	bh=gETGwCaOGnK7nQikpyqTQI6K1uu248xeEEWKHxkYDSw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=T9E4RPhObp4ebIDdbbrr0RaefwnhWtP5Df7z9ZGiqyHIpjUZL2w6Mwusm9Ey5OUrdWYUFapf6rWXplrtcv+JysWtvD9hwurC7kCcOi3NEzq0qacnlicfMcJ7Yrb/7bqoj3LV5FUQapt3bL/UsOuHxNRIq2fc59D3ZNanCJW9xog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IGOIc3Kc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IGOIc3Kc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b678da9310so129164585a.2
        for <audit@vger.kernel.org>; Thu, 05 Dec 2024 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733445905; x=1734050705; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DAbdRuarLinIGr4f64EbY2TJW33duoe/lFkiR5WKEc=;
        b=IGOIc3Kcin8EAENMxtzQJ+KPSK4f2lfRNvDfvhzIWVGNmYNZOcXYNFcvZzjJPxpEUi
         GngKKn4yhJMWCaJzWFZ3fKneA18ZHPFiMq23Sfi/mSLCyFR3Q63Wq/H+cP8b1NY14oRR
         RTKnZnAmwjyOWcnmyLLQo9QgkXpGkVDGsigQE1DElN5/zLfFdeM+rYO/FxAib2vTP/ec
         SHcSmhplBpb9jnDds5zPNrerh0HOYzjXR70t1RIi6IlVypmTncSBxtXwYDiyKX08HlWR
         Uhhs5hc28UA5gJdzxgrGzpSwVs/6pgD0QCCuYTBG2SlhEtwaGbOSyPGmAlCQdVQhzU4Y
         tvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445905; x=1734050705;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/DAbdRuarLinIGr4f64EbY2TJW33duoe/lFkiR5WKEc=;
        b=dowldWfdvXpHhGUqk1vPp1Mli9NGTRMMCjqDtWR9j+9rctXK34iQVF4w/OGpYHtxkQ
         37B+nMfuso9V5z86T5xz4WsUZSLlt4vbdMgaVJgyBEiJuuFrbIJ9xRglBXgmQ0yVHSwh
         glzUGWV9uSCSTaz1YMrM0jbokvUxVS3AvAtm2nMVZe2omWMY/IhSkyEWYD9IoMfjRP7W
         fSLEKOzzuKc5weyLNndYdOM9zV2cmqLrcF82twFTe3KM4/hXYn8fBklSySwZB1Rp77lA
         jB0+MysZpfCQ9U9unT+ExZnJj0cM5Ci6lUiAxAjoGHkdKM43ZhMwtH67pyKrwaw4h+vg
         Ej9w==
X-Forwarded-Encrypted: i=1; AJvYcCUbO7Au4gNSYenQgNMiKx6ZTeXp0Vt5Zbbn6ufTxUpvUp1mmOhNycNmjRHNqBZBz17LqLkkHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AqhNdjAexvDE194XgdBiBwVe6Sa1+4pwpne7ihQ/C08I6kfT
	jDJ1SDRDW/6gcRdqBLyK5PxFswHqfEu9yJGu6+z6hZO6PDHPERI6v/0s7tqh4cQJNBX/0Gr8PCH
	bBA==
X-Gm-Gg: ASbGncsrZKV1eY8uLrvHxZvpUsyxR8+cZCeQZZJWdTga00TkPYKzNg9fT5+wB/2M+Ox
	rxuK2IA7krKoHLyH0EjdIEN01qut+QaSsmCDHgEExrSpx3Yrs4XhD5AsO0X5iSRhlBSSL+M4RSd
	5DZQu1wuNdGNms97QWd5GYPS+hHhKkC9hT0o6PmD7hf2dkgVxfOhKKT8h7kjebLslih3ci927+Z
	/aLBxMglgyHoNRVi5ngaKFGNmwQ18mzPYQfQRmh3ODH
X-Google-Smtp-Source: AGHT+IE1MP4n6e0xT6O4u5Tlnrsd5VtUq4n8BNtkEUzNio6fpacn1x9Fa/HW6pEEO9LhGetK3e/V0g==
X-Received: by 2002:a05:620a:294f:b0:7b6:78e9:1ea2 with SMTP id af79cd13be357-7b6bcac8926mr229275785a.4.1733445905567;
        Thu, 05 Dec 2024 16:45:05 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296d4d7dsm14242021cf.34.2024.12.05.16.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:45:04 -0800 (PST)
Date: Thu, 05 Dec 2024 19:45:04 -0500
Message-ID: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241205_1904/pstg-lib:20241205_1757/pstg-pwork:20241205_1904
From: Paul Moore <paul@paul-moore.com>
To: 15074444048@163.com, audit@vger.kernel.org, eparis@redhat.com
Cc: 15074444048@163.com, lihaojie <lihaojie@kylinos.cn>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kernel/audit: reorder the member of audit_context
References: <20241205063023.744685-1-15074444048@163.com>
In-Reply-To: <20241205063023.744685-1-15074444048@163.com>

On Dec  5, 2024 15074444048@163.com wrote:
> 
> Adjust the positions of target_ref and target_comm to
> reduce their direct proximity. This can prevent the memset
> operation on target_ref from potentially affecting target_comm

I don't really see the above as very convinving, sure by moving the
target_ref field after target_comm it is less likely that a too-long
memset() on target_ref will impact target_comm, but ...

* lsm_prop is a fixed sized struct so memset()'ing it should be
easy to verify.

* if a memset(target_ref) does go long, it still jeapordizes other
parts of the audit_context struct (see the audit_tree_refs pointers).

If we need to workaround some shortcomings of the static analysis
tooling (which compiler/tool are you using?) that's okay, and the
paragraph below is fine, but I don't believe this change really offers
much in the way of runtime protection (the first paragraph).

I'm CC'ing the linux-hardening folks as they may have some additional
insight on how to best work around static analysis limitations.

> The compiler's static analysis tool considers that the memset
> operation might affect the adjacent struct member target_comm,
> potentially causing subsequent writes to target_comm to exceed
> its boundaries. Even if an overflow does not actually occur,
> the compiler may issue a warning because it cannot fully
> determine the safety of the operation.
> 
> Verification:
> - "pahole" shows no size nor member offset changes to struct audit_context.
> - "objdump -d" shows no object code changes.
> 
> Signed-off-by: lihaojie <lihaojie@kylinos.cn>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 0211cb307d30..77c140228a4a 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -144,8 +144,8 @@ struct audit_context {
>  	kuid_t		    target_auid;
>  	kuid_t		    target_uid;
>  	unsigned int	    target_sessionid;
> -	struct lsm_prop	    target_ref;
>  	char		    target_comm[TASK_COMM_LEN];
> +	struct lsm_prop	    target_ref;
>  
>  	struct audit_tree_refs *trees, *first_trees;
>  	struct list_head killed_trees;
> -- 
> 2.25.1

--
paul-moore.com
