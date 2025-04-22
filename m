Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA441F180E
	for <audit@vger.kernel.org>; Tue, 22 Apr 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336272; cv=none; b=BCoPnV7g9OV3sKPHncDelc7R8Ef/vpUOjsJugl3WdYFl5YGz7qL5hLEb676fZt3gafgAgbVs1/zvNbUXnvUJI6kmbffxLeAvxHZm6cA4eHsjebq3Vo7VP6h1YpJBN5xApAPQtGPJ2LDFr8qEgcfcg40gWidQrNtgfq9KJrjPVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336272; c=relaxed/simple;
	bh=jFZ1V84giT+YUQdEZUVPilmzVULgCGOUEFQfGNQ4RSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCG2m+TR3iy3US5mVVTrtUAm1wOt5hRmymxM/lETfsgmVYbgeHtSHYupE+3834LMLhzOPj9Pi4ObmgFj1JlTZYVDAj2qjp5whjQ6j0rI/LsFgS7a8DQ35RpRCUw/9yx1mWwH3+QE6wS55t9e//Y+JiuWTrhv/W6tJRQglfux+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJ1kCbor; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ1kCbor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745336269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcu1mJHODKObLksxc4A59swiNVK6LroG71Dl9SlbtDA=;
	b=BJ1kCbormGwo74YJX8kGxB63IFA+rrjLKzVhnEAs4ASgEXssrk4ikAWl12TqyALb+OUrb9
	8R4yvT3ieLGYBrmyhlQ1os4W9NrnRrtWZbxP1RQfrFiSOlt/eGyuO9Eqz17an8B96i5zdJ
	HCt05hNnGlJJ/giCJ7UNS2zUHwg+9Eo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-hp0aCYEXNbOBG2kQPca4kw-1; Tue,
 22 Apr 2025 11:37:46 -0400
X-MC-Unique: hp0aCYEXNbOBG2kQPca4kw-1
X-Mimecast-MFC-AGG-ID: hp0aCYEXNbOBG2kQPca4kw_1745336265
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD11A1955DCC;
	Tue, 22 Apr 2025 15:37:44 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B458B19560AB;
	Tue, 22 Apr 2025 15:37:41 +0000 (UTC)
Date: Tue, 22 Apr 2025 11:37:38 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure
 case
Message-ID: <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
 <92e9622d6dd1bd3e59a36269275aa1fe@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e9622d6dd1bd3e59a36269275aa1fe@paul-moore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 2025-04-11 14:23, Paul Moore wrote:
> On Mar 17, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > 
> > The move of the module sanity check to earlier skipped the audit logging
> > call in the case of failure and to a place where the previously used
> > context is unavailable.
> > 
> > Add an audit logging call for the module loading failure case and get
> > the module name when possible.
> > 
> > Link: https://issues.redhat.com/browse/RHEL-52839
> > Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Changelog:
> > v2
> > - use info->name for both audit_log_kern_module() calls and add const
> > ---
> >  include/linux/audit.h | 9 ++++-----
> >  kernel/audit.h        | 2 +-
> >  kernel/auditsc.c      | 2 +-
> >  kernel/module/main.c  | 6 ++++--
> >  4 files changed, 10 insertions(+), 9 deletions(-)
> 
> Agree with Petr's previous comment about the URL in the commit
> description, if it isn't publicly accessible please don't include it in
> the commit description; I'm going to remove it.

Sorry, I thought I had checked it more than once to make sure it was
visible.  It should be now.  Please re-add the link.

> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 1fb9ad289a6f..efa62ace1b23 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  
> >  	module_allocated = true;
> >  
> > -	audit_log_kern_module(mod->name);
> > +	audit_log_kern_module(info->name);
> >  
> >  	/* Reserve our place in the list. */
> >  	err = add_unformed_module(mod);
> > @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  	 * failures once the proper module was allocated and
> >  	 * before that.
> >  	 */
> > -	if (!module_allocated)
> > +	if (!module_allocated) {
> > +		audit_log_kern_module(info->name ? info->name : "(unavailable)");
> 
> In keeping with audit tradition, wouldn't we want this to be "?" instead
> of "(unavailable)"?
> 
> >  		mod_stat_bump_becoming(info, flags);
> > +	}
> >  	free_copy(info, flags);
> >  	return err;
> >  }
> > -- 
> > 2.43.5
> 
> --
> paul-moore.com
> _______________________________________________
> Linux-audit mailing list -- linux-audit@lists.linux-audit.osci.io
> To unsubscribe send an email to linux-audit-leave@lists.linux-audit.osci.io

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

