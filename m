Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1F1F3BB3
	for <audit@vger.kernel.org>; Wed, 12 Mar 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823503; cv=none; b=ByqqLNDK9wx97zF5Zfn1aoyrMNdruNyH/X3E8Fpa7lS6IY+FWFWm+rDHTChWhnJacPnnCJN3Q1yhHPCmKXpQQDkH5b6VyVxSVWFYaBXM///yR6yiwqxeyyP/0q5Hav8VpeQeieW5V+oVyxCBeTyTXNANy//Y7ndGciOhYlNsMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823503; c=relaxed/simple;
	bh=OqK4+EI0TbzhbvaQRc8UpdLTwB+tY8fTMAJuj3Y4hzo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ezRC/AAZ4vc0dTyG0h9bBpFqSrBRyuOJTDZrTBCXsCkj/FVM2iwQY0jMSO4NmQ3N8Y/1q7ihDsbJPpP71Ry4oLO4Ftjec7MSmMmJE0pq6gidFeWaGjQFPcS/v/oMni6RgXxLnVJuzamTPi/mKz+gaQA+uPDySlqdxd1ud4blACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Evv093QN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Evv093QN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f05acc13so4671036d6.2
        for <audit@vger.kernel.org>; Wed, 12 Mar 2025 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823499; x=1742428299; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=Evv093QNcDQqsE7ZwfMOQOk6wQ6pnItsC2+RyPv/F4HzhGynZsQ1YtMlLPr0+N8JKZ
         rU7ZbRX18N581teTBS4FH3XX8h7MBIB0mBNyGlacJCgacGuTxgMmUJYlAop8g6Z+X1w8
         SIb2iQPv2VG90GhLQPS0pktyCIQAzFPb37ZZjTnpdN7piLU6PFLkXKLNM4sWrewX1kpc
         fB1K9woFBrzsQhuqElTwMdiwrstFgwmixCGaiFQz7j6++BIv4WToynCoa3ECaQVuXoov
         f/p6dxMc6+vHr0UIbAKYJp84wW3mSWVgX7UX6QA1AVM6ZhUk79j4EU4KG9BNanaM6LMw
         v+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823499; x=1742428299;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=T33YcpqRLm2xV3vAtCQywRkES5D3LX9duQPjFYgcgDXC56wTwUV5ppmkpTKmr0DKVk
         BYYNxV9dlBohbMPVvMWojDgCibYSm0WpZh4DT0GKTely9bn42R7uIdFSN/N/4lx8vI4l
         x2AmeZV8jLuS//wGNMIx1Rskq3T+lBSxPN0qxN53KKQPDbaFRqzqV+jSL0VOXJS2ne+R
         7BdjXHbrgNBv5phKGSymos+bAy4z2vZMRxsx5qgSi2km4ZjkPeCJMerel+0CVspVA0RV
         tkPo0ylIeSeuFbyEVPf14gmK0GCvYNqQe+w7z/7LnmEdXoESvfIOsEC3a3FcPLVRjA1S
         b+7w==
X-Forwarded-Encrypted: i=1; AJvYcCVi1iN6fvh0x4vNUHXRSwX3aProKjSHR0HJiWS1nfHcxrH9a7lY0J8/DU1HEMXiswOndHmmtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwLWzr6idFoKGV5+r/XwNCqhUJFRCAQSf1ccZaVUWvd40mISj
	oFFaPxswm2IhqdleNC4Lqkj+nYIJD0aHYdKqGMLMLF8YwaCPxKdLnu8P6n4rXg==
X-Gm-Gg: ASbGnctvmfY6UiHcZqhk4vzGf7FstJXGf0KxDw2suJ1w93C/7+pzWG5HqG0Brv7THlL
	+8sUKUKdh4eTeg+aUr6Dtdz+UNfDW8RQRUhlUJ5zHIbZxmTECqpns7M3cIO7Pd8o+joK62sLC8y
	n2qkbObJJgGlo0ceeNgaMOGPeJCamGCsqUlKVEBou5a6Or5PpIWBuhlietGuE3H/qvqkx3ppGLx
	y07Y0sMJ7KaEMuIn6gfmZxYDpIyMJHfHB2gMthbFQE0FHgxTeWs7CSpesj/v9nuL+768yjF3/mx
	BZV5DYPjbBK6yuObdEAi0+HB51FKvI73dIf/WInUgM5JVm4Kijj+B34C3Kl25O2yL5iSqi5hoPb
	/jZdml4ER6LgsLA==
X-Google-Smtp-Source: AGHT+IFlyR/GAqSTyYhAIKsmF0zsCtOyT1xvl6rvyoCreNYLYVbRsQ3f/WRhdPpglFjVH6KtCvTPRw==
X-Received: by 2002:a05:6214:c83:b0:6e8:f0f8:67f7 with SMTP id 6a1803df08f44-6e9005f7742mr372102726d6.16.1741823499484;
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade236776sm1858186d6.49.2025.03.12.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:38 -0400
Message-ID: <f64ab132bdc436ec70ded81f83324f15@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
References: <20250307183701.16970-7-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1424) record is:
> 
>     type=MAC_OBJ_CONTEXTS[1424]
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
>  include/linux/audit.h      |  7 ++++-
>  include/linux/lsm_hooks.h  |  3 +++
>  include/linux/security.h   |  1 +
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 53 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++------------------------
>  security/security.c        |  3 +++
>  security/selinux/hooks.c   |  1 +
>  security/smack/smack_lsm.c |  1 +
>  9 files changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ee3e2ce70c45..0b17acf459f2 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -186,8 +186,10 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsm_prop *prop);

Less is more, "audit_log_obj_ctx()" to match "audit_log_subj_ctx()".

>  extern int audit_log_subject_context(struct audit_buffer *ab,
> -				     struct lsm_prop *blob);
> +				     struct lsm_prop *prop);

Do that back in patch 5/6 please.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index f0c1f0c0b250..054776f29327 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1116,7 +1116,6 @@ static int is_audit_feature_set(int i)
>  	return af.features & AUDIT_FEATURE_TO_MASK(i);
>  }
>  
> -
>  static int audit_get_feature(struct sk_buff *skb)
>  {
>  	u32 seq;
> @@ -2302,6 +2301,58 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> +int audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
> +{
> +	int i;
> +	int rc;
> +	int error = 0;
> +	char *space = "";
> +	struct lsm_context context;
> +
> +	if (lsm_objctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &context,
> +						   LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return error;
> +		}
> +		audit_log_format(ab, " obj=%s", context.context);
> +		security_release_secctx(&context);
> +		return 0;
> +	}
> +	audit_log_format(ab, " obj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (!lsm_idlist[i]->objctx)
> +			continue;
> +		rc = security_lsmprop_to_secctx(prop, &context,
> +						lsm_idlist[i]->id);
> +		if (rc < 0) {
> +			audit_log_format(ab, "%sobj_%s=?", space,
> +					 lsm_idlist[i]->name);
> +			if (rc != -EINVAL)
> +				audit_panic("error in audit_log_object_context");
> +			error = rc;
> +		} else {
> +			audit_log_format(ab, "%sobj_%s=%s", space,
> +					 lsm_idlist[i]->name, context.context);
> +			security_release_secctx(&context);
> +		}
> +		space = " ";
> +	}
> +
> +	audit_buffer_aux_end(ab);
> +	return error;
> +
> +error_path:
> +	audit_panic("error in audit_log_object_context");
> +	return error;
> +}

Let's follow the same code pattern as suggested for the subject.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d98ce7097a2d..82470862ea81 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
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

Thank you for both of the indent fixes above.

--
paul-moore.com
