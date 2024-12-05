Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FC1917EE
	for <audit@vger.kernel.org>; Thu,  5 Dec 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371068; cv=none; b=JwiLSITRCG2zvvR26SeffdftFvySIJGopmjB7teLBv3r0yQ1C0+rdvQ4KSz/ZxOut7ddOcNKkiWO9vq8Xn3EH2r/UPtzEQTwwP/jKreybjy2tSHPiqBkJr6s5zr2M4fazJwU8HMZ2L61yxVvXHruAQ1KPHCt3w2oIdvsq1x2Kac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371068; c=relaxed/simple;
	bh=oLRGTb72ejWWk9aFimMv47FZezfMuWjGvZSLQZgea14=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lwA4YPVUEWCqhHtHaPO06M2RKRPgVXbE8ilN5au1reI4Ykjjc47dIBZP6kZ2hq3VUb7Nl1JZHEr34mI7N88TcNwqvaRlhDWwu8xWOYRVZEO/saJuaAZ+W5l2rKmTyt+H/u0f6CrlqYuxjUi8why7JHaFYk/DG2izrBnExaT4Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jggbfd0c; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jggbfd0c"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8cb085d1bso4605436d6.1
        for <audit@vger.kernel.org>; Wed, 04 Dec 2024 19:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733371066; x=1733975866; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Oti3qozRwoHqpzvb7K6NtyZNM2s4uzWDXR9kDcWgEw=;
        b=Jggbfd0cQuUh6xIIsTe6RnfBfUMDTh0AIjZGDttrdXvz6xYwOV4sKNaVCaKhWIp9BM
         63Uu0prQcIcBoZj6ZX3RAobxT58g4SlPeGAZ26l9hSeD4malPtj8xgQm6SVx6FwFjXNM
         sT/40cAnIH9GynQi7qQm2A0dKlyIhdSvCVQ0mYileeDByl4BuAJHYrcOcvYN4lB7HrU6
         YwGjIqRlh6LYJrBQexPjzWCCSj7l9IWFV1dn3zAp60OmMZt0oZuD0XinsZjqQYWpLVQ5
         S4y5Nf7q6nquSd8pcdW1CrvN0EPsem9ZbynOfHGHZ0rdMgFPTPRXNcCm+6DZKWCtAYKg
         CiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371066; x=1733975866;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Oti3qozRwoHqpzvb7K6NtyZNM2s4uzWDXR9kDcWgEw=;
        b=wUPxqVVmfL8Hp/D5jIP/F2VVMWLVGITOQt3BosaxkVB/w8O9aMmM4r4usWjnVf0R0Y
         I6yXzaJ4IAbHUky+rx566qiVifFa3v7oa+wjVknikk1J5NZKTgZExDnqDZ9EiD0xkJtj
         0ZNY9t5HqCEbbzY6ecyeI0JVicPTwSB2H6VbCATXXEEwydgnesWQYg/EtbA/qs0ok26Q
         JGwdc+65LfinmC4u3pxuiJsrUkWWUgYRUSt0Iw0lYR/eAMbAnv9vQ3fZ3XuzQZVHKEn2
         FXMuNuxlSJU5a00z+shZWjKfc6JLEezF0sUW9VL05XV7y0p14+6Ex5L+7DoLl5JWHKit
         4bhg==
X-Forwarded-Encrypted: i=1; AJvYcCV2cPFFmogE+0aPQeJtfQzsJID+GnWmFjPnM7rh4OE2pECCi/WhT8hwucZoNTsiShEcso3QEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNRBOjeF3RyDvFonc6tmJ3BVj9iRWzdY6qmdRShNbS8Dx8SXi
	KwXnGAoZSomnqhg3mGTgBSSt5tLDe6NnkFNJXeQqe/aoO+jWOLMZhpBwS1Shag==
X-Gm-Gg: ASbGnctxWLSWHzUWn0ga7Q9iIsqTazKMU419mbw0XEYxio7dVyOm+Pm6o+Qw+ycUyy8
	y6qPZ8Ce5yxwd7Jxw7fF5Wq0xYxoeca8Gcx0V2uH4Zfo4HH9qmly3cudu2s4RgIch29HMCBnEP6
	vVViGRD7c46eDkVipgQp/VtMeEbe3TqybA9r2RR2f0EAwXqWtF9Ba7i0UPOUoXg4fbqy7oHXRtv
	idhl45o7i0CgCwb+IMYZsrbMYiuV114IgFv2E13FcL3
X-Google-Smtp-Source: AGHT+IFRejNpSwq8ad9CPlSgB0kK8N2HvIpjbURpmP7KEs6utN9/K2cNkEny1rpEWTrXQgButkPo/A==
X-Received: by 2002:a05:6214:21a8:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6d8c4656a3amr86825166d6.27.1733371066112;
        Wed, 04 Dec 2024 19:57:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6977b5sm2522186d6.43.2024.12.04.19.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 19:57:45 -0800 (PST)
Date: Wed, 04 Dec 2024 22:57:45 -0500
Message-ID: <0539f2c64df66fe4adab6ba9a1030ab1@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241204_1752/pstg-lib:20241204_1702/pstg-pwork:20241204_1752
From: Paul Moore <paul@paul-moore.com>
To: Yafang Shao <laoar.shao@gmail.com>, keescook@chromium.org
Cc: qiuxu.zhuo@intel.com, rostedt@goodmis.org, lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Yafang shao <laoar.shao@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] auditsc: Implement a workaround for a GCC bug triggered  by task comm changes
References: <20241205021100.86390-1-laoar.shao@gmail.com>
In-Reply-To: <20241205021100.86390-1-laoar.shao@gmail.com>

On Dec  4, 2024 Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> A build failure has been reported with the following details:
> 
>    In file included from include/linux/string.h:390,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:63,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from kernel/auditsc.c:37:
>    In function 'sized_strscpy',
>        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>    In function 'sized_strscpy',
>        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
> 
> The issue appears to be a GCC bug, though the root cause remains
> unclear at this time. For now, let's implement a workaround.
> 
> A bug report has also been filed with GCC [0].
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117912 [0]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@intel.com/
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local.home/
> Reported-by: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF389362@CY8PR11MB7134.namprd11.prod.outlook.com/
> Originally-by: Kees Cook <kees@kernel.org>
> Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
> Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/auditsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> v1->2: Add the link of the GCC bug report

Thanks, it looks like the GCC devs have been able to reproduce the
problem, hopefully we'll have a proper fix soon.  Regardless, we need
to resolve this in the kernel *now* so I'm going to merge this into the
audit/stable-6.12 branch and I'll send it up to Linus after it clears
testing.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 279ba5c420a4..561d96affe9f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getlsmprop_obj(t, &context->target_ref);
>  	strscpy(context->target_comm, t->comm);
> +	security_task_getlsmprop_obj(t, &context->target_ref);
>  }
>  
>  /**
> @@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getlsmprop_obj(t, &ctx->target_ref);
>  		strscpy(ctx->target_comm, t->comm);
> +		security_task_getlsmprop_obj(t, &ctx->target_ref);
>  		return 0;
>  	}
>  
> -- 
> 2.43.5

--
paul-moore.com
