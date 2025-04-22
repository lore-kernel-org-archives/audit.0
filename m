Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877928153C
	for <audit@vger.kernel.org>; Tue, 22 Apr 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339415; cv=none; b=c3ZUrIhB/0VKxb7fqXDqsbfKCuIPJYp6uRBNEEvwAbnTr8GbFTP3U6Wo3CJ4lyrBoa1KN7FEef+BAZVK2ac4iaEmaG+HcbL/OdAk+mX2LRJui66J8ipEyGTB3n4Qbm3ThGIqQVkZ0wuDfzyUSzyyIvCIQ66p9dxHgrw6CIAb/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339415; c=relaxed/simple;
	bh=qHub41/86u9WEWcM1Mg22cJ6Zhr0Fexc5QzjsIThwPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkRI6ow+OAOjIySnV/nXqIReNY6mbnTQp7cgu7+CU8p8dAeOnhFlHarqCIJ9r0K6lYRRtn6M/7jf2VqisRNZZkUZYbTgahxCr9BUvx6wyndJs+AXJfjfbqs5yAlz3rsNYAyjECka2KIhO4w6NrCletJQXorBs5l+EtYRBUpHQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b7+I0bwy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b7+I0bwy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70811611315so6919797b3.1
        for <audit@vger.kernel.org>; Tue, 22 Apr 2025 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745339413; x=1745944213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqKEbNLGhzwV9XEBdGBE6+HUfiIb/xIBVlRNIZDoITo=;
        b=b7+I0bwyl8jcr+29KLfzHBM+aT64dMM3tc8M9mILCm4UcHXW1iMQzva70UIdv2H4Vb
         0LQNs40lOtD93ddir8RMZXG9FDcwN2o5Rx0pGnmjSD2D2ZimKVN7VPNpdr/liWRPu93U
         vJHyEZw6BX3TP+bWM1F3zxDgxD0qhkxi9eDUCnA6dunU8iVwMK9IL4oNNClUje5FamV4
         j+OORHD9GyshjBBvmyTqh8iY7mqSV1xjS0bsdHYhGmtj0WD+w3ihmf1V9O8eMHkczmjv
         p/SNnod4xkWdiQzGoh/EW/Kc4vP6SOQOzPtKDBkvYeTkuVh7kPywXcsdbkZN/zA+hLe4
         /DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339413; x=1745944213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqKEbNLGhzwV9XEBdGBE6+HUfiIb/xIBVlRNIZDoITo=;
        b=xHX6hbjJjKRXPTu0WWBPN8jUxMR7cSckIMkh49Fr/RWiqQHynHCRjRnDKdpdBEmmGn
         BnPKZyZqQbzW3Vcb5t4/laRU0DxtV/zHdi0iRBs2MMk5vPdTWY/xIoMFV4ulXJJbfz6B
         r0tuNtOkXit2wMwC5NoXKX+A2b38XgtLa2cFruy2OqJfQDU2il/2ii4IpdH+vCbROduv
         Blnaywg3c9QB2B7OFaexoIKBbsXcz90ZsInYoODw5D9/QYIe7G7J63OlVSOZfjYG5f3K
         dIQEO1YrHXzEJ8Kj25/23VHovSmqv6VoTY0IKC8uYPRqJFDXmrHCN4hamUgp4MTVeObx
         Am8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAaJ8pYOnfyvLOAeBb6y6QTiDnLgIYZe1cztWBYcjoVGSlBDl+jc67vsBfx/ZjBc85LmTfeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/WGZjimPEluglSUzAgs/vqFXuhQMztXlEpd3ekYjGuCTJNgQ
	Jbfjwglp+mL9zYjoVPtFyaiIeMZdmz2SoxEl9kfHFti1rbsyoBAQ14QKQcW0xfPj/EHRxA1mrQ3
	k2xvrrtKelY12qSrnyMiQXrJ3Vb2vpHb8sdAJ
X-Gm-Gg: ASbGncu0ftg7Bnl4oYV6ZiWwImFmhubeAwrwRC5Ao5buIAojs3wgV6YSp8CPLFN8K99
	ajq7kCYh5dgmDpIpkV93P2hTDq7HAT8WR17upzN54UN1jXFQCRbcDgpFLyJD+3IxFfIA8srBZ8o
	owFQWJQZ5MtcUAoxkQQnIQ5w==
X-Google-Smtp-Source: AGHT+IFV+Fl/M43pQ5C4mwjWmtEQVn4Q/KMbbjlHzVR5N2ztbMJY3fq7yDfY3/zkm5NX/tHqeSoyi5mBSi4LDPN1oo0=
X-Received: by 2002:a05:690c:7209:b0:6fe:c75a:4309 with SMTP id
 00721157ae682-706cce44e78mr218124297b3.38.1745339412762; Tue, 22 Apr 2025
 09:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
 <92e9622d6dd1bd3e59a36269275aa1fe@paul-moore.com> <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
In-Reply-To: <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Apr 2025 12:30:01 -0400
X-Gm-Features: ATxdqUEOFVSyq2d1v00GrCvVvc8dU83XbSJlmQt5G4oKG4Csn74EEhOQKDYLcUk
Message-ID: <CAHC9VhRhr0GMQB59DZ4-xJ788yEgAsUMBLNdYFL2UxioBUPhGQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure case
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:37=E2=80=AFAM Richard Guy Briggs <rgb@redhat.com=
> wrote:
> On 2025-04-11 14:23, Paul Moore wrote:
> > On Mar 17, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 1fb9ad289a6f..efa62ace1b23 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, =
const char __user *uargs,
> > >
> > >     module_allocated =3D true;
> > >
> > > -   audit_log_kern_module(mod->name);
> > > +   audit_log_kern_module(info->name);
> > >
> > >     /* Reserve our place in the list. */
> > >     err =3D add_unformed_module(mod);
> > > @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info,=
 const char __user *uargs,
> > >      * failures once the proper module was allocated and
> > >      * before that.
> > >      */
> > > -   if (!module_allocated)
> > > +   if (!module_allocated) {
> > > +           audit_log_kern_module(info->name ? info->name : "(unavail=
able)");
> >
> > In keeping with audit tradition, wouldn't we want this to be "?" instea=
d
> > of "(unavailable)"?

Any comment on the above?  This is more important than the non-public link =
...

> > >             mod_stat_bump_becoming(info, flags);
> > > +   }
> > >     free_copy(info, flags);
> > >     return err;
> > >  }
> > > --
> > > 2.43.5

--=20
paul-moore.com
