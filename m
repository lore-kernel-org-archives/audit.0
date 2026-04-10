Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF2219E8
	for <audit@vger.kernel.org>; Fri, 10 Apr 2026 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824564; cv=pass; b=DbrvM/GzdPjfnLrTuxjB0dgB8JPseR9pR9uA4sps0uqGtIiYzhFhf+9m7H1K+7kPGIqJwskBa+TGXkHPdC7v955G0BVL0UBK8Kboz8RNDz2vCneXN7KB1sL2tBvFp+nGtkwPEHf5pVTXEEPKLy/DYQ/fUSoYAuBSvIjVheI9y20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824564; c=relaxed/simple;
	bh=Ewiqt27VmQgPelzQrIPxh4/qEBWrEg/9WiLDKDX0Ycw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZxNMP/3becU6btPP5PB5Q1qcg1xsI7+gWZ7LNJNXDeYHdO4jmg5+LvWBye0ooWkoHQGMRr2dM+5Wixo+wYseOEaAR5ms7Z75LkakTYDZNmz2zuDjBS6YRESbln61w50UBaa47XLbttK+9m/sB+7X/lrdv0y4pngBj7VWjCH+rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LurBBRc0; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LurBBRc0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a337552604so1747383e87.2
        for <audit@vger.kernel.org>; Fri, 10 Apr 2026 05:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775824561; cv=none;
        d=google.com; s=arc-20240605;
        b=ew0/51/r8vFjdghilbV7AeFM0Ai5acYm5e0BeNcuvOt2tZz9UrrNB9ju4CUwYNVyiQ
         T5WktfQQuXUJUQpJMffB2X5QD8loLIZ9cqPLWv3nroOtqhAhplvhy0rXGJbenqs5X0pg
         4MTLqlTrbgccUwMjop5v/7r/jlIiWG/X7Z2N74Mr0eyBYP18REN34kI/7AdEWn1oybGg
         fPnrX9GOO3XuTGIhXv8gG6FOMOJCTxpCqfm1tYfYBgeNpUSwTHE5v8gGIlvkDkIZS2TI
         zzzB7HMco0SXR0oglBJ5SyRZm6NkAZ11h5F2F1Anj9scyS6UUjxHgaeGMQDRi6oQUw/3
         ayCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        fh=oeNx+dBNNtvJvgyguIcK74C2fpU0GsSxOm5LWwco+wU=;
        b=gT+Uup1lgLHgJ8OQnmZcv3rULhQSxEyqalZ7L93ulULyFJStH5K+Y7P06YgxkVvW+/
         4TYwwyDH0G3rGawZ4NEEj1/6TTgIFlLxyDDEmmt4U+fIE89QkF+BJ0e7MZyRArxJ8/TB
         DcG2M+2CCtttdWPiIjHScg3ALT287ZajnzH0n1QKUoLi4GUuOeeJip1h9+pIG532UD95
         E6Qim2fKZk9QO+D7V48iY/WMP0nFawvD67QCO6pnWkvkttxq7rRHTlbE/z/D1OrOX8B8
         qZHzH0GMAmZ4b57U6unrATBsC3bNLprBCN3v56spKfpXUlpdsufaXrqbODLkhLGm0GaV
         Sz2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775824561; x=1776429361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        b=LurBBRc0xarrG0ObsT3o/3kw66FL5yaROkdSYtIYzTWpgyit4ViplXEcalmbkMrJ1o
         HtIYz9QCiWyIfL3jzTklF/5hY1VuCfZOc3kfUZzyi7Aa0Mn0bMKQWZAfX1RPtKmY5WcD
         mxxqphx3cGJHo2uPpkySeAimfrvswzcYhAOgH2C/dR3RiBkhGKaTS82rBuFl7hxbzcVg
         5vuTt/4ZmtDLmjna/d8Htav5VH+WUWb9LK5ynQoAvvTD3RbeNa8E00Q+DyHhZfkFW8lG
         v2WRzhvDjeKtskehltSpy1J9JLo7yo79f6Zf5e56zdCAi5mLFA4ryiWqYF+mawRzLB/Y
         9tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824561; x=1776429361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        b=syINUG7NMRZaZaViFJmEkO83U12uAQBlAktwKtP7MPaetv00Kj5LMyuVvM4ElrdyCN
         N7BUCuQNqyp9vcgLhS30QFTkjQ/vGj4f8JYjEqqFEh0Hdfrnl03QO2S67KMI1uKHMR2O
         RiaPjtgCjkHoMw4BfxWu72JWUOsIvfTbvq8V2JhupsTEHgvIYt+jDWOB6Zb+VhsOaXsa
         OiLxwCKk5YIwgqBBKAik/TI+pClnNCwOxATMPFW1pNmsJqVODWOgG7Qdyd57lgQGS7l4
         eCGkOSILCNz+1UXjd4uQtr8/pdf9kt3aw871T+7ws7k67fmfxHQHeMwem+Xy1ncrcgoi
         rVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0tubxYt/qpTx5q2EG5BOPIikQ9UIIvmQ57tlzjGbujNlU5vxpG6QTjFjyu8MtgcUMU4NlFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq/SaAE93i3SDHfBpyLo7lqpuX9IC8Zzx0W0kHV2VFvzRNAtO
	sNjmHjzePXjhJzAlHAWaKcvZs+w0dx9ypSqjj5oWHZdiUc6dklt4t58nRkUlZ+dmRHh0IXvhGwo
	onslLk1Ksoj/U8RtBLvRA0cULoeekRcjr7K0kHGMxaQ==
X-Gm-Gg: AeBDiesL2T4r0mZcURXHzkxEbcS90tA441hS6ZgSSIitPYFX9gGYMYgWcEoCNh6rq4f
	+5d8rE8LsNcc/3RfCgE8bzT7me4CfVNu/vrayw4afuB4q5a6Xuey0L5+mpLPeLLhTcvK9+pTfX9
	1RcnWKuolm+uKwG0RwUw5N7Q+RnXkh6EmT1a7jj/lB64cBbW4XPqn2p/agycO2jTd1apzGG139r
	q2Do+moMEe4nuJRagUXvF7Z0lH+IQ+R4U6Jh5PjCo0BV3jrfbscVoQT7XeKRj19g2yugzay/fXc
	DrHRJlrjuG/h5D7CwVsgadyYxLPnhPhvwYnlZA==
X-Received: by 2002:a05:6512:3b11:b0:5a1:381b:fae1 with SMTP id
 2adb3069b0e04-5a3ef8fd63emr1219768e87.10.1775824561064; Fri, 10 Apr 2026
 05:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org> <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
In-Reply-To: <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
From: Thorsten Kukuk <kukuk@suse.com>
Date: Fri, 10 Apr 2026 14:35:49 +0200
X-Gm-Features: AQROBzArSFfIiO2VXc7LMGcNpLBCIDOn1Vma2d3qfz8GDhDkrpDnJYgPEh_f5Ks
Message-ID: <CABMvmLsdgEP4sw=6YHLZxU3pHNs5fXYjQwew9ixRT0+3+b-OPA@mail.gmail.com>
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, libc-alpha@sourceware.org
Cc: Roman Bakshansky <bakshansky.lists@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:45=E2=80=AFPM Vincent Lefevre <vincent@vinc17.net=
> wrote:
>
> On 2026-03-13 10:59:11 -0300, Adhemerval Zanella Netto wrote:
> > From the glibc standpoint my plan is just to make the accounting databa=
se
> > function no-op [1] (I hopefully to get this in the next 2.44 release).
> >
> > And I think Thorsten Kukuk already adapted most of the usages in curren=
t
> > distros [2][3] using similar strategy, along with a better systemd
> > integration.  I am not sure if/when distros are incorporating his work.
> >
> > [1] https://patchwork.sourceware.org/project/glibc/list/?series=3D37271
> > [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
> > [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
>
> FYI, utmp has been reintroduced in Debian for libutempter (and thus
> applications that use this library), because systemd was not working
> or at least not sufficiently documented:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1125682

They introduced the old "hack" to get "wall" working without solving
the problem.
What will happen now again: all people having xterm running will get
the wall message in all terminals.
People not using a terminal (so most of the normal users, not
developers) will not see this message, because web browsers and other
graphical applications don't show them.
The correct solution is, that the desktop environments register a
session, and if there is a wall message, show that in an own dialog,
so that everybody get's the message once. Not the one person 50 times,
the others not at all.

Regards,
Thorsten

--=20
Thorsten Kukuk, Distinguished Engineer, Future Technologies
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461
Nuernberg, Germany
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich, =
(HRB
36809, AG N=C3=BCrnberg)
