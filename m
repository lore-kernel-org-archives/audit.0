Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C11D61B7
	for <audit@vger.kernel.org>; Mon, 11 Aug 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950960; cv=none; b=FByCTFdSfcm0omUT+ZxFCmwQoph7Ju85FtCFPIVjqMZ/N9NmpydLBfQfbTuVY6XId5sAmMKNrpqn3q4CWOSXquuSkDwHsYsf/q2J0R8SlZPaqKDl75ctN25qmLdOzIQBKtepLy1HSB1aQgbS0CWKKiZjlNWtiKjsfPyNOgbP5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950960; c=relaxed/simple;
	bh=6FRs2WGwD++dmIR2ElELNp+KfEt0U6e/Resq8Iedu3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmjwkfttHvmPtud/1vE2gTbAYvhjcXsQS3M3dIpP/BH9dR6vw/Ye50s9RldABhHKoqgkb76b1nXeCje68UvMs4tS1ZDUI1T+n2ss+onV2FVJ/elohifDyHksiStr0q3CtERZTnAgdYVNljdAZULV7OMFsWLw59bvCXyYLdgkCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KlvV7y6i; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KlvV7y6i"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3951948a12.3
        for <audit@vger.kernel.org>; Mon, 11 Aug 2025 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950958; x=1755555758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BPMyMVy4Q6wAfzkb5VkKhfm5jUZ+GnJD9nh3Em4VNc=;
        b=KlvV7y6i1oJLyK8fxLm6IMnsFWAaSnNr/URAl5WUPOD2uozZe/twDG3yqdmmFoupvN
         jYONr+ovDy1b/6xWG1i3rqM4UZbZMX4mFtrd71V5tCvNx6RRfrud2yyWLejEP8rEUyoG
         bx9buas8REw+KrX5KUYQK1iiTPUhvP/MDtkeLDyK07bRkralwzjP2cXrwExUl1ehiiU+
         weojPMHcNIBeTqsYNzje6uVeQUj8Z8HOx3bt6n4B82YTKeGRsUpg8NwFUES4w7a4Gs/5
         56mCbHHBRlVeobGt4GUMoDF74v9FV0c76XKKSthSo+Vjh8QWCX0CTirrwxoH7EKqt04w
         BtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950958; x=1755555758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BPMyMVy4Q6wAfzkb5VkKhfm5jUZ+GnJD9nh3Em4VNc=;
        b=dnYNxXaelfqQFLytam/MRESL+TEiHeosuYyxFhB45ORHhJpoQDu/02PlEHa1oBhn20
         qhhLKox31y0r86lVB0y64Ce24lcxF1moJP2qMs/1sTC82RXfn9lQ6E0eXhLPCGEbJznb
         HrHRuVYgPhAoXrfLVD7W3DtR20QJb0QWfdJmAXIRifgZ3BOFdXjo9y/k7iApFXLRivLa
         lPz0rIgILkBo403pSfUEJhT5xrz8bHxvlaZ8f1N2kuR9mTIwmQpDxLyfN9GpJMNLpDqO
         CEfRMJ/Yhgh0J09mkFMtOsdDk7TNUy2vmSblovCNsKK2zl1wAaBNniVwsBghBmaiOflY
         wwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcHoxxUQgdLLflZdtAAatbjcAwBif6khvsjVuIDaDzurujJERMA++IcpZr63o9O26/1gArgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4skINBGukaNkBYvm5aQMgtzkiLC0CiJ0USTvXjEY2STII4eR
	3GG7sasqA0HnabLODMOp9x8a51exsh1wmDT0ePshZxk8ZPKrFT2EQGbRgYJG7rR9iLY0ua1jI7U
	tr83CJsQbPT/fqSyQuAOcts2dBaSEGKZE0i/cH8Q4CLcdj2D8hDI=
X-Gm-Gg: ASbGnctQWtR3LM3/WwAzS9tHq5Wh8//iqbBldHYXDBw1mz+OodFVRLuXZ2Y6Nzo4LE4
	0/c3YY78a/QGiVKhKUinQ/Bsqu8qir0u80DNUFjQiKgN9dCGwXYbed5Mnv9JnhMK00AJUZ627s2
	hnS52LvJvbsr94e7EanXGsERYZn0G1wUd03hUOJ489e7KjQfpcP2jqlZ25rXPpHlhaYSnlyrTHB
	ERVZkc=
X-Google-Smtp-Source: AGHT+IEeRmbDpiSfjiaV21PpqwH99LxECSMMnR6hbqnkKT4Zv6LEevHwWoBCmuUH2YHSfVGP9WPOjYsSuG7CvQTcRck=
X-Received: by 2002:a17:90b:3d8f:b0:31f:20a:b54c with SMTP id
 98e67ed59e1d1-321c08d9221mr1915423a91.0.1754950958529; Mon, 11 Aug 2025
 15:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705074810.102784-1-kfatyuip@gmail.com>
In-Reply-To: <20250705074810.102784-1-kfatyuip@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:22:27 -0400
X-Gm-Features: Ac12FXyMLtQGcotEjui80IfdSU1hCLve4NUGYX6P7D9R0h9Gl2DV39jCYC7rIZY
Message-ID: <CAHC9VhTgBsr5fws_O-fYpuD8qPZswS=M-e7=r0tKF_3FfuvRCg@mail.gmail.com>
Subject: Re: [PATCH] audit: fix typo in auditfilter.c comment
To: kfatyuip@gmail.com
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 3:49=E2=80=AFAM <kfatyuip@gmail.com> wrote:
>
> From: Kieran Moy <kfatyuip@gmail.com>
>
> Correct the misspelling of "searching" (was "serarching")
> in the function documentation for audit_update_lsm_rules.
>
> Found via code inspection, no functional impact.
>
> Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
> ---
>  kernel/auditfilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks!

--=20
paul-moore.com
