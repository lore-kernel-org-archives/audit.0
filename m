Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E8280CE5
	for <audit@vger.kernel.org>; Tue,  6 Jan 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735751; cv=none; b=YBc3aehsEA/1Any8uyA+kBLZGg/Kz0buRO75GHGjsTHOzMQP+j3HG+EuKdQvktYim0UmmYV5UK2Cz5tywvjmKWbvT8nOQY+RXRnUh2tJZjmRBxeICwsR7hdO1oOfYtEfMDGwOhtw28d+YnBgyO4mBJpOIXlQb9t499cDYZG69eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735751; c=relaxed/simple;
	bh=NwsMZgLdX2ewxYT8qxsnZazbK85TBJwW3uwLTOwncMw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=NXSARgaGLF5zFrjM0UY1alnzy1f+kB44S+zYqbQoxEIthzxlyvrHtlt5LuZ77vmIxTy/HHyUVtMQu3RkSB7v/ku3O0EGO+xvHRTl9CMXDUJc6wGYptbZ+Now5lRX5FIizmwOw6TeQRpwRs8RGD/D3lurKXZxarTIpogQhr8HVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gaWE6t5B; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gaWE6t5B"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2627269d5so150710685a.2
        for <audit@vger.kernel.org>; Tue, 06 Jan 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767735749; x=1768340549; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S814f4ADVgreHBtWuvy4duDQOAEx7yRjhKLWh2dMDg=;
        b=gaWE6t5BEohFu5oLtzEStJggMY0ARTZ0rDjxojufmsY5dLHppCZt6L1t7y5SS3syWS
         0Ezt6/Z03NRjTdfMMnT9FPCftgUgsfMoUrKJu6Fyu92SONQPNhHTPcNs7iaAeNB+R00Q
         uUPZbbcmf8hUzMrsanO+7IsScbr4+QVpaOKeR/gmY8y02afzfOX082vOBpHTgN4gcApl
         4rNcrQnL24UeU5tzGQ9zCS1ztd3CEo0YkAkuttSuTJ34KSjNIA8ktYEB1/zeAKO1usBZ
         HhM4ZQZKxWnJ2JDwyi1nMtTzMexYzj7FTJuxSknBos+E1mRFMbWsQXI6DhAGWAFvjBTo
         xI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767735749; x=1768340549;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S814f4ADVgreHBtWuvy4duDQOAEx7yRjhKLWh2dMDg=;
        b=cnoEY0IDDronuhm9GLYQFhGIHTkZ1+8NDCkrT9gdeW9a5dKEFmLfeCgQbyDDQSi49n
         5uXaC45Hk3MBDUKNC32jeiCuIIRx/wuzYxlH/g1UKkbJ7ZPzyh2usaZVFNdgdkkVDFtA
         vgjJJZ2iozFwHgF2+UXStJaSOn5RwGevmlPpu6U8YHuEW3gOCIP6cmxI4/GhblLjCxnW
         k1IeqFFzbqovmhiY4A5cyZjrUN9gBJ4SYzjydMHbk40tHlZj+ixFGZ2sNfVb2eSbOiNm
         N173Z+Z0xbz7+q8g3G5+syqzz0PfcWIcJsI1KlkYb1r/z1AyJeo0Zy4pxwua2cVxKZCw
         8dnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgokjgoPeCvrC2Yt1c7oDvFVfiFX7iFK70zraObPN4KCOX6YyT4313ERTMbxNYKZSTyIY8ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7s9vsI9Av31suS9h6MYppMpd7Sqv8PYjZUj06F0dsHYxlMjO9
	SLobL9ofdi3yLTypWsy4RJEvap61MxvdwF2UTqsdGCE+9Sj2kuyunjaSTuQtL0cX9g==
X-Gm-Gg: AY/fxX6XRE2rjibOg0UXbZf2o7rcL/DfUjbbMbFn10OGplMQBhlh+XCgmXDf7bI630g
	yVCP3tu93A/mxgamWl9fXwCk9+FIxH7oDWcE0SK7+e4g5fDeRFg8YXUdbHTSb/c0Ap1FD9m9v5H
	5n6huHA/fXNQzuDscHwt/T6CVJDmQzCT+CGoB3rLNuY0IQjLX8JITnMOrhpMorLKCOxwU9knShQ
	0jFKj1NpSMexDd4QhhRVhkP3112lPWhtAloL9OGPvNay1ZVQO44CDJP89AcFVL8ZbBniBkGu+et
	Ejdr7YwoaiDlyz27bSaCVvMLAasb3bdO3uweHVpxN2O8k5jWJzhQ5nzU969KmIV1d5xVG3DJqzb
	ukTh2N7xc4p8vyUtmVuH30Tj7bkIzwfDU8MCm4qgRL3S0zAR4/n23ytR5CmYzRh0FKzn8i9ubLv
	iQZaS0sMYy4YKjuu+4Zp+dNHZXRDo5H+dpHo5ZdBkk3V1Vh26UK3LPQ5Yk3nJchoBAICQ=
X-Google-Smtp-Source: AGHT+IF1cBgrXHb+mkNKqgOw537QmnrcGZDgb2rpqVvqc0DXyfy5FKBcdCiC3g+w+kThYbyheS9VWg==
X-Received: by 2002:a05:620a:4541:b0:8b2:1f21:ccdf with SMTP id af79cd13be357-8c38940926emr39579785a.48.1767735749174;
        Tue, 06 Jan 2026 13:42:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770ce659sm20902116d6.10.2026.01.06.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 13:42:28 -0800 (PST)
Date: Tue, 06 Jan 2026 16:42:27 -0500
Message-ID: <7ec1d6a0e0810fc493b38ab48d872a54@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Bencteux <jeff@bencteux.fr>, audit@vger.kernel.org, eparis@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: add missing syscalls to read class
References: <20251227083924.6549-1-jeff@bencteux.fr>
In-Reply-To: <20251227083924.6549-1-jeff@bencteux.fr>

On Dec 27, 2025 Jeffrey Bencteux <jeff@bencteux.fr> wrote:
> 
> The "at" variant of getxattr() and listxattr() are missing from the
> audit read class. Calling getxattrat() or listxattrat() on a file to
> read its extended attributes will bypass audit rules such as:
> 
> -w /tmp/test -p rwa -k test_rwa
> 
> The current patch adds missing syscalls to the audit read class.
> 
> Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
> ---
>  include/asm-generic/audit_read.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Merged into audit/dev, thanks Jeffrey!

--
paul-moore.com
