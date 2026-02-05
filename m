Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201C3ED13E
	for <audit@vger.kernel.org>; Thu,  5 Feb 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299958; cv=none; b=BZd6wXaWATDz4rlBeXG86VJQywt/A95gqG2WzJ8uHec9vKkA0OJDfrRW9DNpMz4GuzoGjYGQ9RXMac1zs1tXzdEHQ0j31y2iiRHFEthydVBXkhHk+gueAfQ8oBIIagCT0EkqUA2r4BZNZYMS4jh2sh4CNv5mKr2z57qJm8X67tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299958; c=relaxed/simple;
	bh=nDUImYwv3xbBLPKMXbwxRdbKJATnW3Ud/fc7GGcNKWc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B4QAIeYcln1hwPws+YDJdoQAEVDtbZzRbHJLHamCyLY1Nl8MKbRSNpoE/9KS+rPXvaU8fNIYXok0ufoTuUNI1z3W4QDAfv+QfliIzKzbaID/ehfPAzGLoKj16aAZyI4vYRTAlpbABylSWyVKFoPBimMsZNe8mKVwVDDAYLnW/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1d2rvaA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1d2rvaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAdYEapv7lODz+jvkHCW5ylaWbeiRic5ErFk+82ErKM=;
	b=W1d2rvaApHfXpmEaSMIZPCYULjWnysUgfs3QisOyEMjwoAiA+WgAx/X46D0hPJBrgONLq3
	/qZBeNfTBIXY/c54+ulgOH3TKbx2L3/d79UzfvOn9uIKh4v9jFQt8vGUq1ZfW+En8M9zHH
	DTsn/xkJ4D2Lc0YQmeA65t3OWmmX2NM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-RLnWujJePR6KFiBkMbdBhg-1; Thu, 05 Feb 2026 08:59:14 -0500
X-MC-Unique: RLnWujJePR6KFiBkMbdBhg-1
X-Mimecast-MFC-AGG-ID: RLnWujJePR6KFiBkMbdBhg_1770299954
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89502dfd7b4so29373946d6.1
        for <audit@vger.kernel.org>; Thu, 05 Feb 2026 05:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299954; x=1770904754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAdYEapv7lODz+jvkHCW5ylaWbeiRic5ErFk+82ErKM=;
        b=hfZg6KOFzjirN9dgHAUIOJn+pEastuCfsTq8oA2eQKI8OcI9XylRenY9Ka/no3JL9G
         f8i0erm9vlcyxADf3ACVxfv62/NSg4/q+Ru45SL+HxIeatIrqyesZg31nmtlvs8+ER4p
         ppj1IG4b44UBgEwbKmTHJ/T+Okfa8tve2MkF7MjABE096oxZOP+481fMk3i28R5Qef6z
         QrLiNQVQ2XLHdbP2kvxVbSwd+PsfPt8zQNHT5Ywuxh4rBcDUqL3GPn30Y/UC/6iAhj1w
         dQ6NOcADnKyOB3ZOH6Lc5oPAZF1oB5GrKhnmPSBOR3vGxiXmfbsKo2EJ1VNOygdE0OFN
         k89w==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZNS+oCnz7f+N52F3jdwenDwlppNQrLMHLVVRqtRl6F4X8uHrtaUysZIbsKG6PA9oesXMRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyI8r+Dma96uISJ6JGHn+w0AgO6TWqb8MWMz+sopsgaGNAnhuk
	XuXS+qCrPMV7I1wqBrAHKx9t749DxfUnpWz5RAV7g/+SiZIj6EnTPtglCAPOqfC/osLwAa/Sela
	8b4I3nIbPA+yBiP44xIP4sSo4pibzLidQJC2GaRJwZdTSqRdCN64Zmi7d
X-Gm-Gg: AZuq6aKe9W6GUjdgG8JQQ63IElSe5LmnsD45xv9VfYIUJCaQ31hm6mfkRI1nsIh8dM2
	Vpsr75zze83pNa1pyxRkkDuRRy4fQt9NqsJXJyJH1bc8gdEAaOdSXd4K5h04X4yZEuv004OywMC
	mRtXSvIjuApnVdYCGVDLfzACK0M9sAz+no8/lSyb9xgZKdrYUvHsN34hXRNtLrc1pDSpnuVuaDj
	M0svv346tVDwpcbqsOHLDhOe4ZyFbbnZQpVP/I3rRTtFawKI6l99X+mdwMxId6eVJ0DSYX0jA8P
	3p6PjN+lMYuJHSL0n9mRePQ5hCV+MGc2fEFd4MKq4F2113uDBkS8Vc6GDk4eBRqEjhrTe/Cv4C5
	j2t9mKttdfdvfnIrUui6IVmL4wy4Otnp+BpDOUcfDI3zqHJxAaeRSpAHN
X-Received: by 2002:a05:6214:1d09:b0:894:61c8:930c with SMTP id 6a1803df08f44-895220f1304mr96893266d6.6.1770299953844;
        Thu, 05 Feb 2026 05:59:13 -0800 (PST)
X-Received: by 2002:a05:6214:1d09:b0:894:61c8:930c with SMTP id 6a1803df08f44-895220f1304mr96892996d6.6.1770299953448;
        Thu, 05 Feb 2026 05:59:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bfe8c4sm42408926d6.2.2026.02.05.05.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:59:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9e794b81-3a16-4380-a397-5e58dd5fab78@redhat.com>
Date: Thu, 5 Feb 2026 08:59:11 -0500
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
 Ricardo Robaina <rrobaina@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <20260205052202.GQ3183987@ZenIV>
In-Reply-To: <20260205052202.GQ3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bt167aIBgHU8Swa5egBGDkfE0XmwGr5lMAfY_wMtyv0_1770299954
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 12:22 AM, Al Viro wrote:
> On Wed, Feb 04, 2026 at 10:03:33PM -0500, Waiman Long wrote:
>
>> Now I realize that there is indeed a deadlock problem. Scrap that. Now I
>> have a simpler idea that shouldn't have this type of deadlock problem. So
>> what do you think about the sample code below?
> That it's rather bizarre, TBH.  Basically, you are allowing to park
> a number of (identical) references in there instead of dropping them,
> with your 'xrefs' being the count of skipped drops.  get_share either
> clones a reference or uses up one of those skipped drops; put_share parks
> the reference if possible.  And set discards everything not used up...
The basic idea is to have a pool of extra pwd references inside 
fs_struct. When a user needs a reference, it can borrow one, if 
available, with the get call and then return it back later with a put 
call. I envision that the pool can grow to the maximum number of 
outstanding get's that have ever happen. When it is time to let them go, 
we could implement some low level put_many functions to get rid of them 
in one go instead releasing them one-by-one which could take a while if 
the pool grow big. I am not good in naming, so please let me know if you 
have suggestion of what naming convention should be used.
>
> It could be made to work, but... ouch.  It looks like a special-cased
> variant of something fairly generic, with really confusing calling
> conventions.  Let me poke around and see if we have any other candidates
> for something similar; if nothing else, current->fs->root is interesting
> and not just for audit pathologies...
>
> Note, BTW, that there's chroot_fs_refs() to deal with, along with
> free_fs_struct() (at least).  This stuff is encapsulated in
> fs/fs_struct.c and include/linux/fs_struct.h...  Oh, hell.

I have sent a follow up patch with changes made to other part of 
fs_struct.c AFAICS. Of course, I will go over it again when I am making 
an official patch. However, I haven't looked elsewhere outside of 
fs_struct.[ch]. I believe the change should be pretty self-contained. 
Please let me know if there are other places where I should look.

Cheers,
Longman

