Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAA50279B
	for <audit@vger.kernel.org>; Mon, 28 Sep 2026 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633455; cv=none; b=aRjWLepD4F/3K+G7VTLHoic10XK9nRtmiAHOAyC+JwIMMME0svRJAAgKmu4prb1JUNmtum8Vb0Ui4AhNmGPiSRFEOO9MV2sVqOmPai0QLL+hLnLIfsbLAJMJzfhKz/FF/L0uw8CEawfDsOzoYds8wVfAqpyeTNgUvIS4F5zHNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633455; c=relaxed/simple;
	bh=B2uuJ2tb6UVo65EPVK7+jnV8vWjWZQPk68SmhF2KuLk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=g2J+9s1fNjpRV1AGrl2cE2lKQvXqFJgmRjHQ5eziAsvaRIDyLxvjUdejKz7Wz50GgFSBUrqQzIWGrk0BU9XJLRMk7QuZqDH6YPbSkuDfZ75TITnnTt2nxH9XfT/tYy/X8JDG73vXOsrshP2cqpuTad3Oph3T21yNsdqpucxtCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IHM6xMgX; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IHM6xMgX"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91784fbb60dso3691156d6.1
        for <audit@vger.kernel.org>; Mon, 28 Sep 2026 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790633452; x=1791238252; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ld93k1mz7prrBKJ8jJcBuGZZs7khQYzy5aYM/AzqGEE=;
        b=IHM6xMgXYX6LxUpey63uuklGK3TneiMD0Y724GtzZ509hA9QedN6IlSWu5GU/uuO4K
         4Q2d3/01hEbUojbLaMDlJ3jNkJW08i8iFu0z0c+Npphe0X+7bLZgjZiQWlfoeCO9NFgb
         pECOtLDdfIZ0bdj9fdj+QXKoBHfq3gVPVhrHafxER7EdpZN/vzmnHrfwLkb6IRZjo68z
         xxkX8MS538oInnScIS2BzXMB9uH6K9V69MYmJ95qL5uBv1Mw/A3NTj6nYScSFvKqUDPG
         +LC46TyPmL7xyf6c694SmbUkOCv7qZ7PnJMY9SBjOP/iia/gmU4JSR+U9DZL94sukyLw
         HGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633452; x=1791238252;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ld93k1mz7prrBKJ8jJcBuGZZs7khQYzy5aYM/AzqGEE=;
        b=gWz1rHK56/SFrvhc/FfKDQtwWUKiSTBlmNgV5QyQRed/GHNZe1q18MivFsjMuX6eEd
         gUUIkx2TDD5KbxEBvD9uUb42DezIrxB5vNeHdFjiyHvGqKfa18i4N9c/zQQMgqlzoZHn
         RRlNBVecq78krO8ds+8ug4HgD2VAtY4uGUyv/pc+UNV0vQdmvTQaa8+GB17q6vnd33qG
         OOBrISYclSk/vKYnfXqQiySe8QtESiq5vLoi7ayVw0SfB3r4L9nCxmn3EyeY/4vmrfZv
         7EQIWs5cWMwnQJ5VE9RU8IpBzSXAitqIYiwBE4yJXkUr/W+kewOxY8W5B4cZ+SbaxW3O
         Papw==
X-Forwarded-Encrypted: i=1; AKwUvBxHfcf32Aq9efffxLixnCFWpE9cqVcDux7MiXvSyzQb9pDs3yV2w2fBWDvVdE+bvRkewjpA7w==@vger.kernel.org
X-Gm-Message-State: AFuF++lYMe3iiyFXYbFC9xvKMHIMPuvHcFkZZljulfWcBzYmvxiin6Nw
	rWwXJ0ToYkuQx3eX2yFVIgEGeLgMjBTO8PiyafCUST77YF0KF1DEbNJyRZV+NzJFEA==
X-Gm-Gg: AYBFou2BB1txhpknfiXp3A/PCXIZ2PQDMb4K46Lap5FNN7dcdJiH0wwtKV12ePuza7B
	KCMyVEU92Ez/dy9oj5hWlR2Rl2Hx3qLhyF9mNV/qzglFgspywqnIRz6MF9/reDjpYjAgRmIC6eY
	p+yxl4FODxFRbfxXx3gzaiVdFuAsi0mBrOk7EBYLFeTPLwd1uql8Gy4+QUu9h97LmrBMELnMVHH
	zu9W263thg6Qpm/SuSehYqtGH14amLsNe8vDWVHBiAFT9ReYOm4UKJ/yL/DdE0FBe6Ji0JsUWbv
	ZIKmCPksPOnjAvwdE+VHz4maeoCoKpTOdyUQ7Sfyygbm7O9wn/P4+v/TXO80sbE1ImH9OdejKBf
	aoceupqPYU2eDw1xTDYqNgC8CPXCEnioGp8I5YFrVgBfric8j7WZQaohe97rWQW+B1qnl96Hkkp
	VPLwVRxdYTdFtozYykgP1MMKtrS3fx/S2aWb2bCWzC6clmGBBY08Ztjhe4n+MEI9dncKIC6rNWh
	AMNO5rNknAcdyS8jSJ3ZHcaHz3RczRGrwWBsWR1jyPh/OZge2xl+ieiqTo23jDnR87UnCp+Jeyy
	qlA5tEbbvw==
X-Received: by 2002:a05:6214:53c7:b0:914:4efc:9b8 with SMTP id 6a1803df08f44-9144efc0ba5mr147070126d6.42.1790633452268;
        Mon, 28 Sep 2026 15:10:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91444d9959csm68163636d6.10.2026.09.28.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:10:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:10:51 -0400
Message-ID: <cf63164d7934f3e0c2ab5f4b5c00e494@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260928_1559/pstg-lib:20260927_2151/pstg-pwork:20260928_1559
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, audit@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH RFC 2/4] audit: compact name entries and context fields
References: <20260917143948.106603-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-2-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Group aligned name fields and small scalar fields to remove padding. Keep
> file capabilities last so they do not separate inode and pathname metadata.
> Store the per-name file capability revision in s16: it must represent both
> the eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Keep
> the existing formatter and its unknown-capability output unchanged.
> 
> Move name_count beside return_valid to remove two alignment holes, and
> place personality before the task credential scalars. Preserve the first
> int dummy member required by audit_dummy_context(), all five embedded name
> slots, and the existing allocation and reference lifetimes.
> 
> On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
> leaving room for descriptor paths while staying below 1 KiB. On the tested
> arm64 configuration without property-bearing LSMs it falls to 872 bytes.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/audit.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 7640d2c0fba4..bd798f8553a0 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -76,18 +76,16 @@ struct audit_names {
>  	struct list_head	list;		/* audit_context->names_list */
>  
>  	struct filename		*name;
> -	int			name_len;	/* number of chars to log */
> -	bool			hidden;		/* don't log this record */
> -
>  	u64			ino;
> +	struct lsm_prop		oprop;
>  	dev_t			dev;
> -	umode_t			mode;
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	dev_t			rdev;
> -	struct lsm_prop		oprop;
> -	struct audit_file_caps	fcap;
> -	unsigned int		fcap_ver;
> +	int			name_len;	/* number of chars to log */
> +	s16			fcap_ver;	/* 8-bit revision, or -1 for NOEVAL */

Should we also change the fcap_ver in audit_aux_data_bprm_fcaps?

> +	umode_t			mode;
> +	bool			hidden;		/* don't log this record */
>  	unsigned char		type;		/* record type */
>  	/*
>  	 * This was an allocated audit_names and not from the array of
> @@ -95,6 +93,7 @@ struct audit_names {
>  	 * should be freed on syscall exit.
>  	 */
>  	bool			should_free;
> +	struct audit_file_caps	fcap;
>  };

I understand why you moved the fields as you did, but is there any way
we can keep name adjacent to name_len and fcap adjacent to fcap_ver?
Splitting them makes the structure layout awkward to read.

You would need to check that this is safe, but if it helps we could
probably change name_len to a shorter type as PATH_MAX is only 4k and
that limit is part of the UAPI so it isn't easily changed.

>  struct audit_proctitle {
> @@ -124,6 +123,7 @@ struct audit_context {
>  	long		    return_code;/* syscall return code */
>  	u64		    prio;
>  	int		    return_valid; /* return code is valid */
> +	int		    name_count; /* total records in names_list */

I think it would look better to move this below the comment that is
directly below it so it remains adjacent to audit_names.  This shouldn't
affect the struct padding/packing.

>  	/*
>  	 * The names_list is the list of all audit_names collected during this
>  	 * syscall.  The first AUDIT_NAMES entries in the names_list will
> @@ -133,7 +133,6 @@ struct audit_context {
>  	 * by running the names_list.
>  	 */
>  	struct audit_names  preallocated_names[AUDIT_NAMES];
> -	int		    name_count; /* total records in names_list */
>  	struct list_head    names_list;	/* struct audit_names->list anchor */
>  	char		    *filterkey;	/* key for rule that triggered record */
>  	struct path	    pwd;
> @@ -142,10 +141,10 @@ struct audit_context {
>  	struct sockaddr_storage *sockaddr;
>  	size_t sockaddr_len;
>  	/* Save things to print about task_struct */
> +	unsigned long	    personality;
>  	pid_t		    ppid;
>  	kuid_t		    uid, euid, suid, fsuid;
>  	kgid_t		    gid, egid, sgid, fsgid;
> -	unsigned long	    personality;
>  	int		    arch;
>  
>  	pid_t		    target_pid;
> -- 
> 2.55.0

--
paul-moore.com
