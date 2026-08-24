Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3D39478D
	for <audit@vger.kernel.org>; Mon, 24 Aug 2026 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609501; cv=none; b=c/6qDE4G+IzZjuh46dtcrZVQNgMyeZWq/+rOMvPmwrmBDaOBOY892uVlFXoizcf4pYqtaqhLWxJuFr9pHhaOBfLKADRYKfm7rZmUfZPbxY+b9EprEu5OhshGxuPBx23ZS5bcSzZ9QopMIZclbLiZyh5mKrbcWXcdUfLW4Sj7TQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609501; c=relaxed/simple;
	bh=AHGZM9MV1aRcdBkfygxeZyG1h4NXSa7avIknZRdwMY0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lEEU/nUyb6dc2gsNT6IXtNe0Qt8Epgu8SkFod8FpUNV82PpOyVNlh7isaW1PlbNOv+qZ1/UL28RVlQK3t+zvekz/530ekSMPQhIRlJBaYJO1QFDEEeca6z03qBgrVhnuGXVQQ1nFSjcL+nvxJ9H3I3LZcIuuYP+5uoupPzYC4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IedNRxA2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IedNRxA2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-934956bee57so415752985a.2
        for <audit@vger.kernel.org>; Mon, 24 Aug 2026 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787609497; x=1788214297; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aaiGEfsQ4cEC5xFUkP5rLfYtHl6ycLF4P+SmVlUKljE=;
        b=IedNRxA2b+kyNpdXdP+L+O0l2ICoVbf8J0VLr60TnNExwX6tRPvWedXZ7BqFeCPIsv
         D1bO6f/L+n9irvScX7maBTwPVGM/tdVS53oNTMwd8Rh0TMpUoWLMbxtBwZrluOQKXTPn
         m9WN3V7E5SOyVjqKt3+w3ON+q4WyMm3JVSy2G/y6IjZBxWxFiG2vEtYEFWLUyKyUb7EJ
         eAz72IJ90SyAGbOs6H9UgOk4UbmrjDK2vfOYK4sSvD0SYtk4hYvNdLhVy9fncrVbRVJY
         +UPgYNkoRc17LRGgWBXeZtrtnNBLKoFnufO6ZZRso+r8ZPQcdElZF0jkEkNYZFBxuKS1
         5sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787609497; x=1788214297;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aaiGEfsQ4cEC5xFUkP5rLfYtHl6ycLF4P+SmVlUKljE=;
        b=WDEVVLjw7DKj1SsJvPj7WGkrDH56MQ/FUd291FxMQF1zFQFzz3aE4J5epDqcY2i5sL
         YU39syL7x5RJmzX+1fopk2Vh78Szy2GXM+zMET+bTY0a31Eb/TOwi1cYt9TQngaJJXD6
         O/6rxkal2aQ/e/J+1/mQtju/a5rH5X7rHvVEOqGk1k3/MhBFUBlCqMORuDeGPYjSLZKx
         1jJmg8k1nmp60GcfVRdi8Lgvq9ZrAyJGK+UKsGB+MN1LGaFnBIjAvUILT0NShgYgG2o1
         CC+yRPkydpYV25iRpZkrYfeuFX5CsGe+hbnVzg1IOeJrvA2UJA82PxJ+ChVoePTuWWyk
         I4KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPlQ0nvctqqL1ql7CkA2NChyCPIyy7qWES+ObhYIn6780rU9d7Jr0AlATD7RZXKMIIJ5S36A==@vger.kernel.org
X-Gm-Message-State: AFuF++lG53q5wwdcQMql/J4MLOwuCqWTvZwr/P2LQCTZfjbRKCYYS+Q3
	bnX8jMfgV9R4FgBzQc0c0CdUeBjIvwKBcbmMrV4X1ijPSHGbmqEANB6sODSWRApKuw==
X-Gm-Gg: AR+sD10vXMklTEejMfuatH2xU7S0DFJF1bWsyN+WFCRUw4nXUEIIdzjCXZovy6Idvc9
	dF2H+mzJMsXzJguzD/KFWvlmUhy57Mi9j4b4lUIsc+wLgUR6a/kiX/TQt6aGxM80W18QYkJZpa1
	FOwvHWewPMK6NayEWj/U4dSIFgwkJcONvLR1kimtd7o6NhMCriFXLmTZejM2D8gVC2bGGqNVuHN
	vbZiZLTGMGuFAO8w+wGKmC9r2XlT/2blLGuDkD6EXFxF9XaI9pbXPcGQHu2jdMGxTPePYbXQYeg
	RnKBsffenGQZfmwC2vPVMGJ3xWHR2phua2k1JzH7BdWwFazbdjZHAmMm7LMhNyseqVm1REITg9n
	1zq22naAVkuF0Z4Jw8q1Y9ALiMja5QkvKSqV0ZPUfj2/3k7gnVuonQmVHZgfkZwIZsf+CQjalC1
	VPZTms1uFdqcnHkzWYj1vZZZJY1MnfPjqI458o4NOTJAxh0fmVeMsbD/E5RJ9sutpj4VWgjYhbr
	cy7v9tFCLxa8DfElmhB0VstsfNLHBkrNA==
X-Received: by 2002:a05:620a:118b:b0:92c:103d:63dd with SMTP id af79cd13be357-9374699c2eemr1825465685a.39.1787609495044;
        Mon, 24 Aug 2026 15:11:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749eb15f4sm594391385a.42.2026.08.24.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:11:11 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:11:11 -0400
Message-ID: <77cb8aa1365ead24eda2ff0800a8ec8c@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260824_1800/pstg-lib:20260824_1107/pstg-pwork:20260824_1800
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: add missing unlikely hint to audit_dummy_context()  wrappers
References: <20260807140521.510904-1-rrobaina@redhat.com>
In-Reply-To: <20260807140521.510904-1-rrobaina@redhat.com>

On Aug  7, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The inline wrappers: audit_log_kern_module(), audit_tk_injoffset(),
> and audit_ntp_log() check audit_dummy_context() without unlikely(),
> unlike every other wrapper in the file.
> 
> Add the missing annotations for consistency.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks.  Merged into audit/dev-staging due to the merge window, this will
move to audit/dev next week.

--
paul-moore.com
