Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839D1DFDB7
	for <audit@vger.kernel.org>; Tue,  3 Dec 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263621; cv=none; b=eMRNOFWSMQR9PS030HfpDPKaIhh470q6izyZhhfUUohvV4bHktiB4cbIIFKdwvVODQmp0FakwaaGz1wGZcGhMijTNJ2l7F3bZizazE/nQSAoQxNtBfGUduDBY9oK8Se+p/TwTGfK13fLThNC49u6x6CCfnnOIoGgaKZyNcpCH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263621; c=relaxed/simple;
	bh=h+BQKIpXE4PFsE+g1hGX/fGHcZIR8qmk9HgPMyMc0G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVRCBNqR9unbpW1zIM11YzByttVtaBNmmanrvjJGa2itfmFhP7SnYKnwv3ObwN0pmqeRzhMkNlPsnlVNZwTWCAfl6agW7hgBYNECZOdHWOA+HyjIazwSrnrjGri7t/fupLSn6SJ6OlVhAEXCEsCjDlyBvOj49Bc89r3VmT/rdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Db93qrQ5; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Db93qrQ5"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e382589e8fdso4217991276.0
        for <audit@vger.kernel.org>; Tue, 03 Dec 2024 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263618; x=1733868418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt6tgIhfEE2uF6kBtPnvdXe7p45YNZugHzIBc4FfBbQ=;
        b=Db93qrQ5EYM7aXfrgjgPcalpYxuZKA5C0yeoICRGCveWBKNzMxkvgIFwavOGV9v5Fg
         F0JZSznECFdLSo56xN/6RpSfQAS62Ngt2tHiJn/fEsfLHZiIQC5MZTYmtI+lA9jS+8V9
         XujLSt6dOM2xiWsi1xDD2dPtD7AxqtHZYUR9xv39v8tYR+1GvSH3/2LIjfIJ6ko09C85
         i6dp18I4ywTTFSDSe3vikUZXJutKF1+YvnbGgK0xYXZRz6KKQ3WIfaJM9aRYPxol9qad
         lxq6G9hNSPqYt970tdGEsFwJjfPmW+pimfrbot1yEKmK17hC1foYQ+RUxZU7STNxDHtc
         6Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263618; x=1733868418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt6tgIhfEE2uF6kBtPnvdXe7p45YNZugHzIBc4FfBbQ=;
        b=S5CDZCzGzjZbYMj4uq2P0bAxOjv3ym3CR1RhhjwV6SHeGMIBIgYv/k8pXlQqN2bGs3
         sJdFvfPXFYllKUUIMKkwl8URnu9oZ4jsQ3SjcpUQ5hMwYYBKhWLIapW+LiFmF6P6mwTX
         Z5a3Gq6OJlgWo3K+59hHzAsQOCApDzDU3hr1HVVtVoDPyXFSi9Swqox8ypMjwPpmmsIi
         UM3hD4FoouZCjl+Rxk9CCueKtb40l2QEMYNQ0tfrfysLgCl0NGEdL3NIMTqNHa3XHNA/
         TmmY+1Id46RCPuiqzUmWxagTrjKHeQrA/Bl9aNdabl7mnxS7sophvF/BYsFsgvQfLwBH
         ZddA==
X-Forwarded-Encrypted: i=1; AJvYcCV0MB34DLfzYnkeXV+CHosNySgcQIDimzcQgIbxgwf0D3mHcM3eDjL5xb5qCmCEA11xcaHJDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/+NhxgpfIkzIZwrO37iLVvlH9Wm3DEilfX11oLEjuckYVY62
	snwto/semQtwa4QwskJeWRJrmJilYQJcxfq/icaHM9hwetO27Rf68uIAm0Poli9Zx8ZlRWiSCnl
	WtsXi0piaxHAHBZtuK+XyysdcanlhAlA97E1J
X-Gm-Gg: ASbGnctwPTtqe1sVUMwYlT9tNtFy63/udAEei5IbmVTs5vwLQ4zUlS4NpvNQZaNiapj
	QYcrChIM2PLZ+JB0RWWNHFf5bZpbezw==
X-Google-Smtp-Source: AGHT+IFcDIYh0s6VN6UUlT7OSsptdYbkjMKXFFp/bpJc9hg8XcEtPBjjWR1dCJHKcOpGDI4z6ka+Kba83P/F1EPrKao=
X-Received: by 2002:a05:6902:18ce:b0:e2b:c7a7:7a3e with SMTP id
 3f1490d57ef6-e39de1e88a8mr2399999276.3.1733263618691; Tue, 03 Dec 2024
 14:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com>
In-Reply-To: <20241203060350.69472-1-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 17:06:48 -0500
Message-ID: <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> From: Yafang shao <laoar.shao@gmail.com>
>
> A build failure has been reported with the following details:
>
>    In file included from include/linux/string.h:390,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:63,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from kernel/auditsc.c:37:
>    In function 'sized_strscpy',
>        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflo=
w' declared with attribute error: detected write beyond size of object (1st=
 parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>    In function 'sized_strscpy',
>        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:=
3:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflo=
w' declared with attribute error: detected write beyond size of object (1st=
 parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>
> The issue appears to be a GCC bug, though the root cause remains
> unclear at this time. For now, let's implement a workaround.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@i=
ntel.com/
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local=
.home/
> Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF38936=
2@CY8PR11MB7134.namprd11.prod.outlook.com/
> Originally-by: Kees Cook <kees@kernel.org>
> Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@kees=
cook/
> Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/auditsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, does anyone have a link to the GCC bug report?  We really
should mention that in the commit description and/or metadata.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 279ba5c420a4..561d96affe9f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
>         context->target_auid =3D audit_get_loginuid(t);
>         context->target_uid =3D task_uid(t);
>         context->target_sessionid =3D audit_get_sessionid(t);
> -       security_task_getlsmprop_obj(t, &context->target_ref);
>         strscpy(context->target_comm, t->comm);
> +       security_task_getlsmprop_obj(t, &context->target_ref);
>  }
>
>  /**
> @@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>                 ctx->target_auid =3D audit_get_loginuid(t);
>                 ctx->target_uid =3D t_uid;
>                 ctx->target_sessionid =3D audit_get_sessionid(t);
> -               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 strscpy(ctx->target_comm, t->comm);
> +               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 return 0;
>         }
>
> --
> 2.43.5

--=20
paul-moore.com
