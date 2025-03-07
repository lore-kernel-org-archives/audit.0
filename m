Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EF24DFEF
	for <audit@vger.kernel.org>; Fri,  7 Mar 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376527; cv=none; b=ZgYUp5I/W7QNAODELbcSEW0ROumpNBgkCgqrN4ef89DqyZ0ddQOte88oneY0hoWubLNXW36r5YcYCi51vapQ3CXE5457BOv3LtyIRMkQmv5uZ51q0FaPsSgFrTln2xMZLhtCuh/LUUAcSOtxZ4LJoLfWMCb2UCPzfz+KK1FyzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376527; c=relaxed/simple;
	bh=ubctbGCYsax+MEfuAoCtbkIGyzgm9i0qIVp21VApKuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufumaxfg074CkaTRJR+cKRKBc4Ac2BJhlU1hNxVAlpVssJA/jyJKhjTlnGsg6eM7ZZquYmXgMoevSVZhSBvBZpghgv0TneBhP6Pv8oWdSk731hSZ1oFsqV3i/nLV/j8ESOFXN4k9Oij6CKDXdoDoT75FWs3lthhLkgQPbOuTlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjnx3aYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjnx3aYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741376524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+o7tZizJIjmOCb+T/PxCYGzCkL9BqpzG62i97Ud4Bs=;
	b=Fjnx3aYbqMTyuVOquUNYNOCECw9nE1RoYNJD28p3KFoJH4KvvthrrHVh6shk7fLfPNUol9
	o+9dOzDbX/Ya53Tyewau8TUUBVA/X8lkLtWbx1E2U1NdX7GdvLnkZs1Xs/jifCoqCerzgp
	U1sNEoB5g781Kyvaspq5KmqX/zbxHHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-voOF87UYNbihaI6AN4-lxg-1; Fri,
 07 Mar 2025 14:41:55 -0500
X-MC-Unique: voOF87UYNbihaI6AN4-lxg-1
X-Mimecast-MFC-AGG-ID: voOF87UYNbihaI6AN4-lxg_1741376513
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7796B1955BC9;
	Fri,  7 Mar 2025 19:41:52 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.64.245])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 787631828A80;
	Fri,  7 Mar 2025 19:41:50 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
 LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
 Eric Paris <eparis@parisplace.org>
Subject:
 Re: [PATCH v1] audit,module: restore audit logging in load failure case
Date: Fri, 07 Mar 2025 14:41:48 -0500
Message-ID: <2743964.lGaqSPkdTl@x2>
Organization: Red Hat
In-Reply-To: <Z8oWlAwgKWW+M8yL@madcap2.tricolour.ca>
References:
 <999cdd694f951acd2f4ad665fe7ab97d0834e162.1729717542.git.rgb@redhat.com>
 <b7f8e0d11b6cfc7547709c7efc472021@paul-moore.com>
 <Z8oWlAwgKWW+M8yL@madcap2.tricolour.ca>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thursday, March 6, 2025 4:41:40=E2=80=AFPM Eastern Standard Time Richard=
 Guy=20
Briggs wrote:
> On 2024-10-24 16:41, Paul Moore wrote:
> > On Oct 23, 2024 Richard Guy Briggs <rgb@redhat.com> wrote:
> > > The move of the module sanity check to earlier skipped the audit
> > > logging
> > > call in the case of failure and to a place where the previously used
> > > context is unavailable.
> > >=20
> > > Add an audit logging call for the module loading failure case and get
> > > the module name when possible.
> > >=20
> > > Link: https://issues.redhat.com/browse/RHEL-52839
> > > Fixes: 02da2cbab452 ("module: move check_modinfo() early to
> > > early_mod_check()") Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >=20
> > >  kernel/module/main.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 49b9bca9de12..1f482532ef66 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -3057,8 +3057,10 @@ static int load_module(struct load_info *info,
> > > const char __user *uargs,> >=20
> > >  	 * failures once the proper module was allocated and
> > >  	 * before that.
> > >  	 */
> > >=20
> > > -	if (!module_allocated)
> > > +	if (!module_allocated) {
> > > +		audit_log_kern_module(info->name ? info->name :=20
"(unavailable)");
> > >=20
> > >  		mod_stat_bump_becoming(info, flags);
> > >=20
> > > +	}
> >=20
> > We probably should move the existing audit_log_kern_module() to just
> > after the elf_validity_cache_copy() call as both info->name and
> > info->mod->name should be as valid as they are going to get at that
> > point.  If we do that then we only have two cases we need to worry abou=
t,
> > a failed module_sig_check() or a failed elf_validity_cache_copy(), and
> > in both cases we can use "(unavailable)" without having to check
> > info->name first.
>=20
> Fair enough.
>=20
> > However, assuming we move the audit_log_kern_module() call up a bit as
> > described above, I'm not sure there is much value in calling
> > audit_log_kern_module() with an "(unavailable)" module name in those
> > early two cases.  We know it's an attempted module load based on the
> > SYSCALL record, seeing an associated "(unavailable)" KERN_MODULE record
> > doesn't provide us with any more information than if we had simply
> > skipped the KERN_MODULE record.
>=20
> Understood.  I wonder if the absence of the record in the error case
> will leave us guessing if we lost a record from the event?  We will have
> the error code from the SYSCALL record but not much more than that, and
> some of those error codes could just as well be generated after that
> point too.  This would be a similar situation to the vanishing fields in
> an existing record, but is likely easier to mitigate than a
> non-last-field vanishing or shifting around in an existing record.
>=20
> Steve?  Atilla?  Any comments?

We should only get the events if we have syscall rules that would result in=
=20
kernel module loading/unloading events. I suppose that by the time audit=20
loads it's rules, many modules have already loaded. So, I don't think we ne=
ed=20
to worry about early cases. But when we do get a kernel module load/unload=
=20
event based on the rules, we need it's name - even in failures. We need to =
be=20
able to determine what was attempted since this could affect system=20
integrity.

=2DSteve

> > Untested, but this is what I'm talking about:
> >=20
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 0050ef288ab3..eaa10e3c7eca 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -417,7 +417,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binp=
rm
> > *bprm,>=20
> >  extern void __audit_log_capset(const struct cred *new, const struct cr=
ed
> >  *old); extern void __audit_mmap_fd(int fd, int flags);
> >  extern void __audit_openat2_how(struct open_how *how);
> >=20
> > -extern void __audit_log_kern_module(char *name);
> > +extern void __audit_log_kern_module(const char *name);
> >=20
> >  extern void __audit_fanotify(u32 response, struct
> >  fanotify_response_info_audit_rule *friar); extern void
> >  __audit_tk_injoffset(struct timespec64 offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >=20
> > @@ -519,7 +519,7 @@ static inline void audit_openat2_how(struct open_how
> > *how)>=20
> >                 __audit_openat2_how(how);
> > =20
> >  }
> >=20
> > -static inline void audit_log_kern_module(char *name)
> > +static inline void audit_log_kern_module(const char *name)
> >=20
> >  {
> > =20
> >         if (!audit_dummy_context())
> >        =20
> >                 __audit_log_kern_module(name);
> >=20
> > @@ -677,7 +677,7 @@ static inline void audit_mmap_fd(int fd, int flags)
> >=20
> >  static inline void audit_openat2_how(struct open_how *how)
> >  { }
> >=20
> > -static inline void audit_log_kern_module(char *name)
> > +static inline void audit_log_kern_module(const char *name)
> >=20
> >  {
> >  }
> >=20
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index a60d2840559e..5156ecd35457 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -199,7 +199,7 @@ struct audit_context {
> >=20
> >                         int                     argc;
> >                =20
> >                 } execve;
> >                 struct {
> >=20
> > -                       char                    *name;
> > +                       const char              *name;
> >=20
> >                 } module;
> >                 struct {
> >                =20
> >                         struct audit_ntp_data   ntp_data;
> >=20
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 0627e74585ce..f79eb3a5a789 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2870,7 +2870,7 @@ void __audit_openat2_how(struct open_how *how)
> >=20
> >         context->type =3D AUDIT_OPENAT2;
> > =20
> >  }
> >=20
> > -void __audit_log_kern_module(char *name)
> > +void __audit_log_kern_module(const char *name)
> >=20
> >  {
> > =20
> >         struct audit_context *context =3D audit_context();
> >=20
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 49b9bca9de12..3acb65073c53 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2884,6 +2884,8 @@ static int load_module(struct load_info *info,
> > const char __user *uargs,>=20
> >         if (err)
> >        =20
> >                 goto free_copy;
> >=20
> > +       audit_log_kern_module(info->name);
> > +
> >=20
> >         err =3D early_mod_check(info, flags);
> >         if (err)
> >        =20
> >                 goto free_copy;
> >=20
> > @@ -2897,8 +2899,6 @@ static int load_module(struct load_info *info,
> > const char __user *uargs,>=20
> >         module_allocated =3D true;
> >=20
> > -       audit_log_kern_module(mod->name);
> > -
> >=20
> >         /* Reserve our place in the list. */
> >         err =3D add_unformed_module(mod);
> >         if (err)
> >=20
> > --
> > paul-moore.com
>=20
> - RGB
>=20
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> Upstream IRC: SunRaycer
> Voice: +1.613.860 2354 SMS: +1.613.518.6570




