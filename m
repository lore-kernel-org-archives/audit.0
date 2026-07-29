Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85C43803C
	for <audit@vger.kernel.org>; Wed, 29 Jul 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362593; cv=pass; b=YmTWCTlhlos+/A9mTBkkkH802Ar9ZPwuCuWXs8s9hq7A+EGXaNKjnACBfw4Z9vIdKD5EYXxkss/Ue01OYJTTjqrw9oSLa+9fxKf2jKzVqaRTQIObFLcgrHbOqMSbpjFoH4cm6TOWOc3CMuuu07yReQQf8akVWTWujR/jChu4IyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362593; c=relaxed/simple;
	bh=HcMbH29taY+ufNcfCTbZJI4vNI2GzSiaiAez8EQJNgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBrUNOstaynIZ7CmTW0d9iFFGvDjJyyIOh6wWeGhrHHUnz7Ix2xPBFizWsrKBJ++6JHlNi5csRHCR+t0sqO5pCC2wQSmBJo0DI3ruBP2Hxy9Nq1VFVdfOraUblfAOA+qLPNVaKXzxFaXaLubT/7TitVW/3BVMUQt40k9kaW+scg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sbe7PTzB; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sbe7PTzB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1743656a91.2
        for <audit@vger.kernel.org>; Wed, 29 Jul 2026 15:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785362589; cv=none;
        d=google.com; s=arc-20260327;
        b=gUpW5lZCaDnGu0dpqXBp+fj/jH+pZd/K5R+w8ObHjL5W6I7e3lW3M+PGWhADVYYfrO
         02W8ahttqlyYWwyXmSF/RDe1f10nwotIDOk3opeubpEAXzLP6n7mhcaNDiHk+PWwP0pn
         hJ254PILsFLKXeMVjjk1j1V0tBDbHmFez/ksNo9NGGOoUO3gFpWCtD0VAA2k3XNRyA/s
         zRUpSSEZ7dHoWUOK95azP7hgpWVxvJ2l/IeMgR+t6+oGfe5xVVIwF1jp2oPNqs5tqyBq
         IS4jS+jUSGBdqmMwKsSMUCLKEtlaJi2xrxyy8PwMM+bVIlzZw9g3qlBwYmne0F7emYFu
         lSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tf+R8andN/8C1l9MVMV+XEC/VXhqnJMJYXGT9VY4exY=;
        fh=GDEtS87Wl4+QJBWppBeZMbnAHKRuKQ0xuJsAytQ2ACg=;
        b=o83C8BrvOpAowzHmi5b9IYdwhZ7L8YlhOEpXv00IEaa48DHARpYESiF9zDvmuFW1Bk
         X1RkE9tcmTvRTX0tDijQoFWOEPMlIPYj82P5UVGnN7JGwsdoSN1cU13n/xw05k4omC2P
         QZ4jFRUM8G601A/8h/yuc1+rKnijAc+0MLwBQxh6S4xKpjSRhlXgkU/NtQdsoorSjsEG
         SJ/6tbZNqKQOnSpzeoSYNtIICUiHaUdzvrOY9DZL3wFfOFBLPs03tuxstZm6kewUpYtL
         Yxsidj+hq0z3w8Xa1Ts2DqwK1RrO54dz256NaH9r8kHZ3nE0XDxT4fwCEYaaBxyRdrBj
         pOzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785362589; x=1785967389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tf+R8andN/8C1l9MVMV+XEC/VXhqnJMJYXGT9VY4exY=;
        b=Sbe7PTzBFpbscn3r1e01imuXl/FChP/xTd29kaJH01wO/zk4eKvfkEslwN9wzQuCEq
         WaKPCZoIbmO0BD9+u8cvo9y8w6mo1r9igiykhpL0DDLBfEBolkPXX5saMEIUwLxClp5Q
         WVPaaFyTGt4t4x8wDAfJz2P++YI5PjrxZrL4rJUASzmzE9W0d7DeLPwKqoeaWj5nVJ0i
         ZcolCFk9G5NyQHMPfesRZCN56ETfetkij05B4Ipg1XObew/L9xUo7h03/NGDSA8CUgsA
         pIx+ioGGDE3hfFWEQLShQplUjR2kc2yydx9Xnvdsc5puVO9hml5tzgmmELhWhn3QBd1m
         aU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785362589; x=1785967389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tf+R8andN/8C1l9MVMV+XEC/VXhqnJMJYXGT9VY4exY=;
        b=rnCCeQi8qFUvArZz4zXyE4YxXdDAIyNJ+IEn7W+EEOU4lh7p01AFCnwy7z2lxzQdbQ
         jSKDnebrS8rpJsmVcMVIxOacXVrg7cbHP9OJTt0FDepb8IfBBGLUY1BexGu1AqS9CnID
         PFCkFstbrJuGdxeIYW3Mf1iwpDFqXxZ9h1UWGeuXkJjeqfD52+C/oBGvmVPHE0QEpI0x
         DXxhgWXobro2Qi3pK2DjSWdb9v6Hd+cwJ3kFSsP197Kuz0Af1w4N/frHm1JuT7kmExQO
         m4SgGd9h1Oq1CZhPOSUvim80U5axQWQXLpR6SgQ1ayvrghD6hsQo4aFsOYZbcAjNRkS+
         ZpNA==
X-Gm-Message-State: AOJu0YzCBFHbUtJIZQhdFhdqJVrd58c3rWgOeHv+jN9b6VIhWzJkPrkc
	ccPRLfZnowcd+8WxBUgcmVpT7fTk8P96cpn5fG5+Gb26p+zAp1XVgSQsPXzDj5IPbH+dnLGg5gv
	rjwlI6U9XqJRN6gR+kcJJSiwWR9eldNcElnyRajgo
X-Gm-Gg: AR+sD11xl2poehDZXjebiVAW1fxC/QuwyCwGVFN6yxGfqUi2U1JTeVya5jpg5yxNDIb
	/h7pTNWX9d4GtMIHRzes/9sjssNPcQjBcG72BQV7d8humhW6YVpf8nhFC/BLRNaona/SnhZuYXh
	Zqy+kqkhGIkOHtV9/yQ1CGilLrZTMPP8+6OPr3rzy3TKzEM1N96ijtWEVEr2wScKXqs1dv17Nvj
	AYLJpWl9uuACnMQgxgWBTezcxwTlVQxaFEgvDCENR8j2L7FaSDOOfpmnXSCptfUheqvIVQ7C3SM
	co73qQEopIk2ef7KYhZrBU9eoYau4l8pz5kpIXzqnifO9U+ojXPj/SdV
X-Received: by 2002:a17:90b:4c8b:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38f9c03f3f8mr16712a91.29.1785362588743; Wed, 29 Jul 2026
 15:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724150258.560396-2-rrobaina@redhat.com>
In-Reply-To: <20260724150258.560396-2-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Jul 2026 18:02:56 -0400
X-Gm-Features: AUfX_mzcntZ6VC8RqxPzHKxTitoDJtU_-OrjKrjMj_YpWSH2DybA-fWhadZG5cM
Message-ID: <CAHC9VhSzhyw--ycYMG_RaT5wpRQWDPBSuaNixsVrWrRXKc9hzw@mail.gmail.com>
Subject: Re: [PATCH] audit: add CLONE3 auxiliary record to log process cloning
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, sgrubb@redhat.com, kees@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, david@kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:03=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
>
> The clone3(2) syscall moves most parameters to struct clone_args.
> For this reason, the generic SYSCALL audit record does not capture
> the structured arguments.
>
> Add a CLONE3 auxiliary record that logs: flags, exit_signal, cgroup,
> and pidfd fields from struct clone_args. When CLONE_PIDFD is set and
> the syscall succeeds, the resolved pidfd is logged; otherwise
> pidfd=3D(null).
>
>  ----
>  type=3DSYSCALL : syscall=3Dclone3 a0=3D0x7ffe7f1ec640 a1=3D0x58 a2=3D0x0=
 ...
>  type=3DCLONE3 : cl3_flags=3D0x1000 exit_signal=3D17 cgroup=3D0 pidfd=3D3
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
> @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 of=
fset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nent=
ries,
>                               enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)=
;
>
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name,=
 u8 af,
>                 __audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
>
> +static inline void audit_log_clone3(struct kernel_clone_args *kargs, int=
 ret)
> +{
> +       if (!audit_dummy_context())
> +               __audit_log_clone3(kargs, ret);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, =
u8 af,
>                                    enum audit_nfcfgop op, gfp_t gfp)
>  { }
>
> +static inline void audit_log_clone3(struct kernel_clone_args *kargs, int=
 ret)
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
>  #define AUDIT_OPENAT2          1337    /* Record showing openat2 how arg=
s */
>  #define AUDIT_DM_CTRL          1338    /* Device Mapper target control *=
/
>  #define AUDIT_DM_EVENT         1339    /* Device Mapper events */
> +#define AUDIT_CLONE3           1343    /* Record showing clone3 args */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant *=
/
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..c0106bb71c19 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2882,6 +2882,26 @@ void __audit_log_nfcfg(const char *name, u8 af, un=
signed int nentries,
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
>
> +void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> +{
> +       struct audit_buffer *ab;
> +       int pidfd;
> +
> +       ab =3D audit_log_start(audit_context(), GFP_KERNEL,
> +                            AUDIT_CLONE3);
> +       if (!ab)
> +               return;
> +
> +       audit_log_format(ab, "cl3_flags=3D0x%llx exit_signal=3D%d cgroup=
=3D%d",
> +                        kargs->flags, kargs->exit_signal, kargs->cgroup)=
;
> +       if ((kargs->flags & CLONE_PIDFD) && ret >=3D 0 &&
> +           !get_user(pidfd, kargs->pidfd))
> +               audit_log_format(ab, " pidfd=3D%d", pidfd);

Do we care about distinguishing between the combination of CLONE_PIDFD
and CLONE_THREAD vs CLONE_PIDFD alone?  In other words, do we care if
the "pidfd" field sometimes represents a pidfd of the child process vs
a thread in the current process?

> +       else
> +               audit_log_format(ab, " pidfd=3D(null)");
> +       audit_log_end(ab);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>         kuid_t auid, uid;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0e2e131a9a5..0f52e8c0e900 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3047,7 +3047,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *,=
 uargs, size_t, size)
>         if (!clone3_args_valid(&kargs))
>                 return -EINVAL;
>
> -       return kernel_clone(&kargs);
> +       err =3D kernel_clone(&kargs);
> +       audit_log_clone3(&kargs, err);
> +       return err;
>  }
>
>  void walk_process_tree(struct task_struct *top, proc_visitor visitor, vo=
id *data)
> --
> 2.53.0

--=20
paul-moore.com
