Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE51381B1F
	for <audit@vger.kernel.org>; Tue, 12 May 2026 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613159; cv=none; b=ftyjR8mbijDFHu0qg9dHh7GNQOvpmVkFk619m8CnRU8WQLP4XivK3ZmSOesebtj+CIdYJuyYB8MaGyPQ7LOmP20cHViQKwhSwRD9lnwMrSEDxy20wJyvmIarEInmF/P107kXQvQdgnzQmAsAP9jZzju0zGI8QmTmyHLPfKTW5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613159; c=relaxed/simple;
	bh=i9gm++O7V3BQT5CieMmipA90HVECAUmxaNsWBwBHkPI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RqL8LbuMp0NpKN0RJ2C7WPnV1UHWNqhWGOdwka93Abhg50mLdTQ/lHZ19kLFhOdXtDJXT6ZzauaJARaL5HROfjruCpI0WsYwO6DSsMn46ln/Siplwko5b/UYa87NQjjsdMaQ5CSnlmY01OKKVuDVNqnRvVBqswHKUAle/EakmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Us/vcoGW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Us/vcoGW"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d65f4073bfso808930885a.3
        for <audit@vger.kernel.org>; Tue, 12 May 2026 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778613156; x=1779217956; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2/2RePmAVzJ7jfmnqD6PsuhJr6xU+tFwvrW/Kgm4H0=;
        b=Us/vcoGWN6R3kNn972qJu5wTJHFWWxO0fbH2WMU2CozEwKe/CRHFErQoZI8tlJyOFL
         pgGK7URZUHg2LGyzmk3F7lKmKuT+rYnyWgE8A+M37fll6uIfbGNHE2bVZg6WJXPdg3NA
         u1lHsUTUr+wswh13UIPJHh1r/DKcN2hrcJ2KAl+PXmh75ZxyUOYcTWvX/LJAAyE58baS
         EckXSeyk5oTaBNR7mXvnQmTofZT+C4lygqMn2vLsaZrI1K5lxj4Z1BEIF+WVSNuBgoOr
         JT4fjDfoWw/NqSX1DlEGR3ZsTZciHgitN23OU/pkqpX0SrmF6WMEUsNQjsWra3u4rDk6
         X6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613156; x=1779217956;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2/2RePmAVzJ7jfmnqD6PsuhJr6xU+tFwvrW/Kgm4H0=;
        b=s34O0ojFRSBnwQKEZHVNZkHIBPU70S+IgRcbk1KyhouQQI+q0E7LWANwdrsXigX1XW
         B3rHktDJcFnFHXPDMf7K9tuBwUY+EoRhDev8FimCqVLbfRuLG56f0VtqXZUmnRTTsvgq
         9B78kFJTwikI7n/5SqJrh1sCh5H108NAtNF6vIOj8Cn2qZBo9EM3lcQqNFL4LS6xr0u9
         7CM/ltQvFfF7pFo+zIQxaqpl1Od7O3Db36wh0NIEW/rpkyFrcwASWNkoXFYo1pKRKyXA
         WM0Qpz0LF0ZvyclI6F6jMfSC/a3GYaNCi8wYEpWGt3/UruhKuj1ndMIs/Tw5fTRpMIq3
         lG3w==
X-Forwarded-Encrypted: i=1; AFNElJ9REOZ3Q6pRMUgk5j3STV57sssaYfbKc/vMv8jCKQXCcU3Y0AZKb+HvmPy3idez/KAY9JyUSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37BsqgoscWSPHZFB0/5NYkaf+oxMY+SRPixXjT7ql96NjJQr+
	03PzcXDKDVnIWVZmFr57wifG37MampUSGHDLmAhgjkFIc1eg9Vyyf/FdSXh1A2QsIw==
X-Gm-Gg: Acq92OE5gNmUk90FcfFeTnPoZUCu3o2QUNvKcZHnsWY73EnNyYM8XZxSZdmVOPgjVbO
	39ZR9+4/07/gc8Q4mH86tC6Sr6SKHhIeQ7uW5zL33fTE6yCI4dpTs2VrFXqG9YjKW9k1h14NANH
	uXnESQghRCQHN7+dr4GZLI1Mt3izM87XLwaRZEUW2nxsD4HJpayfZZldqwc87crUlxXb+mJUf8g
	N1D0fssFVdoOnp7yZX/12tdc6qGXsMSxlaSdPEGCE7L6wLm73HuNF7v0n6eT8NeE5znb9JFrEsx
	8ThMCpEA8ctNry3Z/ydjEq6AV4e0QabJ/yXq+9GFokzoJcZjFGQcVGRfTTXY6F2Ildqq6aR1TEj
	nQ7W00UrBmrbX5eDEzVEOSml8bP0H1QCcxSD/SQfXxq0xvKs8lnesFEHRZvZ962toN0rJb+2xnq
	2xnUSKoanFeEPPC20eqbUcHrnlyLJw9RfnsyEFyEuyvSQz4ixjT3ztkVIQPmGcCUHkiuso
X-Received: by 2002:a05:620a:29c1:b0:8c6:b247:4c with SMTP id af79cd13be357-90f882f7554mr45674185a.2.1778613155720;
        Tue, 12 May 2026 12:12:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm1394843085a.4.2026.05.12.12.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:12:34 -0700 (PDT)
Date: Tue, 12 May 2026 15:12:34 -0400
Message-ID: <402f11211fcab76b6410f3f57372c58f@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260512_1209/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, longman@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 2/2] audit: fix removal of dangling executable rules
References: <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>
In-Reply-To: <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>

On Apr 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> When an audited executable is deleted from the disk, its dentry
> becomes negative. Any later attempt to delete the associated audit
> rule will lead to audit_alloc_mark() encountering this negative
> dentry and immediately aborting, returning -ENOENT.
> 
> This early abort prevents the subsystem from allocating the temporary
> fsnotify mark needed to construct the search key, meaning the kernel
> cannot find the existing rule in its own lists to delete it. This
> leaves a dangling rule in memory, resulting in the following error
> while attempting to delete the rule:
> 
>  # ./audit-dupe-exe-deadlock.sh
>  No rules
>  Error deleting rule (No such file or directory)
>  There was an error while processing parameters
> 
>  # auditctl -l
>  -a always,exit -S all -F exe=/tmp/file -F path=/tmp/file -F key=dr
> 
>  # auditctl -D
>  Error deleting rule (No such file or directory)
>  There was an error while processing parameters
> 
> This patch fixes this issue by removing the d_really_is_negative()
> check. By doing so, a dummy mark can be successfully generated for
> the deleted path, which allows the audit subsystem to properly match
> and flush the dangling rule.
> 
> Fixes: 76a53de6f7ff ("VFS/audit: introduce kern_path_parent() for audit")
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit_fsnotify.c | 4 ----
>  1 file changed, 4 deletions(-)

Good catch.  I might reorder the patchset so this patch comes first
in the patchset, but this isn't a big deal either way.

--
paul-moore.com
