Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782179D9
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZzJPx0y1"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045361722
	for <audit@vger.kernel.org>; Mon, 23 Oct 2023 20:52:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7789a4c01easo264257985a.0
        for <audit@vger.kernel.org>; Mon, 23 Oct 2023 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119558; x=1698724358; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XsaNGjlcimJtQjiAwAEMf2P9+0lBW+WKE/hjZAD7dek=;
        b=ZzJPx0y19ajQdpatRHIV9OeYbUZdaaBZFXCshlqwJCZYO2u3kgFCbgta/xGM2jnj2p
         8+kCX5JTZZ1VehON7byPvfJ5U6/lZGLLV2HrO7ImJwWRGysVUGepVz4oGfXDSxWpS01H
         llWr0/T3mPVztmuSNR7LotGveoiuz5fcXyqySGe9L3uM8KoTajs1X9PyyL0LMbDIr0zz
         wU8i7Zkr8+w0f9km6wDCmpyvw8I6jpaFQ46JySPHx7VHXazCIRGoGTUGtkcUXyKSOFyy
         w/aOFa8b5S0U1O6CjzMwBBUajPeEcD5Cat7S04a9vo3XlUfv/5SiVcqa5keww9C74lKY
         DXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119558; x=1698724358;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsaNGjlcimJtQjiAwAEMf2P9+0lBW+WKE/hjZAD7dek=;
        b=UYMdi5R8b6JfKLGC1A37rICbmvwzHGKBL7ROvDZIW2jrxiruStSQaCf7bRM7RhjRSM
         xbOBollrvj1G9HvZmf3Lp7oxsI0u0z29m//Ad0GzYo9czmJQzGcab/NCxXNJTFZxWKYl
         TeL8Xk9mqEfeD9jIGp7scRtGzzRWcU7j8u6FVBCW9oJI0c0cqjLx9B8St5gWDJhSGP08
         VmamtMsnzMYR/Ginojz5bxREGZ7unXDxoQnA5WORrJ+mtSjYkUs2dDefDDLFfFOCzDCY
         j98d4VntyEQVpQiYGm5H1Xnp0I+XJNsxfPGsNa2xZdrWX08IKyR3DcAMMVT/zVtUNCH2
         mPkw==
X-Gm-Message-State: AOJu0YwClDjsI9m8NlJ0EFj1P01ma/pMpz4D3Rw74I4lfP2wTcQDDCvY
	JYpxsFpD2JKs7nOz3uP8kawx
X-Google-Smtp-Source: AGHT+IFgtMi4EqN6N9ZtnfOHbANV4Egy0LBPK5cs6vsX4rIphs5HUZhBFo1nSJ25zSqGEggCASqLKw==
X-Received: by 2002:a05:620a:430d:b0:778:8dc1:bb7b with SMTP id u13-20020a05620a430d00b007788dc1bb7bmr13244374qko.27.1698119557740;
        Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s4-20020ad45004000000b0063f88855ef2sm3286811qvo.101.2023.10.23.20.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:52:36 -0400
Message-ID: <88259677752389b350614857e6003b8c.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, audit@vger.kernel.org, roberto.sassu@huawei.com, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 18/19] ipe: kunit test for parser
References: <1696457386-3010-19-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-19-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Add various happy/unhappy unit tests for both IPE's parser.

I'm going to suggest: "... for IPE's policy parser."

Also, aside from the policy parser tests, are there any other IPE
functional tests?  We do have a testing guideline for new LSM
submissions:

 "New LSMs must be accompanied by a test suite to verify basic
  functionality and help identify regressions. The test suite
  must be publicly available without download restrictions
  requiring accounts, subscriptions, etc. Test coverage does
  not need to reach a specific percentage, but core functionality
  and any user interfaces should be well covered by the test
  suite. Maintaining the test suite in a public git repository is
  preferable over tarball snapshots. Integrating the test suite
  with existing automated Linux kernel testing services is
  encouraged."

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-guidelines

> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v6:
>   + Not present
> 
> v7:
>   Introduced
> 
> v8:
>   + Remove the kunit tests with respect to the fsverity digest, as these
>     require significant changes to work with the new method of acquiring
>     the digest at runtime.
> 
> v9:
>   + Remove the kunit tests related to ipe_context
> 
> v10:
>   + No changes
> 
> v11:
>   + No changes
> ---
>  security/ipe/Kconfig        |  17 +++
>  security/ipe/Makefile       |   3 +
>  security/ipe/policy_tests.c | 294 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 314 insertions(+)
>  create mode 100644 security/ipe/policy_tests.c

--
paul-moore.com
