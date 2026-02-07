Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAC222582
	for <audit@vger.kernel.org>; Sat,  7 Feb 2026 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505590; cv=none; b=Q+PsWTOxhcgHAtIUVQ19FsZo93rhWJ6k7JedDCY61Hahxn9o9Q1R+KzegMcs4KgoNeMe7eWDn/8ZV3mj2x2vFjxlI1dMXywQoGdulkBMO+qu97yUHwhmr43IH4SNJDQxCWXhy+rdpDjU6LfSTPSJWxA+p6KanY1V55Hr5GlfS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505590; c=relaxed/simple;
	bh=YrgypsXzAoSsRO2hW4cxzJfApzUgTJCsmqDOoFH1Hkc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L9huQg1OC2G/0nsgdl3p73JaZFniz83zzMcwTHwaEb07m6/07DxsziTx1BqrYXG3UPthx3GNFdw9W42ljdyFAMt39P9WhNxXbXWyJfyETq5Nyu0wuMh8L8i2P2CrpiRJUU1Y86YmUnx1tAt3kh9z5niPQL0U5OzX0RGeX/IH7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P76RhZyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P76RhZyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770505589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjFu2j4cSqbQw4phkd9l7dLJra+Vd47iY+6CBQEX8r0=;
	b=P76RhZyVwjNQ7dFRMKgEXAMRu9Rj0ymBlsrAcpzyv6m282XNMikyUKX0+bTOSR4El63rnD
	3/fecNRENYukCZiXUUcr6FIT5Z7i6amkgWGk7Yrg/L50gyD5hoGwmzut8LpaifrL7GrzO3
	9SknTZl3axJh2icTDhIeb2aOyF8lyo4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-NRw4RN7GNiaUssW3wdUsjQ-1; Sat, 07 Feb 2026 18:06:28 -0500
X-MC-Unique: NRw4RN7GNiaUssW3wdUsjQ-1
X-Mimecast-MFC-AGG-ID: NRw4RN7GNiaUssW3wdUsjQ_1770505588
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52d3be24cso492789985a.0
        for <audit@vger.kernel.org>; Sat, 07 Feb 2026 15:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505587; x=1771110387;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjFu2j4cSqbQw4phkd9l7dLJra+Vd47iY+6CBQEX8r0=;
        b=sv2vmbtOK3tiG2UyZNmeN27CxwVlX0QpDxTgamTxQWTcZ5Z+HMRAoMFKA6EPcOdIQ8
         uUwmUsUzEHYI237DiEifaRuckqjmk4cHTV64iioGg19Op3mDqP6+LufDvk66byU0/8Q7
         FyRntk1VWuvqtfp1fNYAQ1vmF+mtTEZtNmO7NV5bOotPM8hUo7soi9rJUXaWS0ADQWMj
         lwjZJGvWdqYJ00Mk97jje1ATuX22Gw1xx26chyubL9gSktDnMvch3Tb2SfA59k77Cl2n
         04JhEb854Bl9dyWRxNdRTJ9KzoSMH6rY1YqCY6a41oAlc0CdfQJT1NZdCxhSZnaRDz/m
         qCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLU62h/0x/pFKf5nB8ORvE1NbpvmeQp6sAVsatJfR7Ej7uPVe3HMusGFTDBU9LzsjIWP7JLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwI4Icf5c/dIysBlacw1Dvmx+0zpgT7DTT0xtuPlblIY3gP0a
	JMr7bAyz0VmYurtMkSpINIky6GqIfP0nSRp+V3GBbqpiXsy+XwK0ZlqYsT8ZHZPssULeNGu/0HL
	CkhH/526ZBkyLzXab577WBcU4lvzYeevMdu5Sk9Q4edQIXAQUMillOydkPpj+vNsa
X-Gm-Gg: AZuq6aLLBMPn8v0Q5ODyVLCQ43Fhf8stOuteLEgZ9R0YU+9RfwI7f1h2D4RQ+sD2Y4v
	1hSFbrRr2Ke1jZjL2YU8aqinWPrsBVTwAQRPS3qyLHD8U00M7XRB0bFj+VCSvupZdqEOfI74HsN
	V1tcjQjB3MBoiQNiaJr/hkl9H9Shr2k4O9IVr2btpN0zhnXlgeo/JnX1MFOatPsG/R7USE6uwyK
	Ugi19xJeL22pRbvpdGD/D+9fXZ3SbWyZJzsLp/o7Ap0D7BS7gUV7SuovRC7RQEJpk8m+rvEVfa/
	jsjwlPD1wHy3vnuGVKjLhCLy90wo2ShcjQNMOel9doHL6jkkmVpN239q8FjxrP/h3PuQ3D1HiUB
	yYOIjvWrrPAndKFLzk1yPbhuB7HFzQv6efXDpn3L9KBfnmgaGivYT2z5w
X-Received: by 2002:a05:620a:7081:b0:8c3:7e51:94c6 with SMTP id af79cd13be357-8caf0f2c066mr882534985a.60.1770505587024;
        Sat, 07 Feb 2026 15:06:27 -0800 (PST)
X-Received: by 2002:a05:620a:7081:b0:8c3:7e51:94c6 with SMTP id af79cd13be357-8caf0f2c066mr882532885a.60.1770505586595;
        Sat, 07 Feb 2026 15:06:26 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf79f7dc3sm478722385a.13.2026.02.07.15.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 15:06:25 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ae3c26ae-1c3f-4a83-935d-1c9c984a55a7@redhat.com>
Date: Sat, 7 Feb 2026 18:06:24 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] bug in unshare(2) failure recovery
To: Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>, Waiman Long <llong@redhat.com>
References: <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <5cb07c57-9dca-4086-af88-f866f765c7fb@redhat.com>
 <20260207082524.GE3183987@ZenIV>
In-Reply-To: <20260207082524.GE3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eK3Z0Sddcbq0QNkYllb2EPvUrLnY8TD8di2tMhoo2sE_1770505588
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/26 3:25 AM, Al Viro wrote:
> On Fri, Feb 06, 2026 at 03:04:53PM -0500, Waiman Long wrote:
>
> [summary of subthread: there's an unpleasant corner case in unshare(2),
> when we have a CLONE_NEWNS in flags and current->fs hadn't been shared
> at all; in that case copy_mnt_ns() gets passed current->fs instead of
> a private copy, which causes interesting warts in proof of correctness]
>
>> I guess if private means fs->users == 1, the condition could still be true.
> Unfortunately, it's worse than just a convoluted proof of correctness.
> Consider the case when we have CLONE_NEWCGROUP in addition to CLONE_NEWNS
> (and current->fs->users == 1).
>
> We pass current->fs to copy_mnt_ns(), all right.  Suppose it succeeds and
> flips current->fs->{pwd,root} to corresponding locations in the new namespace.
> Now we proceed to copy_cgroup_ns(), which fails (e.g. with -ENOMEM).
> We call put_mnt_ns() on the namespace created by copy_mnt_ns(), it's
> destroyed and its mount tree is dissolved, but...  current->fs->root and
> current->fs->pwd are both left pointing to now detached mounts.
>
> They are pinning those, so it's not a UAF, but it leaves the calling
> process with unshare(2) failing with -ENOMEM _and_ leaving it with
> pwd and root on detached isolated mounts.  The last part is clearly a bug.
>
> There is other fun related to that mess (races with pivot_root(), including
> the one between pivot_root() and fork(), of all things), but this one
> is easy to isolate and fix - treat CLONE_NEWNS as "allocate a new
> fs_struct even if it hadn't been shared in the first place".  Sure, we could
> go for something like "if both CLONE_NEWNS *and* one of the things that might
> end up failing after copy_mnt_ns() call in create_new_namespaces() are set,
> force allocation of new fs_struct", but let's keep it simple - the cost
> of copy_fs_struct() is trivial.
>
> Another benefit is that copy_mnt_ns() with CLONE_NEWNS *always* gets
> a freshly allocated fs_struct, yet to be attached to anything.  That
> seriously simplifies the analysis...
>
> FWIW, that bug had been there since the introduction of unshare(2) ;-/
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..68ccbaea7398 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3082,7 +3082,7 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
>   		return 0;
>   
>   	/* don't need lock here; in the worst case we'll do useless copy */
> -	if (fs->users == 1)
> +	if (!(unshare_flags & CLONE_NEWNS) && fs->users == 1)
>   		return 0;
>   
>   	*new_fsp = copy_fs_struct(fs);
>
After booting up a vanilla 6.19.0-rc8 kernel, I found that copy_mnt_ns()
was called 13 times during the bootup process with current->fs passed
down to it. After applying this patch, the count dropped to 0.

Tested-by: Waiman Long <longman@redhat.com>

