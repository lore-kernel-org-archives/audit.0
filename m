Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C923B62B
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901417; cv=none; b=Pu4uV8KtSiHugO37XWvzlj8ZPNq7RlAHlZXRBQJ7TrKdbG5gH5SzCABoiq/A0m4tZ4B0CzX7rSBwOAcAKm5t6Oqea/DotRVRUy4La2SWHOsLosulk6DLsBRh5U3y2BnihKSC+x7F9vn2TUYdlbSF6Vm0w2h+O+/U6D1WYlsddcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901417; c=relaxed/simple;
	bh=NRF0QdCCgWaxhi5Awrbe/uc4JcFKfbNk/cZ1tMfOlDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulqpX035YY8T1T52zirptjqGqhIjs+Mje2ABAGTsTMMNwI1leR/FZ47GSai/pCgWc1UebV8CSh24qrL81SJSe+cay4UOMmgWowJ2iC6mErZS7MrkJbumdv+CVfVaIPjOd/XxDEKAch6DTMXFrHbbHGvFkPn1EcgjNfer7EFBvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KjhzPV8M; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KjhzPV8M"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so890139a91.2
        for <audit@vger.kernel.org>; Tue, 16 Dec 2025 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765901415; x=1766506215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PoauRsRe2PyKgjmHmaNav09oGxjvBx7YXCMg5VtPE8=;
        b=KjhzPV8MqcXeYNrN6Vec8L2E/8KHYxiUPYDHW7nRkHdsX9xa9WWUHGzeRU/erIDCEZ
         ypSKBW+CmKEAtKRBeSmT8G4PNPf1u505+IBHC8Msmx6TUMf4m/59I9V6fs/AtAvQPwcv
         ehyVDolJqCNqxhw08OMA/cMDVCxVD9zs/QdoGcOqkXZN1OA2d7El6lQfQgwR5U43fSfu
         ync/N79H1FUK/1ymAfFxQvdWjgS9SoBIBvAOsMfshdrrhtz91Fhn5ZTCJZ0sDDrI0WK1
         V3fj2odhIdD1bHyyyzJCSjIfWWjOjH45mPEln9JSj3M+UQnJqnOP0wMMo7Z7KEep84c+
         0nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765901415; x=1766506215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2PoauRsRe2PyKgjmHmaNav09oGxjvBx7YXCMg5VtPE8=;
        b=OGpnbz2WNen6QW/k7vjplfMf6q6knOaOnoQJbTcCQIdNWqaBE/rXpuUxX/xjBi8BVD
         QjlvQ0nnWhj08KgKbIp/K3By6xLOg5o1SeT6jSPqUvZO7vsQgUEL+9KQDYXFcefAGY4N
         0d5bSkShQ6s/AgmOLR2A86+RZnzdSKHhxJU2CKB7BYNwaS+Nyi9ipn2Uz0mztc9YcWai
         XyutoLIUTusSs1XNEeA1Mkh2vIRiJG0O/IPsTWeAsbKIYRYomM4loaOTzXVuCbtIWTYO
         3Wnr3QNQWNJ9uqn7eZ/am5/m3RCg8wXh35wCVTtj+rx1ThT8UXisXNMA7m0sl4w8LILs
         KtvA==
X-Gm-Message-State: AOJu0Yy5NUo3lYSCgCyOguKpx/HrYMlwUfZF8Flw+MajDcHU30nwgaFI
	B7syvedtJLJIAvU3MObJHHHPMa2aEqOToM6sGNayl+1y33zaoVZOzpqHbrB9kkAaMQhf7NgYdun
	0WfRJurdxX5yekFUkJGpvrQiWCQ8I0go7VX3t9KTW
X-Gm-Gg: AY/fxX7/JIXPo5/I3BPm6jr2OeH1zzLqrTFMn66+udZhgTUq8wBbMTzUnTnI1ER14Ac
	L5GPqZx+6/y3ppJ7FYRE4RrYtNsezg3weVDghfWFwAlyjH8WkN6tFJFviElUrdVz822hwEsTRQY
	0RFozrNQpDJDbNxe5zp2OY+ayRr6tf6Y6TPcYWXCRoWdjfjdRYcQuTvdg3SSKYix3m2EXn8f6Mm
	ednUHA7fpANlsEBGTDOdEufwmJh1/zIUNH98dXYDuJJnCipk04sLvxHozzR7e7ScGZIevs=
X-Google-Smtp-Source: AGHT+IEdi0glckedzxRx192OJEm8vyU6rb6hn4LGFTzovQeP8RxQkB4U9n2C0dtN5ZFZ8qoHL/13FRru6SQ6qNE5yCI=
X-Received: by 2002:a17:90b:1d4c:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-34abd817345mr11798465a91.22.1765901414614; Tue, 16 Dec 2025
 08:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763122537.git.rrobaina@redhat.com> <CAHC9VhR5_wHWpSXVapFhswqnUw1x0M3SCSyD76Kad8AMi8xEeA@mail.gmail.com>
In-Reply-To: <CAHC9VhR5_wHWpSXVapFhswqnUw1x0M3SCSyD76Kad8AMi8xEeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 11:10:02 -0500
X-Gm-Features: AQt7F2rG94S4iiHVyf7F81p0EXlE5cJMHO3tKFCJmGnDXN8eMfYOSyaNWI6bgyM
Message-ID: <CAHC9VhQtYSpw15JM_1Yp77E1nBCuR5xeiE_TzTVuZ2_zr2W7wQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] audit: improve NETFILTER_PKT records
To: Ricardo Robaina <rrobaina@redhat.com>, fw@strlen.de
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 9:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 14, 2025 at 7:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Currently, NETFILTER_PKT records lack source and destination
> > port information, which is often valuable for troubleshooting.
> > This patch series adds ports numbers, to NETFILTER_PKT records.
> >
> > The first patch refactors netfilter-related code, by moving
> > duplicated code to audit.c, by creating audit_log_nf_skb()
> > helper function.
> > The second one, improves the NETFILTER_PKT records, by
> > including source and destination ports for protocols of
> > interest.
> >
> > Ricardo Robaina (2):
> >   audit: add audit_log_nf_skb helper function
> >   audit: include source and destination ports to NETFILTER_PKT
> >
> >  include/linux/audit.h    |   8 ++
> >  kernel/audit.c           | 159 +++++++++++++++++++++++++++++++++++++++
> >  net/netfilter/nft_log.c  |  58 +-------------
> >  net/netfilter/xt_AUDIT.c |  58 +-------------
> >  4 files changed, 169 insertions(+), 114 deletions(-)
>
> Thanks Ricardo, both patches look good to me, I'm going to merge them
> into audit/dev-staging just to get some very basic testing, but if I
> can get an ACK from Florian on the patchset I'll go ahead and move the
> patches over to audit/dev (feeds into linux-next and the next merge
> window).

I just moved these patches in audit/dev with Florian's ACK.  Thanks everyon=
e!

--=20
paul-moore.com
