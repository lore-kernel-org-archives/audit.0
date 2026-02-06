Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42B337B8C
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 04:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351118; cv=none; b=ltB8H1YORetNXBq2GDzxTZaKYKJcRWmzVu8yLuue/j1G/Y+zAc/MdJqn9ycTs/zBzWaowJLArTgPkQDVAaU7Tefe2Vf3dMfO5G4feKeQjhGIoPfTYWrwyyBIrESUoIm+1XS7m5jXedStH32ZwYZUtMqsGpssNQwAwXOOnV8itdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351118; c=relaxed/simple;
	bh=CqNvcZdgbnxnxEFIdy8rb7bQtmODIxBiyT4JV8C9dzI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bPQ5qXPZftIboFJQgUJnLxYD01vQgjKxEhmdAhA9Qa5Ty/PrPgq1YBu/WPqFEFUCh1DYRSp+qx98DRFtbq2GJyzbGSVeAt50KO3SlCCn+2ikRxVHsQQyV9bbv07L3BQsEOblQF2Tc3f8k99+YtvvusZsw5ZWcEu/M+2rtXpZJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffpf8CnM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffpf8CnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770351117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMjRxnp/naG1oRSEXueH5gSgIvo1mJhYDvUVqD1MzTU=;
	b=ffpf8CnMpjHLd017JIdabBUJXUMn3fYfpliX1EM2FhBFGwwJ36MMQWEaQ7bw03QZ5mOVHX
	3tRNev/Rv6ywhqGouHg/ETWBiSCJEoyn8iy+AcHBuhpVR1tNRLKNqy5igmYm5sDoXNVaeM
	GjYLdP6A0fqicMLIBWraACdOoYIs65s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-bnYUCAhEPamMMjn2WRL3Fw-1; Thu, 05 Feb 2026 23:11:54 -0500
X-MC-Unique: bnYUCAhEPamMMjn2WRL3Fw-1
X-Mimecast-MFC-AGG-ID: bnYUCAhEPamMMjn2WRL3Fw_1770351114
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a289856eso790628185a.0
        for <audit@vger.kernel.org>; Thu, 05 Feb 2026 20:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351114; x=1770955914;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMjRxnp/naG1oRSEXueH5gSgIvo1mJhYDvUVqD1MzTU=;
        b=HgStn6D4IPAsu3J/nppjC6qbi00QnFtkYSkYyxSjfGnhzUTU/2ejyq7Y8MR0Mk289T
         l6jlh5wncCpCUVqN0FlJ+bdOl7x5dyA+H0YS9IOmWCAnXnLfLhgYzLz/Y19/ijo0NTKU
         wbvUZ12l+j4znmy4BcU650ymlXV4xiARrzReGeNxVYKh11xXUQLbNw6rLKNNQaopN1AP
         /19Y1jSl33GPK/A3O4bCgpp46RA4ucgNTs7U6G4ghhD4GUv3DB0mYW/rtQMS07dzKjRy
         XqYFUw/6DByYcHJOEOV0ARLnfj+3tOSEsj9KjemCz0/sm8kRXiSYm/K7mWTzeuFv+E0n
         3eaw==
X-Forwarded-Encrypted: i=1; AJvYcCVaFhFTpBpSGq4n/QmSjPHWTm3uIeVRRuLE5ZtXVUi3XWpRRI3FanOWKceOdPak1smxbBWx0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIoGYV13GiSP08yNLyZvyO6wN9gg+NDg9hzh3UwXqGmk9fo8d
	affjpS9faBWQgCfKwKkjO17zfQhAMsZ1qTqNbvKQ07KrRgAC65Yasxl5LkSljEZOBEikYGpskqd
	OxcxjhiapOI3LSf9gJY4NJhbuMOVYJEaBBZvt9ginwc0zdOBaZTP88D7P
X-Gm-Gg: AZuq6aLISyAy3frCpn+DJvTmIl3zbo4oryKJ3jvG+vlynC7kMf/Kauo1ysO4GKjHo2/
	TffWCVZPZ4CYokmL7dRtx2hD8/Q+jpEpu8iRyG2a0kQtCOEXgO95KJ5v15b1+0G8VRQ30MG/FZT
	fPchXT4WXX0TReMaPaArG1Xz5AcZXSchh99vwSm8fd90Hz8wfowqO9UXPULz9Wot2ecIn1ZKnMt
	egao1zw82MFXVsnrrFmu/ez/1bPZ1VNW5iERWflXsWntjKCTbDmlMyvXS4UrXkU/EiPw29I9Qu4
	uu9p7N0l34+gG1+k0FbFpe+Ujt+kP53LJvPaGN3dK5Iwo8klRCeEDqrdJP5aLTD1Lh6eVRewaPM
	owz0BWhf9/rItQjU6cnyEocksgbU/31cO56pCZL+7kVhsl68H+9mrd83d
X-Received: by 2002:a05:620a:488e:b0:8b2:62ae:acba with SMTP id af79cd13be357-8ca40c19340mr594442985a.26.1770351113816;
        Thu, 05 Feb 2026 20:11:53 -0800 (PST)
X-Received: by 2002:a05:620a:488e:b0:8b2:62ae:acba with SMTP id af79cd13be357-8ca40c19340mr594441085a.26.1770351113364;
        Thu, 05 Feb 2026 20:11:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c0759cbsm9628386d6.50.2026.02.05.20.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 20:11:52 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
Date: Thu, 5 Feb 2026 23:11:51 -0500
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
In-Reply-To: <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RwtlK-ff-xNNkBocm1kd4A5YotXmV31uhBF5Sf2Su_E_1770351114
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/26 8:20 PM, Waiman Long wrote:
> On 2/5/26 6:53 PM, Al Viro wrote:
>> On Wed, Feb 04, 2026 at 11:45:17PM -0500, Waiman Long wrote:
>>
>>> @@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, 
>>> const
>>> struct>
>>>                                  count++;
>>>                                  path_get(new_root);
>>>                          }
>>> +                       count += fs->pwd_xrefs;
>>> +                       fs->pwd_xrefs = 0;
>>>                          write_sequnlock(&fs->seq);
>> Nope - you only need that for threads that have ->pwd equal to old_root.
>> Incidentally, I'd forgotten about that sucker - it kills the idea of
>> fdget-like tricks dead, more's the pity.  Third-party modification of
>> task->fs->pwd (under task->lock and task->fs->seq), possible even with
>> task->fs->users == 1.
>
> Yes, I am aware of that when I took a further look at the patch that I 
> sent out yesterday. I am testing the updated patch now and is trying 
> to figure out why I get a warning from mntput_no_expire_slowpath() 
> with a count of -1 when doing an umount. It is off by 1 somewhere. I 
> will post the patch once I resolve this bug. 

I now know why there are warnings. The problem is in the copy_mnt_ns() 
function in fs/namespace.c:

__latent_entropy
struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
                 struct user_namespace *user_ns, struct fs_struct *new_fs)
{
   :
                 if (new_fs) {
                         if (&p->mnt == new_fs->root.mnt) {
                                 new_fs->root.mnt = mntget(&q->mnt);
                                 rootmnt = &p->mnt;
                         }
                         if (&p->mnt == new_fs->pwd.mnt) {
                                 new_fs->pwd.mnt = mntget(&q->mnt);
                                 pwdmnt = &p->mnt;
                         }
                 }

It is replacing the fs->pwd.mnt with a new one while pwd_refs is 1. I 
can make this work with the new fs_struct field. I do have one question 
though. Do we need to acquire write_seqlock(&new_fs->seq) if we are 
changing root or pwd here or if the new_fs are in such a state that it 
will never change when this copying operation is in progress?

Thanks in advance for your advice.

Cheers,
Longman

