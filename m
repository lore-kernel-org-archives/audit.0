Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD01269812
	for <audit@vger.kernel.org>; Thu, 13 Mar 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879159; cv=none; b=dtBSSKK4XzpH+C1Kvlg+d9PPtmfxh4TD1rUd+jfa/h7aO9bAhs57lqJU5Po7/lN3bsabOxh6C/AWfgFfI+2+I1ivITXxMr4L7sgbpqfTmKR9YWsETmDzC3nMO5hcEn2MJgS/81DOwsl0/5GmQfD4GcoTriJQsZ5iolBqk95oZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879159; c=relaxed/simple;
	bh=Dahx4YCeDFazmQDtfk0gy0C6DwC6v3J6Nwvt1/nlFxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBdxtnHKgXcm4kdrgkVYqLq0NxyiS8gDsW/rS21HHETYtDiM7ygo+Y65+cdGL6cOcUudB2YzmsaefCQvpVun7w3NUgEwBnR2/lJir7zt8ORPtR5IzoWEZODQSxLn5PgmMPmg+VGo3JTxT+y/x/PPPNldmGPnRwUTcLsBKi04ZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5Yzwm/p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Yzwm/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741879154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9zaHgixonSILPYIqqBFAZyXZsf0jbzyGyxAoGfZOaA=;
	b=L5Yzwm/pJ7/bMg0dpU007Wuwgc3+b9WN5ersKY0eWqnNuZSM5bkspxA6Xt+COzf8GeNNKj
	1WILfi8kF1QvhJbJWV/V+Vy/EDM1eUzyhRJEuu5gpPwIqa7DE3fh5NQl/BuC5DjM0jQ2+I
	Fo9RYoP0Oymevu420KO3VlHWVMK/mOo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-Gji8Z6jlOeSsyoEMH6KeKw-1; Thu,
 13 Mar 2025 11:19:10 -0400
X-MC-Unique: Gji8Z6jlOeSsyoEMH6KeKw-1
X-Mimecast-MFC-AGG-ID: Gji8Z6jlOeSsyoEMH6KeKw_1741879148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 646961800258;
	Thu, 13 Mar 2025 15:19:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.76.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B5A300376F;
	Thu, 13 Mar 2025 15:19:03 +0000 (UTC)
Date: Thu, 13 Mar 2025 11:18:59 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v1] audit,module: restore audit logging in load failure
 case
Message-ID: <Z9L3YwDxHcRI5EWp@madcap2.tricolour.ca>
References: <999cdd694f951acd2f4ad665fe7ab97d0834e162.1729717542.git.rgb@redhat.com>
 <b7f8e0d11b6cfc7547709c7efc472021@paul-moore.com>
 <Z8oWlAwgKWW+M8yL@madcap2.tricolour.ca>
 <2743964.lGaqSPkdTl@x2>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2743964.lGaqSPkdTl@x2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 2025-03-07 14:41, Steve Grubb wrote:
> On Thursday, March 6, 2025 4:41:40 PM Eastern Standard Time Richard Guy 
> Briggs wrote:
> > On 2024-10-24 16:41, Paul Moore wrote:
> > > On Oct 23, 2024 Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > The move of the module sanity check to earlier skipped the audit
> > > > logging
> > > > call in the case of failure and to a place where the previously used
> > > > context is unavailable.
> > > > 
> > > > Add an audit logging call for the module loading failure case and get
> > > > the module name when possible.
> > > > 
> > > > Link: https://issues.redhat.com/browse/RHEL-52839
> > > > Fixes: 02da2cbab452 ("module: move check_modinfo() early to
> > > > early_mod_check()") Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > > 
> > > >  kernel/module/main.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > > index 49b9bca9de12..1f482532ef66 100644
> > > > --- a/kernel/module/main.c
> > > > +++ b/kernel/module/main.c
> > > > @@ -3057,8 +3057,10 @@ static int load_module(struct load_info *info,
> > > > const char __user *uargs,> > 
> > > >  	 * failures once the proper module was allocated and
> > > >  	 * before that.
> > > >  	 */
> > > > 
> > > > -	if (!module_allocated)
> > > > +	if (!module_allocated) {
> > > > +		audit_log_kern_module(info->name ? info->name : 
> "(unavailable)");
> > > > 
> > > >  		mod_stat_bump_becoming(info, flags);
> > > > 
> > > > +	}
> > > 
> > > We probably should move the existing audit_log_kern_module() to just
> > > after the elf_validity_cache_copy() call as both info->name and
> > > info->mod->name should be as valid as they are going to get at that
> > > point.  If we do that then we only have two cases we need to worry about,
> > > a failed module_sig_check() or a failed elf_validity_cache_copy(), and
> > > in both cases we can use "(unavailable)" without having to check
> > > info->name first.
> > 
> > Fair enough.
> > 
> > > However, assuming we move the audit_log_kern_module() call up a bit as
> > > described above, I'm not sure there is much value in calling
> > > audit_log_kern_module() with an "(unavailable)" module name in those
> > > early two cases.  We know it's an attempted module load based on the
> > > SYSCALL record, seeing an associated "(unavailable)" KERN_MODULE record
> > > doesn't provide us with any more information than if we had simply
> > > skipped the KERN_MODULE record.
> > 
> > Understood.  I wonder if the absence of the record in the error case
> > will leave us guessing if we lost a record from the event?  We will have
> > the error code from the SYSCALL record but not much more than that, and
> > some of those error codes could just as well be generated after that
> > point too.  This would be a similar situation to the vanishing fields in
> > an existing record, but is likely easier to mitigate than a
> > non-last-field vanishing or shifting around in an existing record.
> > 
> > Steve?  Atilla?  Any comments?
> 
> We should only get the events if we have syscall rules that would result in 
> kernel module loading/unloading events. I suppose that by the time audit 
> loads it's rules, many modules have already loaded. So, I don't think we need 
> to worry about early cases. But when we do get a kernel module load/unload 
> event based on the rules, we need it's name - even in failures. We need to be 
> able to determine what was attempted since this could affect system 
> integrity.

Ok, yes, agreed.  But that information isn't available yet for a number
of error cases.  It hasn't even been looked for yet after
module_sig_check() and can't be reliably found until halfway through
elf_validity_cache_copy().

So, we should provide the record and make a best effort to fill in that
information if we can.  We could try more aggressively to extract it
from the info blob, but I don't know if that is worth the effort because
a number of the steps leading up to it are necessary to check the
validity and set up structures to extract it.

> -Steve
> 
> > > Untested, but this is what I'm talking about:
> > > 
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index 0050ef288ab3..eaa10e3c7eca 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -417,7 +417,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm
> > > *bprm,> 
> > >  extern void __audit_log_capset(const struct cred *new, const struct cred
> > >  *old); extern void __audit_mmap_fd(int fd, int flags);
> > >  extern void __audit_openat2_how(struct open_how *how);
> > > 
> > > -extern void __audit_log_kern_module(char *name);
> > > +extern void __audit_log_kern_module(const char *name);
> > > 
> > >  extern void __audit_fanotify(u32 response, struct
> > >  fanotify_response_info_audit_rule *friar); extern void
> > >  __audit_tk_injoffset(struct timespec64 offset);
> > >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> > > 
> > > @@ -519,7 +519,7 @@ static inline void audit_openat2_how(struct open_how
> > > *how)> 
> > >                 __audit_openat2_how(how);
> > >  
> > >  }
> > > 
> > > -static inline void audit_log_kern_module(char *name)
> > > +static inline void audit_log_kern_module(const char *name)
> > > 
> > >  {
> > >  
> > >         if (!audit_dummy_context())
> > >         
> > >                 __audit_log_kern_module(name);
> > > 
> > > @@ -677,7 +677,7 @@ static inline void audit_mmap_fd(int fd, int flags)
> > > 
> > >  static inline void audit_openat2_how(struct open_how *how)
> > >  { }
> > > 
> > > -static inline void audit_log_kern_module(char *name)
> > > +static inline void audit_log_kern_module(const char *name)
> > > 
> > >  {
> > >  }
> > > 
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index a60d2840559e..5156ecd35457 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -199,7 +199,7 @@ struct audit_context {
> > > 
> > >                         int                     argc;
> > >                 
> > >                 } execve;
> > >                 struct {
> > > 
> > > -                       char                    *name;
> > > +                       const char              *name;
> > > 
> > >                 } module;
> > >                 struct {
> > >                 
> > >                         struct audit_ntp_data   ntp_data;
> > > 
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 0627e74585ce..f79eb3a5a789 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2870,7 +2870,7 @@ void __audit_openat2_how(struct open_how *how)
> > > 
> > >         context->type = AUDIT_OPENAT2;
> > >  
> > >  }
> > > 
> > > -void __audit_log_kern_module(char *name)
> > > +void __audit_log_kern_module(const char *name)
> > > 
> > >  {
> > >  
> > >         struct audit_context *context = audit_context();
> > > 
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 49b9bca9de12..3acb65073c53 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2884,6 +2884,8 @@ static int load_module(struct load_info *info,
> > > const char __user *uargs,> 
> > >         if (err)
> > >         
> > >                 goto free_copy;
> > > 
> > > +       audit_log_kern_module(info->name);
> > > +
> > > 
> > >         err = early_mod_check(info, flags);
> > >         if (err)
> > >         
> > >                 goto free_copy;
> > > 
> > > @@ -2897,8 +2899,6 @@ static int load_module(struct load_info *info,
> > > const char __user *uargs,> 
> > >         module_allocated = true;
> > > 
> > > -       audit_log_kern_module(mod->name);
> > > -
> > > 
> > >         /* Reserve our place in the list. */
> > >         err = add_unformed_module(mod);
> > >         if (err)
> > > 
> > > --
> > > paul-moore.com
> > 
> > - RGB

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

