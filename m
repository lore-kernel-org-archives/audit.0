Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E82E0B74
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483565; cv=none; b=L+OcxI8kvQiQHFrgTXA+NCOV8mfsXVnT2wqorAAt3pZX1L/0w00ySGei76QxvH83FbHoqybYJTP3SLVUQrnt+XZvmXT/EZf0GfNKaVyP280xyaaM/ONCia9GhnCHVtEuZLvIoZ5MbPFgBl9okRi/7S7Tgs58lXABsJ6MXvQHivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483565; c=relaxed/simple;
	bh=3Zla5hsgeKl5qE4xSZwjkNBiMgzZToY1+It37HWjw6k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gpAAkrhPvpKSYQ84uADUnmiE9onqiWYUY4iBbdLGR1mC4DDccak2TolZhKeNsiO7D7FCToQoX/M5Co1ZY9v04IQXYX3xkW8XRM8CBza0eE2s9puimGwceeZmBTgJa5LFom75XTpBohXwF7t9r+CnKcZc/lVYQk3eXrYRHj59KAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NSjOr9zQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NSjOr9zQ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f15d58576so4742976d6.0
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483563; x=1761088363; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=NSjOr9zQXLXuj1V2iyQLH6yNnAJSVtXITKlKKnken42rgfOU2TcZenzjYOIek89amM
         6jvwo3gFn5RfqnCAiemRH/Mx1zUqgw/ZnhPZV+tqlySEAh12NlDzovmSu3crxMhOQVMI
         E7YKiwzRCTa3GESfhjqm380TKTsqBpXFbV3ThQ9Y70i2gRz2v7SPnIeN3XTwFz56lO3s
         lZSxFFPtlRy8AqblWVM+POOu9G1qSiD9P4Y3QFpnZwd7Csf/58Hx1qSH/L9zlZ8wTY1a
         xxr+bRDfyaZKEEefHOi6pjoGX2kvSelWczxtvzgGnxjx2SvLfcTx34ECGvM6ZZwEVBuC
         WI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483563; x=1761088363;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=rbqBgvcVEI4poladqm4M1bi7egCwe8qmjQE2j2DA9lQMCboHSmoMiHMnldIX7aPpbl
         TvKu529ZaFFGUt79LrKdyWpdt8dU4tqpdOIWD5Pfg6243yBRy5dZ8CeZr9Kzeuy4Icvc
         nRwstvLWY6cdTHcgpRlT6Z4AxtUlNfy0Wc9Ia7KcrHCsTYapHJjV8AdZULTw0YzFnTYN
         PIxQNqvnAbs3JuqPcvxDXHq7WHwnjo7HDXmMNEPOSDYnUyAy2Ae49C56talRbniGFerO
         R/akFcwHV9BXz43Q4ZefvNBCKbMEgEnHXWrypKWO8XLFhuSXq5zwJAZR05jax3VU4OKZ
         HENQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7v3dFWtAuT+Wq7rx6mDrEP+sYcdBbheiio2oKAtNtupYHv9ZNEirtrK7k2mnHoPB7JhFslg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/p5/vWOc8QqX560uIJQjsslxgf4w1ARxzRlVmGxc5qdLBaWc4
	jOlOCol6ucbsfsn1IE4tnothMDFSJRlDY00CAJQS73lfNg3zsl2OFhSvM8gpb4AevA==
X-Gm-Gg: ASbGncsTpBxCNa7M9RWROO7D6Kf+0GYXZOO6wrh+0YH7Ik+KackvXiGqeEEv2z8f81/
	FB+fCPnZ/DGmzr4K9ZGcCE6h17hHIcFLWG/UtfeoOtqxceHxuhaxZHgXorghHQTm1jua6mRAftQ
	AUtRGkNyTANvyW1kWYsXl2jy+mXKrMtnSp4ce5wbtBUHFuxexVu19do2wqDS6QH1Mc8fkLClNT4
	9avvcZtUWw/RzeGq/cobTbyaK995DGDLssEVrSm7MVZm59L/5XRAAg4Gc8Q5CCKIpX7bmYgxSuR
	1/x2bqnupwDx786lpsLOwm0zgfpzHtfzIXUBe1rx0jzvMN/gQdSso+/+UfnDAAAYcLN8YP9DNQl
	5dh+fnJNh80upNwxUtY2/kyjmfRuAuD+T4nejzrAoMERNh3qbx15enyfW6k25mnANfq2n/iyv5N
	ZsH669DJJVD26SDpFrrB3omA==
X-Google-Smtp-Source: AGHT+IElj7ocLs2TIw65fx5R2ooBgDA9bofkFHqCmgSA+UgdqEXOhfYPORVhESpLJNrEH6dTHeSXJw==
X-Received: by 2002:a05:6214:2b06:b0:7f8:21f8:6f7a with SMTP id 6a1803df08f44-87b3a7fb6aamr353893716d6.23.1760483562435;
        Tue, 14 Oct 2025 16:12:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a226fsm6968306d6.50.2025.10.14.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:40 -0400
Message-ID: <a32fb2be726969d5da7caf55a8f82e77@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 2/15] LSM: security_lsmblob_to_secctx module selection
References: <20250621171851.5869-3-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-3-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com
