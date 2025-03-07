Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A28221D82
	for <audit@vger.kernel.org>; Fri,  7 Mar 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365154; cv=none; b=C7v60/M97O0V46r1dvyi2YdSLrHVct4SrL63aLB94b3oRMzenkP6ty2n9Nd4NKxe+yiFBJ9xvyU9FoxXMgw0dWowPCZgSnUHgBmeZyScQBVaIQqVkIPx3ykJZsMlyekeSGg+467DngwyPkISs/WQBcWfxjGSbN0NOLYIHmzsDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365154; c=relaxed/simple;
	bh=xaiQsJdBQxlDeOtm+4O7NGV7vcMhAxgto+N2EHIhGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRRZ4+liFarYi45hjUabaFZd40iOTmAF4SNhcXA/gumsNpCqjkdbhl01FSC2wy09Xu1DoJ/VTLei5RrAkaG4W7fL6bV+FmNvbWXSTzIiwtgOgQAI1hg923L9E27Xkq+22rrDUuRiqdw7UVCHhZkyKd5Z6aQ8NTVXBt2O+ijwHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vyKWQTtb; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vyKWQTtb"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85adbdf335aso61321039f.2
        for <audit@vger.kernel.org>; Fri, 07 Mar 2025 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741365151; x=1741969951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=vyKWQTtbd+945VUGfTn6XAMQm/6HQ368a4Tj1GmAbPPrQIKUSy5VPauOL1P/JqKwsw
         wrvSvXpPDmCBEwpu4Ys8ioo84qayGxXnWaRuCF5Ji6ZjQ2IXZ6mPH9GghKDzjYIHP86q
         H3pS2bbupyf2c73WUD0nDRp1zhXEEEdHvTOpq3atvXSFxySqaFaVO10gcjAUZ1qzK3tN
         d7TugjBBhF6J57AItd5uIhbIonefOjvl2WHj2ZzAOo9vYy9eVeUxwuIV8mSqw5HFuS9h
         LkPvDd1C5I9bLkAmVqnlaaoYSubpeOegb8IQbRbHqVSPX0HC1aIZ4q7E52VidnLfK9yA
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365151; x=1741969951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=eO/W9y+SVQHDqf0KiVpNgdcP2BzDC8Y95whlGLBI0mqElg3e/0L6S0sP9KeLCsOukP
         ktuf2QNOlD8U1lrq92r5pFDXsDMJLn73kLg2we6ae6YHLeiCRzpy6eAqMmEStcBZiuJA
         XFzXDY7n2zubePj4TNbkv446uGL8f5t1+1o/coKEh6P53ntCwJs6zDbmqByKo8QsdR3c
         lobaF1NklluTDmakBrdBDmIYzwDVqMRwV3YxYzuZvcr6jhUEsQ7gcmi2gkcO5Do5FOGu
         wBPAzMpyZXn6UyuP0bFzW9MIK5v8N2V5V31NTO2eUM+LKvcjqN/aemB1d1cuJnWSHDpu
         wreA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDaj6VTzAsLAm56oc8HTD8Udhrqd2n6MPiAsgGznJi6+XJKmIvUy6BxTz6DX6a3/PLHnZUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjjuxrrj+YT3z5sy9F9jFXkzidp/aGDPj9IsmBIDrzInuO5gp/
	zerlwnx9ckuSnhLSzOzeVJvBidJ7l18apb/a1SGfq3OOWjrs4X7RH1k5Y4oxvQY=
X-Gm-Gg: ASbGncsToABC+yRWHLguqfdeCo0sbMSwuBJ7eHjY6fbHQCZ0mxm92zcx5vwqCh0AAcp
	hu+hnnPB6pwoDdF0H62rOktcH1VZtol7O270tZOzQyuB5Q5aPws56wRK2wn1Q1lhO8iBeajS8eN
	eAVz4RzpPF6jRKNlEFVWUp8XiK8He0PdnIA6BmvQXZwSrQ1aBq2SMDGw1p01+NXWS+YMEM9Hp2D
	3xBXGBKzqUS/fcBLLMMKVpDzzfzqJBQkiptM9ivNYlZKodBP8u/pn4NOI7EkKyFi4jwm7N4hDKu
	HCAgU3SsREpkvSK5m9rJRLo2fvyqgr4uDQIt6TTc
X-Google-Smtp-Source: AGHT+IHrkCLjuVHj+BJlje4EuU1N2OofbZGNyuXaZNfL0mggj9MLt+HfmyCGFOKlxxG5IOS/M2005w==
X-Received: by 2002:a05:6602:3a09:b0:855:cca0:ed2c with SMTP id ca18e2360f4ac-85b1d0d5b8dmr500795539f.10.1741365151234;
        Fri, 07 Mar 2025 08:32:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06a6a7sm995329173.134.2025.03.07.08.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:32:30 -0800 (PST)
Message-ID: <5a0ddd31-8df1-40d7-8104-30aa89a35286@kernel.dk>
Date: Fri, 7 Mar 2025 09:32:29 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
 <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
 <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 9:25 AM, Mateusz Guzik wrote:
> On Fri, Mar 7, 2025 at 5:18?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> +static inline void makeatomicname(struct filename *name)
>>> +{
>>> +     VFS_BUG_ON(IS_ERR_OR_NULL(name));
>>> +     /*
>>> +      * The name can legitimately already be atomic if it was cached by audit.
>>> +      * If switching the refcount to atomic, we need not to know we are the
>>> +      * only non-atomic user.
>>> +      */
>>> +     VFS_BUG_ON(name->owner != current && !name->is_atomic);
>>> +     /*
>>> +      * Don't bother branching, this is a store to an already dirtied cacheline.
>>> +      */
>>> +     name->is_atomic = true;
>>> +}
>>
>> Should this not depend on audit being enabled? io_uring without audit is
>> fine.
>>
> 
> I thought about it, but then I got worried about transitions from
> disabled to enabled -- will they suddenly start looking here? Should
> this test for audit_enabled, audit_dummy_context() or something else?
> I did not want to bother analyzing this.

Let me take a look at it, the markings for when to switch atomic are not
accurate - it only really needs to happen for offload situations only,
and if audit is enabled and tracking. So I think we can great improve
upon this patch.

> I'll note though this would be an optimization on top of the current
> code, so I don't think it *blocks* the patch.

Let's not go with something half-done if we can get it right the first
time.

-- 
Jens Axboe
