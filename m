Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308F23AB98
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718156; cv=none; b=tOJhu03CAn8lHUMdYs56DRmv12D6fOr96+Hw/UU+dhlMv0DKV309dom61iA6iBV9ibb2a+oBCqizrIPc/QoqqzfBdYgfKZf/M+AHgHIf1QpP18wqtxPbWq/4rupluQ2mM+y9bb+BovPjqtVZ4p8XRWfchjFqSb9HcKZPjKa772o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718156; c=relaxed/simple;
	bh=Ji6DwMlMN8CaxkUNYoWO0yeIXZAwhuvFRKjf56mogUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EECwfngjEMpaQxdUgGpyaQnkPo2URLYDmHQ6jbgvyjbikMcQp4xxnPN+1XkKFcmy2UrBYQeWyVO4CJf+q20IPw8otFJcznN/KIepMM+J56PRUvECqLtsopEwGJqOi8dey4NnKsvyGkg18l1/rUYm9qpSdj/adwEmT7vo0Jvguic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3xv8v/B; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3xv8v/B"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b714b1290aeso379412866b.2
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762718153; x=1763322953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcyRvQ5BWmuhxa99TkWLL6vqD6kswgiu0T8eLECURAo=;
        b=h3xv8v/BAeisJeh4XxXkOR45HsuscxT/YlpsLIyj4jSXGA0xZlWY5qLfUYb8+K31tL
         LjDs+pFpiRIR2hPrrFZeXGKd5A5XBzgHDom/Po5KjNbCPEK7E8dNL2eBh0bPvyHXEbxt
         +jexPIhXiDNgtN1Hs8DuIFRwLkPP9aW+sfK9hApf2BIs8wvlvp1zhM6gBlY++e8I5rPh
         qNxmX3huDRJum0c4rQBwRKpzMqtETmuKWHlrJKf5kHZoJ88PNl1WRkVB2/stkRT/c4/l
         DlX4rVYMPwL4YX8tbkxpA2h3P7nw5SWiZNrwD9NfMPxC3XaynVdyWBRlEWpQ3RkDXfd4
         mI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762718153; x=1763322953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcyRvQ5BWmuhxa99TkWLL6vqD6kswgiu0T8eLECURAo=;
        b=Ps13+dlGFlVz4W5UoOq304l7RFdUJ2t9McRTaIwhdwg11sjH8Par12uL5R60Cn38Gb
         nXfxluTEPCfsgRuqrnleVQ8pcaJ78HNhZSZE3DiySEpwNzcJQgACSkC/kAFv/e8kqYWr
         nvjGUs3sLkCmBxUDE6UlZQwYGC58eAYVN9/8+QZQ0QMuZH7BaoZ7cfMVfAJyh5p7BeZa
         SkMjrxNE2v5CyT0Q/06KswbARAyF7bXY7cgl5UfGyXwcHdeGLVzQ859+HeSoeVGMuND/
         qmzFtvCcVjvcEsQV0txc4kfE1EQSo1Id3L1S8Y12N6hDgYCtOTO+rhtFHpw4O944iPpk
         PQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwtOeqnuN246f18fkMq1SDr8pyUONyQjM8kcySubXcH2Zgk22vz6altHI+zIIJAyOBGLToMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRszEFgFXYMn0jeTsDgBouhxbsettLhSEV95x7jmFBj8fiqbrs
	RvVRtaHjVuN/QSCrXtP5+18I6odfm7YHCs3NEzdstL9srbvbM5ea4w1/6AzPDo4crq8LdgzQdsI
	tLWyZ61LUKVJNeZwMLlp0+T6z4O/b7o8=
X-Gm-Gg: ASbGncu1bVYpaLnLtMsKsmLDiE/bEBoXOC7rTJ06w07WhQxU9YfQcSfcjA58UoqS148
	fzlTapYT9HzVaGDLjX/OKjM0CcLTKVmvpBoEGWyH0ZFcAXeBiMBxY4XBN8ksk0stQ1TGXqPCszV
	VTIA6KDnyq4pAxytLrB2HVopGhfuupMtM9qbr3Whz+wu+Ba0HCgAHKqCAhBYYnrZxwDO4INXhXV
	6sKEBGhKr6hi4O8CeH3FpXZCN3l5BT2sHA/cMdCYWFw6mj1nLCxjERxIsFdkWPQdsy4p21eQQ1Y
	5Ngcf6dWWjbZvLeag5GUsOKM6Q==
X-Google-Smtp-Source: AGHT+IEJCgiSucxtulit9BfgtiUFhXxGXU3X/Af+a3d5W7s6ZwCxLSq9hCronQnPafiuMWNaswfyJjDhfpl/FqcUENI=
X-Received: by 2002:a17:907:94d1:b0:b72:1b8b:cc3 with SMTP id
 a640c23a62f3a-b72e05626c9mr673442466b.33.1762718153194; Sun, 09 Nov 2025
 11:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 20:55:41 +0100
X-Gm-Features: AWmQ_bliPSq7XXfs20U05pA0IPp_kEb85lD9jJkcNmzDbC2EW1Ybr__mANNaRXU
Message-ID: <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 8:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Nov 2025 at 22:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > These days we have very few places that import filename more than once
> > (9 functions total) and it's easy to massage them so we get rid of all
> > re-imports.  With that done, we don't need audit_reusename() anymore.
> > There's no need to memorize userland pointer either.
>
> Lovely. Ack on the whole series.
>
> I do wonder if we could go one step further, and try to make the
> "struct filename" allocation rather much smaller, so that we could fit
> it on the stack,m and avoid the whole __getname() call *entirely* for
> shorter pathnames.
>
> That __getname() allocation is fairly costly, and 99% of the time we
> really don't need it because audit doesn't even get a ref to it so
> it's all entirely thread-local.
>

I looked into this in the past, 64 definitely does not cut it. For
example take a look at these paths from gcc:
/usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/lib/x86_64-li=
nux-gnu/Scrt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/lib/../lib/Sc=
rt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/12/Scrt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/Scrt1.o

Anyhow, given that the intent is to damage-control allocation cost, I
have to point out there is a patchset to replace the current kmem
alloc/free code with sheaves for everyone which promises better
performance:
https://lore.kernel.org/linux-mm/20251023-sheaves-for-all-v1-0-6ffa2c9941c0=
@suse.cz/

I tried it and there is some improvement, but the allocator still
remains as a problem. Best case scenario sheaves code just gets better
and everyone benefits.

However, so happens I was looking at this very issue recently and I
suspect the way forward is to handroll a small per-cpu cache from
kmalloced memory. Items would be put there and removed protected by
preemption only, so it should be rather cheap without any of the
allocator boiler-plate. The bufs could be -- say -- 512 bytes in size
and would still be perfectly legal to hand off to audit as they come.
The question is how many paths need to be cached to avoid going to the
real allocator in practice -- too many would invalidate the idea.
