Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6943403F8
	for <audit@vger.kernel.org>; Tue,  1 Sep 2026 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298518; cv=none; b=g4+thEvPzyaarXsYgEdqvVjitZtZsWVqNwVVY6INnUKSuluZ+zFgEpTGkNYOnOD0Ui/xx0ul5dqUd8O5P3zi6gcVwsLHwD2jeXnNtVA0k03LgLMyYZt96byrvYPFmnt1CKbQa1rc1Bsvu+Eunr34fFuEWESLvp4xwEZQMXOsKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298518; c=relaxed/simple;
	bh=iSLp1IrSeiNNeBsrOLPLaCfMKFD7rzEjvmdP6CIih2A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=doHRoAmErBkzx57yc9hQvYvhl+lrCNwYIrhuEjcV5lYw/JWhDwDLktGtbXRwYxzyTFq9Rypjt58yTJBS8FxMGUM1ZsI5wWwsIIKgQkPXnh3zl5xfkDnAcJK7kgQK31s1AJXtzeLT5XjrhTs4Ek6nmRYmdeuwaK5Q71V69XdEPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SXjBgpHk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SXjBgpHk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52fa9c055b5so19912181cf.1
        for <audit@vger.kernel.org>; Tue, 01 Sep 2026 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788298515; x=1788903315; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IE2LqMY6NUtGXuk1qbc18CY6EeLLZzRewObQtxCrnzU=;
        b=SXjBgpHk0N2+jZwhGyhH/DweP9fsFDBsGihousgoKG1dxDF/JDAHCfvh4HbB45OO4W
         +i3XMQlrNdNf49sCwmrwtPFP9G+blHuYebX6EPLXAdHUtk0HBsm6ldQkr8bZPPUE6Jpw
         qvku+97mbMMYv0pc6nSIdoDJBOLmkkq1vb/108mpf91FscvJXvYNghUvf9gSZ1Y0YWvy
         4vwH5RHoUBE5wmnOit6ydDNP5RdZvHcuKdzdJdAxBs5xAmijmA1xYvlGHCPJ5UgSVp19
         qcRj1bTEdrkf/aTZ0T3odBKBVR8URnGSXnIrXU4XyLaB0MQncp1jgKfi3MWimZHx4OTo
         E0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298515; x=1788903315;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IE2LqMY6NUtGXuk1qbc18CY6EeLLZzRewObQtxCrnzU=;
        b=ICqxW/8pg3hjg8e6/BMHLtRArzQMF8r6cK3q/OVDpURwhdLGN9k29ahDgrm1UhFFmh
         6Aszt4S6252krDgaDcnUO10ldH4P3JKezaVdTp17fHy8RFd6NKFiH5XOTruF97Eth2n6
         ELfkRrACAatQDlLQJeGFx1Kbupp8HaLiqVHqcticklz4SNAuEli2cwTfrQ+zwps07pgQ
         HE0wn76vu4O2698mO/tYzASmza7EQZZW3tPTMXL6G1e6kzoazuu/5ijtTsXCtRnu5Dt8
         +BfddRoEgh7Y1Z7+P67yK7lhQAxVoP+5NW7CfFUuSuJYtHHKPDLRh39pBEDa7CtLyY0f
         jN8w==
X-Forwarded-Encrypted: i=1; AHgh+RoOBB52bYKGBTVx+d26wSLxgthAYfRsWezsIOrfACVzhptA5GqWiwGrm5ooe7IjKbqIsPQFjA==@vger.kernel.org
X-Gm-Message-State: AFuF++lkNp3R6D2uFKNiEjgkTOxKPCDGRMJSMMZ83FMYbr2GiaMnAvZj
	H0j0AXAl9QHi6AUR5BBqEZvknr01TUK2ApvTMymzhm/+wzyvJOWhSJpjs227cQNi1Q==
X-Gm-Gg: AR+sD118vpZAxE3BhHSyec50xprSX76ifLpyJDC9thK4u/O5KiKWbgskAb9JndiFhT2
	e5rNAbLUk3rmEzqM4KrI+fditQW7Otpjnk6reJmw1rOXTshi1bJlgwb6PJRrlMxO7ltKX2rrBmW
	rcHmCqutlja+/NSx1UZhjaKD2Yd9qvTUSqirLBo6Q2169arLpiJQulRlnNO2VDjsuDhsTQ1CXd0
	R4sCJKnc5VMyT/earR1aVcFUSAY35CPr+MUrOAO25EjUlyyIYoScsMkummxKZklxAtNeGy36X1a
	nNiud4rTluENTzIBPksocC9jGVnUHtAcakCpicOMDT9PvMrVoL7JUbStarqwGTOiS+UzRlqwjxa
	wByVTGsf2BjBqMeIBLpG2RK25g4SCZK2n8HM4NZG9E4cynET+UobT2OrstxUoL5D78yuEQS4a6f
	66zVrb1pQMzWCkvaDVuT2gsQnnRPvaPYuog7duBsTg0woCAJ24Cn9ZE4PBYw9hyPJ4xnj7DS+U3
	BeMLQf3j3Q6TiXC3xcrUruBC172f4USA8rHkCLODS3X
X-Received: by 2002:a05:622a:2305:b0:517:c65c:4987 with SMTP id d75a77b69052e-5302543895emr138218971cf.22.1788298514613;
        Tue, 01 Sep 2026 14:35:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff4e90sm5772091cf.2.2026.09.01.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:35:13 -0700 (PDT)
Date: Tue, 01 Sep 2026 17:35:12 -0400
Message-ID: <580b5af8293cea8dc0a13e044b52280c@paul-moore.com>
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
Subject: Re: [PATCH 1/3] selftests/audit: Add syscall overhead benchmark
References: <20260806-audit-v1-1-ddd0d94ff0b6@gmail.com>
In-Reply-To: <20260806-audit-v1-1-ddd0d94ff0b6@gmail.com>

On Aug  6, 2026 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> Add a microbenchmark which repeatedly invokes getpid(2) and reports the
> per-operation latency across multiple repetitions. The workload avoids
> filesystem and other syscall-specific work so the fixed audit syscall
> overhead remains visible.
> 
> The benchmark deliberately leaves audit policy management to the caller.
> This permits comparisons with increasing numbers of unrelated exit rules
> and with automatically removed watch or tree rules without modifying an
> existing policy unexpectedly.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  MAINTAINERS                                 |   1 +
>  tools/testing/selftests/Makefile            |   1 +
>  tools/testing/selftests/audit/.gitignore    |   2 +
>  tools/testing/selftests/audit/Makefile      |   9 ++
>  tools/testing/selftests/audit/README        |  30 ++++
>  tools/testing/selftests/audit/audit_bench.c | 227 ++++++++++++++++++++++++++++
>  6 files changed, 270 insertions(+)

Thanks for this Stanislav, but I'm not certain that we want to merge this
into the kernel and have this become the defacto standard for audit
performance.  It's a simple, easy to understand test, but I worry that it
might be too simplistic to properly characterize audit performance.

... and no, I'm sorry, but I don't have a better suggestion off the top
of my head :)

However, audit_bench might be useful as part of the manual_tests in the
audit-testsuite?

 https://github.com/linux-audit/audit-testsuite

--
paul-moore.com
