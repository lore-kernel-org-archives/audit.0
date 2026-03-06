Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B305342CB0
	for <audit@vger.kernel.org>; Fri,  6 Mar 2026 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766970; cv=none; b=dxlRiVG6A7FEuNmhhe/KQK78MMOiW4y6sEkDxXyNoOjpygOBorw2dwW7SPM3vBbOKoypQfV4GHR5B57My0uIf3ukD8tW3wXaYXpnzsCPk7OucRgYaZQ4M1WRY7rLGWs83RVhJrW5XvpfWMbnkOlLQEZaWHM45dMu7wRKe5WuL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766970; c=relaxed/simple;
	bh=lTHdlCeWkJuzqVW+zS04I3w0TQtO3Y4W0AHfEttUj+U=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=JWB5r9mbPVnspLCq4Xj09u+iFmFb2g8D7bs5tUeeFvmyZ1S0P0VXl/7HCB6IYpOYqPS8Wxzr88vcEcis2Lj7NWITlUQZvYh+YLWpdQLOV703LTm/ZYfAaYJby5b1LSEq4DovlznMY5JQgKvxWFUx/pT7FDjJmmVL7B2w5MrTkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fxFBppPj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fxFBppPj"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a93ba42dso91049411cf.1
        for <audit@vger.kernel.org>; Thu, 05 Mar 2026 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772766968; x=1773371768; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avhud4NtQnnmaRwpPx1Kk7Q76ujGXGZpEhv1lsJZSfg=;
        b=fxFBppPjfA50Y4AXygnr0HvF0NaVhzBPv8KRNMjCtzNRHAtHjDiG4M/A1QMvpsoG25
         +r6xjhRyDwGc4UWWIa3G27tayE2tsv0gyZjhKPxA//rUCj1QBVXEsj21UHrykKzo9pii
         oTZn5KiUcaDtO60KOst9ER5feXbMLoyOGI+f3o1Kz1GGG4kWBmU02jJnet4G7VGyeeZc
         9s/WN/ceFlNkjYSyhLS0f35P09SeypOVEuuz9j5dBZDCRos1neTz8ocJrbMN+Pga4Q8k
         lv6BS2cDUykPbrqszPX4fgCnfl4NoVtJvp7/5JRHPTUPwX/sLDeQGmqEUkSee2S2TqXG
         ItVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772766968; x=1773371768;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avhud4NtQnnmaRwpPx1Kk7Q76ujGXGZpEhv1lsJZSfg=;
        b=Nv+Xd1phZeDWKvJeNrsqX8exSO5n8Y++ZOCmJ1KQmxbr4HgnBgOR+vJFBw94YccTzv
         +466N6LSu3kR5+nXgKEqF28ob+pL+4fqCHh7CsZ2mQ+EyG1+oC+NtAF6CuKNQeYK4b18
         OA6fOfqLV+j4Q35m4gXUs8o8+cb+5CP0z4TN28Ur9jjrJ58j6QU4m/C24Vz3Eh9Numkx
         lW/ZzPWdaJ1lBW3aoSIZ52/6oVBdrAc0WELLO0/SGwTmplguxJMf1y8kqPJp3rLb9UQD
         LmTCO9woYvPaj1YvbocRggPp9gXjwfcH0S5b5h67yGL9Ck3+GHMFwkEZ3q/YUk/Hr8Rj
         y6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWXnpuHViFb5Bds3S5/23NIUfrhLEqrGvpjoj1PDZWnS8ClcCHm0ndUnkdWV4lB1n4XZC82eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJDbEt0n3CVvkJFnz/pWwDBaRO55E3cxQqATYz72fWaP+4PKV
	tSoyAUJNcRR7nBsOGlZvRLS+yjP0bTXsoIafOFmU9eWbw0kjnosuBdfhKzqm80dLSA==
X-Gm-Gg: ATEYQzzWHYzXGtXuuy/0ZWWqPAxY2B4W90fkRQ4vh6VQrtbAmIP2Z1dvXeJ7V29wsc2
	tLixm1Zh3vrpl7PX0Xmf5qS5AOknnBgUC4c9px9fnaRtb/QHYEGWlhRv32sjhmSIP+i0AimCIXK
	//K+EPfJ2ulwBVcRr6AvKiheXZrgDZJmk2sojOf4NWL1K9DHVQTImVWhYwV5UxkysAWkHhZX03k
	pGXWbf0c4ZXQJMvb/ocddBdARK1IHIF+UKxCIurNLo80dKUtvLQgT6xGeZho9bRVNzmTK4lPqwI
	z/GjrEwo3kvS1MMmntlc1tr1gTYGYs2lWwII8P+//mJn2+c34TzuXlmulVp4lHMW/3oWqsm7S9F
	5D+f350houyd0uGaydCQqbIiAIVHS7M6g7omWT8mVWTozGKqWB7iy7PEDXWGSRiDd6urUSLVaiK
	wqsuF3U5yBsHKc1kjkPHaz5lGBBUG8ArI42sl+JHO7Br45a2Oq96kZwAitccnaF2IOSyJ8NIe7M
	F000qs=
X-Received: by 2002:ac8:58cf:0:b0:501:5284:c49b with SMTP id d75a77b69052e-508f496e60dmr8406181cf.39.1772766968161;
        Thu, 05 Mar 2026 19:16:08 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66d983dsm661301cf.29.2026.03.05.19.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:16:07 -0800 (PST)
Date: Thu, 05 Mar 2026 22:16:06 -0500
Message-ID: <2de50f30bb93c06044c56fa150587c56@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260305_2211/pstg-lib:20260305_ 910/pstg-pwork:20260305_2211
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, akpm@linux-foundation.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: fix coding style issues
References: <20260303133528.704135-1-rrobaina@redhat.com>
In-Reply-To: <20260303133528.704135-1-rrobaina@redhat.com>

On Mar  3, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Fix various coding style issues across the audit subsystem flagged
> by checkpatch.pl script to adhere to kernel coding standards.
> 
> Specific changes include:
> - kernel/auditfilter.c: Move the open brace '{' to the previous line
>   for the audit_ops array declaration.
> - lib/audit.c: Add a required space before the open parenthesis '('.
> - include/uapi/linux/audit.h: Enclose the complex macro value for
>   AUDIT_UID_UNSET in parentheses.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/uapi/linux/audit.h | 2 +-
>  kernel/auditfilter.c       | 3 +--
>  lib/audit.c                | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
