Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E909836AB7C
	for <audit@vger.kernel.org>; Tue, 17 Feb 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335861; cv=pass; b=hOFKVIAd1X/eTQeawH6igsjtLzZ6si7VWcZoFakamRBQn2Jd3h4ze9VksePFepBYZuAO9xoY92QGhgTrP574t1s+j9mZfM0uiIXwQJtT80wspqvyRzhVa/M6O5C0KGhkjwMX56AygEGZ49fyfcQPTvQxHfS/BbNEKehQZ01A6Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335861; c=relaxed/simple;
	bh=uIwgs6+KfVm6ezT+rIUnq56Ei9MBoA09jVtLFpXkKDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cdol1mXG7KcKDNyxB+23b6kbCD6ttniWhHe3g5MIRZNfIzJuUMYCIdOEIiGjGwu3A8mfVoImUT7IYviaB18JHJjwCMaBx8PMTFyIx1Xo/UQ3DUH2jQokTjLR+S1RcshQZKiet9/21QN6CovGfhCcyXHz64PYfinQ57e+LdXEnSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvWxClvQ; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvWxClvQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fb3c4bbc4so569624366b.2
        for <audit@vger.kernel.org>; Tue, 17 Feb 2026 05:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335858; cv=none;
        d=google.com; s=arc-20240605;
        b=gEWCT37X0hJLcRMJypscYSTH00Yq2ZiQYQ3W7SbkhpQ7PG9kpTbATEnm7WkQjZ6VCM
         DYtR7ou6SSuswgcAsoqZn5+Ni/yjmC+vBXVOiK9vaCqhVEt5wNSplX3YzgP9Mc+et7aT
         xII4/DGXGWaFXazqTnE+L7DrW1ULYh+O0lR3YP/2k7M8gZXWg/xBdm4IODV7dmuIh1jJ
         Np4aEY+lZobaKhsWAorGzseJpm9agygyBfS7cc4R90BRlPKfW2KG/xTUbGXApdeFic4z
         sq1y9pbLFB81IkuShBsbrlpS60FtUU+fUQYMnq3M30I/XJBBiS+GKKV2fXbWme6jvdH4
         Trzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NG7tJlsrCf47QZDECjNynyzE6rS3FfREc+SHd+1cJDg=;
        fh=xW+1UT9AXVPQ7NFvK0gKFYgAOZDSzzzfzjSe/f+JKbY=;
        b=YB94mhFV4VaE911aEuscWbrgMJX3ZFV4nPAuqbmldK3e6yHsv06hf2zSxE9XT9p+pn
         SidwedJnylJScESMbwgAQ3kwwHdAeKUatjMSvOxZCLzM67Mv18eQSicxm6sy7Xp2HKQq
         Vio0fW71c7W0DpY5RzLBggGa2EpWKl3LtzDHj67aGVqWDt92YSaEzFr9DHI54Ku2KXxQ
         KsrojrQwSg91oae1QPJoSrty9asvoaByu6Av7Qh/UtCHcHs0k9S8ku51FPv3VgIIP3tH
         0y+fyzGOiJeqWArzCyTWxOv0Qo9ShTKC2xIQDruOnr+SPw111HgevRWoXaO5vTr6J27d
         lf5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771335858; x=1771940658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG7tJlsrCf47QZDECjNynyzE6rS3FfREc+SHd+1cJDg=;
        b=kvWxClvQnXozJ0XJJeTrfMMB+SzFBlaJ/A/4b2iUtxcS5t1jK/mTwU8CMUl0RZXf5h
         aKQyGizW13wQbKmYXv/QilYPTluNfljtSTCQJtwhz8j/EZaD+b184Q2Ru9GkSCozBSZi
         brCCWVOJP2kSvKrbVvae9BIXqrKKhZneusCj3vwL0anPyU5s44PaxDrNYltl/B1kYAif
         tmh07m3+d9kHi5PEF/Wfug+QHnU7tcPhIcczwhcv+zybE0g2BWeWlBXNtJvLsXuaZNPZ
         FPc8fPv/2qYpaf+jXaiho3qnYvHDePlaKyzYDbdFC6ELpZVU8+QmEHS0bK3xuBv3+kOe
         utXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771335858; x=1771940658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NG7tJlsrCf47QZDECjNynyzE6rS3FfREc+SHd+1cJDg=;
        b=UG05ob87Pkfyv0Hk5fbChVmQWX1ep5mpdMj/sBqhoRRMuWe45hQduW+lvT4bbxYDBP
         8Q3/ecIOxCJuqUZu+pnWDL7+Jdz7tnr1piIORZoKKVIXmybWCKU8uUuvDmjD6DOV+95a
         6xLFHA2wNCkFnOaBZc5Fk7T3JcLVGRmcmDWgE/qW998IlrJLo1H+Ba6bvzYhOkAcnq+w
         pI72od6Gdy4byeUUvy3vZgWf+BJLafXAmYNMivIXUz7fownq1uN+NKlHzuLNfVNrg7ps
         LSUcJxrhdipzhKsxws9S6vkNtCAMd6b59tqbpeizV7B3UKZ87Y73yEQzJm4krcSsOe26
         9qtw==
X-Forwarded-Encrypted: i=1; AJvYcCVJESq7HzFRJjE7R2qCJTNjcQ0A6o12TwbUuQU62ajLJp7t0pDtbcJjjXxND9XP6WTDQlaF2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyELQfWRFrob7O20yEw5uISQ+xtwsEpqtXu09E38O+Ng0UwASgU
	DUVvzkJPfyX5A7tMYRkfwUO5tO4RZ24iGv3dclrpiK6343SX128rPcn6JMtHgI5f9vW6hqlBv1N
	t4CkEiR7/wTnB1OEbSXA2KxZspMtTxgI=
X-Gm-Gg: AZuq6aI4zKcNJ7neDUZhaq3sdFJnsQVxjmaGN2qkWBm8VO/xHjvbxscFm/9mZuo/++8
	AV+ee1lwB6DJy/DgtaUM4TU526j4SNu40b7LNuvzoxFDFkvqEg9ZDThDeU+Zo6ifioMyFe9lcuV
	4iXlnhsKfK8T5VeuWj1aQxvDY6KIZgmXBYnTKDwvYFlKTVnNXqNF4qWYuU3UGytAEclcSNGWRaG
	g6aX2oipXD9DTOe8zkQNiW55lMFLWXHt8oeM2YyfvLCn1EIQqCKpEzrwZIqNwYJZvTrRA5Vgs8j
	iaOuGI8AQvxoDlY1LDJSuhTNMi9nrPGDQYq4SJw=
X-Received: by 2002:a17:906:209a:b0:b8f:c4be:f1f3 with SMTP id
 a640c23a62f3a-b8fc4bef454mr306018266b.59.1771335858045; Tue, 17 Feb 2026
 05:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com> <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com> <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com> <20260205052202.GQ3183987@ZenIV>
 <CAGudoHFz1QZdYTp=PbAF+v-3-EZhwL0PQz+Zv0nNTG0WCSAdAw@mail.gmail.com> <20260217-fortsetzen-razzia-11771992d348@brauner>
In-Reply-To: <20260217-fortsetzen-razzia-11771992d348@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 17 Feb 2026 14:44:05 +0100
X-Gm-Features: AaiRm528gKxjugErWLP1yyOWwCCWyW6AjV2fIZk4wj6m71h8TN_j8eXtz9RPnKs
Message-ID: <CAGudoHG5uGU7p67dK5tj_NJ3F9_+moRWGCu=VFR+8MFP1O3mEA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, 
	Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 2:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Feb 05, 2026 at 06:53:34PM +0100, Mateusz Guzik wrote:
> > On Thu, Feb 5, 2026 at 6:20=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > > Mateusz: *is* there a measurable effect?  Because if there isn't, I'm
> > > very tempted to simply revert that thing.  "Churn of adding fs_struct=
.h
> > > as needed" is not the problem - try "exposing the object internals to
> > > far larger subset of the kernel".  We had interesting bugs with weird
> > > shit deciding to poke in there, locking and refcounting be damned.
> >
> > This one I did not bother benchmarking as it is an obvious change --
> > read a var directly instead of going through a func call.
> >
> > If this is causing trouble then it definitely needs to be reverted,
> > but any woes only speak to the mess in the header files.
>
> Any reason this isn't just stealing the cred.h trick?
>
> diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
> index 0070764b790a..e8b8d073f9e0 100644
> --- a/include/linux/fs_struct.h
> +++ b/include/linux/fs_struct.h
> @@ -2,11 +2,12 @@
>  #ifndef _LINUX_FS_STRUCT_H
>  #define _LINUX_FS_STRUCT_H
>
> -#include <linux/sched.h>
>  #include <linux/path.h>
>  #include <linux/spinlock.h>
>  #include <linux/seqlock.h>
>
> +struct task_struct;
> +
>  struct fs_struct {
>         int users;
>         seqlock_t seq;
> @@ -42,9 +43,6 @@ static inline void get_fs_pwd(struct fs_struct *fs, str=
uct path *pwd)
>
>  extern bool current_chrooted(void);
>
> -static inline int current_umask(void)
> -{
> -       return current->fs->umask;
> -}
> +#define current_umask() (current->fs->umask)
>
>  #endif /* _LINUX_FS_STRUCT_H */
>

This depends on the users having task_struct already provided, which
sooner or later will give someone a build breakage when they work on a
new patch, but perhaps that's just a minor inconvenience and is not
worth worrying about.

That said, if the above is no considered a factor, I'm definitely not
going to protest.
