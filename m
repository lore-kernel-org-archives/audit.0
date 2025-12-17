Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011142D8DDF
	for <audit@vger.kernel.org>; Wed, 17 Dec 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971611; cv=none; b=u2IBu33R3hLJ3thDOHfTk1rw/Wsz4YWBQ8JT771iw6tlJWkA2rGspjyrLlRZLdQuAQmYS/Sv/BiOW8ZhKCJeCa5clu8x6kljrRUA3NKZoIb2F45lMl3I8zYvwl42hgiwJXglUqN675MH58eH4gcNlXjC0D9X4KqmijRQzkAeiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971611; c=relaxed/simple;
	bh=1U/ikegZolI19iSMBScb8qYGCyxWSZzi9ToYMoe2yjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riVZCKLKC+gjQTM2f9uT0IGGawKI5FMqhpYEMq5d5UA+6PXL8iGJXd9fr/tGVKHkbmY7CcmQZFOluDEZH3DWFQChvzx6fhHHFcRSbG4LqTjwpg+tK0T/Fp4vyKpvSzjYzydlgLLphKCTZhzY6Rv+0mWqpps5cI2IYQv9zzusdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma+MEC1f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma+MEC1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765971608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nx9KS1++6SSB7P8E1Ya6NVI77CW43nTZBnj1FAdXZIo=;
	b=Ma+MEC1fiY9bClT6Ieu3d54ueQs0MGozQcZdmkP/aciU9KvMdl953VmGQwPbdwGxEYfuju
	zYN57CqPqA2eKSv5kdB4fGJAkcl8DaKBkPGLb5PYdPnD3vYokdJSrH+jWhEJs5htp5lu7Q
	2F3DMennXf7dmBtpXVyrx1vIW3OB0Wk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-1NaGrwt_MBuPWbrKerVJNQ-1; Wed, 17 Dec 2025 06:40:07 -0500
X-MC-Unique: 1NaGrwt_MBuPWbrKerVJNQ-1
X-Mimecast-MFC-AGG-ID: 1NaGrwt_MBuPWbrKerVJNQ_1765971606
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b800ee1a176so67813466b.1
        for <audit@vger.kernel.org>; Wed, 17 Dec 2025 03:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765971606; x=1766576406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nx9KS1++6SSB7P8E1Ya6NVI77CW43nTZBnj1FAdXZIo=;
        b=oUpVMRnHsW98OyONen2k2XpV2/hgW4Ww4QuzrcXPAvS0LeXUs4YXLXYl0LDP16uaGJ
         xAv0l/j1l01LAAfRLubQwzvX71twUsQIsFTrzZOOH2IGfeK6GlwMFhxz7rNT3VyQQA7f
         AYL8R0elcPxIdrIHbHG4BKYKFWH04ZPrdkNUfg1++JJ174FkhXv7LI21oTAVj8AAiN/D
         UIfbcFBrpZJxurgeBDcwLg+5nn+cFI5adX7JGPeCyHU+3tdxpQKPtKeKl/KI1ctc4uBL
         VwVJjCRNnw3FkWmuL78JUBS94G5vQZBuLQ1OXpYliX0znBZIJOa6krIzUiRbfCIVLTke
         ndRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZuHl7xr7nQOkNRgzEIVctZUe1w3VY5nPNdAd5TCpqQHdxwIXoPq2O4ahQ/YYqY1VfzpChhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/AORAuIv9VuVihJIrgtUgYD/RJA9t3L3iOB3omrtAebMAm1Z
	PKhKeg71yRqBkfz6wntKDNn2tI/EHYa9Ogy8uIHvSAW5GBIbdJyYWnbzUikU9ozWj6Pnl5uwFvB
	rxSZdgY4vN8Ck8fURR6qPMc5TPJrMs5cvLZteiMPHIimBv55G0JIg6VHwS86Pmys+ThbpDsDoP+
	wVDx0K4Wc+fAX23spDetI3LNcmDjQVoKU=
X-Gm-Gg: AY/fxX7bd+aVn2DKjdzYF+b7I2SR3gXcHmkGO/DbLjXIaeCwT1yQtbL11YTR6cte9ZM
	0QrYv3CHYzgn+Vr5m6HKPR30i27bsTLQJyaEQU4rkJh8yG9m+H9E37EEDyXM6yPFRiLJBEdhzML
	0TKgIWdp/VjkC+JL7hb2MERSk7gDfWr7FyccKzt6qk1eNF1ykyVuejgsugFeJTbyVn0n2y27SnX
	0vhcN2sVNctUAVVjHvVw+vL9Q==
X-Received: by 2002:a17:906:599f:b0:b80:1a97:64e4 with SMTP id a640c23a62f3a-b801a976d97mr15181966b.39.1765971606163;
        Wed, 17 Dec 2025 03:40:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQgvZFBLTmM5DCp1T/Ugk2vXHsXNq0G13zpH5cgH6CF9AJZTB72OD0VvTOytodrDludyMUO4HVickRiaZUuGE=
X-Received: by 2002:a17:906:599f:b0:b80:1a97:64e4 with SMTP id
 a640c23a62f3a-b801a976d97mr15178866b.39.1765971605695; Wed, 17 Dec 2025
 03:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763122537.git.rrobaina@redhat.com> <CAHC9VhR5_wHWpSXVapFhswqnUw1x0M3SCSyD76Kad8AMi8xEeA@mail.gmail.com>
 <CAHC9VhQtYSpw15JM_1Yp77E1nBCuR5xeiE_TzTVuZ2_zr2W7wQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQtYSpw15JM_1Yp77E1nBCuR5xeiE_TzTVuZ2_zr2W7wQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 17 Dec 2025 08:39:54 -0300
X-Gm-Features: AQt7F2qMl3QTmA3xsM1Taw_PuGZxuhOIdPpD10MJZzwhSr-g1vsDqMI_lT_XZX8
Message-ID: <CAABTaaDyFA+J7HLZhK9=uO_jaE=BU4pcWFa-4mOaa-u0NymgoA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] audit: improve NETFILTER_PKT records
To: Paul Moore <paul@paul-moore.com>
Cc: fw@strlen.de, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h6d4HT9XDO85pTFnvy1RioxBliebjUGy-pH-OmthHTY_1765971606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Dec 15, 2025 at 9:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Nov 14, 2025 at 7:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > >
> > > Currently, NETFILTER_PKT records lack source and destination
> > > port information, which is often valuable for troubleshooting.
> > > This patch series adds ports numbers, to NETFILTER_PKT records.
> > >
> > > The first patch refactors netfilter-related code, by moving
> > > duplicated code to audit.c, by creating audit_log_nf_skb()
> > > helper function.
> > > The second one, improves the NETFILTER_PKT records, by
> > > including source and destination ports for protocols of
> > > interest.
> > >
> > > Ricardo Robaina (2):
> > >   audit: add audit_log_nf_skb helper function
> > >   audit: include source and destination ports to NETFILTER_PKT
> > >
> > >  include/linux/audit.h    |   8 ++
> > >  kernel/audit.c           | 159 +++++++++++++++++++++++++++++++++++++=
++
> > >  net/netfilter/nft_log.c  |  58 +-------------
> > >  net/netfilter/xt_AUDIT.c |  58 +-------------
> > >  4 files changed, 169 insertions(+), 114 deletions(-)
> >
> > Thanks Ricardo, both patches look good to me, I'm going to merge them
> > into audit/dev-staging just to get some very basic testing, but if I
> > can get an ACK from Florian on the patchset I'll go ahead and move the
> > patches over to audit/dev (feeds into linux-next and the next merge
> > window).
>
> I just moved these patches in audit/dev with Florian's ACK.  Thanks every=
one!
>
> --
> paul-moore.com
>

I'm happy to hear it. Thanks, Paul and Florian!

