Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC32DA91C
	for <audit@vger.kernel.org>; Tue, 22 Apr 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354692; cv=none; b=Udx+nUnbVc7WlzdCF8oPqmhStokOSAe3fzF8WRgYXRcdKjIQBHAxTfNVKZgEzbYEKehUTW9ATmAK1PGS7uLr7L0vPfh4Tkl5YCa73QFgnUcvyHaYGdHI+Db965lhZPUD+ye9Yn3YuQVpSO/tUuAQdNQS4m6ct/+IQddNIEBgQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354692; c=relaxed/simple;
	bh=7VhY4PjIf81EWoXWHrFKIc936ZjMX/5D5dOVZdis28A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jS2It0T29I4R0FDVpG7vZSJ3Yzbrto2I/5lfFOcFksqtE04/t2Gyh1wnG+uIADqMw0hcZbWO4HzRInMR2M99eVAjdId7hVWLXeglROwcsBVfTgOY7vqWbjjJPEp4O+ALkG6pwrqlAcpbAobXgLa2Zo4Zur55IDPD/ZxKE/ilL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJDZ0/9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJDZ0/9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745354689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+hOL6iZRO1BIU3i23We9soIGz6Aij367ODuBHv8NHI=;
	b=AJDZ0/9UAgVfgVLO5zDtDsaWW7mapPyQ0Rp9VUA4FGNCM9xKpLGcmbCM9nnlJQ0Ey2t3P5
	DOaCJKdoXCeaa9J1ZyCw+S1xvn2yOpxCVfMSgga+kxiSRPHoo0UyzNYeO8XZ7HFtNiih6U
	3HkUzAFIxwLq5ZFauWDgf//fDkjIAws=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-JcyJRqaQPXikpD9ghI48_Q-1; Tue,
 22 Apr 2025 16:44:47 -0400
X-MC-Unique: JcyJRqaQPXikpD9ghI48_Q-1
X-Mimecast-MFC-AGG-ID: JcyJRqaQPXikpD9ghI48_Q_1745354686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D46541955DCC;
	Tue, 22 Apr 2025 20:44:45 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.65.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D409D18001DA;
	Tue, 22 Apr 2025 20:44:43 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>, linux-audit@lists.linux-audit.osci.io
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
 LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
 Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>
Subject:
 Re: [PATCH v2] audit,module: restore audit logging in load failure case
Date: Tue, 22 Apr 2025 16:44:41 -0400
Message-ID: <2755922.lGaqSPkdTl@x2>
Organization: Red Hat
In-Reply-To:
 <CAHC9VhRhr0GMQB59DZ4-xJ788yEgAsUMBLNdYFL2UxioBUPhGQ@mail.gmail.com>
References:
 <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
 <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
 <CAHC9VhRhr0GMQB59DZ4-xJ788yEgAsUMBLNdYFL2UxioBUPhGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tuesday, April 22, 2025 12:30:01=E2=80=AFPM Eastern Daylight Time Paul M=
oore=20
wrote:
> On Tue, Apr 22, 2025 at 11:37=E2=80=AFAM Richard Guy Briggs <rgb@redhat.c=
om>
> wrote:
> > On 2025-04-11 14:23, Paul Moore wrote:
> >=20
> > > On Mar 17, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
>=20
>=20
> ...
>=20
>=20
> > > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > > index 1fb9ad289a6f..efa62ace1b23 100644
> > > > --- a/kernel/module/main.c
> > > > +++ b/kernel/module/main.c
> > > > @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info,
> > > > const char __user *uargs,
> > >
> > > >
> > > >
> > > >     module_allocated =3D true;
> > > >
> > > >
> > > >
> > > > -   audit_log_kern_module(mod->name);
> > > > +   audit_log_kern_module(info->name);
> > > >
> > > >
> > > >
> > > >     /* Reserve our place in the list. */
> > > >     err =3D add_unformed_module(mod);
> > > >=20
> > > > @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *inf=
o,
> > > > const char __user *uargs,
> > >=20
> > > >      * failures once the proper module was allocated and
> > > >      * before that.
> > > >      */
> > > >=20
> > > > -   if (!module_allocated)
> > > > +   if (!module_allocated) {
> > > > +           audit_log_kern_module(info->name ? info->name :
> > > > "(unavailable)");
> >
> > > In keeping with audit tradition, wouldn't we want this to be "?"
> > > instead of "(unavailable)"?
>=20
> Any comment on the above?  This is more important than the non-public link
> ...

It would save some disk space and stay similar to all other events. I also=
=20
think it should be "?".

=2DSteve

> > > >             mod_stat_bump_becoming(info, flags);
> > > >=20
> > > > +   }
> > > >=20
> > > >     free_copy(info, flags);
> > > >     return err;
> > > > =20
> > > >  }
> > > >=20
> > > > --
> > > > 2.43.5
>=20
>=20
> --=20
> paul-moore.com
> _______________________________________________
> Linux-audit mailing list -- linux-audit@lists.linux-audit.osci.io
> To unsubscribe send an email to linux-audit-leave@lists.linux-audit.osci.=
io




