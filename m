Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0646D0B6
	for <audit@vger.kernel.org>; Thu,  3 Sep 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469988; cv=none; b=WoEampqmi1kSWJRwxlssfg+XMGztE5wn+xvhHn3dGR+69TkpYir4PLBOcrWHNNuxd6/EzhiJ0eVSTthE5fuZgqIErgJs5Cke9IQMk7Lmm6reHNNjdzAKL262m+H71Aty3RBEAlr9XDjJ13F8PyMxtT3OWr746nnDgmV2uYGvE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469988; c=relaxed/simple;
	bh=/SXNaYAzOtG1exBAfYMsRpUkcMovgrlxcT5oK0UNJoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzpKWz3odOJHyRUH1XAEfIiho/uTSU1jDICduOXFmK+1C66NW8tpIVTBHu+qff54ksHrJ3wP116xuDQo27jCLrwp/vJToRu02ZfZ7vXIGUj3zf10Kw2cvERFX6Mk9EPCV/TmJSHWFUT3/hTMhFDe4ExdzjZwfN+5QEGOoAyLxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H30SvNco; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H30SvNco"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so360188a12.3
        for <audit@vger.kernel.org>; Thu, 03 Sep 2026 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469986; x=1789074786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/mj3IVRmoCFRi1EC9+dVyk39SNMUGyb4URbFkvdpey0=;
        b=H30SvNcoJr0RF6gresCkpTwoVVzuNC0pjaGGpreHTSKfprQVVizSNpBk7PIJPoyGBr
         y3ER69pQ4v1MFrHU3rL3JcMni/gf0wGTkGc8yQR9PlMvAWPg3voccltIbSSdrFBl0jqV
         +ocsF0mphFV2DpehV1Cnvx7lNUHHfFmntxNrTUbKtnbWuGeXq/sJR8QEGIHcovlLh9Gz
         GXMymmZo8C/RBUln+VbkpQszrTrTphj+5jD8gV2noZLFBymR1gu79WBMbiElzH1AuPTQ
         EtisAgESzDsz1Uhs9Ahu6A+6XoGR6rwALRphtoqzuhCaK81fQwR+WEVnUUkygDJlbIbF
         zSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469986; x=1789074786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mj3IVRmoCFRi1EC9+dVyk39SNMUGyb4URbFkvdpey0=;
        b=E/NW9ooT644Yc6gBrqD1qEm6rbWjXAuo1T7EAzKujqYfnSnI4XDDMYgl0PHywfaLEP
         U1RFVU48Q/LfLTw/roKFkm/rINj5TrSmvd4immjEYTJlahU3anqN3c6encx0VWAMm635
         WTreC5r5bPl8RAQZB285KzL17Qn3bCqxphS+aVMqpecJBgkFxwiGJ6H3yu2IR+2HywBN
         Y2qe15LUdVmqBgJDT1A3oDWeqe6Nv/+ewe88YRsbRSbC+Je796SPVkjnE0oTbwHTXBwZ
         iSLzxDKWBVXr5EBr9GsmLrmleUGBlMHEs/icLjav5LvvNnc/WZ1+fgL4kvXL9hVExZ27
         mKxg==
X-Forwarded-Encrypted: i=1; AKwUvBz310YRmsKqmusra0WH2sU7NGac88A4NWCjxidfXapi2g9Gng8CivFt3SYAie6fJDO48YZung==@vger.kernel.org
X-Gm-Message-State: AFuF++kAnomkx0oGjCu0XNWwnP67QeT1AhK8+9gAfrvfLE7lghorSG1M
	nCNBTqyIAAR+TJtiqj+WguIwXYdeclOwu0RcNJbOqGTeTYvmCfVECSs9
X-Gm-Gg: AYBFou3+PrIaLzVL3pmquN17/KG/K0FQzAVuadnq68BpybAOCBH5GEJlC7yFzqg39Lw
	IkEz5l0q7jxRy9Kw029Gm8dtjCAzYkiCXyrarOkFbhbILOwe0vVMPASP4Ka9hsgL2gO8Dsd+LNb
	e/bGXtrWM/rjFKm/UTXDYvaG7v6rQcQQGXcg7bB03oOsfxGOrKzP/SQDQaI8qP9ucDVKC8Kh3bu
	+v2vRsOGBafksnVxjJLXK2N4I0b6QIVGzujRqF6VX+EXfNOvK/hgeupWGje7qGfb6HwzfLt7r2n
	sjpNla7njvy+lIHppC/Lk1zZnYs9TR2L5sOmtVcWqulJcTuB+eIY4BBpq//QpxCcGFlS0ZKE+Mw
	myBRI3XHbjGlNh6CkH1G41XWdpFTBBP4IzGPLONRPIL0+lGVVCsqQF58K++c7qTkGjh3Rsqq3Uv
	xy2my26au8+IhKj1irVK2GF+QPShF15sVd2ZBYmj2pxFflbT2AOTDTnLIuwknClfvgV4Dn1PGsi
	Mf9Ijo6FP7UQYEFw0daLuet8Bkefn6TgqwVBha2N80zFzE7jo71abM=
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39b263167f7mr1956509a91.25.1788469985477;
        Thu, 03 Sep 2026 14:13:05 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae633be61sm3479083a91.1.2026.09.03.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:13:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:13:02 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Paris <eparis@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Amy Griffis <amy.griffis@hp.com>,
	Frank Hofmann <hofmann@deshaw.com>,
	Noah Orlando <orlandon@deshaw.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/audit: Add syscall overhead benchmark
Message-ID: <apni3p2JBQmc5IZQ@skinsburskii>
References: <20260806-audit-v1-1-ddd0d94ff0b6@gmail.com>
 <580b5af8293cea8dc0a13e044b52280c@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580b5af8293cea8dc0a13e044b52280c@paul-moore.com>

On Tue, Sep 01, 2026 at 05:35:12PM -0400, Paul Moore wrote:
> On Aug  6, 2026 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > 
> > Add a microbenchmark which repeatedly invokes getpid(2) and reports the
> > per-operation latency across multiple repetitions. The workload avoids
> > filesystem and other syscall-specific work so the fixed audit syscall
> > overhead remains visible.
> > 
> > The benchmark deliberately leaves audit policy management to the caller.
> > This permits comparisons with increasing numbers of unrelated exit rules
> > and with automatically removed watch or tree rules without modifying an
> > existing policy unexpectedly.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > ---
> >  MAINTAINERS                                 |   1 +
> >  tools/testing/selftests/Makefile            |   1 +
> >  tools/testing/selftests/audit/.gitignore    |   2 +
> >  tools/testing/selftests/audit/Makefile      |   9 ++
> >  tools/testing/selftests/audit/README        |  30 ++++
> >  tools/testing/selftests/audit/audit_bench.c | 227 ++++++++++++++++++++++++++++
> >  6 files changed, 270 insertions(+)
> 
> Thanks for this Stanislav, but I'm not certain that we want to merge this
> into the kernel and have this become the defacto standard for audit
> performance.  It's a simple, easy to understand test, but I worry that it
> might be too simplistic to properly characterize audit performance.
> 
> ... and no, I'm sorry, but I don't have a better suggestion off the top
> of my head :)
> 
> However, audit_bench might be useful as part of the manual_tests in the
> audit-testsuite?
> 
>  https://github.com/linux-audit/audit-testsuite
> 

Sure, here is a PR: https://github.com/linux-audit/audit-testsuite/pull/129

Thanks,
Stanislav

> --
> paul-moore.com
