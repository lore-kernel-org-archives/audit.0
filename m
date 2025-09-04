Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669412FB99E
	for <audit@vger.kernel.org>; Thu,  4 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998396; cv=none; b=WkpGYOpDqTAdalyojqTrgxSt4pUuQQqtwjgDamWp++JUimvNcb2spzgz01HgxdGCNXUciumtOPjIRO3hMutPIFuLrVP0xobhIeh01cQq4OafUTXsPrrVTJ36YSSQAu1I/qz5bxYr7nsr+YgxkVnIuATrLkGss6YbnS3Wd1/AV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998396; c=relaxed/simple;
	bh=GjIMhldMZjLi/k1VMDA0uSdrpQ2tcOhNKetfFoIFYTw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=i84kbm1zb8ytpJVHplHIZSSIu6RL+51qBfwR9hutUo9sWTOM9xaMVJkWZcgeLg+Vg+fD5DvJTR4rhltUg/7dWo+xQF53274vPNE07Mg0veDcxPyIQOD2Y1RmnWismAa+W5iDWVrYUgyqtwP5GMqvonn30wOUG43YrzUW1dDQQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UmgIrN24; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UmgIrN24"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80e33b9e2d3so101230785a.2
        for <audit@vger.kernel.org>; Thu, 04 Sep 2025 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998393; x=1757603193; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=UmgIrN24bZcnKDgQ+hfbmlbI0EQX7VCiJ0iyk6Ht7loHlFNEh3cSEFxt1ZvIsQOUZp
         61rke9doJgKSUWbMEJMYeLPaOsdJvRBpdys1a53xdDMMcIMcdFBwg1V6w37X6zNxMQQD
         m3YGJ/jWzQA8fwaoOVfGDUQTEqtDZgznENXvO6I/KyW+bV2esFgYkKcDcCzIheBzXICQ
         c4XlQhhGBy9+fQ4CCPd+8k83FzrlLRomG6JUoNdYqyn5fAM337Pn68z8FTLAtGOxDD3R
         UJ1xhBPlWvEMAXVyicR16D59bY5BRqTotBv3p6JCgsy8D3MZpuXnOazdo7RH+rDO2+tr
         G/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998393; x=1757603193;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=qx9dj3hWucbjPU13j8j88cAWGnNjgKZg7kEdF37xLFsNbwadzKqHbv7MTf8Y9Adg1e
         n2LthDTVloBoQD2A7JWWCNKLQa2Wcq3kVXBm/+VhhIAGTrZF2I1qQxwamnkmeb5QtjTM
         M1WC1m2IaplUQJcF2HRLmI0LwZhll6PFLIxBBZEH+z5oLwsqysxtI/bsMwNgaf00WZWo
         CJeQQAsRI3bnkicx7RiKaMjDelzWO1+oMRGJknrq8Q8tBsf8d34MJ+U4allCzYgVYpb1
         p4MxVBid6aVkt+nE/blLqj3jMWkSRunD9Wvb8fDnGIFlCZsLDmO5qsw896dgwZd8ptl5
         6cTw==
X-Forwarded-Encrypted: i=1; AJvYcCXeRaBRlkXfnIvJ4yzl//JdTK0L5ON56ErqmX3pHOVSPY22zQ50CAIhahDhnxzpV4BZet9knA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrq9dW5zexL2wFnUf3+i4M9YdawAwaXbZ667fbb8igJMQkvbe2
	bDrg1l2KFuAYCN8zm2+gC8nbIFESqlJQiU7OOOGUkuxr4+5mvmjwE6UMedPQObNJDA==
X-Gm-Gg: ASbGnctWrFOjF21WsagsjdhDJY6dzvMcE63sHREQgO7cWKJV/39QCPkd9DDXuKi6yOX
	MAhdp9cENTKyKYH+nUx0oaumlLGD6lJ9XJG2w2gFh1Sj8u+RTV6Rt88/RCFwASLpkSnceejHGxR
	IfBwt/4GBS8s8aJtYY5KUb3y5lgwtEGnIJpSEMgarClabxAZBiUo4tkGUW7fXihsSgAssnQ6K+P
	WWODOJdVnu+55vuKNdTRBV8zrg2U9WEBs5iy9vC5NwKPBvaOHoyA+Vewz4dMKrWDoTLhMZ8WdAq
	eEc+Lgvycvnc0vCwvkjtnJ+n2OCsf2WZFtOHJ2vsPgWEZlOMGFiDqCriqzI7q5PxTgpjQHX84vq
	93I/3qR83RHyWmSdFPxs8k2bmJCUqhOH0kEgDqSAkkpnnlBSkWPeidA4Qey1BcwshZyYNiGFpvP
	cOZfg=
X-Google-Smtp-Source: AGHT+IHEZYUVpRQ02k7NJUaQish8Bi6v9XojrzC/OeiOZRuFggywJiau6M41XffV1wTKoVjcjfFHig==
X-Received: by 2002:a05:620a:1a81:b0:7e8:14c:d1a9 with SMTP id af79cd13be357-7ff27b20216mr2265110885a.28.1756998393152;
        Thu, 04 Sep 2025 08:06:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aac237b51sm289724485a.61.2025.09.04.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:06:32 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:06:31 -0400
Message-ID: <cde565adc43452e83958fbe0ab54080d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250903_1606/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <edumazet@google.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Subject: Re: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
References: <20250904072537.2278210-1-edumazet@google.com>
In-Reply-To: <20250904072537.2278210-1-edumazet@google.com>

On Sep  4, 2025 Eric Dumazet <edumazet@google.com> wrote:
> 
> syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.
> 
> We need to initialize ab->skb_list before calling audit_buffer_free()
> which will use both the skb_list spinlock and list pointers.
> 
> Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> ---
>  kernel/audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Eric, merged into audit/dev.

--
paul-moore.com
