Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E66EB5B
	for <audit@vger.kernel.org>; Thu, 25 Jan 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195603; cv=none; b=g3CmpAtWSdU2xIc+OlB/rdWd7RdSJpoQKwEQckC52RTbon/h26oF7htJ0ScvWxoUV6fZ1ZtRAlSnibMii9XX3nYIKDb5c0fLQV9UWQgaVlMsFNw37pKZWAH+Jusqyux/U595DqGu8lIr5qCK9nK05VM1In2JoEzWDD+HrXx5izE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195603; c=relaxed/simple;
	bh=1+gWzxHdDlvUYh7j8de4u19xdmEQhVFoU39PTbIkN2E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eENQm2AdRMGiBoedYkbCZ8LkbZBJJOWfjsMPBPIsgXMAkAdVqQUHhxXehK7JZnkhD+eqkJUdLMyPU4KO95KSCKEIH38WfVntyfUf+SF3+9KiI7HQpIe5rPLXUobJGLlviQUDs5rc3HPHTNwy8O1znHs2CxUcggC5+SGBBeVmqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ApDpCl9W; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ApDpCl9W"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783293278adso535047985a.3
        for <audit@vger.kernel.org>; Thu, 25 Jan 2024 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706195601; x=1706800401; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8QfX+fXMC//GQOsMmawYMOFIuyxE057vSsZZYnIogE=;
        b=ApDpCl9WKbxlFmKiIncvTlnmk9JM6IOLvC3SIXbIgOfwx49W2FemHoAbiZrMJ+3wJS
         Bni1LaAiamlDI6boEdKLBxFNPLT2DIP4RwNcyhIIIEKihFMH5KLdLffNUJy0jRQ3dnQF
         43KzNq8kimi002Y1KZHPGn2/jKpmKXahnWre5NSUbtW5EDjJRE/EbAa3ixAYRI0gRhwc
         L55iOFw2X7EDDX0352cD1cDcuCKsLrG2pjmUp03iD1sQIvZ62zeUrtN/yCIqJDAWEQhS
         I5vCP6HXy88p29Y3iXMmN0xovsXj1GP/SsPx0nVE8J2kY8Gy/+cnabtb4ya5BYc/Cixt
         SaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195601; x=1706800401;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8QfX+fXMC//GQOsMmawYMOFIuyxE057vSsZZYnIogE=;
        b=J394mVDjvLM5xm6zBeo0jgwI34drSTPEb50t9AZBy1d1JkOkY8hXPFysqtCmq+Pb6v
         3tux9k8rx5mCyzV9HHt8iJ6ZRZmvqwCYEoKRhRek+nG6XuQabfFPsKNRU00VzUaPgspz
         kJ+tiXz0JrvQk2MOty4fCaxrld2RggoVCnZ942gPANVAOKF1Xl+z1AM50m7KVG4lHYyA
         sfNSsARcqvWIjyXigijtAIOc1mQ3kMRKtd1w5QgyN8CWEPQQVjn4Q9nJ62yf0kcUKt4b
         IZGGP4xUfsAzJHnPBj1LxG44P4ZrAPpTV70G2quELHXMqASGlxJpMsXa20q2FJDhRrJj
         MYQA==
X-Gm-Message-State: AOJu0Yz+Cmij7tDVhEzNtpCF8YQIixt7Ow/wjOYDF53gKi818HTIECYM
	VLlaZZ+pp8djC9UoelnO8YxEVD2kNOkBGatADzUGBS4SYnxuEckxdkxRDR3PNg==
X-Google-Smtp-Source: AGHT+IH++ju+QnC7zWMmKmf82XR22Nz1qLA0O29ZEqkNG6+qEZ7JpdQbGUJ0jC6kQDzg6KIzJ4GsuA==
X-Received: by 2002:a05:6214:c25:b0:67a:a721:caf3 with SMTP id a5-20020a0562140c2500b0067aa721caf3mr1242821qvd.84.1706195600876;
        Thu, 25 Jan 2024 07:13:20 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j6-20020a0ce006000000b006817a88541dsm5526504qvk.75.2024.01.25.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:13:20 -0800 (PST)
Date: Thu, 25 Jan 2024 10:13:20 -0500
Message-ID: <1d15909e568d1571f08d430213ad77ff@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Kunwu Chan <chentao@kylinos.cn>, eparis@redhat.com
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] audit: Use KMEM_CACHE instead of kmem_cache_create
References: <20240124060224.463335-1-chentao@kylinos.cn>
In-Reply-To: <20240124060224.463335-1-chentao@kylinos.cn>

On Jan 24, 2024 Kunwu Chan <chentao@kylinos.cn> wrote:
> 
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  kernel/audit.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
