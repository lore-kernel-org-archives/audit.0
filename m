Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97826264A86
	for <audit@vger.kernel.org>; Thu, 23 Oct 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244880; cv=none; b=K5JPLareWaIjFtxuKhwr3fF+WKxxqtMEAPZdZIIYa0iZ4AF+T8LSbUt9VEfA6BLaN4LXzd41aBA1Bwr3t5JaEpPpKuec170n9fVMQz3lR9m367VzQQRzMtokm3PSbDXpRpSvRcXJQoxFerReZs2Svrgd6wH/3m6ACLQQz0HtJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244880; c=relaxed/simple;
	bh=IB4y5AHNYRtdR201nNfBi/IkRYsNB8voCIGCo03zGns=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=D/CGT4lcRs+YfBOm0IZOQepc4nVf63CEavNmRXRfUZeOEsubJ79GXXFR2+mOzIiB0BB5/hj2ydpEWKfPkmHxftXJruxecGmqS/LG7zKAASefDEsa/EHIFFSH48r4wVnhma+6IG7G663SJyuju0idC5/ZV06f65TNAX/upKPKY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JP14phuU; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JP14phuU"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89048f76ec2so129945485a.1
        for <audit@vger.kernel.org>; Thu, 23 Oct 2025 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761244877; x=1761849677; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tmaPCByA6miqx0CEbKAWxagIl28CyBryGaexUihdIk=;
        b=JP14phuUJMQ4hGdpp4n0stnQ5tTuq1dJ88+Jl470jr8mVCM72gnhuUXm6en1SynR8A
         ZzAQnG2dG3obJmQwScQtAtRn9RYgRMrCRqpYZ8le9OxoVRIMKpOr1DS62drWu6/zDxTW
         qb8hBdCYfFYgens3U8a16Ie0ib9jfjiLBuQkGyvUjVpLt2VckTmFk+bB6bAj+npG2xUN
         sAN/EBBiFY1gbcwC4e7lzgzbv2C+A4A+58DC1aQWg4i2yZeozS39mCDaxjryCFntv9rt
         ww0Kz28WrGhedEreYtmF7H5QBel0XpAj5EhBubJsF2IjI8qRwmVnGNA70s7GoYt4eHFw
         U4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244877; x=1761849677;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tmaPCByA6miqx0CEbKAWxagIl28CyBryGaexUihdIk=;
        b=oFdkj+xIG7dlJsFr02i+7MfBwFWa5g7KC0WSiU6ihOFQx36YgwYHnidSM3O5VbY5S4
         XG356xHCyv9lLJaCgMT9JjDTY5h11TcBqnOVkwszQYzsTihoDlcxlI4l9NPI8zg38wta
         2KJnTaYn/8+uGOTnfoN9WRDOEH+qSFoFpdCdt7Y0487tJXjIQ4L8aiWUmolqqizwo5w+
         pnWc7YSS9iQiGxqRuW+fCEhiPK3hkIWygCsjnHM0KepnoJTyYpar6OUjH7x6ZiMSfpP5
         bo/77ioCmo3hh8lCW/phOBVDHuoCbYCWVPlMxL8icGrFoCbol0jiUdbhemlubZv3vFAw
         br/w==
X-Forwarded-Encrypted: i=1; AJvYcCVpGvciyGsjas6pW4Bm4mbpqHP5He8gtIpOUQ4cf0cUIXcS6i6M2wz6tvNhdBplrBrjlKT1kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOB0E8bUXcq6h0Hiaxh6Oa4gTY9HpXzpfthkCRUL9mRPzZBfZn
	ibztqvgRFSOIF9QbpG+RAkxuRQaq2jC+evZNxM1QqZ6yD9A75lyB7o+EnnTySkrQ9A==
X-Gm-Gg: ASbGncvIrLcBIp4zj5vjzZpmu93xawR5t1IGbgYoJahAnBXU2jGY9AM5deEYpKZzMve
	yMRlq/i+LSrSPxYOzoc72JGXXR22LwY01yHz5KoE2svJlxZDJUWA848ZZzTE2EOUUKoVsmScpXq
	So9fBdiumMTpXQ/KPBXBNZkZ/UQXGVVPZ3pvLmhO1MdhR67yRmZbA8YkYrcMCWlcxbIwnaLKiaY
	R5JsuGaBC4NVaqsabyDI2uRxcktzn+gGCdM0w8lD+lqDb65rw2+9chBi25b7eNDzfoObzvzy5gR
	xWWNy7bF8IKmPPWOxH2+N0zvdMR/FlEAzr/Zy+KZ8ZE/SyVuYmF3r5yxcQh62EDJ89MCAY52DeH
	Yq0H1Hi4C8teovaoXWX4xBrM27ymETSJMHdAMOxlMEHDzpUL4QG7dgViuNWqyIj7nMlU5nrgMOm
	klDF6GIp7aY8qRswFdTA0bC28/Cpj2j84u0xzGRymfMsh1VnyJBh3hn7o4
X-Google-Smtp-Source: AGHT+IGZGIJd5kSR4u1priNBK708NaQacpDTp6H7OVf6iWV3fUrpgDJKeJJaqGKCTMOXVL/lQFnYiQ==
X-Received: by 2002:a05:620a:4481:b0:89a:ad1c:5157 with SMTP id af79cd13be357-89aad1c55b2mr864530885a.0.1761244877347;
        Thu, 23 Oct 2025 11:41:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11e62e3esm212229885a.42.2025.10.23.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:41:16 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:41:15 -0400
Message-ID: <cd4576d9d4a00366283a116ab14231f5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251022_1701/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
References: <20251022123644.1560744-1-rrobaina@redhat.com>
In-Reply-To: <20251022123644.1560744-1-rrobaina@redhat.com>

On Oct 22, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
> 
>    # uname -r
>    6.17.0-rc3+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
> 
>    # perf record -a insmod loop max_loop=1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> 
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
> 
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
> 
>    # uname -r
>    6.17.0-rc3+-enhanced
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1966144bdfe..8cebc016d9eb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2416,41 +2416,36 @@ void __audit_inode_child(struct inode *parent,
>  	if (inode)
>  		handle_one(inode);
>  
> -	/* look for a parent entry first */
>  	list_for_each_entry(n, &context->names_list, list) {
> -		if (!n->name ||
> -		    (n->type != AUDIT_TYPE_PARENT &&
> -		     n->type != AUDIT_TYPE_UNKNOWN))
> +		/* can only match entries that have a name */
> +		if (!n->name)
>  			continue;
>  
> -		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> -		    !audit_compare_dname_path(dname,
> -					      n->name->name, n->name_len)) {
> +		/* look for a parent entry first */
> +		if (!found_parent &&
> +		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> +		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = AUDIT_TYPE_PARENT;

As mentioned in my feedback on your v1 patch, we can probably set
n->type equal to AUDIT_TYPE_PARENT without checking n->type first
as it we want this set to AUDIT_TYPE_PARENT regardless.

Please either fix this, or explain why it needs to be the way that it
is in your v2 patch.

>  			found_parent = n;
> -			break;
> -		}
> -	}
> -
> -	cond_resched();
> -
> -	/* is there a matching child entry? */
> -	list_for_each_entry(n, &context->names_list, list) {
> -		/* can only match entries that have a name */
> -		if (!n->name ||
> -		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
> +			if (found_child)
> +				break;
>  			continue;
> +		}
>  
> -		if (!strcmp(dname->name, n->name->name) ||
> -		    !audit_compare_dname_path(dname, n->name->name,
> +		/* is there a matching child entry? */
> +		if (!found_child &&
> +		    (n->type == type || n->type == AUDIT_TYPE_UNKNOWN) &&
> +		    (!strcmp(dname->name, n->name->name) ||
> +		     !audit_compare_dname_path(dname, n->name->name,
>  						found_parent ?
>  						found_parent->name_len :
> -						AUDIT_NAME_FULL)) {
> +						AUDIT_NAME_FULL))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = type;
>  			found_child = n;
> -			break;
> +			if (found_parent)
> +				break;
>  		}
>  	}
>  
> -- 
> 2.51.0

--
paul-moore.com
