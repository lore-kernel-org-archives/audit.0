Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596947ECC4
	for <audit@vger.kernel.org>; Thu,  2 Jul 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994733; cv=none; b=pX/1LS1wwQJtPhsrmtCr26PkifXd55SXRQUZbsOOeT4w0shg4VQ+ySc7oyiGR3majnBjeOw0eD7ENJGVMSAhiD56LvsT/d/CU/sIMOiuJH5iFpEyRU64z+2oy0N5/HnwyKTeYhu5sGjWH2/rFFjavoBEYAO6TiZyUAmdKzlN2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994733; c=relaxed/simple;
	bh=XeFTm+NDhKM4oCHE6F+bTKNgKrbiRR9bmo8v9+zhMpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IM4hKyVA/vVLhxBFrfPQHyqr5U7WfZmJIDilsuPWU0dNmgRKaoVmwMQBx4aVg6gKeEAxMO4gDVDIspuP95txxK7MvWGWeSpcmeHLps9mIXNXEEOVVXP+KATEhe3V2INuBq7T/7IKTyMucAX0YMoJ4sgMqmDXCPa0CT5YZQ4E8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVuB6ocl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVuB6ocl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782994731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
	b=MVuB6ocllaO4XyqqTuhmrL2IKOvJ7S1O+MaWZEfImIzv7PJzxemrbeEbnWbnrcr2KYfhyb
	8McESbTjBNkLPRxgIoGdL3xY6Gvg97mpSwC5kbrrgqsvlICNHC7z189eHr3ylaonWZaQHv
	YWCq91/tjvbuiZnm6MidUfV+DdpBW4w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-p8amwxibMO-vWO74nJhCtg-1; Thu, 02 Jul 2026 08:18:48 -0400
X-MC-Unique: p8amwxibMO-vWO74nJhCtg-1
X-Mimecast-MFC-AGG-ID: p8amwxibMO-vWO74nJhCtg_1782994727
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1271887c33so162101566b.3
        for <audit@vger.kernel.org>; Thu, 02 Jul 2026 05:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994727; x=1783599527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
        b=YQ1TP0MMw/u8OAXjLSDI6mAyOUKabFEJBg4VJjSv0FY2dw6JDx9vBW1FJ/ktY7QglU
         +QSzZtlgX/nkaX5TqsvOkRkpXdK24/Rs3YCkBxXQe4YN4uIxxqWHvELTJpyrsVF+R1wL
         pfJq1XFFVCE5vr8QDuD/U5p3N6HBy6U0CrqSwyDFCz+Kf/4O9umKXpkH92/uGV4FopGQ
         JKrfznS9GG9FjLoIfl1z52+OAno7Te2ok7DZQV+SRZfakP5vEWkr61COgQl3MZGE70QO
         bsu9kcQt162+4Y32v3FvDKZRyxTWq+aFFkGCTeF1Kp7Szs6yM7suDBcb25KwR0B3KgRl
         WttQ==
X-Gm-Message-State: AOJu0YwafG6nI+4ZyjoN5AU7L2h9g8QLVSWFO+697AbQDcEbIAbRzewN
	ReOlkoZS4cIBPYRXJqNT487CaISK8fec8IXPqlG+1Ohrt/nrROwt5dRx81z7rz40bnnldRmcTph
	BL5uSX/GgWmofURt9czC1IeWKwRBC1iTKEjrJa5555lioaZnLQe3O5VkTIU2WQZsWSS346xh+sY
	RodTAJN9zv3g//icyoy1RlsnzQnNsGk1g=
X-Gm-Gg: AfdE7ckcaL9tG2eXvqF/yhYrq4Jh9jfI1iI02EwS0A2rldMLO02m6KptryC6GYrv4cT
	0GSh3WMalJWX6vQ4wJMXmEGSn0f4klXUQN9dhBRj7iU+kZLlqEuyr/3A7ciFFc4/7KsQEy3Ediq
	3hXFUjZGpdeI/gSdYg9wW8OCXfYQp5AlB+fyri5Lkx+vi0Hmzmu7zsPikJQUEE3D5LrF1WN1Mba
	pIBlundVDjvLTaRD9yVHO1adGG8zwDSpKT0ZsLyNZLw/BRe+AcX3yUc
X-Received: by 2002:a17:907:6c12:b0:c0d:cd71:6463 with SMTP id a640c23a62f3a-c12ae48cbddmr258355166b.16.1782994726716;
        Thu, 02 Jul 2026 05:18:46 -0700 (PDT)
X-Received: by 2002:a17:907:6c12:b0:c0d:cd71:6463 with SMTP id
 a640c23a62f3a-c12ae48cbddmr258354266b.16.1782994726351; Thu, 02 Jul 2026
 05:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701132410.711205-1-rrobaina@redhat.com> <20260702-edelherzig-hammer-beenden-08e75c154e46@brauner>
In-Reply-To: <20260702-edelherzig-hammer-beenden-08e75c154e46@brauner>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 09:18:35 -0300
X-Gm-Features: AVVi8Cep1ZCE6nCvM5-B9LYxsOd5RvIlr8zB25Nc8T6Z_iJ3zcYnuNEtemUS1kc
Message-ID: <CAABTaaByDwAokuDgR5BsoKzWyByHn6rpBL1EoY_TdVyT-Kt0Jw@mail.gmail.com>
Subject: Re: [PATCH] audit: add FSOPEN record to log filesystem name
To: Christian Brauner <brauner@kernel.org>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hDxIds-ogwubp2yGVP-9edxTCtTXAk6Wa2r-71i2mDs_1782994727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 3:59=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > does not capture the filesystem name string, creating an audit gap for
> > filesystem mount operations.
> >
> > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > name string passed to fsopen(2).
> >
> >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN_C=
LOEXEC
> >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> >
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index ae19e5136598..8b07f9d42be2 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> >  #include <uapi/linux/mount.h>
> > +#include <linux/audit.h>
> >  #include "internal.h"
> >  #include "mount.h"
> >
> > @@ -150,6 +151,8 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_na=
me, unsigned int, flags)
> >       if (ret < 0)
> >               goto err_fc;
> >
> > +     audit_log_fsopen(fs_name);
>
> Right above:
>
>         fs_type =3D get_fs_type(fs_name);
>         kfree(fs_name);
>         if (!fs_type)
>                 return -ENODEV;
>
> So that's a UAF.
>
> --
> Christian Brauner <brauner@kernel.org>
>

Thanks for reviewing this patch, Christian!

You're right, I missed that. I'll be sending a v2 shortly.

-Ricardo

