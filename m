Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920522D3204
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381492; cv=none; b=YfcquvPALJ9/zoj7VLRdoXesxGH6nZGdmF/USuVFj0remdtDB0Wb81znKs7/CLOIIcOB9xEkDOWwsRSDwvdN+R+Ar4Mwv/H4Hb/a/omnihvR04UjhbaGQMIHVuQ+84wFEW+2YgzHyT9X64nb13ZcE7fzvkn0afD9xUkCpYMwDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381492; c=relaxed/simple;
	bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhYIQqt454pQMSlUhKPXDHY5ko2GO/kzqVdkaFe0kQyg9fAbKlcgsMOkoxkMC/XYeiwVecwhE1BcZAHFHPIOYZ4Y8IdEsIwHH3w5Tvb5Vj0onn/5ly5ub0J8oiVgSjeI/T787SOhQm7cFlLn66Fnj8w5JRujZVkKOaY/D850Pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bHjf/+eq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bHjf/+eq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so5581007a91.1
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760381490; x=1760986290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
        b=bHjf/+eqj5vY/bF2BPG+IBWrL862vg9upeGqiY7tF1XTFjeL/A6Zh1nWIKT7+IR0vv
         V5ZoA3eicWyBe3LnMF7gHpr4O3nDZNgEZ2XJsctatsYUWCrfJ8M44bHY6oG5jxE8UNH1
         xeAQulsuR+SWtgw+rCkUTtZ/D+S0x5A/1c+UyuGvE+cR4Cfh7QMGwpMk1qw0xn7ArO9E
         9Y1lyUFJ0RBmMriiDsDExRMURgH87JXmvdCWqn3GXuqbBxMSVzjrPLmxzw4hP2xZiMAM
         yIz6KgAj4urgu1fjk+zI6JseZEo2ocKhHNGRC7qmNzvjWYKuXbTYP1EOhzwSCQas4MGJ
         skWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381490; x=1760986290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
        b=GQjUL3V7CWUZfN0HNjBpSDNbeWlQRDqABPnYMWjpKNjQIo5bjzhWaONfCB+VhfzFsw
         qDPEzeijY7wwcwkLZSGz7E7j8+MrpkNiX3mUOnxQiEjRa7r+cNz5QVgA/fo/GPxZe2xL
         FB1QIcGJcpXwL1EXd7kHfWFTODnDEW/vzrDOeqMc/VPxqGS06a+EwPKWnJ5Svi5DoyQz
         7MbrImwQEuD/jI/18+sJnjYxLOPur7BDgY5oUeHEPSkn34KjsOooZAKb9ChaWWlBKsxY
         rE8lCiJgyBaKcHBuaSUi7XJSlOvplX85PDokOvQz4jKwkqXMM8VY/sA9qLXQ2YNf1wx5
         bQTA==
X-Forwarded-Encrypted: i=1; AJvYcCUKKS6P19w3zXAVzJhJhkA14j+AKalWJdmcDHE9JnsNoJgTh0MIO5bAw97n6e2ZEjWa7hD+qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nVzRU1zVjdDWDJ+wsMLOEk80HQouLqpPp8/QagQjOfcogXkA
	dqXZ9DtSnktWtipc3RbMz0rCjxmr6pdFkUW940Vr0gWtoyXFKVmK8KxG8Rt7FAUN+E84EWadsBy
	Ef41KYJ/tvWlQElSNwjTMrPXLDnzunCTqiqhWYiSo
X-Gm-Gg: ASbGncu6eDcZEoSn/+0ptRt/OypODPNN+37Hg+gtsV44sgHRw0PZ6Nf9uykh5QdbUoF
	dxG/n8qmzJKKATn8Npv8lnSSL1e7xJIjZZN7bciFBKWIRQx9dD9FhcYNRfzNrIY8MQXNtM8cMzo
	Q8eEx9Gl/8yn7MBrlgVilLDyKD/kiZFRV75qMI4enITV32cmMROlQVPxQ1J4Wi8NqXtiJ1ro+/W
	93TX0Am1Ihvpns5tG4Yj0r0N+S0Kad0YkbQ
X-Google-Smtp-Source: AGHT+IFMC9e/vwhBwj0ALme8Cp8fCsUdX3he4mM8zid+ESaytCdihd+ScwemDPrM3iGDaixXxrSTv0P6mAS0ElBGhM0=
X-Received: by 2002:a17:90b:4b06:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-33b513b2d70mr33835189a91.17.1760381489825; Mon, 13 Oct 2025
 11:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com> <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
In-Reply-To: <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 14:51:18 -0400
X-Gm-Features: AS18NWCCxvCqhwe_ZDUQ1QESEd77z51GhuMdOVqnR8miGtQcczLoD65PJ8boWMA
Message-ID: <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de>=
 wrote:
> > > Ricardo Robaina <rrobaina@redhat.com> wrote:
>
> ...
>
> > > Maybe Paul would be open to adding something like audit_log_packet() =
to
> > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > > common helper.
> >
> > It sounds like a good idea to me. What do you think, Paul?
>
> Seems like a good idea to me too.

A quick follow-up to this ... when you are doing the work Ricardo,
please do this as a two patch patchset; the first patch should
introduce a new common function called by both audit_tg() and
nft_log_eval_audit(), and the second patch should add new port
information to the audit record.

--=20
paul-moore.com
