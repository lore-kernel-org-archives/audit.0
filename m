Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631E1684B0
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408298; cv=none; b=lgAxeE2lab8WLk/mC+CvtsMnBqCDJ4CGj31v8ji0Vel0xryJCa8svN240/5a2SWQHAEYMA/gfnn7HWQo3VJfQVffWFcD1cTPFMUclrYc69UuhdgWtSEK1DQ8opXmMy2sBSoavZJ+WrG4jzr7sQ+lOXIwgKt72ayKJoXiE3PUpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408298; c=relaxed/simple;
	bh=bFwL7hmv1u1PI7IRa1YTNhhzF8tpdQ0TiZHeKDflxu8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VOQIgOvgIreO5zZV0NwDV8Dw8WUTIgPDCh584E3lBOBvfqP1la0Dhk2+pRJgmYHuMpu/vZeXlkUozJTvViQqaWNa7vFBDUZzV7kIzebHtcsCkAG0PzSOUbnKfteZWg4kfFL8FtAhwW9OD7fsrPze7MOQdMTlKFc81VzGKN6l+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUZ89JiY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUZ89JiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770408297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVzRirf5XaErG6vghkd96u/UVATWDd6WInoiZjFSHEI=;
	b=WUZ89JiYFlP9MECm26ufVd2lfixF4JVvb1YViAJhfsENVI49qeptDbgwKRREAoVlvM6uGJ
	5rcgzkbgTGiLcJQjBvF/02/Mh/4M1EtliGKcA4QGFvBPrS+pJ5ZOssvmLSSpYEuzDLloBm
	AzfGy25hgSS9G+pzhFI+iNocX8lI4r8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-nY0d7-k2NBi4sm7Z0JqZ9A-1; Fri, 06 Feb 2026 15:04:56 -0500
X-MC-Unique: nY0d7-k2NBi4sm7Z0JqZ9A-1
X-Mimecast-MFC-AGG-ID: nY0d7-k2NBi4sm7Z0JqZ9A_1770408296
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5014c9ee70bso36141851cf.1
        for <audit@vger.kernel.org>; Fri, 06 Feb 2026 12:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408296; x=1771013096;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVzRirf5XaErG6vghkd96u/UVATWDd6WInoiZjFSHEI=;
        b=wS/tzH8cYGYFkqX+kERSimm6xrtbGRw0VafMS/AZ5nDNC9yNUUL/YcRjxFQhJcQBk8
         MUN8vHvCq5bl1M0FghUnzdS9IBz1PLd7Y88lOyYjk0IxagTe+RYmfz/bqqGSdXjX0BIy
         kSU5R5zwbuM1bSlw/w9CZa4fSQe5gVF+V8XS9b7dksWxdjocJpzNAxgfBEQ+mQgJrSXH
         0uuOBYaRJr4Dh26a+UbutsODfOVdaJGj+DzDfI01I28OHfetPVc9n33RSO2HpBhHoj3k
         +Zk/6wHQvUVCq/7e38OQBMUKHaqOPJddId/+tYJEbSxCryF8suxCWJ/1lltJ/PmLVrfd
         fFVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/pEtdElmDueWGjFcwWjkysZOpemgrAQL3Jgw4Eq8LR6Am1mqLVck9F8SSugM4Xr6tlFP1SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXU1N67xdmreIgjM/cVJk++PddXf8ADS19xhRvTepE3xRwHc66
	VJ9ppW65vrna0xuaxrLFav7oQwDDGOZC1iu9zDOGgZft3mbZU+EL5DJFulaKsvw8CQvhJ7U4Fwm
	3V5jykjw0y2ZTZDfU56Wo4lSi3YSlkserPuNw8lRNPzl8lH/embN8KnEnHtFd0tL4
X-Gm-Gg: AZuq6aKfpKJGKXcy0QVsrbKf4wSqvVU0P/77cHziGskJVazarwq3+/83Cg8ezX9KeMP
	3eUah41mxhlH+x949rGZM+eXIMArBixGKQUggDC31q1Uh5MxOK/9134xnzUEvqp6qOws4O5SGaI
	k/6YijszA0Dco3TDxcROFR3swaCkyvF+/PZsqMQBR8eBfSyOY8cL/hydSk5y6IFg4fkx0R/xgIh
	vu+ypaN5VtPDVvav1dw2IHmaJaRMsLZnBGnLL44/qgCvcx6ZM4rXeErKgdg14IaDYdVU6tif6jy
	DomHAAjDjDN9pLpUk7E9GDctjGJSa2EXLwwErDZxsZhUMNPI1rtN+VlR+KvwlMEao5PQPPslIDA
	IwC0EFBKzfvwVgBYJ5N0HuLkVh4XfR9jagOYjg/91vVX5RuZ3tKVjpVrz
X-Received: by 2002:ac8:5a44:0:b0:502:ba2c:b492 with SMTP id d75a77b69052e-50639a2b22emr53041551cf.77.1770408295870;
        Fri, 06 Feb 2026 12:04:55 -0800 (PST)
X-Received: by 2002:ac8:5a44:0:b0:502:ba2c:b492 with SMTP id d75a77b69052e-50639a2b22emr53040891cf.77.1770408295255;
        Fri, 06 Feb 2026 12:04:55 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89546b09f87sm8021606d6.34.2026.02.06.12.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 12:04:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5cb07c57-9dca-4086-af88-f866f765c7fb@redhat.com>
Date: Fri, 6 Feb 2026 15:04:53 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Waiman Long <llong@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
In-Reply-To: <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 21SI9J898t3g6NnDOa5UgR-FZ_JlpPaYk089xgwcobY_1770408296
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/26 2:16 PM, Waiman Long wrote:
> On 2/6/26 12:22 AM, Al Viro wrote:
>> On Thu, Feb 05, 2026 at 11:11:51PM -0500, Waiman Long wrote:
>>
>>> __latent_entropy
>>> struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
>>>                  struct user_namespace *user_ns, struct fs_struct 
>>> *new_fs)
>>> {
>>>    :
>>>                  if (new_fs) {
>>>                          if (&p->mnt == new_fs->root.mnt) {
>>>                                  new_fs->root.mnt = mntget(&q->mnt);
>>>                                  rootmnt = &p->mnt;
>>>                          }
>>>                          if (&p->mnt == new_fs->pwd.mnt) {
>>>                                  new_fs->pwd.mnt = mntget(&q->mnt);
>>>                                  pwdmnt = &p->mnt;
>>>                          }
>>>                  }
>>>
>>> It is replacing the fs->pwd.mnt with a new one while pwd_refs is 1. 
>>> I can
>>> make this work with the new fs_struct field. I do have one question 
>>> though.
>>> Do we need to acquire write_seqlock(&new_fs->seq) if we are changing 
>>> root or
>>> pwd here or if the new_fs are in such a state that it will never 
>>> change when
>>> this copying operation is in progress?
>> In all cases when we get to that point, new_fs is always a freshly
>> created private copy of current->fs, not reachable from anywhere
>> other than stack frames of the callers, but the proof is not pretty.
>> copy_mnt_ns() is called only by create_new_namespaces() and it gets to
>> copying anything if and only if CLONE_NEWNS is in the flags.  So far,
>> so good.  The call in create_new_namespaces() is
>>     new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, 
>> user_ns, new_fs);
>
> Thanks for the detailed explanation. After further investigation as to 
> while the pwd_refs is set, I found out the code path leading to this 
> situation is the unshare syscall.
>
> __x64_sys_unshare()
>  => ksys_unshare()
>   => unshare_fs(unshare_flags, &new_fs)
>   => unshare_nsproxy_namespaces(unshare_flags, &new_nsproxy,
>                                          new_cred, new_fs);
>    => create_new_namespaces(unshare_flags, current, user_ns,
>                                          new_fs ? new_fs : current->fs);
>
> Here, CLONE_FS isn't set in unshare_flags. So new_fs is NULL and
> current->fs is passed down to create_new_namespaces(). That is why
> pwd_refs can be set in this case. So it looks like the comment in
> copy_mnt_ns() saying that the fs_struct is private is no longer true,
> at least in this case. So changing fs_struct without taking the lock
> can lead to unexpected result.
>
> Should we add locking to make it safe? 

I guess if private means fs->users == 1, the condition could still be true.

Cheers,
Longman

