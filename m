Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD41FECD4
	for <audit@vger.kernel.org>; Tue, 23 Sep 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648899; cv=none; b=j/JyvRoC9OAbG1bwC0CP2u3iHpL212Jc0SjZUkckAV6JAg4Z6x0ZQIMhbv/i+IGzG5xwkVgwUv2aK8Yx3OV2Q4ypjctMU0HUILSow+RrcYG1Se01rssD+WAdM/ooYCH1u/Svc2n6Zw3i4bKYv366rpFDdOm/inLln/8e7HbyTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648899; c=relaxed/simple;
	bh=kiHYOV5tKHdiZHaewEhed9KwrpNMOwErNX95ewTe0bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po8Bp8VmSoGvCo3PiHkeRgPkQShBCSlPgoIZy2/qwrOaRPXUZOxSDmgEt0g7k+Trc/seDXjzZLlAWpMUaav3sdJdfiZ1HUYosNZ2K6zFjiuHiE9EAJk8xIR6Is7zSVBP4W5r4hFGISo7Dix6z7mc+lI/mCNiIhqQmCIoRLfncos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey/14/ZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey/14/ZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeHg931zRHI47gvkNWZ7vE3F3NuZSRm6Ea8fb1/M8s0=;
	b=Ey/14/ZM2ZHKJJelmckzhx48m387pdWnWu4ftzyrjmMZ1OQCzq1p5AOh+aLYT/s8we/Nbm
	rWx5qL1Lvv27yMZJy/IuFqZhijV07A+4edRtmyy8XvsnBHEXt8MIF9q3S+Z3qf2kQxN1xQ
	WaEsbby0iYIGpIdh3X/2TX+eqH9squE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-VOzk2U99Nwq3S13IoQwJqg-1; Tue, 23 Sep 2025 13:34:55 -0400
X-MC-Unique: VOzk2U99Nwq3S13IoQwJqg-1
X-Mimecast-MFC-AGG-ID: VOzk2U99Nwq3S13IoQwJqg_1758648894
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04a8ae1409so575446366b.2
        for <audit@vger.kernel.org>; Tue, 23 Sep 2025 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648894; x=1759253694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeHg931zRHI47gvkNWZ7vE3F3NuZSRm6Ea8fb1/M8s0=;
        b=eaZ1MKRGm6j4BxUI8JpX9+bdpcaZZhxgFTX9wEgpIEQvvj4wo7HeOpw40ANpA2C8Hu
         8ig8ZbA7YcyhRPrK67CC8eg4AIgrAgPTrwDeDglEPzQF2nVB+xSf63lwP2k9WMNSgHIL
         INz0BP7HMetiHnVzohoq3wKpyYimLhtw7dTUipFQKhDM7AKUPFGYRSwUE6D1ICF9IFto
         O6AdwbYNR5iktz58zXviW/rBbVpsxRx3gew9GezFYJmC6GqEaebsBGBadER3H8Z3t4tL
         Qr8d0D4xGxbCFmwMWmhzK2FYv37Ik9ih4PArk0dHHO7zza3BQfoewgWXqsbAvNni4nDe
         sk9g==
X-Gm-Message-State: AOJu0YwoW5GH+MGGT7fCPX/ZKzOoA0cBrWyWR8o4RCOmOPn4ycn3Lqoi
	6HoxUNPAbvoBCF/ZKflr9CclC9PQdlb1Jc3fKzppRcCZykffBuJbQ00HyVkAPYuj+OhFSPr0NVE
	MAdeXsBjQVlSr55NZRsQwP+LoEhWOJM59MDvUnqh/CWQbp4e19B88vyHJx6UKZMqaATJffmxOc/
	usHzZvuYkbezLLrj+EuBheUu6QsJr48t4=
X-Gm-Gg: ASbGncuFVHcqOTkESwNQH/dGTJqCzyOTxEAFtI2i3DEVjAVqP6d3azaN6IqKmTo3mGq
	22XpkdvyUejtUPjvmYPet+hbiUDY3hpwEWSkzYt+3HozdrCyJXSY3jJr3qKoTTBuWkSHBfvJyyE
	pFEqAOm564U+P+aPCoJVWara/dQG/6X0llnkMRtYg1wivKAiYVAIjYxw==
X-Received: by 2002:a17:906:9fcd:b0:b04:20c0:b1fd with SMTP id a640c23a62f3a-b302ae300ccmr331462466b.36.1758648894493;
        Tue, 23 Sep 2025 10:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq4BfWe8HxueShfdYzigmJ/VAJwF1XeJgNJ2hPk2d7C/yE2zIEX4Wl+YrY9HIBKFihHiry//0x0vN++dsU+uY=
X-Received: by 2002:a17:906:9fcd:b0:b04:20c0:b1fd with SMTP id
 a640c23a62f3a-b302ae300ccmr331460766b.36.1758648894113; Tue, 23 Sep 2025
 10:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922200942.1534414-1-rrobaina@redhat.com> <p4866orr-o8nn-6550-89o7-s3s12s27732q@vanv.qr>
In-Reply-To: <p4866orr-o8nn-6550-89o7-s3s12s27732q@vanv.qr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 23 Sep 2025 14:34:42 -0300
X-Gm-Features: AS18NWBWOHf8rNDBSAWfxx9RxHlA_lLobyIxEA9zXAn2_ywMPGOuRbJS6DmvJVs
Message-ID: <CAABTaaDaOu631q+BVa+tzDJdH62+HXO-s0FT_to6VyvyLi-JCQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: include source and destination ports to NETFILTER_PKT
To: Jan Engelhardt <ej@inai.de>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, paul@paul-moore.com, 
	eparis@redhat.com, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WUXL1n9vrA6TiXQSArsBQIp6YemxzJAW1H956kX8b5Q_1758648894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 8:29=E2=80=AFPM Jan Engelhardt <ej@inai.de> wrote:
>
>
> On Monday 2025-09-22 22:09, Ricardo Robaina wrote:
>
> >NETFILTER_PKT records show both source and destination
> >addresses, in addition to the associated networking protocol.
> >However, it lacks the ports information, which is often
> >valuable for troubleshooting.
> >
> >+      switch (ih->protocol) {
> >+      case IPPROTO_TCP:
> >+              sport =3D tcp_hdr(skb)->source;
> >+              dport =3D tcp_hdr(skb)->dest;
> >+              break;
> >+      case IPPROTO_UDP:
> >+              sport =3D udp_hdr(skb)->source;
> >+              dport =3D udp_hdr(skb)->dest;
> >+      }
>
> Should be easy enough to add the cases for UDPLITE,
> SCTP and DCCP, right?
>

Thanks for reviewing this patch, Jan.

Yes, it should. I assume it=E2=80=99s safe to use udp_hdr() for the UDP-Lit=
e
case as well, right?

It seems DCCP has been retired by commit 2a63dd0edf38 (=E2=80=9Cnet: Retire
DCCP socket.=E2=80=9D). I=E2=80=99ll work on a V2, adding cases for both UD=
P-Lite and
SCTP.

