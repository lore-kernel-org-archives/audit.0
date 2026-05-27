Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F5346766
	for <audit@vger.kernel.org>; Wed, 27 May 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885852; cv=none; b=IAMHiiQohZVGgzjlOBWNT9rysV3d5dld5dtDBi3Z0ILQufxyTRgiyn9Uk1kmFeN6MGzdLLoU8ZLr+aqvbeEC+mybP82LbBPw2japu+wg7OAvh9jvoIpDYejb7BuyF8IYsygksR5Mg6VEAaK+pZRSD+ZLScEl4pNtzV7PgE2vPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885852; c=relaxed/simple;
	bh=GDkb0qNWZl2J9osNXb92MaC+7C2p6Yl1WbfmEG7MhVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgzdHYfip4U6eka0uGIetphO6tM8E1LZNSSozDygs4WUYRNek8t6vSiJzW8AvwmYpHVYII2iBGZC6jkYOGHWn8vhYZPIPiGR/lVCFu/RHgb9F07Vn4JxllvVCYYJurWrU9K/XMkFUozmZsJF8Uf2V9FeX9tgmv8PNteac6fn3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNTX3exX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNTX3exX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779885849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wN+XcSZH+JG9OSdWYBMf7L0BMqEqeoiKPDa5zE+FwZA=;
	b=hNTX3exX8eX5NwP6nx72FoTSM0Ivds24E5TCyRMCCq5s70INrZY2vaRfFqPpocHa0eHKDg
	7QH8OOBYzFzncnCRj8ocnYH6EbuQ5c+CJOwOqqjECXmXzTgu9kMU6blIAa20SeBJBVJ7fh
	xcqTKsx5ZfaKwfgckvN4JrLpO9AZyRs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-skCoSGDDNlanuvevGNNNRQ-1; Wed, 27 May 2026 08:44:08 -0400
X-MC-Unique: skCoSGDDNlanuvevGNNNRQ-1
X-Mimecast-MFC-AGG-ID: skCoSGDDNlanuvevGNNNRQ_1779885847
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd81e585e5fso1064912066b.1
        for <audit@vger.kernel.org>; Wed, 27 May 2026 05:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885847; x=1780490647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wN+XcSZH+JG9OSdWYBMf7L0BMqEqeoiKPDa5zE+FwZA=;
        b=qrQ/nBjWF7EAV6MVb35sMmXb5SKoMGAjJdOFEZnQV1L1Wslc9XMhD8jizEIFBXQNqp
         uGBgxcDsXg5n6Mfnl7D04fDw0Gpnf5MSv/MBEBIS6dvye06+BW/IvI7uStFJZQ6B1Ikz
         SnECME3NZtuIXjlkCrDYbH79UP20+IFm0zPNMY3QAM4DkgoZWp6DP6WfGZfky5N2yatd
         MMYCCao0zbkq63PuHcsiClK33vFSNWZicl2F/afZa8lP2aGN2FwtYhZbCWb0MQMIAoEc
         lRrDg6D7vuPeph6wpIsam9MzvQ5/ot5KOLPXI+kml2T13ZEylOjsD2YFXh2G0QBb1frX
         xVgA==
X-Gm-Message-State: AOJu0Yx54Nyr/zFLhnntbmyNo0psmnqrwr/FyjWdgq3NxrXW8Krl2ngA
	ya8NNZ4m4bldfr8vSL7uoK14Um7ZsR87lVbFG6uDV3uN1SSFyn2ew21pmmVKUMsI8JdhzIp7BPH
	lHowRE0D2frBNLGyaqzRWJ+9qrVKwyD/V5N0cdmVeL7OeQeNv+F62EpWhIRsODXgojShhAUG0ox
	zdueaxhH2ua9Ip8axAodg+s4IJfnpL4fMZ8sImqFDgkQ==
X-Gm-Gg: Acq92OF6CJZZLfSOcuGENP81NREVH03hzzekmYxQ4ylFbjv9g3mm6fTZwlDG8R1izBO
	Xa0rjAyxZz7iVZN762Rp5CkZG4ll3bmd1yasKVZ3csaOdesx1AbbxNIug7Sb/Lzt32Tq2sz3Wkx
	zZKRWX8qjIf6MNYoh9B4XDpWg4MHnnU+vR2h/mI2DVcof4LOeDJaO1Iw3sGjZXX038dBXYZmVWj
	2s/ePTPgAGZo0LwwgBoTste2rjLzQNFnee0HB5lLspZdLczCF4k7jFlhPq+hiU16lr+iXCpAvPN
	4/B2wqLhXsgQZB2rNByrGVVN
X-Received: by 2002:a17:906:8446:b0:bc6:5f97:8f90 with SMTP id a640c23a62f3a-bdd25136d7dmr1108029466b.3.1779885847112;
        Wed, 27 May 2026 05:44:07 -0700 (PDT)
X-Received: by 2002:a17:906:8446:b0:bc6:5f97:8f90 with SMTP id
 a640c23a62f3a-bdd25136d7dmr1108028366b.3.1779885846722; Wed, 27 May 2026
 05:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514151320.1939290-1-rrobaina@redhat.com> <96e71b4f0f9685a990fe20d7c49fd669@paul-moore.com>
In-Reply-To: <96e71b4f0f9685a990fe20d7c49fd669@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 09:43:54 -0300
X-Gm-Features: AVHnY4LcpQkSAxx6Atb4YqWPni2DqY1R7you8tv3EXm94N_ksW-JLu9qsAbvwUM
Message-ID: <CAABTaaB=bMB3L6tZi=27OEYJW=ekrO8CTM7-5baMs4BgNQytqQ@mail.gmail.com>
Subject: Re: [PATCH] audit: use 'unsigned int' instead of 'unsigned'
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3TwgegaxtzS1IVfvSEZOoy9fZDParujTdRVb1lc7e-c_1779885847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Address checkpatch.pl warning below, across the audit subsystem:
> >
> >   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> >
> > Minor cleanup, no functional changes.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/audit.h      |  4 ++--
> >  include/linux/audit_arch.h | 12 ++++++------
> >  kernel/audit.c             |  2 +-
> >  kernel/audit.h             |  2 +-
> >  kernel/audit_tree.c        |  2 +-
> >  kernel/audit_watch.c       |  2 +-
> >  kernel/auditfilter.c       |  8 ++++----
> >  kernel/auditsc.c           |  2 +-
> >  lib/compat_audit.c         | 12 ++++++------
> >  9 files changed, 23 insertions(+), 23 deletions(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!

