Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB934C981
	for <audit@vger.kernel.org>; Wed,  4 Feb 2026 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178889; cv=none; b=gn/RcZsopwPab0DDft/+Et5JurS9UJ2I7pniAVy4GLuEi3UbKnhYG0WhEYA9PKhP3enAgVKIyRQMLwL0FeAY8zzNcEILqtrlrlIb+YRJA4XuRlDnV0SpPnUe/Jx0Ernb8g0JOAkde8wZZMYcu4qKZsos8KosTGpljIrVTszHpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178889; c=relaxed/simple;
	bh=PzQQ3B/+w7hS3/ALA88P5mujhAE3S+HZezzvrGHmRME=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q9plNoU9HwS1HE3iun4oPCq1EF59yztHLNXREm1JeZGZBKJ+SNoXONncszi77RJJy4xAUIpN55l2Jfp6nvVRwaJflBCYNc+bW6UEMC6mRzow685GXUCqjU0/hXua2B2AAhXCoAbeuapf0vWSAtknozofk1dT6Mg8aiUDEZ+r8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbYrLIIl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbYrLIIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770178886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcBbuF5wJvFTL0tuao0MoCA5GeDjlAU8Fd2jJuLQGU8=;
	b=RbYrLIIlNzwg+hbUOZH+diAt41r1NcK1Ts3IAEDiBGu5OXwLRmscQBPzi81GZvkn7LWZpF
	/o10+04MNMR5OaFR0Ph2zWTvGq6AGcjO2r1+xT8koIZK1g1vZNwkrZdjcf6tYOYBXTmn0p
	BlNzsAw70ufyXzJXj5fi6+sIW9G+pvQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-TfaaSlyHMZCeGDv31oo4eg-1; Tue, 03 Feb 2026 23:21:25 -0500
X-MC-Unique: TfaaSlyHMZCeGDv31oo4eg-1
X-Mimecast-MFC-AGG-ID: TfaaSlyHMZCeGDv31oo4eg_1770178885
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50335bd75bdso74654551cf.0
        for <audit@vger.kernel.org>; Tue, 03 Feb 2026 20:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178885; x=1770783685;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcBbuF5wJvFTL0tuao0MoCA5GeDjlAU8Fd2jJuLQGU8=;
        b=QhzZ+0Q01zom/5yj+Z0uQl4o7UhxB5gl3NPmbqMvQkzHmHP0g/Sld9uiysH5Eyyn0O
         sxaGoJ7uuFnZBqltfsgyzLqIiNUlLNqtwwHMZIGxUf4NFIF9rjLptM5tG5l9OPHEYGtf
         sOEcu/+7LWObGHcl4iRCPXQ8VB5y8yEHx9ZJXTcad9PvTr074KTxPccAnz2d/LfpZUvU
         /SEu4uiXUIwZWQdWvKNjTUB4h/b0mh0p106RLncKD85EL4+sgbAzWFSqrjGK0UoqrW0i
         WFbdmTyhHRPLfrvX95ASbe6NxyWXNB6XU7ykgZtySRc3CCCcHYhsp+x3HMxA8KK800Is
         XUUw==
X-Forwarded-Encrypted: i=1; AJvYcCUf4dELlhkLNfXxWzLxsbl7emHnormc7cjmLRsPKI7n7qz5CIEMMwu3nL8QTMrSISknEv1dOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOdpkGwhpVAIMaQWJjxMzcWrwJXIbYDVzQFEERunkxqjzL4+a
	SkZGkkeOoU5T8nC5fKX67EMCRcHr/+Y3Qwv3aAzGYk/HA7fc80fLUW7FccIlLNiPW6RJx5cHLNe
	ocJ6hZGDveI55lN2LlSs4VmKWfG9u7g1fFOFwOLiRWOerRa0fephN1CM0
X-Gm-Gg: AZuq6aKd5Jyg2vNBi9wqni2OtS2Se+uBQEcGGBML4SoF0Enuv1JyqkGj2gZphZTUY0v
	j+Y9mfkst94dMHLfFGeBY9gk7BRsJd6ycJVIYqJ+LVjmNwFbBO8K8YKFO+/3NUqVnt+XBStPpYM
	B1XS1GPaT7ZlGWI7vQMgp0wJV7QskOHhjrcw7tGeZXSmk/tKyPv93+AP17CMzc8iGUqY2ne2X61
	nTskiauhZH/7Ch0uh4aVvwsrgAHe6sOhnOJmtXDp3Hgp6ge3VRCP3Y7xCVeM/PZzrGi1Yqtnz7E
	bsQ+t+rovFtTb2LiVITVZxMfsaILCN/deX956weZCPCB7pUylP4L5udHYUcp3wgyIoP9KTK5Lmz
	AjdTc6cfOmrKUlUvzSIv0jb+G63nZTsJkywDIqKIa7Aid+FCxHwpd8qBb
X-Received: by 2002:a05:620a:31f3:b0:8ca:3854:8110 with SMTP id af79cd13be357-8ca38549dafmr1977885a.72.1770178884833;
        Tue, 03 Feb 2026 20:21:24 -0800 (PST)
X-Received: by 2002:a05:620a:31f3:b0:8ca:3854:8110 with SMTP id af79cd13be357-8ca38549dafmr1976685a.72.1770178884482;
        Tue, 03 Feb 2026 20:21:24 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd5382csm108055685a.50.2026.02.03.20.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 20:21:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
Date: Tue, 3 Feb 2026 23:21:23 -0500
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
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
In-Reply-To: <20260203232634.GJ3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 26CoIIXjSJEIfB0xAL5P9QPeqMjbcvRH7fWIABFGkG0_1770178885
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/3/26 6:26 PM, Al Viro wrote:
> On Tue, Feb 03, 2026 at 09:50:02PM +0000, Al Viro wrote:
>> On Tue, Feb 03, 2026 at 03:32:04PM -0500, Waiman Long wrote:
>>
>>> That is actually a concern that I have at the back of my mind. I can modify
>>> the patch to cache only the dentry and do get/put the mount every time which
>>> is much cheaper as it is a percpu counter.  In that way, a chdir(2) followed
>>> by a umount(2) shouldn't cause a -EBUSY. Right?
>> Quite - it will just retain a reference to dentry, with filesystem shutdown
>> being very unhappy about somebody retaining references to objects on the
>> filesystem about to be taken out...
> Sarcasm aside, I wonder if we could do the following trick:
> 	* a new primitive for "grab or borrow pwd", similar to what fdget()
> does for struct file.  If current->fs is shared, do what we do now and return
> true; otherwise just copy the contents of current->fs->pwd return false.
> 	* paired primitive that would take a boolean + struct path * and
> do path_put() if boolean is true.
> 	* syscalls that might alter ->fs, ->fs->pwd or add extra references to
> ->fs would start with grabbing an extra ref on entry and drop it in the end;
> that would make that primitive safe to use there.
> 	* audit using that thing and storing the result along with the copy
> of pwd; on the way out it would use the "put unless borrowed" primitive.
>
> Might or might not be useful - hard to tell without knowing the job mix of those
> audit-afflicted production systems.
>
> I'll try to put something along those lines together...

Interesting. So are you thinking about a reference on the pwd inside the 
fs_struct? I am thinking about instead of getting a reference to 
pwd.dentry and pwd.mnt, we can just get a reference to the pwd itself. 
We have to grab the fs lock in get_fs_pwd() anyway. This spinlock 
doesn't show up as being contended in the customer bug report as each 
process can has its own fs_struct instead of many processing sharing the 
same working directory.

In the case of audit, fs->pwd is copied out at the beginning of the 
open* system call and then put back at the end of that system call. So 
it should last a pretty short time, i.e. the reference will be released 
shortly. However, that will make the set_fs_pwd() call a bit tricky to 
implement, but I think it is still doable.

Cheers,
Longman

