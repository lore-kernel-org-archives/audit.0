Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8222272E6E
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381308; cv=none; b=Mfp/1UUhQXd43E1vSUqVJDoPxuDGJHxMn4gsww4zZ30wuzI8JKr6Z0K1kxeKAylHZpYvsKKdPkTy+mvcSosRy1ZdEA5BpTTYb0DkAJEQEC7ECwUj8SGpbzLL7YyDitzcALA0JKa7TC1gSvg2uXrjMZY9qDX0/dxK3e6SU4nfc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381308; c=relaxed/simple;
	bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUCLHTkbKsl6ws0d3pdvQr7Tmx+P4VZRqwxStkwlZpD3lOzCVJuCE90mwodjqR6eDHRbBWYpbXHrS87Mh2GMlJJub+U/QubyGgPCCQ9XcHPfqUO0OuTX3rDPz6IUL0cf94UM2hNluguA+up4pJJIGUiRFHqg89e7dNt+2w3Y1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I7eXGvwx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I7eXGvwx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3679232a91.1
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760381306; x=1760986106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
        b=I7eXGvwxsC9hd9WQ1Js9QJyZUabM2yER12oZD+qn1NjgichCUT2g+6nGxWXuqDv3pr
         VEeYuRItnOYaC3dMwsa12db6OFBJkz2Fcod0h0jCAjNO9GBdUxHDXPB+zdPckVGInnII
         5wYyom4zoGgZBMrlncvCTOcA93V2CX63mdmHDZjHHuuJs9vw5E9f5Mn2meaXMK+dSYry
         hrrmBsAustQFhwO3qoglOfoDdasDf/1TKSt5kJZLvetAOQk/ia9fhIeMP1Zd//a1RmE8
         uNbAGqhNRJ3FySpcoDF0ZaitR8PEXw1nhVuvXKSvPLbuzuGu8Rkg6PRwPlle/VmZZPDx
         QgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381306; x=1760986106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
        b=IAHDC6Gomf4TgsaB1k3MhjLt8BrOdmytBxjfzuU7tvWzm9bsoV7wZIW+7m1POw4d14
         Znxv5zgumj4pLXh6bdc+mHlglaZsOJnB97KzK3l7DaojlU2Qst0g/qLXW6WRorOa4M+5
         xwJ9sZrlu/6bFtNCS1UA0xt65C9VjhHZYLfXpu5xzO6kJdqFXRAGZafjMv6uB1mSI7bp
         FPqRorPSIaes3l9qVCN3lJOS4EHFXUaB7YzP28Z95lr1mDDKFSsovC29uMntsL3kPN+C
         seY3mwtgdcVMo06qwoJLGr1dx48pcohFqW6JSwqUTMAz+zVF0zlGA/KBg13gJmYj7zFF
         Y2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVqdpIhdWw06JCcvpqnjNdRR+b/ftzdcOAERsheStkvyLOZOd8L6YdF+u4lF1KeiG6VY0bLfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6LZsVHNP0l/Mzl+f0UlN2Cu8zJFHZj75B5OemDRnCmu7dKvL
	OY1ttdnruRx+0GJe0tXs5WmeorjCD8afQoriHiFHj8NwZ5TzQlUB4+qVd+38Zwg0ysUD5dZcfi/
	C/5gyfycdvnTzZTwe99cccd49w0cuw04bC7G6Tb35
X-Gm-Gg: ASbGncuy/Fx155lxBKt18x7KDMeCy3s32tXnWUhmoJX4DQxRdkGZtGxdWrhsZ2WMn4m
	ZIfN70EX/hY5ZNdMy3WYzzfbhuNe7hvm3D6kfXtiOX4opxVtPm7AvHC3fvTouGIH3S+dvPrAH74
	JUP6oa18eoh28uCrryw5vg2O3UwSyPr6n4gYX7rLFpw2aoKcfnzCxZIQKGtK8p0id0LvbxdfxQI
	KPJhYDFWwL3qofZrPCDkJRtQQw6q+q6kyra
X-Google-Smtp-Source: AGHT+IGZN58oraJKYOel3htu345mI+OrYGHA9s9qA4axG5xZODKhYm0YNJs/VRer0wpLSUpLTcJwFs9Oclh2FLyAP1g=
X-Received: by 2002:a17:90b:37cf:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-339edaadd9bmr33999353a91.10.1760381306209; Mon, 13 Oct 2025
 11:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
In-Reply-To: <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 14:48:14 -0400
X-Gm-Features: AS18NWADP04PjUwD5Bh9EaCBl6eZqSpZ9M9cNZXWZbUAMAyKy1WbW4DhJu7OJ44
Message-ID: <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de> w=
rote:
> > Ricardo Robaina <rrobaina@redhat.com> wrote:

...

> > Maybe Paul would be open to adding something like audit_log_packet() to
> > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > common helper.
>
> It sounds like a good idea to me. What do you think, Paul?

Seems like a good idea to me too.

--=20
paul-moore.com
