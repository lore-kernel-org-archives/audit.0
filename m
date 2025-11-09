Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0426D4D8
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729693; cv=none; b=pV6JNkCmWmdokdy+Ip7ONK7DQTbif9LYfQ1DP09LKY5poOwXP24FtZ7QI7woyWSjz/xuPCKbU5nzKwjE794Q3/VtCbOi1nlE2t8+JGa68HUavZJjIAbUeqUhdiGn9zsoUcjtLinvSVfJfUo7VRcijYPAXz8XW+OwzGB3QcDm8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729693; c=relaxed/simple;
	bh=iACxoHcoDxLWZj3kolEGP9nbhxUet6TkNrDdT2g6g6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZFvGB65EwxgTmEmR9Jub/9UHZzV3+IGbi8n/7J9mVYljBjPPjq0lhOuIROLSkiEwziieZFrdi7eWDfEK7iu6sGJpFL3AUOxSBsJJXz8EjnrlxIWtkpt5drKTUl8U2DrMvHIsGXFrWYLfCt13opcIDt3FdvlWXxeD0FeF6tQRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZmcOuLFZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZmcOuLFZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e9d633b78so426002166b.1
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762729689; x=1763334489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAZXs3XadTTrsCvx/VeK6Nga0Xvd+txMXgtt9i6bijA=;
        b=ZmcOuLFZceHb71iFe7EbCUnGZvf1GBccZl7skKMvy+hQwpdvuoln+JUEo2i5So0W8W
         TzLlE6Eo9IqgsAuPDM4dFyqCbkvWZe8RoR+qIPn4IrtfpFoUavnEpkrdK2TsLCU7GlH2
         q+ZoKfsy9DKsJEL6WG5gc/R5pn7h/Brnlccvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729689; x=1763334489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAZXs3XadTTrsCvx/VeK6Nga0Xvd+txMXgtt9i6bijA=;
        b=dlxRda7DC7YwbBpV3NR+Y4PFr44R9zucmll7gqON9Ylktgq/6NRx+xzP6bslThfjnl
         jfCO09jhlhCrDJWiq3KLbVZzNUwxc67L+DrIBjkmYpAS5quf4qw9yRdaWRnVKZnVOlE1
         OlafbYaiyUvARmDljr0WNjd8FcNhV6ygUfYn4+kNiU0u3tHUmX+blTAmNo1Gl5tK7hgi
         E3ZLvGv4U3EzPDoKyc74FAAH2X7qs2ASdoAbW/+1ku536mSR5DglRitDFxe4i3FA9rdJ
         jeuqa+d035PT30cOAqL5ssEbRhngsGudDatfW2LTiyBOQtMR2EE7NksNqbluTjTyhMVF
         0ikQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTqapsHge0PFYu9Z6kA+KiAx6sO8fTl9qVN8gjE+y31v7jVjx5tSwg/bcs4BT+jvRWGdYlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GBM08+9ZuwQ5V3DMLPcXRZoBU9SZ2P+ZlbisSXMeur4vptnK
	z45SumGIeOoAxBrySKZ5/PZFKtGof9gg7WAaUggprgqbp5Cq7jUZgyEgvd03IzSDd+DQqy+IGMc
	vt0XUSwM=
X-Gm-Gg: ASbGnctwgXB911RUFffg3Gn7GVn4skJen1hs7noZt5ZKZr5E/gvYS/KUUR00NVBnxTW
	BUWZ0nHmVnzIOmtkCXtVA5AA3vwDWqdSHWruaw1VyTZEw8VUgj3fVCac1UDn+jcRPUQyA8SIEsf
	uPH2OYdlbepZtXrEoqpRDvgZRW5fwzhsruSHGC2yLAR2A4/XM7Lz7uFu/2prvUUat7vPwP8FtDB
	OfiqKss8XtRYgXoTFp+Jc5pSfp+AAKgEjeGI0y8CUImLV5xI5aprtQynHg0TZ5nohy9cm7gb+hf
	sgOtiDuNRFy+TPKjQcB6mKBOgzPLrCpahgMGyPEMCfZU6hG2FeD+kueMAQtBxknSIoc9QtngTsi
	lFRn4cffGzlCQx2OXaVU7Ctrq72gHivLU0mnyKN5zt1mU24vznQrJ8LhmZ3PsAqJ5znCMuxEcjy
	unL0TN+2C6PrCMVP4AyE9XmYjFytSGpRZE/Otmaolaa3jDqku1Lg==
X-Google-Smtp-Source: AGHT+IESYzwc2LoxcLg+K57SvH5QaBX79GkjyrMNiHe3iGwkMk3bgEsSOR/nUDJzGGZVMhINDmoQ8Q==
X-Received: by 2002:a17:907:60c8:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b72dfd9b021mr725716166b.17.1762729689064;
        Sun, 09 Nov 2025 15:08:09 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm919835466b.22.2025.11.09.15.08.08
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:08:08 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso1696488a12.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 15:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbid4zdp/DmEKIKtsVIJ/4GASVYp+9z0he4gO6v7jMVRk0j26HoPLTrfT//20xZnsHWxklWQ==@vger.kernel.org
X-Received: by 2002:a17:907:7f13:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b72dfd9b02cmr669689266b.16.1762729688139; Sun, 09 Nov 2025
 15:08:08 -0800 (PST)
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
 <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
 <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com> <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
In-Reply-To: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 15:07:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghq+wJrgrDy=-S5TmVNkaJS5RWsQ3kFfCCwv0juoKG4w@mail.gmail.com>
X-Gm-Features: AWmQ_bnxTScKA_GtJGPpI3hrR3y54KxE0TmLEXSfNmQBESKxwdZdKzo52akvKlY
Message-ID: <CAHk-=wghq+wJrgrDy=-S5TmVNkaJS5RWsQ3kFfCCwv0juoKG4w@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:44, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And again: that patch will slow things down [..]

Having done a profile just to see, the regular allocation path
(getname_flags -> kmem_cache_alloc_noprof) certainly shows up.

But on that test set (kernel build), I never hit the 128-byte limit,
and interestingly putname() shows up a tiny bit more than
getname_flags().

At least one reason seems to be that the

        if (refcnt != 1) {

thing in putname() is mispredicted, and without the auditing code, the
"refcnt == 1" case is obviously the common case.

Anyway. Not a great test, and this is all the "good behavior", and all
the *real* costs in that particular path are in strncpy_from_user(),
kmem_cache_free() and kmem_cache_alloc_noprof().

And yeah, STAC/CLAC is expensive on my old Zen 2 machine, as are the
cmpxchg16b in the slab alloc/free paths.

And in the end, the actual path walking is more expensive than all of
this, as is selinux_inode_permission(). So the actual filename copying
isn't *really* all that noticeable - you have to look for it.

              Linus
