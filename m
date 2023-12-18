Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F82740A3
	for <audit@vger.kernel.org>; Mon, 18 Dec 2023 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GrgpJDbY"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so2354558276.0
        for <audit@vger.kernel.org>; Mon, 18 Dec 2023 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702937265; x=1703542065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUcm3hZeA1tHXg/5cRtV9HHOwlOpMuYbkhoBDL9h828=;
        b=GrgpJDbYIYo1V8GJEq/5eA1h/hhVozyswxtyjCdcIrJzW2GulIw+YqwKvXtS/KYrdo
         rYou8TczpGjH/acvjzdmNTGf2c5tC2vI5iS57ET6WlxBqq0ToVtt9ykGvEAhv8d9uMGy
         JaVkvTwLgBgIXeGz5H8nKhGRUCvlHudrQkVB6p3swYLQ7lBS2FpEnxqHohDNdEAjskCs
         ql0H6l2lKJgKYNVNnynYCagcAO/oNYUJ9e3N5atSfKIWOpjB1iqiWh5ZM4uAulC/0nht
         UcAWNoMJtfKSuWf6EaO2kDnnCUP10LZy6IHxuZ0eC3JXfpLcwfxptDxalOYcThyT2cej
         BrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937265; x=1703542065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUcm3hZeA1tHXg/5cRtV9HHOwlOpMuYbkhoBDL9h828=;
        b=M9Iw4CPURM5Sce9ApHcq8Zax/hSNuPP9ztdgMGpjldPJfdF6T9iX4GAouExx1IjnjA
         IGwaU9aX3EuVIupX7lTN9xXMoZ9F3bfrYON9cChtDUemZW1x1YbqUr5oi8ZAhTDDTDdE
         xH8PjfKychamK0v9kn3j3p4HvlPruuugjWqDC82gGKLSEykWDL0h1IU9duyIFaGZwWkl
         dHhwyLXrO9ixkAyxjIEbNBdE/5tsYzPKnFWsAXrBh1Lvdd5AbIwh9ugWAqgKaCNOOLOb
         9ympWaRvpOyPUBsFFnlATotkw+TdEmH43KV1zZ4YMyNojvl2oqCnIcnZpscCOlAnemXW
         PkZQ==
X-Gm-Message-State: AOJu0Ywr/ryOUkc2fgY9StWalEtue4WKMml+BmoIzc/FZdSWV2FNRrnh
	Geab2eDejtQHvWXTK1iuAsf9nWBuV4s1SVKH8Tqx/9l2oB1dXig=
X-Google-Smtp-Source: AGHT+IGTl8OE1POTeJXRuA+3fh9msHUUqEyQJVeM/QK3tQOePZBmI62huK7fh1TIsMkfbN2am/5Zk/rjrlWegpXeZfs=
X-Received: by 2002:a25:9983:0:b0:dbd:2399:1411 with SMTP id
 p3-20020a259983000000b00dbd23991411mr1287701ybo.66.1702937265304; Mon, 18 Dec
 2023 14:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-2-haakon.bugge@oracle.com> <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
 <738EAB12-E8FF-49E9-BD92-4E3630AFDB17@oracle.com>
In-Reply-To: <738EAB12-E8FF-49E9-BD92-4E3630AFDB17@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 17:07:34 -0500
Message-ID: <CAHC9VhSZ6cZ32f5z_aLkpSbSnpeFe53+NHNXfjyJzpOZ3x7mFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: Vary struct audit_entry alignment
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:25=E2=80=AFAM Haakon Bugge <haakon.bugge@oracle.=
com> wrote:
> > On 14 Dec 2023, at 00:54, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Two things:
> >
> > 1. If we are going to create a kmem_cache pool we shouldn't create it
> > here, it should be in its own audit_filter_init() function which is
> > called from audit_init().
>
> Understood. Will fix.
>
> > 2. I'm not sure it makes a lot of sense to create a kmem_cache pool
> > for audit filter entries, especially given the modest performance
> > gains.  Is there not some way to request cacheline alignment with
> > kmalloc() or similar?
>
> The problem with today's kzmalloc() is lack of entropy on the lower order=
 address bits, because the audit filter entries are aligned on a 512B bound=
ary. IOW, they are too much aligned. The increased entropy is exactly what =
we get from using a kmem_cache which yields more L1D cache sets to be used.
>
> Although the performance gain is modest, the reduction in L1D cache misse=
s is substantial and that will improve performance on most archs that emplo=
y a virtually indexed L1D cache. And, this commit acts as a prerequisite to=
 avoid high variability in performance gain from the second commit in this =
series.

My hesitation of using a kmem_cache object here remains, given the
relatively limited and static filter rule configuration I would rather
use a k*malloc() based approach.

--=20
paul-moore.com
