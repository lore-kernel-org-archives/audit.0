Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004632E73D
	for <audit@vger.kernel.org>; Wed, 21 Jan 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008176; cv=none; b=VGxAQmN83/QZhNVhwvzsLIrPYIr1pgzzheizWZuArEtGdVKyPPHAle14k++Wlsl7K1YsBKki94Uvxqu99Z/Gyt3oBgW1uuwhqbXDDGYdRp2d5SNN4EVXsRHwasfQCI1jglIXAxmw37ovhV8Rh7XD8sUmAkFhS0l2ohrZOvmoyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008176; c=relaxed/simple;
	bh=28sXgVNf0Wht5rKNeRqvJBtP0GkBUYCm5WU0V/hUUwA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nz+m+g1bgyzJtiUlMsdaXBB1JBVjHyCeBQZ+eZ2nGgVDnWQQEtE6PJjiObhQOc8YZQqUtTls3CYVK6FksHB2dUMjXqfff/RtMJhIsO7SmBfAwuiBNxOI4Oq2HdNumfI8wU4tPp2IyssXL2iXnhu+jr/iw4Sf/2zy4oxouVp57pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+eAdxH3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+eAdxH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769008173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uY+pt3bmrvrb1Hk1eTt5XNY/+OLl0+7wKbN4hRmyI3I=;
	b=D+eAdxH3xzeL/ssPWpweSMBFNpDYqx+MBuv34x1WV7Kpni4gjtSPsczTFTIa6UwTPtOMvJ
	8pJS28tcD9Cie0P2CoAIhrB3FyD/4Ouil4nzsWY6WbsweZ/pq/JKQo87r63eoCyLMZOxaE
	LXmr3siRJuFWO9TI4VxO2rWrpiiK2bA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-adcq1XstOt-XQZMg52FnAQ-1; Wed, 21 Jan 2026 10:09:32 -0500
X-MC-Unique: adcq1XstOt-XQZMg52FnAQ-1
X-Mimecast-MFC-AGG-ID: adcq1XstOt-XQZMg52FnAQ_1769008171
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50299d2e742so268124681cf.1
        for <audit@vger.kernel.org>; Wed, 21 Jan 2026 07:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008171; x=1769612971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uY+pt3bmrvrb1Hk1eTt5XNY/+OLl0+7wKbN4hRmyI3I=;
        b=VdWAC8tdBszyGufhh8ccbgu0DLbTZCvmvRo16SGOf1LBTV8jqQm5BgFys581nnjxAW
         UJ0NY7xF/m+HmisQgefAHwZUqhNWk22y6DRsWgzLAJ5K/2AbkyVvktXdFgCYJYS3aGOI
         XotL3TdthvChE+fiaOmK6lmjPBh6HRBrLWEFCg/lRqdj4nsnqkywiPOo8DKOD/f8ZbgH
         nMQSJjkbyXRDrDpyntQIiMNkm6jQLOcxFqaluaXOXo+PeDHhz9iA3r3eg7gdMqrBIEyT
         HPmgHzaCAmxTFs6D1OhPIM1jEr5p98Oz8VG6Wps57rjU4yZxHKy1zkP4QJay+ErWUrRN
         2asA==
X-Forwarded-Encrypted: i=1; AJvYcCWoqFzypiTDikAtj5PrMC+s0a4dWXQZsqILKQmHXeTbO8yPX3M7LayJindGI0WB6phz6jEJmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfvy8kg0SoiXS0fEpRnsoMnAQN2tOhhtnFq2wiaJRQord/1tAs
	dJkD2YzA0K92p7VIeBVsl/42NSgFKdeEps4P9So/uiaNYHs2i/Hi1fPuqJObpg3gPyykx8w1Y/V
	ZterWGd/HJ0ymXR1gQEK+BQO75qmynCFQ6LOJVuK7zEcWnAwYJ23eOVPo
X-Gm-Gg: AZuq6aKbHyC62msEfq5VGg+yLBspMsMumvAU78NQ2cLMCqJAvsOk5FP50N/eXZwqhUG
	aL7H+cyOJ+kXq8s0pyiwFIeti6ZBcrgsS/2V9us6V1KMa08lpvflsM5otQeZoh5+RA7JMJwFFjf
	QhuGTmqvmjDOtT9Rr/NJmVxUmzTqREk59lot/33CGBsLJLXNua4AgbjA/xA3KRBoJcFWf1FiLW+
	N+WKJAsezApzQ5PFMFj2OsiWEGW0g0Sx+a5gXy+pZAT+2e5TQf1bHR16G/lvLQp+nwbAfZBVC3t
	BZyUXTzNZEUTlI3kw4mgsEqV1JHAFbrKC158v5+EMo8i/smbuhQSfTvV3pBKDbWK07805fMFTOv
	rDmSAVlSG5TJWvrXL43WtllpyX+iCRbz2fYdjYSyf+8pp3aAoKjxLS3iy
X-Received: by 2002:a05:622a:4c8:b0:4f1:d85c:d7c3 with SMTP id d75a77b69052e-502a1f777b1mr265101501cf.66.1769008171501;
        Wed, 21 Jan 2026 07:09:31 -0800 (PST)
X-Received: by 2002:a05:622a:4c8:b0:4f1:d85c:d7c3 with SMTP id d75a77b69052e-502a1f777b1mr265100951cf.66.1769008171129;
        Wed, 21 Jan 2026 07:09:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f2a1sm117028691cf.10.2026.01.21.07.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:09:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <204e011a-582f-474a-980c-27c30620b8d7@redhat.com>
Date: Wed, 21 Jan 2026 10:09:29 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] audit: Quit audit_free_names() early if name list
 empty
To: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260121023509.410423-1-longman@redhat.com>
 <20260121031105.GB3183987@ZenIV>
 <84955de9-823f-4b3d-9107-f7d4aee38b88@redhat.com>
 <20260121052623.GC3183987@ZenIV>
In-Reply-To: <20260121052623.GC3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hwvOW5v6wYPLPhuIQasFYTYtbvllHmPetM9UU81NYUM_1769008171
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 12:26 AM, Al Viro wrote:
> On Tue, Jan 20, 2026 at 11:08:45PM -0500, Waiman Long wrote:
>> On 1/20/26 10:11 PM, Al Viro wrote:
>>> On Tue, Jan 20, 2026 at 09:35:08PM -0500, Waiman Long wrote:
>>>> Optimize audit_free_names() by quitting early if the name list is empty.
>>>> This eliminates the need to acquire and release the fs_struct spinlock
>>>> in path_put().
>>> Why would path_put() go anywhere need fs_struct spinlock???
>>>
>> path_put() is defined in include/linux/fs_struct.h. It calls
>> read_seq{un}lock_excl(&fs->seq) which, in turn, acquires the releases the
>> spinlock underneath the seqlock_t.
> Really?  Which kernel would that be?  On mainline we have
>
> ; git grep -n -w path_put include/linux/fs_struct.h
> ; $ git grep -C 6 'void path_put\>' fs/namei.c
> fs/namei.c-/**
> fs/namei.c- * path_put - put a reference to a path
> fs/namei.c- * @path: path to put the reference to
> fs/namei.c- *
> fs/namei.c- * Given a path decrement the reference count to the dentry and the vfsmount.
> fs/namei.c- */
> fs/namei.c:void path_put(const struct path *path)
> fs/namei.c-{
> fs/namei.c-     dput(path->dentry);
> fs/namei.c-     mntput(path->mnt);
> fs/namei.c-}
> fs/namei.c-EXPORT_SYMBOL(path_put);
> fs/namei.c-
> ;
>
Sorry, my mistake. I mixed it up with get_fs_pwd(). Will fix the patch.

Cheers,
Longman

