Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D021F8908
	for <audit@vger.kernel.org>; Thu, 24 Apr 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533114; cv=none; b=dQf1hKbD7WeMCqLbVVQuyIXctayk96ZyS608oN7bmpXZg58j30Om2kkDeI0XRY4spTlCm1g+UZGC2X7rAfutaP3F2HzhAkuABzlmD1MbvcpRWtaiYw41IhiYS4CyjQsE4Mji98RIik9MuRg8xIFnoDZlNnnFjGGWnh8limni5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533114; c=relaxed/simple;
	bh=w6LlIf28NyGBFtutNuc3GI4ql9DOzl5pnXCFXvIoaBo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WNTASdI2BRJ1VU0+hFYKATF8KuMyHJi915reV+y9abUs0NVgiNsR4sfazF+Ddq2BU4KVVBG6DSxneZJ28hzM4opr98oY651crnwlZgTimfvmpVEqzKujLOkKMHZA/o5BNMqGPioqM0YlyVuqLJOZG92zBRwwp5gKLkrPHD7aefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MBxCA2bI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MBxCA2bI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so22860571cf.3
        for <audit@vger.kernel.org>; Thu, 24 Apr 2025 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533112; x=1746137912; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDD9yFwsvgkEFtZxZyeicpTkbPdB1oQ+j/wziWiSwI8=;
        b=MBxCA2bItPsPob9u0o8EBGhOsAhxlVxo+kz2s2V0nCXdfDARVjg9LRIDIyEKmNZt2y
         Wd9qCgezgSPWnSz6lKNsjMUGZR6AlS/3UAwInpNh4SznGocQ+Y8TS3ZjixUqhzVgoo6y
         9iqs5mze4I8Zx03UgLcLAksuWDuAcgXkv0H+McXjTqcj0hbtunwiziKa1SHuMPsx9OzR
         y/aJ/2mnaVnUjNZiZd22QiECQPGqN2+OfoZ1IaOBPQ3JMZrZrCKbxlIdq7zYdS/ssibD
         0rL0o8B60fzQrJMIUnPKsdWDJ+j+6edJ2nKhWBNfkODYhYUL8XxuRYWVBuSgs4s2RepI
         dlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533112; x=1746137912;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDD9yFwsvgkEFtZxZyeicpTkbPdB1oQ+j/wziWiSwI8=;
        b=Yiwo6dy+IE4nTSHCellh50nKkSFVu4mFVQTgW/3Wo4nc5VVV/BaDIp8+USbdd5pIRp
         bAP+d3MWaj9NXcbQ+MX1WdqIGQrv9JmUtoxZY6xTbHnVVWKalElOmEhwdDDhyuzGoLoZ
         JV9fasuoTJKjAZTKopnw72HrnLz2rsbfUDjy077E10J8wnIrXYZ+s8ePyVVala1ZPDhR
         GyzW1S4akpKkVG6L+39HB6TXjndMSZqAh3cCpYy+wOZ5Cso08PXOq1PtHpnxXGMeIjqo
         FuVtpyWKQBNCu03in9BGVPtaKpKwIGlJpvHheLkU6WtsnFLNli5tv+vacREL566VPQik
         xFIw==
X-Forwarded-Encrypted: i=1; AJvYcCUuFWcASgqE3HsTQZuZb6ttgRECzGflJ0Pseoq4pPK2eYt8EU1vyJS5SG0ciUEjC4Z98YL5xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl843WGTzt6xfgcbkNPmZ/pyaHmwXXRttL7G4AvlIK00DeKvs
	ygk4PTxp8fEmxxlgnaoA2HyxcWCLk7jfJrEl7Ulm+vOEVO6Ur0nYxaDsOfPlmQ==
X-Gm-Gg: ASbGnctcjdlQFRAMSSrBKS5aRQkeKREclFr1OLYfhjjcVv7UX+hGa8QehI9JQxkEfO/
	KjIHdvM466kSkto8KJai4TVLO7hjP2k/f8hzFkQcsFVihqhzoIRQ9DxWE0y8r0vCkRK525MJDcA
	syirN1IJ/8hG7RYiNZaobDYdv8dVeQySDiMiFyHclHjnfiEFysXvhBTpVgLivF5qSIEZxBSupnv
	67+K8xWvVgfWdTHT2QY5oX9ajxlkcCYEFZVNVAq5zdGbEkyx3RvFiafCwjqtooUPcurLQswnQKn
	Mkea+DsHOWm/LB1zvWvRRmMn1R40N44pyR9FwjsVTRalQ8bsyc5oMAqHWoMLd/6MYnW3RfoC5Q9
	aOV2kW4B+Og==
X-Google-Smtp-Source: AGHT+IEHD12ufMOYwnkTSyFoER3memBLGPBgeX0kZrL8caC70GLQkKQCwxWZrvj3Wif6jPcsY3zXRg==
X-Received: by 2002:ac8:5911:0:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4801d049f45mr1896491cf.26.1745533112047;
        Thu, 24 Apr 2025 15:18:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ea2299710sm17345031cf.81.2025.04.24.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:31 -0400
Message-ID: <b515a68481217f0dee0424464d56955a@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 2/5] LSM: security_lsmblob_to_secctx module selection
References: <20250319222744.17576-3-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-3-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Tested-by: Fan Wu <wufan@kernel.org>
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
> @@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
>   * security_secid_to_secctx() - Convert a secid to a secctx
>   * @secid: secid
>   * @cp: the LSM context
> + * @lsmid: which security module to report
>   *
>   * Convert secid to security context.  If @cp is NULL the length of the
>   * result will be returned, but no data will be returned.  This
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
> +			continue;

As mentioned in the v2 review:

 "Let's use LSM_ID_UNDEF instead of 0 here to add some clarity on
  how an undefined ID is handled.  The function header comment
  should also explain the special handling when LSM_ID_UNDEF is
  specified."

https://lore.kernel.org/audit/5838489ecd5186900315f8f6c6e02f22@paul-moore.com/

> +		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +	}
> +	return LSM_RET_DEFAULT(lsmprop_to_secctx);
>  }
>  EXPORT_SYMBOL(security_lsmprop_to_secctx);
>  
> -- 
> 2.47.0

--
paul-moore.com
