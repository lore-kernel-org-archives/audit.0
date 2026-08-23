Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E711891A9
	for <audit@vger.kernel.org>; Sun, 23 Aug 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508640; cv=none; b=XFZDUzgOWN9RFS9lEfD6eAV0Z3fq8dYOAwT4bvFfU0rBUQFHktdFwccERQQWv+XbLgbyXF/YZq0Jab12I3D6z1rsnGDcbc1p+d8dyYUjQu0MtuaOK6mg0vgHxHUzRcFX1ZhbsDtDczqG6zYMuI1wD+1wS8QQvEgi4mKXfFSUPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508640; c=relaxed/simple;
	bh=fGYi03ob++A1OM/7GWgjQOyXpfe+tdTeHisTLkTszvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWjqoGtolIYnAjWAtiXl7Vax2YCa/nB6AsYkI5gGQDI7r3O930b1owvbgw9r8fZziDskzUJhPZqLs5KqSTzk0sdHDwb0cFE0nQxxepwmOXsd4TJBGGwt0GfDr8LhmP3TvDF9C4NnlXnaDqOzDLVOQthQDe2tmdCq8wY2IuUox78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2uJI3vi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2uJI3vi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2140500a91.1
        for <audit@vger.kernel.org>; Sun, 23 Aug 2026 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787508638; x=1788113438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=40bzyEpk4244+pXyR4A/V35aPJohFaRdnFjBwHWe5DM=;
        b=D2uJI3vi3WxZnfPn3ZjqspNiEPNmrh2ZZu968RILNByB/ZdBrYk4hj4mg8QQLNsXDK
         U3wTEWZhEa0q8dUDkNEwhN3DTFTW566uCCmBj8SZzrBTTns1b9olqxBH8cqtSFMICCug
         iot+VBD9XV6cdqRNIT0DDlMkSubimRJ2EAmlrJ02UjGimDBky21PNf2clvYo3z+uW1IM
         sVO9dNNNKd8A3kTVBmEyxHpzILkYP55Q4BNrfRalEeeNGhbM0+gH1D6+L7kBYOQi6nn3
         s05ViAGYGlqElNTQet2bmTq/sw8Jcahy91xazSQct4OEykM+sSROcQ6l8P4vktcM73he
         a5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787508638; x=1788113438;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40bzyEpk4244+pXyR4A/V35aPJohFaRdnFjBwHWe5DM=;
        b=f+tXvo/oS2m7dLj3aimvMy7YCilM20i30NXF5+HjLlWzOfCfsEquLe+TgvQG2yhowL
         K/u/+oPoAtbYMnRidwl8nEgNgMUApJnto+q+nwV2ENgdwbhqeiNNIxlII+THcbCpbubv
         9PqCnHbyv2CyT/0mYn3RX/nO+LR+bmjaTrYGmLutvPixrIdzaJ/1Ianu7fItQVMk8hVE
         M46NhYIcFfJ0F85wSXQD+Imhb7b89ya2LrVWQzu/zHVet6QrNaIGDq3IzaSAUpknTHrh
         YvIzwNfufbXTcs2PM79kzxqC0lgQchZZu+yrHpVLU4ZatwWYpu2KhLxTocRwwCC/83Jf
         AASw==
X-Forwarded-Encrypted: i=1; AHgh+RrwZ3OVbn4FA2Yt2N3jucUuS06ekbV4+fifKH3YNneg9zJmEWSBfhU35Z/16YnnYsSCFiGpwg==@vger.kernel.org
X-Gm-Message-State: AFuF++ksg29ub6mcPNI3FnsfxbAKljZym+A/uiSh0wh2tIb5hNzVdlFt
	J09unS8RE+C0KVJ/U/Hf6yv0Yhy6xI4FrKQDb8QtT181aArXZkgYfaDBf6Rxow==
X-Gm-Gg: AR+sD106cEB+0JwUXs0nJFwMvyAGt8u4BONqwQt5l5IuDnNMWEiQLpWvLwC88y2a2Vn
	nq1dXkQxkFFCuTE2PblhhS7h7+hrjYcqHssEiAAfoSf6UtYRVkbFKf9Z0F/z7i18OhqRzMk8Jw1
	efJHojzKKX5eWLnFlwHRnSFZ6xAMthUaaO9TPmwPJ6hH523jK9RGplbmmjDd8zVXOKKEsjQFbPA
	WUp9pceqVSa8tmtQUzsuB8pfdleXkTxSMJ6nZwPiwyIBNLzdbNE2OLFOyJSFsl3dn0DPHcmZGyw
	I2h30/E0lJlro8nHZwwGFLi7VDGltY4bsGeNiC1DnsEyJRHZd6dl5yPVxMvf+swkSZ/jAtb65ti
	rvwb8vISRL4xv24LEho7xDRK+QxZj67cy4hdevk2o+4zWOYj8Twic3k2tNEb7s2gurOZmjdO+Jz
	xYaOqklxp0zkvwL4sEyNUzAsY/qMV3jxJnBQwMixebmwd63F9rcbVGDDOS03DQldauovTFvfuzz
	hdI9S4hwiQOeCXhERqyvlOW2X6nYpU=
X-Received: by 2002:a17:90b:37c5:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-395c4c35ac3mr18952438a91.3.1787508638219;
        Sun, 23 Aug 2026 11:10:38 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49d8b1csm7092886a91.11.2026.08.23.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:10:37 -0700 (PDT)
Date: Sun, 23 Aug 2026 11:10:35 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Shuah Khan <shuah@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Amy Griffis <amy.griffis@hp.com>
Cc: Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [PATCH 0/3] audit: Measure and reduce syscall filtering overhead
Message-ID: <aos3m2wG3To3wCeo@skinsburskii>
References: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>

On Thu, Aug 06, 2026 at 06:01:18PM -0700, Stanislav Kinsburskii wrote:
> This series adds a repeatable microbenchmark for audit's fixed syscall
> overhead and uses it to address two cases where audit continues doing work
> which cannot produce a record.
> 

A gentle ping on this series.

Thanks,
Stanislav

> Patch 1 adds audit_bench, a manually run getpid(2) microbenchmark under
> tools/testing/selftests/audit.  It leaves policy management to the caller
> so the same workload can measure different rule configurations without
> silently changing the system policy.
> 
> Patch 2 fixes audit_n_rules and audit_signals accounting when rules are
> removed automatically with a watch or tree, or after an LSM rule update
> fails.  These paths could leave the counters nonzero after the last
> applicable rule had disappeared, causing every subsequent syscall to
> allocate a non-dummy audit context.  It also centralizes rule accounting
> so all rule removal paths share the same bookkeeping.
> 
> The median getpid latency in the same unpinned VM was:
> 
>                                   no rules   stale state   fixed
>   automatically removed watch       38 ns       55 ns      38 ns
>   automatically removed tree        38 ns       59 ns      38 ns
> 
> Patch 3 builds on those lifecycle helpers.  It maintains an aggregate mask
> of the syscall numbers present in exit rules and checks that mask before
> walking the exit filter list.  The mask is architecture-independent and
> therefore conservative: overlapping syscall numbers may cause an
> unnecessary scan, but cannot suppress a match.
> 
> For an unrelated getpid workload, the median latency scaled as follows:
> 
>   exit rules                         1       32      128      256
>   before                            55 ns    71 ns   428 ns   791 ns
>   after                             55 ns    55 ns    55 ns    55 ns
> 
> The aggregate mask is updated through the centralized accounting helpers.
> Insertion sets the relevant bits before publishing the rule with
> list_add_rcu(); removal unlinks the rule before clearing them.  This keeps
> the lockless rejection test conservative during concurrent rule changes.
> 
> The series does not change the audit userspace ABI or rule matching
> semantics.  The benchmark and complete reproduction procedures are
> documented in the individual patches.
> 
> ---
> Stanislav Kinsburskii (3):
>       selftests/audit: Add syscall overhead benchmark
>       audit: Fix filter rule accounting after automatic removal
>       audit: Skip exit filtering for syscalls without rules
> 
>  MAINTAINERS                                 |   1 +
>  kernel/audit.h                              |   7 +
>  kernel/audit_tree.c                         |   1 +
>  kernel/audit_watch.c                        |   2 +
>  kernel/auditfilter.c                        | 140 +++++++++++------
>  kernel/auditsc.c                            |  13 ++
>  tools/testing/selftests/Makefile            |   1 +
>  tools/testing/selftests/audit/.gitignore    |   2 +
>  tools/testing/selftests/audit/Makefile      |   9 ++
>  tools/testing/selftests/audit/README        |  30 ++++
>  tools/testing/selftests/audit/audit_bench.c | 227 ++++++++++++++++++++++++++++
>  11 files changed, 389 insertions(+), 44 deletions(-)
> ---
> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> change-id: 20260806-audit-96a1e71d38b1
> 
> Best regards,
> -- 
> Stanislav Kinsburskii <skinsburskii@gmail.com>
> 
