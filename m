Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC4214A6A
	for <audit@vger.kernel.org>; Mon, 16 Jun 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107608; cv=none; b=Rzpp2NAj2Wwol3J0iLswRc65ZZaZIMp3QgMcM3fOpCZ6VhjSBuzkevkcQFRa4QdBcPPPahVGon6Eh3DAfy8F8x3UJ5kh0qrc+XSoo39XkGNDEwCP1LLyJWs1zOXuFm+f7+n/t5Bt0mUo4ueEuktZupZIjg7Dox+lxXT9KpUKRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107608; c=relaxed/simple;
	bh=85V7IA2aISIwTDOJA3zCDbzaPGLMrAlD2eCpQ+pTtCY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SXs3Bv+eGrNR9YLeCGMJDkUDA1KSXJRDA4tgPKNDLTpzNiXln9x1DsfPGci40qOjNJiyvM/WXv8Xzn+kUe/Bme5zEn2rIhUOtKz5TNepEguyB9noqhgUzLPdMQBBh+ztlSatpNQkkwcLn9TqvgBScDmDpsRPNsJg9Wbt/Pa/3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LX89Feo+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LX89Feo+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7caeeef95d4so551117085a.2
        for <audit@vger.kernel.org>; Mon, 16 Jun 2025 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750107606; x=1750712406; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65voBFu++KUxAGnb17CUWd/eEc8FRKpL+JgvnIz6Rz8=;
        b=LX89Feo+52pF37QwuNRSqtLtCdIxpG3ehzgXg1AzH5HAeAA4IbflBPFfo/+UT03ae6
         uQBGvJ94MsLCOBAvPhFNnBHdEPWIGaFh5mPjBVn6BlP0te/8+oUtcHnHXKaOiIYQNepX
         ZyBsjRzk/zolnlNdYwUlEAzyDMQsLUc8lHphTo9J3PPrqzp9VP8wdW55Q/iacsJdijGW
         GS4v4BucndWqyts+r6KyeCCT37wYwN/2sDG2aZz71zUGyUjJZsOAX1lmDcVLZdnFWwCF
         hhitpJFA3e1lGqdf1lMTTUq/uP+loqHNpkuKBiTfF+WywJA7ZAauMfMGPlaxywLVxfXQ
         d/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107606; x=1750712406;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=65voBFu++KUxAGnb17CUWd/eEc8FRKpL+JgvnIz6Rz8=;
        b=JpmfiF+69paLYmwwEjnQEkYJKQB+xHthl7Hrhd9k/+KTEtkxX/VjVnlRl+ZInI4jyd
         xcHrZYKyjRavvOIIDtIVNvpaYM7wx48fW4m1mmCw0NUdpUCADhoq+eqGdm5g1JCscuT6
         xfj4fKfn+jZTq5L1tJjBTVmJxC2V6Z624Gz6xsG6Isz2r33qT3Z3Vf177dOJhXASoJQB
         VeZOlkYeHpsLUVfTXMEcBhfTAgf5v/YclUc1l4te0gpPiia6jKqobbSokdcLe1ERyybQ
         mI8jPPFoBE4yizR4xBPgpwt/ioS/9xPYy/7EO5fwXZ/bMhFJ89BWRPt8xwD8eSBaJ4W/
         rKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWy8HgbWnXd0DacPJHxKtU5gRIGF6oowoOmqWr50fjBFji/+6WUNWjcB6f8A/Cqxvy/ZuconQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFI+FvxYbMcXrs5R2QhzoP0zoxnbbU+KiQ6o86JlWCx7Auol/
	3TFRPMABOnjvk5Sds1A6+fFfZwp0Zo2fGmmTFeHW6pgsjYHPj9DG/lBCEU2e9LayqA==
X-Gm-Gg: ASbGncuiEJ2LkIh3wCpnpCcNxLekflrY/C0f81/E1d1trmByatfwG/OYTygvGaaJHwO
	OkCREQVbHVXKXotpHVUvymlPjDxn8TEtXyb2fUVxm4rASRwFqJNcbKrw/8+E5uCCmWvLK/34oEK
	k3zs148D0BIzvDoXYMRonD2VQeBh9xKEjGxGxpdXZksr45lWODD4zwOH03HvNQZnHPUY+6Vg7Ec
	YLje5anZgBmXQXwaUaeqZfb9Dmj0KMue+dNKwKkZ3to/f86Amz1qRkuWOY/nJLgquHSwpedc2u9
	YyE/X84oQygF+TBqVvb5WW0jCuWg2m94WVagwbZB/2vBxOyNnIMAGNW416INXr809rVHZzreC/m
	I4gEk5HqChWPlHSsg26kL8M8a6PT2aZY=
X-Google-Smtp-Source: AGHT+IHaG7XFRU2VIYe0CJKJvqwGmo+KTaXV3iT3aOl1lxbWuUv/pC/6cFlxEol951+BgG6B48ONvg==
X-Received: by 2002:a05:620a:f13:b0:7c0:c469:d651 with SMTP id af79cd13be357-7d3c6cff2a0mr1547477985a.57.1750107606484;
        Mon, 16 Jun 2025 14:00:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b8e0535csm569975685a.41.2025.06.16.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:00:06 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:00:05 -0400
Message-ID: <baa9721a34d995cbcc9f7db5c9eba531@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250616_1212/pstg-lib:20250616_1001/pstg-pwork:20250616_1212
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v3] audit,module: restore audit logging in load failure  case
References: <9b7b21e5f37f5718fe9176a36ebf670bbdfdd54a.1748462545.git.rgb@redhat.com>
In-Reply-To: <9b7b21e5f37f5718fe9176a36ebf670bbdfdd54a.1748462545.git.rgb@redhat.com>

On Jun 13, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> The move of the module sanity check to earlier skipped the audit logging
> call in the case of failure and to a place where the previously used
> context is unavailable.
> 
> Add an audit logging call for the module loading failure case and get
> the module name when possible.
> 
> Link: https://issues.redhat.com/browse/RHEL-52839
> Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> Changelog:
> v2
> - use info->name for both audit_log_kern_module() calls and add const
> v3
> - use "?" rather than "(unavailable)" for consistency with other records
> ---
>  include/linux/audit.h | 9 ++++-----
>  kernel/audit.h        | 2 +-
>  kernel/auditsc.c      | 2 +-
>  kernel/module/main.c  | 6 ++++--
>  4 files changed, 10 insertions(+), 9 deletions(-)

Merged into audit/dev, thanks!

--
paul-moore.com
