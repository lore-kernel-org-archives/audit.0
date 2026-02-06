Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F362D9EF9
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351602; cv=none; b=E6zyv/sSB0xIzBVg10K1XBdqZPcybyVTmowujO/2GRf2KMyRnFChedh/Z7XbLF2cQUHNbR45Wprr/Z60DoaUx29u6fOHYcLCHtJH9cZ02MnK2N4jOJ8iaQzxNpYi/W04gHzStEYWN1pUfoG/zlpNtY4eIlyLDmc/6LCJBx6NvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351602; c=relaxed/simple;
	bh=o/siDAMDFeybMNav05zlB+FG9dYQgIQoLHR0jcIDqps=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fll55iD7UZuKUl1mYgv8SXmty0v9wQVen8k6VXaqX8JxtZe7AWm1UcUWBOg0FV/KVt5sCtG8LOcLXXiu73a6kyUsaD9Lvi2eLYnKXMcEqvZW+P+W1Hu+gWoylf1sy8iezgr1Fi5Vp9vnUX8TdWdGH38xIvlv5iBnhdfwV51cGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7ZDOHKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7ZDOHKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770351601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5FsNubkCMbpQGFmT9U+rlcEe2nNrmz/u6Yd1lqWSF0=;
	b=P7ZDOHKEsPb4wAqE12V3F7rOJAhJMephTTlj/FpOYMA1hhhuwy56Nd/L2uJRTEP6vSc7NV
	KiUVVkVNLiCvNVU9wTGRxsHzmqaCX1KioGxZk1OHUyC4VXC3/XHPrqsU9HbJQAv9FBhERV
	1VPKRPTl4MRJt5FbJC9ADeSXDOjQMeI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-MRHId148PMSptbNStVH9CA-1; Thu, 05 Feb 2026 23:20:00 -0500
X-MC-Unique: MRHId148PMSptbNStVH9CA-1
X-Mimecast-MFC-AGG-ID: MRHId148PMSptbNStVH9CA_1770351599
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50355952ac2so46600361cf.0
        for <audit@vger.kernel.org>; Thu, 05 Feb 2026 20:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351599; x=1770956399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5FsNubkCMbpQGFmT9U+rlcEe2nNrmz/u6Yd1lqWSF0=;
        b=akZ1+qwh8DjBIZW/td258qwVWUohS8lpouX7T1sPJCvDTXdb1traaZGe8szXCoxzhX
         Lej3UdCi89/C9z7tUv6kw1uioNbHEafMiCitQZ75A54KmVFLXSIVveHv81exE3PFRZDL
         FxDXcBfSBq+Zz2K6HWvbgLiEWQ6vhh/WjZSQLzsSlVjL3qvn8cXijCmnFdWGISX9jrzQ
         G9TDkp4zxrWQjc93s5dEucyFC3AbKm0DSE82W9oDDc66sbZJi84eB5Mpf4QfDyKN+M3Y
         CgF9mF7o0ew1GSrb483KUxHglxYfF6bBlADyb5dCHHQVmWqbuRytWFc5iH3w5yYKDK3s
         lFFA==
X-Forwarded-Encrypted: i=1; AJvYcCWfipVvuKjMHwaPe+BnF5kox6gR+s56l2wghM+6lf/f8v9jjCG+YhxxQh79PHq/L1K5A4izUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeaXneBb9bOBHnfFA+p21U4cUWqk7QQkH1QBEz0PMyc77TtuQ
	zOt4MYAgRGPS7I0D7qNc2lojnMdAPJ4lZ9fZ+ERTtwooyHma3I1JA3jvXLSlDGSjT3tN4JN9uAm
	4C9wwnWLg5v/cgh/9C7NS1fpGChosdLUipTiwDvnOzLLqfDqcc2+yglOa
X-Gm-Gg: AZuq6aIFELUKIZuWICSHNpee/NGvKz3MWLhXnEMUSzbGYd3LwHP6DI4+G1iQp8ffgVK
	tb72msV6VZtqwdYbtTgF+eVSaaUEe2h/5GAsR+L5ikHASP/5bZKU7p/6ixuZgnUw4KG0uGAlKmS
	4E7IV5YQRczLpY2w7MH7V6A68rKThgQEKtVjfEJQnwNGKE0Ix1hKIP5t3swSrnXXaPNsfx1Uku6
	g45AbI5OlksXccP1IhOz6/4Tki/yx40u6A8Y6JPQxTmf+z1Y8RJM4z0OzaX3jm0ifY1wVUlMWcE
	XL8cILNjvMna27D9Iy/911F68Zy6f5gTQIv4lFgvdtb8vbo3cx/xr2GJ3UZnUICcwt1rMAHGrGC
	giHUW7HhYBWjnlNayjzn/8pdYVzAQ+Z8VAfgTUi5EZaDU0hMlWg+JqFYC
X-Received: by 2002:ac8:5705:0:b0:501:452b:7f5b with SMTP id d75a77b69052e-506393b6928mr19531761cf.32.1770351599397;
        Thu, 05 Feb 2026 20:19:59 -0800 (PST)
X-Received: by 2002:ac8:5705:0:b0:501:452b:7f5b with SMTP id d75a77b69052e-506393b6928mr19531521cf.32.1770351599004;
        Thu, 05 Feb 2026 20:19:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063929099asm8347111cf.22.2026.02.05.20.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 20:19:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be783cfb-ef65-4546-81eb-5eb6a18d4ef5@redhat.com>
Date: Thu, 5 Feb 2026 23:19:56 -0500
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
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
In-Reply-To: <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r9IlJdMKmPFbkYPqurtYnKBdxbHK3L5qiQQ1hMRm7Eo_1770351599
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/26 11:11 PM, Waiman Long wrote:
> On 2/5/26 8:20 PM, Waiman Long wrote:
>> On 2/5/26 6:53 PM, Al Viro wrote:
>>> On Wed, Feb 04, 2026 at 11:45:17PM -0500, Waiman Long wrote:
>>>
>>>> @@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, 
>>>> const
>>>> struct>
>>>>                                  count++;
>>>>                                  path_get(new_root);
>>>>                          }
>>>> +                       count += fs->pwd_xrefs;
>>>> +                       fs->pwd_xrefs = 0;
>>>>                          write_sequnlock(&fs->seq);
>>> Nope - you only need that for threads that have ->pwd equal to 
>>> old_root.
>>> Incidentally, I'd forgotten about that sucker - it kills the idea of
>>> fdget-like tricks dead, more's the pity.  Third-party modification of
>>> task->fs->pwd (under task->lock and task->fs->seq), possible even with
>>> task->fs->users == 1.
>>
>> Yes, I am aware of that when I took a further look at the patch that 
>> I sent out yesterday. I am testing the updated patch now and is 
>> trying to figure out why I get a warning from 
>> mntput_no_expire_slowpath() with a count of -1 when doing an umount. 
>> It is off by 1 somewhere. I will post the patch once I resolve this bug. 
>
> I now know why there are warnings. The problem is in the copy_mnt_ns() 
> function in fs/namespace.c:
>
> __latent_entropy
> struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
>                 struct user_namespace *user_ns, struct fs_struct *new_fs)
> {
>   :
>                 if (new_fs) {
>                         if (&p->mnt == new_fs->root.mnt) {
>                                 new_fs->root.mnt = mntget(&q->mnt);
>                                 rootmnt = &p->mnt;
>                         }
>                         if (&p->mnt == new_fs->pwd.mnt) {
>                                 new_fs->pwd.mnt = mntget(&q->mnt);
>                                 pwdmnt = &p->mnt;
>                         }
>                 }
>
> It is replacing the fs->pwd.mnt with a new one while pwd_refs is 1. I 
> can make this work with the new fs_struct field. I do have one 
> question though. Do we need to acquire write_seqlock(&new_fs->seq) if 
> we are changing root or pwd here or if the new_fs are in such a state 
> that it will never change when this copying operation is in progress? 

Ah, there are comment above saying

         /*
          * Second pass: switch the tsk->fs->* elements and mark new 
vfsmounts
          * as belonging to new namespace.  We have already acquired a 
private
          * fs_struct, so tsk->fs->lock is not needed.
          */

So I guess it is safe to make change without taking the lock.

Cheers,
Longman

