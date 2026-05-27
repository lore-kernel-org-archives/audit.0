Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC73360EE9
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909867; cv=none; b=XdSvouVj+3Kqd5C53i2zMWFi496UWfDJrI2ckjHxr1RDM6umMwvxWP1e/IcBiDO3zvQRTluyH1r1H+59i7r/8zX51XooCZJUNEjQiFyTV8tER6Yr0VsJHUCt3Skhb0vkS4/hHw2bKJyhkfKn6JPJD4oQ5cmU1I9sShDwGyKZq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909867; c=relaxed/simple;
	bh=IE27ud53BUktEXbB6OkdYpXZ30dl4eOxgAfc8ez+tVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSHHACLIbnN+ZsYrT1gaJCG1emIr0ftJ7sExNMZostO7duj/bYS2fzHbtQJsk+Hm6+KjOQZhinUDxmAqc9lxQNm/+Jbf5J2/Ao8VbQ5S45wHNzcPxvPTVg5U9leezUgnvV4tkvxtgBC94Gue9yQEiepwvOPMdf5Vl2172leTQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1xQtI+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1xQtI+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779909865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
	b=M1xQtI+U63bAyWHl/bXupGdyN5wtaMRw51CYU8mxi+4WxONEi8A2ygZQiOkOcHKA+Tp8nF
	XfFuy+tbkoRfIYKlkb4FLm9KgXmxwwPxPiJb9D2gRd7YTO+eBjBthjGk+3AuhPXc88CcmC
	zTQnM5uvbKef1tDOP5cW4vaj/9mjTeg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-62FHv2QsMnqpQGD8t8ptKQ-1; Wed, 27 May 2026 15:24:23 -0400
X-MC-Unique: 62FHv2QsMnqpQGD8t8ptKQ-1
X-Mimecast-MFC-AGG-ID: 62FHv2QsMnqpQGD8t8ptKQ_1779909862
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd52e4acb11so898087166b.3
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909862; x=1780514662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHhJRP5pVLgcPa4KuNaBBD+P9GhP2r2iVQQYvikzvXw=;
        b=X7XWqdA2XE+6jN1xLxUkg03Hpo0AYt8paKr3QeJ9WwL7xb7XUxKtu6Dm5T39p3QvQm
         t7qsh0vBjKvVLPGR+1/zrwF3H7ENiA69Z4/xIn5C2MWJobSVUDhgWFfByZBSPqr6hqyi
         +G0eJLKfbQ6eBaeBtck/2ooSpgAtYtvvBH7kOhgbZr+nSDIsvSfLO2qxButzqj6y6SVp
         JCHxFPdqG+rLR9FgYGeHW82g4NyI1ZBocthU2/QHnszZ6LYkDejHABc5A8nWQz2S1Fo6
         1rWmTDEtdgd3i+vGIaBcZTDKpZEOfQwxR+hHz5Eda/7OXDEEqRGfqORPdYI2uA1n+exN
         k0RA==
X-Forwarded-Encrypted: i=1; AFNElJ8jkYbTzisdw0xajIXNr8c5i5Tw92zLiVbL2BzswY/ee8FDwLz8p5xEHSTfplXMjf5ZKtjKzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ46VcZCd7HWYbibxEZ/+koF5JLEzvNfN3aOPpMFNDGskz+jWr
	/r87lFS+eSUFU8zE0Xo13krDd0dljTtc5Lemzzs7aFbW3IXuHd/t4D2cP9j2KxzlXvxcL79CBqo
	wNnuNM+fpKP70qo8PKnc7oBkbD8yNOb+llWOXXA0gsjHRqlWS5VN71KUvPtL2v4PkwgmH4BKUPx
	Ta+ufnwTcnTjYZe8LFk/TY6Y/lC79r0+4=
X-Gm-Gg: Acq92OGCPbjq23Gyj1/jbSM9eSH42kik5ucD9phAe2/lyH7535jjHFfB02gGaFzW5UQ
	mFE28MoZGMjlqNrDnprOGyqWsHrJ7B1Y/h86EJ4N+oNvZDpGIho8qiB2pPeLOSujdgUZQJ1VZmW
	aSKJ2idlXQb2+dhesFwftP5QULVcVUMQfHyCO78EN3y5JjvfLYw5GuUi1eslU8SBhAlYhu/TmT2
	AcDoVVVzDVzK3c+Pw28TDTkRQRdb571eZl0O66Q4XX6xFh9ht8xzQfFdaK5CUaRuYFSJeTbnuxp
	6SQwFruf4fAu6HEgF2xVMLh2FB233Vfsq98=
X-Received: by 2002:a17:907:a647:b0:bda:24df:21b with SMTP id a640c23a62f3a-bdd251373e1mr1221763466b.5.1779909862381;
        Wed, 27 May 2026 12:24:22 -0700 (PDT)
X-Received: by 2002:a17:907:a647:b0:bda:24df:21b with SMTP id
 a640c23a62f3a-bdd251373e1mr1221762166b.5.1779909861978; Wed, 27 May 2026
 12:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
 <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com> <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
In-Reply-To: <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:24:10 -0300
X-Gm-Features: AVHnY4KazjW9-E13AaekWdAuAmWJYNciyg2swPIqPIUBpVIkPmxIqJG7Vw-jMEQ
Message-ID: <CAABTaaDbcuPOxQhE1w0nbq-kK7HEYmkVzs+x1qa0iYsRtsWonQ@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Eric Paris <eparis@redhat.com>, 
	Waiman Long <longman@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rJ9_utZE7BFY2dpoHVSO2FIIShJGFlsS0ZJoaleXWhI_1779909862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 4:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 27, 2026 at 2:55=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> > > audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> > > audit_dupe_exe() but did not update the macro stubs used when
> > > CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for th=
is
> > > configuration:
> > >
> > >   kernel/auditfilter.c: In function 'audit_data_to_entry':
> > >   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed=
 4 arguments, but takes just 3
> > >     592 |                         audit_mark =3D audit_alloc_mark(&en=
try->rule, str, f_val, NULL);
> > >         |                                                            =
                         ^
> > >   In file included from kernel/auditfilter.c:23:
> > >   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
> > >     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > >         |         ^~~~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (=
first use in this function)
> > >     592 |                         audit_mark =3D audit_alloc_mark(&en=
try->rule, str, f_val, NULL);
> > >         |                                      ^~~~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function=
-like macro and might be used incorrectly
> > >   kernel/auditfilter.c:592:38: note: each undeclared identifier is re=
ported only once for each function it appears in
> > >   kernel/auditfilter.c: In function 'audit_dupe_rule':
> > >   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3=
 arguments, but takes just 2
> > >     879 |                         err =3D audit_dupe_exe(new, old, ct=
x);
> > >         |                                                           ^
> > >   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
> > >     333 | #define audit_dupe_exe(n, o) (-EINVAL)
> > >         |         ^~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (fi=
rst use in this function)
> > >     879 |                         err =3D audit_dupe_exe(new, old, ct=
x);
> > >         |                               ^~~~~~~~~~~~~~
> > >   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-l=
ike macro and might be used incorrectly
> > >
> > > Update the macros with the correct number of parameters to resolve th=
e
> > > build error.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_=
dupe_exe()")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  kernel/audit.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index f1a77aef4533..92d5e723d570 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(voi=
d);
> > >  #define audit_watch_path(w) ""
> > >  #define audit_watch_compare(w, i, d) 0
> > >
> > > -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > > +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
> > >  #define audit_mark_path(m) ""
> > >  #define audit_remove_mark(m) do { } while (0)
> > >  #define audit_remove_mark_rule(k) do { } while (0)
> > >  #define audit_mark_compare(m, i, d) 0
> > >  #define audit_exe_compare(t, m) (-EINVAL)
> > > -#define audit_dupe_exe(n, o) (-EINVAL)
> > > +#define audit_dupe_exe(n, o, c) (-EINVAL)
> > >
> > >  #define audit_remove_tree_rule(rule) BUG()
> > >  #define audit_add_tree_rule(rule) -EINVAL
> > >
> > > ---
> > > base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> > > change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
> > >
> > > Best regards,
> > > --
> > > Cheers,
> > > Nathan
> > >
> >
> > Hi Nathan,
> >
> > Good catch, I did miss that! Looks good to me, thanks for fixing it.
> >
> > Acked-by: Ricardo Robaina <rrobaina@redhat.com>
>
> Thanks Nathan!
>
> Do either of you mind if I squash these two patches together in the
> audit tree?  I would preserve Nathan's sign-off line and add a comment
> at the end of the commit description about the fix provided by Nathan.
>
> --
> paul-moore.com
>

It's fine by me.

