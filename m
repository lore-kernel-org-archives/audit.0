Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FED4D2ECC
	for <audit@vger.kernel.org>; Wed,  8 Jul 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535749; cv=pass; b=ZZz7Myk45is/k9+Dp2d/zymLo5Y0nLEz1dOZKIbvKm5wQPKDk4xcSR0ZTN1vWtksaHwgqd+nNUCkpaI3wcSwdVS63wnXYqUvLmYBjrYoZNwsWUAFBOR6RplMsWtRHM3hZgqDjyLaH5bSyu2IJXGxjhbajigzeNcIoHOpddRmivk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535749; c=relaxed/simple;
	bh=QehcSz6vCvUk5JYMILPy5wBJGc+OD+X9IzLND2dhr3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkqFw9IXKVCWrXvHVPoHezBsDhVA9XUsaG6U48rXXDCFB1aWpyVKXs9cC+FktFQYEH22ve2CPZyDDBZilzwEnWJdTXcCG+jbcQi2Kxy/DBhFjLWF+nwiA3F2eOwtO/fwmZV719ffLGKOhNIAkm7W2rCJjCLuO7J1zbEGlrPvQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mkii83qZ; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mkii83qZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848479c9bd5so746497b3a.3
        for <audit@vger.kernel.org>; Wed, 08 Jul 2026 11:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783535747; cv=none;
        d=google.com; s=arc-20260327;
        b=aG/DW5AnkghcdAVKqL0oTjC7LugNpb67rSHNxcmzrmwFpW7mCX3rFYZoLXe5V+6CSA
         NEcgRhXFwzvJ2MsxsJ/QTjnxMYxIQoPRGPvZRJtCdtX6gyvgP2UMtpOTFMuJFFIzLS9G
         A+ltUN+k3FdrZmC0hYuRpqszeMEFl/bYzU5hLmFVRM6YYdnywI9pq1526rt4COpacrMu
         UHxPLH2bX639pfukH+MJnYDxUJqjOVxoJR6GIU4M+qxfIUNMqL1q8k3KWjqKYgM98O+t
         fnIJVq/HJxCnrbIjHx0nTG2r4151MbKjg8olBXrZrqwS+bSEkoW4rcOeW4Vv+d/FznT9
         RinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BfTGWSdMJAl6flv5r0Gj2t6QPtFx1AHneJ/te76wCZ8=;
        fh=DgjS6SecTIx5+zlmW9FgRBU4xq5BC9Fwrvc4MyOM22k=;
        b=seNAgPTX+DlPHYC2h2JvgpYMLWx83zicMMWOLPdjJ1JzG+DM+1BBDg1acxLz1vYdrQ
         2vpm4s7Nlg4vi4bDd1q2B1oqQhUboMouThtxaESPCLOu3fcyU2jH4tHxTPZ7SCF/7Dd+
         Jv2Q9vNBccnsi0aAbscXQVPBWXbXu+Eu4507tZAnNDG2qEAbuZOTobNQKZnuj4fRErPY
         l9yc0/yrhZ6mOAZ0sCKvOXt1S3zFIa7WI21o6UfScKLwpmvPAS8AvlZktl0u4Pr6N8Yh
         iqFDpqsMLnYsVKzu9jXVN6DZ57IyrLUcS39HUiE2Adn4I6jeP6kvxgCQY5fg8Rkz68AY
         a0cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783535747; x=1784140547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BfTGWSdMJAl6flv5r0Gj2t6QPtFx1AHneJ/te76wCZ8=;
        b=Mkii83qZI++T735dsp7IWettPkm2iyMIeCfEtYmwBCGutRPJVslByZLanCgq/Nmb3E
         lplR6F0JYTyZ7X6fuxZnxap1A3KDof0s+sLbmmpVaDddNJxYkSxhxnmy7eqr6Ow5ds7Y
         ++GG9b2YVaVFJDg/1nEbqaRnSPx0SaYOiJyu+UfwB2K37g2sl3IZlmRLtMj6T6lYi+pT
         frrFpS0vmJ8LfOGh0E3a0CTdGvKO3Vjmsx35FRa+3B10aqEfOe8V110mUDA/ZZtIaQwK
         UZLzsKXHPMatqzH9bKzwOWufE/iVpq37hc9q0YXBbVZmS1L2qKEyk8hNJc/ERDWX/Aje
         fEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535747; x=1784140547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfTGWSdMJAl6flv5r0Gj2t6QPtFx1AHneJ/te76wCZ8=;
        b=ksJojzcDyOuFs8FgKg7BjEcXhaRUsGWTrBgD25KZOiisMs8NZSe+w+nDw508Kc41lK
         hoJBYvmWa5OuHwUO1YM7k7Bw695cGDfz41hTBs1RvTw7589pt/kKzxoIHqkZ8Po6KawB
         fpBzlddUfnpEXhDliF3C0TMoKZsfBZ3MPhx7wQehvdYZx2+HCF7/gVdoB+OWMWDEQUjy
         NXb1VHDMwxbnjzyCi4mSeBCSMhTP87XSfSAwzpdr92ywGKkWvm5LtrXYjgnyjakEZUy7
         YqbhJ2wj17vCEZS0w9h6x4DL1LSZRAMqf32O0zP3mGcx2mtFjPjI6/AWuI5+11/9UULx
         OCLw==
X-Forwarded-Encrypted: i=1; AHgh+RpNpvmhhhZ+7V7n0rl9F2So51ORRYvK0OIue8ix+CWVka/nsRS5waElfZ9KVQY20F3SQGZfZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOMZkKbR8Qfp5UF4wujX1YtrDerRJrt1VUCqhw6ZZXd6CWtkr
	1pGc3higshkVX7bLIMK48TLYXI1Pb5mPp6VLMkpvxHDYyV8d4s5FclChYS5mEh4LgQjMWuX1MWb
	tmepOSxwmv7Xmr3zZAZSRRZQtr/B46dlbsMQfDmW0
X-Gm-Gg: AfdE7ck1+T+wWvcz0cQgtalnwpi8O8vkV7SSdd0fH6SgWkWgDHf/ipEPMahBqeYWsw7
	98dz5blmDyJZ/0Ut11u/aWSdw3Mqa2BpYqx7pnBl3s0nCzI1pxZV7yDqbtQhrOgxp4rvCnZAmld
	Dy84qFNkoYp5x566uL29MXodelHjerAc/rkeERU3hNtER+wWhXvCoPSO/oHgHPfOiDeK1cD9LFY
	wKd8HU+aIgKTzirWpI3k8BrVu++f8dRG4pkEPuOMGSCHP9n5PBRYSxJCN9UxSnbTXiKsrvA
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3c0bceb75bcmr4322897637.11.1783535747245; Wed, 08 Jul 2026
 11:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708152957.150112-1-cuigaosheng1@huawei.com>
In-Reply-To: <20260708152957.150112-1-cuigaosheng1@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 14:35:35 -0400
X-Gm-Features: AVVi8CcAnOf3DxXEmFl45ZzpYHKVhUpuqEv_daGD3vtJQ1WIh5MeE2psl6iI_Ys
Message-ID: <CAHC9VhSZeDd_v9MEstqH-9pvt7xBkmKbO09Nrm7Gn+chuCkfGA@mail.gmail.com>
Subject: Re: [PATCH RFC,-next] audit: add syscall fastpath to skip audit for
 uncovered syscalls
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 11:32=E2=80=AFAM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
>
> When audit rules are configured, syscalls not covered by any rule
> (e.g., futex, nanosleep, epoll_pwait) still incur full audit
> overhead.
>
> Add a bitmap fastpath: at syscall entry, audit_fastpath_skip()
> checks a precomputed bitmap; if the syscall is not covered, set
> dummy=3D1 so the exit path skips both filter traversal and context
> reset.
>
> The bitmap is the OR of:
>   - All EXIT rules' masks (not including watch/tree rules, ORed
>     under audit_filter_mutex during rebuild)
>   - audit_inode_syscalls[]: native syscalls that may trigger
>     __audit_inode()/__audit_getname(), built at init from the
>     file-operation audit classes plus audit_classify_syscall().
>
> Compat syscalls are excluded from the fastpath because native and
> compat syscall numbers share the same flat bitmap but belong to
> different namespaces.  in_compat_syscall() guards the fastpath
> so compat paths always take the original full audit processing.
> Accordingly, audit_inode_syscalls[] only includes native audit
> classes, not their _32 compat variants.
>
> The bitmap is read lock-free via READ_ONCE on syscall hot paths
> and written under audit_filter_mutex with WRITE_ONCE per word =E2=80=94
> the same no-guarantee-during-rule-change policy as audit_n_rules.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/audit.h       |   6 ++
>  kernel/auditfilter.c | 140 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/auditsc.c     |   3 +
>  3 files changed, 149 insertions(+)

I really don't like adding another set of filters to audit, have you
looked at improving the performance of the existing filter code?

--=20
paul-moore.com
