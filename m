Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F4524F
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927443; cv=none; b=LK3kow7Hg6hWGmKgV7qtZYbVlS1HbqTY/xLGM7W572DwtgObAGVO+vkA5F+jER+sOdZy2Y5zM/lxVsIixKZDk+heQWwJIH826TndGVxxyVErcx7akPeJv8j3xlUHIchFlKvwGQNTuLBHVyLP7GDoXZdyvIcqJtaq/zduCjLW9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927443; c=relaxed/simple;
	bh=80pVOvLhx+Wdn2FQlmGhXjRbHTitdSLioqC2O3ubCNg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Wggy07jqFlFyFPuwMWMKwcKwP2NuZ6cWCfxT/k+zLonwfhEmXqGXAi8yHuNrO2TSm/TTCbPaoRJctzhpuuhhSO6V76hDBX5n9Kcqk+H3qQa0zUvttQG5N57Xto83zLLaaFYP+zduigYd/gfEx1ZBWSvBlAE9kKxGwqs7UN3CnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GsgTI+hk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GsgTI+hk"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efb708b1a0so7951116d6.3
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784927440; x=1785532240; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhsc75Oo6AuEhvOwEPNfuq0mbfOFTRMSybKBRxOVKlw=;
        b=GsgTI+hkHZ8VmqwdycBolYwd8MAMkyuNZF/A+K2t7KBqJqUidBRThjwV7HnfkkibJ3
         msHHPvb0nmhZdhv/aRTscPRcdzMN8oeCnxagwJaEcH92q6e7hoIvhwME25JXHWLZ5TCl
         jR28bKTd8Lf/tx2+68pdLvrj0wGa+iTL8/J0QGnp9o4gjP/Xld9auKLLAYliAk0cC290
         omly/ZMeIfggI/rX5DEGpNlWP0tZKJlOasvDJ1wVXio26fN/InyVJFwuelEqfyjxADTd
         lgdMOZWf7y1au3iqjPRQ7j3HgDZHROLtt5/PTfiP7lUKO6XxryOim3mOZ+dli0rgwYSx
         1K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927440; x=1785532240;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhsc75Oo6AuEhvOwEPNfuq0mbfOFTRMSybKBRxOVKlw=;
        b=I6gYkSdFV+zIqjuIqQY4ctQmoKJX3LmP9sp509dlP/Ewcm1h3mqoxhNEnI/TDQShEo
         pENQQh99TLWTo0cMT9didau4y0+36Dx8rrX21mHsDhyVqBrb2P54fcSB8WH7C+HFUx0w
         ubrL7ng+pWnycUgmJxOfjVNPifemSZC/zgnr9rtZUMTRL3V3DGvFN8oLO6GfXC4IGlcX
         Qy1aaPAtf/IUW0FV1mv/1dS1iOyxUmEIAhnE78jmAFuhd0M6JJ1vRFF8Xmq1qq3fqIdh
         f2gTZBwCB+HlhQgmnx7zGhkKalUtu41KJZEWu/eHrLUqWWgrhCDxzupQVOCIfe/d6LPp
         1Rvg==
X-Forwarded-Encrypted: i=1; AHgh+RrcRDu64XDR9kxcGbRkOIAub894mrHhyibmI2JEQMn4HFMxz0NQA6/jJiJYGPN8It7VluU2JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nZejRiuruwXw5tDEpO1WNt0iJQE1913xQv/QvZifrDn2szp0
	70UNkVd+DPEzNeAt5dabw2SuBhddFQoQCkKkmSrYRyNmatCTIPqlR8V7hyrBTnAamg==
X-Gm-Gg: AR+sD11SjA+5tcc8g2iKG+PhoRBdEknvZCV7DTpW97/sD385fKloJwndlU5YXboohHP
	MbKaeymAEYgQSyzAi7hOCgr799/DkL0GfzuAEXjHPa32wSaE0PUpYQzBtGHSZom/hOQF2JnalqR
	eUjv04ND3IY8WEN85ImvajT3KLBbB86iT9S6qFe73fnPALOcuDfXWo+TY+bNnSgnigQBfRNC/NB
	ii+m7d5FLD7Re0FGut/YWUgYQZ01drJfBesxcpzpWy11tRXvEiKjSMgTmADXqYKTWiC7yKyh4yO
	N118BP8nUH2fv8vw8IpC8S2+bNh/YjbfO3FNX5eEcrS9LwzZ2hILx9ZqAVtWQA4zW15I+5SutEJ
	DnzS3ayfBvt9C9N1nP/ogKaJVwsyuNHX0o171ZrE2t2Dl8ixJnO/XfDv7mck6XB7yea8ehidwzq
	X0ZqcCEtO2Q/JGzMN5RG3nz4nqQ0MUTk5o3GSdCu41BdCxbRg=
X-Received: by 2002:a05:620a:2915:b0:92e:7ba3:740d with SMTP id af79cd13be357-93103a568cfmr1043858085a.68.1784927439959;
        Fri, 24 Jul 2026 14:10:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de676a41sm5540085a.46.2026.07.24.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:10:39 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:10:38 -0400
Message-ID: <0ea73a164fb2397e58ae28a2fa35266d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260724_1628/pstg-lib:20260724_1535/pstg-pwork:20260724_1628
From: Paul Moore <paul@paul-moore.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 3/3] fs/namei.c: update kerneldoc of atomic_open()
References: <20260710164233.827744-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260710164233.827744-4-jkoolstra@xs4all.nl>

On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> 
> The comments above atomic_open() contain several errors:
> 
>   - atomic_open() does not return 0 if successful
>   - @path is not updated
> 
> Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
> are set. Change to a full kerneldoc.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
