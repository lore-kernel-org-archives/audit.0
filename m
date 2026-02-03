Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BA2FD1C5
	for <audit@vger.kernel.org>; Tue,  3 Feb 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150732; cv=none; b=CWf/OwOEWVip085k2FdY9RqACAcG1936B2MpveQFefJF/bqv032I8NFkx3+G9v3/Qjj8LrANnxraMfPi2sfVtDiwwzjvE3Q8nJFIDkNf7oXgtebMxcBLsjLH1uXx5IiffVH2NrrI6pcuipq78N3Byef8kZ1DpdYxqCeS1BjdZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150732; c=relaxed/simple;
	bh=oRC6tKvvEj9AaBHGot8WNopEmaDChGLIc8MKjI+lHxA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AJi40kB5zvCmllUhlMKy7/t4B046Y6GjPc46fuoq1/V7xv7Z5yDAG/eUYBiPuMjg0IGLwJEl6rUYZFdTNzLpf/yX8w/DSCsjCWj7Urx5xycaPz+al8fA9731NMdffONkxlxammLgjXRZ3N+VV84YidEKWWt09R+RNHf1e2fy8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ol00R+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ol00R+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770150729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7L1FzLWR80XL9pfS0ZqYqfha235I3U5glTbWqm/on4Y=;
	b=S8ol00R+0gKT5EO7oVTeOjI9tfiqtzdQFEnJkT8l7nvv7iBuJRmp49Tir5cCBqSS2YzP30
	KuNqyIHIHynVe+geuSw1f+SECyrAwH7Qx2Y1WxdkZubDjcNhS4agw2HKSpsSHV5uaHc4gR
	7s5tjbbSWpb8vniwZig0MKO1T0eDh0I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-9XlRbGHjP5eFvmj-bEeVIw-1; Tue, 03 Feb 2026 15:32:06 -0500
X-MC-Unique: 9XlRbGHjP5eFvmj-bEeVIw-1
X-Mimecast-MFC-AGG-ID: 9XlRbGHjP5eFvmj-bEeVIw_1770150726
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-503342386c7so198002281cf.0
        for <audit@vger.kernel.org>; Tue, 03 Feb 2026 12:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770150726; x=1770755526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7L1FzLWR80XL9pfS0ZqYqfha235I3U5glTbWqm/on4Y=;
        b=hNus0b1MuIlicorYYA7yLAeTda2FcXhNmAxyumtY7tJbAwGCPG2Tyg002wEnmMVSl0
         RXHMMfnVlmWUbzG4cTDt4TJv+k67EXJQrPenTyxleO5H9AqBJftJVJc/814Bj/b6sus1
         7RBo880o1VxheAHFNuZGMwjGWibGPXQHE2tYORmEucXUuaTafwnrOmFjdi3iMx6m7Bri
         7YjIT/3iG2Sk/mZURSckrM4hwz5I5cOfeHIbgc1PUNzy0S+t6wjNHl6p9eRM4hIqriKq
         smz809oOEVNOZMHVQNh0S2voFy6jGv375tkpHO36/xh4P9Zs1b+Te1c+VAUwx8kHT9Fc
         NnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo0Ri4397hb7s9n68C2CUuTtozkdCxYePuTLxOFGAicdfAgstGpqb32QcQ+kB3jIwPspDTWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/91nNYzhixkfj8F4qKeeH5uZ6RcijgLuudyeC5y08XuBUa97
	YRBNr6tOYNP/XlLuQO8CCccolTtI5/uZbeMfI/OFBUzJBReHOmsY5sAGLU1DFRlMHD3RqNWq/jo
	FbMzYl6p/jwsZ2Dw5UGfBJa4PncfSXrrYUPQ0XmdeskFUsHtP8QVGBW8q
X-Gm-Gg: AZuq6aKi3UP7FoGQk3PK1l9lwUr+mg9grqd1ZgNpc9oAScb77eV6IadUJ2OuvHHCzyN
	Ew9Z2alrs4ZrcH8rpNZywRXggsn6arpX+cVIXNZhcRHv7qBNQaWYWtXrfHSALrIzFTWXC79Z4hb
	9vwScAmhpwsSFG+F/wMzVGvDau/9BfGJlRDsv33HC6Q2N2SiWJZRQGWZ++qsW9L2oehTJHrBo+G
	wB7IqbyHO89me/0N+IUdXxr6w/yNnoqhvwp3z8rSownMsZVYRzSDVFFSywiN6vqFzLLhn9RWt98
	X0RyMOm5vDhFw+wG1AhwcjOUR+IgB2E1fFUVfeFYSJ86h899O/qDd8jfN8Yxl/h49Cq+bvfFoyM
	t9KaNwtc4lt5c5eJJu5B6rqVPXac5vccAwriprOVOlZbtABg53AzJDw3y
X-Received: by 2002:a05:622a:1809:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-5061c0cb0b2mr9458311cf.19.1770150726180;
        Tue, 03 Feb 2026 12:32:06 -0800 (PST)
X-Received: by 2002:a05:622a:1809:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-5061c0cb0b2mr9457911cf.19.1770150725770;
        Tue, 03 Feb 2026 12:32:05 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c1f7764sm3057731cf.23.2026.02.03.12.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 12:32:05 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
Date: Tue, 3 Feb 2026 15:32:04 -0500
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
 <20260203200505.GH3183987@ZenIV>
In-Reply-To: <20260203200505.GH3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZXy6NehNxAUBvGBK1symKYTq4gmkn2nOvfUTO59-IM_1770150726
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/3/26 3:05 PM, Al Viro wrote:
> On Tue, Feb 03, 2026 at 02:44:33PM -0500, Waiman Long wrote:
>
>> diff --git a/kernel/audit.h b/kernel/audit.h
>> index 7c401729e21b..03f3539b10e7 100644
>> --- a/kernel/audit.h
>> +++ b/kernel/audit.h
>> @@ -133,6 +133,13 @@ struct audit_context {
>>   	int		    name_count; /* total records in names_list */
>>   	struct list_head    names_list;	/* struct audit_names->list anchor */
>>   	char		    *filterkey;	/* key for rule that triggered record */
>> +	/*
>> +	 * pwd_reset is set if audit_free_names() has been called from
>> +	 * audit_reset_context() to reset pwd, but pwd is still holding dentry
>> +	 * and mount references to be used in later audit action without
>> +	 * the need to reacqure the references again.
> That's a delicate way to say "we have mounts stuck busy inexplicably for userland"...
>
> Generally a chdir(2) away from something immediately followed by umount(2)
> is _not_ expected to leave you with -EBUSY when nobody else has been doing
> anything with the mount in question.

That is actually a concern that I have at the back of my mind. I can 
modify the patch to cache only the dentry and do get/put the mount every 
time which is much cheaper as it is a percpu counter.  In that way, a 
chdir(2) followed by a umount(2) shouldn't cause a -EBUSY. Right?

Cheers,
Longman

