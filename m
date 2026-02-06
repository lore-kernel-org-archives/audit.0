Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D12304BA3
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405378; cv=none; b=p/iWEBCUkemdG0pSALuLHNn71aRk1vedW4r+xb1S3uT4mc0DI/AEt4kK/+qZK16YRlOcahNqEdN3ULoHgT8cSJ4xFi5TSQpO8jFYINgPpBLf6mOWpPQhltxTMJuBijm/2MfUxj9P78tmdOATJLsS/5BtBMTJh4XtMro7CgjINXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405378; c=relaxed/simple;
	bh=oC0lyvpYJhQMDmrnOsS7KdALqcDcuMmhOpdaVq4Bmt4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oiAoE3nOYDpX6c3YYTiXY5Y9DGP6gGXgiyE6uCNiyFmg/GAV00F0DO+WFvi8REDsKdvd9WVzYrfeZVzkYtyF6OLxJ4xEB+dWDMWufQTRX09jUHqXpJWZ2sBRey0CfFRJjv8TdQRU1c1EpJ3BX8dXskDe+0FFfurgHS8UGCIBnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTXBA1kZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTXBA1kZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770405377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLrijLNXCiQLyqwcI/JuIJlx7kgTDM+X9LDMe7zXupk=;
	b=TTXBA1kZK1leqcHplcTE3ivZHcWu39gtSCyYlOB6AXjW+qyMPg6dh/fRL43u5IvCIGvDK9
	R1sBrWmTuKgH0XkHyJBUq8djXvTxq67xi6jhGN6ekc/h5cuaboTp2pXCBCjZ+p3AMmezcO
	WCNjdP94HdfU/isZNSBzO0SyHD668ow=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-b6qe8DVeOFaHp00DvcNQeA-1; Fri, 06 Feb 2026 14:16:16 -0500
X-MC-Unique: b6qe8DVeOFaHp00DvcNQeA-1
X-Mimecast-MFC-AGG-ID: b6qe8DVeOFaHp00DvcNQeA_1770405376
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c711251ac5so641530185a.1
        for <audit@vger.kernel.org>; Fri, 06 Feb 2026 11:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405376; x=1771010176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLrijLNXCiQLyqwcI/JuIJlx7kgTDM+X9LDMe7zXupk=;
        b=oFvmw2KVF4p7yp999fEVqSRboeIChaRD8kZOsuJ/Eoj5R3gVIwRvWxNJX5o6wFO0ST
         /V2p9kebZc4Q4slnDqL/2wNmU3G24KpOCsH4y2Sj3l8EoLJ2K696patIlFe/uc3Vo2PZ
         e6nHYFuSDISq3OVpujUiYbrm5/QMMpqLMy+EhXzL4Gfb0kBg9DzGTZ+adbkHsWUzV5rC
         X5YG5dE1z7oodi/68XXSvF4gJdLeNy3bsPGjZdwahqmeNkNvo+PK3Bwr7+TovccXgVUQ
         hQ+Sspdp7DUX62Eyr0Tk3Be3L6Cf0GSqOoQAM6DgFFdPyMtVC5PhxAyXXx/6Xunribuh
         4Pag==
X-Forwarded-Encrypted: i=1; AJvYcCUiW/eh5UGpxjRO3hezoWwG2lZSprzKRfc77Sh05cU2zgUF6ht7YrbzRD3PItpI3vVYpwenvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmH/AR2raGuQd5ogj9ViXr1DBJdqkjaM3E5zwjOFcjJmsvztM
	qtpVTh4uEDGgmrf2HLRkTp6IrA8LsRT4++NIZE91qW0Ubv5mwOJiyCo2l/+lWBhuawuNWj5Y8LG
	0L8yb8bmdS60FapkA3RflljyhKcyer65lZ+O8bZDYQdaaxEdSWuvGpkpA
X-Gm-Gg: AZuq6aLfhHjNQZ8a9TY0ma/efWCjoeM0/caoKB1ZWqeHvA4INqJZA9q3vSKoiKsd8dD
	ONXgVuUG3l66qdOyhynJuiXZwmVPhaad/8uW3Ij1gqdx5Lc4znJZH1el5iYgcqfUqAgDW4Ne6Vk
	ll6U+0kUVpQyPieyBC0lOSJ1Mr/VWfJ+b4wxTmxd6vOZ8ohYjiGZC26+PsystcWNxE7QxsbI+dq
	F7napZXLpB0MUNN9LoADwnNrUzT4ccGKKsu8ybubA7A8wR8Of0b5oIjeQfp44veEGQC/KkNHOeF
	XoHCDIf7ckZiJO6T4GV28K2h9vlFsW1VAIQ4lv9jK5KjUhZNDoNOwaa+Mn8Gb0pMb7dr1rLIzSd
	lDcBx/mYrCSakjuYUIlI2GQqwUIhuSe51iHslwO2Mpi4KGXpntfPaU2h2
X-Received: by 2002:a05:620a:1913:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8caf1307e27mr472833585a.50.1770405375737;
        Fri, 06 Feb 2026 11:16:15 -0800 (PST)
X-Received: by 2002:a05:620a:1913:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8caf1307e27mr472828985a.50.1770405375199;
        Fri, 06 Feb 2026 11:16:15 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068c10sm27317556d6.46.2026.02.06.11.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 11:16:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
Date: Fri, 6 Feb 2026 14:16:13 -0500
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
In-Reply-To: <20260206052218.GV3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NNnihitTF-CtZ607X-NsSxqK4ojx10yYivyPOIuIApU_1770405376
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/26 12:22 AM, Al Viro wrote:
> On Thu, Feb 05, 2026 at 11:11:51PM -0500, Waiman Long wrote:
>
>> __latent_entropy
>> struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
>>                  struct user_namespace *user_ns, struct fs_struct *new_fs)
>> {
>>    :
>>                  if (new_fs) {
>>                          if (&p->mnt == new_fs->root.mnt) {
>>                                  new_fs->root.mnt = mntget(&q->mnt);
>>                                  rootmnt = &p->mnt;
>>                          }
>>                          if (&p->mnt == new_fs->pwd.mnt) {
>>                                  new_fs->pwd.mnt = mntget(&q->mnt);
>>                                  pwdmnt = &p->mnt;
>>                          }
>>                  }
>>
>> It is replacing the fs->pwd.mnt with a new one while pwd_refs is 1. I can
>> make this work with the new fs_struct field. I do have one question though.
>> Do we need to acquire write_seqlock(&new_fs->seq) if we are changing root or
>> pwd here or if the new_fs are in such a state that it will never change when
>> this copying operation is in progress?
> In all cases when we get to that point, new_fs is always a freshly
> created private copy of current->fs, not reachable from anywhere
> other than stack frames of the callers, but the proof is not pretty.
> copy_mnt_ns() is called only by create_new_namespaces() and it gets to
> copying anything if and only if CLONE_NEWNS is in the flags.  So far,
> so good.  The call in create_new_namespaces() is
> 	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);

Thanks for the detailed explanation. After further investigation as to 
while the pwd_refs is set, I found out the code path leading to this 
situation is the unshare syscall.

__x64_sys_unshare()
  => ksys_unshare()
   => unshare_fs(unshare_flags, &new_fs)
   => unshare_nsproxy_namespaces(unshare_flags, &new_nsproxy,
                                          new_cred, new_fs);
    => create_new_namespaces(unshare_flags, current, user_ns,
                                          new_fs ? new_fs : current->fs);

Here, CLONE_FS isn't set in unshare_flags. So new_fs is NULL and
current->fs is passed down to create_new_namespaces(). That is why
pwd_refs can be set in this case. So it looks like the comment in
copy_mnt_ns() saying that the fs_struct is private is no longer true,
at least in this case. So changing fs_struct without taking the lock
can lead to unexpected result.

Should we add locking to make it safe?

Cheers,
Longman

