Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33C11707
	for <audit@vger.kernel.org>; Sat,  9 Mar 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946871; cv=none; b=eqJ/BAIvQqa46i+oJLxy2f/ghlCf/kxwmE5Ji9sz93j7NXJLNWYMnC4a5FzVyB04NBfDMz0LQNmTaF0PqD7JIMAkF+vMBgBs8gi2C7Jxv3kdPh5TQ8RAuLnZBBoM9wOvkYCYYQVUO2cis44Fi/ijMXYZjtBCDDzaco1XxweaMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946871; c=relaxed/simple;
	bh=PVSSW/TRZScbGAXptUtzNMhjOI0JAjP3o2LHf4YtFlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufZyJZWL/E8Tu+Y7TOfR3POfg4Z1BJh5pv5KpjavKrUSVf1zpgrfueCRsQhj7gboE1uXJEe071keJWfjo8BKsxyXIazCxWhtUFQuNi8Q3c1nYHIKPi9MuptStJezqSLmhJMOy0fcwYo4iAr22NnKANlIsb+M4ouifCYb4ZvvY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y1ZITEOE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y1ZITEOE"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc745927098so2437158276.3
        for <audit@vger.kernel.org>; Fri, 08 Mar 2024 17:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709946868; x=1710551668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPz2z6DvnJxq/mvZY2AzEM7nepXgQps0sd3FnWYy8AY=;
        b=Y1ZITEOEQMcPGo0IG+gwiGch8CnQXfEH4HEZKP2VNMxLUEtC0/XKnlmtFb01oTOAoM
         bUlhF//VTz39WdyQJ4aNxBCGDXS2HHz8fRKSaeXfnzQg/WmzaJdmlHo4tS+0cUaCQBMS
         pUqke+3r86nVSAScKNFYk/sFgex4OoZh72SHtjI0gIV2MIR72aHwQcSQLpNqlG92Vp3L
         cdKjHiDqA44uJNzOECaQdtY14Z5kBvXFj6Q7wfZWgwbuYjW9o3QX6cQSt3btbzM7Tak3
         mE7eNvUokKYai8U35gAQ+n09p7inXwVrvXZLcL7JCci6k5+Q2SDk1+MZ8k25c8zXXXre
         CZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946868; x=1710551668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPz2z6DvnJxq/mvZY2AzEM7nepXgQps0sd3FnWYy8AY=;
        b=XHf7SeGJO+HJUuF0ER0w0bG4695+5ZDLbGxvUjgENOfBv6/bkou/CBDkenYNhgUXta
         HR8itY7D+nFDhVtpOeeoSuc3BROemChERTlsoMZKjuobXyXbAizKtN0GKfRiaPDFYavU
         Yab+baRTCZibljOXCj1eM6Uru/+D1aXyW57rebRrlA1c8rYiOYw4jimIAT4swIwkOPGP
         WD82upi3G+pWyCFgwj8tBniuXT9kcOq/7nHLDXl4sqstOYKs80LGgKgCVBJ0aEMCAgan
         nKXbG+ZjU9Phn3Xl8Muy412MwC3SpEQQfzOY3ooqTSa+Oo79CfIN+zqTkjum0z3Rxus3
         lTmg==
X-Forwarded-Encrypted: i=1; AJvYcCWd0bmPVWOUxDnGvM1ey/35nxujLxA3Gt6BBmBRrUUrZDgGTtH06syGAX9aNR9IZ3BLlhMxlwXt0R9rRSwTNyw5i3G01yM=
X-Gm-Message-State: AOJu0YybbE29k1coEg9iumISJ5ff+IZSvlgHE9FdDya2zBqYRpUjA0BJ
	3UdcHRASkhxcwQhSaN6qfM8GvcQM9KRtcFG/FvNKzJqam+ROdDLowTBv1XAAq7Hc7qi8y+vJh4o
	zfQjhHIdYQSdZGHW+hvfnG1B99xKw39q+vQ5s
X-Google-Smtp-Source: AGHT+IG/iVw0xp4cUGbrbuHW4JP6YIUG2WhfFnWUrnT+aZkEjbYKTgvQfRu4/7uLG7cpfDOqG4dr9VoK5RFcwZhesog=
X-Received: by 2002:a25:b227:0:b0:dcd:1043:23c with SMTP id
 i39-20020a25b227000000b00dcd1043023cmr780907ybj.1.1709946868255; Fri, 08 Mar
 2024 17:14:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Mar 2024 20:14:17 -0500
Message-ID: <CAHC9VhQ90Z9HbSJWxNoH20_b92m6_5QWJAJ9ZkSR_1PWUAvCsw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 00/19] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:34=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> Overview:
> ---------
>
> IPE is a Linux Security Module which takes a complimentary approach to
> access control. Whereas existing mandatory access control mechanisms
> base their decisions on labels and paths, IPE instead determines
> whether or not an operation should be allowed based on immutable
> security properties of the system component the operation is being
> performed on.
>
> IPE itself does not mandate how the security property should be
> evaluated, but relies on an extensible set of external property providers
> to evaluate the component. IPE makes its decision based on reference
> values for the selected properties, specified in the IPE policy.
>
> The reference values represent the value that the policy writer and the
> local system administrator (based on the policy signature) trust for the
> system to accomplish the desired tasks.
>
> One such provider is for example dm-verity, which is able to represent
> the integrity property of a partition (its immutable state) with a digest=
.
>
> IPE is compiled under CONFIG_SECURITY_IPE.

All of this looks reasonable to me, I see there have been some minor
spelling/grammar corrections made, but nothing too serious.  If we can
get ACKs from the fsverity and device-mapper folks I can merge this
once the upcoming merge window closes in a few weeks.

--=20
paul-moore.com
