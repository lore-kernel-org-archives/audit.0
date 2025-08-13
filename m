Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D227A446
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100306; cv=none; b=foHVim6qvxWqrWwQVHmja8CJRLT9lcCJWB9aBjVfTsGKLgqFrwINRN6ohZ5fhZ9T2MqCRANwjzZLNXl0zvbab5ggFFwADlQ8bNXSdFdX05tR+q04aTptI/qCtcoVtGthodzib5IAqvdxPHJmf9W0sIfGaEtOCKmm/hVgLJWZlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100306; c=relaxed/simple;
	bh=NI/e0Y3+s1QkGxWx3m6wQ0kYdQLGDnrZaGdrQ1gijK0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=alVUwNXu+qPGRi3r4OIC92r6kGBwqF7eyzRgF4DvCxHUCTfUzz6KZNXQtyrCru/JoMiLTA4La5XFa9mYPyz5PeQm4f4DOghIDkyuOgzxmsb4NbXD0iItj2LWHfasUSdEbMGcVZ9ZS3r0zxcfvP6YeIp6rcjDEb/C0uUqUOKaJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eJwbnjZe; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eJwbnjZe"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b10957f506so777721cf.0
        for <audit@vger.kernel.org>; Wed, 13 Aug 2025 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755100303; x=1755705103; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSZNbk+TN65+sC0ETrJECleAB80q6fi8W4gvr84DJq8=;
        b=eJwbnjZetkRFWG5aOqS7y+hG/cTDts4gbTXteIEGAEhMPDN/dwTrxKIF6Vs4w5esdt
         9xZfNQtXmhoRUVLHErgjZvDdLqGbElbJSVsxgtalCQWlcWSz0RfE6le+u6/UAB14wNc8
         jk+tzWYllGJfWfPx+SsPo5oNrwi5fGNv7bP8lbZfYo8uQVW87RFJ7jnycBV8p29I9bnP
         rrP+VDi+d/VgCHm33Y224bFJwXAKJqlDdy0vpy9zKgVj0HJeW+lFLqG3u8kH4gTf0int
         1vhw2xcwoxH1hEpVR4I31NYXbEUxsFnIE9ah42gFas9jqKg72IPpdzWDerV8m6AtefGL
         goIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100303; x=1755705103;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cSZNbk+TN65+sC0ETrJECleAB80q6fi8W4gvr84DJq8=;
        b=Bt+luBY3Kod3swvViI12FIBivga3D14Enzxg22TiuijMsTz904C7chuhDqzxcJjn4X
         NQiIZiDE+OjF445JNpjGEM5njwAvXbOxoRpyqhrt0Ctx2LYsmZTah/kSR2FYQQGuzWg5
         W2HDQfvDrn5yDt+8seS3TfDorRHqa2pJc6VCyweHaX28l3BtcfDbMA0LT1KHdnK3PmJb
         4AKO5S3g9BsjxsRY9zFY+TzgvDPAPH3kiysOQ2kqLmcxJwaM+FTlcN0dFyor9+fFcB8i
         c4vl21VF3W+Ieo2NPfiBQUbD2Cih64U9Gfq+55gUlJ2w/j30qJDt7sZXrAbZFdoIixf8
         Sr4w==
X-Forwarded-Encrypted: i=1; AJvYcCW76VQpjIzpFzPF5FzFn6X1maHJaWvxZf9kcnYEx3uP+ghS1LvLHl6rLVowzMbsfaJmMBjTiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAuYkr1MqTSrsz1OubQguOX08zmiMnoQlyVIv35svJFj562Y9
	0qSqCA8NskfxnDI10Qy9Z+xuL6vcDUTjXNIPACfjrmldwRc/4oDe9L3+3cXfCoP1y+dyUMVhKuG
	slbA=
X-Gm-Gg: ASbGncutYO/WIkbCFfpd1AMMXHSZgZ5xJDDPlvNVlj+/KRofOzIQbs5G+wBuFWD1Z+I
	Toh+Inl97moaX/agTj0PhWQxu6N6OwsfElL69NezkKic+NZuebRbs6c0AS8HCjg+Cp0N2LHkhOQ
	O00RBtF3l1mGiNjTcv0ToJTJx0hfgSdsZylFkcxUMWnut7/NvGCnHOczFp1meEBzYAzPAJHjg7C
	alVwtR8omfY0LtTQUubUblijmHNumaMK42fgkvvLLBfv7bAp9WLvg5na2nhbcBPdwFxXtvJM9h6
	/E+ieRlrLU9V4frZg4LWhhK22iLqYUXAFIgdjDbSiq9qmPDrIpgYiqvP/SwVLF/8RBNN4LNM+dd
	P7eMzlaEosePMZuwMxQOqEdNdE8ewjSaikS0gMm+DQdUg+4y3reP9VEOSKsiKEKJv+Dw=
X-Google-Smtp-Source: AGHT+IGFCJBWX2Icu2aYWunbCMiwoJI4/WCzPBp+aEG0Ea/nYQ5twVDchw4xZsULxUDU5X/I+9N9fg==
X-Received: by 2002:a05:622a:1a21:b0:4ab:3963:c650 with SMTP id d75a77b69052e-4b1099cd66dmr1481411cf.10.1755100303329;
        Wed, 13 Aug 2025 08:51:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e82aa29328sm1027746085a.33.2025.08.13.08.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:51:42 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:51:42 -0400
Message-ID: <235be32786cb9a6c98a464d202c2daed@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250812_1310/pstg-lib:20250812_1218/pstg-pwork:20250812_1310
From: Paul Moore <paul@paul-moore.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] audit: add a missing tab
References: <aJwkwMRSxUAvI4dF@stanley.mountain>
In-Reply-To: <aJwkwMRSxUAvI4dF@stanley.mountain>

On Aug 13, 2025 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> Someone got a bit carried away deleting tabs.  Add it back.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good catch, thanks Dan; merged into audit/dev.

--
paul-moore.com
