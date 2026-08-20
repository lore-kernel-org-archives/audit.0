Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3244064B
	for <audit@vger.kernel.org>; Thu, 20 Aug 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229703; cv=none; b=P0t0fiIqKUszmYkUq4vtAr6hp9y4SLyi21asYEAyg07XkDa7ut2IvIfRq5hVUIswNwTAYIUsFW7lHcJ9tAc/pPL/IYufS1E+qU5aAZsXrh/yB3QLRRo1ddvKmr5bF3dyBxdUc4LOfScLsWCsmCpTuXXl59J11Z7Hf+wB6x8ZpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229703; c=relaxed/simple;
	bh=xyK3YcJ8rmgj6lq6VokQD1kmp0IQkKKUKZmXMzPvcbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8TE3sgX9SgQ7glh2HlVtv+YlwMidGZJQ6nXWky0bmImcJ42NdHGhflx3cLCUOKT4Jw8I8FbEv0fKjfBZIr6kXd3lmsyhWjB1undGHT49eARB/P/ZJsZeOoaOxD750OmFz09MSt2Zj+zT8Ty+nC/UVc395zZkLqqCYTlIhFKzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBuCa6wE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBuCa6wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787229700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
	b=cBuCa6wESgJ0CtROH2sl7F4tOE5sAPr4KmM68E/Mwip5YgGQwa4PaaYnwRbv+oznDrgedx
	pGBPg2RO6l5F1x6N4zGNBHBkhsXX9ycPD+7f/td25IJvybPYh7ekA4exrXSyrwy+yyybT7
	kX5YQvjiz2yVQdTdWEa4R2iTelM1a3Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2VGVF5l1PLWlMCvuhHSxHw-1; Thu, 20 Aug 2026 08:41:37 -0400
X-MC-Unique: 2VGVF5l1PLWlMCvuhHSxHw-1
X-Mimecast-MFC-AGG-ID: 2VGVF5l1PLWlMCvuhHSxHw_1787229696
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15fff01a30so136384466b.1
        for <audit@vger.kernel.org>; Thu, 20 Aug 2026 05:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229696; x=1787834496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
        b=Pkltt+jkhnQQTCvNxFcTF84WOX73yaUWTtVxnvyxCy5hbCsjMOE1aDFXfv6R/5m7jp
         f0mbOd0hWzl9ajFVacTmxgCTnz4fk10hU3xf30TgqMHgzshO07eBKbBiC+7gn0/HBbQb
         cWn/6Rhlu6SPAKfYvuuxtmIfnShU3ekzBCTTncZKxia4aAAlWoDXeSDFp9DW8Fj03bd/
         2sQiTPyxnaSRHgyUUjAP3BKtoIQlJv9FXBi6KZirvxJNWXaCang1DTU2eafrU6h9mboY
         i7mqbM09zXYZgwDEfrd9b3haeWCrHKM8madCk6wGcd8nqGmZVRDZnpiYxYYG9sxfsDHc
         TMnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDfMDPLoblXiLD65qUthR15rKilBxUHAiAJNu8j7Axp0KkZFOnKhsH5efUBa8mha+OCLRIVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8oHwviDSlfibTrvOoZp+LT8X/Opq9wmuns8nJGha34TlmSdI
	OeZb2yKTli0xT8UUCogIdz2V/j0lL2J6lpfPNGh5vIJAMQo49mEhSiRm18ARZ5gbk4FlA9v/Mv6
	8AP2UptK7zadvUvdbJeBLEG+asK9fzKbpZWSViu2K12tKcgBDbKicnGaB33+F/26DtLcnlN4ej0
	20RozwvcGRBooahL60ztZstcxInQX+ut0=
X-Gm-Gg: AR+sD12Qx16pI9cMIp764TplnNsX3XoazLJ+bkXXZK9vN8LoWL808ttqmY6ayb+FGtB
	5OC0xReIGUlf5oCnIaKbLgfZgiC5yK/0BmLpnAQ1f8rXDGxiJ89foh5+oAO/wvbgFFaoBBj9YaT
	NaRiw0Zwng2PbgSsRVSdAX7V85FS1P7wVlW069KczjTtJaLgLwXZ7tG9lAef9mLYPjayMIsX20B
	/MjG262yQPB65KHrjYEsmkX+oNO6e9F8m1KJc0t8K3LhxHB4iu2QmkFqD1uUhmt+85pTjA4HbVU
X-Received: by 2002:a17:906:9c8d:b0:c1c:4895:c3ba with SMTP id a640c23a62f3a-c242e6e95ccmr930677466b.22.1787229695779;
        Thu, 20 Aug 2026 05:41:35 -0700 (PDT)
X-Received: by 2002:a17:906:9c8d:b0:c1c:4895:c3ba with SMTP id
 a640c23a62f3a-c242e6e95ccmr930672766b.22.1787229695334; Thu, 20 Aug 2026
 05:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173710.964626-1-rrobaina@redhat.com> <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
 <-GF9cdtWTQSigd6gY6zWOw@redhat.com> <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
In-Reply-To: <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 20 Aug 2026 09:41:23 -0300
X-Gm-Features: AcwNN1Uw6af7c0GFDlK7UVFm4k2Bj_2hvGt9ydWcdax4ivJFhj9FF98E_U97WLU
Message-ID: <CAABTaaBWiWM3ON72MtTeoJC=h7mTMw7cALsNXMZwiRNpU4rrjg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, rbriggs@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mw430C8pj02A2bFchUsOfsF7WSKTN2mV88ikX0ImmfI_1787229696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 29, 2026 at 2:11=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> w=
rote:
> > On Tuesday, July 28, 2026 4:35:20=E2=80=AFPM Eastern Daylight Time Paul=
 Moore wrote:
> > > On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount=
(2)
> > > > syscall. The generic SYSCALL audit record logs the fsconfig syscall=
 but
> > > > does not capture the configuration parameters, creating an audit ga=
p for
> > > > critical mount information such as the device being mounted.
> > > >
> > > > Add an FSCONFIG auxiliary record that logs the command type, parame=
ter
> > > > name (key), parameter value, and aux parameter passed to fsconfig(2=
).
> > > >
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_STRING .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_a=
ux=3D0
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_CMD_CREATE .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_au=
x=3D0
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_BINARY .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" =
fs_aux=3D4
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > ---
> > > > Changes in v2:
> > > > - Fixed null-check for fs_key field.
> > > > - Clarified trimmed SYSCALL output in commit message examples.
> > > >
> > > >  fs/fsopen.c                |  7 +++++++
> > > >  include/linux/audit.h      | 13 +++++++++++++
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> > > >  4 files changed, 48 insertions(+)
> > > >
> > > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > > index ae19e5136598..9b3c02f59df4 100644
> > > > --- a/fs/fsopen.c
> > > > +++ b/fs/fsopen.c
> > > > @@ -15,6 +15,7 @@
> > > >
> > > >  #include <linux/namei.h>
> > > >  #include <linux/file.h>
> > > >  #include <uapi/linux/mount.h>
> > > >
> > > > +#include <linux/audit.h>
> > > >
> > > >  #include "internal.h"
> > > >  #include "mount.h"
> > > >
> > > > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >     struct fs_context *fc;
> > > >     int ret;
> > > >     int lookup_flags =3D 0;
> > > >
> > > > +   const char *value_str =3D NULL;
> > > >
> > > >     struct fs_parameter param =3D {
> > > >
> > > >             .type   =3D fs_value_is_undefined,
> > > >
> > > > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >                     goto out_key;
> > > >
> > > >             }
> > > >             param.size =3D strlen(param.string);
> > > >
> > > > +           value_str =3D param.string;
> > > >
> > > >             break;
> > > >
> > > >     case FSCONFIG_SET_BINARY:
> > > >             param.type =3D fs_value_is_blob;
> > > >
> > > > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >                     ret =3D PTR_ERR(param.blob);
> > > >                     goto out_key;
> > > >
> > > >             }
> > > >
> > > > +           value_str =3D "<binary>";
> > >
> > > Is there a reason why we're not logging the binary data?  We might wa=
nt
> > > to impose a size limit to truncate the logged data (although we have
> > > provisions to log rather large binary chunks), but I don't see a reas=
on
> > > why we couldn't log the binary data as a hex string.
> >
> > I did a search for any user of this. There are no known consumers. Last
> > February, fsparam_blob() / fs_param_is_blob parser support was removed.=
 That
> > means we don't really have a use case. If, for example, someone decided=
 to
> > use this API to insert a private key used for decryption or something, =
we
> > probably don't want that in logs. So, without an actual use case, it's =
hard
> > to say if logging this would be a liability or something needed. But ye=
s, it
> > could be done with the hex string encoding if required.
>
> Let's just log the binary data.

Good. I'll be sending a new version shortly. Thank you all!

>
> --
> paul-moore.com
>

-Ricardo

