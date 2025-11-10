Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496C19CD05
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816434; cv=none; b=ryfTdiWPFW9kv6MqFcSLsJ1N177EI4aaxPh4cROO+i21CYIGivNhUPvKkomQjSkpj4uuit2U9RKr5I1JymIKLynVsz+TenzCmQNcAAl2R/Bjv8Cyd3E93GBPx8fNgcT6GLAqFEuak963v9LTQH9D+SnDDmjHsbggW6imL+wmiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816434; c=relaxed/simple;
	bh=6HrRYtMJ/Wfde6dGoSgVBHgpsjkZ4V5YvSNZm+omjEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx1FczQDpQD7urq/lkoPOhTp3o7wb9rmCWarEKpoGpM1KPj1iE7r96VY2ZW+a2FXtZkiVjVdS/RU569UrKX12PkYUJKbgL4uPjuXXQBDVNxmq+pKXFZsHi1IYUdJLmkNNoQPBGfadFB3caGksrni+0to77SdR60lyaSjkyiaaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RXDBiAkn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RXDBiAkn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3437af8444cso1827267a91.2
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 15:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762816432; x=1763421232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3KPhXF0t2wnycc2aLqfqc1/q03aoID4kpmhgGyPorc=;
        b=RXDBiAkn2dVPauk49CpNDOtPnDvSFfSspcrEAPutbLHjiBHmU1W1Ub62avfwLMPtyK
         SQWjsersDoMq9bs4StfgDCQwkqwxJsZpLVnA8Y7kA2p22+B5UUBgOF+JcseAGc4jOlOm
         sMOeLSW22SdBJUHAIwlZdbuJRl52SOQJNJ6EV+6dDsItSbt25/KRq0tMVbY6XtdbU0vk
         MkBSyM0rHtyPpnsWE+kXlPOffLGxD1A83l5m33Qmn2cBrOz2TjaiIqyYb5DG2zTwFqpp
         7Hgh8M8LISoDLOpDJnzozZZRw5TPRWzY9PRCXUkrC0kG+r16N2mS+l8HkXl/13J8X0Mk
         L4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816432; x=1763421232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3KPhXF0t2wnycc2aLqfqc1/q03aoID4kpmhgGyPorc=;
        b=G5lXpXlcxbeFAT3GclVWj0jS9nAkbRUb0vHuIzfSQK7AYjUou3MN5dz/10MqObK7F6
         yESAIqkUFXzTKd7RbXcoNBe8ZQtlxLMPu4vuAadGyz7vL/nUd4zvBloxOVgv8CpV0dJs
         g66VcpiG3W5oMJc4BPgVyGmJJTDLnDd0ihXgO12rhqeuWgb7mxYmEePqp+2nijSbbl5P
         LiZQVQ9JZmTZ/Kf85B3DzY5pl/rpuXYOBkOdwy61AsZIiqSWj2DzlQLgOJEgROgoLbOW
         v+4dpAzFQfSwk60sgx3fRBtlJybjjW/tquF+EvE7Oti0PAj6VyI1ox5pxVnAx05miJsW
         iHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZQ70eyv5V6X3wuO1e+tl0UWY3o5WQpT58t+xAjVWKhWVAtVFBXtbKgQEIwDhMy3UsQJZwQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8KMctUqt31QIbGhDT0wdEKPTEYN7wtn2r8F6FYvdJia9Peam
	1T6R89BZI0jvezzWBO1WVKaDACS23L+w08b0HcBcUjlW9GqlheBmUh21hqJZ49WoRJPLsOKxoGm
	wq4RMkZIHCUbBXBnDI4pVegSJBZUIYA/hSqOoMQ2J
X-Gm-Gg: ASbGncuH+htzGEWgR5+4lhWxf0R55ArWsZJTjmhOkneA+NtYtUZvkG7QUEEVXhIEGu7
	XScG5ATrRLOOGWG8nJCxLLg7najx2jzo8GUsP61M7p6GAL6bRSbWufCw29YEbvNQvASxgCt0ELL
	B56kMLVPzppNzaIkr1aesXmi5aXZfaPLS1tPgLhQxFgQLoEFMo5ZS1AN55FQ0uxbweHX1PQZDH9
	Z8/JqdU77sAhOlvtDmxqR4BnnIpsIZCQ6/SxVnD2RYFV/MHCLr4heGsp1B2
X-Google-Smtp-Source: AGHT+IFYNRYOcq3lXTSLxepvhFlsqHyQOENBHvM+0XEW3jFrOeqIEOlKzMsifFBfU3mbMDgiQHfz3UnA14dsSUJ+7p0=
X-Received: by 2002:a17:90b:1809:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-3436cb73f03mr11262409a91.4.1762816432065; Mon, 10 Nov 2025
 15:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk> <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 18:13:39 -0500
X-Gm-Features: AWmQ_bnCgAh0ZKGySfJXTPcRIiGidW5nkGfPuxkAP29SXlrBtrADhb7UtVTCqhw
Message-ID: <CAHC9VhQjzt0nJnbwXuwT7UPBwtHjEOPZu6z=c=G=+-Wdkuj5Vw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Originally we tried to avoid multiple insertions into audit names array
> during retry loop by a cute hack - memorize the userland pointer and
> if there already is a match, just grab an extra reference to it.
>
> Cute as it had been, it had problems - two identical pointers had
> audit aux entries merged, two identical strings did not.  Having
> different behaviour for syscalls that differ only by addresses of
> otherwise identical string arguments is obviously wrong - if nothing
> else, compiler can decide to merge identical string literals.
>
> Besides, this hack does nothing for non-audited processes - they get
> a fresh copy for retry.  It's not time-critical, but having behaviour
> subtly differ that way is bogus.
>
> These days we have very few places that import filename more than once
> (9 functions total) and it's easy to massage them so we get rid of all
> re-imports.  With that done, we don't need audit_reusename() anymore.
> There's no need to memorize userland pointer either.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c            | 11 +++--------
>  include/linux/audit.h | 11 -----------
>  include/linux/fs.h    |  1 -
>  kernel/auditsc.c      | 23 -----------------------
>  4 files changed, 3 insertions(+), 43 deletions(-)

Looks reasonable to me.  Not sure if you've run it through the
audit-testsuite yet, but I'm building a test kernel as I write this,
I'll let you know how it goes.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
