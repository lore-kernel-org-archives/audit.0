Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A423D47A7
	for <audit@vger.kernel.org>; Wed, 29 Jul 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357210; cv=pass; b=DvvRFDhBuX8XRsYuOoDUVqbzacoJIAvYZ7TPuT0RCq2P3Wsuv7qElrlPE7YmeYskVmYoKyQxmiufijaejb7URomkXhVTlLArS8b+tKdK9FaRVKBYEzIH5uEJg5xrFqzCgVcdGnOKtg8fBtIzpBTdZCLeColNElkFRg0GyLjREMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357210; c=relaxed/simple;
	bh=rl00CFnjfTQdhYmoLt+8jdSHsilIM9IioAykyBOfUKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkopezmMi60N/lz2Ytt8f/g5oyN1Hy9WD3bZi2Lal0TEgql2qZ4hPmrRpFbbSTbjHlIWpzv6Ip1MZ+gikq6FrNvWhrWlC3uAaeqFTfFdKNM0yie0wqyEdAZUTnksUh8wHAprfQed6iiKiEk2HJZ42jt6mJTcnRkPQrbqOLI42cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fMQSdpgB; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fMQSdpgB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848593533cbso966003b3a.3
        for <audit@vger.kernel.org>; Wed, 29 Jul 2026 13:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785357207; cv=none;
        d=google.com; s=arc-20260327;
        b=Sjjk3Gq8wsuKDvQ6Qaa27BCSSo701b+5KQRwqQWCJPjiVayGEpkUCjHJns/qJXpqHT
         +IMCpAFb97o0pqZYLVgWB6TRmPOm3+Ykk8Gzqudb3GfFSH0RuLwWWD1luPqnY5bfaGD2
         5d+Dn02cc5e5O7Q9+jjgYVj1mQ3wUANAFLPMooXlAtLpvcwAhRoZNnyFPkUBZVBgJ35f
         /iJyyTCHwERjk+MPt7Vh7IvK1ftrqgl2INWS5sW0b6oPxFSQHoQrbDMoWAXMq2JGg63+
         EMKvymtwg9FR/OymFSPTLqkJwrCjb7fbWhlHB+BdCuuXlu4ukX+QbAk9zbIHz6nYRGDi
         RlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        fh=S7v6FmG33HpyyubrkolZZ9RnqE98BDXRuvlcJR6bGDE=;
        b=Nw6sIMAmbT0+GNhvir0iPlmgSlItSahCyGYjPYwE5ZQA9O84R1SueDC+4MnZ3VbFGI
         QVa9aBtlIBrVil/S2STDqa63dMST7Njy2Ym6950Gz2JooqYGnwnF37/j4XKz+/Jah4HQ
         /tydNwbJzjD2GImfF+fAitAB+VRqLjIY7BIRLHO4l7MrXCnZKrhiMX37KcjwqIEyf6BK
         JcloiEVQOk4anVRNURxNf+/zQNBKibg6ePMxVz5fij5CVsoD9x/bySm1aPjwzDHm4Pwq
         536YqA9PSFiAd5s1J6O0qpqHTa/WQiEpQbA3c4wxW4SExDAKwHjc8pqQRxmDuz7B+9jn
         5DFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785357207; x=1785962007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        b=fMQSdpgBPsKgFB908EtBrWpBsp+xWzcB7dUCFAsehLNVh9zmzitSlvKGCcNtcv0a6u
         Ewaz8T9FZY3UZv9TYfdczohm/Naw0iHz91olO3sLXKu/JwIj2+1NUbSjyL5QZQmNBZU0
         4Xp5IsqVGrf/p6Z70H842w4giCTPUDOX0ovT/sC1gPcRASfgX1EK9nJEf288osdjsTVg
         Q86njvQDZ8O+CkSLCvH4EJ9GI21y/pIdBYt9JmOIIL7UBfQpTA++1jWd+Q1B/MXMnnL+
         pkF2ofcrgcdcz0EZh5UtqWfWpyMtgfi1ZlpIdQHYym2bP3b3GCEoyaR1esO/Hl8VnEzl
         M1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357207; x=1785962007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        b=EmojEhp/ntnIKAeGa2cl74nNjEYYKHS1rmXsVrmJUEsLd4+5A4Ss4Apji+wpYiRv4z
         v+XD23KinDsRtqd4Vir9qcALPyukrQq250UwVSHlIbSMzelZKUVxxKWGqZp0fftBCyHn
         pWKs7ptFeGJMwjNTJUZ+c8AsFLvbR8RQTQeRu+xYRIdETUN/lC1nIsmFA8KQlrvyYjH6
         6V1c7NuakTmCds9sonx3a9DeP2DLBAJ9y60aOYOsl7gHC8E1tqLebJXpdqX4vFGax7TV
         DyqgaVyL0usGVveNRQjvuO1thySqxq4d/4Bi3KKeSilm5fGLGKJXpN1j9EKn6NUOyJFj
         iy8Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro8Q9YwThO5XtmGvAWtALAxFKxDM4hrgrCOcnoSwOjStQqaUZNo5zwMhf4wjHnRsSu24D+0eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuObYW/GOzixB4q5y76iisEMJ38/9M8078ojMbHjJEI1J9O/N1
	8aUK0aS47XCABCR0tFLLJD2tVT9nLj0wDrh7qNJh4iCABCAhK0G8jsLAIeGYVE4sNVmQW/qHmj0
	hEYHTcc3l6h+M93osxpwk2i2UOFBEnNT8X9E0HQx/
X-Gm-Gg: AR+sD10Rs+6PwIa1vNkKXjGg2MXDR2nUzkEFmXW8rpBBGWisyRZ4G/lYti7jDZhz5pW
	aLSxhYWFY9HICqC5abRFOLBxzY0IQ5bb6VTLIX0HfpIer19Mxbw4qnQgIwPcNyapDkDuvYtmaRO
	f4Tg9+sF/QiUkfmCQFC6AkvyD8+B4rV1Npgk7o5Ym9iZIw6JxxxY30OTEPXxdFRtB773lUHITv2
	8yXUqe7f+o5odmBJQZWcZQLqWFlWHjQdTfC29gpVWtdjA5jfsft8n0O7dw3/SPh7rC3x+TxRykP
	qQwz9H1oEXmx26+zis5p+SixJk1fVlKHA3ozXtiOQU0q
X-Received: by 2002:a05:6a00:1407:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-84eba0d2741mr290741b3a.30.1785357207079; Wed, 29 Jul 2026
 13:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173710.964626-1-rrobaina@redhat.com> <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
 <-GF9cdtWTQSigd6gY6zWOw@redhat.com>
In-Reply-To: <-GF9cdtWTQSigd6gY6zWOw@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Jul 2026 16:33:15 -0400
X-Gm-Features: AUfX_mzIikCBs8eykvIkNwAKaaJ_gfDNHj6hpFCIxVi_KmhNMPnn4-xMb0XDtzo
Message-ID: <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	rbriggs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 2:11=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
> On Tuesday, July 28, 2026 4:35:20=E2=80=AFPM Eastern Daylight Time Paul M=
oore wrote:
> > On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the fsconfig syscall b=
ut
> > > does not capture the configuration parameters, creating an audit gap =
for
> > > critical mount information such as the device being mounted.
> > >
> > > Add an FSCONFIG auxiliary record that logs the command type, paramete=
r
> > > name (key), parameter value, and aux parameter passed to fsconfig(2).
> > >
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_STRING ...
> > >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_aux=
=3D0
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_CMD_CREATE ...
> > >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_aux=
=3D0
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_BINARY ...
> > >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" fs=
_aux=3D4
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > > Changes in v2:
> > > - Fixed null-check for fs_key field.
> > > - Clarified trimmed SYSCALL output in commit message examples.
> > >
> > >  fs/fsopen.c                |  7 +++++++
> > >  include/linux/audit.h      | 13 +++++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> > >  4 files changed, 48 insertions(+)
> > >
> > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > index ae19e5136598..9b3c02f59df4 100644
> > > --- a/fs/fsopen.c
> > > +++ b/fs/fsopen.c
> > > @@ -15,6 +15,7 @@
> > >
> > >  #include <linux/namei.h>
> > >  #include <linux/file.h>
> > >  #include <uapi/linux/mount.h>
> > >
> > > +#include <linux/audit.h>
> > >
> > >  #include "internal.h"
> > >  #include "mount.h"
> > >
> > > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >     struct fs_context *fc;
> > >     int ret;
> > >     int lookup_flags =3D 0;
> > >
> > > +   const char *value_str =3D NULL;
> > >
> > >     struct fs_parameter param =3D {
> > >
> > >             .type   =3D fs_value_is_undefined,
> > >
> > > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >                     goto out_key;
> > >
> > >             }
> > >             param.size =3D strlen(param.string);
> > >
> > > +           value_str =3D param.string;
> > >
> > >             break;
> > >
> > >     case FSCONFIG_SET_BINARY:
> > >             param.type =3D fs_value_is_blob;
> > >
> > > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >                     ret =3D PTR_ERR(param.blob);
> > >                     goto out_key;
> > >
> > >             }
> > >
> > > +           value_str =3D "<binary>";
> >
> > Is there a reason why we're not logging the binary data?  We might want
> > to impose a size limit to truncate the logged data (although we have
> > provisions to log rather large binary chunks), but I don't see a reason
> > why we couldn't log the binary data as a hex string.
>
> I did a search for any user of this. There are no known consumers. Last
> February, fsparam_blob() / fs_param_is_blob parser support was removed. T=
hat
> means we don't really have a use case. If, for example, someone decided t=
o
> use this API to insert a private key used for decryption or something, we
> probably don't want that in logs. So, without an actual use case, it's ha=
rd
> to say if logging this would be a liability or something needed. But yes,=
 it
> could be done with the hex string encoding if required.

Let's just log the binary data.

--=20
paul-moore.com
