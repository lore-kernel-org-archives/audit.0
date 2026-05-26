Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654543C4540
	for <audit@vger.kernel.org>; Tue, 26 May 2026 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836415; cv=none; b=T854COIAKFTZjMZTPnJQPXQPsAzjr/wPZ/OQDvB8ZhX2kHNzKDonyDXntR6o2B9H8biGfmJcSRXb2KZkska7oyeYPwkL9d4V2vG42+K0v7Cyc9af4bol46BQU5UEREH+Rv6HjKlMUK7CDdPfxOgbLC2tXf/kGqJGvwroKubadzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836415; c=relaxed/simple;
	bh=+uRbzz5AyCUsDbRrb/GU6Uhn7FLl3Jx5tCu0ePg5V3o=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=daF+FWd/mFVkqA+/JjDDjQXXn7lJJbCu5Hu8cDmv1o0Js+P17X6PNurhvkLI6sLwjQ+i9knrXJQ1ZTeJMMXdTxmSt35JnhWeIS2Oq544HJ4ptS2D5gVFs/Xgg77zFcBtdy/0wAQP5qyEstD/ae2pUll52E/2h7kzzXysd5I6Kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YsKcPujs; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YsKcPujs"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so84299106d6.3
        for <audit@vger.kernel.org>; Tue, 26 May 2026 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779836413; x=1780441213; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdBVsMe5ZBVw60rKHtMu0pWGx97YtPHOG8LV2Ijiw5s=;
        b=YsKcPujsDUPMy/zC40CvmmPG6HYQD5IZq1kej5tJua/BD7JLIy+tZk4kQ8PZcV6WAx
         dSwVdaK592H3lMREU0iJe3BtnTQlrqGTTVk6plIpHTlXbVP3HY8UBb0e/um6VCIn151e
         RshXbkCrXZvMN+mc7f3t4w534rlGWjND0NI3/22bLzZqY7B5LAMgojZSYiDl7twwpeVX
         MAkywi8hz7YDaXH/pOEliWhobCo4Rgk3W+/sdi25lm4nF5HNpL8XZdO2rnxBoELycIUm
         /A2nHIKzWbpkQ2auWkjDDacSi+jPFsY51CScBuVCvnGb5QZhzCGQM0KkJdaoJGaR8Hcp
         gIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779836413; x=1780441213;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdBVsMe5ZBVw60rKHtMu0pWGx97YtPHOG8LV2Ijiw5s=;
        b=CaKZz7+mfcZ6JAE9ACKpve62BQJy8hbYoYODBJcnmxKZswxELNrG55tkiT3Fg0sSJt
         KW1pa8rswBTwV34hJFLxBpYVVxgPcPH73a7kdvvVghPmCfm3jLVcGrPBcwvV/TvMEmAT
         naztv+k1egJ2sxQk10OjHwBkuwuiyr82mXPbI3upDRF0GH4RnQopdFOiVRr6xX/JNIND
         BWggWchMradi+HF2dH1ko2qWfHA68jgcv+m8zKOE9wTQooaWiXe6lQsLbaj2KYO+8jrU
         57EmN7jLDSO3bN2utK0/Enq5isG++UCp9REqKzF/k0MDZpNJQkCYXaQOHMT6KURW1uTb
         A2Ig==
X-Forwarded-Encrypted: i=1; AFNElJ8pvqDimEejWpJQ3rMQ9hJ/aFpIzEU0JP9+4eoX388k9xQEXBlqo5Sl8WUe2EPA4qw1bkgmhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGG16zAWwzdg5ltjhivrKHMpiOdiJ3UtkNRFc0w/3YvDVy+Ha
	W3QAfwVhcMKNv1AaEXAjOyzrBfYwEOhGdtWx9y6H1SP0t902hPKr5dJiDWNC1E/Tzw==
X-Gm-Gg: Acq92OEz9zc3ZAZxHsSjgpCh79FRlsvrQ/FNmv0eEK7WPuctckKdochZKTQ5TlnSkhn
	ErHg/nweFf3Zd2xk4dydvJ9YPZGIVE+I52uE//vvSA2sVXU6TeHdDnylWCX5Ewzi9yWkhHlU6Vz
	kLjYvkF/JbSDxsznr8NWkoNs6AvfY9DA44dVCkJqYnwdhnLSYUmzcTqhWEYdynxxLISDa5TiZFm
	C72PedUrU3VCyyy9MYK68yhypBSMxYJVJ1In/Hzefp0RxSMc9q6sK32CL5IF18HUgBWGJ4WvV2+
	PaDnnof6CVOpdQU/OK90lPjr8b99SVGUFAjacdUGGiUHEXZNXrfS8cB0EBs0qa+xrQh21wZj6wC
	WmpPnbNNACSmNuJaz6F3xh4nuUgSLzjluYfy4I3lanPzbDB6PjO9O1DPCXj/KBsJOHm0XQYpvOT
	tU6hI4aMXyP0+AP/kzaxBlKHaOay5oxB+YSAdjl+NcT/iGKLX59aLCZ+s9IDC/8O76ncDU
X-Received: by 2002:a05:6214:300e:b0:8ca:164c:a861 with SMTP id 6a1803df08f44-8cc7b4ec38emr372431136d6.2.1779836413238;
        Tue, 26 May 2026 16:00:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd81esm153058876d6.9.2026.05.26.16.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:00:12 -0700 (PDT)
Date: Tue, 26 May 2026 19:00:11 -0400
Message-ID: <18f1ccfd1e80b91948e3445775be31a6@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260526_1654/pstg-lib:20260526_1539/pstg-pwork:20260526_1654
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, rgb@redhat.com, longman@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2 1/2] audit: fix removal of dangling executable rules
References: <7f0a259c6e6b5a1da6578fb83b531276425aa030.1778704210.git.rrobaina@redhat.com>
In-Reply-To: <7f0a259c6e6b5a1da6578fb83b531276425aa030.1778704210.git.rrobaina@redhat.com>

On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
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
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> Changes in v2:
> - New patch order: now patch 1/2 (was 2/2 in v1) per maintainer feedback
> 
>  kernel/audit_fsnotify.c | 4 ----
>  1 file changed, 4 deletions(-)

Annotated for stable, but merged into audit/dev as I want to give this a
few extra weeks of soak time in linux-next.

--
paul-moore.com
