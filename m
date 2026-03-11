Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F63D1714
	for <audit@vger.kernel.org>; Wed, 11 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226062; cv=none; b=ICzpWG1LNGkBky6HggbaPayDAd8D9mwqsIxOq7paEV8AlZH1Ut+w/CQ/05YuwfFhquVa6mS+/wSIbrjLi7CFCGCmEpDFhD/Gzw3txt9Vuq9kv/w8bhAXCoEvXQIva+uSRZj8kreIXmskokZkL720onHm7tyaeAu9/j8OQaknalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226062; c=relaxed/simple;
	bh=zRCIOZXGAulewyBbqGE0TlQlTPqeFeIDTbPGyy24MV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Kvey38hxllltljXfUMcc0Q0tWF+/5PyKrN9phktKQxGWnHkG3ATtbdm6KS0CpsAme7GrSDTLiT9fBCVdIL57ALELxUEsO1pj0IgxmWrCUGRlRMNdO7Et2C3DSFDYEl0Y2ARDIs2wdfyOtsmkSOaIdm1vxK5oWecDvWPZ648R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+NfnaGG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+NfnaGG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-485409ab264so6052235e9.1
        for <audit@vger.kernel.org>; Wed, 11 Mar 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226059; x=1773830859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=l+NfnaGGhGE/Qag8NAZKtowOcVY2wLQCbEgf8MnpvieTQKfxTgLXG7gVpu41GQE3Cp
         lhcuSJ3ojhuoA+XvMW4ZK8DqWwguSBIQJdzHM+m0gGn1i58Im+PG8aw4GSSmMwNkHayu
         W9J2Et5BO3MOuAYEpSQbP4o8f9J9gsDj/OANzpqDRda1qkC6GXeo6tLR1/FbLVhhy7Cf
         MUxhHc5jx0lvSaHnxQ6WahuluHX1XzGqARVN8PyVe1PrQbU+agAKtUfEmOiyxhtTA+gY
         BR6kn5ugraDiB91Rov4L/mant481Z758KVbs1s66hkgz+KSI4U1uv3Da1yI4gGWMgZ4d
         Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226059; x=1773830859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=P/pvgTD/SDMXdbmTkz0p0EmU0dCaPuIRFsHLBqjS0hP3sA+DE4/FMyitt6kNN2srMr
         U4uOIKpQmkAuIb8Ga+hV6NsjDliOyUVgqvXYrW7+a3mk0leqjXFNwoZy2KiE8yePomTh
         elru/p99wpO4cWyCcMxAcDdcpNfIAa2PL4ceftN5095EJW9L3f9TDnMRNJ5z6ogW8a9+
         XTCZ6HpiRGxU/ujnaFFsZ49s/FZuI3ZyEvs7LF6EDjh6m60Q3pVcGS/dtxL//y+I3SB9
         ojGyWPHXJNK8nw5A1ZiR3zX1iBnqyLHkNGdd8Xb2qa/DuqqRJ5Lii9YZpDvynHzj/YGu
         QjCg==
X-Forwarded-Encrypted: i=1; AJvYcCW78wzx9UZIhueSjuFOExZ6LZNwmTnFo6HUprrV4sQEZxBnhqM7enBnRay2s11hidwGKhP/AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKm92SH1LJ9WmsHludy2YYUVNdx/WUpFCVaO7vAn1pSsuNWgp
	hIHzzd1nd/LKo5yPiehHMKOe1fVN6N8R2BpbHjayQdoMnmzmAyZBdpSP
X-Gm-Gg: ATEYQzwqUyv5tUeefO9XUuY/kvNgO97cjDtexIi+AYaijpiI4kxOypIHIOzhIOvUgV1
	pAe/p+7RR1xb3NZepLBaxAyk3N0gHimNMs6G3ynZnh5yQeJKtf7LqzCp6G8t4OFGKoWxdHSliyB
	3oWcCAc2KSpoK4pbz5ozLc3+F9z0If2T0ngZXjzaRdCfgk78xDdIB6pcktSLJ8I+4Z9F29DeEy1
	BJJby+sf4U0jv4VJbuj43powD2Dx2VOWgZjnsVJqIevScO2TsfFgQlhClEDnjAFbvhmxeZ3KKkc
	1GjTYHgF6pms6TmGY1Hqf+s7ViE5rtNq+MR77RqxAaGZfS/JPqfi+gMeH9tbhKlEPz0Zr3BNhbj
	Pt8nBUw09Z/ENgBU7UD3ZJj0U4IRIUMcryPGKOKdb3JOQfkyGV4go0Tglf/iSgZ1rzv1ifw19gO
	C9zy3+8otY+8cDiwQf9R9CbKvaiqnuBZrwJcATp2JcxZQPeN67fNXhRaBpQ7tAOWvJS6pwejZkx
	Lc=
X-Received: by 2002:a05:600c:5298:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4854b291dc2mr30148705e9.15.1773226058755;
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm5725154f8f.30.2026.03.11.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:47:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfs@lists.linux.dev, io-uring@vger.kernel.org, audit@vger.kernel.org,
 rcu@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kthread: remove kthread_exit()
Message-ID: <20260311104736.51b53405@pumpkin>
In-Reply-To: <20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
References: <20260310-work-kernel-exit-v2-0-30711759d87b@kernel.org>
	<20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 15:56:09 +0100
Christian Brauner <brauner@kernel.org> wrote:

> In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
> we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
> We left kthread_exit() around as an alias to do_exit(). Remove it
> completely.
...
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> +#define module_put_and_kthread_exit(code) do_exit(code)

I'm intrigued...
How does that actually know to do the module_put()?
(I know it does one - otherwise my driver wouldn't unload.)

The corresponding try_module_get(THIS_MODULE) is done before the
kthread_run() (and has to be 'put' if that fails).
So there is an explicit 'get' but an implicit 'put'.

While a loadable module that creates a kthread usually needs to give
the kthread a reference to its module and then have that reference
released as the kthread exits, I can imagine cases where that isn't true.
(Or broken code that just hopes the module won't be unloaded just
as the kthread exits.)

It actually makes me think that module_put_and_exit() ought to have
a 'module' parameter.
Or, perhaps, kthread_create() should have the module parameter and
hold a reference to that module until it exits.

	David
