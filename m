Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6583A6F05
	for <audit@vger.kernel.org>; Mon,  9 Mar 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058978; cv=none; b=kNg5KM6IpVCBzW47M8n3k6Vg3i+EdgQtVIP3T8V4YiaL99BV6Ji2wVtLPXVv4bu95wWHTAXXGFY0HKMdtCgV5CitlwahQzoU7d0Bj/khD1zo1IHPwxNNqBc7kRge890M9FAfF72vOD0toqGMvXI1D3GBrOaacCjUYmy6EcbdhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058978; c=relaxed/simple;
	bh=pQ1D47PLPGLOmkkXY9JWgTiYocFRNXWOiG8Y1MEkywg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhT7YylFNE7WIH/Qs2y8brMZjkIzCWZbq5TGDVvgKKWxY8bPk16s6dLIkyVV1+6MV2q/R5wVoO97oeWwZG+z0LFpS4DzIrbk5loyv4BX1M7IWBSvnt9vCrf22DKhG3OoYu67xtcIobWCYpt/jKK8NGfR740cqXFloIhMJjGbLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uoo7jtXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uoo7jtXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773058975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mW96D8tAtkkQwwjsVACwpnMPM4QBA+efjiTkirEJVEc=;
	b=Uoo7jtXg5p820k/TpVtoraK3Rf++zDqDaOkz1Il8KBYhYMpqVhJ/oCTGrgJzgeGWdbLlDO
	aFWSNYofzzf8QxhgHUB4rBS22jIA9y2T3aRtS7OUC0BcIDQeSx1I0UNhO0hgjJ5kuZa6wG
	CgbWMO0AMswsbHDhFXvlxyCrUZe+e0c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-RY4UoRXaOWuPlpqYNeVtUQ-1; Mon, 09 Mar 2026 08:22:52 -0400
X-MC-Unique: RY4UoRXaOWuPlpqYNeVtUQ-1
X-Mimecast-MFC-AGG-ID: RY4UoRXaOWuPlpqYNeVtUQ_1773058972
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-661aff85c3eso4928680a12.2
        for <audit@vger.kernel.org>; Mon, 09 Mar 2026 05:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058971; x=1773663771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mW96D8tAtkkQwwjsVACwpnMPM4QBA+efjiTkirEJVEc=;
        b=Kk3NRn/tOJw4TzUuVN6S3ye5m2/rnb+j5JXf8m+0zE4ueNmrLU2s4dfYmsMHtj0971
         h1mO75Jxv3bDxyI02u07iz6hYnKiatYSngqSlwN3ix3yKgBcjtRh91h0cJ7VKveal/q9
         0aXhDKURkGZmhhMnTwnJywYn2/8diJMk3YqzZffV1TSJ/D3Bc0kFQRzR6YjGXrGxLpqf
         Dzah1xxyHfIdj/1eKmru0UZ7eEeJxeQ48s6PFHyi1baKrSNah/B9UVu8utFC9NZs1srF
         O/6AsedZ3sHnWS8KuEJ/CH3Do4ko8FVk7+stFoJtWtWdfWgcqWWswlooKiAy7oISNPtl
         iKYg==
X-Gm-Message-State: AOJu0YyIGKT+ZMeO8eI1yyOEqeRqibSTfrP+BSJptIg7gnwlvHaeKHa2
	Tote7VBF2xwavIwA7HwEoRESq887sE+rwV3/qM4+JGnQQAjxUzpnK6kxQnZtgjAXpqKUvSjyBkE
	FvDlTDEySAZa4dw218qQUEUz/qymlrLFhRbEAhWNsVNLhtvZAsUIDTTOJUvNPZcsZKJpcL6ABqw
	I+Vm7E6aXCDCx7mVT0xTqJXfUY7o4WXOA2nxVKgto=
X-Gm-Gg: ATEYQzy/SJUyH40juo4l3BDWfrac7XVpG2xq4JSVzm8/UWGxg2y7/u7J1QoVXsj3CRc
	sayW3LVhSnUiHFxkvu/q78yafSJAGIrfBODywzUeuX7oKW8jtcyvaT4Z3ZjgmLRCj7PY5GGQvyj
	hWOcO0K1q2M5GL0Ij4wYbLEGdMQoWUevXSV+UGVXXbGIQaxDi7yKJZ0ajM1uyHLKP7s7fhYFFzG
	WD9I3NBZFfue5f/dqckSBKyP7G/rE3s2yNk4Mt8FOuaG+M5j0r3JsjgO71JiezIUYNkL9c/1XQt
	DKiHPIUIHMzsUE/XxE9njB0=
X-Received: by 2002:a17:907:720e:b0:b93:3c03:706e with SMTP id a640c23a62f3a-b942e02499bmr639376266b.52.1773058971178;
        Mon, 09 Mar 2026 05:22:51 -0700 (PDT)
X-Received: by 2002:a17:907:720e:b0:b93:3c03:706e with SMTP id
 a640c23a62f3a-b942e02499bmr639373766b.52.1773058970666; Mon, 09 Mar 2026
 05:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303133528.704135-1-rrobaina@redhat.com> <2de50f30bb93c06044c56fa150587c56@paul-moore.com>
In-Reply-To: <2de50f30bb93c06044c56fa150587c56@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 9 Mar 2026 09:22:39 -0300
X-Gm-Features: AaiRm503cnnekwE32lc7f6njdylw6XOidkYjZWYS8PwM7UEXrSaEUlWVpDqCyLc
Message-ID: <CAABTaaA8x39aZYGVEhhnf9WFsemx9Eetp99cabFBE+W=Edr9mw@mail.gmail.com>
Subject: Re: [PATCH] audit: fix coding style issues
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bvcILRp7NZOte-4K3rd43VNsqC8gA7si_LEyy4q5RqM_1773058972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Fri, Mar 6, 2026 at 12:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mar  3, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Fix various coding style issues across the audit subsystem flagged
> > by checkpatch.pl script to adhere to kernel coding standards.
> >
> > Specific changes include:
> > - kernel/auditfilter.c: Move the open brace '{' to the previous line
> >   for the audit_ops array declaration.
> > - lib/audit.c: Add a required space before the open parenthesis '('.
> > - include/uapi/linux/audit.h: Enclose the complex macro value for
> >   AUDIT_UID_UNSET in parentheses.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/uapi/linux/audit.h | 2 +-
> >  kernel/auditfilter.c       | 3 +--
> >  lib/audit.c                | 2 +-
> >  3 files changed, 3 insertions(+), 4 deletions(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

