Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A141F2367
	for <audit@vger.kernel.org>; Wed, 12 Mar 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823499; cv=none; b=mwCZCHr4U5hVZIwtp1nXAUJ+L/SKB3eGDB5NsQ/BdjyqJgssw+o9OkL3lvBnygwmR45CFUYYpNXZ0sBZPH8ngtICBWukLq2BEdr9M6zEr7n82MKz9dy12L9Egb4cwtjTioP3ddBjL7zFvmYdCh3rZwPWkIYX5/kzh0XBXrUhK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823499; c=relaxed/simple;
	bh=Ut8mJ3k+V5R8KikZm3AWOWmMzt+8Gms0zA9wZlAf0DA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vz3WeEzY/BTMSvrO8pFO3u8ndgXNsUUhBcI2FjU5xxrNF8MKcqrDbQQAblFU0BEECLJFKdaiuUhA5oxvLDL2DAqSIeo+W4JHC1bo2STfKPw+KEgof8amfZHPp6DVFyvOHxGafTEN82Ypu6WbfgauJgcWVxoY/Ydul10DJuhyuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J/MYX0CG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J/MYX0CG"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0155af484so46996285a.0
        for <audit@vger.kernel.org>; Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823496; x=1742428296; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=J/MYX0CGKllQKkUk3OLXjuLN8WJ5ZUiunVH/BBYM9VQI2i4Wylg2tEt2o9w+I+sMI/
         a2hN7YKA4uOkHbmeWJ0XAcUfyyn2v3odG14IlXSwz/l4+Eo7lxJfhKmgyieCeSjBgZhu
         dfDSqb+NLWQInF9Y7fZBPCoa+uwj05SpOOhvUfJl0d3cdVRNRG1pYa3JNe4Rj66z1WYb
         w5SytroKKtxYsLydCVozB9U8YmainI7fmkk0Zq2z1rTsBRx7/DeoALnbozOGmyRV5zJ8
         SIdi4R/RYdgwCopKJuxDksGQYcmxrRrZBNfQ93DAS6HJOfQCHgfY9iPt/i/yqqX0zowM
         NTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823496; x=1742428296;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=GuHnv/ES13xSduOyBNYHt0yCGQ1kCDuGVOhmI02xdKO9xvGNAZcTBTl0LR5zMZgQOi
         XKN0TH8icsKj3f6cHkQq/WXa892E2JzuDb2ZDF+bxxUhX/fjmoeUZlLXlgOf8TPduHTD
         2U/oNhlpXUshgLRgeH0GI8IQmwEPwx8KTNHPUPHCptJ9CJofYxVoEG6u2FfBDRtaVRvq
         s/Q6exMUk5cCbUF6eEYnF0MaQyUcoXsJE6NYCxR6efmpbRBU7adUpvHtyLj32GD68MFx
         lUWsCvlITubNLx9N4B2T6+zPXaxggsjo0FwjciaUbIqEZ1c4Ov5474HaxkZ3I+rcZMyW
         rVew==
X-Forwarded-Encrypted: i=1; AJvYcCV0fOQ6oO2vFUHbX5CFy2a9/5WeS6w/zsw/JhywH4C0LPfyIJKf/36coqq5c4/mHuyvbfn+7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgsIWo6DJRjjjv/CZ+WdM2XGWnXiLP2r1OdjTyAfwLiYRj+0B
	oFI0A9hd5X3lYNkTyGSwFZWLByAu92fav+Aj/R+PX1D/mZ2ZIdz2q3mBL/5OFA==
X-Gm-Gg: ASbGncuhfNxWgLM+e8JLDKZXNsmBEUOEjGh+gAP/LdaS3b1rhPv+hV+sber+SImA6Iu
	YQCAjFxrONDxAIx0Fwl75NmCFau8HpRBDKhUQS8f9hSlkeR1EhDQtCcK5WTEMPUJ+lcTb1n4Fm3
	Nf2RvouD8wS4srUhGD91JYEwZmWY636sWeN8FJK/cJhO9q4cGEPDV1Qvtqc05MfjWXinpuMPHBV
	xP/JdvmE8m9O2Ha57wBR1tam0BlHtGDIc4aK4shi7nuUzfnddaVz/bDGJDurwr5FB4oDIRY6tYr
	X2frTY2i1OqONiX3DvNVKUtaVRDsmVWiKYHBJ1hg33Lc0hmO8FD7WRHSnnv/lqf1831Oh11QmfD
	kf+Qqxe3MPo8tbQ==
X-Google-Smtp-Source: AGHT+IFz+Ql5l9a0k7whlaB+u7Ab1OaGXxcSzFd8PxxyofE58NI5fVrN685DtdC5WBfCUDuiBPqKlg==
X-Received: by 2002:a05:620a:2b89:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c547c6bc04mr2824280285a.40.1741823496118;
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f731sm19255585a.13.2025.03.12.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:35 -0400
Message-ID: <5838489ecd5186900315f8f6c6e02f22@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
References: <20250307183701.16970-4-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-4-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

...

> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e8..55f9c7ad3f89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>   *
>   * Return: Return length of data on success, error on failure.
>   */
> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
> +			       int lsmid)
>  {
> -	return call_int_hook(lsmprop_to_secctx, prop, cp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsmprop_to_secctx) {
> +		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)

Let's use LSM_ID_UNDEF instead of 0 here to add some clarity on how an
undefined ID is handled.  The function header comment should also
explain the special handling when LSM_ID_UNDEF is specified.

--
paul-moore.com
