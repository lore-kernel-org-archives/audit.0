Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3C2D3226
	for <audit@vger.kernel.org>; Fri, 24 Oct 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321310; cv=none; b=gTOdp+v6gUTqk/vGlmO5wuBq8alO4Sp0h/vqp76P3YRTqxEEFmkQYtwYJIQ0hhoURYdmNhOJqB16f1eJH9Yie8PQ5kCazkQyXSf6tMtODECdl06hOkq+1CQDOMGmuZbJNp4+b+KjqOv0g65Qun2C3C1JB5mETR6JFTgVfzoqyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321310; c=relaxed/simple;
	bh=XUUjiT/LL39HQxlWRGK1kB2VdbDdz5ho6javHy1jlVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvwUhTWzFf4DGTuBvGhmq09/RlwmITdkl1p5BqEzVwjo0UDQ56byGnUIszES/emtpsbynMGqxGIdeeF5Y0+vi1IlXzERxdXgIcgMGEB3pcI6wkO+oPrLXAnDUVdYfXX+4jaVO1oX3brcTTVImHfqAIJLFUYL7MOo3pVHqZFnTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW84+P4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW84+P4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761321306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJ8CBgdnp0x5YCgKtD8+31O84jKpAdCiNyX8xfEa5uQ=;
	b=NW84+P4XGmP89WhSHonWcYGjUzJoGNkxeoMyvOpp4UyxqI+sFsWBVo8eZR7ROFxYKd/h7r
	Q1l/Jekl6KJuKTdrJnFz4HoXoZKvXulszFcyyVzvYhpuPq8CHPwLfpQo5sigviPzgOswWu
	HhiuOZielUrS2FzHMOae0B5g8fqAmYA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-erQ2B9i3OJi-utgJF_98Hg-1; Fri, 24 Oct 2025 11:55:05 -0400
X-MC-Unique: erQ2B9i3OJi-utgJF_98Hg-1
X-Mimecast-MFC-AGG-ID: erQ2B9i3OJi-utgJF_98Hg_1761321304
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b48635cf06fso374591266b.1
        for <audit@vger.kernel.org>; Fri, 24 Oct 2025 08:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321304; x=1761926104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ8CBgdnp0x5YCgKtD8+31O84jKpAdCiNyX8xfEa5uQ=;
        b=QokOWDENyamFcXvs/390/AnAUXsSv+Ed02cfK53/HeZD1T2fDKuYyt1zwHcXDuhX32
         2M6nJwpZ1JiNwkHpHxaSW0vEbX4Zw7o5GNsUPFy+moqI26xld5XGLqs9GoSQ/oy20XuH
         dtlZ5NZ9yvgkJO7hhndLs3pSzEFv8bjMoZw7wdSSVJ7BRVwe623B589qyxUfk0IvjiCy
         auH5oEe4VOsnNCFoW+wJskwO+p+BrFB4G4rtq8KPp+uAyMh1wgKBQcLGqhQzcbbtWhEy
         InfQTkm4MOPthBUS0lnD5dHVF+HK8eaNf7p6xG2/AJcAJFHgsCqA77cDcv8RA6JJeYxe
         7GWA==
X-Gm-Message-State: AOJu0YzQTFdBAh6JZdgRe3f1fSdd8shHKzH1jtwWdQ5XMOuqDeWKS47n
	R58BqPK9wsOY0mSapBXGQuZ4TY8Lw9hQ1dRhTEoz8V9RzJ0zJjRgeyIxKyNvcTy12Y918k932VD
	dQxkH3RDtvyRS77hPmtJUm6nPwdEstXmph0E2M8S5lQBWBfCZrgCELLvFO6SW1vBPafp28NrMZO
	VBkeSvzAtGAmXhGyuksuRA6wLfSpFFpkkW6eQTMM97eA==
X-Gm-Gg: ASbGnct4c1yp3SALYdjz5ePFAW+k+xFt/2TAu2QUd0zsYmCKqN1PSKVB7nzazmbzi9D
	qjcskpd5nkGPB2YIxCQT8IHw1NzFqKvGMs5pO+ItEhVFVlIGYCVJcziTjyAcD5Obmg1jWvIaZIk
	p5X7r3whpA0res5z9csU5ZafT0uT7eolAZm8LdIVHEL6LJXogBU8Nc510s
X-Received: by 2002:a17:907:9448:b0:b04:626e:f43d with SMTP id a640c23a62f3a-b64751284f6mr3012891366b.47.1761321303757;
        Fri, 24 Oct 2025 08:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoFO2lt2SNKwryeKYy2tueF7Ewy+SHv0qWkyzbxhfUjzu6PXuLi7pGKg6VF6E0uZH8YqujQA1JKEKxkPE9qq4=
X-Received: by 2002:a17:907:9448:b0:b04:626e:f43d with SMTP id
 a640c23a62f3a-b64751284f6mr3012889366b.47.1761321303380; Fri, 24 Oct 2025
 08:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022123644.1560744-1-rrobaina@redhat.com> <cd4576d9d4a00366283a116ab14231f5@paul-moore.com>
In-Reply-To: <cd4576d9d4a00366283a116ab14231f5@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 24 Oct 2025 12:54:51 -0300
X-Gm-Features: AS18NWC7wcZUbzwsc4ajI_C_1nQT7HFinNeXWRIipzFTOwu9q12KDZ3DloNlX1I
Message-ID: <CAABTaaA6BvcYP7_0KrOtXW7ehNH=RrZk4QFWoPujevXOJEY=Sw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: siGeuYii_kZcR-toLzSii6RYdDM3jrYdBk04YrWHVAk_1761321304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct 22, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Whenever there's audit context, __audit_inode_child() gets called
> > numerous times, which can lead to high latency in scenarios that
> > create too many sysfs/debugfs entries at once, for instance, upon
> > device_add_disk() invocation.
> >
> >    # uname -r
> >    6.17.0-rc3+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m42.753s
> >    user 0m0.000s
> >    sys  0m42.494s
> >
> >    # perf record -a insmod loop max_loop=3D1000
> >    # perf report --stdio |grep __audit_inode_child
> >    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> >
> > __audit_inode_child() searches for both the parent and the child
> > in two different loops that iterate over the same list. This
> > process can be optimized by merging these into a single loop,
> > without changing the function behavior or affecting the code's
> > readability.
> >
> > This patch merges the two loops that walk through the list
> > context->names_list into a single loop. This optimization resulted
> > in around 54% performance enhancement for the benchmark.
> >
> >    # uname -r
> >    6.17.0-rc3+-enhanced
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m19.388s
> >    user 0m0.000s
> >    sys  0m19.149s
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 39 +++++++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d1966144bdfe..8cebc016d9eb 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2416,41 +2416,36 @@ void __audit_inode_child(struct inode *parent,
> >       if (inode)
> >               handle_one(inode);
> >
> > -     /* look for a parent entry first */
> >       list_for_each_entry(n, &context->names_list, list) {
> > -             if (!n->name ||
> > -                 (n->type !=3D AUDIT_TYPE_PARENT &&
> > -                  n->type !=3D AUDIT_TYPE_UNKNOWN))
> > +             /* can only match entries that have a name */
> > +             if (!n->name)
> >                       continue;
> >
> > -             if (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent->=
i_sb->s_dev &&
> > -                 !audit_compare_dname_path(dname,
> > -                                           n->name->name, n->name_len)=
) {
> > +             /* look for a parent entry first */
> > +             if (!found_parent &&
> > +                 (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent-=
>i_sb->s_dev &&
> > +                  !audit_compare_dname_path(dname, n->name->name, n->n=
ame_len))) {
> >                       if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
> >                               n->type =3D AUDIT_TYPE_PARENT;
>
> As mentioned in my feedback on your v1 patch, we can probably set
> n->type equal to AUDIT_TYPE_PARENT without checking n->type first
> as it we want this set to AUDIT_TYPE_PARENT regardless.
>
> Please either fix this, or explain why it needs to be the way that it
> is in your v2 patch.
>
> >                       found_parent =3D n;
> > -                     break;
> > -             }
> > -     }
> > -
> > -     cond_resched();
> > -
> > -     /* is there a matching child entry? */
> > -     list_for_each_entry(n, &context->names_list, list) {
> > -             /* can only match entries that have a name */
> > -             if (!n->name ||
> > -                 (n->type !=3D type && n->type !=3D AUDIT_TYPE_UNKNOWN=
))
> > +                     if (found_child)
> > +                             break;
> >                       continue;
> > +             }
> >
> > -             if (!strcmp(dname->name, n->name->name) ||
> > -                 !audit_compare_dname_path(dname, n->name->name,
> > +             /* is there a matching child entry? */
> > +             if (!found_child &&
> > +                 (n->type =3D=3D type || n->type =3D=3D AUDIT_TYPE_UNK=
NOWN) &&
> > +                 (!strcmp(dname->name, n->name->name) ||
> > +                  !audit_compare_dname_path(dname, n->name->name,
> >                                               found_parent ?
> >                                               found_parent->name_len :
> > -                                             AUDIT_NAME_FULL)) {
> > +                                             AUDIT_NAME_FULL))) {
> >                       if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
> >                               n->type =3D type;
> >                       found_child =3D n;
> > -                     break;
> > +                     if (found_parent)
> > +                             break;
> >               }
> >       }
> >
> > --
> > 2.51.0
>
> --
> paul-moore.com
>

Hi Paul,

Thanks for the heads-up!
Now I realize I misunderstood that piece of your review the first time
I read it. I'll fix it and post a newer version of this patch shortly.

