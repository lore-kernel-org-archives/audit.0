Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55A36495D
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909205; cv=pass; b=qfyZwtIYLV6OoNedA28cGkRGwl86WeliXI9LiSlSvI1vzOMjfxRB2xp5Y1iuXTXJ9CUe/GJApKGHOM438gwX8yHf4AnCwJZXUj5Cc8nupj+sQnZhlk0sh0SiL/IQrhOFKElfbzV/0NzaYwVOVzfM4nvV9zmCozbePZX44CCAA8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909205; c=relaxed/simple;
	bh=arW85NP4G3Vx1E1uaf3yqqPfSSzR3Kno27p4gRd3hlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBiWc8vCM6Zk6BAxP9hRH9p4RfrbB+MqEniauMvuPZFWETe5oywbYh0EtBAhNDIGNg8cb9PPpccrbQnXa/xZHOpiZTrRxsjOq+FYQExFf+KdCwOUamFxIXZipgsEGcKPX5PZsq7tV03nZfGbCuSa+zvIxLZVEzzrXmiBWHI837k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fXNGzB3T; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fXNGzB3T"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2babfd18435so54478245ad.1
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909202; cv=none;
        d=google.com; s=arc-20240605;
        b=GOtOr6djOJUom/b5ToICErY7gwKWCIZVnAaL7+ux/fhciPGyXA86AYoj+bcY5RarCQ
         0+qj9+iGaYcltx3DMYVMwpQV9dqyk140n9W7kZndJ8EZbio+yGo+PuC5H0V0n/AOh8jw
         9JkUi2fBRD2ObFH8y09azi8ADdYrretkJAwDo3QCGUm/arA3LG6oNwuGhSTLt4kGQGt9
         zgFGcqB22wU9ABSaAvESEO34VRWTZo+fkxIQ2hfvZ3jKHEphcCllssIhvZuI3L5stVJF
         N+KizHQ5gSzMcxReQzlcP/UCrc5rcgFwgkMfyQ6Ar5nY+1kEZgfKJlq3k5o6V5sm8Bdh
         p4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        fh=Jh2twnUIWRObNHyX+Ef9cs79YkqLFcM1mfpi41rbKDI=;
        b=hgxjBYhHrb9o6TsvjkcUkq/0z/5DPFPo3JCaEee9hdibHOG9eekz50vXlVsPWSvYtD
         sW0iWIm+KdLz/qmd2PsaFIWdkdIl6tgusA0/NdalzAY6OmL5XOh9X3rzLFPQYF4MwFM1
         ArUsLSqaSbrn/tGNWo3EOv9/gR/EOEQuzO8sAxnUjMueBH+cR61Wged5gzGgwA00vdvk
         k1WmwMCYilg/Bsrp0mcgbDwtGRtkH8NsmtFTcrXYO3kJY325JwpDbKTkg79rzs2aShkZ
         pLhx4HKQXQFvwOi0Mt1ocsTZ6EO0NDVddCYhPIeqHaVxX6t5wJ1Kq7TBm6NDVrDrMsux
         t6gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779909202; x=1780514002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        b=fXNGzB3TFZyq7edBEWR4FNBxN4Pv/CMd8lAJud0CCOx25HDdq3FdeYPDGAbc0ymlOO
         CavMLnlvTtnFjI6LdUUHHqETuav4Ky3H8LXzFWQ3UTbczoFKQpDI4jWiVF9270o4OxZb
         ntr8GKU2YGEuUDZ5EgQyE4SlzXv1rMCGNwLU4biQ4WIGyoop8OKq/3vLR+eZlxXmpfRM
         oVO/djy0y2D/JjWMcqfY7OMSVzj2G7BRuXbO76ucCTGqAmNfy9zGzce7qm5jTQOB+8R6
         CrjoBgQ+t93qfDuycAV56GpD1pq8GKnLgdV5wOZz87g6mn0Z6TRzkBjPgddEVaU3ut8Z
         dQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909202; x=1780514002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBJOcUZKwlryBrLyHrM1pbqAMloKqVU+cfZbZQFpt1E=;
        b=YgjeXcqAXo3934pQpIsU8BmiaMX9UJoeKDAuWDpd+lem2ED+U3HL1+Bmkpkp2/n0iB
         qa0jxISvk/OyUVzWr379THl1b2xIAZhqZu7MApgxAlL1kUjdVoz83qTNbKRo6br13uaS
         nISc18tv1xEVfuuPb3vbhXsih7gqWzd79HC3XbXUO8WfS6/UHBDR4ZhVrayaptbXd86s
         FMZnWsTmiEfYmc2AXUPlWTwGpvQfvand+R7Z6KLE/UWkspsukyMBav+6lGyXXo4OPvsu
         NKDUl039OcfP9ZLelsN+hXm4tLF7Nej/f8/u4mC/hsONLNC88yDSF6O62KVthtmoTC9y
         qU8A==
X-Forwarded-Encrypted: i=1; AFNElJ8TqQRq0tYDrMmdkaBr2jqFjwovTAeloHxMQJ84Q8okp+wkRDKmrv2Ab57mNKA8bddJ2NBiCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIMRNPs59O8VAITMvMKrcDrhnITUp5u29bqke0uD24Zeet757
	Y5iEKvLNykf/j9rz0RUWkGh3Nm0LIWAWavcqpgPTXvrwVizWAlChYuVAiCl8eykH8t3ZTeiL7RQ
	1PI7CPvuaV5SrWCpjfmBE7XJcDQAqMkAOko54iNGI
X-Gm-Gg: Acq92OFmBj6kdI7y5ugXYl/G4KYdebblWqhNW1Ck0Ll0lrabBAFxJkNgEc3EW7DlHCt
	B0Khj03VxugiaI2tlzh27rumi6qf20eyE+/E/YcBjK2nkbD+QgDPlxy1IZrGZOVeWTCllVvYJxL
	qX5JOmYnZwd3x0+kzHDzWYYJcUbKneKCFZf1TO3nnVn8TL/rbmTvdR4LyMkhqDSEeQ4uu9JpajZ
	03Unfw1JbwKdmmEgkgP8Tk59WyGE9fGzzvLhxM6KQjlhj/JSEi8VY5rTzCWScuDMDSfuCIeCXi3
	rLIXLPg9ONT4Vs3rl6qC06+5YjQO
X-Received: by 2002:a17:903:244c:b0:2bd:7ff4:ab0b with SMTP id
 d9443c01a7336-2beb06552bbmr262114595ad.39.1779909202300; Wed, 27 May 2026
 12:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org> <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
In-Reply-To: <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 May 2026 15:13:06 -0400
X-Gm-Features: AVHnY4JyDaihz5j2KMbjN9c3bYMT5kulIDfNm6wxP3VCcHavB9S0Ini-jhjCGkY
Message-ID: <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>, Ricardo Robaina <rrobaina@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Waiman Long <longman@redhat.com>, 
	Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:55=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> > audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> > audit_dupe_exe() but did not update the macro stubs used when
> > CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for this
> > configuration:
> >
> >   kernel/auditfilter.c: In function 'audit_data_to_entry':
> >   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4=
 arguments, but takes just 3
> >     592 |                         audit_mark =3D audit_alloc_mark(&entr=
y->rule, str, f_val, NULL);
> >         |                                                              =
                       ^
> >   In file included from kernel/auditfilter.c:23:
> >   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
> >     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> >         |         ^~~~~~~~~~~~~~~~
> >   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (fi=
rst use in this function)
> >     592 |                         audit_mark =3D audit_alloc_mark(&entr=
y->rule, str, f_val, NULL);
> >         |                                      ^~~~~~~~~~~~~~~~
> >   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function-l=
ike macro and might be used incorrectly
> >   kernel/auditfilter.c:592:38: note: each undeclared identifier is repo=
rted only once for each function it appears in
> >   kernel/auditfilter.c: In function 'audit_dupe_rule':
> >   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 a=
rguments, but takes just 2
> >     879 |                         err =3D audit_dupe_exe(new, old, ctx)=
;
> >         |                                                           ^
> >   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
> >     333 | #define audit_dupe_exe(n, o) (-EINVAL)
> >         |         ^~~~~~~~~~~~~~
> >   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (firs=
t use in this function)
> >     879 |                         err =3D audit_dupe_exe(new, old, ctx)=
;
> >         |                               ^~~~~~~~~~~~~~
> >   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-lik=
e macro and might be used incorrectly
> >
> > Update the macros with the correct number of parameters to resolve the
> > build error.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_du=
pe_exe()")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  kernel/audit.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index f1a77aef4533..92d5e723d570 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(void)=
;
> >  #define audit_watch_path(w) ""
> >  #define audit_watch_compare(w, i, d) 0
> >
> > -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> > +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
> >  #define audit_mark_path(m) ""
> >  #define audit_remove_mark(m) do { } while (0)
> >  #define audit_remove_mark_rule(k) do { } while (0)
> >  #define audit_mark_compare(m, i, d) 0
> >  #define audit_exe_compare(t, m) (-EINVAL)
> > -#define audit_dupe_exe(n, o) (-EINVAL)
> > +#define audit_dupe_exe(n, o, c) (-EINVAL)
> >
> >  #define audit_remove_tree_rule(rule) BUG()
> >  #define audit_add_tree_rule(rule) -EINVAL
> >
> > ---
> > base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> > change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
> >
> > Best regards,
> > --
> > Cheers,
> > Nathan
> >
>
> Hi Nathan,
>
> Good catch, I did miss that! Looks good to me, thanks for fixing it.
>
> Acked-by: Ricardo Robaina <rrobaina@redhat.com>

Thanks Nathan!

Do either of you mind if I squash these two patches together in the
audit tree?  I would preserve Nathan's sign-off line and add a comment
at the end of the commit description about the fix provided by Nathan.

--=20
paul-moore.com
