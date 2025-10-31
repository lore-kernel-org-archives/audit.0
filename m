Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863A1A76DE
	for <audit@vger.kernel.org>; Fri, 31 Oct 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921940; cv=none; b=LdTmKkyV0qloF2AWGJFkm14o5V9dz+a23tsdm13K8Hf2bNMVQbak1qxj8jVFg5XqtvFE6H7vrFLTPsKo5quqmO9CW/PLkrg6B9QYeHuhp0fmsMqTx7x9+krvk4u08O7MMilP2naDUivMBtFyVhEN4GGpRFvtdyQViWEEwuA/X8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921940; c=relaxed/simple;
	bh=s/h+xeadJlbYtXcDkYDQSaTnoitNRuKIJsoQoIQocw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ/L4n6LCt/40wpn5Gb0kb8a7PQoVJP8CKOWeyWH90JXw2IQnI9g2T3bE4SJGaP2KU8HYCSotNMPmC/+VjfzplkX3Nfa0LSogrOrstw4Ux8Q8aQ9bXhsFz5P6giFBrqqvGq4LNzzY112vtJqSTRQ5RrW5kv/rY3nXN3pwo/tLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBzTv0hc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBzTv0hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761921936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DX4abzNNClk60Xm9uZ5i2oidpiAB527b9PJpwtS6gkQ=;
	b=GBzTv0hcecbxAvkIPVewszOKR66ss4Gcp3QdobXfhjCRO7vrxdrWaFGTWRvQXFebZPc5tO
	qLx52oQBZNQ+J0PpQUxprs2/FnLrgQNf0yVOGAE0+WrHTFb9vdxwzlcxIxglDImKlsPE/L
	A3KPyQrJRvAfSKkhxOW/CwsWqoSdxZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-Hp1EnfCVMieKYgQTZUtNsA-1; Fri,
 31 Oct 2025 10:45:33 -0400
X-MC-Unique: Hp1EnfCVMieKYgQTZUtNsA-1
X-Mimecast-MFC-AGG-ID: Hp1EnfCVMieKYgQTZUtNsA_1761921931
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ABCC1954B00;
	Fri, 31 Oct 2025 14:45:31 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.76.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C01A41954128;
	Fri, 31 Oct 2025 14:45:28 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:45:25 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: audit@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>
Subject: Re: [viro@zeniv.linux.org.uk: [RFC] audit reporting (or not
 reporting) pathnames on early failures in syscalls]
Message-ID: <aQTLhZGOkufsFs9W@madcap2.tricolour.ca>
References: <20251031080615.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080615.GB2441659@ZenIV>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2025-10-31 08:06, Al Viro wrote:
> OK, that's two misspellings of the list name already;-/

Adding the audit userspace list to get Steve Grubb's certification take on this.

> Al, deeply embarrassed and crawling to get some sleep...
> 
> ----- Forwarded message from Al Viro <viro@zeniv.linux.org.uk> -----
> 
> Date: Fri, 31 Oct 2025 07:58:56 +0000
> From: Al Viro <viro@zeniv.linux.org.uk>
> To: linux-audit@vger.kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
> Subject: [RFC] audit reporting (or not reporting) pathnames on early failures in syscalls
> 
> 	FWIW, I've just noticed that a patch in the series I'd been
> reordering had the following chunk:
> @@ -1421,20 +1421,16 @@ static int do_sys_openat2(int dfd, const char __user *filename,
>                           struct open_how *how)
>  {
>         struct open_flags op;
> -       struct filename *tmp;
>         int err, fd;
>  
>         err = build_open_flags(how, &op);
>         if (unlikely(err))
>                 return err;
>  
> -       tmp = getname(filename);
> -       if (IS_ERR(tmp))
> -               return PTR_ERR(tmp);
> -
>         fd = get_unused_fd_flags(how->flags);
>         if (likely(fd >= 0)) {
> -               struct file *f = do_filp_open(dfd, tmp, &op);
> +               struct filename *name __free(putname) = getname(filename);
> +               struct file *f = do_filp_open(dfd, name, &op);
>                 if (IS_ERR(f)) {
>                         put_unused_fd(fd);
>                         fd = PTR_ERR(f);
> 
> 	From the VFS or userland POV there's no problem - we would get a
> different error reported e.g. in case when *both* EMFILE and ENAMETOOLONG
> would be applicable, but that's perfectly fine.  However, from the audit
> POV it changes behaviour.
> 
> 	Consider behaviour of openat2(2).
> 1.  we do sanity checks on the last ('usize') argument.  If they
> fail, we are done.
> 2.  we copy struct open_how from userland ('how' argument).
> If copyin fails, we are done.
> 3.  we do sanity checks on how->flags, how->resolve and how->mode.
> If they fail, we are done.
> 4.  we copy the pathname to be opened from userland ('filename' argument).
> If that fails, or if the pathname is either empty or too long, we are done.
> 5.  we reserve an unused file descriptor.  If that fails, we are done.
> 6.  we allocate an empty struct file.  If that fails, we are done.
> 7.  we finally get around to the business - finding and opening the damn thing.
> Which also can fail, of course.
> 
> 	We are expected to be able to produce a record of failing
> syscall.  If we fail on step 4, well, the lack of pathname to come with
> the record is to be expected - we have failed to get it, after all.
> The same goes for failures on steps 1..3 - we hadn't gotten around to
> looking at the pathname yet, so there's no pathname to report.	What (if
> anything) makes "insane how->flags" different from "we have too many
> descriptors opened already"?  The contents of the pathname is equally
> irrelevant in both cases.  Yet in the latter case (failure at step 5)
> the pathname would get reported.  Do we need to preserve that behaviour?
> 
> 	Because the patch quoted above would change it.  It puts the failure
> to allocate a descriptor into the same situation as failures on steps 1..3.
> 
> 	As far as I can see, there are three possible approaches:
> 
> 1) if the current kernel imports the pathname before some check, that shall
> always remain that way, no matter what.  Audit might be happy, but nobody
> else would - we'll need to document that constraint and watch out for such
> regressions.  And I'm pretty sure that over the years there had been
> other such changes that went into mainline unnoticed.
> 
> 2) reordering is acceptable.  Of course, the pathname import must happen
> before we start using it, but that's the only real constraint.  That would
> mean the least headache for everyone other than audit folks.
> 
> 3) import the pathnames as early as possible.  It would mean a non-trivial
> amount of churn, but it's at least a definite policy - validity of change
> depends only on the resulting code, not the comparison with the earlier
> state, as it would in case (1).  From QoI POV it's as nice as audit folks
> could possibly ask, but it would cause quite a bit of churn to get there.
> Not impossible to do, but I would rather not go there without a need.
> Said that, struct filename handling is mostly a decent match to CLASS()
> machinery, and all required churn wouldn't be hard to fold into conversion
> to that.
> 
> 	My preference would be (2), obviously.	However, it really depends
> upon the kind of requirements audit users have.  Note that currently the
> position of pathname import in the sequence is not documented anywhere,
> so there's not much audit users can rely upon other than "the current
> behaviour is such-and-such, let's hope it doesn't change"... ;-/
> 
> 	Comments?
> 
> 
> ----- End forwarded message -----
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

