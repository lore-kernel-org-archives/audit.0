Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B091D63EF
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762719754; cv=none; b=oQBXTFh5W7IooR8Rh1HrDNzq2Ek9Jz+566Z2kxLkHhemN0SuWzLI10G9MUU2jVK8yA+6/V7SIKwjtxvpQNAjhTmZku//fU9onqsPA/Ho4dnzgERSVLc1pbT+Y+tn/b41ubW9hmp1Cu9jWqRjTSVW40H87OhAMNXMfiPTz+CJT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762719754; c=relaxed/simple;
	bh=gMM3i9EQws9r0erlhwqEHGf1p4xwZQaG6fRH9k5nI/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/XCSI2Jra/i4cLdlZ7ckp7Hd5MIdvJpJw8MKbcly9tuM1lVcrfEsQ8GTEZMVz9+EQFpq1STjB/+LiuHnuSt24ukaQA6hVk5PW/tmbJcO3LpD77jfVvWQ65p4oDZqsUCzdHL/U0hgbm3Y5bh26AlXEqHYCWasDobB2mQ9oyBMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euAEvstC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euAEvstC"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b725ead5800so306417766b.1
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762719750; x=1763324550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb0PYNykYCL7Bou9jPgLMIeh7nnGaWAzoWBWhkWIpmo=;
        b=euAEvstCThowZ5cg7UPyK9sDwn11PFtcX5ZBQTpizq2KoKuI0/7Rxc3+oHLJR7DLQH
         YH/PZpFlGI3CGtKEn1/kXNWvW0eCr5BmYV7HTV+S/ri2boLdRdJCPCkwYBqcHZ+Lv6cm
         ylJ1yi1NQ8Yyv7kQv7Vz1P1in+bQGOWl8caLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762719750; x=1763324550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb0PYNykYCL7Bou9jPgLMIeh7nnGaWAzoWBWhkWIpmo=;
        b=IYebCGOZxDVc/RDSkEYybJMJA4MabHBPmNN3f7afHDXpgZZxz6UCsslwsX+VrE6ESe
         T3ZEZ7NmzDoy1rawksthekFh+w52peHRvQaVCE16n1HnKUXtrjosVOVj6j3mwWwzOUTG
         iP0Y6WZKrOh7CbanuqQIMbUB+QBwGAfG4PJuAAYi2f32fkxUx8Ec/07uMojRtbMBpPtR
         8mwIcjRkl4u/oUaBtm42nzQWe7BNl2g/+98POPuc5junDYrhVue+3RMHDazT05mueWx4
         kHLzvSMjIGJEXGpdlX+/ShHYi2rJSQZzhHDGdZ8owxJio7BhoeecP2iKPC2tv4XKGIEq
         Dk7A==
X-Forwarded-Encrypted: i=1; AJvYcCU42uwpJ1pAp/hDmqUCbYdItxYierRfOg/GUWG3AUfvI6nVXErIeFMdD12d9MmziHYintm/+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5Up5YrEoRmgCsddK9Jots3Q7jsTjOVyetgBfDS1JMFoDVc3U
	uRLFqDmvUg2cby3CfN5kmrbPjtyT2plQ3fZRdQH8FhNsPsyBB5nJUO4t57LY5xUe4MCMPwGc/Rz
	7zbmndao=
X-Gm-Gg: ASbGncs9XBrxLR9++9kggvTIjetI8yu5Ev4F83byJAstgcbf0Yifu1kM6Tdl4xrB0SZ
	HZTo6ZnAFDRIC6psr1MVJx0RCPi0M7+iKmbqWGuWwqaj5enXSiQzbnJWCMA0AfWaFnM06jPI4tn
	ENq9r2YDjRf4Nuc9OJ63pUnqx/oLdPumOT5tA/khZv10uz779n56bLJ3nTqqRUtqmvXF8NxIkJ9
	l2hGnwqroVHmarxuzNY4GLn6MVGPSzTLpM+QL0f/9OWOwib2ij46m6XcrUENBfZmFThkzlcpn7/
	EmCTC5eiSvp0Z+RARk9EA676B/BiXW2KW9hPXAGv7tKPUFUFzY4jhRRFdIwFmak6muz7Sple+w1
	nxyk15S5uEd+E5MWT5AQI8W8glSpgk/x8jW5l89/P+gubTSy3IIBI/jpJCY+8Iq9b3lh791takZ
	zOJGJajUGkjDHDrVKchsx9nW5dhvJVWE1EQVoqL9Iq6sZhko+ihQ==
X-Google-Smtp-Source: AGHT+IF6j629SBkZkL3w738ipqzgWKqNcv6B6NgMI+cfVr/9C53lmVk5TglAyJmhXpGh0W89q3OK9A==
X-Received: by 2002:a17:907:7f93:b0:b72:c1e9:5f1e with SMTP id a640c23a62f3a-b72e029084emr550377966b.3.1762719749973;
        Sun, 09 Nov 2025 12:22:29 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea81sm877094066b.13.2025.11.09.12.22.28
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 12:22:28 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b729a941e35so277916666b.3
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 12:22:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoY+JvQLDlI2hIZRwytEhBL+Jdqz7iGzk8uUsxjj4aWeIQ0INczt8vuovBxiwR+kvtoU2Q/Q==@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:b6d:51f1:beee with SMTP id
 a640c23a62f3a-b72e001b360mr489809966b.0.1762719748467; Sun, 09 Nov 2025
 12:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
In-Reply-To: <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 12:22:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
X-Gm-Features: AWmQ_bkC_Y91-ng6JwGWrLQYnTWxwwp_oTGnNI2FkdTnLtXofrxPbxBR3HUVCm8
Message-ID: <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 11:55, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I looked into this in the past, 64 definitely does not cut it.

We could easily make it be 128 bytes, I just picked 64 at random.

> Anyhow, given that the intent is to damage-control allocation cost, I
> have to point out there is a patchset to replace the current kmem
> alloc/free code with sheaves for everyone which promises better
> performance:

Oh, I'm sure sheaves will improve on the allocation path, but it's not
going to be even remotely near what a simple stack allocation will be.
Not just from an allocation cost standpoint, but just from D$ density.

But numbers talk, BS walks.

That said, I partly like my patch just because the current code in
getname_flags() is simply disgusting for all those historical reasons.
So even if we kept the allocation big - and didn't put it on the stack
- I think actually using a proper 'struct filename' allocation would
be a good change.

(That patch also avoids the double strncpy_from_user() for the long
path case, because once you don't play those odd allocation games with
"sometimes it's a 'struct filename', sometimes it's just the path
string", it's just simpler to do a fixed-size memcpy followed by a
"copy the rest of the filename from user space". Admittedly you can do
that with an overlapping 'memmove()' even with the current code, but
the code is just conceptually unnecessarily complicated for those
legacy reasons).

           Linus
