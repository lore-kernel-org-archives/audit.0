Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F93205ACE
	for <audit@vger.kernel.org>; Tue,  3 Dec 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267624; cv=none; b=mJyw8Q0OoRYlseIm7p5P8Qpn4Wlua2o0AI3vM2HOSl06JGCA+C5Bl/0liPsUtvIP2zGyeKIn86F3wipi6EmjBQwXBVjLzho5uIGfCEhXehWckVSba4AFgxsNmfpURdf89MAU7W9jBNxsq9/IcpCz3hjdYG/FpPdZNukAAmpPdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267624; c=relaxed/simple;
	bh=T1DfAvfSKT/yTo8pOjR+H0hgWWAEDncbMVCqDAIuFkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJni2CNxoVj++JgMtxGcR2sv590qOgiB4SCiBkzH33PiZlngvzKLDP0sEjQQ8shM/aMZfvuR7EUPzO5vNOM5oRPal1cmPTqmjtKDB64LaxXjnCRNvKkAS+1h2DOuBI/Plczf4VS1AFEN90py8ttF2kxgPy2ObMPU83t/gfvZu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KJmxRgos; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KJmxRgos"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e398273d6ffso4600896276.0
        for <audit@vger.kernel.org>; Tue, 03 Dec 2024 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733267620; x=1733872420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xASkeX0kWqgVIiC/SnivnP44lIKmYI/S+xS1gTSLSYo=;
        b=KJmxRgosPm/tATQcDdyv5ursybaHKu1NdvFXitd9wQsQ6g17bkV6Nr0eLtgx+45Zes
         w6oZADW0tPTup8nqUe2hoVDtqxhAOqeLI6ZHWvi8Gt+oFQFzO9lwZjdFmf7Ry6urcntt
         wRfj3rRktpQRavPtMS6jB7ohxX+giG31elXkw+4ficc28WEb05i8gVVHU0k44zXCozl/
         88cXF2NUUVKpV4i71trk+xpwrgr57psivj/3p0zcOSh8D/OGdHS6CR6lKtzgJxCKgTfM
         Y5pYzt7vzht3nIap5KQ8TT8E7UwIvjc7TDbS7oj84IAnKU6Piurf5XM03eMuo93Y5J6R
         zs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733267620; x=1733872420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xASkeX0kWqgVIiC/SnivnP44lIKmYI/S+xS1gTSLSYo=;
        b=ZMkhDRU4R8gNTavFwPNPW/OyoCY+YdMSAkdcn0isFC3cOhXEJpxK5wuH780kNgZj3R
         xwAKutpPd1Q/hpj2L7wQ+QzboCphNYyhsVRf4tD878qqZQX570gZ6QwfBdLwVW/FwmMi
         XxVDSsDN0o8CpScDTyaevftwiY0hfh0LfPSP6aazCq3EbjODdLOC4s5FtAQ3AOhVY1ZM
         yDhELlrcI1wIUcQXKsbUswJvuKXBLCFZ7alAQtN8XUkozTXCWnhUzg6hfaccERVsLO3J
         bOQy0ji1XoedzKrA5gKUOP92vvm8P70/464ZNfgCx8/1Swd8ujloffNr2GzZHUFTSUf0
         Y/ig==
X-Gm-Message-State: AOJu0YwKZSQySHhXZdFlKIF+IcMBFbFG/yIA9mefIMjb0wBiVaW4oMk2
	SM/+XnoB6UXyDAgQ1MFG0uWj4NvHF1hDvtuGwDbM6HJ8r3+bvIapfskT6vaTUZkEIxCXYKw4jv1
	xCWM2m75CBKi2GAgQrkbRLehOebmjeMPAAlMib5Cy2FiP4gg=
X-Gm-Gg: ASbGncs1QZNWV+8H+l86VkXwkbJEcmyn6CCaNXY2/dz+Vss5Riwu+NwetSjvyxKruKH
	1zP1+hJah4ipRJz1bLEYY0EhbCaaxPg==
X-Google-Smtp-Source: AGHT+IHCJEmxXqoCjYRRhl8xD7ltWGOF/UdY3OytCC+CHpRYtE6wde4v6pA4hpza8FOMQpNewFWC1ZB3Lc7czwkL2Hw=
X-Received: by 2002:a05:6902:1895:b0:e38:b2f3:b7ad with SMTP id
 3f1490d57ef6-e39d4386e75mr4900384276.45.1733267620306; Tue, 03 Dec 2024
 15:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202014217.34580-1-15074444048@163.com>
In-Reply-To: <20241202014217.34580-1-15074444048@163.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 18:13:29 -0500
Message-ID: <CAHC9VhQwifyzueutyzy56D-G=7erf6KK=r__B9RWJY04fN3dJA@mail.gmail.com>
Subject: Re: [PATCH] kernel/audit: Use struct_group() for memcpy() region
To: 15074444048@163.com
Cc: audit@vger.kernel.org, eparis@redhat.com, lihaojie <lihaojie@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 8:42=E2=80=AFPM <15074444048@163.com> wrote:
>
> From: lihaojie <lihaojie@kylinos.cn>
>
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
>
> Use struct_group() in struct audit_context around members target_comm[],
> This will allow memcpy() and sizeof() to more easily reason about sizes,
> improve readability, and avoid future warnings about writing beyond the
> end of target_comm[].
>
> "pahole" shows no size nor member offset changes to struct vlan_ethhdr.
> "objdump -d" shows no object code changes.

That's obviously a cut-n-paste error above, please fix that.

You also sent this patch three times, that's very annoying, please
don't do that in the future.

Finally, can you provide a link with an explanation as to how the
struct_group() union/annotations is the only way to do this?  It's
kinda ugly and if there is another way to do this I would like to
understand what it entails.

> Signed-off-by: lihaojie <lihaojie@kylinos.cn>
> ---
>  kernel/audit.h   | 5 ++++-
>  kernel/auditsc.c | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 0211cb307d30..20483670ea02 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -145,7 +145,10 @@ struct audit_context {
>         kuid_t              target_uid;
>         unsigned int        target_sessionid;
>         struct lsm_prop     target_ref;
> -       char                target_comm[TASK_COMM_LEN];
> +
> +       struct_group(comm,
> +               char target_comm[TASK_COMM_LEN];
> +       );
>
>         struct audit_tree_refs *trees, *first_trees;
>         struct list_head killed_trees;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 91afdd0d036e..e279762463b0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2729,7 +2729,7 @@ void __audit_ptrace(struct task_struct *t)
>         context->target_uid =3D task_uid(t);
>         context->target_sessionid =3D audit_get_sessionid(t);
>         security_task_getlsmprop_obj(t, &context->target_ref);
> -       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> +       memcpy(&context->comm, t->comm, TASK_COMM_LEN);
>  }
>
>  /**
> @@ -2756,7 +2756,7 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>                 ctx->target_uid =3D t_uid;
>                 ctx->target_sessionid =3D audit_get_sessionid(t);
>                 security_task_getlsmprop_obj(t, &ctx->target_ref);
> -               memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
> +               memcpy(&ctx->comm, t->comm, TASK_COMM_LEN);
>                 return 0;
>         }
>
> --
> 2.25.1

--=20
paul-moore.com
