Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938131A07B
	for <audit@vger.kernel.org>; Fri, 27 Feb 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210289; cv=none; b=Tu+bhx8HfS/j/ZvBApkver4Q3K3r4M/drLFo1kNcVh8VfLtdcmZnJ//wkKhGTVH5CS5tIwfC1zYAup8xg4W+a7vNs2Ra08PYiYfZKhukzleH4XYZA22Kj3BUW8Z6qZSUSw72vyYIbTSNG3/s2hdryE9cKhOAi3dDHAPir2lKQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210289; c=relaxed/simple;
	bh=lMXL/mlAqimXseoJgvNhre8MEuktOnws6M1xMb7iwqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IT72xbADCqgKvgdiLHoweJLXJZjDegFE48boQluYTlVnba39mwcPEXSTkotq/kV+tWO2svCWVNckBxYS0t5RIyk3fHDuQfGbjYwOT2q+ayE5nR0SYvwtI+hpPo87ryMFbpOSuM0jwna2cLlW2fN2k5VKgTVCbKfo9rYSah/s784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hza2df8c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hza2df8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772210287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cFN0VjvhWLaPYkQMfpAy7AmX3Ya0VP+SIdEjxLHDri0=;
	b=Hza2df8c2AH6Byd0MXCr8wd3bbZMx2dESenJmTMFN3jaAOj3my5gd3M+b8UHfzZD8P+xZA
	v1a4NdFOH/VpXgwC8ehhxvmPxfAcHqabhQN5sQOdSs1nsnitPAEVBsvYeYwz1TK7+0D2bX
	CNAlQg2JkWlJRtFQQrit1BM92aYjkI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-w4kegXWqM1KLOSA01oC0zA-1; Fri,
 27 Feb 2026 11:38:03 -0500
X-MC-Unique: w4kegXWqM1KLOSA01oC0zA-1
X-Mimecast-MFC-AGG-ID: w4kegXWqM1KLOSA01oC0zA_1772210282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85BD81956068;
	Fri, 27 Feb 2026 16:38:01 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51C63180066F;
	Fri, 27 Feb 2026 16:37:56 +0000 (UTC)
Date: Fri, 27 Feb 2026 11:37:52 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	audit@vger.kernel.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool() APIs
 to get/put pwd references
Message-ID: <aaHIYHFH68nM4jQ5@madcap2.tricolour.ca>
References: <20260206201918.1988344-1-longman@redhat.com>
 <20260206201918.1988344-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260206201918.1988344-3-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: k3qqe41MVGtCjHbdCR5BTa_-6g5L_oS8LQdJHRF_Irc_1772210282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2026-02-06 15:19, Waiman Long wrote:
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
> 
> To avoid this kind of performance regression, use the new
> get_fs_pwd_pool() and put_fs_pwd_pool() APIs to acquire and release a
> fs->pwd reference. This should greatly reduce the number of path_get()
> and path_put() calls that are needed.
> 
> After installing a test kernel with auditing enabled and counters
> added to track the get_fs_pwd_pool() and put_fs_pwd_pool() calls on
> a 2-socket 96-core test system and running a parallel kernel build,
> the counter values for this particular test run were shown below.
> 
>   fs_get_path=307,903
>   fs_get_pool=56,583,192
>   fs_put_path=6,209
>   fs_put_pool=56,885,147
> 
> Of the about 57M calls to get_fs_pwd_pool() and put_fs_pwd_pool(), the
> majority of them are just updating the pwd_refs counters. Only less than
> 1% of those calls require an actual path_get() and path_put() calls. The
> difference between fs_get_path and fs_put_path represents the extra pwd
> references that were still stored in various active task->fs's when the
> counter values were retrieved.
> 
> It can be seen that the number of path_get() and path_put() calls are
> reduced by quite a lot.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/auditsc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index dd0563a8e0be..af22f8be4d70 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -931,6 +931,9 @@ static inline void audit_free_names(struct audit_context *context)
>  {
>  	struct audit_names *n, *next;
>  
> +	if (!context->name_count)
> +		return;	/* audit_alloc_name() has not been called */
> +
>  	list_for_each_entry_safe(n, next, &context->names_list, list) {
>  		list_del(&n->list);
>  		if (n->name)
> @@ -939,7 +942,7 @@ static inline void audit_free_names(struct audit_context *context)
>  			kfree(n);
>  	}
>  	context->name_count = 0;
> -	path_put(&context->pwd);
> +	put_fs_pwd_pool(current->fs, &context->pwd);
>  	context->pwd.dentry = NULL;
>  	context->pwd.mnt = NULL;
>  }
> @@ -2165,7 +2168,7 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
>  
>  	context->name_count++;
>  	if (!context->pwd.dentry)
> -		get_fs_pwd(current->fs, &context->pwd);
> +		get_fs_pwd_pool(current->fs, &context->pwd);
>  	return aname;
>  }
>  
> -- 
> 2.52.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

