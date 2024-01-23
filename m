Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB01A27C
	for <audit@vger.kernel.org>; Tue, 23 Jan 2024 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047938; cv=none; b=mWks0INBKBkd/pXh0ruZuRXQNtZDTjfY3s2d30XAy2jcqE0bw5SArR14Bz6uhtE84KaUQ3BUrPkbFJFjN9N8DePIKuvlIHXy1tttxBkaZ/NDRFloikslnO4w6oRq+g4PZRZCe31bhWnZXsXHIZk6oxscoqxYkCmxRFEpe8JzH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047938; c=relaxed/simple;
	bh=Moy+hnHnq3f85k/cPBzerP9U753OoKO9eNgn+ielp08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KsviIz3UHstJENh0AuI7LAns+UbdzI5N/f4hsvivJznLooo9nbW//6x7SuyjZNv7ccYtyPbjATjz01xH4z3j/mVwmLHrzxwJf2dLrNkMM8YsaCtlzyNMzrmsumnX10KCLwIZLBhmhmWYE6Y/IYzaNN3cQ5eBDhazf3vGTHFfT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yI61+eRd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yI61+eRd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so701426a12.0
        for <audit@vger.kernel.org>; Tue, 23 Jan 2024 14:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706047936; x=1706652736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq0z14Ii88qAlUObbDzs0mcPd0Y0cMCwmMHUzqVF6YQ=;
        b=yI61+eRdtbTK04lwamCvLU3WAffYQcTAcZUAslfOIwbbuALsPHqS/VlMGuZRb0noxd
         JrrnXEExDkyuEvYxTkP7OUyjwpG2vJqJuJ/hERahMCn1IJjhe4dLzUxVqD4c9qaWBf6y
         La3yNZMe7TJ0W/f9HSGNWHTXi6EjII/fyaBlmG7UkgT1buHZtoZxQE73dktGlgvFuWrx
         Wc+OH3/uw/JdAFSM+0lgRHK8Ao/5VMCo0gtUR22OkBoLtyd3wapsYjk1ETqUCRPsKAbM
         TiwkrGtSRgXBkH2JRj2ATpGC6HERbV5NlQ7N7y2tW6NsNzzZqYYExE6dLH3Copc6zoou
         Rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047936; x=1706652736;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rq0z14Ii88qAlUObbDzs0mcPd0Y0cMCwmMHUzqVF6YQ=;
        b=NA7ueunv6l3FUtaxcB+WE5LBAEs78aifummMuqslZDMMdlJu1ZxD81Q0Czi67AhI7P
         IHtHGKs6G2P6i7zn+yAYh/42VtMW0nYw6Xy2E+4ELvQmyw0PO9ShdPvTTUySCPQHBz92
         jGb0KsvixWLhfQPTCZ8m98K0vhtJMldlYFwF7Q3bi8L1R/EhXSjH3otCDpSisvDODz6p
         2BtK61WVsGjQJjo3MrHYAWqg+c+o3AdCEcEkgeVBVr5eeb82McINnP0nGgJj6REgYRhW
         urmC08roIkFHjy/G+hdgwEVC6oohhhunFN6RVbzLBRYFvTbrWDgRXxmWlLVrfceOiHJx
         8qBw==
X-Gm-Message-State: AOJu0YxHKSeuDEeZBt0m8iMjZNDIgNh0soAAK8hsaQigATOF9zWkTQS4
	dLZSyKmYrLUb0rh6JjlhsB3MZCE5wowWemIRmJv0M26dbwLVeBgO/SfuAeG5XOo=
X-Google-Smtp-Source: AGHT+IEuEdQyZz6k3HPaHTpiIwi8nPgiYt0chQK1YArsjluKjpj9i+5ue9+w7Lo1EGbrtjNIIuyRfA==
X-Received: by 2002:a17:90a:c915:b0:290:1f0f:fc89 with SMTP id v21-20020a17090ac91500b002901f0ffc89mr689048pjt.0.1706047936404;
        Tue, 23 Jan 2024 14:12:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ee6-20020a17090afc4600b0028e17b2f27esm12468545pjb.13.2024.01.23.14.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:12:15 -0800 (PST)
Message-ID: <dbd1bfa4-7583-4be9-ba00-cde4f340a509@kernel.dk>
Date: Tue, 23 Jan 2024 15:12:15 -0700
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
To: Paul Moore <paul@paul-moore.com>, io-uring@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 audit@vger.kernel.org
References: <20240123215501.289566-2-paul@paul-moore.com>
 <CAHC9VhRMsUkNHpc45H4PVnrGj77RDR_BLR9nN89Nh725ke1ECg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhRMsUkNHpc45H4PVnrGj77RDR_BLR9nN89Nh725ke1ECg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 2:57 PM, Paul Moore wrote:
> On Tue, Jan 23, 2024 at 4:55?PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> We need to correct some aspects of the IORING_OP_FIXED_FD_INSTALL
>> command to take into account the security implications of making an
>> io_uring-private file descriptor generally accessible to a userspace
>> task.
>>
>> The first change in this patch is to enable auditing of the FD_INSTALL
>> operation as installing a file descriptor into a task's file descriptor
>> table is a security relevant operation and something that admins/users
>> may want to audit.
>>
>> The second change is to disable the io_uring credential override
>> functionality, also known as io_uring "personalities", in the
>> FD_INSTALL command.  The credential override in FD_INSTALL is
>> particularly problematic as it affects the credentials used in the
>> security_file_receive() LSM hook.  If a task were to request a
>> credential override via REQ_F_CREDS on a FD_INSTALL operation, the LSM
>> would incorrectly check to see if the overridden credentials of the
>> io_uring were able to "receive" the file as opposed to the task's
>> credentials.  After discussions upstream, it's difficult to imagine a
>> use case where we would want to allow a credential override on a
>> FD_INSTALL operation so we are simply going to block REQ_F_CREDS on
>> IORING_OP_FIXED_FD_INSTALL operations.
>>
>> Fixes: dc18b89ab113 ("io_uring/openclose: add support for IORING_OP_FIXED_FD_INSTALL")
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  io_uring/opdef.c     | 1 -
>>  io_uring/openclose.c | 4 ++++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> Not having an IORING_OP_FIXED_FD_INSTALL test handy I only did some
> basic sanity tests before posting, I would appreciate it if the
> io_uring folks could run this through whatever FD_INSTALL tests you
> have.

You bet, I'm going to augment the existing test case with one that
passes in creds as well just to verify that part fails as it should as
well.

But looking at the patch, this will surely work.

-- 
Jens Axboe

