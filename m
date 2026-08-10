Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1F441022
	for <audit@vger.kernel.org>; Mon, 10 Aug 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390920; cv=none; b=CYeJUTsbi/ffNTBL+HNXCBBi/p2sS6C73dVx9L2uYVIPUZlMo4t1hzO1Q9pWa5D24MQI8rPHFRTNc29OFH8gk2cApxTkZbmEq8W72qIsDDKoOzPHwpZM7S4/sTnGa0dB7zhEhjS8o5IFuDpyX1xeOFB1EK4AV5oh8YmUadF6XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390920; c=relaxed/simple;
	bh=LOri3CcuBtdSvAEYFeKTd1PeW4G632pF4oItWhfE/Pw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=blqRAlLXnlBeqknwUxj8vlsIXuqGWnu3slA6jEQT7Fhjm8FLm1pXCd3t3Z85MJ4kgh1MOHGotI4cygkuIYSpRyFq96iklrAnZBKdJwzB76hOGbTv29Rr/At59NAmdrL8GfDysCpz4bl9qrVHMlNTtTqo/DP+QvO+hrrYzFIFE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dgxzB4zK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dgxzB4zK"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c149c5722so2593251cf.0
        for <audit@vger.kernel.org>; Mon, 10 Aug 2026 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786390916; x=1786995716; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vsd1x7Iz/VQJIsN2hgBouGDdRtwtfDh2Zexev25G1Ak=;
        b=dgxzB4zKI8coAO1aT0pFwxfat56Zm5zt1gevfiFT3TU/hSJDhqFvnzP2B9KbkXTomS
         cU1Y3PIXTk1EgUa11NJMZcNki/kAQEFPu2l+MugzfiYMkFVbwUvaNcGKdCJ6A9fgg9oi
         6KVyJ90ygYkML+wsvi5jkO5PyGATs3PuCSPpoiJtbs6s0AXa4mvMqSJVKpGj5PMpNwMb
         16KiBTwxk27BL9H585nqYDt9vEuVMtbdrRKF8wTdi4SGFlYlKkk9u7blK0sRJHVOxnnu
         WJdOT2JWiuVyIdl81mw/GIqdJdsV0l4K/SaaWrIhndTJG703QAkFU6ZlW6M05RsbGK15
         LRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390916; x=1786995716;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vsd1x7Iz/VQJIsN2hgBouGDdRtwtfDh2Zexev25G1Ak=;
        b=r5yCst+ojJy+SRUcKh88kAp2a/JFSLNdzxCF7DphJGY1dAnhNkMq8qwpvyXaTPADqF
         sdU1OErBrWaK/gTCtYNRPbLPPAHmodSCjcaWJGMAYygWm742l9YecOY+1czKpT5bw8rS
         6VsRl2g3i7rmG30HCEgIO4qz2wxaQRUy2Aq2gSsGzMuYV5KUMk+rx8768h8k/2267swH
         yAAnM3OO0eMPLC1ltV8PsiYnl9Yk2z08M2cOBs0l8L9RUvI8kzsReb+epPF0zpvVR5Ty
         9ldo/CPhOzxWvKOdiWj0wKQbvPTyNRsXPFmrANHCcDoOdVJL1rM3OzKwDZAvKvVTxPkU
         2pLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ZVS0+Eo+2N9ybYoHFAWD5YeBeZeNxUvtjzDzVGvoNt+APP8jnM+Bz15idro17wzIdZ2ptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AzeV6tlp7424u2+idUVvzMJ+Dbg5siEa7zxk/BC7gB48Y0fj
	jmw19dEg7iOjIig81tduJ9ZgIEEvbXwS4jNTE2bdu+Ymw6kK9YpY4+ZzmacE9/0ISg==
X-Gm-Gg: AR+sD11pGqHGHCwHN2s+R5R9s34URSjpxIZnh0ZiTr6Ch74QSt5ZVoWp8rtrjzaPFhS
	+PMvAEcHunXa0Ie8wy69ajQmwBzosnuGf0pTagTnJBFadqKiUk8yPrkRjX/3OiwL1eTqWLpZTC/
	/no6XMUvcrDffVmsFLBPKQAzDBcRo7P9cYTqXtgtXXjnJBDEgBp3hzIwwgo2J1QSNZH60mExEJb
	JEPoGHX6JabAyOi0PUMPTVXBx17ukJbEORHQQfeuSwLEybj6SMlCue6I2P8pBHpcH/1cg5S0Oif
	bweoMF3A4HRSwbGcXx5CqDKO65K4kzUoMY+J2RJelvtTgnzkguOPnvFFx1LYHSLBtzm/uK5VZND
	NyX0+7dnboxEdrigzfVp9EfeFe6447gTPG0j9cqY1NBmacjNrfpyFTalSD0xfGptovP2esd8uO3
	1OeeC5KayuDJPSAquEl4WRHqXNkK5UOcCSNCydlh7B7ExqDZEP4Wg7BysId3srRs+5if4UN5Ekj
	ln+wYJlfnBDsWLFj8qp1EHGxuS6UwBHUQ==
X-Received: by 2002:ac8:584c:0:b0:516:35fe:5524 with SMTP id d75a77b69052e-52d5139f5a9mr11184741cf.5.1786390915980;
        Mon, 10 Aug 2026 12:41:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a91e2cdfsm79012536d6.22.2026.08.10.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:41:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:41:54 -0400
Message-ID: <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260810_1522/pstg-lib:20260809_1908/pstg-pwork:20260810_1522
From: Paul Moore <paul@paul-moore.com>
To: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, audit@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the  current task
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
In-Reply-To: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>

On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> 
> The `cred` field in task_struct is currently marked as __rcu, but that's
> not true: It can point to credentials from access_override_creds(), which
> do not get freed with RCU delay.
> 
> What actually protects task_struct::cred is that accessing it is only
> permitted for the current task (except for setting up a child during fork()
> or tearing down a dead process).
> (There is currently code in Smack that violates this rule, but that's a bug
> and causes UAF, I have sent a separate fix for that.)
> 
> Clarify this, remove the __rcu marker, and remove RCU helpers from all
> accesses to this field.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> For context:
> There have been at least two UAFs of struct cred that I'm aware of, both
> caused by wrong use of task_struct::cred:
> 
>  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db7
>  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26@google.com/
> ---
>  include/linux/cred.h  | 17 +++++++++++------
>  include/linux/sched.h |  8 ++++++--
>  kernel/auditsc.c      |  5 +++--
>  kernel/cred.c         |  2 +-
>  security/lsm_init.c   |  2 +-
>  5 files changed, 22 insertions(+), 12 deletions(-)

This looks good to me, with one small nit below, but as we are at -rc7
I think this is best kept until after the upcoming merge window so it
has more than a few days in linux-next.  I'm going to merge this into
lsm/dev-staging with the expectation of merging it into lsm/dev after
the upcoming merge window closes.  If anyone wishes to object to this
patch or add their own review/ACK/test tag before then, please do.

Thanks Jann.

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..1328a2ceef4b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -476,7 +476,7 @@ int __init security_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
>  
> -	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
> +	if (lsm_cred_alloc((struct cred *)current->cred,
>  			   GFP_KERNEL))

Just a FYI, but I pulled the GFP_KERNEL up on the line above while
merging since it now fits.

--
paul-moore.com
