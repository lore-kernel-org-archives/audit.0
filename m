Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55522CBD3
	for <audit@vger.kernel.org>; Tue,  5 Aug 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423866; cv=none; b=tdJaTRnTPWXw+pB5EcWUP4CXilEN3JEaM8VO7X/8vfJXzKRqz2bpl1XDBL9FmuMrUpftytBJih2Ff/hgMwFdDvhdLjMrPaBjZ4NNyyooPxUdMS4MUmNLMhF6wd7Z2h6wkoqc2iRfa/2I0PIzR36M30DccDiloGWrlzat6PSt5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423866; c=relaxed/simple;
	bh=bC+zFzhWtUviZ0EXWS2t+T+yocqJQ0MUviaN2AZtakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUFqceIFh48RZ4XvBkQIi0a4sRaZSYoqJcB9aN7QBYsCrV/ChQZ5GySHhPikaNzihm8eWv2ny7bgFZ8GVB23j5Sq4Pdh8NPEoji5WHgPxAIuMszspqfeb2jphclNFBlWhzBVC4B45gs3uvxPSK/4YBpLYq7a7GoZMN54vhcO9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dtyU/vD6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dtyU/vD6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32128c5fc44so226936a91.1
        for <audit@vger.kernel.org>; Tue, 05 Aug 2025 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754423864; x=1755028664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=dtyU/vD6+eUz45Iyhye/qTCtmvMAoYhAC7zSJ0HlBeLv4YQ9+UaRn7FwQF5iW3pRYo
         m5v8aNBBbf6Xq64Z8L+Tj7lxKh/R2L1ZsHb7GAEouqxLuAtAzrspBYseiteczUHqlFly
         t8+Itvu7oT3b9sJDJMkMtb5Mup7NL5fcqAxMW3fFx8u56gpg7wyfCO8IWkru0rQliSM5
         5X2GFA8zN9qovslm/EAKJMezGdw8skGJte8nMzVXoIrs3VVdXNY1+9stwGHtvkHo0Mwh
         FByMGHDGTe11MpNxk83DqvoQjxFpu0Z918wXVrVdZtFBFO/XthIkANdrsaRPxQdxd32L
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423864; x=1755028664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=gvZxaD+NqHp4dsdidl+o0nP+mKZ9YRy+jlf1oM0RnSq39OUg+SIl+YFT7g/J4dhOuQ
         ZbZ1Vf0OU+WtP/eFFZRfGhV9rYqmkFQBAr9B1hkELu/E/BMVmryvsMtvcfTkL/H5dIH9
         hi2nXSmv3wir1i/gzZvO0ZopizTUapJfGL+opzF/I7VhVqJaY5rFnw8oVDaLsznTWI/u
         1FI2YbJPl7ZbQ9Z+smunhaDTRsYWjlfpzueDzSVyXvAA6yYLdO7juSh3aNOdt9S1Cpox
         TaQpXJGfDD53S/lThzWV6L1qd+6AUn1Kt5ZYNV4mUT2/PXuk2V896q4ITULCm2Xez8Sq
         bgfw==
X-Forwarded-Encrypted: i=1; AJvYcCVEeXuNbuZu0zyF+O5RjJJfYnfClF5CLrkC9e1HVk6la4ENhwZIxMUiRD2P8T2QUzirtR+1IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycyK+I0rajtG6m1MZ6lZrJgLLt74XzsAlDMvEvKrv832Vtfx0r
	in9NTdCvFoEXP/bY4ZMEdwlI2Ye8RYPw62DbzdPbhS/ZEtLkWaAC/q33hJwm6TMLstjwiMCrsla
	hb4nu/7wo1RYa3nUPLwGYMLup989Prl6rx5uzPYw1XQuZUnBZ4GQ=
X-Gm-Gg: ASbGncucEj2bX5PcB4C4XwnSxsUW8hbtPAHAnkVUBBMFD0BtzBfCE1/dvKfTGA+tU25
	Cgcau0epJ3SbHrKyUnCo0JHy+n62lr8UHYn+GqXmxpXpC1tUKUS+4Qzo4u0IgWqw2w34208LhyM
	fCKROTmNewrOIMorNSQXBKTZDu8hx2CDK0KBF9a647AW0PJ7D+7a9Ktf7w9EUJLW29n+dExAbW4
	6niIpc=
X-Google-Smtp-Source: AGHT+IHKu8z9XhICdXETPTLsS+z0RRZ62+RDpW21sm8v0pPvwaiLLnpAF+0jPbMODlNzNNx8b8mybw2geegLclSoToQ=
X-Received: by 2002:a17:90b:53c3:b0:315:9624:37db with SMTP id
 98e67ed59e1d1-32166853c96mr228245a91.3.1754423864335; Tue, 05 Aug 2025
 12:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev> <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
In-Reply-To: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Aug 2025 15:57:31 -0400
X-Gm-Features: Ac12FXxf9GFYvD_gIJTvIFf5uHVEOE2KFf8JM43Ns-i9kOgsOlIelGwqX7VSTXc
Message-ID: <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linu=
x.dev> wrote:
> >
> > strcpy() is deprecated; use strscpy() instead.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  kernel/audit_tree.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> This looks fine to me, but as we are at -rc6 I'm going to hold off on
> merging this until after the upcoming merge window.

Merged into audit/dev-staging for testing, audit/dev will happen after
merge window closes.

--=20
paul-moore.com
