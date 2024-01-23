Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35955465E
	for <audit@vger.kernel.org>; Tue, 23 Jan 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049790; cv=none; b=J0Bd71DiGRn+degByBc/EZTxpJeZVfIAxo/ZZrv+/Y8SRS+GqZA5DsB1EDTuyaL7FsgCKbmgmCE0mtGuI3evFQVAQLC5EAQDYPqSa4DXvbwQyidn6G/Yg0Eg20N2dhbbk6+zK7Niu3sASDxY4OC31bHgtvbpiiOlgMab3srsvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049790; c=relaxed/simple;
	bh=iUB518ugqYlOim7h2XTpdjWYCOECHt/eRE1y528tlvM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PkFQRMCEFDQecHDvxPrtm4ln778SHDRETD36zDPw7ohzv1UlcIOLDffelkBXF6ngp5s5Xt5/i9WZK/hJptGZ02V+qbLIvHhlpXjLnFkKQnYHCTJlnzr0vRufroBlMddODBkmqd05aPdKpXVfbHK1omE+9JgycU9ZAF65FIEHlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OyayA4OU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OyayA4OU"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290327b310eso662280a91.1
        for <audit@vger.kernel.org>; Tue, 23 Jan 2024 14:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706049788; x=1706654588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ8DnQ4tf3hf+QSmZ07ypiykiybqiKeAhzaeUG2T/BE=;
        b=OyayA4OUUErOfmoY6F6nkS8fF5qIQseI98oCEN98cvP2MSf4cnpjVkbs3mmw+8MZEm
         EZj5JLHseYFStJCZWmxk7FOGXt6FkoRMlMsxHpUPmAxktDp/pyPkYL4iTudcAwFvyYMx
         8SXHXFUpO8WKVHqFe0r+dyvje04yG21ACwTVmZ7JoE22Pof3cdlKeETBlSruJGfadNoD
         lttYHG2sFs0/aNXgRi80iSw0N1MmepGnxz2/7txrYbxxXo4RDAnNLXaGaifgtQT3hh5h
         knhU+3D1rhkAnxDDTlzYZJJ4g5+FuLkA91NIo04BHa1hCsB/aF9JfplO0K6kV4br252F
         iWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049788; x=1706654588;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ8DnQ4tf3hf+QSmZ07ypiykiybqiKeAhzaeUG2T/BE=;
        b=f4pcu0LnN3dBRVNIO8GDZu2pYOuT5ZyGbAitzX1waBFAuMhgLo2Tb3/UzHBJoIU4R7
         SKRiDsQtcUQMRDOPYBMYi8HwwzXBSNj8MvoWHdP0xZNjyer65N+4ILb4Zk8YNlAQt3Q3
         71EDUDDPJ85VMTIiBR0CHcJjVVj2M9Eb6tUBcuWGpAM5L/pfjQFQYMfUEkkotCbZNsn4
         qMT2bSUwuJLS+QrkDMlya7RSKvDCV11zTyNcPaCNQ6Tm7QisUHMTdwn/EtsFY8kIcZN9
         5AMlOFs825AJlxjH+CwRx6coT8niOMyJWpvrqIZaXhKqJSOM4oKHUexNMkOEng6SrSt5
         c6JQ==
X-Gm-Message-State: AOJu0Yw9AAQSji+QbQqGLyzKXvJnLB+UNwvIH6GekK6yvmKOBnxVpsUc
	TzQsgRVzQAkIXmDQ08cWRKEEoWs2WfLXpoF3YYt/54bmJmQvv3UfXBl4JpMkZ80=
X-Google-Smtp-Source: AGHT+IFCEjc9dpcI4WGNlaoVDX/WSUtSwSFot6/0SHia4xao8n+OpxbkMVyGTUvjhQlO5dGDI8NvHQ==
X-Received: by 2002:a17:90a:7897:b0:290:8cb7:fa28 with SMTP id x23-20020a17090a789700b002908cb7fa28mr710655pjk.1.1706049788176;
        Tue, 23 Jan 2024 14:43:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d76e9ce688sm1606911plc.114.2024.01.23.14.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:43:07 -0800 (PST)
Message-ID: <cff4ba69-cc21-4af9-8a44-503649677b9c@kernel.dk>
Date: Tue, 23 Jan 2024 15:43:06 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: enable audit and restrict cred override for
 IORING_OP_FIXED_FD_INSTALL
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, audit@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
References: <20240123215501.289566-2-paul@paul-moore.com>
 <170604930501.2065523.10114697425588415558.b4-ty@kernel.dk>
 <e785d5df-9873-46ab-8b8a-7135da6ed273@kernel.dk>
In-Reply-To: <e785d5df-9873-46ab-8b8a-7135da6ed273@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 3:40 PM, Jens Axboe wrote:
> On 1/23/24 3:35 PM, Jens Axboe wrote:
>>
>> On Tue, 23 Jan 2024 16:55:02 -0500, Paul Moore wrote:
>>> We need to correct some aspects of the IORING_OP_FIXED_FD_INSTALL
>>> command to take into account the security implications of making an
>>> io_uring-private file descriptor generally accessible to a userspace
>>> task.
>>>
>>> The first change in this patch is to enable auditing of the FD_INSTALL
>>> operation as installing a file descriptor into a task's file descriptor
>>> table is a security relevant operation and something that admins/users
>>> may want to audit.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] io_uring: enable audit and restrict cred override for IORING_OP_FIXED_FD_INSTALL
>>       commit: 16bae3e1377846734ec6b87eee459c0f3551692c
> 
> So after doing that and writing the test case and testing it, it dawned
> on me that we should potentially allow the current task creds. And to
> make matters worse, this is indeed what happens if eg the application
> would submit this with IOSQE_ASYNC or if it was part of a linked series
> and we marked it async.
> 
> While I originally reasoned for why this is fine as it'd be silly to
> register your current creds and then proceed to pass in that personality,
> I do think that we should probably handle that case and clearly separate
> the case of "we assigned creds from the submitting task because we're
> handing it to a thread" vs "the submitting task asked for other creds
> that were previously registered".
> 
> I'll take a look and see what works the best here.

Actually, a quick look and it's fine, the usual async offload will do
the right thing. So let's just keep it as-is, I don't think there's any
point to complicating this for some theoretically-valid-but-obscure use
case!

FWIW, the test case is here, and I'll augment it now to add IOSQE_ASYNC
as well just to cover all the bases.

https://git.kernel.dk/cgit/liburing/commit/?id=bc576ca398661b266d3e4a4f5db3a9cf7f33fe62

-- 
Jens Axboe

