Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE839341F
	for <audit@vger.kernel.org>; Wed, 21 Jan 2026 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768968537; cv=none; b=dLFjeDRSqIh7vY5p7QskLK0EGTqsTHLwVK8j63fvmu45bxiQppp7/Lisw0rF0zWVU2c1BZYAKoKP15lniBPJj/dbeW/TimorcpYUF5/Er3u4s5GMnGaIia2dVMgKkeVK5tB8Z5ER7Z59ggLPFU5xDZwJG1d2cdz7fkIvsWbDDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768968537; c=relaxed/simple;
	bh=o30k9E1o9ocTKSpuBX2i5MTmcEsomKYiKwIKJXTKNcw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hhozvd4VqkbzVE2RMqtmZ7uBzxPWX5WSpk7bpEs11J+e8pToC17isC2/n4Y1+M9dHiyuvRfRdukcEi/HUc/e56AC02W3iwa6+YRdW1Z3log+6wRt1lEKGc3fNbjTR6DM7PMvNpS5jYIOEcyRykr5+701rp+BvavTm/YokbB3vTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz3iRJzE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz3iRJzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768968530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHHkm5Bjk5imhl4lGVMoSCR5TkexCwEXfLnS8LKrLe0=;
	b=Fz3iRJzEnlEqhHHR/zec4OiU7I8yUbhl2Ie2VmN4jNYWHVySRpqhqQo6Aqs/6YGXXmqmou
	fdnWeLQUBaxIn4NG7YTP6KkS27CuFALL8m+6BBxeUtkihJGmso+1ATiqe0hBsYSs1Jk+Xz
	JSgDcLam3XaWJTc6xfADp7Kxg/XYauw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-uAvNOFbHPou95hONYIeRTA-1; Tue, 20 Jan 2026 23:08:47 -0500
X-MC-Unique: uAvNOFbHPou95hONYIeRTA-1
X-Mimecast-MFC-AGG-ID: uAvNOFbHPou95hONYIeRTA_1768968527
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894769f8732so551106d6.3
        for <audit@vger.kernel.org>; Tue, 20 Jan 2026 20:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768968527; x=1769573327;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHHkm5Bjk5imhl4lGVMoSCR5TkexCwEXfLnS8LKrLe0=;
        b=FO3DhPzvChcEqgYKazRpe8egrxE01hFM6eZ6mzZlZuPU2lAxQmIDW2tz5KoBPv/FAo
         VCX2AwYaCzPy0lQ4rhn4wnqLydh1JtgajZo7tybUBncd3M0zXWlO0DQXsOimSoMTjkPs
         z5worAcxaE8CD9G7DEEi9Xc0f9FfAvUz4grUdlhXTnQWZVNosvmfOhgSQ9zxHM2Iwe/S
         nD/IMevULv8ZJgUR1zrDh/6WvWz2eTUxtdafbdbGXA7Lga3c1q8frpN288p13aqruZkO
         WLiuWGXZRag7GDoWB9ZFv8L/Kx/N2M7EUZStp+ZKgaeXJrCUds+TTJKRTNPB++R8LaIy
         0fVw==
X-Forwarded-Encrypted: i=1; AJvYcCUTREvqDhQLJ66EMcb5F/Y04V3+0GwmHX8Wux80PJlHyYmr/rmH0tykrltHQ7+zYGDczsctXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdxs1mOgmMUJDDtbv+HZSZ5jAxCYeN2+Lmohku2t429yL8XTWD
	YdYNTl+MtoPiXH+9IhOLoWeEPXs1xKzOEg/IOXs+HYLnpWp/cd+Q7Hbjuq1EDvArjcXMtPnx8FY
	KJIhzIlZtw4EhGMRZc8WiJJdD/Kbu+74XU0NpHlBN/6nASVrOUZH2G41U
X-Gm-Gg: AZuq6aISaVa8E+i8mMui/fX19dIvlO5GfHFlwpad8KgZvZnU9e61PkvB0zk6ZVdDWDU
	jLIk9dIK+P2cZmG1wESWMRKBn208uQBdLf3Uiu9jF4qXg8IRm+iXIZQOczdH+Q4mIL1m9tU4tZK
	fYRkXg5CgaKzv48WoqoCT16AeitmuZk/v26dUBFnTzdDRl1pZSM+e1hg1UhwqLoe6rJ/o1Owd6x
	Y39D1RCZSu5o4+Y8FZqPCcVxGPJ/AjMq8vdgb/hVlykm1toQGgqtXvpEhMWZ8+UUHuyiZpbsBZI
	Szimd7GnjKDDQUqD8jyuxmGT8EWTchNZ/1aSsmyeuUdQ5gO9sYL40MPulq+uAdWi7anb1mug/A2
	zoPAjFc3Nt23JO1haXa6+JIdhIvggFIcnD/joetvHYI/dbvZzcp6qZy4h
X-Received: by 2002:a05:6214:1243:b0:890:6331:7e88 with SMTP id 6a1803df08f44-8942e4b8f8fmr239200936d6.44.1768968527023;
        Tue, 20 Jan 2026 20:08:47 -0800 (PST)
X-Received: by 2002:a05:6214:1243:b0:890:6331:7e88 with SMTP id 6a1803df08f44-8942e4b8f8fmr239200806d6.44.1768968526744;
        Tue, 20 Jan 2026 20:08:46 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89471f6b0ebsm5902146d6.55.2026.01.20.20.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 20:08:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <84955de9-823f-4b3d-9107-f7d4aee38b88@redhat.com>
Date: Tue, 20 Jan 2026 23:08:45 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] audit: Quit audit_free_names() early if name list
 empty
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260121023509.410423-1-longman@redhat.com>
 <20260121031105.GB3183987@ZenIV>
In-Reply-To: <20260121031105.GB3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OoEDL1AHC-XavqN9JU763CpM_jBeUi9pJDnYFmnPj6s_1768968527
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/20/26 10:11 PM, Al Viro wrote:
> On Tue, Jan 20, 2026 at 09:35:08PM -0500, Waiman Long wrote:
>> Optimize audit_free_names() by quitting early if the name list is empty.
>> This eliminates the need to acquire and release the fs_struct spinlock
>> in path_put().
> Why would path_put() go anywhere need fs_struct spinlock???
>
path_put() is defined in include/linux/fs_struct.h. It calls 
read_seq{un}lock_excl(&fs->seq) which, in turn, acquires the releases 
the spinlock underneath the seqlock_t.

Cheers,
Longman

