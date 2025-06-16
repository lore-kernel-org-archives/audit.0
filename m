Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5F215198
	for <audit@vger.kernel.org>; Mon, 16 Jun 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107295; cv=none; b=fQAnl8IjcQZMrziHnVKIdN5gW0pgdTHuSDVBdZytbEsOjw7s27hdIuw3c6nDliv72KWTOh7dKUzjBmpMdyN7Ts2bOtrajFB89xbcSIQpR6M0HJKEPgp97KGHvysKqYKMwFZp+4lBZoXZjjtOENKgTLOgV7oDJTOBk3qdxlhBPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107295; c=relaxed/simple;
	bh=vuneaxYsglXJSYuOHVTHDsgFTJlNj3AUO16cZfmI4qM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=luPrNsGnISuGvGofZF44yom8Rrs67zxljoMOyHVMINoMFmcdKbJO26gYLs3sSvQoo6zO+PrZFtVsIGuTXXsPOnbYJZGFXb+CC81HWCqFg2/3pWfhjolj1dKVKd2m/EhAJPOIPA5c4hT2QemWILKVub9CN6Kc8DYCTu5TsAZ3SKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R4Iy+v8B; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R4Iy+v8B"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d20451c016so279745885a.1
        for <audit@vger.kernel.org>; Mon, 16 Jun 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750107293; x=1750712093; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3Kgmbky5db9m89bohqEKrPPgpDZrCyO85Ean9Ku/J0=;
        b=R4Iy+v8Blb7t8uSPq2eNTaeA8ExouVjkHvXiv0jHLrB4ajGeTU7L1Mqig1VNFk1oPw
         6sJDRhZ2T0A7W3cb/nmwMgzdWtwBrgL5liq+nPPZuZtwAVU4NXWyyju6RP6SvyBcw4dK
         8J8jZbG1xRBqbJULgDVDKFppU273W0CzFyu+v+TBOWS2Ratdvg0drrMs3O4ka1w+kfMm
         sS/9Os7Myxv0JOJXG74AI1Hg4qpdtqIQ6JLBV9x+hFIEDqm8BIJyPVuVRFsaspJ2yW6Z
         w2q0/TQJhVuJMb+mCDveVkOU7a9d93aBdTo365Nm4wwJ+NMbytELGp+Fwa5ZTc95o+Z0
         REnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107293; x=1750712093;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3Kgmbky5db9m89bohqEKrPPgpDZrCyO85Ean9Ku/J0=;
        b=YwdYPt/TRPM3KHTO0KLfRiKzMwupGepELY2sQOlusrm022NZnwtlLF/Zo33Oy6YwTL
         5/QSul8auZlvY6armPxtVYM67pzRKjmFIyPcN2WI1shiUAEoksK+UP8eaUCY2f1jyEuF
         vbCFRoCQ9FLYkfH1QhAn1SRcu99P/jQ27VpcVWUprJp9nHKKklF1APupBNcrSpxE9CKX
         1eD4X4VOpglfNOaO63LZd5KDZ98WGXB/UbDlM6m8gX40m3kJ00Z/tVMoWuLRt28zH+qu
         Uql+zXMT6FMg8MK3Z17s3M1Pjv4SpV4QOHNpwi0VfGF+2AdMnYBubqOk/P45DDWdEk6A
         UbBA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyRLp/UQ5WyRynycI9zoIxLKjMy/jOV80mKH07l1Pux3PQCgtDRzZKu60x3kFhMGDNUplaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvcs7atR1FRMpDhaB19cP+yMBQ/1wLT3Se2nYwADB1ECtpFjqb
	c/lIO43//InqvgvWV5h7rKi25nqv35KL78ofU95uyrU2IdaxLCU4oTQJL11RWvTPfg5Lp2mLxLl
	L9RU=
X-Gm-Gg: ASbGncvO0cqAD3Jdg8ygJvxF8j4vKQkVYxwGIOwsohrHAauJQJrSC/skx1SAebWapRl
	69/saNufzKHQjJ0Pjl/63obg7ibd79k23j3rYdHc7tv6qzEkjv2DCZbVJrg5+ZR6XqreZdKmPzp
	D9tJgLmVmD7ZEAcWzXOMnZsotCnlv4Tjs10dlt5kGyhw5ZUSJIkgcOMEE5GGREI1NHorXzylM5G
	Biy3yruaPbqwAxv2LbnPaLHvh1k8g2lEQaVdCN5UZjHwstB4vk9g10EFB3TTkRSquxXsjTKORGa
	SU1I1n47u1YhbjWbuEZuArdQYfYnCObqoGUTMmB9nEuPm8ZzA7Y2G1hSsJ9ZoENAhNoDJeAndMn
	70lZnXsMIn//iuhn8l/jnDHOhHLanR78=
X-Google-Smtp-Source: AGHT+IF1ECxZitb+Z1gvGxJubA2r+gN7ApIhAraLwq/Hx3ZsNhjSJsGL9Gp3ZL2knRHy2W96yaRpzQ==
X-Received: by 2002:a05:620a:2442:b0:7d0:970e:8dde with SMTP id af79cd13be357-7d3c6cdc861mr1816443685a.31.1750107292892;
        Mon, 16 Jun 2025 13:54:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a72a2bf06fsm53531891cf.14.2025.06.16.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:54:52 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:54:52 -0400
Message-ID: <88f740c7efa914435e2223e90666c8b2@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250616_1212/pstg-lib:20250616_1001/pstg-pwork:20250616_1212
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v4 4/4] Audit: Add record for multiple object contexts
References: <20250607005134.10488-5-casey@schaufler-ca.com>
In-Reply-To: <20250607005134.10488-5-casey@schaufler-ca.com>

On Jun  6, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS record is:
> 
>     type=MAC_OBJ_CONTEXTS
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++---------------------
>  security/selinux/hooks.c   |  3 +-
>  security/smack/smack_lsm.c |  3 +-
>  6 files changed, 80 insertions(+), 37 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 0987b2f391cc..451c36965889 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2337,6 +2344,55 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> +int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
> +{
> +	int i;
> +	int rc;
> +	int error = 0;
> +	char *space = "";
> +	struct lsm_context ctx;
> +
> +	if (audit_obj_secctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return error;
> +		}
> +		audit_log_format(ab, " obj=%s", ctx.context);
> +		security_release_secctx(&ctx);
> +		return 0;
> +	}
> +	audit_log_format(ab, " obj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < audit_obj_secctx_cnt; i++) {
> +		rc = security_lsmprop_to_secctx(prop, &ctx,
> +						audit_obj_lsms[i]->id);
> +		if (rc < 0) {
> +			audit_log_format(ab, "%sobj_%s=?", space,
> +					 audit_obj_lsms[i]->name);
> +			if (rc != -EINVAL)
> +				audit_panic("error in audit_log_obj_ctx");
> +			error = rc;

Do we need the same logic as in audit_log_subj_ctx()?

> +		} else {
> +			audit_log_format(ab, "%sobj_%s=%s", space,
> +					 audit_obj_lsms[i]->name, ctx.context);
> +			security_release_secctx(&ctx);
> +		}
> +		space = " ";
> +	}
> +
> +	audit_buffer_aux_end(ab);
> +	return error;
> +
> +error_path:
> +	audit_panic("error in audit_log_obj_ctx");
> +	return error;
> +}
> +
>  void audit_log_d_path_exe(struct audit_buffer *ab,
>  			  struct mm_struct *mm)
>  {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 322d4e27f28e..0c28fa33d099 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1098,7 +1098,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 char *comm)
>  {
>  	struct audit_buffer *ab;
> -	struct lsm_context ctx;
>  	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -1108,15 +1107,9 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (lsmprop_is_set(prop)) {
> -		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
> -			audit_log_format(ab, " obj=(none)");
> -			rc = 1;
> -		} else {
> -			audit_log_format(ab, " obj=%s", ctx.context);
> -			security_release_secctx(&ctx);
> -		}
> -	}
> +	if (lsmprop_is_set(prop) && audit_log_obj_ctx(ab, prop))
> +		rc = 1;

We should probably use the return value from audit_log_obj_ctx().

>  	audit_log_format(ab, " ocomm=");
>  	audit_log_untrustedstring(ab, comm);
>  	audit_log_end(ab);

...

> @@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -				call_panic = 1;
> +			call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  &context->target_ref, context->target_comm))
> -			call_panic = 1;
> +				  &context->target_ref,
> +				  context->target_comm))
> +		call_panic = 1;

I appreciate the indent fixes, would you mind pulling this out and
submitting them separately?

--
paul-moore.com
