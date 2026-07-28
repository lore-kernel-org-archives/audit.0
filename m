Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AD37E5C2
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256277; cv=none; b=QtdW1dv8WSHeul4rfaAs/d4RgFKJI0neBAaRSX1QBqITw513OJOmZtJN/CHU6zPdxeFiOyBcIvTVkRG5hfibBU3LC1RHSG9pO7ZADbgKu4RU88wlayDCXTG7Onbos1ySUz40E9wuX/R0waoSy9BQDlT16r1VBGPihd8TuuFN5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256277; c=relaxed/simple;
	bh=qOKnkJcMl+/bY0vsL5JrJr8Xg2jeZslfJj9zzLsETy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MBCvawOv9junfuE1T7k7pcNh5MLBq5c1koyFlYBoB1uC+BBiXB18V1WF+MhNyYbma2he6yMq8jqVUYlKTDVI9QfYj57mHkUnLpTQOrT13b03XdMwS91O5BclidhRWN6RA1EGKK2du9Gb30ZdCPnYIuql/E0PnyS021eU/SVneQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKzewIKk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKzewIKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785256274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qvz+f9qd1XslHKjpkIvG5iZUOK8HWLkYqkSa2lLHUw=;
	b=VKzewIKk9jEsZ36bh3u/9yZRbj6oiw39Q0YUVjDcu+OPkWqbh/SB6r1pSAp3RUj35bfTFh
	C0GzTmqlolVp6tTxgGTMH8mBIRu8hcOGh47Nv6LM2iAhzjnG3Shq6u3cW36oXoOq6/in0a
	JO7s4THCe1CmYO0jfLIaElWpa0Zhxhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-UUTgbLUtMwCTt3lPXG5hBw-1; Tue,
 28 Jul 2026 12:31:11 -0400
X-MC-Unique: UUTgbLUtMwCTt3lPXG5hBw-1
X-Mimecast-MFC-AGG-ID: UUTgbLUtMwCTt3lPXG5hBw_1785256269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB5EC1800562;
	Tue, 28 Jul 2026 16:31:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB657180044F;
	Tue, 28 Jul 2026 16:31:04 +0000 (UTC)
Date: Tue, 28 Jul 2026 12:31:02 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, david@kernel.org, brauner@kernel.org
Subject: Re: [PATCH] audit: add CLONE3 auxiliary record to log process cloning
Message-ID: <amjZRgbKg7svHU7r@madcap2.tricolour.ca>
References: <20260724150258.560396-2-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260724150258.560396-2-rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: uBY46M0cDw8foyKlFUjV33bBsg7X8klM3Y-XDiVM5as_1785256269
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2026-07-24 12:02, Ricardo Robaina wrote:
> The clone3(2) syscall moves most parameters to struct clone_args.
> For this reason, the generic SYSCALL audit record does not capture
> the structured arguments.
> 
> Add a CLONE3 auxiliary record that logs: flags, exit_signal, cgroup,
> and pidfd fields from struct clone_args. When CLONE_PIDFD is set and
> the syscall succeeds, the resolved pidfd is logged; otherwise
> pidfd=(null).
> 
>  ----
>  type=SYSCALL : syscall=clone3 a0=0x7ffe7f1ec640 a1=0x58 a2=0x0 ...
>  type=CLONE3 : cl3_flags=0x1000 exit_signal=17 cgroup=0 pidfd=3
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/151
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 20 ++++++++++++++++++++
>  kernel/fork.c              |  4 +++-
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 45abb3722d30..833f349bf415 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  			      enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_log_clone3(struct kernel_clone_args *kargs, int ret);
>  
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  		__audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
>  
> +static inline void audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> +{
> +	if (!audit_dummy_context())
> +		__audit_log_clone3(kargs, ret);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  				   enum audit_nfcfgop op, gfp_t gfp)
>  { }
>  
> +static inline void audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e8f5ce677df7..37357e17adbf 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_CLONE3		1343	/* Record showing clone3 args */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..c0106bb71c19 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2882,6 +2882,26 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
>  
> +void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> +{
> +	struct audit_buffer *ab;
> +	int pidfd;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL,
> +			     AUDIT_CLONE3);
> +	if (!ab)
> +		return;
> +
> +	audit_log_format(ab, "cl3_flags=0x%llx exit_signal=%d cgroup=%d",
> +			 kargs->flags, kargs->exit_signal, kargs->cgroup);

Would there be any confusion if this were simply "flags=..." since it is
already a record type AUDIT_CLONE3?

> +	if ((kargs->flags & CLONE_PIDFD) && ret >= 0 &&
> +	    !get_user(pidfd, kargs->pidfd))
> +		audit_log_format(ab, " pidfd=%d", pidfd);
> +	else
> +		audit_log_format(ab, " pidfd=(null)");

Is there any interest in:
	child_tid (was captured by generic audit syscall arg 4)
	parent_tid (was captured by generic audit syscall arg 3 or 4)
	tls (was captured by generic audit syscall arg 4)
	set_tid

Is there a situation where a valid pid is returned without CLONE_PIDFD set?

Otherwise, looks reasonable to me.

> +	audit_log_end(ab);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0e2e131a9a5..0f52e8c0e900 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3047,7 +3047,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
>  	if (!clone3_args_valid(&kargs))
>  		return -EINVAL;
>  
> -	return kernel_clone(&kargs);
> +	err = kernel_clone(&kargs);
> +	audit_log_clone3(&kargs, err);
> +	return err;
>  }
>  
>  void walk_process_tree(struct task_struct *top, proc_visitor visitor, void *data)
> -- 
> 2.53.0

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

