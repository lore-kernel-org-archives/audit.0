Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345418C08
	for <audit@vger.kernel.org>; Sat,  2 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395292; cv=none; b=KMsEGFLF6q+demmFKi7ph5b/oM6bH+YPPjP7pk4RiqAiTiXmKZ8Oo/ZA5pGKjosyOJSROvByG1Xur5k5UN6TZ8RPWF3CmbVg8eC7VnbD/ktBfGUphufQAuybJPMs7oO610ngBovEiOSQFjs5uzysAJdTdnNs/oqZ7BYGgVrdyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395292; c=relaxed/simple;
	bh=LFiAtGjubDWpNLUQxtbJ/E7SHByKNPAdC4jbSr77kCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy/jBDQYpgPjeDe1h7I/ElNJJE8rMjvCuLYrJqUiFij3lkf7XDn/T4JBPHIDc8yLpeXY0+X/00MiNC2+DTSRB+ScVxW39oEqkPdrCtuaGavvyyFS8NYCcaqdVajzcj9BA8EUa2gTMRsMzuBzABuntQjTc4ZhMPSzQ5xa4cy5sJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69066459b3fso1627266d6.1
        for <audit@vger.kernel.org>; Sat, 02 Mar 2024 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709395288; x=1710000088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XenCVyPUGE/ocH2LizUOZPuh6vZd/WYCNYixpMDiLyI=;
        b=dQmCHzCoAdUcHdGKRZKlw2ghz93/hiUgJHKI3wV3bhnymnjnOWaH4CaIqhyX6zRMBK
         K5BpzvqJr3I/NqzmwFYjr7okosvGD5kCvnkDKBNH5azxJBBTbCjawr68iRSG1y1ul5nJ
         ynq7GDZWxqysWLufPNck06glCQ6yjELYMowUDZVvuHYIV4tPF20MzKnqT4Ylh021kGxl
         M9t/hnK6oQ3pkfWg8UDaKmKiYEipqFuVM3HnSX3iDCWWDx5utCw9ePeSRm81/lylQ9m8
         YfjtIYTGDhaZIhz8JRLGBPMMfhJNhQFT3P5+zyRrSJ3t8PftwI/FWeCwIo9+bDe3zKgm
         Cxwg==
X-Forwarded-Encrypted: i=1; AJvYcCWtcm4fRut2g11aRdN7Pt2wVNv35ia8RwRaFvB8l6EstLnF5LkPVAhv2GEvNoAALc2YspMawbQqpwnIWI+b0a0raM74ly0=
X-Gm-Message-State: AOJu0Yz58e6WVZgaYO2bLPjK7d7qLA6p6ugmOUqwQThdUmIPhSHBNdzE
	VBug5vgKm6jvdtSseByvmfzF9S+hiSg+ydoHpxCcgIsOuUOcWoM9424rpZ171Q==
X-Google-Smtp-Source: AGHT+IGzvxitZoqsBYuFgO2HzG9/T+9mfzbc+Y/oQjpPYffJx1lNgpS1DLq5H2YZNnh++/V9NyR/5Q==
X-Received: by 2002:a05:6214:57cc:b0:690:6b94:67fb with SMTP id lw12-20020a05621457cc00b006906b9467fbmr9186qvb.21.1709395288340;
        Sat, 02 Mar 2024 08:01:28 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id me19-20020a0562145d1300b0068f85706ecfsm3064940qvb.104.2024.03.02.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:01:27 -0800 (PST)
Date: Sat, 2 Mar 2024 11:01:25 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v13 12/20] dm verity: set DM_TARGET_SINGLETON feature
 flag
Message-ID: <ZeNNVWxkhki8lX55@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> The device-mapper has a flag to mark targets as singleton, which is a
> required flag for immutable targets. Without this flag, multiple
> dm-verity targets can be added to a mapped device, which has no
> practical use cases. Also from dm_table_get_immutable_target(),
> it documented that "Immutable target is implicitly a singleton".
> 
> This patch adds the missing flag, restricting only one
> dm-verity target per mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

FYI, I have picked this one up and staged it in dm-6.9 and linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.9&id=9356fcfe0ac4a8545f9fc32f2e404524e1115ee6

Mike
