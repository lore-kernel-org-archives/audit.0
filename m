Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD322B584
	for <audit@vger.kernel.org>; Sat, 30 Aug 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563329; cv=none; b=o8n3c2aM3pCiH9AHb1fYGG+L/Zz1VUk8s9VmcURRTQBJsToROfPeZFyqV9NwIUYhFiUwJWJMhF2holS5jPOdFMQbfnbB6nolq/h3Jup3s/+hOCg1H6dvw1qD48AJlLIHvBdawJmFny6NZvCqfq3TufjWJOKH8Sl5/qG36eNmOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563329; c=relaxed/simple;
	bh=lL9TZZ/BH9fXb2IasJ4LrIBwJ6L6IbyqBrTMpkJsTsw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hQoNDr56Lou+rndXpdB/EamgW3kmFUgg92TiKlmIESl8SOxTS4+NsREILE0wuD4MxiZn58+YKsjefG5dzbD8uj9W3bVAw+CoMrYcsIbVVu2OUiQqc7aGvsg7w7xNFR4ctXChG4KyNjgCHjQxGAkgjAIUWfC6H6XqM8e9d/YloU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJ2NKvoz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJ2NKvoz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so1880200b3a.1
        for <audit@vger.kernel.org>; Sat, 30 Aug 2025 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563327; x=1757168127; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=CJ2NKvozbnQRJikyMKUXtoTkcYjVS71c5lotg9+KiUwjqlXMeNsPUhDlyFHHqop+wv
         xZHMPuYxXYsuNw+GFZ8wpxj3ABBgYq0QSE0XSgcWxZlqK3Kw3ziDbzEYNLylxgpiTTl3
         3KpTDRIagFQPTLzfnOgZoPmclC0F9sqCt6q/9zILW+mlyAltckaec7A6ETwWBo5W6G14
         /7WNZblcENNYufhjgonfpWyUA+Xn9NIXBYdcvDav+gV6L9Lg5mkskUJSqw6Zr1XkpVPt
         3XcmcUd0n5G/T/VBkzdwlFcdZ2BZp3Oejor1NvirSXIwJi10ZJXNOHLgm2kBQvDQC+4z
         7NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563327; x=1757168127;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y69h1UcOXut0Ylir+EUHpoR9nI3kmLoFEjeqKBYKfI0=;
        b=a+fhi5At3d9GlhkdGS4Ptj/M4frGsg5hepVP+ZUJ5U0/Jg9LjL+FXYtdaZRioKCfeb
         J8A4OH4dp1x49V53hMc30aE1kV3fdFUv1Wrf5fXJwDIkZwBHbMcGxOFKHEaXjgKBwxzX
         ySMvqZo8uHmtk63aA+qXlvY5IJrTP4rn6V2RQWqK2ga4bhRvbQkjdgfP1I+x+0oIwa/v
         3C/tbA9PBs/oRF1xhjP7sRsDkDep9y+zgpLS+tVl+Ud4qaxgMTdw2Xrlv5R5aVsL8/hF
         wrOIGBUiCuM+SioEWaxhIbS/pYchD591XQnSrYvytEx4CJJ0CrsAllzqW95hqtV1I4E+
         QSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmCzp3GvBW87b67Ys2GDu2M69LYiydVHJHNnx/kbckL+1Kn0OJKz3fO0zkSwsd8u+u8cpGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyTs+psWZrRMfQnTnSOkH3ZR8OrPN+llvLXadym3Ib/iqG9umd
	pvoJmE536Y5MCaL3OKplPmlbFNTFKTwLWA/3RUao3AxGfdpMZGRG4Zv38s0Mf5fYHA==
X-Gm-Gg: ASbGncs/Ex2fVs8Rmx6jGDUOzj/kww+G1uONGzidmScw5luDUCfxanibWQpSTmQPPg+
	iqJGlB3VbJtVrdKs3Pepgn8d6BHmFihdd1D3ONQtAXEgYe8iDLpvY1DQ3/Z4HSDEf/qybckGeZn
	do1v7UqSah/oB4lgrQ0c1JMFQrFQxHE4j7xZP5SIjQyu7wJKEhToqnQ4YQd3UJYdOZgPS4i3wv0
	GqI37wvKm6vWoLsu0HCH2zzewOHx6CFE2eFJwOFf9PBIT7a443maFdIiAVgleESQz4QTijSaWiY
	uBhptHY40UWYbZxSKhhLLq/46grVCeapm6HfTkr1ZH3dW+EI7x4EiDACRrN6tM4M9pWMvzGuTFT
	wsFpgm3utrNwBiwzXlbtdYrpl
X-Google-Smtp-Source: AGHT+IGL4OfyFEaEZdVSYEKPN6ZBrAyplAqXNRfv6Ik+ZXab4VyJSnykpSuF8eLpW38m9zQkwRaHpg==
X-Received: by 2002:aa7:8881:0:b0:771:e451:4edf with SMTP id d2e1a72fcca58-7723e0d46cdmr2221100b3a.0.1756563326726;
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26a0b3sm5441563b3a.10.2025.08.30.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:26 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:17 -0400
Message-ID: <82fda5ee57f82d4a470d08969781b6c0@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Audit: Add record for multiple object contexts
References: <20250816172859.6437-5-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-5-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS record is:
> 
>     type=MAC_OBJ_CONTEXTS
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 38 +++++--------------------
>  security/selinux/hooks.c   |  4 ++-
>  security/smack/smack_lsm.c |  4 ++-
>  6 files changed, 78 insertions(+), 34 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
