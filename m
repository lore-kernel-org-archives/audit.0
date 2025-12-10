Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827621348
	for <audit@vger.kernel.org>; Wed, 10 Dec 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330316; cv=none; b=SsqJpgPVZiDvHG+++JGEyOKp6n6BwLCNUuHof5BMec+tfr7ZiuH59hMV+Xg19+pX/au89jgo1IvbsKVwEt9iDr90sEBLgrexvVF8JWD9nuzEmwgDMVB01EBK3aCVi5OH9cGDplgcQ5OlJnExU9om0nD2GFQXyBXGZhf2CONEAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330316; c=relaxed/simple;
	bh=Qzl2+G26+egzW7NDywgHIPdgsSaruQbcND52dODf3n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X26iO08T7hL+mIOCNeYgrmUx/FKsg3y6wo/sbH7hL+wg6MoZ+ffBHf/G9B8ff+kW3RiIZe+hbPO6aTtsOljXLQ5Jw6hzftwvyRzwkFRCFw8I59h2qiCyfhYkrACwhO6LXVClNNRFwYzCFCDDWkCVN+Y2vAdLOXZj1PzwhBc8jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vcWO697F; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vcWO697F"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-297f35be2ffso91823875ad.2
        for <audit@vger.kernel.org>; Tue, 09 Dec 2025 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765330314; x=1765935114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bADCVXBmULrDifzRYGxN5q5EnP7XKBVKqffCRORME+8=;
        b=vcWO697FfeR9XP3IZLye2h5kDXCOy8u4uaEwWUapyEix6y7jfTcVCAiwDu0gQU/tCx
         n6eKFfZWTp7jEz5ZDIDKdDXUb/tABDWOpV8+KdbA65q9EDo0gxovTwFO44A85J3sYWt6
         mngtreF1nRG3mQ/WGiWI3cXpv8Kjmks4AJNPMjUNDuvGz4Pz7n6ClW3sdv8G3XsJjEbr
         9GPXJH1nkd6qtRraL2jRm9hU59fkLMk2Rd+YYOE4+MCjC6xklg3bPg1YFyD1qNkQbUEm
         zDW/lwDX5wQZEIThCubD8U6HW4JPb3nCLTJulvvgbvwYuYciseZI+UkCgeVg0KXOhsbk
         rplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765330314; x=1765935114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bADCVXBmULrDifzRYGxN5q5EnP7XKBVKqffCRORME+8=;
        b=CQe91Ao/bsxDJTwCADmCwSxfWSw/X34PEVc4Jdnv3Hw7N2zQ/uu1vnq26FVjJm4iXL
         aiV78eJWjkOzIXxLzG0XJInI58Ej1lWEZ9NrFwv8y0Eff90AIdmmzq+JRyRgnZX4biXK
         nPo9LUPtB6lTng/HHPFKkSqMDtj2YOKVY3QyNktIHolvFSwAFwAGu1sUKEBtZScveieR
         56WPFnBoi71+yTpHskKC6cxES5OK5ab6ZwMzrkpgwXBHFC/X7I2wYNqmG9a9IiWuc+iv
         uW2DdFURWxj0CBoHPxOrxiZIjB+INJHGoMB3tpefQb4pV8jAh64Wiibv7YD0J6s8n4rD
         8O6g==
X-Forwarded-Encrypted: i=1; AJvYcCVazGS0nWL/Sx9YQPOpH25/6IaRitvSiqNaM7RDeDaM+QqXZyCSrKf7V+vrbtPcfprnjL28cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJzGFggoGH4xLinxyrzIHfu16s2u2dp1xX/y2GOlLklK20rMq
	3Ma0bimpGSx1IYy289ttpn8fnJ7OVFO5wzq37T+jW5eKls2YWkqTNQzRH9fER0hXEWc=
X-Gm-Gg: AY/fxX72t0fa14QFbrTl3bg1i+8rvJLZUl9yORwubR8ZulaRQzfC92yB39rRKilGfIr
	UrkNLRkS7n6+x6e+qSObRsgGRWYSLzhQwhVs2EqjMfJti+jIxci3FitpliLRp4hpar/3MAiuueT
	PdHQf6Ne6owm8jMxK4gFL9gh77asAMdDAptrsOSOaBIiAtr+a8n2umzOysaSgq4Smvp15tsqqiI
	9INfgOOGoWkJHI3XQ2r24o6oGGOcYP4I2SRVJdKsgutBfM65I8wgRsURIXkOuGQaFQ3Z0NKpTlf
	j0e4tFlEs9Z1jzZ05n9rXFPlJ3KPVf1egZObV+YPK20XU9FgRxbaXNTIUSCfyoubHRxe76cXqKm
	nWx/ZGp2RIUS/h751qi1oqx41LPFW3szlUOjN7JGx1kbMahSQX4d4H4IlrTLCfqe0DRXfc8nPBf
	16cnKkoTvbuVGL9ZrrKr000rc5uzkdECKSSj7SK5Jo
X-Google-Smtp-Source: AGHT+IF6FoYEiOVVDWUPpLU3jDJvqNCzpKzqnbeVvQnDEvwsoJDLeiTjGFb0z18Vy2LTN2AqGWN2Hw==
X-Received: by 2002:a17:902:da82:b0:298:595d:3d3a with SMTP id d9443c01a7336-29ec27d74f8mr6124455ad.50.1765330313644;
        Tue, 09 Dec 2025 17:31:53 -0800 (PST)
Received: from [172.21.1.37] (fs76eed293.tkyc007.ap.nuro.jp. [118.238.210.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99ea20sm163067015ad.49.2025.12.09.17.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 17:31:53 -0800 (PST)
Message-ID: <3c535b4d-6eaa-4c33-83fd-8cce3f62c020@kernel.dk>
Date: Tue, 9 Dec 2025 18:31:49 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] io_uring, struct filename and audit
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
 mjguzik@gmail.com, paul@paul-moore.com, audit@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251129170142.150639-1-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 10:01 AM, Al Viro wrote:
> Changes compared to v1:
> 	* putname_to_delayed(): new primitive, hopefully solving the
> io_openat2() breakage spotted by Jens
> 	* Linus' suggestion re saner allocation for struct filename
> implemented and carved up [##11--15]
> 
> It's obviously doing to slip to the next cycle at this point - I'm not
> proposing to merge it in the coming window.
> 
> Please, review.  Branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.filename-refcnt
> individual patches in followups.

Sorry slow to look at this - from the io_uring POV, this looks good to
me.

-- 
Jens Axboe

