Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7A21B426
	for <audit@vger.kernel.org>; Tue, 12 Nov 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449194; cv=none; b=nHJx5lKI0URLlTfpe9B4oxr8Muo6GbeTy+fdywjhSTknLyWInlEK3C2kP9ZpLoL8dUSOI4fHN2M0dSH53UsyWl8TxYSqSzXZJqVzlzeFbAOIZvzrownX+FehzNYB69YUUQzuwEqFhdt93GR1X7t+vQkCL3b8pYW5H54O9SbYYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449194; c=relaxed/simple;
	bh=i4EMPQW1PxJFEmc9RTtHUH302zIFgA67WJ/uqyRqwTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpNlHIvSATFeWmx3joJzfoL1luSqSSVOhwqDwuj4140qOXt+g9Znj2xCdRxs3vf5FyJeDbhujdOY2VK8zY49I8qijJmmr8zv5i2u2rVVPZ9rRjREZ2qHZz9jDSoPxJ2Dm3gl85/d2slJdBDn0osbayHUtbE3snp5MFkc8z2NNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QElvhwaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QElvhwaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731449191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Opbk5CisPAPeD1z2ZdpIAuUoCHESrrQTOa2uV2H9r5U=;
	b=QElvhwajR4D0HF+nLThhG/O5LPDGEQFl4BA5ZyiyPzGC4asb1PYbF8Foq5oFoEQPR/eOtU
	uKlgNUeMaRUyzpBfnzEEHM6u1J6v2zT1pS6BmKwpLLBPHGg8v3Gn832ZOp2Rz/s1ZrSZ4C
	t/6Z5T0AiTrJJtBjQpt2u52Jye4A8Sc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-HfCfHNvSOpWctwiO8N006g-1; Tue,
 12 Nov 2024 17:06:29 -0500
X-MC-Unique: HfCfHNvSOpWctwiO8N006g-1
X-Mimecast-MFC-AGG-ID: HfCfHNvSOpWctwiO8N006g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F6D31953953;
	Tue, 12 Nov 2024 22:06:28 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.13])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D04D21956054;
	Tue, 12 Nov 2024 22:06:26 +0000 (UTC)
Date: Tue, 12 Nov 2024 17:06:24 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, eparis@redhat.com
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in
 __audit_inode_child()
Message-ID: <ZzPRYCEjL16p0vew@madcap2.tricolour.ca>
References: <20241105123807.1257948-1-rrobaina@redhat.com>
 <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 2024-11-11 17:06, Paul Moore wrote:
> On Nov  5, 2024 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > 
> > When the user specifies a directory to delete with the suffix '/',
> > the audit record fails to collect the filename, resulting in the
> > following logs:
> > 
> >  type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=2 name=(null)
> >  type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=1 name=(null)
> > 
> > It happens because the value of the variables dname, and n->name->name
> > in __audit_inode_child() differ only by the suffix '/'. This commit
> > treats this corner case by cleaning the input and passing the correct
> > filename to audit_compare_dname_path().
> > 
> > Steps to reproduce the issue:
> > 
> >  # auditctl -w /tmp
> >  $ mkdir /tmp/foo
> >  $ rm -r /tmp/foo/ or rmdir /tmp/foo/
> >  # ausearch -i | grep PATH | tail -3
> > 
> > This patch is based on a GitHub patch/PR by user @hqh2010.
> > https://github.com/linux-audit/audit-kernel/pull/148
> > 
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6f0d6fb6523f..d4fbac6b71a8 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2419,7 +2419,8 @@ void __audit_inode_child(struct inode *parent,
> >  	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
> >  	struct audit_entry *e;
> >  	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
> > -	int i;
> > +	int i, dlen, nlen;
> > +	char *fn = NULL;
> >  
> >  	if (context->context == AUDIT_CTX_UNUSED)
> >  		return;
> > @@ -2443,6 +2444,7 @@ void __audit_inode_child(struct inode *parent,
> >  	if (inode)
> >  		handle_one(inode);
> >  
> > +	dlen = strlen(dname->name);
> >  	/* look for a parent entry first */
> >  	list_for_each_entry(n, &context->names_list, list) {
> >  		if (!n->name ||
> > @@ -2450,15 +2452,27 @@ void __audit_inode_child(struct inode *parent,
> >  		     n->type != AUDIT_TYPE_UNKNOWN))
> >  			continue;
> >  
> > +		/* special case, entry name has the sufix "/" */
> 
> /sufix/suffix/
> 
> > +		nlen = strlen(n->name->name);
> > +		if (dname->name[dlen - 1] != '/' && n->name->name[nlen - 1] == '/') {
> 
> I'm guessing @dname is never going to have a trailing slash so we don't
> care about @n missing the trailing slash?
> 
> > +			fn = kmalloc(PATH_MAX, GFP_KERNEL);
> > +			if (!fn) {
> > +				audit_panic("out of memory in __audit_inode_child()");
> > +				return;
> > +			}
> > +			strscpy(fn, n->name->name, nlen);
> > +		}
> 
> I'm looking at the extra work involved above with the alloc/copy and I'm
> wondering if we can't solve this a bit more generically (I suspect all
> the audit_compare_dname_path() callers may have similar issues) and with
> out the additional alloc/copy.

I had similar concerns about the alloc/copy and using a fixed length
compare but hadn't thought of generalizing it.

> This is completely untested, I didn't even compile it, but what about
> something like the following?  We do add an extra strlen(), but that is
> going to be faster than the alloc/copy.

I agree this is a better approach.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 470041c49a44..c30c2ee9fb77 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1320,10 +1320,13 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
>                 return 1;
>  
>         parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
> -       if (pathlen - parentlen != dlen)
> -               return 1;
> -
>         p = path + parentlen;
> +       pathlen = strlen(p);
> +       if (p[pathlen - 1] == '/')
> +               pathlen--;
> +
> +       if (pathlen != dlen)
> +               return 1;
>  
>         return strncmp(p, dname->name, dlen);
>  }
> 
> >  		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> >  		    !audit_compare_dname_path(dname,
> > -					      n->name->name, n->name_len)) {
> > +					      fn ? fn : n->name->name, n->name_len)) {
> >  			if (n->type == AUDIT_TYPE_UNKNOWN)
> >  				n->type = AUDIT_TYPE_PARENT;
> >  			found_parent = n;
> >  			break;
> >  		}
> >  	}
> > +	kfree(fn);
> >  
> >  	cond_resched();
> >  
> > -- 
> > 2.47.0
> 
> --
> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

