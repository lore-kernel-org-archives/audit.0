Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E2438026
	for <audit@vger.kernel.org>; Mon, 28 Sep 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633458; cv=none; b=T2zcxRmVIooiU1djGLBdqpT/NzNPUtiO0B+dYSO4tr0FOon/tZnMBeliyQwENsT7vP+RZYFy05f7UCflVDbN+bWO6PlUlG3oOkV8BakVUEgRPuqIapH2nBT0chtSz4U378UcRMvCKcBpHCJyfkJWlDnxwS6nkYtMvOrxwn7bbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633458; c=relaxed/simple;
	bh=BJExaB8huR+9hsfSbiLsPI0+csaibaFNbBEke5qFibs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mB/aQ/TpT7K4UIkDSXGDz9LFWJba4wG3vcPK1YktbzbtQn0Kkm2n/lj0138E/ZKOUYimRnOrXSO7mmaon721v2EfGS3/Eqlj11cHFxiE8Sn7LZRaNHJFiKsDrdpjIoea2kdUxQEtXi7hDEYxO5GyX+I1pwn6iiiIa8LWlTliQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a35QUIgh; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a35QUIgh"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166acdso251813185a.0
        for <audit@vger.kernel.org>; Mon, 28 Sep 2026 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790633456; x=1791238256; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJ0YoVU1ifdFU0UV1Dv3G5e7aUVMATQ+qYoomR0cCqo=;
        b=a35QUIghCFjJQfusj2cMJg/DQ4Swfz7vq8K7EqOvtJLgPfS/rM8Pg8BltlUD84sxsu
         PkkAttuDzhjjs+QiA/vFM02ZJMnbagXefZzFdazVQxHNuAE5YAKTVVH87ioXQz928uDr
         mFywz74kB6DreJxZXiBqfVsvJDDZ4M+AGuEc1CdkxBUT9zalGod+lQ59t/vx4dW92f6+
         ZwHooxVJYfiWwvHK5SYxRq73ZrR6NzDCZRN5XaaVBkuwsPATSoGp5uBTO/pWgTPi9TgM
         aq2qyVR6xkRouh/CFkFlIpkSZ7i+UOA3ebHWAO9BrrLl7MBlpih0gUzp3xCmM4MFn8Zt
         V/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633456; x=1791238256;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJ0YoVU1ifdFU0UV1Dv3G5e7aUVMATQ+qYoomR0cCqo=;
        b=OxKOmNgJTAhcTz/SLzuGUeJYu6YA2b3XBDzk+FRhS96rPDugLKxywJYS6d4gH8kQGo
         qfqUD5ZPTAzxuaZFd9QpkciR4baugLdTq5UjTVfWsqftJcZmtQ4e2ukBnRxGNE8mKMLU
         4W+Vt9QMUHIjygcqoo2WCm6P6eUZPxSPiKUfXIET78m1HPEXydG0v3EcfVdco1zQ4tSc
         JkpOznlpIfJU2g+ZSBAdvdnzvMs6kZ+3DaWOZshuGeYg9TthpfeytLF1XKzARj6kc4QA
         VOF9lRm3oI6JubCvS9gwCfNfIg15JLbvqLFt+KgFsduQ60vJRHvtV8T8+NW5AKv5qlLD
         y9jQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4GJ+4hQj/P2RTpAunCROffhm0VhQGj119PzSIMDwR9ou9No/pvMjGkKoCQwKaFFnIop1DmA==@vger.kernel.org
X-Gm-Message-State: AFuF++lyiC9LiK+igdFLqzJqsnZLBeGh0FCVxubumNTJFUB2n0FH0pKn
	TVW81MwpujXpCenc3rJ5r/drcGP/nhjkR5JIJAuvMZkD4GjFhfyGV5xqQJvAREMX1g==
X-Gm-Gg: AYBFou23XKWvAe7ZM9+EQ1cB2exshXxXP3kjsIKla2/D+KBjALhMmjG2GOM+APA1egD
	CUINXc7BsC8d0PYwRhNeFwVZvR4V3o+1uglA9MYkZ/XnWx0gy+qsILxnyCBhm+EgzaFuxKASAX1
	oEvsxe50mI/j/wuB5UfVjRiZONEkqZlHEFYR2rq76H7YVz0aRpewV8zdyJzp2na7nInyes9nFs+
	jhXuBBx3uR0BSjbhsZ9x/e/lR0XI+EHZZplcAk167c32LmtqOlPCjiv2etpFCZFNY7Uh85S0wEh
	upEWC3jli+s2+okJff4yD0SYD4evYrcsgj/tgPxAWQrk7YKd+Epiq/oI9K9/oP/QopaStwXMGHm
	F8f/HkajdmAgS2ZlcPZMM3moeQoxgvTYynKDnu9lmL2+7vhurLLyPFh6GAi+/OrfjBuAuFAdmpp
	2wEB8zma0kgvAvhABV766v4X3H76KyWKQAtYe4vGOtSvun/z3KFxSSo6waGZDFdo6S4ISXBK3de
	cNmoQX2SSm1dxpRN2Ui4APGmkZG2T460WtoB2FCBzjDetuNRAdxxzw84SmpbYlB5C4VI7Xdajo=
X-Received: by 2002:a05:620a:4492:b0:939:2c5c:7977 with SMTP id af79cd13be357-93c43c75a3emr2355858085a.20.1790633455767;
        Mon, 28 Sep 2026 15:10:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914472260cfsm65384016d6.44.2026.09.28.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:10:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:10:54 -0400
Message-ID: <4efed6c106525339f6074e3c19c65139@paul-moore.com>
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
Subject: Re: [PATCH RFC 4/4] audit: retain file paths for descriptor PATH  records
References: <20260917143948.106603-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-4-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> fchown() and the other audit_file() callers collect inode metadata but
> emit name=(null), even though file->f_path is available.
> 
> Retain the path with balanced dentry and mount references, and use the
> existing audit_log_d_path() formatter when no filename was collected.
> Release references on context cleanup and entry reuse. Filesystem
> exclusions continue to skip entry creation.
> 
> The name reflects d_path() at event emission: concurrent renames and
> unlinks can affect it. Original lookup names retain precedence.
> 
> This adds sizeof(struct path) to each audit_names. With the preceding
> capability and layout changes, audit_context grows from 880 to 960 bytes
> on the tested x86_64 SELinux configuration and remains in the 1 KiB
> kmalloc class. Other LSM configurations can have different object sizes.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/audit.h   |  1 +
>  kernel/auditsc.c | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index bd798f8553a0..ef8d25af18c8 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -76,6 +76,7 @@ struct audit_names {
>  	struct list_head	list;		/* audit_context->names_list */
>  
>  	struct filename		*name;
> +	struct path		fd_path;	/* owned audit_file() fallback */

Since you were looking at ways to reduce the size of audit_names, I
suspect you could probably put name/name_len and fd_path in a union
as you should never have both in use at the same time, right?  You would
need some way to indicate which was in use, but if you can steal some
bits back from the name_len field you could use that.

Just a thought, obviously what you have here is just fine.

>  	u64			ino;
>  	struct lsm_prop		oprop;
>  	dev_t			dev;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b14765cdd56f..3d2f130bc0f8 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -935,6 +935,7 @@ static inline void audit_free_names(struct audit_context *context)
>  		list_del(&n->list);
>  		if (n->name)
>  			putname(n->name);
> +		path_put(&n->fd_path);

Do we need to reset n->fd_path.{dentry,mnt} to NULL just as we do the
audit_context's pwd field?  You are already doing something similar in
audit_copy_inode().

>  		if (n->should_free)
>  			kfree(n);
>  	}
> @@ -1530,7 +1531,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  			audit_log_n_untrustedstring(ab, n->name->name,
>  						    n->name_len);
>  		}
> -	} else
> +	} else if (n->fd_path.dentry)
> +		audit_log_d_path(ab, " name=", &n->fd_path);
> +	else
>  		audit_log_format(ab, " name=(null)");
>  
>  	if (n->ino != AUDIT_INO_UNSET)
> @@ -2222,6 +2225,10 @@ static void audit_copy_inode(struct audit_names *name,
>  			     const struct dentry *dentry,
>  			     struct inode *inode, unsigned int flags)
>  {
> +	/* An entry can be reused for a different lookup or object. */
> +	path_put(&name->fd_path);
> +	name->fd_path = (struct path) { };
> +
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
>  	name->mode  = inode->i_mode;
> @@ -2358,7 +2365,15 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  
>  void __audit_file(const struct file *file)
>  {
> -	__audit_inode(NULL, file->f_path.dentry, 0);
> +	struct audit_names *n;
> +
> +	n = audit_inode_entry(NULL, file->f_path.dentry, 0);
> +	if (!n)
> +		return;
> +
> +	/* Resolve at event emission, so renames and unlinks can affect the name. */
> +	n->fd_path = file->f_path;
> +	path_get(&n->fd_path);
>  }
>  
>  /**
> -- 
> 2.55.0

--
paul-moore.com
