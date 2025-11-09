Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C824A049
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728140; cv=none; b=mrDYiPdZ5puxU6JRx+MvFRVcETQwKMUhrukT6BJMuiXxg/Ns33bhsnn+NT0BOCOXrjzFWecK9iwcIAc1RUwwtGZMte9gH2jyod6nP+a+2zaxM+e/fxG2j2CXmzNkho1+1lBBMVAOcEJFlbYNYRhrMuXCE8PB9oOrQZvoX6ukBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728140; c=relaxed/simple;
	bh=qIjdEUO4UIxlK8RXL91T93B918tKVIx5tlbLeaqNZTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulcfb9fyFafkhfKAm+lfk7pXHUv5+beam1n+BjF2cZ1jxhO2YnU/7VJw1eS8sKf9ppNaUnQLi+MMlPK57fOtwkR85gQE2oIRWJuiZntXp5/m/G0R1M1a6MAAOzO6mUl3r1DGuYfaw0oFjMiUwgK2E+uS19lP+E4wVs3qq9tRhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MzX4VfDs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MzX4VfDs"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7291af7190so359272066b.3
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762728136; x=1763332936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7S1tPI9KX5FxZpbFA6GTKD9y2rwBJh6/sJGdbAgzg24=;
        b=MzX4VfDsnyjNO0R0WafNm74z/mAMlXZi2wgGt/ByHmFKH03MtFD0c1Ic1GShzg7/lE
         Q3xQgiZ4GiotpvNqKQOb6P9JzqQrehpMi8twO20QcQ+j1R4ZD2SDs5hG+y+WB1/GJn/E
         k9taFObJ48GV+2HskA2OjteraGRrbHHldHY4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728136; x=1763332936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S1tPI9KX5FxZpbFA6GTKD9y2rwBJh6/sJGdbAgzg24=;
        b=vfXxqZk2TXaPHdoDR0k064YeSbRzbh2lI8TkJh7BZvg7W088Vxv9c+RMwS9N2y+Tc7
         C5MD+OKKb9FcNsuRy4zOpJZ69e13XWff1dm/TG6FiCGrFOvUNcnwNctIkDyIRKNL0c5o
         gVgR9wiaVWZNJABNuZIAJlA6l76HJi1PVHQWUKrV7tzcR0kS70FEbu25ID/rsMFcDyv6
         V8aJ6r1QcJy1c2IjNDLCGIQlmcJLG4+TdYKOhNJETIKho+NzfhxnEGZNjTdeR55IEA5T
         JxABesY7fcDhsxgzz83fEzGOm04bDrsv4WUjt6Ep/ccJmHMKzvkb7xR4iOH4lSiDz0Wb
         2Dug==
X-Forwarded-Encrypted: i=1; AJvYcCW7uMkpRihV2mjhqbsTcroFCOp36/v8nPrtacD7SEyWP6EU9T7PFVJyVMs6O3Y2QvAsSgvC+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YymTogMqZo27npL/9uIGvRXYRFuNof47Dejpqzr95d8Atqpn/Aw
	49YPQvDOj6aa5W3sjh+iTQ+6Vco9zl/DHbI30HKKwQE3RB/MPpB9FzYOaFY67sdKihnKOQezLqj
	GJxBaxJc=
X-Gm-Gg: ASbGncv1wsw6tBW5mvF59Y9IN4UPGiFGz0Lp8+AdGe/Te9UZsah2+toA2xOxW0NGsiC
	WF3U/Hfn+uGohLXJHNeZgRAHVk6ztnrKxRIsqorSN3CxHRKbO+RComvGGSeBgt4EsDfl1LVypBl
	+MjLMD09k8NA9ZtNzkEhbJniBU4EEapNjcntv4uGVB9JcmNTuO9oj4GYBT5/Ku+Hx+vh95Cw5Lo
	LHzVL6/nUT11d2qkG9S3Z6voJO5b3+KqrgxyZw9+uQHoLF70Wo/LKjNIrF5dwEGqzXTDR9zcNUK
	gbLd1V+6rRz8ygtjp2dAdFFz2FodJtBpDYSUuZiY75dR6mxF6sDtjqcUNcOF+uKpc4OQNwFCzBk
	XVW3M1WI/M3VJnQkK4Iao7i5nMlVFYrQg1xbGYJbz+W/R6zJnzi+JKw4loUev/bAlIdg4Ng+FCT
	HGUjg/Kf+PimDKEvISR4DsnVlbdXKyn0SH1HogXhon3azXZNzWuQ==
X-Google-Smtp-Source: AGHT+IH8Cjx/CvUErdHXI6yEabo+5BFfTQeK6/t+x2oDN3hzNDCepfwkitzG/piT1NgG6eSUnZpPrw==
X-Received: by 2002:a17:906:eeca:b0:b70:b52a:5597 with SMTP id a640c23a62f3a-b72e045a333mr638355066b.40.1762728136029;
        Sun, 09 Nov 2025 14:42:16 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bc09629fsm944202266b.0.2025.11.09.14.42.14
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:42:14 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2db014easo447938266b.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr+VXS6vwgHCl0hUxl7RR8+DFBa6tfFYqNW7AWTlaj0/czcli1/v4laeEm4ZOl2yVxCnJMJA==@vger.kernel.org
X-Received: by 2002:a17:907:7246:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b72e02729dfmr660861066b.4.1762728134438; Sun, 09 Nov 2025
 14:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com> <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
In-Reply-To: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:41:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
X-Gm-Features: AWmQ_bk5CNTgXVq9Wj4DrVDvXfYphjsw9So7wK98LkhJD7EILYp-AjhoG9v3pfw
Message-ID: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The programs which pass in these "too long" names just keep doing it,

Sure. So what?

We optimize for the common case.

Sure, there's an extra SMAP sequence for people using longer names,
but while those SMAP things are costly compared to individual
instructions, they aren't costly in the *big* picture.

They are a pipeline stall, not some kind of horrendous thing.

It would be *more* expensive to try to keep statistics than it is to
just say "long pathnames are more expensive than short ones".

                Linus
