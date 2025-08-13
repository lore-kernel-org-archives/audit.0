Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D127EFE1
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117593; cv=none; b=On8xhpK+HvhI6sSpvpmWf0o2mq5FYEfsS+bnAdvi3NC36QHCHlC8t/bsbjiW4Tg36cTTNQdbJQGFXtCPkkMcf1xll3HOElP/x3+PiB6KkN+M8d3gpu2hrGCq7mHqAejVk2HgenZdu63Tdcs7Xw916hlkFGaanxOObP0lqbgm3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117593; c=relaxed/simple;
	bh=AXffZ9dyioE6nOqSGA3Jy2oI5Z20yBGFwOs8nynpzPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWoRwWON7goPc4K97nNdBmT7PX3pFagsaruv7uC8QatvS1xXhEP9TB3JCagPwmlkX7rn1ic8vBeWYMhuHlzC/JUYd/aVDOJZeJOugFhTiQJeTIcOSb6OVQul/ehiWcFIt4Rg53cjp6MzVZHyI0vSGb8Qxbso1TiwVtfykT7L620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dR34cAxp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dR34cAxp"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e56face8a2so2214895ab.0
        for <audit@vger.kernel.org>; Wed, 13 Aug 2025 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755117591; x=1755722391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lP0QH6bmUQ+2Acs8+Imh9XZZLiBHsh0NRGzPgFU6eoo=;
        b=dR34cAxpfjkdqNi00u1SayjSu6D3QJVGRvDkez4iGJyTdpwNsfSnpEvPYwR/bkkGH8
         bmaF2H3smnrV8IF5gVz8ckv4kqXrNfgSJAVQw/q/guhxrXYFgwM5a4DR34ipn+nlGB4L
         fSsXNnZhO1iYH8WP/t03Y1/SChz5tQH+rstUERX7bgWuk1VvEDeg+eOPHOQs2zg/0R3u
         Ze/ym8Jom2p8Cd/QNAMwQwRaLBYcF0lmN0LUhoaxNxQF9iyQz4sRIiqWEggNREraBZEF
         oR6q74QpAnM+PA4dkKcbTHabvs3ebv9mROBP7wVv1LoXmKIIjMcReCP0tL5pBGy5RNG0
         QGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117591; x=1755722391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP0QH6bmUQ+2Acs8+Imh9XZZLiBHsh0NRGzPgFU6eoo=;
        b=CVGmC6h2Y6ZQ9DBE6J+7rN3lqoZLTt2VLzZgtF1+a6vTsJqMbUq6GKvI+uBPwjpLAv
         QH5ZuVxZ08qj53dNZ1rmKxwLIuJ9GkTw6pVnaQSw45ZvBufnX8XlcWLNt43B5PV3Cvr6
         JurYSAiXwCOeEKjVK/dHH827c/GwepkxgEFIn1jEB//36d0rjnGXNuIFvXD+Jzuq8jh5
         clUiC9/2153IK6X0DCDZXNbUTX/tC5+9jIy8fLuFkNuBC8y9wcmKqNw9SS/U4+yueghf
         YaUCEVg3W0tOEv1RuIKQewWizaGSi3BGpygIQtnh1Lk7zQfpLSo7UPZzvDR+cGnKQZh/
         fs9w==
X-Forwarded-Encrypted: i=1; AJvYcCVrtVBLZT6LN8kX6ERldbjjBPe5l5qic7Ane4RzP8NlfKEjeHtrfVgKdXYY7/KkkqhR+9dskA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHtOgpNjt/wANg/AuSaY+po6mkkKd1NoKwS80iRCukxAV/QUE
	kgxdewUYlU09gwpLqQXLPF+DoLc5NBFqA4iEYK3ZitdqJXkoBmuPh0mOJNY7VRxI3xJhczKO3vU
	OOXZX4Mw=
X-Gm-Gg: ASbGncuUAwXHEnGd260kiya6q0ZKYdQq5UpE1YtraIozHMp59BGrUkK+2thMAyuGjzV
	m08NJXsf+ypO8afto0KI9RrUr2T5Zkj2izMVhz4HtttznHpCPCM2M5MTjrnqspfOZqwX/+SLTEZ
	sjHypjTuJqvqaQ2e3UlyFp5EkmHl9J6FkJ+IrO/R4jfdM4bdBQMR7nGF97K7wDmSZE7/SCMJrN4
	MI7zvhNJcS6wB/nKXJ3+8Qn1M7vwfjo3Eb4UC812xWvfvaAQz9qKVcs9beW/5XLrU92pcY8sKiX
	3duZU42A3zJmxmdBJ9Bi/x+u0cv6CumuB+f4v3EDOI4eKhSsWRsZitw0Rxs61XThXLRUlJ+vRog
	Y1Ts=
X-Google-Smtp-Source: AGHT+IF33uU6G1tdISaoHujqKFCv7GAhmf5MtVqMPZeo70bmBvi9Ma2tNnrW3cr8EJyPXQvpDlIPHA==
X-Received: by 2002:a05:6e02:b4f:b0:3de:e74:be13 with SMTP id e9e14a558f8ab-3e571530619mr5127105ab.0.1755117590530;
        Wed, 13 Aug 2025 13:39:50 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cd268sm3918681173.22.2025.08.13.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:39:50 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:39:48 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
	kernel-team@cloudflare.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] audit: make ADUITSYSCALL optional again
Message-ID: <aJz4FOOy8eYO6OTN@CMGLRV3>
References: <20250808194034.3559323-1-fred@cloudflare.com>
 <b7fae70a87b4fe937607e5e3215397bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fae70a87b4fe937607e5e3215397bc@paul-moore.com>

Hi Paul,

On Wed, Aug 13, 2025 at 12:01:42PM -0400, Paul Moore wrote:
> On Aug  8, 2025 Frederick Lawler <fred@cloudflare.com> wrote:
> > 
> > Since the introduction of commit cb74ed278f80 ("audit: always enable
> > syscall auditing when supported and audit is enabled"), eBPF
> > technologies are being adopted to track syscalls for auditing purposes.
> > Those technologies add an additional overhead ontop of AUDITSYSCALL.
> > Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
> > offers some advantages over eBPF technologies, such as early-init/boot
> > integrity logs with. Therefore, make ADUITSYSCALL optional
> > again, but keep it default y.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >  init/Kconfig | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
>  
> Generally speaking the less Kconfig knobs the better; it tends to
> complicate things and for those that rely on distro kernels, there is
> always at least one group that is going to be upset about the Kconfig
> knob being set "wrong".  In my ideal world, CONFIG_AUDITSYSCALL wouldn't
> exist at all, but sadly not all arches have the necessary support to
> do that at the moment, so CONFIG_AUDITSYSCALL remains a necessary evil.
> 
> Thank you for the patch, but IMO this is not the direction we want to
> go with audit.
> 

Thanks for the response. I think setting the filters to never would be
OK, but doesn't hurt to try to see if it's worth squeezing out the
remaining usages.

> --
> paul-moore.com

PS. I'll be sure to use b4 next time for a
submission. 

Best, Fred
