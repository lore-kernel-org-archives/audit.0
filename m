Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFA45C0B
	for <audit@vger.kernel.org>; Tue,  2 Sep 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846745; cv=none; b=KXilONmiER6/u1MCLDHFJi4Q0pjTIAPLgkTdnrX8dm34JsammwYeHamCFVNimzwkzolyFDSZe4FQNfvjSgBmeJgADJr8FL8e9A+j2/tRLvjs4tDv8ZMPQWoHowu0T1lOo2v0AyMkbdeDNKoUrGSZR3r6GEYYjE52muLzhrqR+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846745; c=relaxed/simple;
	bh=J9nG8nHGWXEat57wAwMEnyjPAAOUbLQ9R91NZPCq/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAWnp6tNpzz9eZqQhjY9wbSrrBF1RcTc5d8UT4HPqwF9jPOklL9VIlg0/Yhktzwh2IlLrs5OducB3DwXCqT5PrddRmklf4EM+UgmtgvFZWLYtmMoiZGnMuc6WdnUU7rYsufMgWsqSFnFBI/22ZcuOc2ibylAlvgnMCd5FwU70BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DUPSSqGR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DUPSSqGR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7723bf02181so2570294b3a.1
        for <audit@vger.kernel.org>; Tue, 02 Sep 2025 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756846742; x=1757451542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHqjHIQglM9tK4JfRDog5euxPxNLOlXWFw8/kHoTSCE=;
        b=DUPSSqGRyhJIfDv2vCrcwU01xeUlrqmwRL8NIvc8L8gk9vF1iPVxhwf5MfhC1oYYS5
         l9PreG8F0UhefIeIlqKOt/yGEMkqTQlqGImSOq5AXzITNNyFeKGrSm3vnu/wA12zOKsQ
         j0+ql+ExGryPbx1YSfsMxI/UL8sm0WLLBHdvbWHkqsRUavkAp3iN1ixoBehksG7uGtO3
         HBtrOM+/qT7jb4CX3FHyph5dBFQs8mieRubC2qqtDjRCFdetf7HxzXB8+bjO0HULSj9u
         SGay9pdtOkB9NHpU0sd1zq+5MzAFKODgMqB7i02cHua5yyzIj1yTvy7JMzNDlHe5xUo6
         KmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846742; x=1757451542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHqjHIQglM9tK4JfRDog5euxPxNLOlXWFw8/kHoTSCE=;
        b=jsLnCa6hKqrQ4zjoPCItX3A1v3jVe2Ufei0fB+jwPdzItfZE1FV0ANJdgW081d3liY
         Q1LcpAXjw52r7idF+WTlXmw4K3DFMvaxyhKnmYS9iv6trletD224I4A3Eu2dt5CqoMBP
         gjxWhhSfEZvyd5w6y007YPP5PM+7+ukLdvzCNo/mbmWMF9spG8Hcl3h7tQ5veiIZm5xS
         WKaneLMwOC2Re8XFGvHGAZaNff06exPjiuQD9FuAsfFOE2MpuFhx3R3kO+/Zr42UqQoz
         Wn/2uvbUv0rdOiyqDwCOtIHcZgwJms752WbRP+xx8NJVIZPowsZACRYdRpOgbv4w3dMM
         SYxw==
X-Gm-Message-State: AOJu0Ywuq0Q4s1M1Y+APFLMwhpGA1jRKSFj6XgbS7fwqCvNdg/98rM8u
	RnkMo0Q1HecVJkF1hWcJPVNhVxaAPt/hhCZO3+h+8wdtkz6pfhTTl0UGoIRZswf/7g10l9bAJXl
	1bIvHNbLNEVkbg2/XGd8a1TE8dOSpizamMzFJb9cM
X-Gm-Gg: ASbGncvfmQKR9O7w5LlAsoVUSvDkImhr117Ssm7WP93yQajH5C5upmtSVghOAdXCjJ6
	FiyJ0zIiFuHJWol9pBDHYAax8y5hehFrY6wKgUFTC90jpGTCPmvzyDKowMhWTuqW6BXbtHoW1X4
	iv0PMIIpd8T+GZMtTZib1ZdFP+JdfLursQVnK0FynNWBoNwzICIi4m7yH2W/9YfrW2+OVGB4ai4
	mqrXIrSCu2buzQ/mQ==
X-Google-Smtp-Source: AGHT+IE1fkssuy6KH7HrWuu3hk96oiKXN56SvxmU18nMFRkqxb2w1JoLMH9tRZQ1AZUqR+zEZU2ZkkVx8lfhABsQOlM=
X-Received: by 2002:a05:6a21:644d:b0:245:ff00:530e with SMTP id
 adf61e73a8af0-245ff0055afmr3376344637.7.1756846742483; Tue, 02 Sep 2025
 13:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
In-Reply-To: <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Sep 2025 16:58:50 -0400
X-Gm-Features: Ac12FXz4PNQBy5gQYBTLTutR4yE4-W2AMj1vXuCtuzSByaZveumuHQYDPD1cI8E
Message-ID: <CAHC9VhQnx38fdardU+Q=JF_8mXPZJ_UcMnOTnTv0zoNUvT_y_A@mail.gmail.com>
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

The basic testing I've done today looks good.  If you can let me know
about the email in your sign-off we can get this merged and up to
Linus this week.

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
