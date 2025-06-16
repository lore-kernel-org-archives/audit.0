Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C322877CA
	for <audit@vger.kernel.org>; Mon, 16 Jun 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082150; cv=none; b=J7uNyPmih270GugTZG9qKavd4DNJEQuw/8g6tObhyYkHI26C3Go6OX47l4i9cwy37jqHu4FaIjNkC6nyK5uaE/8a9LLF8c4oJMaN5/QObrPOsVTS+S2pobqbxdCEPCmkUBefSJQDUqPCX3BgM3fVs/dJW8dj7aWlQXTR3fD0uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082150; c=relaxed/simple;
	bh=3e3eB4muD3EpvcsC9L6Q0h5kVqMreAfRRRIj6lFfMjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkNpldkJQM5D6ymBR34VHFanDuO7eyMF+U67SFQjje+NoEIlFczZrjrFotwWy2FIi/ivu480LNOozGppB+Z5SoAFxkP2J1faaKICkcX0L0UlOSyFrebklkMxCTEvzZWAQqVA7ZR0H77Th8KvMz7IWsvZMD5TjNbJZoxOv4bgzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C7l26tzL; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C7l26tzL"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-453398e90e9so23129755e9.1
        for <audit@vger.kernel.org>; Mon, 16 Jun 2025 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082146; x=1750686946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CEry3X85ozS8Z1Uce4c2f0+5kW2c09B3vCuZTGfDKo=;
        b=C7l26tzLFY5+QVD/YWv8OeByVcL/rij7VKbuSG6HHVkkbJ1bgwW5Nk04x5Jnve+EVW
         BTcOJmg4xdlR2l4xpETxks0jzLyCqQ9jY/ev4NPYmd7KKzrKMli/BOE3Al59hc5dKb/f
         0lvV3GkWo1mwKswDscEXSZLhcz4tLp4ZrkPKnQSYJb0vbpoPmbqaeIdF320MJIxpbKPK
         3cxNkaoHKULtAfkhnuOPLuo0bk+KZNdq+rsg52rLEtwqljPzCVyEVVxcsgF46h4f537m
         xCutLZ8fDE+wPP4MK8StfmGU7hT31haYfeos3jTXXs3Q16Y9ai15FFkQa+sUAi0I1ab/
         gj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082146; x=1750686946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CEry3X85ozS8Z1Uce4c2f0+5kW2c09B3vCuZTGfDKo=;
        b=OeQksVqBj1SWswGD7BQQMJzAC50CxmdbTShvA5fDk64/FbGHpmytLESb1XrZf7IKFX
         ofBiwT6h1LNJ8+oNFddwcqBjG4xVTtiqdr3ag/obOQGDPzwmWvam8y+ufZntOF4pGpFQ
         UWSO+j7uvRtD8FJArnzHNstX6YmEN4n3785BqIAF3FMfaAB622Ea1gCfFMIAvcVTS9Fv
         W3oZui5h7NvYl/Lqc7Se8o8wIfJ/6PwWmr3t07zbcnu9Xze6Fh8IU2kRWaRI6nXrBVcR
         iAHrRDGYIj+ZRTdZrmadRLGcB1/7DSAEypBrKcB9BR3uFvHrLqu04wG+obppmzIqm7Om
         Cwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUfGsHE2MVd5Dh6Y7pjitk3OHKGryslT3uP88NuPozXB0V5r+Vm+bPIEaBGz+b4Tt8EHXwLyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WXKIHW+SMUsiKzwvhexvhvSXB95uKb9gD1AX596/Kst79qPZ
	B7FPhFvDxdvpFHJwPYnl/VgmkQFTQAaw5DbxX6zPbyxq1Vz4dZe5xjV+SdendVDbSaI=
X-Gm-Gg: ASbGncsnXfKh0+i0PkzUydfUmJDK3yRV3+GTHeUKOEwvPccpMdXIZ4fRhvofm+az7To
	8Wv4o9u0gA7IhLn//9IUMo7e6QsYZZrG2uYsMjpq3cNFkNDWOJWZSKMvTwNw9tCcUtx5A6aqnJs
	gaL+42dt+MrXHMNXqKomQZ0XwHxAqiEm7hSyef8qn8zpEGiE6hy9V3u4l6s/UCVJmbWyS9sKBaw
	7k4X36Z8BL956om1v1k1WHOIF8Q7ai+/xjzF9TOP3T+nGHiJkwZlLdE5VY9BFpZbBkDysG3j8ES
	VHIMldlbvn7e8/e/3d82aHqKR5K8xBx83omL1oeCT2bmW0fwfTn3XW5oelOsD884mg==
X-Google-Smtp-Source: AGHT+IE7aNvrL801nce5K/gCd4B0EbDVYCJl9pyUvZAsnQZSq9qyx+zKtCFrtCQyL2xM4CQ5A+4QYA==
X-Received: by 2002:a05:600c:3587:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-4533cacf27fmr81249365e9.7.1750082146044;
        Mon, 16 Jun 2025 06:55:46 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b19b32sm11311798f8f.67.2025.06.16.06.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:55:45 -0700 (PDT)
Message-ID: <e12739f9-bb54-4e9d-b70c-f4b5f99a7920@suse.com>
Date: Mon, 16 Jun 2025 15:55:45 +0200
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] audit,module: restore audit logging in load failure
 case
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 Steve Grubb <sgrubb@redhat.com>,
 Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
 LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>
References: <9b7b21e5f37f5718fe9176a36ebf670bbdfdd54a.1748462545.git.rgb@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <9b7b21e5f37f5718fe9176a36ebf670bbdfdd54a.1748462545.git.rgb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 9:58 PM, Richard Guy Briggs wrote:
> The move of the module sanity check to earlier skipped the audit logging
> call in the case of failure and to a place where the previously used
> context is unavailable.
> 
> Add an audit logging call for the module loading failure case and get
> the module name when possible.
> 
> Link: https://issues.redhat.com/browse/RHEL-52839
> Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Looks ok to me from the modules perspective.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
