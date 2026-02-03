Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92636C5AA
	for <audit@vger.kernel.org>; Tue,  3 Feb 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149927; cv=none; b=s0Xz358VJ8IKOCrtdUESrO6kqFIiG1HrMIdVwssMweA183IPelSthBiJyZgyMDql+obSlufbdBLx5exhxkh/htxWnIkuqTO8ZUtooCs0v3jSA+32DHZaF2/POUkdL6Mi6dPI6dOlQ4BIDCNuX3aZLQdCRsPq37GtKtcWfxcA7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149927; c=relaxed/simple;
	bh=sIn0+PpHeGwl59t8r9yhm3iiMAcqZDGGOJQU4O0rpAs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XUNZrQPYCxwdImiws3w1CT2K96NWgnWwG198ZZ8XmvS2sTkmbs/XdGWow4PZFS0zPZCePO7R2lH/QjJYV+92GujsHV2ukmzcmMkno0E7J1ibPlaJxU3nTw7ZLF0Jss7rA33C5HxI8/NG9cayjwTaz48Xr7a8m6zjqi6fYojRb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3/7EM+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3/7EM+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770149924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOgtVFt2QSNKNnhhkPHuppGUAy5MYL9zrORdrlUpHd8=;
	b=U3/7EM+48OYWv6qnxjm6YbJGpCAROD5AMVp6JYvwBtncGZYbZ+g2HifYOFJjkpXQixkzw8
	pGGTSfd8mCF7mRU6DY08Be00363GNwpKMmL44lf851o/0fLiBcN0sVdxxxfvZFHvQibZpV
	i/9u0NsszdBCHaIsK1MVc8qJeu/vlW8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-evfYsxByMYauMCxORtZ3yw-1; Tue, 03 Feb 2026 15:18:43 -0500
X-MC-Unique: evfYsxByMYauMCxORtZ3yw-1
X-Mimecast-MFC-AGG-ID: evfYsxByMYauMCxORtZ3yw_1770149923
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71304beb4so1386403285a.3
        for <audit@vger.kernel.org>; Tue, 03 Feb 2026 12:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149923; x=1770754723;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOgtVFt2QSNKNnhhkPHuppGUAy5MYL9zrORdrlUpHd8=;
        b=wvOtG/5NWKYtGtANEY9N2sZsf+cg62mS4l+yKibsqq7k+qG/7E+Gb5sh9QOOZ8WE6A
         vZap4iK1SBWAjdlCBzrLoyU0aSlFVg79MatyeeiPUf/9slV/Owa06mnTNHadTMSFWxSz
         PC1QITFol5yBErizSbUP0J6fvPd0IgVqj+oBsSOhzpaVYsy9ofLgeNVu5Gm50KqG1sKQ
         vZnqsyJtvBIAQLN1HP9pJmdEouQoNbHKjytQCxoihBYiYwg3MO+hwzdqm6QNPAk5+9rO
         PeAgHloJCNXH/tfd0HB/0L/Y0xNMk6xi7C32u1jt9GAlB4laYvccBT54qxHNNkNeJfOf
         nAEw==
X-Forwarded-Encrypted: i=1; AJvYcCXGRD12+ielj2HqAzlxERHpGQs6dyR+J3vbcVYpXx/o6cRI25RVjtmKsg5Bqk7ph745RptOSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxowNRw2OLqB2i6iZWEF2954dpP/9imn6lmzet+bKvo7phBu0ld
	9ZQauj5zIqRYE40jjMFHnrFL3FQnSZ7ne0QXhbmRKt1Y0OCY1XSjl4GhEH62EGucIdLTO+J+ahE
	aGqVi5VRb61KFY9mpIjB42aXU/16ALluR6aGmk6plDF6gvYD0rVP+wxlr
X-Gm-Gg: AZuq6aKerna7fmZJ+RTESkSeIa1iLC4OD/A7AkJa97yeYkTh/LyUm4NyuNikZ1/Dw3Y
	m0Ukauehvm9UiE4XPrQjXJ9foCnumWe85uUvNdOQxyq3aY6E4h+m8u7Li3UaC9lfhNUKYDf9glu
	JHAX2sOI7j3ehM65laOK8/r9KDTawoxO2wB8s8WrazYWkrCAJlJmVS2CDcrIIlt2qW6Agph3mZv
	/kbxsniyffDBSUWqrwh7/DMDuKXa0RiQ9oMowEVc/OB/00BlYu8xImwKoS9NIAr0taNpk19yX/k
	4mSpQcyfMQkvyuhxuMArruexWuhMgjM4vAGaVyLKuDfRihrbwEoDCTbSYVrGrWi3WphTXwo1Yaj
	U/O3e+U1XGkQ+4PlX8KKDcmq2J/MkZniwC7YA1WDNqVaQ1L/VIcagMQPw
X-Received: by 2002:a05:620a:29d5:b0:8b2:f102:b904 with SMTP id af79cd13be357-8ca2f82e45dmr115301485a.12.1770149922723;
        Tue, 03 Feb 2026 12:18:42 -0800 (PST)
X-Received: by 2002:a05:620a:29d5:b0:8b2:f102:b904 with SMTP id af79cd13be357-8ca2f82e45dmr115297885a.12.1770149922314;
        Tue, 03 Feb 2026 12:18:42 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2cbbbsm41231285a.26.2026.02.03.12.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 12:18:41 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7d9f73c4-0071-4df5-9bc4-0f58ce427a8d@redhat.com>
Date: Tue, 3 Feb 2026 15:18:40 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203195958.GG3183987@ZenIV>
In-Reply-To: <20260203195958.GG3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sJ2RtVVPa82LQet6Ghrili4pWONrw-9O1Y53xpdF-Ug_1770149923
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/3/26 2:59 PM, Al Viro wrote:
> On Tue, Feb 03, 2026 at 02:44:33PM -0500, Waiman Long wrote:
>
>> +		/*
>> +		 * Defer the path_put() call of the old pwd to workqueue as
>> +		 * we may be in an atomic context that cannot call path_put()
>> +		 * directly because of might_sleep().
>> +		 */
>> +		pp = kmalloc(sizeof(*pp), GFP_NOFS);
> If that really gets called in atomic context, this kmalloc will
> in itself be enough to fuck you over, won't it?

Looking at the bug report again, I realized that the problem is because 
of the get_cond_fs_pwd() helper in my v1 patch call path_put() in a 
spinlock critical section. So we don't need to use workqueue here, just 
doing a path_put() should be good enough.

Thanks, Longman

