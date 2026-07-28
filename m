Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95F36C588
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255390; cv=none; b=CrHVZIfNy2OzllNPuxijC0uvoSbN+dBHTa1BEzfgwwuW5Fukb+sNOHZaPAT/GlxmM3pF8rUEmBhTxad5B+P37v3PHARQV9pMw0XtfIwzZymjiVpU6DKuYnj+PyUGWm7rP8lw9NjqfeYRlpP+RiV+Db0wL+q/elIzexmiD6ayGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255390; c=relaxed/simple;
	bh=zbP0fgi+EApB+uBYo7yptEDQz6XO8DHNjqcRXnDFGI8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pHsIbFRJMXc1yRBC2IpDs878pN1vxdp1bEAm9ziffRza6A4mMO583lzMt/oRVwWINhDFjYbhutDy+KPLAh5F/qVl4h0Lb7fkOiNcuRAHxsYWpV25aJs+273nLfsRU9S9p5WZi07OyANi45g+qwEjsvimgIlkaWeDAWaLMr4p5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MLrO+Sc4; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MLrO+Sc4"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-976ea28c65fso2193552241.1
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785255387; x=1785860187; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAriX3tLCmrnUO4qSHhwDGkR5q4S1pPXvajnZr56PhA=;
        b=MLrO+Sc4b6q1HMMDqe8zweEY+eTufkd72mEHrcIeunJYiD+DD8V3OG6GtVPpqOETgf
         5eiXG39R6K6hoE7+QJXkI2Luw5UzPtDYiaB8Gs17bACYCsCG8nhymMPxlcfrulcdKfap
         QLxp8M7Hzc07VUZqFr6zWw8gZyP9K0PJjQCoBwIwZULxzOeI3tZyALg8nhbKRV3nZzFx
         vHUYM7XA0Mi46VMkSq6YTUr8ySBzQxhvs1298n0Fc+6amab5jL3t5JlPUT9+pa5Dmivm
         29uFdxdKQ6eYJO+r6HPiqe6gD/VCbBJQ3FZk56Bm86uI6jWgJJXbAbLhRKFNkr+HpSB2
         ntLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255387; x=1785860187;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAriX3tLCmrnUO4qSHhwDGkR5q4S1pPXvajnZr56PhA=;
        b=JUGY8ygAMLKlCTYRSXkbmohfw7TlCyu5uyev+/u/hC9c9Psp+xPrSlr5BXJqh6i3K1
         lNM21Hi5N2jhGZjQolyvpd2wQLf4JiLw3ybjMw3lgJ1LhxEGHjcR7h90W4yP+yn+YUfz
         M0EpZGSo81uGhpM1TmUBsfpcjBhqLkjswicZ6f8a3cq+uE5m/8wX3MkxIEZVTrR6bfki
         qddeJvmZOaPi47vqEGqJ5Ay5ArlBj1oE58D3XjA6JXNGAawelDHzDhgLAHO0MrZkM01R
         rm7zRceFQYwYlRX/HK9ZLFDJiHrnWSWZfM/NPpBiSLu2WlEs2q+4LgjMmKnVT4D2PbA7
         2rxw==
X-Forwarded-Encrypted: i=1; AHgh+RoorTpZN/hm7m6qV/cuMzpoz7KEbil0+Z3bB0OCsGo+ucg4wpJHxIYCWCJpKWpkP5B2B4+wrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqX5mIZzOmXw80coRuIpgZghOb9fxEQ3BZCIxYlLl6ygBUr7H
	rz201NxXbnJEc89/pRSByqBzPEf9Hmq276c3ZHXe7R0g4IOr4r5CDv3avhHv5s01mw==
X-Gm-Gg: AR+sD12M9Nu+/ETXj0pZ0Ze/kHz5bqyw6J5m6rmZidmtooxjtycb77WG3ZLA31sQxFx
	z1jv2Taw5itPUQOWFIG7nH5Hj4/FG0pKBPwmoCe/yhGmS4w3xnIl1MPHiQ9vR4KGdvaOoPmBr9Q
	ygKWwxsQoROJopiBIby3JaDoq23zQhe2t4ZhNBKwW4sEdwy9iHG2SbdlJxoMZ2TI4riheNInQwP
	gYTy7eaTCvWhvGagh1teSzuDV+7eGxg/6NK2UA4ZKV0pgou/mOUCiIVmaYI/mH+vEGAyyMGde9a
	HYLNaBBbWC0PrTncnzSZTCAgo1YWmyF/9GH4nezcBfFT+CnTEO1FwsKY6RRQf++t3oYhlSMZYVV
	A6au9Dhy1NGKnHeA7LApCOp7YJCD/ABfwBABe2rZHS75A/up8+wIbPp3no7yBzDQRxJ/PRzY7Lx
	/6b8/SAKaIbSPfA5aQXhyP3Dyfy/Xeau/kkzyvrBAi6OhlD1I=
X-Received: by 2002:a05:6102:942:b0:737:ba2e:8a26 with SMTP id ada2fe7eead31-754a2dcd8f7mr1579232137.27.1785255386692;
        Tue, 28 Jul 2026 09:16:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc44d0fsm2424756d6.6.2026.07.28.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:16:25 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:16:24 -0400
Message-ID: <2f53e3c8ee57824f1c741f76021eb2ce@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260728_1147/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v1] audit: free proctitle in context so it can be set by  fork
References: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
In-Reply-To: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>

On Jul 26, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> Original title: fixes clean proctitle in audit context on exec call

Please don't add stuff like that to the description, it's not
particularly helpful by itself.  If you want to link this patch to
something outside of the git log, use the 'Link:' tag.

> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
> 
> Suggested by Roman Dolgikh https://github.com/rmd4ctf 2025-06-11

Considering that Roman lists an email on his public GH profile, it
would be better to use a traditional "Suggested-by:" tag, for example:

Suggested-by: Roman Dolgikh <rmd4work@mail.ru>

> Link: https://github.com/linux-audit/audit-kernel/issues/170.

No trailing period please.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/exec.c             | 2 ++
>  include/linux/audit.h | 9 +++++++++
>  kernel/auditsc.c      | 4 ++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index b92fe7db176c..bd51489dec23 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1744,6 +1744,8 @@ static int exec_binprm(struct linux_binprm *bprm)
>  			fput(exec);
>  	}
>  
> +	/* clear proctitle in audit context to allow replacement */
> +	audit_proctitle_free(audit_context());
>  	audit_bprm(bprm);

Since this is the only place where audit_bprm() is called, is there
any reason why you simply didn't just move the free into __audit_bprm()?

Doing so should shrink this patch considerably and would keep the audit
overhead to just a single !audit_dummy_context() check as it is now.

--
paul-moore.com
