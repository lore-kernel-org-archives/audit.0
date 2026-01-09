Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812E2741C0
	for <audit@vger.kernel.org>; Fri,  9 Jan 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994682; cv=none; b=gty3kPCOGfcThFs6Qbv1cpAlq43CcEh4eLHNP2RTDJikTkm8SCBjXCQ75It+b5mrkkKo1hLjqGLc5NWaOZcJz58l+l4z02qKj7LGeEzRZ2LzkjG0FW6INfqNgSFbjnMBJFy5sOtarcQ5BAlQvzpgxamzMdaX1K0QZ1XcXByEPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994682; c=relaxed/simple;
	bh=S5aVh520K3lg8UkCLOBc2MadcpPdNgMqmpTmBKE6754=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=U0NR2fZqtSBOEVbVEIg6+gLHAKPx8+pNlS77sskBbefOKV7Om/exVr7pPM8F1yd1wfVe3tAgWYmHv0YqzAv+YMKYLcChmb77+JdeLVCaMEtV1/MlonofZjW7qWviDMu6vgBXJQXFzxBsGOayD1d1fo+4gy+Fj49vrIM3escjrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z7ZA/qCz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z7ZA/qCz"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so40912086d6.2
        for <audit@vger.kernel.org>; Fri, 09 Jan 2026 13:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767994679; x=1768599479; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fldW0JXC7CiOQzI5zIq0HGur2P2GdtXN8gYrW1+z1ek=;
        b=Z7ZA/qCzmaRLPwkJyMk6jGAq7IH/dQh/5XJvJfCsJBljn0fDFlyKhawKWrZt/j92zv
         miZe9l26smYyGsYaLP9Y3MYB2WpGbgGiVzAwuq/itccMAd9stWMM6Ck9m/O7UEjwBB0R
         vDb8tE4Pa/xGkARaLAjOq9S2Kf+NaBPK3sk5kOk9bvf2VXfDuBwHYFdOFkD8ZU8T7BIk
         KCVFQRNxUXj21M+mVWdx++w2Ouz2waruSaQueadls1Lld4gTSfjEnshbI5H5iWKEb4Tr
         O7vYioESDIsiN8SW63Z0axkQ8dIP6mhDnS+kKKh16u+ChJNtqIBkU0UJg1EhKxhHS0Ry
         foYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767994679; x=1768599479;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fldW0JXC7CiOQzI5zIq0HGur2P2GdtXN8gYrW1+z1ek=;
        b=r2EiZ63elfNGaSY4xfDibGB4rr04WeVa139d/q69T4wIFzwSu+9T2M5Y7CbU7zdDRC
         xkF1IyivaOZyHb8m/Xw4HBQFC56jqH4Hzxqvhu5jrqVEmHOvswOyccUBjDcVB+wPVP1I
         r+1swyjYdXBz3bqReLeC0J+EJCCUftuTqE08xwkSFz1Eo3qIQVDEVGTa56dlgjevQa6T
         O4MWkfsDyHqkCLFehbnce450X8dioWIQxrImMVU1LtOtDiAzoMs9TkPsELD21ohEtWxV
         X1YA3XW/bF7XlPEvBfYRTkjYEC6iXY33BUnljdfNRZQmQPgCEq6Xj4I5B3JIH63wH8lH
         DZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUwW3bD7fpoMKU+w00ijq8Zlt/zh39ZXiWMQ3zmVC4LZWivmEjiUMfHoSbyu8+aX+MOhemojQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQKsSZPS1V9xRzldfy+Bmz9IDf0OwzcwKDoc9l/co2JZq0QrN
	gyILvy29S8C1E9xGk49/ywm2pWiwk1pPpS28MIvkw27E1spD+UJrlcvxws98fCm0xg==
X-Gm-Gg: AY/fxX7r8Sjwx8B/IMdIIkPoFsi4MvXH0RYHMpV/66oQkbh8JVzwVb/OCIEt0CRB57/
	LoMe0L1BRMYMZvXV66Dm/FckaU2mSVlYVPT8jjkNjA6L99NIOEl/liBIRUsgxC7D+D7ZtWHo7Ef
	SEw+KMLQCOqcPi2I48WdPx84x+xaiXMgLab+/mMxnKnYneyrFtPrJBR3DTDOGNEXEa+MsBoZSpU
	f0YeKMbkw1KUJHHQ9hIS3x73fqoqxk97zxNBHIyQyTKTYavT2+rXJfKWQJFxiQI1YIfRV+wemO2
	ihDC57+TcNKtwothqKSARLwICJATgJZ5k/bCnTMWwM60WAitSco13FSW1uMk88w2Exp7dyQ70vp
	oQjuK5ApUQG3pLKaLFAtkEsovls9Jq9dOrUvTeEQRUA1TxBYKZ1v54PVMRHuEnhxmMNVpUtqZ0p
	Wk0gnvqprNfhYHI48YsZCouKuK7WTuKFnd5sTseB0s3ZLF/ljHdXoYFmk5
X-Google-Smtp-Source: AGHT+IHyxQlUz94Mq/TA/alMr+BodvbzETad/mWJ9ul3qvZjqzarb6iLsc9wEl+Zg2zXqVrO0ZIkcg==
X-Received: by 2002:a05:6214:5906:b0:888:8247:698c with SMTP id 6a1803df08f44-890842356famr145099136d6.40.1767994679383;
        Fri, 09 Jan 2026 13:37:59 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a9a19sm912522785a.1.2026.01.09.13.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:37:58 -0800 (PST)
Date: Fri, 09 Jan 2026 16:37:57 -0500
Message-ID: <b1174bc8641f6738a1b82b237bebe68e@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260109_1633/pstg-lib:20260109_1633/pstg-pwork:20260109_1633
From: Paul Moore <paul@paul-moore.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc: eparis@redhat.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] audit: sort missing compat prototypes
References: <20260109133938.404748-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260109133938.404748-1-ben.dooks@codethink.co.uk>

On Jan  9, 2026 Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> 
> The comapt_xxx_class symbols aren't declared in anything that
> lib/comapt_audit.c is including (arm64 build) which is causing
> the following sparse warnings:
> 
> lib/compat_audit.c:7:10: warning: symbol 'compat_dir_class' was not declared. Should it be static?
> lib/compat_audit.c:12:10: warning: symbol 'compat_read_class' was not declared. Should it be static?
> lib/compat_audit.c:17:10: warning: symbol 'compat_write_class' was not declared. Should it be static?
> lib/compat_audit.c:22:10: warning: symbol 'compat_chattr_class' was not declared. Should it be static?
> lib/compat_audit.c:27:10: warning: symbol 'compat_signal_class' was not declared. Should it be static?
> 
> Trying to fix this by chaning compat_audit.c to inclde <linux/audit.h>
> does not work on arm64 due to compile errors with the extra includes
> that changing this header makes. The simpler thing would be just to
> move the definitons of these symbols out of <linux/audit.h> into
> <linux/audit_arch.h> which is included.
> 
> Fixes: 4b58841149dca ("audit: Add generic compat syscall support")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2: fixed missed commit of include/linux/audit.h
> ---
>  include/linux/audit.h      | 6 ------
>  include/linux/audit_arch.h | 7 +++++++
>  2 files changed, 7 insertions(+), 6 deletions(-)

I merged this into audit/dev, but I rewrote the subject line to "audit:
move the compat_xxx_class[] extern declarations to audit_arch.h" properly
reflect the change in the patch, and wrapped the compiler output examples
so that 'git log' on an 80-char wide terminal is not overly ugly.  Please
take this into account in future patch submissions, thanks.

--
paul-moore.com
