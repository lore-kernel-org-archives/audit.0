Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854472620D8
	for <audit@vger.kernel.org>; Wed, 26 Feb 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613310; cv=none; b=WkBH+A9Mr4k0gGMXGE/B5aGxiZ8NxsgaAzdacveADjXZzQMIRXqpdKjtQH/KCqk5VV2E3l8xkYv2w8NdUhFNt2HkiUhlGgVrK/KNBl1NhjPsEk4abwCixUfjIHQkBMxtUynOyVTLnZilmIfWbL0XsllZuzdzsz99GYy+BR52YiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613310; c=relaxed/simple;
	bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laJViOtxmUks7B82zw3/+KaNJHCHcngkrRss3E27up1JIRJmjGF47rLC3/J827B3KCG7+4JwaCDi8/uuPG87+nbSnStvBagwP6aHMT/eKR6P+8n/ezxgAT7QLAxkyxd7JeM5yoVhLzGD98Ere5TVdaeDzwWMgANXFpKzT9Fge4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f74K/K/a; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f74K/K/a"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efe4e3d698so3851707b3.0
        for <audit@vger.kernel.org>; Wed, 26 Feb 2025 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740613307; x=1741218107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=f74K/K/afzWjWvWsdHxzN/jH61xJHHyuPbfUP001y7a/mX6nUiQ6DZSUR4rQzkAFCx
         uOFAYRBDM75LJJ3tEtVTkKT7Pfyamp4QYiJxQoBN7PAuBLpEFKsB4bsCIFSC+EyqITA4
         MSFowOZhYMXT6smdUYfJrBJNAGtzWPePtqkaV+TeW+JQV8A86bZ4NvxrgQQwmhygBwVc
         4AyCxHkuezll/ele/Euj7pr1pPIBuQgLCodPj+v2Il0IkiTCMNdfBwh8YYMXpiUuZsUg
         jNsMH1mqRG2FYKB9txR+/jBVrF4PiuwCG7NFcaxSBTrxjJCbTAetHKMw2dcEExoHNhUR
         hHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613307; x=1741218107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=skGQD6bsC0A/ltVerG3PcDd5xYtSd0IrXEAW0EFVpG2JASt2NMh2MsDXvIipsi2nHG
         BvCbYxmbqn+C/13O++/ZHgZGEXAjqbi4fJCOx2dTuPMx2OxmMWtg3mTBjkMlUh5f7oIY
         89JqXx8wqg4BHG8ShugFMIvxYJeU8wl0KOGbONBMWu4qXvbu2lVaC0G2XqHJn+zPIItV
         1U9g8P1fXrNpTGoVxNDGRQZLhgVoO7M1KF61AuEhdcumaAN2dPgpCothZzfrbSvbfgb8
         2XToyd3a0fSK1MvEdCHglDwxRM3NUplVKjHa4n87U9a+LOYWnUJCr0sPd+wuGySUduXG
         Mpqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIcUx6qpIcFEW3ayUBcSY2dQ0pIsW9mfJ2okazgN9Ja4urIycAqoBG7iRrSlrvzU9aG/YV8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLJBYk4+OHz6QkplF4GpCnTwtFWBIOruwDwOeQIyW1FlIWaeT
	OK6xrsFcV+WPsiByfujACHdkmWc2SV2hnx/WMWdrExode2P/GeEYzdKo57iPC17LtRt7To8mD68
	4yq3wpjUhDAYFmnK1cia+qnvFgU6xCjtynmG2
X-Gm-Gg: ASbGncuX+hpyPfShpxK5ZWMdUp1P3LYJGMg89LS2UAqajbmRl8JcKx06M8/CiSAItyw
	gha159/8NtkcChZY7jUvqb1uo637Rgyqau9x/4B3JfpRIKGw0Uy0ICfUP95CI2HvrOjtKgxX0R0
	5sRjVEPoQ=
X-Google-Smtp-Source: AGHT+IGemVdA8vFM5APA46NT9uZdRK4EJWAEgmp2/eNiVxXqJ81TXGGCyav4i+lfYJLRLeB/U2Bp2pN4yp0P8tAT1hU=
X-Received: by 2002:a05:690c:38d:b0:6f6:b646:4f34 with SMTP id
 00721157ae682-6fd22074377mr57621747b3.30.1740613307514; Wed, 26 Feb 2025
 15:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131163059.1139617-11-mic@digikod.net> <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
 <20250218.aePeer3oole2@digikod.net>
In-Reply-To: <20250218.aePeer3oole2@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 18:41:36 -0500
X-Gm-Features: AQ5f1JqWYmxLqpt22zS6kb-r4-IiD-XvgZ__5B9665k_Ga0PZ4Qv98lgbWnYyX4
Message-ID: <CAHC9VhSo7L8jw2pR9x6KmVCiqucGaRqkuj+RyQXOC6jnQBcQjA@mail.gmail.com>
Subject: Re: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log
 domain status
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:21=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Are there guidance about __GFP_NOWARN for audit or other subsystems?

Unfortunately I'm not aware of anything, and I too would be very
interested in learning if there was some solid guidance around the GFP
flags as the comment block in gfp_types.h is rather short.

--=20
paul-moore.com
