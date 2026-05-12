Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDA3C4B82
	for <audit@vger.kernel.org>; Tue, 12 May 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601523; cv=pass; b=aNUCdrWez/3yDid4WLTBUEwEIAYz6Tfrvk4nTLDSU3A4N6VA2KhMS2Ra1e04z3A/0te0ZaQyLDHNuEscOqAjEBojIisnlJpHW5gv5wzACSW4aCjAz9jO6AvcUq9qsNzmF7St6oMCUqAl+uZlLuDHxO+m3o7jw4uZPVqbcpzyGvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601523; c=relaxed/simple;
	bh=Zeskne0KDF+k572erCzcEBWpvpWo/BBFQbC8Ica49v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfI4c1wbh4UQIOWGBam6PG3SVfxNzQTur/hUIfAnH0BbgilMeTWsCZeoZ1yySRgiOFjru4IlaX090u17NsnTJZO1kNYXZ0TxT4XnG0VyJCBrCMITHVeTd9UNiD8ozXAdGcoMCUAitctNkUO9NAreomAN/gwtW5SetSoLAUuTV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ILVowHdr; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ILVowHdr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so2499878a12.0
        for <audit@vger.kernel.org>; Tue, 12 May 2026 08:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778601518; cv=none;
        d=google.com; s=arc-20240605;
        b=goZH1YB+fH0ydjVxgo2z03AKvznqCdh2z4HYB9EiVi3rI7My/PkG5/msY6kYb1WfMR
         +TfylTTjiJYE78yys02Qck5KhSTwGA5voIqUWIvpdpP61mH2lXbB8trEsRPc2jx0+9dg
         FHtCxkoSpOjF744NuMtLUKE5bEmWhovFluUhOEIeD87t88lu7OoV4MtA1VRVkwqQLGLI
         h1D0zvTy0OpKAHj+RkN0bV6CYncjsIoQWoV8ldU5mZ8VMz97cxo4p0+NtAaL+KOzA/zR
         TaDqX87C/ULv/DQgQHjwHu+MIexk16pIzAJ3dmjtGtmbhlwaKCRr8tSs4yPAeQEja2/k
         0Tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        fh=k6KqFRSK+w12c8hif1wIp8UwR2zZmM1rxa6vQtTZHxQ=;
        b=W/mRbURBL0GhVhmthXYzXR9TZh0J1lUIaViZdI9HCkKcjfMECD/H8A0PJ9rGqQrdfG
         4edCqCr0EEhP5a+tV6tEKdmedHuKcPaIGKufjIXBZtHq9nJN1HxzCvALbhW8CeEBrhI0
         9CL75IjjJ4LvGI3yIhS5BZdqqwO6mRO3HAEg4olvm+/E4dgo7CAVEUX6djk2WeAOcr0w
         RddEskAWb1pq8DizQtAQblw4spSz0DOB8z/pqjNEeqoDJSHlUgw3p7HbegNZiSlDRPZE
         T2Ttcezz5uiccq5722uyNcS3iVqO9Os544rY41U7sIMTUXQ7IeeJ4HQTQALfuMYO9e2v
         AcPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778601518; x=1779206318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        b=ILVowHdrQgKoq3gdE7DgIXiEWXc2j8xANwT7ZBIhhLP5ACasbbZdyu2KIPr2Bt3jxA
         4DfptGoy+ZqPfNNsxKxq3VED1dTRmJydWvkJPCh5uZmkRsQkAgS6zTY4W5Unc+fBdzXj
         ze0W/hjKLlN1I3leM5PGl7TzKCy3bWedCLRwsU+vEn0TuQKfB2BjulYp01PcpjikyHCk
         zx/8GhGsWxiHka+FtLvJCfrATBNZXZ4trF4IJIEQEa5CPTSrDCbNNqu1/+PANC5aR0e4
         XJ1HaWyy66TCoNNFHnGQ4cGFgKL4RBN0Oaj3f5LF7wEGRQ7/EFIgD520VFOhgip4+jDQ
         7q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601518; x=1779206318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        b=sj8ryF8qu99l8oiuk/Aiv8wzPIn7zWlwXVaxmFYfkysZFlNcx2O7QM8h+ywuCgC7Vd
         j1eAmsFk7ffxpdJOb+JTYBgxmIZ4MVrRSVASfk5fBR2GNXEC5H46jfTpqfG2EM0M4Qgv
         /RDWpRNAsQROuSfF257n/f/rdCsblmYgEkinKZcZ9QNrMUyMTxzqsfdQIBBwFtaFi+Wh
         UNnfEg/a9nI+CWgvGBKQU9ve3Q0fpGlGRhupuaXOA/q1+uhApeHb2JqHeqvirSkUr2FX
         FFnKeq/YUnZVHroA6eIb1hX4QGDsZlQ6AA4LUnrL+H8yV2JKACSG4Nhask7Yuas3cFZf
         tw0A==
X-Forwarded-Encrypted: i=1; AFNElJ/XjpMKvdVkH/eowDGFx8AAoa8V3I78RQt2mnYA7GnXTKjwnqgCjWCCPGvJy09NmpdvGQOSyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SpB/uPe1C/ms70Hruq66TdiyLOBrNpZ31IH0mhI8aWDFQlSW
	Bhj/CeAKAI90hBFf1Syka/Cvf/lDYAtnDUENsCUypSzWVlW0SjBSq8OxY7lU6yx+41niefdxucK
	3aqo4IF2MiDcx/2ZXa7AlGlKqzRhn2efdr9zFm1iK
X-Gm-Gg: Acq92OGuFXQEiIxs1Yw6i6EkwdxOojdEbyMIFfAvjFMvk65G56/s3cg9ZPBUMllYjeN
	RHgNfivrk/hDBft5cFJD3TDiGlT63ouEpr/Wd0/jVYXiwsVjxQk+k0luN9DMCubbQtrvHQWRLug
	hVB3Fg4gkDT2D9WzLG2KZTIzw1AD4vUWQK7rjWsTtA8/Or7catLfaTIHyrcs2az/HB0MYRTPRIq
	CMfWc6HA31zOA5EiJPoVNRb68zPHHdJ8gp1yLWFTImGC4eM8r6ZSf7ocn47D+peFLWIt+Rjy7/S
	iAu4FOk=
X-Received: by 2002:a05:6a20:12ce:b0:393:74ed:7de9 with SMTP id
 adf61e73a8af0-3aa5a458774mr36680654637.3.1778601517961; Tue, 12 May 2026
 08:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
In-Reply-To: <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 11:58:25 -0400
X-Gm-Features: AVHnY4I275P3CzSroklxl1VjTCxBzyxSQmhvt1UdsgCWsDYxXPS271nl7VghH8o
Message-ID: <CAHC9VhTjSFKEZNgd-w3Gh=qENW7KL-CYq_syozTqD05iAMubqw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Eric Paris <eparis@redhat.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 12:28=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
>
> On Tue, 10 Mar 2026 16:08:07 +0100, Christophe Leroy (CS GROUP) wrote:
> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> > targets") added generic support for AUDIT but that didn't include
> > support for bi-arch like powerpc.
> >
> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
> > added generic support for bi-arch.
> >
> > [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>       https://git.kernel.org/powerpc/c/f26ad12356a275ab303d5d3af4790ad94a=
cc20d7

I never saw a follow-up demonstrating that the audit test suite runs
clean with this change.

Madhavan, did you test this before merging?

--=20
paul-moore.com
