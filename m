Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F9395254
	for <audit@vger.kernel.org>; Tue,  1 Sep 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298522; cv=none; b=WjZyuC5CqNK5krySsB3NXhDpQZAPe4CD+35Ax44ltIMhN2DG9OQjlZtDWsdHXiuR5CKJCw3VK9ZyRywymXe6oqC3GEfPljE5Oncdq4R16lvnf4m0MPt7Uea/t2SHv6jz5gFuqRCsKFuhQbafi96BijrXp6IP+OkIlLGRFJQV4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298522; c=relaxed/simple;
	bh=NIl2SpJoXWgkNOAN+Yj632DNwtSCaFq/3Wl4BgGWVdI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PmWcKC/d/hpuRYbsPRV8LLcev6uWbyG35g+qBgA6ryJOXFPsXKnDsRePJ/VLMYaYoDedAjP2S9WRqfQG+E/K2luIuU1fOaOFH3I3IgkwaR9mNWBfO9K86sS+lGUyc6T4kU8pI7rxTILZ+F2duZqosQ7/kVNRvcXROqFQFhE0hJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TZTTbXNV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TZTTbXNV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52cd38ddcdfso2652251cf.3
        for <audit@vger.kernel.org>; Tue, 01 Sep 2026 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788298519; x=1788903319; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGBMA70aQ29OFSgQVpxK2CgFIHiB2+n9s56OX+rPnLo=;
        b=TZTTbXNV1GBoLhQzNVVFAqP51wY2bVecRAu/Yb72azxgkJAbxLMUH192k4QN5oijne
         c8LcljnZk8CfGjLc8LXxRXMoH+ftB7q8IYCqm2BHDc8NdfWo9v/baQUyO/2TWbsTGeDp
         lKg/Nkj6JWGN/xi3QnSWPoUabrw4IzZnTMglp9HYwZLlH/3d1bKhbeYj45o+3We0uiYE
         2V+94SQzePAZCIFNT1puqsB75XZdpOvGqrPQx+ZcSsGnvctUdUhAp5PyEWauiwD+k/Iv
         MQ1gO/PUOfPD34q063J68CmxhH5yppR/IwyWMVK7AfWK8nv8X/Yk3rpzyM2MYh1SiHr9
         n9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298519; x=1788903319;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGBMA70aQ29OFSgQVpxK2CgFIHiB2+n9s56OX+rPnLo=;
        b=Y57EiKdxEjnU2F1jt/bRD08tBLKQFuldaJayzHisJOJYkJJ6sHTRLkppwzGoLj5Jru
         TXLkosk39TJJZZJR0VLEF2lbIY044jZidh9lk6PjiT2bE9OX5ULbb98t/ZwHqW/zl2yG
         CIF6xEobQAkgq187PB7LgU6FExAzuyrVVNZ/KKTQ4OGIQ8/Y3Jt4Mh2MPb0LbiM0RY58
         83A8JFLDOGzDM9W0MBIgmLuMooNLzmZACZCUkENKDQ/UDHvND74vbVoMdeF1aojPVTsB
         bzd/ODxLEbh3Z18vv/ifXZIO3QEXhVzDC6JfxRQHb+fBESiYZ5e1YaYMw1dHO9QeAS9l
         1nig==
X-Forwarded-Encrypted: i=1; AHgh+Rr31ssh1NdYuSInGzAGOj4lwQrLAsjp6xbvOnT69n6UogA5MAmYjhVW1pvSJSejDFKq9L+nFA==@vger.kernel.org
X-Gm-Message-State: AFuF++n/Asfs3o267VW1wNhAZ1+5B99XYZmTW28LeZOIwNph+HXziupF
	NN3pbVr2J/oFqi5T33KXBbceoEXiArw0ZwQA4rCS7x6KujRJ0+N55m1hr4F/ud/bYA==
X-Gm-Gg: AR+sD113dFWhXfw1YkHQCNe4rymBreWt5ABgC81+Yuv7iKC0Lt5fwT6xyc/TixqL/t2
	XHBdnNpSCd+fBbOPQdjMrlEx49XGlJIsVkpY8fHxZ79iOcfR4kCgrv+/hobk6UGiv5rAnEMa3fq
	0sNqXeYrQue7t7kj+RfYZ3LQ3CGkXFCHL6GZtq2pZHFXTXQ8tSPE63085x09ZWn6DaEUFP6HUV4
	mOsrWsITdkTSAYwnjYVQhb/XhO/mRGxNaoGebwPYHVFlRwFu2OHEjGx8ZWkKhVWA+LtgCR0WzRC
	BZJHoKVH/sYjLm5pegGZo4iVY9rFRqqNuUS6Q7Rxg0sRM1mdyobXvyqW/MJC3lh9G+etoYqcZDI
	pdYkCSLlmjI8/LFwfg+OX0xZJWMDUWJ+okU9HtumF7ZCcUsbpJaRD2JnHe20xP/FQniqhMy7Pgp
	vV2o2sgvNM9psm1bvjCfeHZmPJb/xavwRRF1U8YCmimW1aNRR5jlBwjp/zqfPZjL07Z/LSJvGpe
	M+s6R+CG6JwqbL9LmhuiYM3xaRaCGw6CwunSPsJs2ru
X-Received: by 2002:a05:622a:259a:b0:52d:6afd:7db5 with SMTP id d75a77b69052e-53021c76193mr177282351cf.25.1788298519454;
        Tue, 01 Sep 2026 14:35:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331dc455sm5474491cf.15.2026.09.01.14.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:35:17 -0700 (PDT)
Date: Tue, 01 Sep 2026 17:35:16 -0400
Message-ID: <23b54475e31ed2c5248650d5aca830f5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260901_1121/pstg-lib:20260901_1604/pstg-pwork:20260901_1121
From: Paul Moore <paul@paul-moore.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>, Shuah Khan <shuah@kernel.org>, Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Amy Griffis <amy.griffis@hp.com>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 3/3] audit: Skip exit filtering for syscalls without rules
References: <20260806-audit-v1-3-ddd0d94ff0b6@gmail.com>
In-Reply-To: <20260806-audit-v1-3-ddd0d94ff0b6@gmail.com>

On Aug  6, 2026 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> Audit walks every exit filter rule for each audited syscall, even when no
> rule contains the current syscall number. Policies with many unrelated
> rules therefore add linear overhead to otherwise uninteresting syscalls.
> 
> Maintain a reference count for each syscall bit present in exit filter
> rules and derive an aggregate interest mask. Update the mask through the
> centralized rule lifecycle helpers, which cover explicit and automatic
> rule removal. Use the mask as a lockless rejection test before entering
> the exit filter RCU traversal.
> 
> The mask is architecture-independent. Syscall number overlap between
> architectures can cause an unnecessary scan but cannot suppress a match.
> 
> The aggregate bit must be set before list_add_rcu() publishes a new rule.
> Otherwise, a reader could observe the rule after publication while the
> aggregate mask still rejects its syscall. Move audit_rule_account()
> before the list insertion to provide this ordering. Rule removal already
> uses the inverse safe ordering: it unlinks the rule before clearing the
> aggregate bit, so a concurrent reader can only perform an unnecessary
> scan, not miss a rule.
> 
> To measure the effect, install increasing numbers of distinct statx rules
> in a disposable VM and benchmark the unrelated getpid syscall after each
> set is installed:
> 
>   for nr_rules in 1 32 128 256; do
>           auditctl -D
>           for uid in $(seq 1 $nr_rules); do
>                   auditctl -a always,exit -F arch=b64 -S statx \
>                            -F uid=$uid
>           done
>           audit_bench
>   done
> 
> Without this change, the same unpinned VM produced:
> 
>   1 rule:
>     median=55 ns/op
>   32 rules:
>     median=71 ns/op
>   128 rules:
>     median=428 ns/op
>   256 rules:
>     median=791 ns/op
> 
> With this change, it produced:
> 
>   1 rule:
>     median=55 ns/op
>   32 rules:
>     median=55 ns/op
>   128 rules:
>     median=55 ns/op
>   256 rules:
>     median=55 ns/op
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  kernel/audit.h       |  2 ++
>  kernel/auditfilter.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c     | 13 ++++++++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)

We've had similar proposals in the past, and I'll say the same thing I've
said in the past: I'm not certain that our answer to filter performance is
to add additional complexity and filtering.  It may turn out that an
approach like this is the only option, but I'd really like to see more
effort put into improving a singular filter mechanism (either the current
approach or a replacement design) before we start layering on additional
complexity.

--
paul-moore.com
