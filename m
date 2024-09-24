Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941C1C3D
	for <audit@vger.kernel.org>; Tue, 24 Sep 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176522; cv=none; b=fJ/jHCts/VcBRvPQF37NaNDGh8ZS/wZpYulooONjI6hyBSVSpBbS5NJGvvm++joeyl2yHOOA4nJ0trUtB6ULGDjbBnufGdHiLZTs+Cym/sNWgJ1BlPxX3WX6BkNs5bxYrWcof2OA2coUhQgVD3Sx3jrDknOby0xJNcYGueH8Zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176522; c=relaxed/simple;
	bh=9FI9xAMCHBNmhI/DaYI1b7ZOqlOzY6QcewMETRn+Y/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st8AWEiUBHrvVlbIazX2tYXefzeXrhK0/Y7a4kr16KLqsSbvJDLYAPRUvVOrStvE0GVpn1n2QCSKfthgbwn0Is+2xM9heZNqm8LtEUGfDouqiBVa7bkYEHNx835vvQsOWVq3uxNSytqI0S2e1e5HrUUVQ/l6G4Hm+T+6u6i6T9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zIIoIV2G; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zIIoIV2G"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ddceaaa9f4so42278117b3.2
        for <audit@vger.kernel.org>; Tue, 24 Sep 2024 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727176519; x=1727781319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcmWd7rhU3F8u3+OG+sqswVZPydo9kgTuDZb6jS8fh4=;
        b=zIIoIV2GmP7Kx2Q2Q9J1b06zG0dS1urqq8Y6w4n41MkttoNPuBawFaY0dCT7AkOFRU
         ERv3z/3OTXM3C6CuBGlCIx9GgyRbJP20/ggsn1D6MuoSkHnJCv2yRnxKkKmLXcmRgf4t
         ouMdaQHcVp4fXfcwcddPk+prVfaZbd6HgmTJ0DZiko/7whN3ba8VRpk1LM42rrRa4Ymk
         uCTgM0eQNx8yY+NdS6Hf+B9AXkn3uoKwgOlGG6HLbc2Iirq+L5vtCYk1pl6601pppFlt
         ZvVqqwc+n1ahwFB28JfoSJF7XM+t9xGd7LQG5MoJujFNWr9gyP+YQ57ABdNwl+AbOLqP
         cRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176519; x=1727781319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcmWd7rhU3F8u3+OG+sqswVZPydo9kgTuDZb6jS8fh4=;
        b=XlUM8sAs1/EZwJDgY72o954gzYYICnwAyfvPsX1r+WkwlhqyYxdMzmLg3Jdebvqd6s
         1In3m9rsdXIMYmABL4MAycbiOamxuRQWdfqyHB6Xuk374025FDM5ukDPhG+F4hNKr29F
         vh63blMzUQPAPwGlCjSluCzoiCuxPEZLI05ztC6PfKWNX9DVP9feebT921suX65FxPha
         eqDDQDyp0Q9O3RTD3LcUEk+8PFawkUOLY0DYH7M7BW6JWarZ7h7pIrukL+ONZzDadGD9
         7XQUrBbWSDdhzFCR87W71dVeEg1zMdyuge4q5RM/1nbfaDMJKwhCGLQ/C3Z/hY1TiAdX
         bi+w==
X-Forwarded-Encrypted: i=1; AJvYcCWM6PGg+lW99sJMWdLKJlvW/zY/Hu02yUDcFkv+mvx5h+85q5wMzLpOcC1GwId6W2m1hIu7YA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04KGhcC4dmYLFoWO1mTaVBaNH2xt59p+waebUs4GSNm6dPOcR
	dJl1uMxFh3c2M/9xQTaXYn899sP91wxVqR3O7RTE+z5fSefNNxiP8ee1+IPD50LaYwNCw3vC/gj
	6qc2zxg==
X-Google-Smtp-Source: AGHT+IEv1rdaR3GUb9IwW3Dmmojo2CNTa7E6hkdkv5LH3UOd53lsITQUVJZofBU6aeuKOo0A+OiSTQ==
X-Received: by 2002:a05:690c:4713:b0:6dd:ce4c:2f4c with SMTP id 00721157ae682-6dfeed5715emr92447957b3.16.1727176518778;
        Tue, 24 Sep 2024 04:15:18 -0700 (PDT)
Received: from ?IPV6:2600:381:1d13:f852:a731:c08e:e897:179a? ([2600:381:1d13:f852:a731:c08e:e897:179a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d15b3c8sm2081067b3.78.2024.09.24.04.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:15:17 -0700 (PDT)
Message-ID: <fb2d2ec3-f0c6-4116-a574-eef8f79afee4@kernel.dk>
Date: Tue, 24 Sep 2024 05:15:13 -0600
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, audit@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk>
 <20240923150745.GB3550746@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240923150745.GB3550746@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 9:07 AM, Al Viro wrote:
> On Mon, Sep 23, 2024 at 12:30:48AM -0600, Jens Axboe wrote:
> 
>> 1) Just don't reuse the entry. Then we can drop the struct
>>    filename->aname completely as well. Yes that might incur an extra
>>    alloc for the odd case of audit_enabled and being deep enough that
>>    the preallocated names have been used, but doesn't anyone really
>>    care? It'll be noise in the overhead anyway. Side note - that would
>>    unalign struct filename again. Would be nice to drop audit_names from
>>    a core fs struct...
> 
> You'll get different output in logs, though.  Whether that breaks userland
> setups/invalidates certifications/etc.... fuck knows.

No idea about that... But I'd say without strong evidence that this
breaks userland for something as odd as audit, well... And honestly
really a layering problem that struct filename has an audit link in
there.

> If anything, a loop through the list, searching for matching entry would
> be safer in that respect.  Order of the items... might or might not be
> an issue - see above.
> 
>> 2) Add a ref to struct audit_names, RCU kfree it when it drops to zero.
>>    This would mean dropping struct audit_context->preallocated_names, as
> 
> Costly, that.

For sure. And you could keep preallocated_names if you rcu free the
context too. But I strongly believe that approach #1 is, by far, the
cheaper alternative. If we can tolerate the ordering potentially
changing.

>>    otherwise we'd run into trouble there if a context gets blown away
>>    while someone else has a ref to that audit_names struct. We could do
>>    this without a ref as well, as long as we can store an audit_context
>>    pointer in struct audit_names and be able to validate it under RCU.
>>    If ctx doesn't match, don't use it.
> 
> That's one of the variants I mentioned upthread...

Sorry, still away on travels and conferences, so haven't been keeping up
on replies.

-- 
Jens Axboe
