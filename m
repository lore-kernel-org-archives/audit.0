Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0423D28B
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727368; cv=none; b=qp0vT8db5I9PQEyDq9KHVat8Wk4mBAdxbrd1mh5BtOox9KTSB2+HQcmTqQ9seldORR3gmF8X216xm5PDJ4J9UmGSZM8epox4crxjKCt+Tdy3bzj+dGwpQ4fcuM0TAqefk7PznrxMe/pguZN3t2Y9rp1MlCiPG5kx4GPLrj/xCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727368; c=relaxed/simple;
	bh=XyKRq+klY1XpCUw5LERZ+VW2+vF/uljQ+cnRU4sIHJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/mRNhM2/nJv2CSg9POzDZl1CHtA35GZA5gs0MxUCV4EbYh5QIjxXT+UhOUDrud7kIjqYW1z5xDd+B87ik0tU1TbWiqjnNeyjnub/iqtRQn/vGpPlAuQfn5siE8MtJ4MuXCge0pfUn7b4C4JRAzx7DB604JVBqnxjdCizDo9fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H+iAGw3W; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H+iAGw3W"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d402422c2so488299366b.2
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762727364; x=1763332164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPZie8eb8w8Uk6fiaOTQBcY1xriqA9OV/bgfwL+5Tjg=;
        b=H+iAGw3WZ8/mcUNCqCYcLbSN05Lkwprzv2wm6tnE0Y+pCwsTV/JswZALzrEZv1CCDd
         V3tFE6r8JSdi2QOBlX4fMJ0Tf5+T9wChdcr2t0zozx+DJ+NA7L3VG8F0fhNm2eOcmaam
         hkyCSMsXNJjKO0WhYxaMNm+ZJZyAYb3GGR7XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762727364; x=1763332164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPZie8eb8w8Uk6fiaOTQBcY1xriqA9OV/bgfwL+5Tjg=;
        b=JlPMNE2GnSEzAsZUWVvA0dYRP8B//+iQqbQ/WsNcYZCpj8c3tikWMDt+wF3vQqOvwb
         0boYAd32KoX7K6NN3lS0gO40mn8Uobm1XhtfBQ2axQY173VitNb343f5K1gRiJv0fBoK
         cshrKLauixXz5aMkFUFGYumXdo6e2TH4bRLX6lqCBl9L1VZzqiAqVeQxwwqodS5LYtoE
         NCNT7aCMzGvl6GUrKXAoV9YoS9UglE5HDe/VQa1r+u/+Izo6FVAaQ6viUTbDf3DnHpb/
         m/8n9IF1WQmRqA7afwSCP59fo/p2Aa2z0mkadxZMXRFexKtOSNE/aqu03zPQnme35Kob
         kHyg==
X-Forwarded-Encrypted: i=1; AJvYcCWdA+Izsxrs1Mm869csCeseJzKQNVlk0vG2GYldrfKNBvRTDS7WIt9pO7taMp24Kcph/kG3TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cXyooQ7rQP3+2OwBsT6KPlIkDwXWscYHTtrYWQv0zc/ASbSk
	u7QNdYWDWyAgiDBKdNtpLaSTrXkVtoXnosTKyI5OxBSXJismlV3ckirUKQLKQwvUFdHnWNkUKwy
	Vzpm8h64=
X-Gm-Gg: ASbGncvCnPHqo8xW0Rs41GgPpxoHBG0RwF+d8CltPTKyaO9kU05Wp0g4tR4L+g5+UJr
	h+EhAfId9fPHLXSXFnd50zZ7OtubItwSKstlps1lghMSpq74pRdPTEamiK6PMhN5wsKRps9bNYg
	2OR39tRt1R+WvYDG8I9H/10YaiBhDLKkttOwkBBB6136+6LZQJUh4KenX7gtPNh0AjKd9/HJBxf
	ONmAVKszDQNzJ5k23JFMoNr0QcjtVATF26GXCgH6ce505GYVn9oEV3Pcs4nkFEsBQ+a6QEcPOZn
	P6iWNt8SAO9V6Gnz6ammxXPCdgnVw3EJPbiANobawtjo0ynmUzZ5EUC51HLXBuDlt+5LP3ybuOK
	zNN8sz2UbDjNLqp3vTkzuWuEpJHuuQy5Vi4Ai+ImOopxZ0KDSQL8175lZmn+0ZE3NGQ4S4f/Nel
	HnF8XGsFlpTZW/EB0UcOy9BCgh0MNTfhTIeBkXSwfuZei5yCZ85W9BGSyXKK1H
X-Google-Smtp-Source: AGHT+IGqG36dlplchnOBuRa43B/D3DPbdSLG5nbBL1jiS1JRsirEk4ln4i7sWsGXHHEB4A0xNmXd6g==
X-Received: by 2002:a17:907:3e9f:b0:b3d:395:3234 with SMTP id a640c23a62f3a-b72e04e1b66mr681563266b.48.1762727363387;
        Sun, 09 Nov 2025 14:29:23 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d7996c4csm719365266b.5.2025.11.09.14.29.22
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:29:22 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4736e043f9so334654966b.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:29:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWog1cZAPnjgRytDSOnDcCtfVVHL19HROHP6Abhml01Q9B2l7orWB141ug40UK6k/upLKh/EA==@vger.kernel.org
X-Received: by 2002:a17:907:7e91:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b72e04ca2a7mr646520366b.45.1762727361843; Sun, 09 Nov 2025
 14:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com> <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
In-Reply-To: <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
X-Gm-Features: AWmQ_blmodcy0umvH9FZdE7IOt16sLGm5PW6HtUqYPgjmzsWiwn8iRr6Hrq0I0s
Message-ID: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> You would need 256 bytes to cover almost all of this.

Why would you care to cover all of that?

Your very numbers show that 128 bytes covers 97+% of all cases (and
160 bytes is at 99.8%)

The other cases need to be *correct*, of course, but not necessarily
optimized for.

If we can do 97% of all filenames with a simple on-stack allocation,
that would be a huge win.

(In fact, 64 bytes covers 90% of the cases according to your numbers).

              Linus
