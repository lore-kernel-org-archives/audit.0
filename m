Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682853D0905
	for <audit@vger.kernel.org>; Fri, 13 Mar 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424110; cv=none; b=mDMXkdJu3/mrsGrywxnllQMDdVKkEZ2aRvL4xsW7KzDf1pHHaDyn07Dm8I023rb1hg4ZTvVYTw6Tg+k3ad15LmmG/ZDOQkyBpKk46FOrxrUNsYxvHOVD6j/46LWNN1SkG/bJKXyNNcrDzse3AycwRrkHb1F0P0koA0ruwMtKAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424110; c=relaxed/simple;
	bh=TWDo8QSGG9FgM5eDtpe6obe0bpwVrY9XvgV6/9CBZdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlikdT+s/OboF+VsOA1ANF2gtjn25qCSx4ZTxA93L1wKPnrVENyF8JCcc1uaeUa1YcvwwoXPWvzWmSuv8IAU+5BeK7saY+4hAVd3KDhiKjV/gOcOXedry3VJd+BnarYz/W206SUo+aW2C2Igcn66IV6b5FUhY+yKWIolSHfQhQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQk98tOQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQk98tOQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48529c325f0so18154055e9.0
        for <audit@vger.kernel.org>; Fri, 13 Mar 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773424108; x=1774028908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wc59JHWlxlV49Xu4pkv5qxkwv3LnMLE9wiNeBvnGno=;
        b=YQk98tOQqO/SbCBjm2l2d0IYEjkkmtoO+3qmHdQPhMd2hy4c7T5jzhYgXwrpsiAVF/
         UwgJJhm/OvURZMRrvVs2ymk0fMO33jd0YjFI+pQ8XUoIQthJemiSA1kKLgnervl5iKlJ
         pn5roA+T+W/O0GPJ1qcKOmpDbe+KdmgSZ00HOCIuH7nUZjqZjPu4SdbAOIi4+0YC4Z6T
         sUr1Zf9u0DM0yUZR2sgRsTEmeZM4eTzHsuWhOaWiT6XogCOswQjRyDprHYPjtvDZ4jbP
         R0GgCinx7ZmrjRPNm8Y6ADXnf9x0UILkk6Nad7vuA052tBLZMhEyssn87nfAvb7uYkri
         yJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424108; x=1774028908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wc59JHWlxlV49Xu4pkv5qxkwv3LnMLE9wiNeBvnGno=;
        b=SCiOTBc+PEZQqOEXM2CCUhn34fVI0bAV8JhZB7gE0BsiCRkywOIifVRUGrAcb9sYTh
         cHV2e27oQ910KzyjWTFlvIPEy4N8yU4ReuLs2fHofbTv3Mk86/c41QeuknerxNaf0lbz
         tV8UL7iwZxfRXTuGwWbJHcmF08z5luAWU8CrPxbtfDWIHGRixnrN+/8yarr7Nj+6FRTn
         WCDXy8S18BnAS+aUaZLr4l9Poey36Acw+RaNP1+u6p3PCNCuoeMZEcwUIeOKjmik5mGd
         vXDPr7FAw8M28YXvkJlTG/LQ1qf5ku00YEa7pnFfhaPnC0zpH51APsGDuLhHoFu2sbzg
         8zgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqNtzw6A53gkHr9ljzvEqgXP/t13tdGXskoNbaKscBsXS3ZR6BAf4UneFPqNURHjYnImrvyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSv/Qaq/3ej5Kfzw//V30GUXUymrKcFauSmTpVKOfR7BpdvnZ
	bW74/BiHpqwZDW7qlNnFEtG9va4VTYCKE38G8vnNpKi3AuVSv9oJKgwC
X-Gm-Gg: ATEYQzwGaTSk3YO1HwM5H6qF008ZqdFTi0Drqfg9TIX1N1T/aoZ1KaULiNbifNFB8mC
	7nXCi8HZe/J+85WWz25KVeUuZs/RrvTo7LuD+1Ti+3tV1I3WIBX8AAn4rGq1mk1A17MrLGkMexL
	0o01GT6wigZ/jAaZ71PSVXAlReXjAJP2LVjVf9RZGKTAtfCpAeFNyyiy0EKWdNhZ/LMk5T7i6xm
	WB+sGD9XOL+6y6Zx4TzX3WJo/RJ/VvCI8J6WId6B4QAqZO6LQgHtEPLH5L/WWQ6nOduWkgLN3yg
	1g96PgNqTLfVATa2Zt+ZZ6kPpP/2M/nyEB9LooIExzeBbIB9tbYbNGYXBBTeQ2vgy5KVNcFDcYY
	847IeTPFEROPrBpO2rCDmalQBJoarw1i8BepznafIfxUtzaKmu01uY1fOsP+XOlk5QiRb1GKkwr
	mfzgeGxdHQr4lLD2Z5FBwQ2QiN1Y4OPwUMXvod5HC6e4iJm/WvOP/eqbcRkS1nAzHAvyoPtxPJc
	9cq5yujoxBQq7XIr2E=
X-Received: by 2002:a05:600c:37cc:b0:485:5812:27bc with SMTP id 5b1f17b1804b1-48558122839mr56882655e9.5.1773424107565;
        Fri, 13 Mar 2026 10:48:27 -0700 (PDT)
Received: from [192.168.1.14] (mm-214-205-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.205.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm217631535e9.14.2026.03.13.10.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:48:27 -0700 (PDT)
Message-ID: <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Date: Fri, 13 Mar 2026 20:48:25 +0300
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 linux-api@vger.kernel.org, Thorsten Kukuk <kukuk@suse.com>
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Content-Language: en-US
From: Roman Bakshansky <bakshansky.lists@gmail.com>
In-Reply-To: <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/26 4:59 PM, Adhemerval Zanella Netto wrote:
>  From the glibc standpoint my plan is just to make the accounting database
> function no-op [1] (I hopefully to get this in the next 2.44 release).
>
> And I think Thorsten Kukuk already adapted most of the usages in current
> distros [2][3] using similar strategy, along with a better systemd
> integration.  I am not sure if/when distros are incorporating his work.
>
> [1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
> [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
> [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
Thank you for the links and information.

I have been following Thorsten Kukuk's work. I know that liblastlog2 is 
already integrated into util-linux and successfully solves the Y2038 
problem for lastlog. I am also aware of his wtmpdb project. These are 
important steps in the right direction.

My RFC proposes to go further and provide a unified solution for all 
four files: lastlog, btmp, utmp, wtmp. The idea is to create a set of 
public libraries (liblastlog2, libbtmp2, libutmp2, libwtmp2) with a 
consistent C interface, built on SQLite. This would provide 64-bit 
timestamps, indexes for fast queries, ACID transactions, and schema 
extensibility without breaking backward compatibility.
