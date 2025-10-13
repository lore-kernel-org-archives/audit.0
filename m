Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165C259CBD
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387223; cv=none; b=dlEyJBQZIgGKVDzPBuLcz1OQTUNmw4BCBIeaw2FHSUfzCwfJeD33icYCdFVgh2sy402QBs7puMEvcCVfArsM17DqZ0sxOoaxh5mCR0WvmVaCn8RmwiG0WZrLL9bm+a+n6HqEftMVpBiNoRXbHxIJmXIEFl715yKBnx9r8yT9uD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387223; c=relaxed/simple;
	bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j21TA/7Ceowa0LzfmH/EhAjNcZrT1PdKDGWbmGwTUVs0g150TcPXFyCoP4kc+lo9tTirE5pVYVB9ZfNqdkIj1IMbsrdyucs7UNNctZSOKEKyCLSfiX5LbFu4U4nwyFh1sFJM9Alr11hLVgmc76J6XUgKZOxnSO5x7WIrpXREi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJxT5+6T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJxT5+6T"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6042520a91.0
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760387222; x=1760992022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
        b=CJxT5+6TaokJ/y+guIdlPVglEm0w81fTgvi+U+3UlXpHbaqVrDSzxSS5qVwiDwZxP7
         q51mvi4EjNdd20Z8DPjGyXGJRvnSaOBGBqHsxEWhHdj7S9uWCisd8uBOpUwNSkgxvf8y
         R5zpK4BqsQEALII7LuG/0LulSPurPl373rnMm+8opO9aqPuvP5NmSZ6mHEGOcNKg5Q1Q
         sZf+wNvMYOOR2sZETAXnjsYnqdz/wAElTc9CQ+TZSlS61iLAAcGFwsCo6k+rlL85Pf86
         tlTVpLP1+rF3XYhvalHxPc75sshf1qCvcLngaiGeIglI5sXtY4QDJaiMUdrE2vXGL4XD
         I5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387222; x=1760992022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
        b=BnKsla5DxU02vC8PpM1vKhDXSbXRr5VAvu2b36U5VdncdQRhznH/ghxUFsx92jCZZU
         MzZHYYdxYcFIYNrRvkuo7IrZJnJV+e/cbm3yOayPfe6VCteQz4JvDRcUZTgLNuzWOgLU
         CJOgq4omOZO+9CMDYDjKjZrD+Qt5qsKLPVxlcGXpPVSywkZk1822tXGxd1b1g5tmC2Kj
         vw8OcUZ6ia0N2/AahUKeNnRbj8hO2D6tpac/hpH5zZTFXsopudqqJjsjH9uD05h6Qm+N
         XS32Z4KWagaCLcUJPOLsuHe1E5PuFCz4wtqCFPC+5dVQ4TmJeSDa/b5wg8P+lbU0GGIy
         PcYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9OfQuvTpccGMJMcCywIHRflCNaHPdkKZSIXWuwOG/o9m0/hprHHnh9NJH1pkHnUP55/UWEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sUe7YELEU0uEFmiCqaAy/fABYDNw5tIQt69LxCirCxLEPeqK
	u8lmPQH2CtZ9SGJnZmp3j9BW4ndvd850B6nWBS5j4kiKbk64j7Jay3z8+H5c9bfaUskAmgZ2FmN
	LUcCxfaK/YT5/KX889yrrhgKPnPJd5U3Nc6OHFuP5
X-Gm-Gg: ASbGncsc+wMoulCRYOfTOf1cS7VAlmCEMStH3k/0OMW3mLeP0GySLJVbKeNMWo7IqmX
	0PDrRFJgfMKkOpAf0CXKTpXajh0StQcpZPYTxh1Q+VW/8eTpGYBDXwH8G0vSIj+nlKRo6k/O3TO
	lxJFavO5oiP9OS9E8B5P2+MLiqKtC2YFrYJrnA6dQ00FjKDevNpii2POFsBhuoSKKk9pTk+Ed1c
	tPzIEZx+6E8QCQI7UBAXovQ/w==
X-Google-Smtp-Source: AGHT+IGss2VDJO8x5HyqI5H573+UkHtTHLXgrJeCVBKZm5LGM/ts88b5TDQDn4YSXHwBmxi80eK/R3J0uWJkmg5SckU=
X-Received: by 2002:a17:90b:4d:b0:32e:11cc:d17a with SMTP id
 98e67ed59e1d1-339eda47424mr36047088a91.4.1760387221613; Mon, 13 Oct 2025
 13:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
 <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
 <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com> <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
In-Reply-To: <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 16:26:49 -0400
X-Gm-Features: AS18NWCUy4T8laMXtjmGm2u5DGufptm_DTkxgnp7osvagZXN3dVSC1WH5MNw9Qc
Message-ID: <CAHC9VhRL2mGrpzz9Eo3Hm+HQkUP36cDv_xx5BtjJjUqh2eZmug@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Mon, Oct 13, 2025 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
> > > > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen=
.de> wrote:
> > > > > Ricardo Robaina <rrobaina@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > Maybe Paul would be open to adding something like audit_log_packe=
t() to
> > > > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call t=
he
> > > > > common helper.
> > > >
> > > > It sounds like a good idea to me. What do you think, Paul?
> > >
> > > Seems like a good idea to me too.
> >
> > A quick follow-up to this ... when you are doing the work Ricardo,
> > please do this as a two patch patchset; the first patch should
> > introduce a new common function called by both audit_tg() and
> > nft_log_eval_audit(), and the second patch should add new port
> > information to the audit record.
>
> Thanks for the tip, Paul! I'll work on it next week.

Great, thanks :)

--=20
paul-moore.com
