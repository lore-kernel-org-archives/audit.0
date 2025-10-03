Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C51E515
	for <audit@vger.kernel.org>; Fri,  3 Oct 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506198; cv=none; b=V8WQLek8oBfk9QJywDiWewIfjUx/m+37XIj6oZb4WBKV2RVMIpblX6f/4UMVGQQzXdnBfPGbVTnBKe9FOjpYHElAwxm9w3v491T5rku/B2a/Jpns50wBul3TBbJfRj6e4fhS5mDWo8SLnE5uvx/nfDpT8IPfji1s7h9cq1x1snI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506198; c=relaxed/simple;
	bh=zPkm8y04zTinG2pzfsV7xNelpFQ9Iy5tfKVIN/TNtTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix9HWdm3i4VaFAvk0rJUkCQkMm5b08A6uFDdGlh0ygCip3eTAQ7wTguN6keJ0KlZcfBT5lYtAyDnAmo3+eSBDW/qOqO8H5Ie+nJFuJnNts9fs57d/kWccTjGvyeILBG/dyXsNqyw6LK9lN1Tv62msL2OlBHsE1liI48hfx9ZsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTkxsBb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTkxsBb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759506195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRGVb+/SviQn0hYEk57O03Mjd4zlMdKn1zCsmQKmvak=;
	b=CTkxsBb5suA0oQfEnMG1bwUKYsNSh0aJx2KCVSyYBhRPZFgU2nYOXwxARzzkUqD2vTFX3d
	eAGn7XvI1i2isi5vTHjoDd4lpwLTUkqffqRfRAimmmDwN5rD5AlnhMggOziUBsclqu4NJ8
	eeCKDfbnLfM/jV8r7tl+Wf+SK449b+Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Hu-mwjkdNjOtruiGiS2VNg-1; Fri, 03 Oct 2025 11:43:14 -0400
X-MC-Unique: Hu-mwjkdNjOtruiGiS2VNg-1
X-Mimecast-MFC-AGG-ID: Hu-mwjkdNjOtruiGiS2VNg_1759506193
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b48867c4fe4so191994466b.0
        for <audit@vger.kernel.org>; Fri, 03 Oct 2025 08:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506193; x=1760110993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRGVb+/SviQn0hYEk57O03Mjd4zlMdKn1zCsmQKmvak=;
        b=AatrcuDgxOX3Zkno2xmwrEoCXYdlyJhi4dE6hxn4FQ5daPXUeQsSfZ7ax5UCtGLvk+
         tzLQSoFhbsKfTKRCn7ItY2CC+qQpSdQW+/DyShHcZ0csDIpSyenk50KqxYrUTzoc2Lyo
         FPZX8lPDIDxjFuT28JiBDwLkCLx+/sdyiA9mONfcXYKd3hdSf85SzmKPG4GC3ngGPjyr
         QenDrvz/wfi6AjQubHBKWFGWMzoH574cc36xhb8aWAFA7ZJBk9CeoKRoBm10/ZZC4wEN
         CsHpj7709oFqTVCjiBOOpA4juToT0vJfqLpwvuqQ8KE6RPABkMOdF+VE1HJddRJEuuN6
         tbxQ==
X-Gm-Message-State: AOJu0YwQKPb495+D0F9764gXiAKkYDBWsdmqhFPfnGT1dBpBh7+/9fn4
	4w6QvyMBUB++6hSVFWbm/ayW7ajpq+O49tHLYPBsBCI+Jzt5+tWlCUEyC09JZvoO06CXhvt75Me
	BRZXca7JK8B0IC9rb0q+pu9ehJsqXjBV9yMSd2RJeKWpg1Sy25LXtbH5CCK7ghZsEsMXvU86nMp
	F4L0yKFVuO5ndlvBGy18DYxUEo8FwUwMs=
X-Gm-Gg: ASbGnctMj8cEIs0BWYD2dYDc4ITPeY4vCohNlroB6xHTg3PRbfjeG2csn8AbxhKLWNc
	FWe5YZH0onAofeo80C6sm5UBN5CNotgnn3cH4ptDgQSP5utLIX+HY+ApL9eAypx4KLCD97jCSVc
	fpcvja8+NYsQqlQZmFsPSE9EJnBA==
X-Received: by 2002:a17:907:3d04:b0:b3e:c99b:c776 with SMTP id a640c23a62f3a-b49c1976ff9mr388877766b.15.1759506193415;
        Fri, 03 Oct 2025 08:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/hB+bqBiXabsgzDLKI0SAwaSMZqQiCYneHNLcJLgmVXqHx4mWWC5CZ27AQOqUH8EWfNPetcIXZgWFyZvMJv0=
X-Received: by 2002:a17:907:3d04:b0:b3e:c99b:c776 with SMTP id
 a640c23a62f3a-b49c1976ff9mr388875666b.15.1759506193040; Fri, 03 Oct 2025
 08:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
In-Reply-To: <aNfAKjRGXNUoSxQV@strlen.de>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 3 Oct 2025 12:43:01 -0300
X-Gm-Features: AS18NWDHnuZbdmtwFCze6OYCQYsA8lH1vWwBn3WSoJ2s7xMRYWiXLVRdHRZKXSM
Message-ID: <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Florian Westphal <fw@strlen.de>, paul@paul-moore.com
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQMxn1ZZUeYZjlH8wgg8nZIqTh5DJqAh1yBGADZ51eE_1759506193
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Ricardo Robaina <rrobaina@redhat.com> wrote:
> > +     case IPPROTO_TCP:
> > +             audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D=
%hhu sport=3D%hu dport=3D%hu",
> > +                              &ih->saddr, &ih->daddr, ih->protocol,
> > +                              ntohs(tcp_hdr(skb)->source), ntohs(tcp_h=
dr(skb)->dest));
>
> You need to use skb_header_pointer() like elsewhere in netfilter to
> access the transport protocol header.
>
> You can have a look at nf_log_dump_tcp_header() in nf_log_syslog.c for
> a template.
>
> Also please have a look at net/netfilter/nft_log.c, in particular
> nft_log_eval_audit(): xt_AUDIT and nft audit should be kept in sync wrt.
> their formatting.
>
Thanks for reviewing this patch, Florian!
I=E2=80=99ll work on a newer version addressing your suggestions.

> Maybe Paul would be open to adding something like audit_log_packet() to
> kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> common helper.
>
It sounds like a good idea to me. What do you think, Paul?

