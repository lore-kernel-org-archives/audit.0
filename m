Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6E2D5A01
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268430; cv=none; b=KQ0rQOpjaKSh5OIcyZXnAU/co2wd6x8xV0/MHrTWSxW2CTY1JOljabEC1nWhDcTO1SvNbLB4cMbggfLdZr4kb9gWpTTbaN2g7/crh/17awp6jAScBl2yxPImDUAmNyXe1jIM6wsIymN1R/6gIuBv94u6dvkAmHL1f4n/eiCTLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268430; c=relaxed/simple;
	bh=pOCc5KHFW5q0Mst1x++Sl8Mr3M3l5xNuWsT/idlKrus=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IjOhevF7/wImq05hcf6EmveXg7SPwjtmCHQV/72Q2MNjAuohE5xDe++awlAvWlp56/w2N56eEkNLJgIYMtwaHCmp97f4PIaL3xvuPNkH/FmxDYP+d3TUtFmoJWHh50/wjk94E9LbWtT4TJh4Jw7in6VZe+4+rLjb0Vg/s42GDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdUmedqT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdUmedqT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5c9211d2so24014785a.1
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785268427; x=1785873227; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlIY1L+o2+XzlIosk/mnO5oYFQNniFpsDQXDhKoVxg4=;
        b=AdUmedqTYF9Vw1cncq2VrSVwcHUgsB2TIadX3QN3STImfZNK3LIeGnrd1ysT2y0SqM
         WkTPWYK6s3OOMfEs2Vs6NllfBbw8s94WzUtkKOIN946FRHT+o9CYydYFAxepfs8B5kOV
         8FH6spBJUN4dcjoKxhEMugU5ZCaCDDTUjF2no/31exldu2dUP4aknbVOjKEXSxBFoQxY
         eBgzAsUFBFWu4q5WS/UR+2P2jdaNGL1/9NsQVAwzPIlqNL2y3URFu7Gk9XEXQsuH3yD2
         5bqwg40oQAAG2nVimjmpKJo3ZTUqrLTin/n+YXmse8HwQHSvz6bUJ3ybw/1FeOdn7yAh
         y08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268427; x=1785873227;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlIY1L+o2+XzlIosk/mnO5oYFQNniFpsDQXDhKoVxg4=;
        b=JVIkzzh1msgnCsbOnkMEDLqCYzRxUEuRA2O1/xS2WmQp/yjKrSxE8xfBVFJrpZ+DaQ
         5GZX2tqyMUB9GeDSGz23TjH2Af8o2nN0iNsYvUIiJDrmS1qemyMRIhbmcs0E9Ue6s9Zt
         CGBxUKVgWaw04q9zeMn8b/fGEZujDcR4dMsXZqq0mzRyH6AJnn2CNV0o9V56ivEtxOw/
         v5zUh24gjCi416zj/lQgfbsOesJDX5JR+vUs6HzllW5CaSHbFxkjDjYUK9ED5Ibxm7X6
         CAJXQN+k8BAGKza8CKVDzyYnTkMl+sTUNtH9uavA5DetdMGA3uP1k2I2G8XC+pAlmCcc
         /qvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9gGvorcn8FqucHZhdbgvDmi4CPwh4iN7DlRp923kQx3mi2w/4SLSiNHddPz9OGV8raUqGcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xCG29MOMpoBoR3VHF/IwSEVvajyXJzX0z/30YJbvIbvX0B61
	HzGhbrtdTmZRGoORiBTyFPUwlT29cw2pVeEYSyfA2wBt/FqCGreVhFbAIDgg22BzAw==
X-Gm-Gg: AR+sD13bX6bwsbYHra1WkWNRidN8MSJdp/PgunI8PcqLhPsKHadbZStQFS3YMzCygxE
	Llej8ua0VGh5vuk46KxNheuDKBTgdX8unNUeZPVZ50j7bv9C9vY9atWhxsZZOUsykcHMuP/S9mk
	XFNKxXrGSZ1DkmySlGjliiymytVCRlj840K+/bARcBEZ0XeBFH06dqHMGEo6s4/BIpTk4eEOg6D
	2j6UEJxFAJhIn46+GCknA+EGruTvOt7V/TRV+b7sGtWFdfHvHcgbsudQxXfrfD5UydrM3BkD9b8
	3nR+hoRba9pdmqZuwiaNZ7yzidm1eB3pTvEUc84uaYUeGqBMATG50iqkTJvKE9UWHouo8JfnBNI
	L+/GMbMT8zCEAvn97I6zbfdfHXeyMyVbHmOAo0zE5KwBMG4u0MUHIw8/jNSdP9KInqP3ODOJzPI
	rGQ2pcHXDsZiKyjax+PTW+hBxQRMK996ZLK0+YQVnuGeTG6Vsi4/7fG3ihgwTqlegJ/M0BwkfPr
	mZKk+mYSrkL0YS0ir4n0WqeRXPo8qvMuA==
X-Received: by 2002:a05:620a:84c2:b0:92e:62d8:1faa with SMTP id af79cd13be357-933026d2e90mr369668085a.46.1785268426765;
        Tue, 28 Jul 2026 12:53:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7361dc2sm5194985a.43.2026.07.28.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:53:46 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:53:45 -0400
Message-ID: <176efbd2097ef7b8a25b09b5e1f7b2de@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260728_1147/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 1/2] audit: drop BUG_ON() from audit_add_to_parent()
References: <e0e6505a3f80912216dd834d25f330b818d73263.1785246707.git.rrobaina@redhat.com>
In-Reply-To: <e0e6505a3f80912216dd834d25f330b818d73263.1785246707.git.rrobaina@redhat.com>

On Jul 28, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The BUG_ON(!mutex_is_locked(&audit_filter_mutex)) check in
> audit_add_to_parent() will panic the kernel if the mutex is not held,
> which is too severe for this situation.
> 
> Replace it with lockdep_assert_held(), instead.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit_watch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks.

--
paul-moore.com
