Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289ED3F8899
	for <audit@vger.kernel.org>; Thu, 23 Jul 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843878; cv=none; b=TRre6Ki/n8KLF3JQDPGeNDJViLrN9/z5qZ9eo2y5a9Al/J/rXg2eRTB86yUU/cyi8xUio8WHZ53ewgkxz7/so5AVYg7kb01fbk9mwnocLDCD+0vkCxtge7W3cK+mcmZwf740J3NRJGUFIIMDCIDE5tR8bRTfrZ7e4ee0DY8IZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843878; c=relaxed/simple;
	bh=ylOeIKd1L7ZIVJMCcRBVkSvyVCfZcUOpGEO57Hr+PBU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bVhKETZdQmHaA0zBNriBgXP8XrcRUF6eiM6y+/dXEztTGFAUjlrPHplJYCw7Z5VmaA7bOqiwytOE0oI9iYU9x8+trPX8kTry/oqt+BdJbDeqybFj6mHga9/OR1FtoSaW5f/6TRuWoO/1J/IvIlNrxbXXOkUwOhlI4n6mPknAq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HIjYBiDf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HIjYBiDf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5276d598b96so9343661cf.3
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784843875; x=1785448675; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqDNQfwHL9fM3Gt3gkX3y29OCx2aWzPuHHonYTNvKak=;
        b=HIjYBiDfMPttfBpheT31E8tR8hns7WmaD321Oeg9W7qDSLkLNhCgqmvfjiPCnkceFS
         6+RX1vU1Hb8C71BUj49LWk+rMdtmZEBR9i7Nq7Odr1NuWrTjSL+YaIfsJbxQKb7TIAb9
         iYkHJAkl141GIvxE6FfJ2/qSkW2rxy5HbEQLoEV4aHunMXnKzaxhn9Gk8EoAGWFsQQSG
         mjgxqhkVniCJGWh3DvM04nItffCRd0g/FtTPo5Mbm6oYWaX52sG85lpNILgguKtOf+JU
         2cQ0U5Hhk7zICjfLvpVjZsywgWnedQZbpkDmgGlwQZRkHR8VfAQkJABV2S41hjk9jVXB
         KvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843875; x=1785448675;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqDNQfwHL9fM3Gt3gkX3y29OCx2aWzPuHHonYTNvKak=;
        b=SO1JWbfqB6Q+IEIyndE56Zbg/APafbSWE4lu117N0jwOnuFdxeQhVvf0vnOpCvYBbG
         Ch5rwTe0IIqzacgsuQieldDRoOpUgjLkf8xyhQw1I90oNDOLo0VRFZMbkicXGkZlXtTI
         V9+HhkQYezfi6mAIvfl6WEhx4v3p6i5zZuWaeuKJNvJmEfRv5fiffTvu4noBkjzTO4gd
         A9kD3EmentAy1qx5MI3s61Kcav1zl21L0Hn0h9ThLzuLLkvuiqWoZAmOUlbc7daGhP2Z
         IoUlUW/2f2oijS4xUDJBJx4JI8a/oWvji13G9pXrcAoGzzOXC9KYlrctQaqDbKfHaXqK
         EGIA==
X-Forwarded-Encrypted: i=1; AHgh+Rqaa+Fky42SaKX4MyNWUaGl3CMTKL1OZt7sM97GAUnnOhH9T3iuYJaGV8pAni0cdLsrQgB1uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjqN6G0AQK155LpFa0EI1LE2P/znk9peeWIe44rfYZ4+KsdND
	vLRHSeqA+JRhV+cMUbxUTDWMO6nt/L9X7nYN5gQ4wzBUKx9ZHAUgVmRjxvijDIvp7A==
X-Gm-Gg: AR+sD10rIIfk+hfKgSlNxu8Te+BNcRmITJ6VYCpwnj6ng/KVZBHr94OwH3eSUNrVlOQ
	VYrgicrnQr+JQn8rm4pzCnc5XYflRuOKpw8e5SClTo+JokOH8I1dygybM6vJl7SsJ8jMndmrUw6
	rSseZUiupdOjgWW9iZiQbaTSBOtM/wJ1ARU/CH9JtUQo6ZL//WqVj13YAGvJXZ7qFK78JexCyOG
	xQjk5LTRxyFdHYBZRhg7k4iH4/Ta9ZP+v2Coaa5YhSHu1CVJzmqkRAVg+e1ypwT5Evs+kRPhVT6
	wdZRp2NnJKjjzAOs+dHsaZMepR3T3WPg56oRBnNdl/HrnBrqnvvjeRrYaQ/1OVUC0kAxmyug4AM
	f0g2qOYbKeSyZ21MnNcmY1ReHuVODMFsvWph4t+LU4Aybu7GDp8ld4TGy1LVflaOR7LQI5KKmUy
	mxo3uunfSmhnZQ47ou5Y6XWN7zsbpTIyupHl6Ca6Hk67G0qMg=
X-Received: by 2002:a05:622a:4c1b:b0:51c:7b11:41b0 with SMTP id d75a77b69052e-5283df9c8f0mr53089181cf.76.1784843874688;
        Thu, 23 Jul 2026 14:57:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3a47ee2sm42095211cf.26.2026.07.23.14.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:57:53 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:57:52 -0400
Message-ID: <623bf8c0c7725ae7d93d7c0847821212@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260723_1338/pstg-lib:20260723_1454/pstg-pwork:20260723_1338
From: Paul Moore <paul@paul-moore.com>
To: Ren Wei <enjou1224z@gmail.com>, audit@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, vega@nebusec.ai, rakukuip@gmail.com, enjou1224z@gmail.com
Subject: Re: [PATCH 1/1] audit: fix potential use-after-free in  audit_del_rule()
References: <ffdeea400054f4d42e394d09003cb4dd5ffe862c.1784611349.git.rakukuip@gmail.com>
In-Reply-To: <ffdeea400054f4d42e394d09003cb4dd5ffe862c.1784611349.git.rakukuip@gmail.com>

On Jul 21, 2026 Ren Wei <enjou1224z@gmail.com> wrote:
> 
> `audit_del_rule()` destroys `e->rule.exe` via `audit_remove_mark_rule()`
> before unlinking the rule from RCU-visible filter lists and waiting for a
> grace period. Concurrent readers in `audit_filter()` and
> `audit_filter_rules()` still dereference `e->rule.exe`, while the fsnotify
> mark can be freed on an independent lifetime path. This creates a use-after-free
> window during rule deletion.
> 
> Fix this by unlinking the rule from the RCU-visible lists and invoking
> `synchronize_rcu()` before calling `audit_remove_mark_rule()` (and other
> rule removal helpers). This ensures that all existing RCU readers have exited
> the critical section before any underlying resources are destroyed.
> 
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  kernel/auditfilter.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks for identifying this and providing a patch, some initial thoughts
below ...

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 4401119b5275..7f791afe5791 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1045,6 +1045,10 @@ int audit_del_rule(struct audit_entry *entry)
>  		goto out;
>  	}
>  
> +	list_del_rcu(&e->list);
> +	list_del(&e->rule.list);
> +	synchronize_rcu();

I generally prefer to use call_rcu() instead of synchronize_rcu() when
possible.  Did you consider creating a audit_del_rule_rcu() (or similar)
function which would perform the other cleanups/releases below this point
including the call to audit_free_rule_rcu() which could then be called
by call_rcu()?

It's worth mentioning that I didn't verify all of the code involved to
know if this would work, be safe, etc., I just wanted to check to see if
you already had and decided synchronize_rcu() was the only option.

>  	if (e->rule.watch)
>  		audit_remove_watch_rule(&e->rule);
>  
> @@ -1062,8 +1066,6 @@ int audit_del_rule(struct audit_entry *entry)
>  		audit_signals--;
>  #endif
>  
> -	list_del_rcu(&e->list);
> -	list_del(&e->rule.list);
>  	call_rcu(&e->rcu, audit_free_rule_rcu);
>  
>  out:
> -- 
> 2.43.0

--
paul-moore.com
