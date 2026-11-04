Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822877;
	b=0tofbSHAFi0AhM8s/7lsvPZQ03nRQhENkg9xgJQ/8l6bkwcQ1GRIeVq+LpprOGnaVvCo
	 Oz0eJdtkAwCEstyM20WRA2MPrzQq22CjS369Z2JS7y+wwEE5BTqHquCOa11CO4pzOVrgE
	 zVPUmBxQBkLjXzVtq/uZugFa+o0UQ4pEHToLH5iXyU8jvgYp1AZYqJBsDdEWCWAtpgbvQ
	 pb80yC/AYDZdbxVDo4TWzrbe1Y+cEDv5DVTx2p7EDmQKr3UX2Sr8auws0/26bF6ws6ORM
	 v4JN0txRwV6sSaAI+xbUn+MtPwYqNDGBKZu+C43wfRP0Cr4rvf5cJYrPbEmIabOevTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=UcNh0oePORUUeQ1MpZDHNaWWnlQIjfdz05R2K+/iwQE=;
	b=tHerDb6uRwIDT738NnA+l3MdUCYkPKziMC3zviJdy9MBWOWYq3JEgSXSXP51QbI3KZpX
	 FFmh1Psh6IeI7WOTy9VueJFfuoKM4TbvQEzs350bWx1F4wqgsXqEE6UNAwL6JgLUuJLfL
	 g6/hlAYb6iwx3EjKbxQy7I4yZagyCP7p1AGly+U/HWSNn/ol3KXi02lHYFqeqpHX9qDMd
	 vh10viP3pw8zbWS5vupXNsJfnE33YDkntxDuYFrpOIlUsbUT8mKFhOD4ChSv4gc2GH4DV
	 gD2Mo/uHNtHXddZ9O18UZDvGDcnIDK+HW+ir2ltLVDQfIlG3GFOl7kkZp9mTuiS93EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=a76A5Kf6;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE6606A32F
	for <audit@vger.kernel.org>; Wed,  4 Nov 2026 20:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EE6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=a76A5Kf6
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533797e72e8so6825691cf.2
        for <audit@vger.kernel.org>; Wed, 04 Nov 2026 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793822875; x=1794427675; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcNh0oePORUUeQ1MpZDHNaWWnlQIjfdz05R2K+/iwQE=;
        b=a76A5Kf6pVLykdbq5NKfGJwIo8SFD+aX9QwmWtoV5fQPDjjZgk5dzUVbJOOGqzLNw5
         4qBWLpqlbzVvmWi3J72u0zZrO0iSBdoCJYpE579XYZZ9nf7wJUZ32pARLCssCbWHt+ei
         9eQ2Np05WjHsCJjuUA8q3oBHTz8HWp82RN4mNL6anaEgbEdu13ycJ09UIAkncpo552yb
         Z26G0MYQFEkUoVTFCAYML8+h8PgSaEQlZmmsSdY6Fg2geBM/d6UBDVegD+GbPS6491bw
         K89p5SSjn/g1k8T/XPEktf3u7EqFoZaUOTfVH/7lREsBMHC8KGo3GY58MD93LJCQeQxU
         tyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822875; x=1794427675;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcNh0oePORUUeQ1MpZDHNaWWnlQIjfdz05R2K+/iwQE=;
        b=ESz6cFgVziXazvDlG7nxSdK/r6ftBf7S7C6ETxvF3/vCGDMKkNIGI3UkgaUt5EZ6GW
         5siMQP5Kjm8RPZXbBTB8dgiubVFGfMx6/jxwY0zwJJYni67O+ftf4xmH5UqWmHx/ga/b
         LG7iaIBTda24md6BoXwUgywXTqZIZaxzpMu6UmlLNy03Gl6R8g8/MtBvxzN1Tbknr/ZZ
         DdZcIWxnr5eVs61nY3lsGQHDgDB5l1dvoKn/5h/XS1NxvhJY5Go4SlitK9UJo1JYIjQo
         iawTe6BE7CTM8/c/pohlvpA5HAhaGs9YLQvjiXT4Lpv0lzAeVUJCCTnbb9fbeqdXSzE0
         Llhw==
X-Gm-Message-State: APuU4Z/QR2gfQGJ2v/mj+LODsgBEfAEWMwRtYws6NFiRNZvgfpMFJs+5
	v0O8OwscfCQZ7IyCpblT/kc7BVAT/KRyRrRTpIR7E02FBfwDFQPbnMXjFk+sZ19HZw==
X-Gm-Gg: AYBFou05+Os+oqrfo8sxGd1K24A6C5IwbqoWiH6ySWvgYkfn8luxWkXmg4BKEWtL8pc
	r49g6OPe4peDqJZGBXi2viUIpp8YCAeD+FJfhogqhl7z5Azpbn/wFAJunVPtlaxPwJ0azGRBoHC
	gHxDEZm5bulIpWjzuMS6cGJk5vvh56pxlKeJxLx7wscgPutci4qqLil48gf6eHhhEjRlMstl9/u
	p1d0XhrNyh6qiwT5hsxuRpr7y8RK7FfsSx1UIOgb/y6rRh/O8SNf2co5uYv0lwLBPv3mg4hDccy
	lxc6uNpFw3t8jwVRQTudWAYr041dPmPl9aqwL5VgmBnFWzjaJyxiJVjFvOh1NTn/WQajWQ3R7DZ
	ZkS7xm8BU2V2dfNo9wg/K4gLQxKxIyJ1B9Yqovk3utU14UsV3SjBgPF3AfwLHoIkRKWD7f28HNr
	5nQo386MlnuXGQH4w35tAGFK0S85bi7s5aYw6yCh7K99BxZISCm+jLTwfpSTGVDWvmKMjV7TdMr
	Zk3GeOJpUA1oabZWocW4UCNH3zheOFYb/J2ZnTg1D4xyxlgcgM6JnfEH2DrUOq9z3RnfT/QAzC5
	9zyhnGeoq7VZ1EABHHSB1RGslupxWBjzxLYxpDIxcn2Ft3S17gYZhiIgsQ5croonl13t+xvzHKI
	W48hktXJgIbxfh9uMb9vaiLUOqpX2BQ==
X-Received: by 2002:a05:622a:250e:b0:535:a5fa:ee05 with SMTP id d75a77b69052e-542b7ff0369mr274600131cf.69.1793822875111;
        Wed, 04 Nov 2026 12:07:55 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10962a29sm32067301cf.12.2026.11.04.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:07:54 -0800 (PST)
Date: Wed, 04 Nov 2026 15:07:53 -0500
Message-ID: <b25c8d7bf9a0d0739ea12969633f1a21@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261103_1853/pstg-lib:20261103_1851/pstg-pwork:20261103_1853
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org
Cc: audit@vger.kernel.org
Subject: Re: [PATCH v2] audit: don't use the caller's root when it has no fs
References: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>

On Oct 20, 2026 sashiko-bot@kernel.org wrote:
> 
> audit_log_d_path() calls d_path(), which resolves the path relative to
> current->fs->root. do_exit() runs exit_fs() before exit_task_work(), so
> a deferred __fput() runs with current->fs == NULL and d_path() oopses:
> 
>   ima_file_free() -> ima_update_xattr() -> ima_calc_file_hash()
>     -> dentry_open() -> smack_file_open() -> smack_log()
>     -> common_lsm_audit() -> audit_log_d_path() -> d_path()
>     -> read_seqbegin(&current->fs->seq)
> 
> Without an fs there is no root to be relative to, so log the absolute
> path with d_absolute_path() instead.
> 
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Changes in v2 (Al Viro's review of v1, which patched d_path() itself):
> - d_path() is meant to be relative to the caller's root, which is
>   meaningless here, so leave it alone and fix the caller instead.
> - audit_log_d_path() uses d_absolute_path() when current->fs is NULL.
> 
> Reproduced in QEMU (x86_64, KASAN, Smack+IMA+audit) with the syzbot C
> reproducer: without the patch the first exiting child hits a null-ptr-deref
> in d_path(); with it the reproducer runs to completion with no KASAN/Oops,
> and the audit record still carries path="...".
> 
> Al, does this match what you had in mind? A final fput() in some unrelated
> task still logs a path relative to that task's root; this patch does not
> change that.
> 
>  kernel/audit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc..32085674d0be 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2218,7 +2218,11 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
>  		audit_log_format(ab, "\"<no_memory>\"");
>  		return;
>  	}
> -	p = d_path(path, pathname, PATH_MAX+11);
> +	/* No fs after exit_fs(), so there is no root to be relative to */
> +	if (current->fs)
> +		p = d_path(path, pathname, PATH_MAX+11);
> +	else
> +		p = d_absolute_path(path, pathname, PATH_MAX+11);
>  	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
>  		/* FIXME: can we save some information here? */
>  		audit_log_format(ab, "\"<too_long>\"");

See the sashiko feedback on this patch for more information, but since
d_absolute_path() can now error for reasons other "too_long" we should
probably change the error string to "<error>" or similar.

--
paul-moore.com
