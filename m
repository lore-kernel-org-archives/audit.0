Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A21BFDEC
	for <audit@vger.kernel.org>; Thu, 12 Sep 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176133; cv=none; b=HMP6ft/vdU/Zg/+k19GvnBlI3kZ2YZy83G2aAg0+SaH9eqEtMXSN+gjMmdcjw2lD73CdY+Ol71Ch0ITY18i8ZpaxQ7Ecamkjz9tzyZZ8noVXkdR5iuebG5brwnHWooPbOS/Kmc3DfFIopispfzexo7bsbwnJrFrtj1QmaZsIjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176133; c=relaxed/simple;
	bh=TQawtmTUJgfQqSFgNjDib+wpBVm05rng4pvOeawm/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6D3nhfUBqLbZLusLFVZDnLVgAK+3Gb+UHIir1fV65tOOXEvHyvsafKJ5odMzzMpEYx9ttB/jH9E2PStbIVm9iXF8E4mb3RiAGfmr4jv+e2g7g4VoS3n3amBSqEBThWNPu8y6BUPZ8FZoeMYi5OnN9NW7aXTz2Crm4497RFfsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eILEPcnx; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eILEPcnx"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e20de1d302so21733eaf.0
        for <audit@vger.kernel.org>; Thu, 12 Sep 2024 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726176129; x=1726780929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuU9UIhvXjSz78840FaGp7kb94KPeUI24x6/4WDdi4o=;
        b=eILEPcnxbcWGxW1bPxyXVTtgtCjVqE/m0WQPk0oWz0wn9KCYSRt57kJD9Dx6koEWYs
         ZSy6qInfjIoD0+MRhJQ9QdE8cznX7BwTYBONEo0py0hca2CA2XZ5yDYiQy1apZszl8QK
         pdsyyzmDhg1+eyreHRgSmC63C5UryBdu5fKfeceb30PLS8NY1w0kCu/6TIyzTWT7d6J/
         kHwGbQOSz+u+mnYCWmTZ5a6vY0MzgslxbRw8K+85aj20MW8Iz3Dp5MXtNghX+93lmu9D
         1BaicQuINKMLgCrpGV8QHayl+DuKcTchttu8qJaio5xq6i4AfpS9cU+E1hzfS8fDIijg
         jtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726176129; x=1726780929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuU9UIhvXjSz78840FaGp7kb94KPeUI24x6/4WDdi4o=;
        b=LS0ORSKslqnF/6+nCj/83XlvRse8rM5jZpL1lYFWJD3qZezujS5Y3LnmSmg9OJl6a2
         5z/ceZfQCvZ9OdUmhVVtYqp/kPgmQutiK8/rtFqDUlJsCDFwIQzwh17wXVoOjDrUKLL9
         53FMB8Gnpe8368GWCnkQzrlpUTi4WAsuBvZ84pbGK2zu8CdQovlmpOKMUEt4e7xzLMIQ
         QWsNvsvM6ovHshlM+JFE3hZGL7u4gaobRmSOShgDx3+JUH6J265YkMVWpsEYmBUwW1h7
         GwMy5JKF1p1xUC4GHcIDkiAljJ6hrb85jkUPHYNmccVMjqeZAwANgExqS45mhlCZ1RXs
         wS1g==
X-Forwarded-Encrypted: i=1; AJvYcCWp/Z5BVr6IoMS9BimmHK2ld2AgFM4g9joXPZhDw9L2BDNOV0EHbm8CDGul68doJ4z3svzSQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxThg86cwYfXgKQzqVemLEGBdZdjDUUshsgtoifJjq/oOflJ+Hg
	gdTEEmi0vt57vRzWjkagbW5hx9mcSgJMq6zz9iDfiiUcBE21LtUFTgS/hkUssw==
X-Google-Smtp-Source: AGHT+IFkVoD/Nk+SYy04kMCW6WhfdrSdzd/PRUZlVwBXDw7def1QUPBiiqZ1N65kkjgIJI+qKHmPfQ==
X-Received: by 2002:a05:687c:2c2a:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-27c68955c20mr593311fac.15.1726176129175;
        Thu, 12 Sep 2024 14:22:09 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3ebabfcsm3299170fac.24.2024.09.12.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:22:08 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:22:05 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v8 7/8] net: Replace strcpy() with strscpy()
Message-ID: <sp3njca35fg5drajiy5ofq5t6nfmbhzec3alsm2o4itsdispdt@e45zirwvovcm>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-8-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-8-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:20AM GMT, Yafang Shao wrote:
> To prevent errors from occurring when the src string is longer than the dst
> string in strcpy(), we should use strscpy() instead. This approach
> also facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv6/ndisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index b8eec1b6cc2c..cf7c36463b33 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1944,7 +1944,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
>  	static char warncomm[TASK_COMM_LEN];
>  	static int warned;
>  	if (strcmp(warncomm, current->comm) && warned < 5) {
> -		strcpy(warncomm, current->comm);
> +		strscpy(warncomm, current->comm);
>  		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
>  			warncomm, func,
>  			dev_name, ctl->procname,
> -- 
> 2.43.5
> 
>

Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks
Justin
