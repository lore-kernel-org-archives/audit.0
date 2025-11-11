Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C232EAB61
	for <audit@vger.kernel.org>; Tue, 11 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859178; cv=none; b=NsH8nWen4bWxcPpdGKxZ1auABj/uvsC8x9LZPEojy7H8Gx664IvsFKXTOa2MKBYJ4qrTPoDpuAacP+iFaX8CX6+IPe/bNvdOq4N0QVln2TjgKMvlVDsWv9WnMTlMOjGO4AQpQEidfjvxB9GvIlOT1L+5hCj1Eue+75mhA5W0pwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859178; c=relaxed/simple;
	bh=wgdtMOgnIdauBeWDydYoY+O9WRpPfmsDE4Q2ko8WTUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZm8IYox6VK4uNKSjLv1njAwoUl509tpix9gkHJtLoIEHugDnp04BzkA2EW59KHiZnyJOQUXCe7EIxt7XQY2v8QEiOL5OFTqSxhDze0ijjtcy2b/T829sRtwdwqwud9GOv/U2CttEL/TuKfmtRvSj4Mn+Oz67hOCIY8a42XOLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhRG8HFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhRG8HFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762859175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbVFAUnTTBAQqYxAS+qt3Sk5mP5Wt8XB64j/zpUDE=;
	b=PhRG8HFroB6GPirs2SXZ37iLXipSyOs8In5E6vm13EDnOmwHMibCNY4EZMue8NdNbErTs3
	hq1h6nQBo7kjaijb5gEpTnz4cQ3bIyE+prqZtQYqWIJyNHTtnjkLBzMxCiaReAO7oLXUAH
	foAKcgICzQ5ZXmH7ycWSf+T42rzOz60=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-nd26juW5NzWDcZOZntJk7w-1; Tue, 11 Nov 2025 06:06:12 -0500
X-MC-Unique: nd26juW5NzWDcZOZntJk7w-1
X-Mimecast-MFC-AGG-ID: nd26juW5NzWDcZOZntJk7w_1762859171
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so70413266b.1
        for <audit@vger.kernel.org>; Tue, 11 Nov 2025 03:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859171; x=1763463971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GDbVFAUnTTBAQqYxAS+qt3Sk5mP5Wt8XB64j/zpUDE=;
        b=vwaO7GuNHPSlC+EfeKCQtXaroHPimflrBzgwWta/i7TG962B5P5Sqy8nuI9hrqtFRk
         1L9kpxHac0WSQgBWNsbKUwN80k9LQFg2INLpUosq6nbIki6BBikO/bzgxSi6mfS2P6gE
         9m0fFUTNt7YH20Cx2bB/qyiCtZpqHY9KrA8fW0Z7zb4pccGYWPPeaYzADVT1ccQARtGH
         3uOwJykBiJHiYct0jnshSNg77nz5iUYPrHVqKlNyWyb0YMVOPc9EbctX1IshDKlzG+kk
         XfqgcyZXqplAbLYQnWG1TSmHiMWHrVyJz7gTEwgLq0VN/jB5k9WlZpXRN0XMjUxtb4pP
         U73g==
X-Forwarded-Encrypted: i=1; AJvYcCX8/0C39VXSEPpi3vuE8IXDKEbrQeT48eMikqHIjgJBpb/dZJveTyr+pI89ZMwi1FGga45C8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJAUcQ6QMX+MJQJg0xHvFUYUPDdxN29UF+25nx0F/JB8S+7rH
	9KhDXyxQaf3a01gMwkr6I2tLDgTBswyAWQd46S94JFBFGyO8Lt35MADkmr8QO+cIKm+eIPPff/y
	T9RIC3iBwehLX1murmoSI6v15jlchybmv+hDKmwIN3XnyQ3suw8yUGP9yUg43Hmf/E+RNsx23lZ
	POrV9C9/28ItSF3VIkWrLQLur7eG2S1LM=
X-Gm-Gg: ASbGncvewGU9mj3vU0N7QIU0nPRHCUgfFUGO9SfdZBg7jPsO0kV3rP1P5bl57AufDz0
	dQb8H4p0gGWJkbKyIysSn1EKLbREqPumkLGMvfcDQSHfeUg8ls1z3mOnOE/fayp74/rb7BFynmz
	xUeW4PC5Klb0VSL0XQ0/AQk7AuDNP8JhkSxOaL2QzPEEJPpPXG5xp/K+JfJrlAYlkhTodFCYNf9
	t01vnxu0uwrYDid
X-Received: by 2002:a17:907:847:b0:b07:e258:4629 with SMTP id a640c23a62f3a-b731d592612mr365867366b.16.1762859170919;
        Tue, 11 Nov 2025 03:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00joUcH98KIScPdspMz6C7WmzE6y9BjmZMzMPi9/1/g0CWswqBDBalNWaO//kifqVOVeSio6hNYd8TE3PJWo=
X-Received: by 2002:a17:907:847:b0:b07:e258:4629 with SMTP id
 a640c23a62f3a-b731d592612mr365865466b.16.1762859170594; Tue, 11 Nov 2025
 03:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>
 <e92df5b09f0907f78bb07467b38d2330@paul-moore.com> <CAABTaaCVsFOmouRZED_DTMPy_EimSAsercz=8A3RLTUYnpvf_A@mail.gmail.com>
 <aRHd_WFBcyiL1Ufe@strlen.de>
In-Reply-To: <aRHd_WFBcyiL1Ufe@strlen.de>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 11 Nov 2025 08:05:59 -0300
X-Gm-Features: AWmQ_bms7BujCKPIYEHexBScB1G6ShV9xg4dnReCgV_Fb1MzdZWI32KI09CCb4A
Message-ID: <CAABTaaA7XKVcV8GdmdkKLP+9gfKpv5f4oJupVXzR6KEaOFS9cQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] audit: add audit_log_packet_ip4 and
 audit_log_packet_ip6 helper functions
To: Florian Westphal <fw@strlen.de>
Cc: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eparis@redhat.com, pablo@netfilter.org, 
	kadlec@netfilter.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZJJP2ntTTV72eg3uToKx6mzE7Qx0D93zqQV-NEZ4lxQ_1762859171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:43=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > +int audit_log_nft_skb(struct audit_buffer *ab,
> > > +                     struct sk_buff *skb, u8 nfproto)
> > Thanks for reviewing this patch, Paul.
> >
> > It makes sense to me. I'll work on a newer version addressing your sugg=
estions.
>
> Nit, but as you need to resend anyway, can you also make this
> 'const struct sk_buff *' ?
>
> Also, given this isn't nftables specific, I suggest
> audit_log_nf_skb, audit_log_netfilter_skb or some such instead.
>
> Thanks.
>

Sure!

