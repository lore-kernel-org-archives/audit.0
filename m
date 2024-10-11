Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BAD529
	for <audit@vger.kernel.org>; Fri, 11 Oct 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609654; cv=none; b=PmAg/gtIzPiMKqPqVQLhn58NkTixsW4shootxCn8pbFQOe8d7usSHKijxw7qHbLgyWClglewisCJMrdb7qYDLjO5/2xTqU3Rjvhi2iE4bMcQmEA30CkcCoTC8fskwDsDbRA0eLACIkRDdW2NaTaLuFgHAGUzfYhxKUyTg+C7GHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609654; c=relaxed/simple;
	bh=yslYLZ3UmvXQ3tXwi9DG46llkHldFxew638wc6nmTfk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TLLrK4ladWRm/hZ5UkcevLHnBDV0NcLEteEJc8HwAvIBErHiz31KAUeZsPTVZZW917d6dTUEr+A9voJ5OqetjORV9gqkHRmpU8Nm0+ELwhkjPeJ55xWH7+bgAuAtUEWd/NRL40Tfx7NJkuS0/6FR/gkc8LDuuJGVMZZLdxJRbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M/3NUOpU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M/3NUOpU"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso16835026d6.1
        for <audit@vger.kernel.org>; Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728609651; x=1729214451; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=M/3NUOpUqIoQ77RRYcYI/jJyZ/Xtik7haqQnRIc03MpHO+vtxDG2so4zK5yXMlOE70
         esudG/z4yLG0d93IWpHOIDMhnwsPhvUSVQKzYI4U+RDv9nSGCIMc1aRQ8RgzC5/wTPO5
         HmOyi5mXt6Ny+XHkhUuDcMaqWDk917J9DPurXoUOLSIDv4k2rMy8mK5O6tsbdHqgbNAt
         qsWSihDuCmm2NYTlAhzp/Ysf1wkBA1JxdPenX97Qf67FGbBgF61TxwWWj1mK0F72B0OU
         daZDc9DYyhJMId9SRHG1EcNLVI9r4z3RXRwF37OnDmv8CRz2LjSmJpk7hPPeAueeZqPG
         M1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609651; x=1729214451;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=HBERDtun35JWMgnAkzMtSga23xro277wyC7zWpT7hl3lpytBKgE5C1SbOihSu/Vl7r
         SiHM5mOSNi3uumKeeraI5qCaP7nrLZJpkqdwTFn54hbQG+iq5dj5z8ZmflJ0cMDMQM/i
         iWzLY9DOW34qFt7tzwEvNjWtNT+am1ePbhI6Lu2jBW19vu7e9MbBrwOpJoOK3Wh5tV8s
         LQofGqS3OF3Mv8NcDayveaHl7Tei0SNAmaJFOYItyoWx2Wrqb3I7TOasl3OyMVyXZFDI
         Ofj0YE8HIzkdckcLsqyCOYnu2xosHaZZMbj0ftzKGKQK9TWa9dKfGCEsywJ7rEDJmyd/
         29qA==
X-Forwarded-Encrypted: i=1; AJvYcCXN5bOFIeZba0Sr0ZC/tAb+H71x9So+Xu5HNzB+8eddSu6q23AMDwip1Jsg4G12ucnKYU+VNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZo4wRHYEq/fhDqy5seQgfhJiPIq2AYiHElcCX2v1uLTyHm7H
	t2eL5LMm/2Z7mWnA5PQWW7xnX2PW4BtVWbjdlge0U1cKYhBbWZ013rOXkPDTcQ==
X-Google-Smtp-Source: AGHT+IEqJeWFt79nQGeuR3bq2NUHrSRVHy+WW2D2IxkX40eKx9WlSMBeeYzd4yPkBCBf4eMRVOJxdw==
X-Received: by 2002:a05:6214:498b:b0:6cb:d3e2:ea0d with SMTP id 6a1803df08f44-6cbefabae20mr21350876d6.12.1728609651103;
        Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608ebasm10941006d6.80.2024.10.10.18.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:20:50 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:20:50 -0400
Message-ID: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
References: <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>

On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
