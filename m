Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE1417BE1
	for <audit@vger.kernel.org>; Thu, 23 Jul 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827300; cv=pass; b=Tuf7FxK6+p7zo9AADyGJpzl+5KVHmrT24zFhpenwSYxsE7J5VsUsFvgwArmqfuuVoSop9LT9265tjIVzSF8KDd7w3rKuH9xh2pboT/qyJc/h8hfzpT3yjrzzq6dholwcgQPknigMdhLcrN+8SoTQPvm4YTKL8yVxANd+0m1d3YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827300; c=relaxed/simple;
	bh=8Gg2XbldpLMsUZojY/TpMY/hmG9JSL4yamN9EKridMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOH8nobWokyl9jUkMOklELdppnlWLTq4Fex40XB+6ZSLmsqtByIzEPOxRforvPbBCVz/2WhSAttScO7XOJCZMM91Ei06060OXCEG6O972y36EoyPfFUX/ehQ5oEA0Xxzco9+IgPuFdC702JOMGTZxS9A5bF+DHSHOOknfbnYAVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dntao2o3; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dntao2o3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so694707a12.1
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 10:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784827298; cv=none;
        d=google.com; s=arc-20260327;
        b=adQwESioeDqV1G6CZLzd85RbbC//NqkMdpaZ5IlH4M4PDfqAHEDexhb4ba9Saa13Xg
         6KWT571xYNNFNKQTltUPC4h52qYu/XE2atQxshRGosQHLcb6litekRnWiFj06tgHhOvb
         0MY4eectc6w9DPo/WFRL7YWSafxmu9GxfUXVArvrk7OuS7NdcOSRvZblV1UdNpjjnffs
         Qai6DzMt2CFOLU7vdhPIRRVCX95g/KO0xKRvikqQj2GKRJbJjmioL7YP9bmelT8UK0Oi
         s2WXpwgLQ8LxVM2oQKT1l79muosrtx5voqPwVEPAakj843PXDDyUVdmvbnK5Fn8ozmwZ
         Zrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tiv4QrJoovLT4G3A2lfHDYRca3fItAiSKI996i+aMNI=;
        fh=LJ1nkRAKnZDuTHV7hMCc3bBF5tcegFgoLfM5jSrlRGQ=;
        b=RZqDC9wu1K4zvcyWr04omCg57Q5WPGVYBrfyqN1ikPvnkv5mCAKU63Xm63LiOoYeTH
         FzP9F168tRRaoVxq+aQNCXt+wSkZchZ6SGyH4WjvZAKFQ0rGpmKTP9jtg1+4e/kUyjTS
         NgY9GRKQChJZMaPDzyTn6MeNyC5PTlFrCaoCx+PerkhEufCS9jXjQNDMbPss0uxlIFdA
         hp8zW+7KgqCz9LQJbAJnYMIciTl1ODIgsrG/Zqs0unPZRtg9JW/kKgI3vJ1XCTjwxAOs
         tKV3brkxmLMSuSdAqky5Jjq1uqdPP/kjsdappyF7WMkO0WSWcwvkp7S0YBHTKEteZRJy
         DTMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784827298; x=1785432098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tiv4QrJoovLT4G3A2lfHDYRca3fItAiSKI996i+aMNI=;
        b=dntao2o3XXiXSveZTbpBVFUE73slzQAyieLn9VwwoxHwjVP9ZR7E+mdlCW3COT9LKH
         G01efTuD9fxVyArO7bmCWSArBE2vIsnGXCVTmBU9hQnmS/IyjPl9HLqA2unhrQWwAbwZ
         WvxREEVyuMIlTj8YQqxFM8HYehtalUG6u86NX/4l2Tey3q2LSTTQepxocYiaH2OSza1K
         bebAWHMGT924nuiJnqd9B/7SftmdTfYOdDcDwwZadZr1C282Bc1FIo0RjsXLTHV2AGvq
         Hb/czHthOWj34QI1jQOiCjG8CyVRQ1LyBOdViImCv46jjebvkLS+xhVkvHJKjFfNnAjG
         PNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827298; x=1785432098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tiv4QrJoovLT4G3A2lfHDYRca3fItAiSKI996i+aMNI=;
        b=c9xfkcsJOKYrw/8lbPupMa5BrTuUv3RrwM7EVVXhwBnofdPmXQzTs2BdoV0H1feV50
         Gm2Lo98pR/nM/N3H1ojXu7XsHVeR6gdQhywIbu9ytBQd6xLavu3RVkl2Y3NTINylhNpY
         TEsnp9HyCZb3jf4eoTykXeRU5vNMEs68pB78edBv5pgvo9K+M4nRfsyfOT5/26y6VVwS
         ZMt5hrMqQkOpwtqqS1Guq0gm0TsjBKD8tVu0RQl5hAJIglHxuxM4vSXn6dXD3TrFZNlF
         S2pjsXIFGexQGJBvDfVhIJJv/ShqFYmuWCMN4F381JX4EtXT2wR3OBFJXY+5oMTUxdZJ
         U3Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpCFuPvmpFgp0TxRFZUTLDM3TmrnLlYEy1udxXSKpTQuBYmUSNvQZRpiEWh06g3rjL6UPH1rA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJdwyIDM73c+tN3uodaBAqPtOHU3rQz/YCgZabsTbD6bz5VD0
	962tmrkCsKufsMuCaLmDunU/ybk19XjrCYVmWjxykmq4ncbZIBdjsBqrYMyt4ChP/XwyK10aRdS
	wTUfRyWvB8lYyhB9nj3AouJlRl0/N5IyVEVxC5RB1
X-Gm-Gg: AR+sD13wwBQvNq0Y5UjxKwcEs3ZSINuGGnR5ZYHOW5TOzrb8zMk/qxtj8RIsQTJAGSj
	DTho3lkJYm6Jm8WImiKHixBFLe1xlYAv+CmSZih6bffWGDQ9RwpUnzTVOZrFwslh8p2MH2rn8oW
	I1E7UTb98Q3JchUKGXtnomkBr2UWlnzIQUjLdUiiX4Yj1rhVX4rxeLag0JqLYhnhTv+T8wHelzl
	yQqVFLONxTeYVSapW8wOxw3DisS9ofeiKNE/1QOCBdhjStd4OjcWHkDJbgl9w==
X-Received: by 2002:a05:6a21:6f89:b0:3c0:9c1a:8950 with SMTP id
 adf61e73a8af0-3c44b23a18bmr4372470637.72.1784827298557; Thu, 23 Jul 2026
 10:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721040118.1000554-1-ruanjinjie@huawei.com> <87jyqolqn3.ffs@fw13>
In-Reply-To: <87jyqolqn3.ffs@fw13>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 13:21:27 -0400
X-Gm-Features: AUfX_mzzHjU3lavD1ndH6OyXlCnXpV0-hf9UtH6alK3pSFD66pYroW73SuW3LWo
Message-ID: <CAHC9VhSohbG8n5WW4VaEjU7nVA4WCrkJ1eD-=34ioaJOQ0-rCg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Force audit_context() to be always inlined
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eparis@redhat.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:59=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> w=
rote:
> On Tue, Jul 21 2026 at 12:01, Jinjie Ruan wrote:
> > commit 6f25517010dd ("entry: Rework syscall_audit_enter()") relies on
> > dead code elimination to remove the call to syscall_enter_audit() when
> > CONFIG_AUDITSYSCALL is disabled. However, with s390 GCC 13.4.0 +
> > CONFIG_KASAN, audit_context() is not inlined despite being marked
> > inline, causing an undefined reference to syscall_enter_audit().
> >
> > Force audit_context() to be __always_inline to ensure the conditional
> > can be constant-folded and dead code elimination works correctly.
> >
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202607181530.2nx8zb3J-lkp=
@intel.com/
>
> Obsolete. Is already in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dc=
ore/entry&id=3D6f25517010ddd3f8080d7e06b9b1cb1b64b73772

It would have been nice to see that patch CC'd to the audit mailing
list for obvious reasons.

Since I'm just looking at that tip tree patch now (perhaps there are
other preceding patches that affect this?), does it still compile
properly when CONFIG_AUDITSYSCALL is not defined?  With
syscall_trace_enter() calling out to syscall_enter_audit() that is no
longer inlined in the same header, and no dummy function/macro defined
for syscall_enter_audit() when !CONFIG_AUDITSYSCALL, it looks like
there might be an issue on some configurations, no?

--=20
paul-moore.com
