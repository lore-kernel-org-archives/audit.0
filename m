Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D429340D97
	for <audit@vger.kernel.org>; Tue,  2 Sep 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839170; cv=none; b=ijQ1QRf9iv5fLTVk7bOlcpp8Fjy3f55MgqeEanosM+tnqdL26Q+Ls6gynNe/Nc6gAHvGfUdylvYI+1s6DUw0kxmU6sIvsrNqr//a0NObBRIkVKiAv3H5QfNtmda6eDBegER1kRGeo69ZDn+nQp9LSfd46uGY2Kyo8HsjU19XF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839170; c=relaxed/simple;
	bh=fr7XTb8icgTgStQB1vrTEUr1xcJEqpWSb5+Jkocg7DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqaDGYbWsjth9Ph9Sfb9ht+kG3p/f+ClWO0WZU2YL/HUyWXMv6TYEW+U26I6sYJv9fxvLqol8OyBxkL6X4J/BkN61rKdIFWDkXwbm42ugaykxluTxmvWynV/+VvwITiam67X1JfY9xVmptVj5Ht5CkPseKhoJlFpMecCUeWp8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fx1s+z/S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fx1s+z/S"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3280264a6e8so2878410a91.3
        for <audit@vger.kernel.org>; Tue, 02 Sep 2025 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756839168; x=1757443968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUfEfExsv4Z4JExYVeI/bpLS60sngib6QHvkE0J/awg=;
        b=fx1s+z/SKoe+ljrmqDqR/AHrXf6b2xFMnbhbr6b9pRHIvtNxJlFc482OjB1mljjN++
         RDlBR5tdeJ5PewL1fphBxqXyXdtd+G66z5acFhjo4owUjOLgVs6Qh/890k18V+lCm5Ry
         QI5el9mmBp+MYmdgjnPSRZNgzoHFC3RscjAxKMF7GYjyCEkOK1JAlTTi8vRmTIZ5XCne
         dZCfA4c7eZW8Cyt1/Ve1I6V5jeWHuS5MAnE9DSs11hmCbkUk9vp+l0QW9lvN5abAuF1W
         32yW8DBEwEcp0SxVNotQAHcRG5fvSvDDgIsShFQJ/EJYe23vyL3fI96h8mlQvjq9xunm
         Shog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839168; x=1757443968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUfEfExsv4Z4JExYVeI/bpLS60sngib6QHvkE0J/awg=;
        b=VPQ9iSJtyXkqPxuUP3RDD8ek0DjQGzg0TxT2mgt8yKin9uZM0oSRc0lzIN6xDDdHst
         fRvjawybeJvduewbOiivS/QcHKqkSYFg/RuJR7MGhSXgZoT52lPUXtF1+7993co3Yw9l
         cnsZy1BU99vKbyyY2LNb/Y9O17lWJrWM6Bu5WWY3mloUxQtm9KL25N4XGlMNpvVpoNRc
         /ylrtVNcjvJiwdY+IjnxeAQLohaBGbTc2HHsPFPXZNFSntDSYp9SOZjfEMInuPyArCFd
         HUrdEjFWXCUHU7sz0DXaAt0wV4c5uoU0b6Xn33bIGjFDS0len/97AuVzhO8YTj5ZGl3M
         z5fw==
X-Gm-Message-State: AOJu0YzCz14NeLrvjBn5YibfZRPIC3QKEt72sOn9QXtbwpqmcMYz/hBf
	sIMVU2FpXH8RIpDY2DHTPpFH7VjjW6Q/ACXG1bSVKriWCukR3fxjMjqc2jfL89/feUNPDbp0TXJ
	5psEvnUg7nnjGEKCSJOhSl2gRJlEb5/xWpPKZV4D+
X-Gm-Gg: ASbGncuccpEkLG3VSvTPVV08yKepDlDQf/2xBAzsvcHOeifk+v2NV98LZS1ko1ajlsp
	0rkYUrirxMgxYAarm86UsZ8M1fRkM2rmllRRYW9Rj5riJwDERotL1y6GqXdf5XjjI053UEFhQlE
	nfNX+FnvwA04MyTQ/w8lypaYdyV+SIse/Sqp6pR4sixvxeQIk3xusliHyb7y3glkGOXln9eEfbC
	JmZAfk=
X-Google-Smtp-Source: AGHT+IGc/tElwygvDdKTlYySO7qXJLf9sHKlds8hH12yn8duF1CFLBxwB+Ce4DYuyOC7qDDzBWrnuHn3cqjkCkYBF50=
X-Received: by 2002:a17:90b:48cb:b0:323:28ac:4594 with SMTP id
 98e67ed59e1d1-32815414089mr13758791a91.5.1756839167864; Tue, 02 Sep 2025
 11:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
In-Reply-To: <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Sep 2025 14:52:35 -0400
X-Gm-Features: Ac12FXy8XdXnZE9C0slRKpG3WzWsuHhhZo5xmbrDdxHDLPKkaXJ-L6LVm3df_zY
Message-ID: <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@ais=
le.com> wrote:
> >
> > When a watch on dir=3D/ is combined with an fsnotify event for a
> > single-character name directly under / (e.g., creating /a), an
> > out-of-bounds read can occur in audit_compare_dname_path().
> >
> > The helper parent_len() returns 1 for "/". In audit_compare_dname_path(=
),
> > when parentlen equals the full path length (1), the code sets p =3D pat=
h + 1
> > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> >
> > Fix this by adding a pathlen > 0 check to the while loop condition
> > to prevent the out-of-bounds access.
> >
> > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Signed-off-by: Stanislav Fort <disclosure@aisle.com>

I also just noticed a disconnect on the email address.  I can leave
the Reported-by email as disclosure@, but do you mind if I convert
your Signed-off-by email to stanislav.fort@?

> > ---
> >  kernel/auditfilter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks Stanislav.  It looks like this problem was likely introduced in
> e92eebb0d611 ("audit: fix suffixed '/' filename matching"), I'll add a
> 'Fixes:' and a stable tag.
>
> I'm building a test kernel right now to test things, but did you
> verify that the path matching fixed in e92eebb0d611 still works
> correctly?
>
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index e3f42018ed46..f7708fe2c457 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *d=
name, const char *path, int par
> >
> >         /* handle trailing slashes */
> >         pathlen -=3D parentlen;
> > -       while (p[pathlen - 1] =3D=3D '/')
> > +       while (pathlen > 0 && p[pathlen - 1] =3D=3D '/')
> >                 pathlen--;
> >
> >         if (pathlen !=3D dlen)
> > --
> > 2.39.3 (Apple Git-146)

--=20
paul-moore.com
