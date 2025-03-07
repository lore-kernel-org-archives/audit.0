Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFE23A9AE
	for <audit@vger.kernel.org>; Fri,  7 Mar 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364317; cv=none; b=mVPkv5QZhDE5FhN5R8I7rZuNW+fcsFjJ12F4BMbbPdkdb5aSW0P0cyU60GaE159uD3B/OtemIXF3u8EnOsuIytyoOQsmF63Zbl0gRQjfUhrZajLu3nnrcE13cRrC5zxq3DN9bB+LspfucSCquYY2gi7s88eyTEV4ZPoVGYUI92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364317; c=relaxed/simple;
	bh=Q7P4hSefpkC1UbSfbt+doLOOOpwGC3N9h0F6ojYSWWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThwWwFQVPn3xmehOqcqrPW7770KtvlHg9DEnhW34cHSApeCFokeMkQAnm/tUTzj3cIJUL2pJ77AZeQQfethrU9zPz3LLjJZpyINBjC2tJH/Tp10yLMHNIf2BFy9PLhrffnARVTeqcRanmRO+0z4YwRsa0YuKPKx2CL3jDyhv7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YCg3Uw0r; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YCg3Uw0r"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d43bb5727fso5991635ab.1
        for <audit@vger.kernel.org>; Fri, 07 Mar 2025 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741364314; x=1741969114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=YCg3Uw0rWDiMXhs+4gxJ3CqU7x3VRb7hkgp2qae0pBtq+uEomJJNb/jkA270xjZ+aj
         5iMtwRJrkV6j3UwwVZA+xLSQ0UL2LcKyCA/Mg1QXXaLf96jTtj8EJI6Hoz+X33vcSuh8
         3C30N694aKe5AuQ1KeNdfW2Swuo/565rcvfuL6yg+wm8Ey3hbbUYxcazmXpMepsAYgsO
         wSKR3UNgCbKNKFMaeD33MS4pFwOCaYnbEqyabsG3tnWAllX7M97zaRH8FllLahhIyp9O
         VeBEHU+f4X4XumMkPD9CDn4R0EEhPop0Wv0S4B/docHIUOW6vPFevSmthMmU9GXaQ/Yf
         U8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364314; x=1741969114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=bHeTVlFouNJ0kHGXrcH9GMJcQHreBwoZlNl0lmFQ81UTnF+Ol2NyaZEX+PKUyV7x77
         +VWYi1iPlqfqmA+hnrmVBJxu/qoaZoCWH81DKLv6SORKMKZqfue34SuhHUwveN7QcVOr
         aCJRbsXw8apDDKr2h47EO9/RsLqagUSeu6l0JbyfuQxBhFNlJpZ0M9w3FSrLw3VPSY94
         eRAr6Y0XhHLGqOyKoDhniwRfDiEHzLt5Q/NwNYakcbgmG6QoJ2IZqGQvAvI43b1HylyF
         EFjBOLe/+earbpvMzaZks/B+oBychpTfGUjFmRRvvum84Mhp05/K4wVrrMSzWd0+O9kO
         J8BA==
X-Forwarded-Encrypted: i=1; AJvYcCWC7ZHiu6XSd7V/toSQXpcvwNMyRQGfUTq8pipcmXbWXvuqCbfDfLhkHtf4tcTl22wbzwRnNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXguAoSoz3mkT6Qb8cEvnPC8yugr9xZRwcEkxVBpAj0wO3YTV
	BX3AwfpkZRJG1oRS4hDX+okIa+4W3vfiyVDKX29udojHIU1IXfCuugmAaG+Xz0Y4EHCT9qnyCbb
	2
X-Gm-Gg: ASbGnctX1HNkpxa31rKg5kpKeldTdjxw2nRnbDJUELmwpuK+fG08nUeuW8XxpqijaOU
	WUojwHIO/z9Ymfi21jQY182caijDpdmZn4aSQp3ZwNoEfq7VxbkoPlP1Ou033C3iXs3rclwpeTk
	wWqNaUvQdF30/4SLkFQul6JHvHqeztwfkLDxjjZUKRfiarEzAbPEkKaXVdfLKHgtidECsdJ1ZT1
	CyrQMCJbFqtPZ20KvDLtJlxe7x7N4BuAliMBMVvRPFZbmP6XZzdhc6bS7jwiv3EDGJ675BOMgfI
	ucqMGc4BEpitgLhZFpiOxVnT6EODP/2qA+w4hm4m
X-Google-Smtp-Source: AGHT+IEZIL6kjCDQac+J10FL30HMzY4rLD57DIbTTax5qwBe0pYmXJaCKIsBu5zSRoGSQEaVsikMCQ==
X-Received: by 2002:a05:6e02:1a05:b0:3d4:3ab3:daf5 with SMTP id e9e14a558f8ab-3d4418dcc7amr47772725ab.6.1741364313935;
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06b059sm1005242173.136.2025.03.07.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Message-ID: <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
Date: Fri, 7 Mar 2025 09:18:32 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +static inline void makeatomicname(struct filename *name)
> +{
> +	VFS_BUG_ON(IS_ERR_OR_NULL(name));
> +	/*
> +	 * The name can legitimately already be atomic if it was cached by audit.
> +	 * If switching the refcount to atomic, we need not to know we are the
> +	 * only non-atomic user.
> +	 */
> +	VFS_BUG_ON(name->owner != current && !name->is_atomic);
> +	/*
> +	 * Don't bother branching, this is a store to an already dirtied cacheline.
> +	 */
> +	name->is_atomic = true;
> +}

Should this not depend on audit being enabled? io_uring without audit is
fine.

-- 
Jens Axboe
