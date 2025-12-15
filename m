Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB16327790
	for <audit@vger.kernel.org>; Mon, 15 Dec 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826841; cv=none; b=Y9u60FRpcMalddbepKTfeuEOzXVg9+9+9UZxFKHpG7z/s5g0vmp0+I4/Cspa35N9Ye5idCoNulcbFOAuuSyCwcqFkJwD0E4O3SPGxOk8sjjdn4K8SWUCVsulyMBgENi80bdpguXWIH8SiWIv0qv0yg0jv/k8uXl0YFJyXP1yoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826841; c=relaxed/simple;
	bh=p19VDjN38aT5/JCtvyTQkIJEG7mBJOoePXAu2Yp50/w=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LWO+GvOWNkFxnS4EXQG5WWHCLkrmXT5URFI7j02haCQr8Ag1VZZCFPqhSZAGDG4xmt6NOZ/iBmxY5F5u3NhfDCg/Ym3RvetrAK1MUeJ4yf8cru3LQYrG8VPE9mSidUAPmc/6GTFlU8slNFrJodJQi8Zy8JH8wiTZc2tix6kvujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q7+Ubuin; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q7+Ubuin"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2ea5a44a9so404479985a.0
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765826838; x=1766431638; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp20YtZZ50Vla8AV5t8DKa56u9VU3o+LE/TSiNNTpNQ=;
        b=Q7+Ubuinxnag4IK7kidlcN3hBcYVz9aW5iAO/x5xUtnWA+wU8nigK7xMdwz4CCURXr
         y3Fx0WQk+mCV64x/NyO09sPJvi7skMS+wKGoEIblRUbFuaUAhmg5YIN1y/tRhczGwPrP
         id1qetngNZrDUaZXN/9Wb2b10DujJlMU9biZr7YZL5TJYpn7WYqB0mYptK+K76DNBY9h
         WXdWtGHQkBmgGIZLcKNmcFObwCRs3/Bmb2xyXBoC4y8gfv0lk/9IeoNEbYi5/ISU6Q0l
         bfp9weg71vw3qyP5xXk7MTr8BWHo0GrFj0+BBkcX373phIHX7vOrwlhEvYAquazDtzeV
         6omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765826838; x=1766431638;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp20YtZZ50Vla8AV5t8DKa56u9VU3o+LE/TSiNNTpNQ=;
        b=dxIxZtE3X9WKcVCSeUosDgObje9ZpCuTaEg+R4czrRs66NkQMZlKgXbf7IouOMawF9
         bRJb8dSBg3c6CT0NmGVtz/mAf1EpCUJPv3oE2XSnjWoV0z7BSLiHR1aWrpUCGF0Db2/h
         +PJsVF9NL18aYKul9YQAkJDGjbVHY/7DVmRA3553u/2BcF51f+OXgI2s3qRbvMDBYvKY
         Ivlfh+lA/amJrptsCdBstdubXJ0nenMs+VKT+Rjc+MboP3R3KyrFR9QzDi6K3GLgsbQS
         XQAFZ+mUL5CeyzLodzn7kzi+wQBbq0a+ctd0gvfsfNtVh4nYDRHuooQlA33bVXmNmV3s
         LJbw==
X-Forwarded-Encrypted: i=1; AJvYcCWnB94sAuzZBIl9KmKWeekUk3e1oJtGA1Jd2jkhMqNnHGI3rcI4fniEWKsH/JaqnIU3FgOJFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtoMdFqThKAhD2JI3St9BplGAyd+Puve6c+kUtUz0Sb6ZWPqk
	Ibx+pmO6Ju6MCHXngItt4hHfLIMFj/RHYZdK+aZs4fgaB8FUEL3PwAAp31aSpPX5Kw==
X-Gm-Gg: AY/fxX6cQ5il1EkSukY/8vgZslQf/Bz6Hjh0rP0ti+DvhtQnamKvez9g2ouw724T8bc
	Xk1DD+YaGzTvX0xXv28gYXUmcDLw92/cRC2ZPl6e0oWyvot0rXak9T9q31iF4+2SCoJXlXGkLBN
	CTYsHf6H8GXclsYHv3Qft3spxMmuqTYgUqwk5cCUy0wK7bcK/9q6GuNn+2Xe2aLVJBRQR6ZGiWb
	jvwre3y1B5L6LYZKxSXPuQ/exwylRy/vHWVd+IQmwSDWgOj9ElqxsmCy0ae/p4NtmhQudNkxmPB
	nVKuOYPChFmAoEKCJFUvq52GeKyxpoVZzcHn9C+KH26RBSnHZdFodHkgU3lgLaWw9dkNWaQ+2S8
	m7sf1dX1GL6aWGAcszA/lplJQ4/V/RIBCx0FpLBJbcU2O81prxMYM0Jr4WGH6h6nYdYHnpDnoTt
	a/TyGzspeJKJa18Lz8r1tyeVQj/wpYUgoa3sffVNMc8tBEebI/F8g1Ldue
X-Google-Smtp-Source: AGHT+IGhNJIIJN3VAlV5pywcC73t+nLUYXSuoiHK63yr3QC8JasWvPTGikG0rTfVuE3OD7DNfYQ8/w==
X-Received: by 2002:a05:620a:2a04:b0:892:5b57:ea41 with SMTP id af79cd13be357-8bb399d92a5mr1555871285a.4.1765826838135;
        Mon, 15 Dec 2025 11:27:18 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be303e7c37sm17648885a.2.2025.12.15.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:27:17 -0800 (PST)
Date: Mon, 15 Dec 2025 14:27:16 -0500
Message-ID: <1ef393619314cb77556d6c27f1042646@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251215_1137/pstg-lib:20251215_1136/pstg-pwork:20251215_1137
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Bencteux <jeff@bencteux.fr>, audit@vger.kernel.org, eparis@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: add fchmodat2() to change attributes class
References: <20251124194930.8576-1-jeff@bencteux.fr>
In-Reply-To: <20251124194930.8576-1-jeff@bencteux.fr>

On Nov 24, 2025 Jeffrey Bencteux <jeff@bencteux.fr> wrote:
> 
> fchmodat2(), introduced in version 6.6 is currently not in the change
> attribute class of audit. Calling fchmodat2() to change a file
> attribute in the same fashion than chmod() or fchmodat() will bypass
> audit rules such as:
> 
> -w /tmp/test -p rwa -k test_rwa
> 
> The current patch adds fchmodat2() to the change attributes class.
> 
> Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
> ---
>  include/asm-generic/audit_change_attr.h | 3 +++
>  1 file changed, 3 insertions(+)

Merged into audit/dev, thanks.

--
paul-moore.com
