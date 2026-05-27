Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769F3451B3
	for <audit@vger.kernel.org>; Wed, 27 May 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885764; cv=none; b=aUgw3jGjMnic89YZKg78fN92+qOfSd3O1ZsNSCHzxjAArPi5bCpe4Nap4u0PnlFQJWoYSUzt9BCfvBr0n3RwjuPYpnW/4tfukyO7sLR04ijtQyUANuTeQ2uGcjOwyxI/y56SDhj9+NBeWmFhKLwuCICaEnVCXzIrruu9jfHhFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885764; c=relaxed/simple;
	bh=6i5/eMcNcL9gEeE7aeV1QlKLdcc7J32e7Ao3Jjgx2Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2aoxhgZqE4h6+y9452Oklas5Rdojt2AJxOiwiWee+wu/BOZo0BSVNDJVmaakAyU75NwKUmE3JlG2S3ekzqfXyWINiB7Z9nQxCBvEwE0U0twArhWUkhZ48rBxrfQssL3w38xu9ns0zaSLQQK0egJis++FFJufHUNQ41/gWT1PdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8YqiyMN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8YqiyMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779885761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu3RGabKoYth5q6gviDBhafFcfTyuUElQUcHUPePfBw=;
	b=H8YqiyMNSevPlox9CKD4Ol+NkUHTViJxLdvblSPNQApIMa0fMVvPlJQ95OfWQKrv56U50J
	2UIDxjwnRr/qkViGX9SBX4taixdOIH3jPdBWkV/tmidAsRgD1lvXHU87RGUehSI4eI6bvW
	DL5CZw4SAjEL5ZUeNvWODtNNCtBzQ0A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-M1AxsjI_PkiR_9KPQokRYQ-1; Wed, 27 May 2026 08:42:40 -0400
X-MC-Unique: M1AxsjI_PkiR_9KPQokRYQ-1
X-Mimecast-MFC-AGG-ID: M1AxsjI_PkiR_9KPQokRYQ_1779885759
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bd86cf9d900so810477266b.2
        for <audit@vger.kernel.org>; Wed, 27 May 2026 05:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885759; x=1780490559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nu3RGabKoYth5q6gviDBhafFcfTyuUElQUcHUPePfBw=;
        b=U+0mSWmMKchY+7NinUVugFwx4bOPGDO6EHPycWUk5k5ws5asmQgAv40wTw0jUHDsWC
         lNKkKj8PfsLdc2QAFbdORf5+SPbm11JYWWf6kBKSmzXc+JYBUexiwJMxkx2dKPHYZG32
         tc3PVxcW49qeOyG4yeCp0czzk1U+9nDE0LTtNV41LQ6RnyNY7/kXbD6iByk71XEJ6iB9
         n0n9285Rtd6LljUNC/QbbteCeWLQ3mnvFn82nbCulerlogG1sm9Ll29WgFxtJseWE+Az
         mtNxdxFdjNdy/PPxG8I0HgCpo6za0/flThN9vDfALg95wo41wx4qeLFX40U8ACjq8kxq
         qXyg==
X-Gm-Message-State: AOJu0YyU1sagaU5Mtra7EBTqUPhcE+dZSVUYf/qQttr4QXKHYURUa20k
	B6joE8XPWXDzWsmtzqHOT2VYDOEH+U5EZhnlInUHs9KzMqihjIazncniS1TYY1t1bxuHn4Ockym
	kgG38tcGuQ3w6TSfDF9zCVtI0nSuNNKaujxsSMovTQQmLYKgNTIDbFNmJrf0VRy8UiUE4msbV9M
	JrnDTY3eNjm9H8pw5m9ZjrXwhzNANrzAs=
X-Gm-Gg: Acq92OEvnXdSADv9nig2DwdaCAsWRg9rTniLLbNg4TetTveiZHfcaJJzNXrTsUrt9nH
	3vsHF9W+eHKCji6iWAEP9XQNMqsqMvDumlwyqMj72GdeudyF8Bqvc+5xCsBzcxGaElHol7fQxQX
	xeULW0lX2Enb+suOSZk2v2PMYNBNiEqYlNWloIQYlDz6BqjkQ/YZ/NcdJr40R4jL09Q5DZGLnuJ
	pbIAFQxW2Q4qJ5sZ9I5vFr8PhPeqoImda5C+vmfqST4KOFct7Xd2T4sx6d4v9yywsUzNt7wJnzK
	B2mZa3JYyN6FjvNaHpYSrM+n
X-Received: by 2002:a17:907:271b:b0:bd8:26e5:d79b with SMTP id a640c23a62f3a-bdd2aee6e70mr1042125366b.43.1779885758715;
        Wed, 27 May 2026 05:42:38 -0700 (PDT)
X-Received: by 2002:a17:907:271b:b0:bd8:26e5:d79b with SMTP id
 a640c23a62f3a-bdd2aee6e70mr1042123766b.43.1779885758204; Wed, 27 May 2026
 05:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f0a259c6e6b5a1da6578fb83b531276425aa030.1778704210.git.rrobaina@redhat.com>
 <18f1ccfd1e80b91948e3445775be31a6@paul-moore.com>
In-Reply-To: <18f1ccfd1e80b91948e3445775be31a6@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 09:42:27 -0300
X-Gm-Features: AVHnY4JwFcY4WP3nrx5GqBURyndPvBmwTdy7-o-ihQvsd474RE0r4-R-2xUa7Kg
Message-ID: <CAABTaaCRFKvBONJth4eiwhtuV02NZO-+p4k-bgHrvL8pAvwSQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] audit: fix removal of dangling executable rules
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9v5TEA91_lOFk8oXS2Xx30WEgNgZIOEfT095qUgeCYE_1779885759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > When an audited executable is deleted from the disk, its dentry
> > becomes negative. Any later attempt to delete the associated audit
> > rule will lead to audit_alloc_mark() encountering this negative
> > dentry and immediately aborting, returning -ENOENT.
> >
> > This early abort prevents the subsystem from allocating the temporary
> > fsnotify mark needed to construct the search key, meaning the kernel
> > cannot find the existing rule in its own lists to delete it. This
> > leaves a dangling rule in memory, resulting in the following error
> > while attempting to delete the rule:
> >
> >  # ./audit-dupe-exe-deadlock.sh
> >  No rules
> >  Error deleting rule (No such file or directory)
> >  There was an error while processing parameters
> >
> >  # auditctl -l
> >  -a always,exit -S all -F exe=3D/tmp/file -F path=3D/tmp/file -F key=3D=
dr
> >
> >  # auditctl -D
> >  Error deleting rule (No such file or directory)
> >  There was an error while processing parameters
> >
> > This patch fixes this issue by removing the d_really_is_negative()
> > check. By doing so, a dummy mark can be successfully generated for
> > the deleted path, which allows the audit subsystem to properly match
> > and flush the dangling rule.
> >
> > Fixes: 76a53de6f7ff ("VFS/audit: introduce kern_path_parent() for audit=
")
> > Acked-by: Waiman Long <longman@redhat.com>
> > Acked-by: Richard Guy Briggs <rgb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> > Changes in v2:
> > - New patch order: now patch 1/2 (was 2/2 in v1) per maintainer feedbac=
k
> >
> >  kernel/audit_fsnotify.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> Annotated for stable, but merged into audit/dev as I want to give this a
> few extra weeks of soak time in linux-next.
>
> --
> paul-moore.com
>

Thanks, Paul!

