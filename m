Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7C17A2EA
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483564; cv=none; b=ZFnLxY3m1Cctm5w1BxqawZ4vBdUUlG1hMKPgSUWMoyAPzc8YqJZZ/Jk8kinsSsiGHqM52b8YPgnA/HmIrA0COG6kMPjxwywP1flvSRqBZeYcjLVjIM2p5O1ZFUAHZnSJ+xx5Zry+kuMqST8QjDCu9yeYhn5nqmr+HHGHsxWljPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483564; c=relaxed/simple;
	bh=jP7eKKlEemoHr9cH5h7XSAsqHsL7E6l+1k/CdljmEEA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=b66a7kHXckgb0D9EYKJa7TiTo35yIiCqsEvi1jNNbhCNexRXAB6jiXKcDqEU2d2AbFM7JeyaBmvHcffmHIMHc5vVBC+zVi5vAeoLBsJDx2HiKuC2Z6Embrgu4eXLqb0CEoutpaKsLWc7V7BG3v7LoUtFqJPwqStSJtK5QsWZlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D+m1psg/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D+m1psg/"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-84827ef386aso574466585a.0
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483560; x=1761088360; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=D+m1psg/0sPA5QUhpnBP97dPq4bd8CQkg3Pfjl/zaOpk19TkocwXe328GVOZCPcJdf
         bdwF7+IjhxslyctHtjf5J4Bbm11EuFY5VAPTLLChUPFzez8fN2e0Zod9GjCK2ix3WHH9
         L4p9WOhLc3SBVfIMcAbMWc5R65PsdBM8o0rCUAzH1o9DlvaM8ILu56S2mFUBcCqELEJ8
         pDfbFHDNvlEsAJWlOKgythNnBcgEbGR1MPesiNfqKBVCLji0Ez0A3Pou+wzUD6cwyqgt
         uJVfBOP67LMupZW2bPSuaWPfy5Yx7m5WjsYovsIzuOkpfH8RqvJfmiQu1R6qvp6wuHg4
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483560; x=1761088360;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=TTJqk/P8WvVWk6N59ASglkZCqbqx3DR9JoCwvCoiggTKTi4Z5z2z85Md4/IIlFQImy
         PB9c44FuZ1h4tsMuQzwKU8r2HZ0iTNwRiEY9F0wV6AxKqruVBKWKIdKHztArxzBgOc+G
         wlDK12WgIj6nJ8zkkROLN+TR5CWiy1+ZZbSlMpW3CNFrS3w9z2NxBXReaOHdEtKqjuor
         +xk+e0RrFFVdnD9UFq9X66X2F++tjku1iX2op8yZOQT2NR83J5DKytKLj1a9jrQxH75q
         8HaP2BA54TY8XdQjmvqFfyDB7IjxaQsgKak/EZaiT2cRjvjP/AUiVZecocF3BSSQ5OXo
         TYVw==
X-Forwarded-Encrypted: i=1; AJvYcCVURw0jhXAnHAb3u7KZ7hUUd3YZvqQi29fFqSJe6YQzJxgUcvDEpsu0Js6IWlJvqsvpg3oDmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GO+MwvigPnWmz6VjUMNsNxKMFoLWsAF1hGZtEhCSHWhrHNnD
	PYi4z5WivqNhaKhpwsJebCdYzK2SdUdLKzDqvXZdeea8XzrXHKs7XUEJsDARcwV5hw==
X-Gm-Gg: ASbGncsNgbdsTuFAlyPdQz1N0zwhD68o9DEfppF+cRUkOyefUB9AR83/1g7RZafy8/K
	2iJ5CjuTaJ997OtGlkQXtlviy3+ZngNf/FmyBEYGuhfX87hjHCN7IGZYOdTpwP9Q6hBhwzOPOm9
	QyLtvxRWzVfY1SrVJAw15qhP7QxzYXiaCXE3QhJ+xQairvCTL35bs6XpODxa9PR2RiBF47pTdcy
	8Ib5EmXyAi4OLOV4v9xTS+s4AClaZmJTxBD4FJOpTEuczpjS1ELsda4QK9rRJPEBPcpi/Jqm4M9
	1pCD1hh/vCRWH1/LEVGetBd6UUQDoZtbt3m3DH0DqVMyky1XO1u0Hgq134n6HoZiruepvB2asL+
	Q6a1hl1rbLMVxoDqatDQcAs/lY6hDLG89med23MwoZg805SzwJZo5lhxUX8fzAuFQ9XWdiFG0Qn
	tj9lb25YBE3oc=
X-Google-Smtp-Source: AGHT+IHHcLVZiMgSbPLG7eY76yfCqa2vB+jpgcP40CTtOHs38xnmpRUGPmtafOl88Gxs8UC/0Ltr+w==
X-Received: by 2002:a05:620a:254b:b0:88e:1671:2e4f with SMTP id af79cd13be357-88e16712febmr95763785a.78.1760483560211;
        Tue, 14 Oct 2025 16:12:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-88e1d60aecfsm23093585a.34.2025.10.14.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:38 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:37 -0400
Message-ID: <846555fc86ec02df31f55935e747a71f@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
References: <20250621171851.5869-2-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-2-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Dropped as this patch was merged into Linus' tree during the v6.18
merge window via another patchset.  To be clear, I generally don't have
a problem with multiple patchsets including a few common patches, it
helps prevent cross-dependencies between patchsets which is a good
thing.

--
paul-moore.com
