Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6D31E106
	for <audit@vger.kernel.org>; Tue, 26 May 2026 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830132; cv=none; b=Yom9Yyl/estsk0Tlngu+dY9xrTm06k6FvmD0UJO8Y9xfA0U7JCKMBZtDnAiCqoRfffOYFdYb2GWtTevOKZLETPJ6Etab24AjNbW5DIWipxNAC8GyT0X24XeAe5EEPJTouhonkOfWpFSOJWlYopdWVPAab6YWjeVh0Wv0uK/aJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830132; c=relaxed/simple;
	bh=+p2x8dpHb3wfq8pCh79mAs2e6s09MSv0ARofyj2W/ZQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=JRLGvjiDoY36jRAqiHOZQMN0iViXht3VQRRZcJg9lqZa2bdKWlp3YttLeJky3r5huyV7qukd+aoXBJrF0y6l3AIlw3quXttXf1k5yoixC1TuglHWG9n1Y5nlChQqT6uBUVN/4tupaZ+FrLcSXelWlwRdK5EK1Nwu8+mxqjoBCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hgsplosp; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hgsplosp"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so148787726d6.1
        for <audit@vger.kernel.org>; Tue, 26 May 2026 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779830130; x=1780434930; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rIEMh3IVqmiOwE11+COExVcH9CPm4X1Fby5902HXM4=;
        b=HgsplospzCrEQ1Eo8mdYbjPiDBbXelPGAMefZXg6pZtr1siB2zBF3okSqEiuvJfW6d
         UKy3rHXRpPvdmcEjpdDh0u4lD4pzFjYUcLF/ZgPXu5wAp6a9A4O/ptrW8eaDBdxU2FXv
         o95xttRKN5oEwWJYaa+l/Fhdvi69TKIGyz3tpQCIgqR2daWIwRbf34ox3iTYwQ2hwcdA
         7ISPNCq+89h03DNOJSwwIR+p21WwfnblJvGJyUISFvTPyVlpuHdw3q1W8Yl3oIg2PvFE
         4pDeG0ADmbt4pGmk4PT5e/s0XsZNTlhIVSg5BdvJ2b47PkxbDFv8FWX5qyFkoDcwGUZq
         MjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830130; x=1780434930;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rIEMh3IVqmiOwE11+COExVcH9CPm4X1Fby5902HXM4=;
        b=BUJXa+hPx2QtZyttOnpiuAjEWjIYYiUFw1FmWoYah9am0bqAau3ML1RhlDl9YbkvZ7
         G70Yjx0q2nBuJysu1/6z5+Q3wFbQkW4oBh1Nf598cC64MydQjfe3FScCNnpyZqpSqCmy
         Ne8jYCxzGLa5gmXpFEPk1aB9ZqNOGFWruCDF4v3C+eeCsZA44FXM6n4JwZF2pdpBB7ll
         6XeXkqX2vTePGcZavyRki0dA7uKwXwwIUNETm467mnCSDmMA8kQCIIhq4EasduDXImsU
         TT3u5ZhPjPF8GZynJRUSYKRCb72cdCbGTeFvmh5DfDsjxf2fWs9GjrB/Scr9DHaSB/dM
         3AkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x/5Q75K30z85GLe5wczqD+xrc0V/an7MN82U4yYy/wQ7Hf5HJZcjzrqZ8G/K5wIPYwBfC+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfOrDm0hpmPJn77tCLrbA4iOlrY5M2pBwUpjOr8HPC/StEqZL
	x4CuCaOkx4ncmbuwuwCXuWRFeXIi0v846hgXYYcVRwsSt8UpBHO5Sx4deDcQKL7W0Q==
X-Gm-Gg: Acq92OF8QgAjHXoMGm9604Cv2MlgdNXV0zgoy6OxcbswrGyTekvGLaUn4FohZBc0wPs
	5daLO2FcgF8xZT/266YZicWY3UMCdEwKmUzBhn9I9ocJ9e4gAhxYZHTwwroIWZAB1K1xcbmF6Uu
	LIpZycx6+3WFtFNwu7bnnrwALLlj4aglH+yZ840PizPdtECzD8Bh0gQ0BF37uQq+25r2iRVJEXn
	5490TY0dJlAixunEe0ISzw+ZSZLwW1TjHv5jTP2WDKGb4K+2ehQS1GqUGBpiHuqBe80I3LB2GyT
	su73bCFs370NR8k4QORsTv47t2Xrc/dhSirWFB0fE91dQ7TsNbQrr9qqQsrsmMbYrV7JdDkjSWi
	iyqIAtBrmg3axEzPXiPFuBkIqqh8pozZnUVaFUce9+x1dKTrYo39i4aFRaemnKtX1MwVip7jLKm
	DOdOatR/Ug/xtZ5TKu2TxG9XbgZZqxpusT1X4b+DtalraTlTdA6sKF3WZaGTA1A3uHtkLefMrUG
	CJASxg=
X-Received: by 2002:a05:6214:5a03:b0:899:f24d:1245 with SMTP id 6a1803df08f44-8cc7b5eaf85mr323356556d6.43.1779830130162;
        Tue, 26 May 2026 14:15:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812df29esm152311466d6.29.2026.05.26.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:15:29 -0700 (PDT)
Date: Tue, 26 May 2026 17:15:28 -0400
Message-ID: <96e71b4f0f9685a990fe20d7c49fd669@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260526_1654/pstg-lib:20260526_1539/pstg-pwork:20260526_1654
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: use 'unsigned int' instead of 'unsigned'
References: <20260514151320.1939290-1-rrobaina@redhat.com>
In-Reply-To: <20260514151320.1939290-1-rrobaina@redhat.com>

On May 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Address checkpatch.pl warning below, across the audit subsystem:
> 
>   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Minor cleanup, no functional changes.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h      |  4 ++--
>  include/linux/audit_arch.h | 12 ++++++------
>  kernel/audit.c             |  2 +-
>  kernel/audit.h             |  2 +-
>  kernel/audit_tree.c        |  2 +-
>  kernel/audit_watch.c       |  2 +-
>  kernel/auditfilter.c       |  8 ++++----
>  kernel/auditsc.c           |  2 +-
>  lib/compat_audit.c         | 12 ++++++------
>  9 files changed, 23 insertions(+), 23 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
