Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3823E34D
	for <audit@vger.kernel.org>; Fri, 11 Apr 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394639; cv=none; b=I1gox+X2hb+Fdccn1X4zer3KPsa+IDEG7/6J85hawJfeU8eiMo26n1HVu/WMgLihIiodU8hOD6VEUeQ/WnYWqV4v8n9q9eG7VgjKX/L757aag5FKFikXNlpwxQq58Tb40WGfKruk1xz0OazYjdNRpbg01RbdAM+Zy9W+4p5/ncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394639; c=relaxed/simple;
	bh=x8x+1RUUuoyKVvm4rwiW1cGjTypYl2uDQbLP7Tq+/ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anyC2GrUKlRYH8GODRep0QyXUuPLUH2C5Xqrvjb+alWxW0eDIecgd9iD03NSu75eRDbRmw+QDJ+3YPQhEF6ECO1eG/fhb588qcveqk/84+3O8amNEyhiBc/GkLOD/Z5+E391/4ZEyN3KnZnXg4SFEzhf09qEG851CSKGeHbf4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DXEJAYp/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DXEJAYp/"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e702ba24abaso1733675276.0
        for <audit@vger.kernel.org>; Fri, 11 Apr 2025 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744394635; x=1744999435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwUA3HJN+kY+Z/XkRzxrR6K4yzKq89b6kJGOJP40UfI=;
        b=DXEJAYp/YUT7qY6hWE5d6lyGPp2cKofR+BrACFakl3jhGZK4x7NOmb7mrlsQcidUne
         Z7iolTqlMEpZXIWQAQs+2UG+8Sms2U2H34sDS6L0SvEQSrQ9SATrHLkpmaoDayLcSFue
         hcZnJ0rqsXhF5MA6Oc6um1Re4WKSBcskP30SssltzMccn+NrC5UL7ZU6Q3yQCuGsSUoE
         a3qqiZ73WokBSChm+m5VNK1lV1Z6ahrStLtLyVfMuL3GoDQh4NBwD3qUGamOwTv6crD9
         K0xjJt3YiypUckpk3H+HPP9uwIdzDK1v5TpEze5ugZ5XOSXTWizUJLL6q/Oq+4zz3Rs3
         QIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744394635; x=1744999435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwUA3HJN+kY+Z/XkRzxrR6K4yzKq89b6kJGOJP40UfI=;
        b=UgKPFe8ARkqFgBltUyMeDufsFSf7GBwMD1dRkDWxzq43Zkp8Zt3vWbe2LL4QaZFHGa
         BIbTrMe6q8MeOYIOgo0EBBoWZK1UdlY1c0Fii7r0fmV6JCPgcHqcrdscIRTj0GPDVG6k
         ULJ47T2/p8YSvz6fZF96qF/qnMT1uviXyRVvbInekdu2sExq4CzYq1hOKQVkm9dq1W6c
         M4nsA8nl8yUZ757eZhD1GMQAFr2CKX/cs0HN7qT89h4kIzHPf/td63HNTWogUC4LN9qY
         hJxjtBOx5BLSKV6KdkAq7QzzxYdaQL0+mkrk6WBPA0X2OeTiw/Po+9S04F6hYEeyf7Lr
         f4xw==
X-Forwarded-Encrypted: i=1; AJvYcCXW9DEpQsOqSBEJExmPIMdGYWF8X1o1mTiZiSQWyfTdSHAy1uBIhiWygDZqrOa3Vm9T2t8e1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuyOumpJVgbupf6uNl9VVfs5eH9oDjO36MAQwZS3SNZRKc4cP
	ruFuGFHtGvNv0wXN4AYyIPwQUgDwq6MrxDx15usVzdJS329//8H5wFhQFIRPrh5rpu0+Fxa+AMB
	iBnZat7tUbv1rtNXGe+Mqmrzust3Z3w7xP8Yf
X-Gm-Gg: ASbGncstMC9h8TEa/5Sh1SlNI3BQuLEhCLcspSBJerCw2kDd87wMG0gtpDD899CViT+
	GIkTXZJvuJaqlmtVj0YW4t/uo5dwUdetiRmduCnLyvJke0AaxMZTtHYK6nk1l24+AiF+pAmjXc8
	2LYg/isa0TB0p/SVKVaL6TTg==
X-Google-Smtp-Source: AGHT+IEECo1qjKE9+f5KAGYFBltXYqlNcShZy0OxIxRF/dripUpXcghaKlFEoodTVnpFvHNNqn3e9noR9gmhbN9E1gs=
X-Received: by 2002:a05:6902:1404:b0:e6d:f0a6:4cdc with SMTP id
 3f1490d57ef6-e704deca03bmr6577544276.20.1744394635152; Fri, 11 Apr 2025
 11:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com> <c7f860b806603cd8af7740c73db68197@paul-moore.com>
In-Reply-To: <c7f860b806603cd8af7740c73db68197@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 14:03:44 -0400
X-Gm-Features: ATxdqUEPAvVP9dZVohwiFoxW7AmOhM6emkPlKEK8JPh8cs8epZY_MHf0QmZ7qQk
Message-ID: <CAHC9VhT9VKQuWONEoosKtB_n=xLz6rrRubmEZi8_+dQrJe3nBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] audit: Mark audit_log_vformat() with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mar 13, 2025 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote=
:
> >
> > audit_log_vformat() is using printf() type of format, and GCC compiler
> > (Debian 14.2.0-17) is not happy about this:
> >
> > kernel/audit.c:1978:9: error: function =E2=80=98audit_log_vformat=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Werror=3Dsuggest-attribute=3Dformat]
> > kernel/audit.c:1987:17: error: function =E2=80=98audit_log_vformat=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Werror=3Dsuggest-attribute=3Dformat]
> >
> > Fix the compilation errors (`make W=3D1` when CONFIG_WERROR=3Dy, which =
is default)
> > by adding __printf() attribute.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: added necessary technical information to the commit message (Paul)
> >
> >  kernel/audit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Merged into audit/dev-staging, this will move to audit/dev after the
> upcoming merge window.

... and now it is in audit/dev, thanks.

--=20
paul-moore.com
