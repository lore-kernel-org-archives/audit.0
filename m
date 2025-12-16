Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE7332EA7
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859550; cv=none; b=CECN97e0381uvYJgM9LcvyyB8zuQNBvc0UA81ejm+eVI9qz6ZX9nBwDg8SHQ7fcTcHAQg+jmaM6tqd8yWoiAJoS1CIdcw1s+r3XVT7v1pVBNBdSegRZkRAos3Ld81UXUVEwv92zZS5ch4Fn5qgd7hXhAJ5o+Cjtx/tIzZveJ190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859550; c=relaxed/simple;
	bh=JAC7T84OH3rJpKA9s8hbP8b38NGlwWMNJLYmPCkoa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwM/8AyswQ1G2GtigmbnPK9r1tfe2Kvza3lJHOJqqhz03YSRAZ4HUSgpC9yHFqjUzuAl5+vAGacBTDfUBhiOc70LvBSLnbT0wniblxW4Gaho96Wa11NYGKBLWbCcG3dmmqb+e/mlMrQs0pJM0lhgvh+Q87VlKggkCPX4/OoIpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dnuy74tg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dnuy74tg"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6495c4577adso5827575a12.3
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 20:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765859541; x=1766464341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u04lKI+ITCEhSjyN8l/3SfN1GaX76pkUdUELbvLmtVI=;
        b=dnuy74tgEdeg4sZQHPQgfnWfF65ZIaEb5VaAbZbGlMltJVDW0a5u0idlX00NVT9MKv
         aZEye1jQa/uTxf9x3WflndEYSycittJiYS4qGTFjnB2wgj5nLvrkoDLkfrTvUXZsVqJJ
         GjdJkjtJqCXh0J0oBfcOTARTHjwr6JFQic18M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765859541; x=1766464341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u04lKI+ITCEhSjyN8l/3SfN1GaX76pkUdUELbvLmtVI=;
        b=EhVdrBG94cdiWSOQhpKOOE7yCL6Axeoiiz8jUS9x9Kx7xZEjYLffdUMzTMzDJ/d0be
         OoPWKCj4frlU/5zXc7hwMtQW8urxCi0H3DnF1LbPXsbq/WdDP830+H65AJJBI+j7jbUI
         Mtjj6gTMjQ/3ktXpVOEa3QbWTuiHJ4gjcPUs/v9uiScUUDWQLiv2dMeqt/i0lyGQIvcX
         WQ0jV35QxywcrC3ZQl2Q0RPM4x8m+GkX+4urYecieYk+SC4rz+Yej3/G6s7bmC1NMELW
         WtDNF04ZMxNlh9OROghWiplxtQNst+PDkA7lxvWO81g801NuRWT6HnwqM8jZcYu333/u
         zV5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBssf1GupiteRMgM0lfJXEDdbjgwsR80GIg1ddshC+sM3SkXZrnux9BLKz1EBDbYk5M4d03Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YywbssNlIA7IS0Aw6ab9RqHtPJaN6XW22gQOfSS29axdm2ZTmdN
	W0x271i2g6PqCWaomZtUa/89q3QKAAW8xK/se+gezQhcTIdzLkGWYkxnTw56eNmt8BwbcUUky12
	i25zPCSh9ww==
X-Gm-Gg: AY/fxX73oBpBxwa3+YFs2lkeNB7754cbd5srD4VVIHcXXqq7/oySvuStcuc7K0cFyO0
	h+dyOIRIsYQS5DIwmOpZl2SqyExPtaQnLsbsTYo2mPIaceIpLK9sCB4PJOZH7ptqPfTJEIb097n
	UY+9YOfEoaZYmVyiH63p3J8L5PoUm7l9cAOmMeBjDTVOIgHIuceWrLH3dAH1IQSCbIk1YVBFW4t
	jMc7xJ7pAsVsWE1L2NbkmqucZGdKq0KKKrt1TGyJF77cxA9PcOGuzxfLGkTfPoN+juOQWcNSEN8
	Uql/0BIVrALl74mCPA87V2cdgjoBc169znHeGYIlPovxW8IfPJeJxbCXPEeYMU/k+CEBZYTfi/5
	4H2TmQYRJVcOnAly8MfS1+VuSIB54EwmMRFJ7mP0i3kegsagPpICgWg6+m0ZsYQpw8oJNExZBD+
	nlJg4vshPfnXzHU4Uxh2aIP4N5zQMvAw8ylZO+dYfbALboZ6HYU+lCJOYkezGc
X-Google-Smtp-Source: AGHT+IEQwq39W1Gn2Rdi5CHCc3ah9BDn54KsFDZfJ1EeZuVMy4zQYB2rVZ8dMikvMA5gZD8OxIE6yQ==
X-Received: by 2002:a17:906:c103:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b7d23d0430amr1429845266b.58.1765859540623;
        Mon, 15 Dec 2025 20:32:20 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5142efsm1548753666b.38.2025.12.15.20.32.19
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 20:32:19 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so7894464a12.0
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 20:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhQ5r68S+EITTu7ud1GS3HPa3mqVKf7A4i5wTcr9oWrNpeKh385hKTEryz6wHhlNXhQ8WosQ==@vger.kernel.org
X-Received: by 2002:a17:907:7e8d:b0:b7a:2ba7:18c0 with SMTP id
 a640c23a62f3a-b7d23d13db8mr1509432666b.61.1765859539518; Mon, 15 Dec 2025
 20:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216035518.4037331-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251216035518.4037331-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Dec 2025 16:32:03 +1200
X-Gmail-Original-Message-ID: <CAHk-=wi4j0+zDZPTr4-fyEE4qzHwNdVOwCSuPoJ4w0fpDZcDRQ@mail.gmail.com>
X-Gm-Features: AQt7F2rYyucJ8k8M5suIcIYwHZryFGRojM10TYRYQXZevxtnA0xqMtui8-ALNA8
Message-ID: <CAHk-=wi4j0+zDZPTr4-fyEE4qzHwNdVOwCSuPoJ4w0fpDZcDRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/59] struct filename work
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

So I like the whole series, but..

On Tue, 16 Dec 2025 at 15:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   struct filename ->refcnt doesn't need to be atomic

Does ->refcnt need to exist _at_all_ if audit isn't enabled?

Are there any other users of it? Maybe I missed some?

Because I'm wondering if we could just encapsulate the thing entirely
in some #ifdef CONFIG_AUDIT check.

Now, I think absolutely everybody does enable audit, so it's not
because I'd try to save one word of memory and a few tests, it's more
of a "could we make it very explicit that all that code is purely
about the audit case"?

                    Linus
