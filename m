Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D029C326
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382697; cv=none; b=ov57ovJA6JwtaG6sZgExp8q9xB9h/Jz2Vh91KURgEbV3I+BW1MMr8/P0TfAg3PwvzB85sJS9GAc48V30K1Agt4g8REwwKa8YQdiauCPpChK7OoP+TVSXwamwDiSkaGbCpiSxIiwk+rpFox4HU0KVxIc9bBFsjssQEFVE5F8wl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382697; c=relaxed/simple;
	bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv8EvMscuRSK7r3guakVwPCAFERCzqn5z3a4iwGYaTOo9jBWmv9g9qVPJ61JTO8mBP48CDDKNQhUDx+53OawaiZtb2LKStUptySSD7Deiq+70OFfKT9mRBbUjJ1pxDkGB1PLQ9iOyfsqsy6ZObcqE45PZPW2UYG45azmAVrrEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRFAp+aZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRFAp+aZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760382695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
	b=BRFAp+aZEQrniIyaDxa0gU5B0ZiI2DquHhD02xh9Jh6vuX7eiFKYLoBGrTh9hsQpkRr1Ah
	+38n8+tXAAFSJwgXmckh9PV361JuCbGZID6827zC2qJzHt/TSkKOjY0DVaaoTgMiMEtfR5
	Bk09lg+QPWM8YGNx60NMUPnmUJfwZEo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-pCjvED-GPVuYHry0Dba9ZA-1; Mon, 13 Oct 2025 15:11:34 -0400
X-MC-Unique: pCjvED-GPVuYHry0Dba9ZA-1
X-Mimecast-MFC-AGG-ID: pCjvED-GPVuYHry0Dba9ZA_1760382693
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3cbee9769fso612708266b.3
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382693; x=1760987493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
        b=RuzLn9/lEmqVRB6olCRiGmU8RTiKKQRRo2S4JWeSboqB+48qt3t/LjHcr7n1QY2RB8
         TmakZxlNMbw2+R77uUSTX/tdwANvXiDxIjFrxaMfx8k1JLc6/1SN5dSdW/ZQxcFJ5B7i
         YFOUII1D6aoL9fh1ShPBWVtUqI6IjGFl7NGobXvb0Vqz90raC6vU/iQKxSy5qkQp9S+d
         Rnl2gdE4Iw1lhDctTTEGlF3t8dB+GbG7KH+ScUWMmmqd6d4ZNUs+YcL3oyq/s3BEn4aw
         SQR6gIq8ifd4zN414f58cbnHqv4gO5Ix4NEDde8ZE5qoQiyj38R/vMt+/7D6U8qshcBq
         jlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTqZtrzkMvlbGcA402uncG3AXL+wr0PCIYlr9s1tD4Uu6d36Sph84Mq7yHeYXUxFcS2UDr/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1XlJDCYoeDVV5TT07MuoP2/YnV/nudOlmFvq5abw3dktY6uq
	vBnw9hbOM2ye5MLut0ld7K35i542P51O38mVX/CJ+XPogxbujSmlOCClKn3rfphafY/FL7Il5yv
	YjsxOZPUw+XRTVJIuFzRGGtEwDFsA8yCH39MoWMeH69s1JSY4p+n8goC4cNxi0liDoVnA5a1jhQ
	6fenWXtWxw2NDY/2qFldK33tT5GC8OgP8=
X-Gm-Gg: ASbGnct/jyaPd+PsGhNgkAKaSH0ONF2nae6LM7KJkbUvMYo9hi69pf9AHnwJrI0ptNk
	Ioc8xzDonGt4AvxLfkChpb5q53glFi7lOICVcMMsebtTNyy/j+mCN0T5JgcVBmwp7oHrUlbWtKj
	ZmxlLXNu97Nq4yvWcVg3rl8w+wieqoVfKJJU7KifHeVJ8bVJXWZwpIzQ==
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b50aa48c4f0mr2434548166b.11.1760382692709;
        Mon, 13 Oct 2025 12:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdZSlJjUKGUyEQeXbLsv9VheuVhvq3shA+CFJRXSerqAlSqVOk9p/8bvz3PxsEytGYzwrMZIP2BUftmKkR2Ws=
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b50aa48c4f0mr2434545466b.11.1760382692352; Mon, 13 Oct 2025
 12:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
 <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com> <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
In-Reply-To: <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 13 Oct 2025 16:11:20 -0300
X-Gm-Features: AS18NWBRpmVXsqMwV5PkEQwwAsDGsJpwgtFtU7bYTbHsTAe-yKFLi7W40fQv0tM
Message-ID: <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HZmYZaAsCKyVfTpeNQTl4S9zseRufbfr0YEzCGmVM1c_1760382693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.d=
e> wrote:
> > > > Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > ...
> >
> > > > Maybe Paul would be open to adding something like audit_log_packet(=
) to
> > > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > > > common helper.
> > >
> > > It sounds like a good idea to me. What do you think, Paul?
> >
> > Seems like a good idea to me too.
>
> A quick follow-up to this ... when you are doing the work Ricardo,
> please do this as a two patch patchset; the first patch should
> introduce a new common function called by both audit_tg() and
> nft_log_eval_audit(), and the second patch should add new port
> information to the audit record.
>
> --
> paul-moore.com
>

Thanks for the tip, Paul! I'll work on it next week.

