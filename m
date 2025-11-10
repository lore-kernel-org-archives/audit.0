Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1930C348
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777855; cv=none; b=I2URYEOnLBF8FkeM4My+89zCUeebihmfhPvFA/vi9aZQ9bcGVDULh0Soyh43Wp0IibcvR1K3cr83CtDbQx1Ri9CTX6DEbykalukbcO+R55eX8XQCNLgU9GZJ0vHvZhaPk/8qdGnipObTwONj/DZ1dtM/C0lShWLVCD7K7lUjQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777855; c=relaxed/simple;
	bh=W8R70bvJHJO7FmVx6tTMUO4eH6oa0bt18eDgp+HCOB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myPNES1nB7uwk2dQs53SiQVx69NNIVGjA9gqmXEwgxNJbyU9MfEm0MKz3PDNTCq+VVOMINSUEGTP7WOEP2EbUMpiPYNMc/iMqeD9wADJDIQ6tzPrXq4pLNo25ZzCT1AlrEEHYs+Tyn4wD3BSU4XNYuM8fy/o7n7ryjxg0QH67SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3OhgrvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3OhgrvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762777852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZzwD8CAgHHIN7QER1FgOYrseElyIf9KwDMPjRpoiRw=;
	b=X3OhgrvCwka9WRXqvRSr4kEqBPZIjKVIFu9C4O5g/IPB35YnGtmdLzYSmmvureXEoxz+O1
	gfdjcm+m4QaANq/tUWK3to//PlZ1IRazTSTSwBY2aEc9Vv8qQZOyzJRXZm5Kx0siTybNF6
	phYw8NUQHxKT4hzEC/vrHorIOmp1PBE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-wO5OeyRxNlm55vOOsllr4w-1; Mon, 10 Nov 2025 07:30:51 -0500
X-MC-Unique: wO5OeyRxNlm55vOOsllr4w-1
X-Mimecast-MFC-AGG-ID: wO5OeyRxNlm55vOOsllr4w_1762777850
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b727f2fca77so309700266b.3
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 04:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777850; x=1763382650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZzwD8CAgHHIN7QER1FgOYrseElyIf9KwDMPjRpoiRw=;
        b=cofxRDfV5x5WHpJovLJ+OAO9p7Vu6e/JdEHns4+PWgOYNPWEiW8QroCmpKd3SsunWO
         EPtot0cFTBzH4kVFmUeuL3dG0zbHZDsaV4IZ/mhyARG9egg+Cd2Xf6fB9Qyscu2UDz32
         l7XqbBWiSaJJQRc/u5Nl0Qo1Cz4e18w/oY1crmzoyz0CR9s6oOTKZGsJduH1WQtfPtY2
         GN/NE1CXA0OflOPDhuPQvGa7DR3kH32Spw/ZRdrxDpdeNlsLQmYsOVz44ZEFNpbjjr1f
         FHNFd5jsKY8PhO66LAcU07IU1uQCt23jm8vua+hSyxAAyNu86hLRwsLEUtidxrpZWA9q
         tTMg==
X-Gm-Message-State: AOJu0YzY6WnXIlEV/n7/xbbTlmNVHto2N5co4Zcg+xg0YkENx61m9DOO
	QVicgmIfYVnjX0mTI/7WpDm8lhYvFGFT85c7dj8ix8OSgpIXLUwOdEWczevMDbB2y0+KnsUSAW8
	oG4298Krdaen/nyov96uz0ca1enB25bXRSvsDMkbgFTaIC4vAmWhoL0msgsy1pUF0I3N580xUy9
	+/AEVQwIudqm2ozWHLZwKNnH9sY2wz4uQ=
X-Gm-Gg: ASbGnct4KQHePYTPjaS9+MdMn0EVf738hmkA0zCKMnwQX2Pp5sXmOySjsMfOmkTsx9Z
	zWjhzRP7d4QHYxEMUOQDICkkd0vNvjxqT7tcZsjRRof9cLDBmobQ5nT/Wui1LFr/26cRvBBABSj
	3t/9RFL+UU3iq1ywe3a29/ac3iv0qUxuEtgqAhAsw6bWA4YSGM8qS5F2zviLkf2AIbwORdETcPV
	vOLbDWiK0irB4Yo
X-Received: by 2002:a17:907:6ea2:b0:b71:df18:9fd6 with SMTP id a640c23a62f3a-b72e04e2f9fmr796238566b.50.1762777850315;
        Mon, 10 Nov 2025 04:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW79YXbAPd7W8RNSghkp1pkzH62zBSAQuhhn9/CPDDGq4jrM89brzjtSfduo2ZuurNAnWCmxoqBt5xe4Hhbow=
X-Received: by 2002:a17:907:6ea2:b0:b71:df18:9fd6 with SMTP id
 a640c23a62f3a-b72e04e2f9fmr796233966b.50.1762777849827; Mon, 10 Nov 2025
 04:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>
 <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
In-Reply-To: <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Nov 2025 09:30:38 -0300
X-Gm-Features: AWmQ_bkxQQWcfjx8r_dF3delGcKOWNjcP730Sx0eYw6APmUwazLTOE5cgyXbh34
Message-ID: <CAABTaaCgFUUNAcrPM5FdskoACcp833kfpM7xv0JNZ0+ZxG+v_g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BNEnGwRVUr4gHDH2PmKTuHFnIYCkXJydciiFKnszBGw_1762777850
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > NETFILTER_PKT records show both source and destination
> > addresses, in addition to the associated networking protocol.
> > However, it lacks the ports information, which is often
> > valuable for troubleshooting.
> >
> > This patch adds both source and destination port numbers,
> > 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> > SCTP-related NETFILTER_PKT records.
> >
> >  $ TESTS=3D"netfilter_pkt" make -e test &> /dev/null
> >  $ ausearch -i -ts recent |grep NETFILTER_PKT
> >  type=3DNETFILTER_PKT ... proto=3Dicmp
> >  type=3DNETFILTER_PKT ... proto=3Dipv6-icmp
> >  type=3DNETFILTER_PKT ... proto=3Dudp sport=3D46333 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dudp sport=3D35953 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dtcp sport=3D50314 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dtcp sport=3D57346 dport=3D42424
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/162
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Acked-by: Florian Westphal <fw@strlen.de>
> > ---
> >  kernel/audit.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 79 insertions(+), 4 deletions(-)
>
> This looks fine to me, although it may change a bit based on the
> discussion around patch 1/2.  However, two things I wanted to comment
> on in this patch:
>
> - Please try to stick to an 80 char line width for audit code.  There are
> obvious exceptions like printf-esque strings, etc. but the
> skb_header_pointer() calls in this patch could be easily split into
> multiple lines, each under 80 chars.
>

Thanks for the feedback! I'll make sure to follow this guideline from now o=
n.

> - This isn't a general comment, but in this particular case it would be
> nice to move the protocol header variables into their associated switch
> case (see what I did in patch 1/2).
>

Nice, thanks for the tip! I wasn't sure which style to use, so I
decided to use the classic one. However, I do prefer having the
protocol header variables within their associated switch case, too.

> --
> paul-moore.com
>

