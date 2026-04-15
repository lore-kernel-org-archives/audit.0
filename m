Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3102432BF24
	for <audit@vger.kernel.org>; Wed, 15 Apr 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277370; cv=none; b=sohA632naUvsHrrOtxOPSR0iWTSGmIMzJN7b1n5guKvXQjkfIq6/jk1Q7qUlVn+asUe/i9jVw9N/8qngSS7ah9mxSw4SOh4+JhWlUkcHX4jIlyrAu2F19ZJER6SmBLsrV8qDq2MZ2d/q9UfBu2QZ5d89Iybb+iGJ9Eqhn5BMi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277370; c=relaxed/simple;
	bh=9UQxRFX+zk9oLyJrcpNXGNppAUHeYE1/jhVVN4dQIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=isp16YnByUNh/Ry4slgslvKZyTy5R8Q6F42PO3n/U7FAv85+N3UgJIhngrQQvB/SY2o3udTPzijBxAzKZ9GdJ5b1ayVpfzBsGyO/CwzJCkZFJRO2OTtl0rqaIGfWMf9uWQuD791YwwX2mnTqk0ReAbLI24+aSjotxQFb0b21m4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2PclzL5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2PclzL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776277368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iV8KAQV0njHyHYRqHjYxlGtxa+oGeeRWr3oSFsYbpYY=;
	b=V2PclzL5Uzh2/a4q2XldMYLoI6ZJ1TO7c5LpX1qXXy1v7e2nDv9FAnaogtCOIMAeNX6LAs
	Jpru/hNgRgkcLYoYMzVudqsEVdDeyEfbPyBLU2gZE26E78YQI0pVAxYge0umtaksJKGqjd
	t7YfquIc4qZ0fxlUHZZVdQs3d41ukQQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-xT3dFDPzM0ejzmvxHcgKWw-1; Wed,
 15 Apr 2026 14:22:44 -0400
X-MC-Unique: xT3dFDPzM0ejzmvxHcgKWw-1
X-Mimecast-MFC-AGG-ID: xT3dFDPzM0ejzmvxHcgKWw_1776277364
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C0601977015;
	Wed, 15 Apr 2026 18:22:35 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.76.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E891955F25;
	Wed, 15 Apr 2026 18:22:32 +0000 (UTC)
Date: Wed, 15 Apr 2026 14:22:28 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, longman@redhat.com
Subject: Re: [PATCH 2/2] audit: fix removal of dangling executable rules
Message-ID: <ad/XZJ9WtvfMIo0i@madcap2.tricolour.ca>
References: <cover.1776176104.git.rrobaina@redhat.com>
 <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: K94Z69VDGIvWR-qhMzVKaKlDQBu7S00LqWTwZw9H5P8_1776277364
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2026-04-14 17:00, Ricardo Robaina wrote:
> When an audited executable is deleted from the disk, its dentry
> becomes negative. Any later attempt to delete the associated audit
> rule will lead to audit_alloc_mark() encountering this negative
> dentry and immediately aborting, returning -ENOENT.
> 
> This early abort prevents the subsystem from allocating the temporary
> fsnotify mark needed to construct the search key, meaning the kernel
> cannot find the existing rule in its own lists to delete it. This
> leaves a dangling rule in memory, resulting in the following error
> while attempting to delete the rule:
> 
>  # ./audit-dupe-exe-deadlock.sh
>  No rules
>  Error deleting rule (No such file or directory)
>  There was an error while processing parameters
> 
>  # auditctl -l
>  -a always,exit -S all -F exe=/tmp/file -F path=/tmp/file -F key=dr
> 
>  # auditctl -D
>  Error deleting rule (No such file or directory)
>  There was an error while processing parameters
> 
> This patch fixes this issue by removing the d_really_is_negative()
> check. By doing so, a dummy mark can be successfully generated for
> the deleted path, which allows the audit subsystem to properly match
> and flush the dangling rule.
> 
> Fixes: 76a53de6f7ff ("VFS/audit: introduce kern_path_parent() for audit")
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/audit_fsnotify.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index eee589bca86e..703a110cebd4 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -86,10 +86,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  		dentry = kern_path_parent(pathname, &path);
>  		if (IS_ERR(dentry))
>  			return ERR_CAST(dentry); /* returning an error */
> -		if (d_really_is_negative(dentry)) {
> -			audit_mark = ERR_PTR(-ENOENT);
> -			goto out;
> -		}
>  	}
>  
>  	audit_mark = kzalloc_obj(*audit_mark);
> -- 
> 2.53.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

