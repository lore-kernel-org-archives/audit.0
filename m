Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D61448C1
	for <audit@vger.kernel.org>; Tue,  3 Sep 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395719; cv=none; b=oeuBsHi98qUWOfiQW73cxhdyT8NBu2nzQypvnidTJfxOKqL/F5QCW3X/lLXgLlhds+k51atqtw+7SiPlilRZbYCu2h7ZDVVU1v000NIYnf5Mvv3BXLABC5R0XS/MtteMmkOviIREzCyUWD1+Ft1SZtSS3macCRi9ujJbYeIPrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395719; c=relaxed/simple;
	bh=PGab2PBLy8ilaHjN16wooXfKRYH+bb9OT2olp6FLY0M=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=I6J8Alh9r8itx5x3RBj7aIyXrEZtx6OXkOAyen1LYRX9UgN7s/JkLsL6SFxwtPaHMqS5UCpyUl81HVkVtxz/Yha+EybiNT8ddnHne2whWypzya60apAANdjGAkSVhKz7vS2pPYdbgY/ARWIXFEuG6skVBtRKxGMcFqmx0j9JqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ILZzlSnO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ILZzlSnO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4568fe680a3so24276411cf.0
        for <audit@vger.kernel.org>; Tue, 03 Sep 2024 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725395716; x=1726000516; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUvKwr5FBy0p26tX1KDMmzLdItJ1zXZxagEcjZYvcO0=;
        b=ILZzlSnOC7F2tWne33qWGVV6SciB2kaU9DmEBHPPDgYeIB+cW4+0rusyfyyS0m9fT+
         k7Xm7Sgxb4VvdqZhkO6UdfNy9aiqtkBcoYNioP0cIgqbM6HNejh7kCcJLIL37uq3F/H0
         otlPJeCJd/NNXpYNOg4LyvkNaNjo5F7LQBpEWUoYe08BkfaW528XmDY6dbOtCVkoe13T
         +wdvTQKAryGOGCyLqRFRhPQmntK3GBiDXi09XgdIF/Hi808yySKoENMJQSxfU2azWnIv
         3RjNV2Boc6Aex+4cjqoQc066X3vX0Gmj5HPqJq/IePSmypJ3OeL561/JXMz4jQwBAea7
         xUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395716; x=1726000516;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUvKwr5FBy0p26tX1KDMmzLdItJ1zXZxagEcjZYvcO0=;
        b=fh6rbEZwCTrqX0vjvjWSgH950aXuCKM9YJBzZ2wYSrRyOMESFl/liF2ILve46os9pN
         i+ERxFeX9mpEUOp0qe1LEFu8Cm6qAdQ3jDCD4SZTW0yJL/PNW6djnD1CjmySkjnUdATu
         CJ0+uzAUpBwg+2qI0QfCxIwJjnoN7+n1l4PcZvoPXB1apgR2jLxkUlDk9YkERr1ZEQyN
         ODVbrqNyK7buCUCJG/W2eTRmEbKABOGQZe/Bn2BkaZ9O+02WWr1xY8RK0BNwguHgI6k5
         Je4xhuDRlN3ljGKbeqtcWkaUsBTrGQUk5XHt2EjsOjTBwQA3YQhokYXyrIdzLym+b0UU
         CJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDQZg25k4VjyapiOi35R2LiS8+4WmV1lM3jscRSaNqKyfB8T2+spZbQKzSG35bQRk2tHK6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58o/+0LPRuWOvJMsqc7+2RCTL8zrBy6Ft7SrQUFnKl4J4/0GT
	WIxSn8fa3/Lj6T/BpujY6Tc4/f0aZ0MgO9p/UOPbYpcfX5lBu+KQl4lICKPThg==
X-Google-Smtp-Source: AGHT+IFnXVhxbcLTuK7EcpysVAtGsWnR7yNflsyrXV/nKS5r+eL1YkxLvnDNGiC0MN35WHxMEAOirw==
X-Received: by 2002:a05:622a:1e98:b0:457:9b12:2297 with SMTP id d75a77b69052e-457e2dc9ec5mr47844931cf.35.1725395716387;
        Tue, 03 Sep 2024 13:35:16 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce3058sm52870231cf.52.2024.09.03.13.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:35:15 -0700 (PDT)
Date: Tue, 03 Sep 2024 16:35:15 -0400
Message-ID: <fb52142f466d0c5852293b83bc7d3650@paul-moore.com>
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
To: Hongbo Li <lihongbo22@huawei.com>, <eparis@redhat.com>
Cc: <lihongbo22@huawei.com>, <audit@vger.kernel.org>
Subject: Re: [PATCH] audit: Make use of str_enabled_disabled() helper
References: <20240831095251.4163011-1-lihongbo22@huawei.com>
In-Reply-To: <20240831095251.4163011-1-lihongbo22@huawei.com>

On Aug 31, 2024 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
> Use str_enabled_disabled() helper instead of open
> coding the same.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We're at that point in the development cycle where I don't normally
accept much other than bug fixes, but this is trivial enough to
merge.  Merged into audit/dev.

--
paul-moore.com
