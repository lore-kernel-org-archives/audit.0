Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C37221FA8
	for <audit@vger.kernel.org>; Thu, 24 Apr 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533117; cv=none; b=h58tN5FnEEBGuttZOYCeOkmq7rvP/PPzIKNvOQF9nEzidHKcBhyJ4C42bNfD7maThwYO3d/G+61/vQ3MWLmjnbN0j52hq1FSWcUfIqPSzbf6x5JDdeZCZWXjuMCkXPfmEqTctMlHDAc5ENl8CU5Fqw5gOT9rdLLHgkURGdecP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533117; c=relaxed/simple;
	bh=h7bS8t6pLBwRLFNubDUutpACHo61OxsUV8u730LTnig=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MtZLfMVy7Bg1H1CpGrWl0KEdkl3Sru/TcfRffp+9LE28xy0hQwQxzhyVWpWCDwoSdWl5m9ClUWCi1uXogN5sq/SCZneGvHx/u5FEewetNLXq5D8zt1BZ9gcmGZjgxWowj5/Uj1/SUvYy6vEtv7WIceQbzaQoXiJyTisCasmi+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WuL+ZVmF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WuL+ZVmF"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso15070546d6.2
        for <audit@vger.kernel.org>; Thu, 24 Apr 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533114; x=1746137914; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAjyXB+CyDav4k4P6PubMcZjSZyXZYM+TboJS0Fnb7s=;
        b=WuL+ZVmFB3eGhyW1vpV1hiagAKqGRt34rxaY37woXQl6y2AJJQ42uty6YuYkOQdhuR
         TYSvY5oo1bmaP3V4aXdl8wCoZhs08vDnw46tqTm1Znm+Y860XC+UFXmaVZRtjKKk9Dqo
         8LOpa7w/tVe4teV//GfSpzdriWNK91pKHsDph6e9JgNub3lRWWyrUDDiOZL5NK81NnRr
         On0wCjVpf1NkFUexqskbDEmEM2Yg7TjfTjvgPQkdWPJE8pF4auz/0ajEPZD8IAWRn6kL
         UJ6+w0uOVCk7xbyY/tsRv7jbVscQ5xtbpN1RRowvKH13sbFToTzmwWTfd2aVLmzknJrW
         C/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533114; x=1746137914;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAjyXB+CyDav4k4P6PubMcZjSZyXZYM+TboJS0Fnb7s=;
        b=O0wAN6rHRxW8HBtY1dLDvtzT6xrnYGoD8ClAo3bcXVPs+tzso/Fw9UfpTRhLYljXD2
         td+YfzbtFYfoGxewRxiWDPd0Z4brAOX55cslMweBbL19GlJ6udp57oG3pygU0fI35yAR
         dqEA/vN/pK6/52xbVuvo0ZZArFfG5Ay1jrKgZCpxUMX8+4mcZQJLneOl/JYVJD+fwkHn
         C1aJiAPwEMXvtn9gakgfobdMxV33DG5dvFcNuvGZeP46O6l0FxSY4AVwOOMmQolKUyr8
         JOZ2XDiiiY+OTLEXp8yezVQeZDwLgrR3m5kbqJQIv6mEVcE+Nv/ldo4QoV8yB5WohS6X
         /OGw==
X-Forwarded-Encrypted: i=1; AJvYcCWXEmUTdszGcz1/lkLhuvmOVUxBZ91OxnYP33iDgQG0/HaFNx4+gnU6L9OTwGBNQDg+kmt13A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoQGSfiWmL1FnUcrJ7LeyBmbZNFoatJnefzS6/T5OJh1mn5Bz
	fP+Td3aHxRtym60X5TcbNLb4nLiBANbh1vGa2s03mQLpOYtgM/mluyJSxeRArA==
X-Gm-Gg: ASbGncvclo6o+d69u0LAHnLTIXw9bCOC0AXZ/p8AE5bdSbY24zbhuuoNBYoyx6Mcn+O
	0/CaPul+xSp/6XkmxVaYvKLY5j3icvtT2BJRUL2YEfHjP6anIDw5wP7nRY21C0h1UrkOUv/M3/h
	hCxbytKkTQHb7GAkr008PBga39TSpf/qyow4nRmlyf/l2y/+3kZX64wJYRGX4sKQJLhFQ4XcbAt
	2JdBHSp+sC25yuRsizVQiS0YRiPDWfjA4ML9vMZ9BcKavnfFQvv6Y4khrY2EwChBRhb+DXmiqct
	t8by+aMlHDP2n4eX65hzA8wjgJbb6eDTQvZ9nKTa0wTMu36aGmOMSZC/aLDyRX9wztM7qpedCvz
	azkcNGfOuNg==
X-Google-Smtp-Source: AGHT+IGXqCgssDpLUT5Km+2/uYfoayGN7KEZy1Sw7rm2oXTApNyBMkE2ly+T0vaDsF3ffw6xOmoIag==
X-Received: by 2002:a05:6214:242d:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f4cbcb37femr1511986d6.10.1745533114161;
        Thu, 24 Apr 2025 15:18:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0a7433bsm14465726d6.93.2025.04.24.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:33 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:33 -0400
Message-ID: <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com>
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
Subject: Re: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
References: <20250319222744.17576-5-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-5-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  7 +++++++
>  kernel/audit.c               | 28 +++++++++++++++++++++-------
>  net/netlabel/netlabel_user.c |  9 +--------
>  3 files changed, 29 insertions(+), 15 deletions(-)

Other than moving to the subject count supplied by the LSM
initialization patchset previously mentioned, this looks fine to me.

--
paul-moore.com
