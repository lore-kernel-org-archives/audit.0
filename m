Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F88130AF6
	for <audit@vger.kernel.org>; Tue, 22 Oct 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639013; cv=none; b=ZQclk/1PGJmQuxLM3w+/Q84E0kIRCKLYwW8/IhNg1pFyhYDUnSULS0FAwaCgWcR6ocyODgH6LQkJdVbiddu43PSdxmYAmnp8INN6qcJbgc3ehwUKcIba1zuXq9s1rq8wg5JALWW8AuW0bP9KQQ71WTLa7V5okwKnfDjmYKnigsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639013; c=relaxed/simple;
	bh=OrdoYE0Q6ccQ44C/5I5oLyobBWb5jRhLx3nEH7xAUMA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EBA4B2JGvODyzNK86MRdCOIpaLDhgH6UzLYURibVvNFOLZfydVqow4oAYSc872JEUZCcEIB3m0bCfZbyQ2IPO6ggGyxYPX1keQB8EXIBPpHj7SjENP4N8y04bmUkm8LufCRV4wpkIMFFWhvN4MS3fif1/QLqWkj2l7EsIz6jDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QLT2qyqR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QLT2qyqR"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460e6d331d6so16015411cf.2
        for <audit@vger.kernel.org>; Tue, 22 Oct 2024 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729639010; x=1730243810; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdRK3yhTYghtJWmdnw+e7xLJLXdLknBEqJe/TDxy7I0=;
        b=QLT2qyqRlnLc1udGb/GgyXkMYbCGuaktvcNdSGJffZUg5jwk30sqCZlxF3tFa090Tv
         kjFyGiZMn5uL61oXUarJsACH8ihIIXYx+3qmEyzNWQzAtPc6z851GOyo1drCmeGJgNHd
         W6U3FF6YRwA6D5sBusLZU+ISbyhSFVKylnuxQaoLXSOIEKAcL/5/V9pvUWxV1i04fGnB
         jrcsgsS+Vnd3Zcx44zI2VlLj/aaYcDZ7qmYRHrM7v+q4/RXM0wZiVH46tST+ZxL7Zm5a
         KqGYDSKho7CaBDSvAoZ5W9uQIqH272ZCYhSZ0mjA6GgcG7+4uMqKh2hmRO0JdTkPgWFy
         cuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729639010; x=1730243810;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdRK3yhTYghtJWmdnw+e7xLJLXdLknBEqJe/TDxy7I0=;
        b=aUNPGAq/Fzx0KGQZbBWVJr6CBqvzr1Mi9dX1LgRA0AR3u9opYkRqOgZR3UwPHLHxje
         eAk+iX92S9iIKaZnQ1+p/6PKBJ+ADUriuDQM44g96GbDm7Om/rnJfSlYkuIpPRJr9PzH
         Rh7kiUs9AyoU6/IeuayjvTIMC6nm/1pCgbDRl2FPmGMgRKabL77MeKRrhfwZL1q19vV5
         4EsBu4qNIYMq5aRiLKZsTViQwaebhVSoqr+ulwLBofz2p3YXy0eIFWrPSzj3Nty1bXFN
         7mt7YuYydG7hn2cHdij5DvlzvezOMSIC0t7dT4kosY5llTcjAnSTGxiLzRmTdA+m4tPA
         6HDw==
X-Gm-Message-State: AOJu0YwpfuElDtBuYSoRGSeDWPt20xyRZSw0tzuTOlcPb+0tZZRBtqxS
	h1TD1qt2GUAXjf1Smyu/3f0LGoyfJdp4v9vOWAy8+x54Qbzgohd/mxT33FUKFA==
X-Google-Smtp-Source: AGHT+IHude/EQvEBYN74MFczuaEQlg2V7f2joS40qCBs1gJ13F8yauj8PlOv2uTO8PItNO8JHZluzg==
X-Received: by 2002:ac8:5987:0:b0:460:b165:2e04 with SMTP id d75a77b69052e-461145a91cemr8312401cf.4.1729639009793;
        Tue, 22 Oct 2024 16:16:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461167a39acsm767531cf.32.2024.10.22.16.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:16:49 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:16:48 -0400
Message-ID: <83794297935bea8af10384deaa9c5986@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241022_1912/pstg-lib:20241022_1830/pstg-pwork:20241022_1912
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] audit: Use str_yes_no() helper function
References: <20241018110945.111842-3-thorsten.blum@linux.dev>
In-Reply-To: <20241018110945.111842-3-thorsten.blum@linux.dev>

On Oct 18, 2024 Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> Remove hard-coded strings by using the helper function str_yes_no().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/auditsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
