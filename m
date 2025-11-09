Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9D24A049
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728288; cv=none; b=RI4szbtGHrwHfwNOgi9g56AKtzUgAE1mR0Uij4pMcp3TJSMuseiTjuhnOUFdwJVd30bONnBU76qFzM2iMzm+K6VmToQVtosRJuyIUKIGeLE0Jhby8MvWZNW9MLigJLLlr55PtZbLl+5VphSsUR4UPcSyKhijLjBbRDh5ZjVsbt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728288; c=relaxed/simple;
	bh=JyYqEeLnWZ0z1NADpRPZfSdR8cGolArsUHrUE2T2Vrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruC5iurIOUM8OW8+L8owEBOQjZ6pssHvYdYx+BsJwqEUFjlTYFADgnMXyNK7ug+9iTkj9s62aMIZ+B1E/b30eL8wnisYuOv8//Mx6Rc1a2lmNaAoo6NShVd9aflqupON8CoIytRwLMcETvAcWZbH9R8qrjQkTZUAE+FX4X5AqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ONbHLkze; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ONbHLkze"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso1680034a12.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762728285; x=1763333085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMxRTSFq+KiC/PO/c3X5DJYPCM+6QHM19lCO2aQiEdI=;
        b=ONbHLkzePLW3NYXoC65X0c4flpPEIP9HB4AWQ6w7d1p8UmpF7VXEUSH0e6eQ+aolId
         t3NGtbcmMRpSgNk7lkHMt/E3beKQ9mHIhiJRkqSVG6qEGCnD3GZW795ESzqWF8OQGzM+
         fxsKxBWZr6J2XplP9J+rDe+JlWbG3QfXeQTuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728285; x=1763333085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMxRTSFq+KiC/PO/c3X5DJYPCM+6QHM19lCO2aQiEdI=;
        b=jk3QnsfgVa59laNP+dNkLjAaVMSFMYNW90Gzbj9ePJDL3Ztearre2a1GMol2t5Qoxf
         ZnuovPtnLqXgfTuDblo6xL7zDT8+zOhNSceY3W+OL+F4xpuDgNNVsQmloiFhm8UE4vj+
         YxW4Mbi+QmQsB2uSfA+x0/c4qVcMRMRZ3klSa6ZjpaQ18XEa9fe839atrF2QScbM5CXF
         P7eb08eXi306gzWiiQLfRGWMpS5VzhW5c78X4L6lx5nhl0oEa0QVmACOzYOR9RJhgytE
         B9pbIaO76IK46c0EdMVdozYtzMhNrEuazY7ceN+XAj+fWgKZPbUUYxikRhq3ymSt03Nx
         mCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiFCtDkUl06TUkyNqj9fMIU1+Jdo/vJqVTzchpdQRfnNWYaTjai/fO0tmlN3S2ryXC2iDZHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAB07IQQXthNwy/cPo+QS/njy4BIUayjhMNT09ZzRRAdW8Z4y
	e3R1abTumnrbgICyey2eGiIxyVisOeb52rvxPXmBA+nH2efeoTdOu2X/xjRywCtpISooVzBZ1C8
	ilJF/ulc=
X-Gm-Gg: ASbGnctgVG6m0af3xJlAP/2nUqA7G3Limoe90ehFvv5ZvmQuujR/tpqbJ/b5cr5+0LG
	NqdArXCFrqwl4vrUlXg7fTvjxvW8qwsvGgC5CfYmFBsj3Y7iRKUTxg6tJcmgDPJUJMsBUobrK4N
	a1UMenN7BOorfbQF8HyXT1DrSI1ruEnrKSE2ANKMRfqO36MxeaYkX9GFpNI8w4VPxsU2Lf54+cl
	3DGQNtkNuXP+HAofCb/bFrf2pUeYToLTrSu7Vmt6TCP2aWG4oEYhww3Puq4ElveKR6VBSkedzHW
	Jfi6u3KjvdawzS9TuG5g1kVxYHBISYvPMtt48DiwdLywSqEhQXuc45qRNSsLkmQPZ30waczea2G
	CqjuqRRelK6iwW2/1rL+IxAK+z1MoHF8jjBbJ/SzNhvCjX9mwk/BZJKn3aEkpVhrEQewqfJpRTP
	9EMnVLxQfqI+801Hn+IASlhQ+pCDI8tYuQ97sWPKZgew10QYJMTaC/bTKfVNUd5gXhzf1CyxY=
X-Google-Smtp-Source: AGHT+IGaqIKUFZb6JQ17DfRxSDcWPOi56rSH2CXk1dCfky+zb8sDIjHbBypnqizyQkK0NsadZ2UcqA==
X-Received: by 2002:a17:907:3faa:b0:b71:60a3:a8b9 with SMTP id a640c23a62f3a-b72dff53b65mr530232766b.29.1762728284837;
        Sun, 09 Nov 2025 14:44:44 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea81sm905434566b.13.2025.11.09.14.44.44
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:44:44 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72e43405e2so190683266b.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4oK/Ct6Pga5eHv4HqAaAbUP2WS3i/h6au15jopkeOr0TUuoz1Jpngh/dyILAYw8TU0dweCg==@vger.kernel.org
X-Received: by 2002:a17:907:7b9a:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b72df9d994bmr743402766b.14.1762728283808; Sun, 09 Nov 2025
 14:44:43 -0800 (PST)
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
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
 <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com> <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
In-Reply-To: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:44:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
X-Gm-Features: AWmQ_blFRyp2aK66FJENgGjkorwps5yaIcGGW5kQ_CdDWidiXHxD-MbAtM3Q3ZI
Message-ID: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We optimize for the common case.

Side note: I'm now running that second version of the patch I posted.
It boots. It seems to work.

And again: that patch will slow things down, because it doesn't
actually take advantage of any stack allocation model. So I'm not
claiming that it's an optimization in *that* form. It might _allow_
optimizing things, but as-is is only adds more allocations (but not
particularly many more)

               Linus
