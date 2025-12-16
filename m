Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BE223DFB
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850851; cv=none; b=KcfDs0OgcbL41euo6F3fePPZMoKU+KcQtE3gPTX4NbYk26yPEGoHXrGMUXDE7RcgeWlkaF4dsPXqBas3kifzyuBEm9dzaaG5mmGE32RHGawzwy5X5cR16x9wW+E6yROgXj6hlyt5DTaW3Ir5fFLwSkzYczhTKI9oIOaXSv869mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850851; c=relaxed/simple;
	bh=Ua0saGAbR1O2pEFzYGaytJ4NzKP9073Kd7qDULFz/VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFRg+xx9WblmansWK4CNWjnXv8p4PxZzIQUPzSTidcHrqrbiDLybdM2+abXY8dL2y9SKP5eUdvrSOCjZJAVeU9fWVjskZBL+zrBFvYJP2UCIo2fGPg0tSmiZNtq6lyF5OrlemwKKCrFRLw/CtY+48p/nDl1pDyOumDrFv0l+/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XLgycp6w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XLgycp6w"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c2f335681so2233762a91.1
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 18:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765850849; x=1766455649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPtfQYPqjPdWZ8kVEnwCAJ60ic6AA/rNavnbR5eX01A=;
        b=XLgycp6wQ00Ap4VuSX7TtCfG3AVv/ymnEOzODOEonl+dERCgDTOdJuUjH8ZyzL25Aw
         RuXM3iFjH+cZFl8hA2AgQqT7K/wwdpJ1g/x9YLkEVMMVvMW9z69PBtJGKRcrgUKGdBBo
         g2O/pJZL14RUDXC/zWxevxW0PbXP6TVOA9pigFLseZ+0OiVhtBQWzv2fX8S4wTCL/PPN
         UWpLF0qzcvS9lVC5Ws718BvYrkaqvi3aq04tylYQlOMYOC94cJp/SgAwUvrukZxK6djU
         hSHsJ/PmzCm53xKFNsDhWhxcX1clZSsBSxTedxELwGoE67SPdJTEe06Xpo0DFnJAKCIq
         NyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765850849; x=1766455649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPtfQYPqjPdWZ8kVEnwCAJ60ic6AA/rNavnbR5eX01A=;
        b=fpOwyxvkaz6N1RJ4NwHHK47FZXG/QHSHahUhzBBc44nH1cnNxPSjmbWNVUhUHEevyi
         VHMegmg9wUfg4vAND+bel9Kot3VIyGJiazxO+AUpHwBXyygmq08+zxEyz5x4evBXYZEQ
         QHlps5r3dutZvIA+2iqgryCDFwEgeB/w+GHMS9n4UrOUTG+1wue0kDV/JTQfS2i7k7c1
         C5rRlDuwBgRVLq1Pc04TrEZcqEV7G7YTNFwlf5DYkMp0l+hr1sIGuiuYG0hcdqBMliIx
         AQzlPJ24qEr8OvwWbSjenWmXvOMlRmYv9eFImXxUvQ+RGIuqkNzM+fvm2ycYXnQsH9bt
         xAVg==
X-Gm-Message-State: AOJu0YwpHFtejF9bIk5CJxhyPFKFHIjTVg22UMuQ97MJlkt5PqvSgeIp
	jX2/+Ay4eY+IaX1EW/WjcM3vBzwNdqumyO0WV52NuPye3zbgZFmLYqdCOy6GmiBlPDKfQLvz9cl
	AXYhcO0QCs5yvFJGDlyt8zfF/Z4hBTv+Fa2cjWtp/
X-Gm-Gg: AY/fxX6HEjuicLBKkFO7xD/3YaPPPGjW8uGe3CaSQW9L1826lqOqe5N4PDs+YBZttZr
	PxGEnOAyYNydtJe+nM3oLs2lcjj4sTJRfYmgNH67q39/5ho04g77qnpDZcM8WNVJoRfdAEpsbBS
	PEsiGkebL8o0XE7pRM8r0bxuRDNgdhdlS4Gxu7m6NjbeAxeyYk+NUznsLVsFlA9ttFQKnGLepjS
	wwD29UWZjwQ292Wv81pVrME6W7H7ik0NfXG51ZbU/kD7xQO1jOeftH/WjbOjwXIGWeuZ8I=
X-Google-Smtp-Source: AGHT+IEXIDmB0kW/nB7MYuTz1qepAP7hKunK2rfMPdIN2Tf49FcWBr3AfwpXxP7xHCxLPxE5eckfauYq/yDFH6/gHvw=
X-Received: by 2002:a17:90b:380b:b0:340:bc27:97b8 with SMTP id
 98e67ed59e1d1-34abd7be2cdmr11050478a91.10.1765850849222; Mon, 15 Dec 2025
 18:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763122537.git.rrobaina@redhat.com>
In-Reply-To: <cover.1763122537.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Dec 2025 21:07:17 -0500
X-Gm-Features: AQt7F2qgoMQ9xayHCqwhzYseUUQuroBt3RUlmHlYaVx_WDSL9bac5aMhJ09Md5g
Message-ID: <CAHC9VhR5_wHWpSXVapFhswqnUw1x0M3SCSyD76Kad8AMi8xEeA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] audit: improve NETFILTER_PKT records
To: Ricardo Robaina <rrobaina@redhat.com>, fw@strlen.de
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Currently, NETFILTER_PKT records lack source and destination
> port information, which is often valuable for troubleshooting.
> This patch series adds ports numbers, to NETFILTER_PKT records.
>
> The first patch refactors netfilter-related code, by moving
> duplicated code to audit.c, by creating audit_log_nf_skb()
> helper function.
> The second one, improves the NETFILTER_PKT records, by
> including source and destination ports for protocols of
> interest.
>
> Ricardo Robaina (2):
>   audit: add audit_log_nf_skb helper function
>   audit: include source and destination ports to NETFILTER_PKT
>
>  include/linux/audit.h    |   8 ++
>  kernel/audit.c           | 159 +++++++++++++++++++++++++++++++++++++++
>  net/netfilter/nft_log.c  |  58 +-------------
>  net/netfilter/xt_AUDIT.c |  58 +-------------
>  4 files changed, 169 insertions(+), 114 deletions(-)

Thanks Ricardo, both patches look good to me, I'm going to merge them
into audit/dev-staging just to get some very basic testing, but if I
can get an ACK from Florian on the patchset I'll go ahead and move the
patches over to audit/dev (feeds into linux-next and the next merge
window).

--=20
paul-moore.com
