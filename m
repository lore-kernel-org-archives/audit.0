Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4861211C
	for <audit@vger.kernel.org>; Wed, 23 Oct 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642035; cv=none; b=MeIGgPmawY0eX9NtTHLSTywVMJD+5Xc6pjl1fkQs6CwMd4zaKw8Js6jDB4Kwwfq3yne2/03Mvk4KwhO+h211BFS++hxV9NjVK1dB5yx3S6S6DAe9agJqojdekZfl4/kfA4HWtt2IH1yUiIU9j1sT30o03IimVLNqQ/1ur7Xha/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642035; c=relaxed/simple;
	bh=jnkmrhzcYEBP1z5umBcm+wct455Zpt09cYoU6UgmM44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVDFxSd+3BJliHiUakKV5XDb+DMLJ9QsNiQr2aakitWth9Zby5+7Cw0Wfhr6gox09HOin17ML/eZ29aljJaawAj46I3f158QqtQCPQXbR7IPPozfGvNeHrr4h2/Gf4ZVrLQJO0M49FhikWw9tzqBv4wONnVgdaZNp2eljIueU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eRUJwDjH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eRUJwDjH"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e291f1d659aso5751449276.3
        for <audit@vger.kernel.org>; Tue, 22 Oct 2024 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729642032; x=1730246832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ1cEM3+cfdDVolwI+TVxmBRgBuH+HcUtwUKGDw1jOg=;
        b=eRUJwDjHS+L1w2jAhHi2l3HJk9EkcEPSCmNPnOH5vPZ5UcUqCXPvrCoibUBIaixzKA
         Cjz7XVOAsiReOXyh0GKicCeDjTAGyuzZ00syFzef9ZZqlhFRb2xKoQXdZ/2jv3HUM7V/
         Gzy1vV3mTBGZLvAncXl1yr8OF1NV4mIOEO71qMzLI2JwvT1qdnhjiLRxTIsjPkJJUBjP
         IY2gF18i7wFB2A8BJ8PACuthgYRQMjfwNqpcp5it5iNv5nfIJ6XUFoOrBUbFjGXdNQ0c
         SmKoWl7LeeLg57q9UrZhlXLWSsRyOsDbmmnKuD9+LaBSnERvfIK3EADUvVmdo+K43NqN
         QD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642032; x=1730246832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ1cEM3+cfdDVolwI+TVxmBRgBuH+HcUtwUKGDw1jOg=;
        b=GHSkJMJytHVC5WZkYCTYZQS+PQZlNwUgI5UEyD+e8fYQm0x5YyAEBmPQwaQCRdfPQ8
         oR/jsHr9bs7Ervjze9IKjzS5so2VMVSlDsntHvl5HmZQVe1Y88UOhgvrjs9Z07mPGO8b
         txk2xLm+dltWczHgrNY4o98xePzNVAeeIJ8V2omw09rAQw2MPZwxM4BX8s1PfORxGrP0
         p+e4diR/UeKCSxwHAQtv6y41mOUoz5q0DCWkeiB7CN46NFpxW7Se4YClsLnCLv2QwrB+
         fcyiXOMA312q12YzRlLfTp+qcw+mcg5nluzKjUWCETwnoDTgXVBDVva4J9pC/LZISfWq
         tIPw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJ6pL64SI88EMR0Y0L8lLQPK+gax33RBD+ykLSiueQCh5K1t2yIZidaoluD8vBmEexYiX9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcZBPIpk7UItKIBcnAnL827vFy1ZowlKKoi4+dyfkQ5FYAgLG
	fQPNEH+De/sxIiq4RlvEOgcdsFEK6jR5uIyRClPPD1uViYOXtD2Eju1WldRJcAL3GTkFmZLYHT7
	rrDD3+0ZBetJ3fHJM6DH2DBeHtp6PdqSdTANg
X-Google-Smtp-Source: AGHT+IGRQVLuzK/6CI72ZCGfa+itwlB7gy9YsYEKhzbjk3Wk8pfQGvbN/bdOxVk2v0pzUnLnPXZpycf7NH1xudzUmus=
X-Received: by 2002:a05:690c:6c8b:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6e7f0e30a3fmr9811487b3.20.1729642031640; Tue, 22 Oct 2024
 17:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-2-mic@digikod.net>
In-Reply-To: <20241022161009.982584-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 20:07:00 -0400
Message-ID: <CAHC9VhShPEpM4_fPoTSqStMnMB0-n1m6scS5b0Syj5V4RvrFOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT
 is set
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and the
> dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> are found by the linker.  dump_common_audit_data() should then failed to
> build when CONFIG_NET is not set. However, because the compiler is
> smart, it knows that audit_log_start() always return NULL when
> !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> a side effect, dump_common_audit_data() is not built and the linker
> doesn't error out because of missing symbols.
>
> Let's only build lsm_audit.o when CONFIG_AUDIT is set.
>
> ipv4_skb_to_auditdata() and ipv6_skb_to_auditdata() are only used by
> Smack if CONFIG_AUDIT is set, so they don't need fake implementations.
>
> Because common_lsm_audit() is used in multiple places without
> CONFIG_AUDIT checks, add a fake implementation.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-2-mic@digikod.net
> ---
>  include/linux/lsm_audit.h | 14 ++++++++++++++
>  security/Makefile         |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)

I think this fix is the right thing to do regardless of the rest of
the patchset so I've merged it into lsm/dev, if anyone objects please
speak up.

Thanks!

--=20
paul-moore.com
