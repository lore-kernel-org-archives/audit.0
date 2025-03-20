Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98152221DAD
	for <audit@vger.kernel.org>; Thu, 20 Mar 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462578; cv=none; b=uc4/q6vINOepMEoR9TX1d3nYhbnpO1GOeBapfs8LX0h9wbYEosi4KMDD8uJzKcLEixJDR+xGShgC1zZ0pU82XbYzK9Rzzo78ezlkVoC7/gqdjYf3rr1b15teZ5L7Q5th14Xt4n+DbCH+y83jFrzfZg7K/UeYasbHIuH69/19jaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462578; c=relaxed/simple;
	bh=v1HzjTFaFAns1qXAyZ3BA8WOSz6IElFgZDI4xKBb5Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3pnnXfDJcYaB71WVbL6/r/Zn+PjUwT2gj37rLtz7Xzui00w5cWzCVciG05/t7F2wmekNG8CbWjYNyHzZQbznsK/twAPxfGLGigQR31G/H9W2XwAWStWPWZmV5f8D03X2l1B9LWqcQVlzz+iBbThhbkYj9ZsKQBAs3MIBiHlcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J8X46BQa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J8X46BQa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913b539aabso247194f8f.2
        for <audit@vger.kernel.org>; Thu, 20 Mar 2025 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742462574; x=1743067374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myg67gk9wPhxLbBgzBdtkm9d24LaKIZKxjxSO7e8nL8=;
        b=J8X46BQayLn6KljvOk0Sc8yPh/qBtxKMIdJLUr6jtEte8vmoBJ24WEW8oyooDzkObB
         /edN/3FhrZ2zL6nQDw/o4PI/NNSUI3e68y2kERGg+fum8TTpDwPfS25gmm6W2vsxmqXI
         pEmbI8rM0TnlTgAsZESjJngs6UomGdHtLoSJR3yi5cTaPKtdtLjvTnUplN2YIDAs3I0Q
         Ub+tAeA6ru1NoCZLlxXn/+bkvR/Kcrw5mbcaHHK0ydgin/tT15gas9szddwnW+k3783K
         d/5aRsF5CzdjCUw6Si/CMy4ZMH3cAM570WVriteHjCxlG5KAPU25xPN7xlxBZD+odhJg
         bxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462574; x=1743067374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myg67gk9wPhxLbBgzBdtkm9d24LaKIZKxjxSO7e8nL8=;
        b=KE9y+sJQwAJH6eNijcw1kcBXIMPKXnTuoR+sQUrDPXG+aH5ja2gNUVbo26NY2mOF/G
         BvNHvV7GHL/5ffqTHPU4tcapXsOvgA2014nWCc2tbGmNM6ws3sA67yIt1xeZGDnzyxs0
         Bm6r38zudVvRlA7uHh7sePMrWMRM9pAQ3eEs6u8nBThpC+aY6DEXmzdzfxvWtWALR5w3
         gdTnrGwVdiHL7SY8AHYwL00NgmGm2fb0RTXQ3p8iG000LYPRmXYg3rOpZD0yK50DIHLr
         /ijtaNrtVcNJS150JEi1bzRVP1QDe+YYQ2FOgO67AA4rhWiiQ6ZYJ1T09VgIgfkUiZHj
         N+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXHNusw63gT9BWj3rEcZWb+DpmfDrM8q9kXNs7y6pMHjDg/PGjRWKACX2xdHU0MVPQsX+HHUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznBl71ZhV47t+QBUTpLMCslWkmL37v3yuGb0hn0i6R6aTFtrEq
	ztxZLzkSwFIvIfDKLNVVszV3sWwTYoQ90k1PHe1nWwQ5Ww8dHBnld3ebkGxoH44=
X-Gm-Gg: ASbGncsK4tI+jNtcGOUO/LJ1TQXyvIlexh1MoZIq27XsvcanV4NjoNIcpmMigqs+s1x
	pAxZb2p50BUZCZcfzeKxR/TPhwqnSQtTXBVcp1psJqoTxmuteEfIFARKRim8CnWLfqEgPU5JjQN
	1qrgvmo85BqIBskRt1ZTQyda79/QrvQrkqH6QjZBuQ+iG6Rq1jkJlxpflHu1J2/VGBZIoaxvzui
	Em4obGJpk0cV188HuLNAOwHbWBz/F79MxV5CV0gtM+AS8Z3uwtb1OfHNKNS46qqNzGKLj7b7Dvr
	2QKuahyIzSjWC2bdwTmpMdZ13bw7UAxgIoWpyLFkVqSK7Sed
X-Google-Smtp-Source: AGHT+IEMUCCcXqS90NjR0ffhPXJJO2ODfxWqE3skotURWyXG5oZbBCdgiIvZjGWPov7RW/+OZqmhDQ==
X-Received: by 2002:a5d:64c3:0:b0:391:3028:c779 with SMTP id ffacd0b85a97d-39973b03ebemr4709575f8f.45.1742462573769;
        Thu, 20 Mar 2025 02:22:53 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm23399381f8f.62.2025.03.20.02.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 02:22:53 -0700 (PDT)
Message-ID: <ea258e7f-85fe-4dc8-8150-90c78b6e3962@suse.com>
Date: Thu, 20 Mar 2025 10:22:52 +0100
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure
 case
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
 LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 Steve Grubb <sgrubb@redhat.com>
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 20:57, Richard Guy Briggs wrote:
> The move of the module sanity check to earlier skipped the audit logging
> call in the case of failure and to a place where the previously used
> context is unavailable.
> 
> Add an audit logging call for the module loading failure case and get
> the module name when possible.
> 
> Link: https://issues.redhat.com/browse/RHEL-52839
> Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

The change looks reasonable to me from the modules perspective.

Nit: Viewing the linked address requires a login, so I'm not sure it's
appropriate for the commit message.

[...]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..efa62ace1b23 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	module_allocated = true;
>  
> -	audit_log_kern_module(mod->name);
> +	audit_log_kern_module(info->name);
>  
>  	/* Reserve our place in the list. */
>  	err = add_unformed_module(mod);
> @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	 * failures once the proper module was allocated and
>  	 * before that.
>  	 */
> -	if (!module_allocated)
> +	if (!module_allocated) {
> +		audit_log_kern_module(info->name ? info->name : "(unavailable)");
>  		mod_stat_bump_becoming(info, flags);
> +	}
>  	free_copy(info, flags);
>  	return err;
>  }

Nit:
		audit_log_kern_module(info->name ? info->name : "(unavailable)");
->
		audit_log_kern_module(info->name ?: "(unavailable)");

-- 
Thanks,
Petr
