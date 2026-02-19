Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205F2D3A93
	for <audit@vger.kernel.org>; Thu, 19 Feb 2026 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539673; cv=pass; b=PB6YleIlrggv76f/AhDfoobtQri80nt1A5bD/gRIQPisn3isN/pf9XGmwlerELhQ4bSKKfEbE1BD5p5OR6pC6HSv/RE4JgcDa+dinMjhav+fh3qxJYSz8qeNcVvSNTtvmp9wDtb0h139mfZXTnxHdMWA4BmWnP5kU/j5EnnpLD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539673; c=relaxed/simple;
	bh=wowk2ufSHQecDFQjYYkrX5YR3rZgdfDGin5E0dyvKbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrNnV40iWddnQOMect7Dmil5NE/ZaQtQz9suVrQg1EL72xjs4UYcz0959Nr8k7AJVapMqSAY286HiWdrymUH+7gUSAzNux4kMrsmBRKJSF7JSvGglWsVfG3E3F/eZ56TNHvlipEGLQi6ZK6/jfkxRp7WxY6hVF4HtQNndwfEb3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KgC4+ou/; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KgC4+ou/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aadc18f230so8756905ad.3
        for <audit@vger.kernel.org>; Thu, 19 Feb 2026 14:21:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771539671; cv=none;
        d=google.com; s=arc-20240605;
        b=L5+lAitlC5rsraV4Kl1lCaoSKrIQQu/DmNwvvGcc82dqRcgpqOaQzWf0dluI82ragv
         I3o7ijjlRoZ93AwbUFlFTJ7YD0Cfy4kz7dFifDBgvWzgk7Rf45kNKkcbX4X4TRG0JDlZ
         3UmluhQfJPJz85ZN6LMbHsWG4uXXOAABnCYQOPpTxiY+hBBkWSqDtQTFET5QpiLvTFqs
         rwO78uOfi8bhVMwkjEyNrPnuW4aNi54wORmX1sPmvOcChmKun05b2LcXdUpmb/ZSvkEN
         9sxRxLZID4YLFxwS5ms0c8ofkdDbUu2DDLkRDRbeWjcmUNFcms0bd2mZV/9kZ8a+C7F3
         3HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        fh=Y70Gkm/WIq97NEf4jA6P+VPMj8NwPBKSndlJD/VF/bg=;
        b=K8FuCOnIgGmgixNWtmacY0ceRw423cPI2yD+AfjYChi5hQA1LwurlhEfiaVlmCl+zn
         Y8at6gTnVKta0OGnczvQqFaBGDhBB82XT7g+l34hNX/PDQeU7VMTWXuZx3mz1qkfQ5tr
         +w1i6r+cF/pU9oxLl26DADSpWWuSQ4YSGgg/gQOHX2CMJFGky21K5JSJp6NZO2t90nqX
         3rIQv80x+/XbyYUS8+QVxnmz9jSs85OcPaMK7A9jsxyGTT2Bc0SLaY20rERvazC/Yc06
         zQQ4YODNdp55Mf7Eg2V3rfqbsXeMt5tv7/PwSYynuSGpU8ThbRSyDCKQVi5yjTRQGPy2
         k9PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771539671; x=1772144471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        b=KgC4+ou/pZ1wsCyJC1XjcA3yDoNZz2fK1nFbxLcqAp0tbqBNnd3C4NRPMGqa2Fv9Lp
         pBtEqj8UkkzL1JVsTaPuk15B/SBNoUDdF3hY40h8C8WH/GvmJKV2YFWIYyOMzPHK8Z6f
         uedyTBXidFJpCheTZITbGA9G1h+p0den5uNCTlP9rP4yK4aXdMdxli4wM+rBiAaVjwLz
         x0GxoZ8XXW6kGz+Kf2Lf6+PJIxs5VQdU132DU5TihaXyizY1EvArj2tPHmeqNINJBuB0
         gYo+lirxvz8JdlEodvwHPXYdOEUOxuXjeIFbQl5wijOCgN2CJ3L5vDFX/ihUMiVeIipz
         X1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539671; x=1772144471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        b=nTSyA0+cSZQ6ClFNOfrD8NiMslekN4EADEcp8OiPlTnnY0aZipfgJp9r4y//RXD7OE
         ksvbP1qQJuJOMHtiamzxFNH0g8pGul4gpCGNZcFrt8LACUD/Rk9/nBgvT1ahzBiGFV7B
         eL1ovBSt8cpaqUzZAFBgGpr1EhhMUz3ibh+pElcoVsClV3aIGtk12XwIBBpgc7Cj3aL3
         LQPJ6ye0Lgg2ObuBOaK7nhscWLjpVQsoPq0pVCktI3/o34il+KIst4zO3IW1J55KoSsl
         pfq1YYpd/N57SNRBA7H6DrKlMsfk7VKln8l2EqufOmjTRafnXJ0/5BuxbNVEdgo/Bk1h
         ydcw==
X-Forwarded-Encrypted: i=1; AJvYcCXMFLVRSbkBrB3816WZfaMESZw4v/qz4oyp1jalTdXLRaVGCjEPq0cs7DxAUZPA9xTvK4hXRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJYOJWssl+9uFFR7vQMBbgac/sBU2gZuLX02zAjVpyWLjEfB+
	zwCr/II8nJr2MEn33mt7NTzurxL2PIFKOYX+Fafmx0UV8khY8N8OMC6Bs6zdPI7z1BEuuErkwBc
	Z0mLdsFDzogeQ9J29yOJpOhOauBr62FSn51bIOP+a
X-Gm-Gg: AZuq6aLunSUjh1Bpi8FwqNLHqYmtpEzpRkisfO/UZIO47GGk/GjcbY312NLGexyunS8
	Uj3pMgd0siOwpNiWOmyAQTxtNO7qQvv5jzDETN34YTJeBCO9JuKRTIq3Epr+8d3edN3rGXmOGWz
	kkeSsnMsSUURpnnIRlxSgqd/nB2X6hJFWYHl1uHA+5XRcoC8gNX7KS1Ytip2UUK4CC0vGWwn41s
	OEQtppZf2Mxovx972muuBJNKoazI8ZM7+swMgHPQw7TBepq+z/Ph6KdgVCcE/2lO3pPDtRWcuya
	9ZRAV/c=
X-Received: by 2002:a17:902:d50a:b0:2a9:4c2:e47 with SMTP id
 d9443c01a7336-2ad1759d351mr213955245ad.56.1771539671248; Thu, 19 Feb 2026
 14:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206201918.1988344-1-longman@redhat.com> <20260212180820.2418869-2-longman@redhat.com>
In-Reply-To: <20260212180820.2418869-2-longman@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 17:20:59 -0500
X-Gm-Features: AaiRm50N0R25gsfn0vpcilKZY1vgm9wjILm5OJyUYNaP67DJtz5hnb-dhbNc_ts
Message-ID: <CAHC9VhTA+b1sdg88o1wXgMUcPDpxd_nQYc-aPEcBuzUuNVz+ag@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] fs: Add a pool of extra fs->pwd references
 to fs_struct
To: Waiman Long <longman@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 1:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
>
> A simple and elegant solution to avoid this kind of performance
> regression is to add a common pool of extra fs->pwd references inside
> the fs_struct. When a caller needs a pwd reference, it can borrow one
> from pool, if available, to avoid an explicit path_get(). When it is
> time to release the reference, it can put it back into the common pool
> if fs->pwd isn't changed before without doing a path_put(). We still
> need to acquire the fs's spinlock, but fs_struct is more distributed
> and it is less common to have many tasks sharing a single fs_struct.
>
> A new set of get_fs_pwd_pool/put_fs_pwd_pool() APIs are introduced
> with this patch to enable other subsystems to acquire and release
> a pwd reference from the common pool without doing unnecessary
> path_get/path_put().
>
> Besides fs/fs_struct.c, the copy_mnt_ns() function of fs/namespace.c is
> also modified to properly handle the extra pwd references, if available.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/fs_struct.c            | 26 +++++++++++++++++++++-----
>  fs/namespace.c            |  8 ++++++++
>  include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 6 deletions(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index c58674a20cad..a2323ba84d76 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -40,6 +41,33 @@ static inline void get_fs_pwd(struct fs_struct *fs, st=
ruct path *pwd)
>         read_sequnlock_excl(&fs->seq);
>  }
>
> +/* Acquire a pwd reference from the pwd_refs pool, if available */
> +static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pw=
d)
> +{
> +       read_seqlock_excl(&fs->seq);
> +       *pwd =3D fs->pwd;
> +       if (fs->pwd_refs)
> +               fs->pwd_refs--;
> +       else
> +               path_get(pwd);
> +       read_sequnlock_excl(&fs->seq);
> +}
> +
> +/* Release a pwd reference back to the pwd_refs pool, if appropriate */
> +static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pw=
d)
> +{
> +       bool put =3D false;
> +
> +       read_seqlock_excl(&fs->seq);
> +       if ((fs->pwd.dentry =3D=3D pwd->dentry) && (fs->pwd.mnt =3D=3D pw=
d->mnt))
> +               fs->pwd_refs++;
> +       else
> +               put =3D true;
> +       read_sequnlock_excl(&fs->seq);
> +       if (put)
> +               path_put(pwd);
> +}

This is a nitpick, and perhaps I'm missing something, but I think you
could skip the local 'put' boolean by setting 'pwd' to NULL in the
pool case, e.g.

static inline void put_fs_pwd_pool(fs, pwd)
{
  read_seqlock_excl(&fs)
  if (fs =3D=3D pwd) {
    fs->pwd_refs++
    pwd =3D NULL
  }
  read_sequnlock_excl(&fs)
  if (pwd)
    path_put(pwd)
}

--=20
paul-moore.com
