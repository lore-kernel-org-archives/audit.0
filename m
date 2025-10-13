Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2771D5CD4
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383043; cv=none; b=A0I/FPM976moOB5JIDZZkJBkcY86LUSYL/VSlhIWjDqxxwvhQPZziL8sUawCAX+WXCErrgyvoip3sNOsDuSF1y3Cb7xGlrQabN8GnQ7iNJ5pRY87LD486cT6QDDoR5SmEn47LOZRLdYlH94EGs5YvZl9xIda1ewA1+e0tN9ua2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383043; c=relaxed/simple;
	bh=vWhjl6PoCPVfQAMi5cZ/kt5Eb+dD2jHQQZjo1Kl9UbU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=njKdzhYcIZSo6CU9z4YXZ52fMRs+x5GYGM9o58qorFSC4QDC+Y0Vwo12e8BnjXdcy+j/eHhkDObfn5FoywINkNZesqNDMFFCSpMEBqp97Y8/o5VMf+cYMPrz/GcvkAvQs0rwQ4Jgph9q/02ONzLrpAMnLTPW5ztZUkA7VJCW+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Uf+l401+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Uf+l401+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-795be3a3644so34678876d6.0
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760383041; x=1760987841; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHhNPd89uW0OatizWwm8WuvlRYH5Pj8OUfvUqnc+kcA=;
        b=Uf+l401+WfuDDl9nmCdATjsPuSX+yBzEJn1ZPe0g2o2qvZgwmvXNw4IeEhXlHvaNMy
         URC/z8nPxU9TofrAXe3XqRauzu/1BfRBV8Qkw3RA/WJZ2NQ7rPI4Yc54+r3nsx9lzpxd
         i/JLWSPjWiW+BwHQcoBHrP0UoV6VWxUZfix1Op9JKl+la+Xv+HwPhRd5ILHfwTECACuZ
         oE6n25/dZekuKEOUH7DOYPROcF0TlVInhDT75liL+X0DM7qVk5sCS/SDtQHn7RxpbBQ/
         6zFjJrZ6UKIUWkGJNSiUgD+HnCHLwSTdxkSchZbLCn/VITXHAzWNQrr78P9wIKQHCTHK
         vpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760383041; x=1760987841;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CHhNPd89uW0OatizWwm8WuvlRYH5Pj8OUfvUqnc+kcA=;
        b=iX2OA+bz1kRNw37Nxs74rNMnnOMllrXghaax2lNLaxZ7ujBhbBNncbwSK80gQJt2qp
         vNW5i5YYXPkqSJWM8UKYe1NqfMIu2Z2LxraHF+/xtiINOMV+JDqKX5S3G05QiWvFQgcD
         t7HzEqbAQVDrLU/hvWpfhldlOGjH30XPNF6D8DCoY68VHUpjawC+4SK2U7WXJXlLborD
         wTTwi5dwhDCTHytJNBky4e8qAby8mTumlsrA26UrC9Eo6bokArCCcPR0ebcDLZcTqNt0
         iDY+/zV1A4z+h8suNPEzO5CJ3YPx7uYjtCkkiPO7L00LSoZgfHnLeiyvQQDFROjE/nlI
         b2cA==
X-Forwarded-Encrypted: i=1; AJvYcCWM1lehbf3uxJXPI9amMIbS38Vm5bWIkELQQrjrh2szlxNsSskEc98l7/f2wMt4Xp057sO8IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDxGbY+LAMzYld3uFUefmig0PEDD30plA9rAyZgVhrTvBhbbQ
	HWf+Rf34FPMIvhJbWcAX3W+z0CLLEjDntbKlLEoJIEKPGZ8AfavnTc1IIPMoRBbu9w==
X-Gm-Gg: ASbGncvi8aRNZSEHpIIWVFMejBnVsThWnJdpHOVIMP0DMHZUQzPXCRqKulKY3l4Te5Q
	1EWRoHz9ZDYkUOt+xuErlrZ4+Gd35VDUWiVtFauu6Sq7VJqb0mPT+Co3mFGL1GKiBvAaTSNXNlp
	P1tDoCu3opPuXAAPEySVTWfnRFqpA72ypNm5s7g1XeuC746qTko8z5pWKyOyekZB1D6+NqRYAtj
	hdAqt0JSiTQWYnQSg2TUlkGQjF0SEmmS5QzI7qWp0vQuafQQ/Re0ZzLPfcrl/2EvELvWMRMaSVq
	275DxmfIKnYqUUqpBJEhErOMPaBYEhDBGEjVyQkoDAu5rZB+0xlXqguPb5CasNr78pVE0X5mfwi
	fI2j5+v1Gn9w9MOa+Wjocx0ckdGUdV+KYgQbM2KR+fGwgHRDUks6z1ibYWy8H27spvReui16Fmm
	h9U4xmE5dMfck=
X-Google-Smtp-Source: AGHT+IH4qPOBpyMQ+sZuD5z+/Hd39mQO7gOWoRYkJohE8XZt/wm19XtyyinMMi7AtpQgte5JWrNyZA==
X-Received: by 2002:a05:6214:21cd:b0:7ab:da21:bab1 with SMTP id 6a1803df08f44-87b20feda9fmr263925356d6.6.1760383040912;
        Mon, 13 Oct 2025 12:17:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc3592352sm76601646d6.44.2025.10.13.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:17:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:17:19 -0400
Message-ID: <afae09deb55bcbfabe607fc2ee7997bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251013_1430/pstg-lib:20251013_1119/pstg-pwork:20251013_1430
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
References: <20250904165919.3362000-1-rrobaina@redhat.com>
In-Reply-To: <20250904165919.3362000-1-rrobaina@redhat.com>

On Sep  4, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
>  kernel/auditsc.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)

Thanks Ricardo, that's a nice improvement!  I saw a few additional things
that could help simplify the code and possibly speed things up a bit
more, see my comments below.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index eb98cd6fe91f..7abfb68687fb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2437,44 +2437,40 @@ void __audit_inode_child(struct inode *parent,
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
> +		    (n->type == AUDIT_TYPE_PARENT || n->type == AUDIT_TYPE_UNKNOWN) &&
> +		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> +		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = AUDIT_TYPE_PARENT;

We probably don't need to check 'n->type' first, as we want it to always
be set to AUDIT_TYPE_PARENT regardless of it's current value.

>  			found_parent = n;

We can probably 'continue' here since a match can't be both a parent and
a child at the same time.

Similarly, if we add move the 'if (found_parent && found_child)' check
up to here we don't need to run it on every pass through the loop, just
when we find a match.

Taking the two comment above into account, I would imagine something like
this would good:

  found_parent = n;
  if (found_child)
    break;
  continue;

> -			break;
>  		}
> -	}
>  
> -	cond_resched();
> -
> -	/* is there a matching child entry? */
> -	list_for_each_entry(n, &context->names_list, list) {
> -		/* can only match entries that have a name */
> -		if (!n->name ||
> -		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
> -			continue;
> -
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

Similar to the parent case above, let's check to see if both a parent and
a child have been found.  We can probably skip the 'continue' here are we
are at the end of the loop.

  found_child = n;
  if (found_parent)
    break;

> -			break;
>  		}
> +
> +		if (found_parent && found_child)
> +			break;
>  	}
>  
> +	cond_resched();

The 'cond_resched()' call was located between the two loops to help avoid
a soft lockup caused by running through both loops; since we are now
condensing that into one loop we can probably drop the 'cond_resched()'
call ... which is definitely a good thing as it was a bit of a hack, a
necessary hack, but still a hack :)

>  	if (!found_parent) {
>  		/* create a new, "anonymous" parent record */
>  		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
> -- 
> 2.51.0

--
paul-moore.com
