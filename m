Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894A3A9DB1
	for <audit@vger.kernel.org>; Tue, 12 May 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616641; cv=none; b=cd50x77dNAV2d0wjo4ZwnC+SkhhlBUqjeJu0/8no4eGdDeUqaPwKeOUMJ8usLRij8PDv5hM0O6M2m16roaTAKKO4o8yJE+dZX8Xd0VwX9S4YbyDXFhMnRATZtXtlg/cXmkxSjomPwQnf4ePMYL1pBz6B55Kid3qGlpMfOBe9pHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616641; c=relaxed/simple;
	bh=Nded5YnhlvH7B1W7gdPtOrHJrXkGJgNX6Ulgohu09Qc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BxP75Tpd8UkdCPZXQMr7EJPb+4IOZcFPYrMaAXPzeAdkxgHllbUA4seSdm7SwjLuHlPIiYePq3+7nsg3FoylFWJvLry7VO9vtzUvxz/3sFtyFi9cbXAH5CUNwi9Q7uyKxSlvS0cC178MDvzft63wWjclY4BnLmHxYfAXOo+klpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dKCgApIf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dKCgApIf"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d7e7f48499so650084185a.1
        for <audit@vger.kernel.org>; Tue, 12 May 2026 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778616638; x=1779221438; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7VZy+MYmGnp0ISA3F0kBNNHUQXAunrHLeetlXx9KTE=;
        b=dKCgApIfi93qZuCyD5h5Sy2ALspexefNABDXIxp1SZa3wRcznJ7x+1CQDn6eVDQ8CA
         ckaxAarxoX5lxdiTtrPamOo5f+7lpfiqeMeKJji9IfSH10YsZ2VjMXP/cUtC60vVLXAv
         WeCCUxaLKgE22XcaewqmYvRpskXUx1oyEA+KX4ajfp7KbCExyEXPJItwmL2oaR//jlas
         xRzHg01SmV8cdyhzIeEZKefmQ4jlyhY8TevJ4Ti9ZNInC3cZ5xugsOSi13cxX0AKaqAj
         rAhMo2VyAq3wAj/hoDmBq810AhlGhrQeOuxzX+Kld1BkcwmThADI4q3cOvDsEfvgPZJS
         mpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616638; x=1779221438;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7VZy+MYmGnp0ISA3F0kBNNHUQXAunrHLeetlXx9KTE=;
        b=bzOEeeD5ZldFFtA/iKthT1nsWqQfiVikG9eTBwP3qYHGYLFkmUL+woBim4pzycBSqV
         qAoGsXdpacykXzliiwEV71Inj2jWDgEWTHGdJU0NFOb6+sPzjlj00+gXyMYg3y8tqF6s
         LN5MIZHXAtUEtSaxH4m+2lcFTsxsU7zHaeYuhjVMURUcpZ3Vvwvqm6/4LSBpKKSo0T8+
         2ZKDrv7DWI9GmXCYDphHDewKxcOoEa44QbJz7OSQNBbv2Cm66jxJdSZoQlsaPwl6K3v/
         JmlFylsrrOMaZGfRHfTeH4s4d+2CIFIVVJ8X8cPLsIzhID7tmvCLv4ST2R1oi41YcLMv
         D6BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yswhW4nw0ODm6XW9r3pkrPgKS1OVKCqE3bLv37Wa+COq4KrXdkmtMIhOGpyul9GEeIzCjwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dtEc/1IbmD7Gl0dv7TCGTytboBImdxe9JWkY3Lf11xziSHRB
	P31DJ9+LmG1os8hG5z0v2bBTLCM38iilmp9R8P1urggpa2JOvrIw3Sr/Hc2MayrC2JCWOaTYNxZ
	z+TM=
X-Gm-Gg: Acq92OEQHuSC3RaQgsTYMxUvA9YzUgKl6c1PY0WRstMACxc51LsF3HJHjDA/yUmP6BF
	09EFc0ee7bL45/fMAsmzrYDe8hNjcdQYB2HHogAgNyD3zqu1055M+7xN9VwZJjY/e/3j+0RiGFT
	oehEdi/oSiCnWzSynDwPS2AFmVmGClZmHMMc2tPWmpC7WhNk9DKFTPh2kpUwn+tlJ+7ELHFC76Z
	qkLbw3Aw/njYIHaoz+WbVnbHJTEcTu+rIFyGrgN7A3IuOBGADXAYjgo3AqgAA945B0qZNvbiBVW
	cQuxS4q6eduHAxOxwJ/5iNAxfLSUlaLvDoW0R2AGe8wkJbp3Mvv9nTDzVtt/l148Nf0Ljm9E3MT
	AKpYj+CKMcztnZv6tdK92onDghjQXjMgXcddqEjYtwEzoNvvwNwdQbxpVUqSXoFEq12BVexSyQY
	dATHTk3qMLUlNh81ByBbQsjWywbHzNLdRqNJwVfuNsR5ubt2T2AtpLSHW0rxZEyyBkOFX5
X-Received: by 2002:a05:620a:2806:b0:8cf:db04:8a39 with SMTP id af79cd13be357-90f8a44765cmr73906785a.37.1778616638311;
        Tue, 12 May 2026 13:10:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90cc338d234sm365224985a.43.2026.05.12.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:10:37 -0700 (PDT)
Date: Tue, 12 May 2026 16:10:36 -0400
Message-ID: <c75e43417311f8f594ed94d96e4950c2@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260512_1209/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Sergio Correia <scorreia@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rrobaina@redhat.com, Sergio Correia <scorreia@redhat.com>
Subject: Re: [PATCH] audit: enforce AUDIT_LOCKED for AUDIT_TRIM and  AUDIT_MAKE_EQUIV
References: <20260512132859.1305499-1-scorreia@redhat.com>
In-Reply-To: <20260512132859.1305499-1-scorreia@redhat.com>

On May 12, 2026 Sergio Correia <scorreia@redhat.com> wrote:
> 
> AUDIT_ADD_RULE and AUDIT_DEL_RULE correctly check for AUDIT_LOCKED
> and return -EPERM, but AUDIT_TRIM and AUDIT_MAKE_EQUIV do not. This
> allows a process with CAP_AUDIT_CONTROL to modify directory tree
> watches and equivalence mappings even when the audit configuration
> has been locked, undermining the purpose of the lock.
> 
> Add AUDIT_LOCKED checks to both commands.
> 
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sergio Correia <scorreia@redhat.com>
> ---
>  kernel/audit.c | 4 ++++
>  1 file changed, 4 insertions(+)

Merged into audit/stable-7.1 with the expectation of sending it up to
Linus later this week, thanks!

--
paul-moore.com
