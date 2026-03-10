Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FD34A784
	for <audit@vger.kernel.org>; Tue, 10 Mar 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170564; cv=none; b=hwqryyioaFpkyGN+8K9gqcPjjxdWx8hwVhjG9rL7uYR5jt8eKRWqqyaimRuwH08Qqf+ZhgDc34RxRcMS5QHRiU2Nz7ib7GSESWJs3LZhhapYEYxUnsBj2B4nRlY5xMxeEi3cd/MmPbJgKd0ztoTOhMYgNmv4yKr4mUA+QpdA4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170564; c=relaxed/simple;
	bh=2X0JXluk460/BnzKu+STGhWj8xvDcmWnGO58GKgYU4c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=d9soz+NgvdoaKzBcpkliw7YSNUkIJ9mGJvrGTY+ynPWv/1sPDE2PjvdOTj28E78ZZ//hw7Arr/tcGJa+1Ejyfm4nlVrgbTfUat1E16ufwr4v4Xm5GuzzAIia8/s62nTxMxUTMUfKWzdZnU+Wg1oOlgl1lhvhz41QXQggroQymTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OzfW7yAX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OzfW7yAX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50905b779dfso40166241cf.3
        for <audit@vger.kernel.org>; Tue, 10 Mar 2026 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773170563; x=1773775363; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aV7hXCLQCflyUrdLM8cprfjVR2mNmzi/mjO0qXwCdXc=;
        b=OzfW7yAXtfvHxL94OM+4L81dUyr+dBSvMXs0Gikx7L5T0YCyf0/JCV01g4jTb4z0VK
         YRFH0N2CGEv5vvG+8kN4UZ1KOiTeuZZKrtdkzp3lsMz1oqLZYQphkqBZthu0L6Qzs0l7
         ZPjusBuo75EJ+mxei/VKZQCEcIG851RSpPiru+lwQ15qMYemD5BiZtY4aN9tDrKB+tHJ
         +zNohkq80ZYT6BPN2PmuDRA4pKgAoukf5eXrojutRKI6hYLzc8cPBPKu8wH5IyOSLzbx
         qzbNVRD8C8VeFUbGMbF5Sd9JBZ3sTtUD5oCnKQC2q5YQcKcfkhfk8wgqoa3Q8QMnQ8dJ
         yP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773170563; x=1773775363;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV7hXCLQCflyUrdLM8cprfjVR2mNmzi/mjO0qXwCdXc=;
        b=UDgblW5FF7B1tMqyXazolv98TP/0th1C1WURMwztO8jZg2hs2nKNoxF6Nk6eN83M+X
         ACyO1MFIg7Xiw3ZL3pd80Zl694eyBNNDMPyuSqMumIMo1G+Jp4MeZca3VZNG7Z9d9KnY
         PIbI4gY/I0Aa4jCgHFy/E2C+9WAeck8weNhgHuQVvLBc/tZsa/5oBl5a1OnyjgQ8xoxG
         RU31TmcsyCuPUVGiIcAIfJWY20P5/iA8ok46fs+/i7Fx1RkvRgaS/VON2xgrUQHgRvaJ
         lrJTG0w16BlTOTjYGYR6xT+9Ef5xFlf7ec+c2fixfzh2GTxw8RMyjCse2F3xJHm05TVD
         qwyg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0m1UjceAB2TvdTHDGJ+yocxw4sEWML2GUnKb5eqeLmw7R/l8cwsk9JQSQMCoBLqZoPJ7GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/wpdoZP3dxz5M5dSwGGJ6twO21yyI/VoIz3mMTptxYda3LND
	abCirljXz+Mi8Mzmqep2eV1orw3qwPZq1jpNKVHH6FU7LKvt7N3LtE3Hk/7ArmhT2A==
X-Gm-Gg: ATEYQzxAmr1QA8MQszxkGDjIucvMqQUOi4cyjyZwp1bAao8L4IG9isSlVnk/+nEUoMT
	0ox2q+ASOGw6D0Z9/iCBkLr3unnSiIwnKDB6SySgKV9KtUbWpq7NjqLPTicCfT0DsiKQ6rEdIAE
	nQjwhzsJP8yoOaycxZfmX6D1PANpnM8p3Wfdp8IuJpPcwjhFcqVckYGTN62xj5VQJkJsCb3ScDh
	oPF7r9G6aQkJsFeQlsLc0Il2HYVaV4byjLmUW97Kpl/tl77B6y2hNCzA5YRevfLWS8TpQvsnk5W
	Dbtb9bO/JY8qcPr7qX1Bdkw2rws//Py0alFRy+qvTHt8TzNX4ZxobwbcDhueTUrTmUuytgN5llA
	dI+F6s6083wE8jU9mnHwuIJM29Esz+62HVJ9ZYIiwgPqeFAZVTnWOpmEree6SYBVl6wA54eVBWz
	bW8ngU8lkiFOqFewzhDvIgV5nuYTYXmDRX6mgVNrg/m9pQdg8e01TZGmZA/wXEok6H2FRE
X-Received: by 2002:ac8:59c8:0:b0:509:1c90:e192 with SMTP id d75a77b69052e-5091c90ea59mr96495091cf.66.1773170562824;
        Tue, 10 Mar 2026 12:22:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093862bbc9sm1796501cf.5.2026.03.10.12.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:22:42 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:22:40 -0400
Message-ID: <7e02e707baecb7c94db329d5d03c1c15@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260310_1520/pstg-lib:20260310_1519/pstg-pwork:20260310_1520
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH v2] audit: handle unknown status requests in  audit_receive_msg
References: <20260309130533.158095-1-rrobaina@redhat.com>
In-Reply-To: <20260309130533.158095-1-rrobaina@redhat.com>

On Mar  9, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
> requests, incorrectly returning success to newer user space tools
> querying unsupported features. This breaks forward compatibility.
> 
> Fix this by defining AUDIT_STATUS_ALL and returning -EINVAL if any
> unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
> This ensures invalid requests are safely rejected, allowing user space
> to reliably test for and gracefully handle feature detection on older
> kernels.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> v1 -> v2:
>  - Moved AUDIT_STATUS_ALL from include/uapi/linux/audit.h to 
>    include/linux/audit.h.
> 
>  include/linux/audit.h | 9 +++++++++
>  kernel/audit.c        | 2 ++
>  2 files changed, 11 insertions(+)

Merged into audit/dev, thanks.

--
paul-moore.com
