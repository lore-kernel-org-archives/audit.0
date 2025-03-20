Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591C224220
	for <audit@vger.kernel.org>; Thu, 20 Mar 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508136; cv=none; b=IH5GXwBQRnIkORgooBegP1zqz75M7KCx//3IXhVzv5FfUyliRvtjfqkZ66VtyMLEe2ZtAAkU1Qta9q92KZXhD8G6X2Om47Zj9y+/IBnpZE6y4GEGm12l/2/BFBwPyYUBZKdF1PHny2k3Z+RMsAQPkqbg2R9SUfQP3aXA1Z6OdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508136; c=relaxed/simple;
	bh=d7Ya1LHCdyWqJD4dFEE2qeC6cXP+snsY2+GnEOCqguE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KxY5GhOrjDyl1npKiL8ZQPooQQsqcNtGJiSED48Q/MzJhqpzUxL24HxrA2zScFwElV7QzqX3bfyeth0hj1z+cNAmxOmCfe2c4DbW/kpO8azrZte7wsRBGj5IEjwhGE8idzNy7QDKQQDgcvH+U9JILV35h9gN0lUE+WWQbhq84Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RqdtWJtU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RqdtWJtU"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47677b77725so11990241cf.3
        for <audit@vger.kernel.org>; Thu, 20 Mar 2025 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742508133; x=1743112933; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBZh6zpn6DRlrcZ7VEPN5EqgicdAyzcXvCF6SeotL1s=;
        b=RqdtWJtUJFwWLCWWVQskqWRqyTkNrKr2VuOEIBBU/696BmyLTBSV4YCSJnnI6+EWIJ
         eaLmwVkohnR9ca0+Z91WsdOs9lXgpT5nb2oBp/C+AKVwAifYQ9LEIVx0fAlaANRvNZ8l
         0klRQTrO1EpHgm4NoXBRJQ8EzCKKT7t5U4c6ozCU5c/592h/aMAHlkXmVOnXvzsPFxzz
         6PjK441ZrUnTzQ/Qk2Mf+v+j8di5D8ThTURfHdxCXH5MVynNthRrSneXpt/lBSTvBMde
         2bv57iJZE4Ll/Wzr6iLtJiYy5vg6uaP794cVtA8hhHP+om7btTgCsPMNHz/FSGdwf7vm
         mFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508133; x=1743112933;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBZh6zpn6DRlrcZ7VEPN5EqgicdAyzcXvCF6SeotL1s=;
        b=ifbeI9uApGWpdDvOjsZBaoxugTp064/jYlDgXzvjxhAnEotgk8rn4/0/VbvT4AnXfw
         +FcsIemuY9KasJmxLhxCiyeYMVnZvtRSOfe3y9OsomDOEkLNUGYej7SEJrxWSWEHf8dY
         rXDVEh/UbJAIv6y6KuhTIcgX38qdtqxtXFQNgkaM77rSS+Vk0CqQWnCjSv2z35H/o7Pa
         wUscAQBzSKIc2wTSU78sgnTKPaHo/c0Mc2k+u/t2Izvk13nR+Egc4rAPRpWRA8coy8m8
         vjfvBcqg/9qT4vpCW2JwsjeoOpX1AiG2V25y95C/FgepXESUIiL/cUKQHMW7FDV/8WXp
         t8PA==
X-Forwarded-Encrypted: i=1; AJvYcCW8cxzAM28AG6bFb+w2nGq80u7EKmk2hY8GWFIZtsOhBirbMQ8HDKbL9GH/m4YmFxicVb8BNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSWjFYj3bum/lKOmqfHsjkyNDiBEklcg3eKfodKb/R0ggC6mQ
	qMQAOeA+HPWqN84FceAbJJCKKdyOK7pf3tcdzE0+eO2JCyrMKjhV5oMA3RHH6g==
X-Gm-Gg: ASbGncuttqa8+8gvA9nUamihlyPqNL57yNCog+LzlavSIvanD6eVzCZTJQR+bLgPwZg
	YNq65krmIPj9mreCt0eGVCgbAJJwB4f6KH9EiLFVOt3XfOTzNMxIEHvWygKDP2/SbX3/4CzWu3X
	+RO67HltBhTN93FACTkLvHNZkOMiFbSgigGQNcbBBjf1795Xdn9UYx78zzqiTCkX59qF8f+tCXH
	bXDnSLnWgz8s2dNsq/sC55Lnbq4L7kWVufAOgfHekPu1e3xjtN0wOITQMIJxM9tXpaK9zeWWena
	zYi5x9pdmoNb2YTAjcC8wt2Rig2vL078TVOqb8XqWnNJcJiCr0ZhDMqkFXlWFFoZxLSWffGM+YQ
	hsdRhxwOLSjSVGg==
X-Google-Smtp-Source: AGHT+IEpTU+4E0FkwubwYokg6Ah9wbYKDgW5/Z1hnBycqv4qF/mtU8N7ku2JritQ36rrSIqLmxtbKQ==
X-Received: by 2002:a05:622a:1f0a:b0:476:a74d:f23b with SMTP id d75a77b69052e-4771de62897mr15221101cf.48.1742508133366;
        Thu, 20 Mar 2025 15:02:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d191ea6sm3608231cf.45.2025.03.20.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:02:13 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:02:12 -0400
Message-ID: <c7f860b806603cd8af7740c73db68197@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250320_1749/pstg-lib:20250319_1956/pstg-pwork:20250320_1749
From: Paul Moore <paul@paul-moore.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] audit: Mark audit_log_vformat() with __printf()  attribute
References: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com>

On Mar 13, 2025 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> audit_log_vformat() is using printf() type of format, and GCC compiler
> (Debian 14.2.0-17) is not happy about this:
> 
> kernel/audit.c:1978:9: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> kernel/audit.c:1987:17: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
> by adding __printf() attribute.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added necessary technical information to the commit message (Paul)
> 
>  kernel/audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into audit/dev-staging, this will move to audit/dev after the
upcoming merge window.

--
paul-moore.com
