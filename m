Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931D1EBFE0
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340825; cv=none; b=HYgDFHKh5Sj8n0BWocsWCxzRZo0FDa8p6TGoV0/vCmZtm5QbFNPGGBzFwfe26xcHrvpwsJsGeHzNcRQzYut+oINcm9my4G9G+sQ8ijvGTPtmGEnXbsPaqnHqGUHw9kdKMnBB8FVESeW6PVQ8D4CsJSSA8c/Pg/WFXnAOeRAZaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340825; c=relaxed/simple;
	bh=GyR6KWVzKhyYrBtw6VfJhs3npmSjck6zK96gQJMdCcI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AwedAdaiseJXx/hI5OjckCVVZkt/GGzsaTuMtbUf1MYLiHjgx/hdXul35/kG7Oj9CWF4XGl2CfhMUJsiuB3olq0LicdD5D06zuIPUVg/pFSx+c24xXD+azSTw9hAI46sqI/VZSsY+SMIjK8tVnuH1ncgl5mqDVOr7XoHoOBrGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8qEFJzr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8qEFJzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770340824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7b157Yafq4kRhiEXcxD2sEQIhOvtPF12svPXHHFHG0=;
	b=e8qEFJzr00C5TWhv7F6yUKzuUy+Kn5L5FpTqsZcE/N/9C/cPhqJ50Iwdpj9uA611i2fA/z
	UcdLfGVhFQemOC28P0ogbUCQaNJypXa+u2FcHbI2zb+GiriLvwI6LJ/gO19YJFXXidLsXB
	RMl5zGyyeZ9ZMObvA9O2+FwofgOHCsY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Mr_oveFoMxKJiw1Jq5_hkw-1; Thu, 05 Feb 2026 20:20:23 -0500
X-MC-Unique: Mr_oveFoMxKJiw1Jq5_hkw-1
X-Mimecast-MFC-AGG-ID: Mr_oveFoMxKJiw1Jq5_hkw_1770340823
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52c921886so187374185a.2
        for <audit@vger.kernel.org>; Thu, 05 Feb 2026 17:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770340822; x=1770945622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7b157Yafq4kRhiEXcxD2sEQIhOvtPF12svPXHHFHG0=;
        b=Pv6RbJ/ExCjMy2YF8rdUa9lStkma9lXfHuB55xfhCqUz60xFlPEM7vR5xBACv4tYyL
         j3Pz8x7Dp2pdOwB3G7TjPQp807vfG1xcynQINAPpyXh5MNySkX3uZH1jx+ZzGBF5JMYH
         ZXuWmnXcM6znuxR8b7kZIUy9keiLUKgjEld+bbEAm65QQ7Jes4J9DqBDWAgq/v6rgV6S
         /TqHgbqiCuxWmBymMu2n5WcAm1iE/YzN6IHgWpIjoX7fJ7E51/1CLyOJim8LDhtAMBnm
         NLVc9rDeTICc4XVM56CnyT3poOVzS1wnHT9/C8JOEjTo/XvwsbP5eQQqt/P1p3DpVdUh
         94VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiJi2gvkRrFXS7Bv88MCLhxXGJuxbrHEiYEZq5lOEB9Znib0CtJvEmnGRC2JQhRrJ0unq6zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ6RBEqa/lvME9U2AhtkY2Qhp6sCitIvN32SuDXjLLigwRNak
	IGGZjkpiA6rNN9OYYbLq4VznP50EfPNiRNJiTQ5QvGIMM1eze6zUOGfYMQphWTa+aH9FoAaaIur
	QBNTXCP3bYC6bdhn7hdL/J9Hmbv/rGUN4+I29AcsVYIswErwpiXeInM1I
X-Gm-Gg: AZuq6aL+0IjQmBf9/apBwJKZEmB7yi5PC8Nkeed/aVFjVSV+61y8s2eUxmgAL/Cc4ZD
	x2BHsZ/Nb8zsO1IAKAm6qspMkAo1jcXRNgzCSrb0osVJKYNSA662AS4RxpWKH5UAIu6G8Q5weNx
	xKw92YGaGpuT4j94lD/dADjczevSrVDkxWqaJ3onBFIjMIzMSkL1H8PgyhaW2SIe6Jk5Y2S0ewM
	jMNO9VPH9cE6xpdHveh/HpwC+ScvQaE0S5WlUVULfrHw2QzKWPQlaPL7tsD6WRVswAqBmFN9EVW
	YpRjimCfdIyHv6WVqVCznxs3OtuFjoHkiFKPz3LY/YQ5Stgyv5U5ZvElxDREmngSGjyprk6NgFH
	YWgvoakSPoxtCZWCiNv0egB5JIAQB2HQ/u9gqcn3Kd0dye1cRKuBAate9
X-Received: by 2002:a05:620a:bd5:b0:8c7:808:3d0e with SMTP id af79cd13be357-8caf0963662mr154635285a.49.1770340822647;
        Thu, 05 Feb 2026 17:20:22 -0800 (PST)
X-Received: by 2002:a05:620a:bd5:b0:8c7:808:3d0e with SMTP id af79cd13be357-8caf0963662mr154633285a.49.1770340822247;
        Thu, 05 Feb 2026 17:20:22 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf5484dsm7302076d6.17.2026.02.05.17.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 17:20:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
Date: Thu, 5 Feb 2026 20:20:19 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
In-Reply-To: <20260205235351.GU3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qwH-tDtoiDaNJFBErxv_KZpVhJTjCeeX1OCGW7dIRaQ_1770340823
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/26 6:53 PM, Al Viro wrote:
> On Wed, Feb 04, 2026 at 11:45:17PM -0500, Waiman Long wrote:
>
>> @@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, const
>> struct>
>>                                  count++;
>>                                  path_get(new_root);
>>                          }
>> +                       count += fs->pwd_xrefs;
>> +                       fs->pwd_xrefs = 0;
>>                          write_sequnlock(&fs->seq);
> Nope - you only need that for threads that have ->pwd equal to old_root.
> Incidentally, I'd forgotten about that sucker - it kills the idea of
> fdget-like tricks dead, more's the pity.  Third-party modification of
> task->fs->pwd (under task->lock and task->fs->seq), possible even with
> task->fs->users == 1.

Yes, I am aware of that when I took a further look at the patch that I 
sent out yesterday. I am testing the updated patch now and is trying to 
figure out why I get a warning from mntput_no_expire_slowpath() with a 
count of -1 when doing an umount. It is off by 1 somewhere. I will post 
the patch once I resolve this bug.

Thanks,
Longman

