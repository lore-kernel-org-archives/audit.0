Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9313A258
	for <audit@vger.kernel.org>; Wed,  3 Sep 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912619; cv=none; b=I/FkztITHDJz43uI/uR6Mc2vOmF65R2q6qm/aN5qX7vmZ0omy7p2JCFgfMHaVbPraFEtX7dwkyJpQHeHI6uro9k/M+hkBZqUAmJlEIaTJMz9lYNoMUusGrSL7FpiuFCqUu0Wx1DkniK/IIgcBwrijXRPjKrLmBeQeJBzivlDdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912619; c=relaxed/simple;
	bh=byK7zrr1bzY5AYWAm/P3qCdsXI6BM+A7ye4HlXMiUD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrQBz4G5cvM6o9RQmmTXQ17Ns3itki8G0+QMibnTH5j6cj4T/Ei1uXmv+oAPuIbcrWiHJxy9y3Nf2acac4CdgMjUatP8uissIEW7hpmgCRGS/oDnPasOwscPaf5wZr5u8vFJwWfZ67KFxa0mMBl3bf8P3KQqfCQSYyZgMA2lg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=COfDzCPv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="COfDzCPv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso585915a91.0
        for <audit@vger.kernel.org>; Wed, 03 Sep 2025 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756912617; x=1757517417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9xoPboV/qxX+mio2heAhqIyl2Xj0Gq/B/HBIeZiQLI=;
        b=COfDzCPvFbJba28oGi8G6VPPVEK9HWgP22clzPa/paUnyyrCfjA2hlIFpEGXpo//7v
         NH7965VpPcKiHcI/W2wVg+teLWWC4Agj1QT3FNT/GnDlOvbUPoZAsnLlO/4AXWhGAQYP
         owGzZfg92iqbgFvb5TIwfwXPi4hxQwjeB33s97qZl/11hfDjnndvQJ5rPS70j36pMTTN
         f5HAJDugR/DYrtSVIFGY4XR19u99RhcQsaYDuWUf1rBDO1jIAk4yYGsWRw9dy3z3EaFq
         iZj8BB5jBUMPekkgQfZ8kZk1d/DU52/fdmfVXNY2o2AFl+sUmHxYtYMYfLeHz02VgR4Z
         6Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912617; x=1757517417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9xoPboV/qxX+mio2heAhqIyl2Xj0Gq/B/HBIeZiQLI=;
        b=cmXnjfivqZGywoohaD7sWNrvrDVsSozsvJfqkmzzo3sIBKci8GaiekeOLrRA3ZoUtV
         Y5cqeQyi7nPis9lCB6Ak6xKJJkgfW1k+Ra56GFZvsCRDAVDNcTzKr5EKsYET4X7S8jKd
         o+6wagXgAD+ktSno3OJ1lck25kNdn6iQHn5/bcjxZjQf5KIiaiHGmP8Domg0JBKG0SLk
         6LIJomoB4XQ+pvBmdn2d64YAEAOveG8I0jkD8qBdJ6TFCh5cFfs7UOICOa/6EqzfEFpZ
         qWItYVD0rCIiMUT6Ql0hB3qrb2sWrRZk5rR2hOBHjDq/6sDX2OqIretBM8IkFJNfDSVd
         xPhg==
X-Gm-Message-State: AOJu0YxN6RE60zgY+rxTm3nbRQ55LewO/OvpiMBvWyX+A1a7KrvKOvdW
	kUvwhtSc19CfGSufPRKZNl0Fb+f/uMQ1qH7HJN8g7i5SP7dlFvjFoGgSpf7UtuJHPKAdK3scjZC
	cSrQslNwA8BMTo/8V5W5lN46rwmKZYY6y73oELMHR
X-Gm-Gg: ASbGncumnMuJQdF/ptHQ468mgfV9hiH9BY/qJY5iiIJb2F0mP2DI4EACoiRf5Qy8i5Z
	bPT69c3+HAG6s4YNT/SNrD5RtCu8bZ+p5s6i3dmm+iAj8hqf8z2Sl9s0qsp0mvznYmxINmvElqu
	2ooJ+5MUSRBHhQFhiyEQGkzn0GGqvVLBiijMN2jmQ1r46vY6zpb1VcxQ8Mv5FDQ9rO4VqHEANn1
	NiYyvw=
X-Google-Smtp-Source: AGHT+IEssE/AwRco7TF6rJSchc13XdpTJCYeO75MU4xNduI36Ol1h4daL6qVVMfNUu0Gyun/oQgqHdsHmb0F25e3H80=
X-Received: by 2002:a17:90b:2cc6:b0:327:7784:5390 with SMTP id
 98e67ed59e1d1-328154529a5mr20653103a91.16.1756912616791; Wed, 03 Sep 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
 <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
In-Reply-To: <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 11:16:44 -0400
X-Gm-Features: Ac12FXxk5b0xYb_QejwdO54jHWfoE6P5UxMpliGAjk9JRse0Tc_FuiYv2QlNnkc
Message-ID: <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>, Stanislav Fort <disclosure@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@a=
isle.com> wrote:
> > >
> > > When a watch on dir=3D/ is combined with an fsnotify event for a
> > > single-character name directly under / (e.g., creating /a), an
> > > out-of-bounds read can occur in audit_compare_dname_path().
> > >
> > > The helper parent_len() returns 1 for "/". In audit_compare_dname_pat=
h(),
> > > when parentlen equals the full path length (1), the code sets p =3D p=
ath + 1
> > > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> > >
> > > Fix this by adding a pathlen > 0 check to the while loop condition
> > > to prevent the out-of-bounds access.
> > >
> > > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
>
> I also just noticed a disconnect on the email address.  I can leave
> the Reported-by email as disclosure@, but do you mind if I convert
> your Signed-off-by email to stanislav.fort@?

Stanislav, are you okay with changing your sign-off email to
stanislav.fort@aisle.com?

--
paul-moore.com
