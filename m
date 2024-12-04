Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC08827
	for <audit@vger.kernel.org>; Wed,  4 Dec 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319384; cv=none; b=rEXlh3JWLDiiGGZAHDmd4qzhnkKIYdRjAjo0tM4sRnNv17nYQb2dqmQ4Oy+nRlpvZl1OG1DyU3qOlizzp0Usgz48Hyv2dJ/a6jHlU9ceu3GTDT2LHdairOoQ0aDyehCyXrBnUhqkcydhWxesvcPn5zOO4+4H4Fz8MffljW9ZAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319384; c=relaxed/simple;
	bh=G3H9vPm74tu0lvdzHCfMTn/mY2bbhXewyUb/tIQ3V/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdMe6vsHq4k90dbEq5BcNhEgwUHFNtw7L2qVUVjxV812eB3ghZ/Kvz7lRKSzP9IobT+F9wJwYv5N/FBZzLpkqXnaJ063iNotOff6iFRP4i5hKXu6xLO3fDU6lvU7z7R8MkfsvMHynISGQc5CL4WBtuRlRBAJexkiMWgalOPh8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KudvbPzj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KudvbPzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAKk5WRAWeLj8mWsqp9Osu+484W5ZjNbKQlb66yg3SM=;
	b=KudvbPzjWvVY4meXmAFxKHdQta47OAi9mtNOZ7n+sjy0JZEgQ3niIFRo57JG3LwDvYydi+
	O3ItMWoKoMq7wCxYAfmRak22iaXsqkIUJKNvgRhGcTvD01kT7OtU3Frs7skTJb1EvqNuHS
	1hMKZsXorYx0njrX+3DDxR6z6EaSfMY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-C6mzAKVONYaCgFzha-FskQ-1; Wed, 04 Dec 2024 08:36:18 -0500
X-MC-Unique: C6mzAKVONYaCgFzha-FskQ-1
X-Mimecast-MFC-AGG-ID: C6mzAKVONYaCgFzha-FskQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa53d22f651so414273066b.1
        for <audit@vger.kernel.org>; Wed, 04 Dec 2024 05:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319377; x=1733924177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAKk5WRAWeLj8mWsqp9Osu+484W5ZjNbKQlb66yg3SM=;
        b=RzMtMfomWNXB91q0+Jec7x1t/7WJJUXCzfcbb+fYlAWmEl2GCoP0Vx9MQnZ4oKE5Bw
         a6Kw/RTwprEN4UbddnY0WSxWP8LCOVa9Z+CijQ1vXTRATUxi/CHhHsdZBhcT0oEVUrCf
         Zo78QA35iDH/tgC+Szsd0dOEsf7xI8FfXAHxHrKLWHUj+WJPzht647ZfRetCQGPlhMyI
         QyvMGQZpQX/rhKyfwfeFUi6tW6d4DqnjSuPPXl9Kk5hVvCdZ5xTIGjlASl2n9M5PIub+
         IK5eGZ/zdXbhSYUo5ikJZ3p29ckHIRwTYvMX8GcAKqRy31zjxXkNMJx1HcPQQIsnvn9+
         EuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXfapprlIR7quiRAx1AhjYHzCcK/Ojq3z7xsR2gT/kwRxkfoTvjPKtVsFtKrN8fK9ovz5un0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrigp17ctiG7wbe5yYzvsFPzSv0lC1wVyDbcYwcFRx+yG0g4gG
	Yna1J66zSTsUtyBp8LYn5usj7GmfiCabI9nyeAAkykqn8xfoH3M6gulrjdAxXlfSOsmoFn91F6o
	8EELDNesQfMkgFLHK23S+FvJt6Ulj1zmBodayctTSQrS9DhvJ6tFfzm/CJNkRvsKObfcZ1ujJG8
	zpCHNoPVyTvJ3oQlltiCwIAq8blE8=
X-Gm-Gg: ASbGncv7npt0ZzzaHGrqmmsNZGk2SNJ/20KLgoeikr1ixiCbDq8H90m2zaKCnTb8AAA
	XoCyAZgymuVDD0G8xDVkh12cZ1jElc43tfrnxwSHmclJP3SXEJHZxqkWQ3RHwL0ee
X-Received: by 2002:a17:906:329a:b0:aa3:49b6:243 with SMTP id a640c23a62f3a-aa5f7cc14f8mr413856266b.9.1733319377602;
        Wed, 04 Dec 2024 05:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9EZvVnmBeGnetwReNdL3BjxaGWr5jMEtJFqHT7yFYKm3v/3OzQl7rY1r9CK1O+SUO5D0KIc+BN2UTnSYPnuo=
X-Received: by 2002:a17:906:329a:b0:aa3:49b6:243 with SMTP id
 a640c23a62f3a-aa5f7cc14f8mr413854066b.9.1733319377242; Wed, 04 Dec 2024
 05:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105123807.1257948-1-rrobaina@redhat.com> <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
 <20241113230425.GJ3387508@ZenIV> <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20241114040948.GK3387508@ZenIV> <CAHC9VhTyp6ao8n0EVp_JdgRXFfP0nLkf0YMKPmiAurFJ_CM0fQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTyp6ao8n0EVp_JdgRXFfP0nLkf0YMKPmiAurFJ_CM0fQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 4 Dec 2024 10:36:06 -0300
Message-ID: <CAABTaaCXu6aeTLwVngOpnCVQJ1z3_TYcdjiA=nkvGyvTN1O8TQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, rgb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Ehf4J9kzj2NKc4bienlNstTv1bUWGLR-tjJKYHyapA_1733319378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone, thank you all who reviewed this patch!

On Wed, Nov 27, 2024 at 2:43=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> > Anyway, regarding audit_compare_dname_path(), handling just the last '/=
' is
> > not enough - there might be any number of trailing slashes, not just on=
e.
>
> Good reminder, thanks.  I see that Ricardo has sent an updated patch,
> I haven't looked at it yet (waiting for the merge window to close),
> but hopefully he has taken that into account (hint: now would be a
> good time to verify that Ricardo <g>).
>

Yes, I did take this into account. As well as the other cleanup suggestions=
.

- Ricardo

