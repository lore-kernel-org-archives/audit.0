Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D41C84AA
	for <audit@vger.kernel.org>; Wed, 12 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795646; cv=none; b=K6ZYvwvNpd3Cl3xleNyYztGwSjEMPdQP3YlfKwEtBEhMB15iSGMKOvq0XeXH/+MwAVoDj5B337NEMKJIYzzW6qrR1i6JsCZ9pFMoRj4SrJmgf7lmroHAHf1WIx/whi+MgSu5a4P7uHiwCzEsJtcUAVJzJCqf8JjXpfnFKBdzGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795646; c=relaxed/simple;
	bh=+DPcVpt5jm09eAi/Y9n5785dJsafsofbqA8F/h57dus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLOjnBCekJBEQanluFiD1CmlHaG1DfcLuXVnrNu8EJ9kv8uuDFAQHMLj6ZG0stCT965XtJfTsko9FxY4pdAoiE6CIyhQlTmIKwMv/GgOFqrmj0GeN0Qyw2IeH44dQQ4vNAn4jbwFLeEQfsxaEPvlOs//62oywesXDe1BROo/QRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HZe/Rgjw; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HZe/Rgjw"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b40c7d608so346541439f.3
        for <audit@vger.kernel.org>; Wed, 12 Mar 2025 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741795643; x=1742400443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=HZe/RgjwWI1hEqmeTUpZ7rLgRzKZbdsCLSjpiIZwywmwJMJ7rpKITg+E+bNy2VmPA3
         IXP66hluxKFO1nUuFB97+n015rW282h0l3WS6oSFD4BCQGeDnXInZkpeJJGAJx5xKHo1
         wylHfhTaRJRSVDoQX0JR0cIYXPLxmrcGiXnxPtenFa7zE4adRUaOKenn9Q6mwk2/sjpe
         ObaEDKowiY/sh2AF5g5FVxhgZZ76mQY6Xfa/1zeE1UrBHyU0gz2AWaUwnb1xhI3RbcAb
         BMkdAkiZzlHY3FyxqDwxgT5FQHU9ZZBWxOb/LHgS5vNpc7nEVtO8uWyp+B5c4UTP/PUY
         BAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795643; x=1742400443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=tCdSjVbDV0+9WA+tQhTH/u6anvCSppodPlRI16H+IgUKqQtp++KTh15T2gn2CD3Y+D
         /RXZVYVgYRabRexCgV6x81AUBRTS8qp4OHDdRVVyEk0gitjlyAu4k3evR6pNi/mnPUMI
         2I37ORDki56E9xe0CzqSOy8LdcLDobYEllocMC437roM1rzZ8TyvMeXVjHVc2R953J63
         cOBd7ZRYqG63OHxZmkLkZ5234zrSOGu2wtU69NPmnTJZbl/B6SQZsjqKjCEVLr1pkgbk
         7SCfcM4Pen/aH6CGrpLgi5/3mtnV6nwA9krbTu5wuyGefJtkyR2S3FdlTkAPV7Rmsu9D
         JADw==
X-Forwarded-Encrypted: i=1; AJvYcCXldwTb5dnC41g+xxmsOHZ6IG/gENdJtcAV+3pw5PbcCnOS/qJ5cnfZlLVE0fJM8jTWd3ZnGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmjUbcnBvtPmrd5Q9NzhMXDscEPTzBhxvj/RwK9yczaNMZK+F
	Ea1NPFbCfPDfgJkCqP158bd7i+Yt7QO2Ml7wg5KA0xD7wA2iLL5Q0XE5jrS37cI=
X-Gm-Gg: ASbGncsVtfRz1333ZWZwatanyzRamfMs6/29Gm00DgfJfvQ/z/7a6XsbjUolZ7T5HY4
	vQSaS2Cn0+FAdpDggEiPnhUOO0uPAKBcKOK2+pnUOoPc5KUFkfZRkQMEIhC5xEJYBCsHN2yrIBR
	sYzOINRoRAA0l51082ejTH97bOfFvfflAO4hG8Vv99ilVQXusBfgsnFx3OBg+cG4vBxBMghLbFd
	7XLtq6g3J44hR8N3wYNjfcUoVEB5oOv7Pe5254rzoNqpx5XD+z15vsYjsSznJ/32VRStAGD5saC
	kFnxOiXIA+/WbGJdrf9MWwZrQj3c10RR+vtW4o7o
X-Google-Smtp-Source: AGHT+IElo/nFdPS6E/5N5+GL1pAZfk0yR7kOrU1+gao2muzmo9g0AwgP1v3zMHzkrcml22cA5yeNRw==
X-Received: by 2002:a05:6602:398f:b0:85c:5521:cbfe with SMTP id ca18e2360f4ac-85d8e2233c5mr1023090939f.8.1741795642951;
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b119a823asm284201939f.14.2025.03.12.09.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Message-ID: <6115bfac-658c-4e8c-859f-d4a1a5820dae@kernel.dk>
Date: Wed, 12 Mar 2025 10:07:21 -0600
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: dodge an atomic in putname if ref == 1
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
 viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 12:18 PM, Mateusz Guzik wrote:
> diff --git a/fs/namei.c b/fs/namei.c
> index 06765d320e7e..add90981cfcd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -275,14 +275,19 @@ EXPORT_SYMBOL(getname_kernel);
>  
>  void putname(struct filename *name)
>  {
> +	int refcnt;
> +
>  	if (IS_ERR_OR_NULL(name))
>  		return;
>  
> -	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> -		return;
> +	refcnt = atomic_read(&name->refcnt);
> +	if (refcnt != 1) {
> +		if (WARN_ON_ONCE(!refcnt))
> +			return;
>  
> -	if (!atomic_dec_and_test(&name->refcnt))
> -		return;
> +		if (!atomic_dec_and_test(&name->refcnt))
> +			return;
> +	}

Looks good to me, I use this trick with bitops too all the time, to
avoid a RMW when possible.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
