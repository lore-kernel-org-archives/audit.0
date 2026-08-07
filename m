Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF04734CF
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105540; cv=none; b=ACq7scniTF24RdOH+9xexM2RUFqj3vdnHbXk3XKVIWjPrBcPxR8ArXKuSTM8U1eoFPsKWaFbnH7N4qYFEZ0nocGgdG2J8PywA/tGMaawtEkPM+cztzvGy1khcGWEpiu5UDqqL6OOluzwm7pQEj+xz5xpTvutjBXWS/W+Ia3r1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105540; c=relaxed/simple;
	bh=fBVOn8mK3knmw46L9mpY8gHcIvb6lpKYd3tG5GSLjvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kf3/vpuT3jQB0O7elwpG70aqRR7vJBUZqgzeVAMxpipqVm/rGY0ebF/M7ijecfB5rTdHqUgiTHk/vAyK+M86h+zjmOy9+5xwPz36WOGlKYmWnvSDhj8GxZmMHV83fju5hrod+vJ2ttUhQdpWLyFd3TLQicgRpzA/VTevdVgJ8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyphB2bc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyphB2bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786105523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
	b=gyphB2bcLPPNJ6VcV0sCwdWfLHPA8m1mR/w5hvTMarLLnFEDRFanBJLHNhHVjQfBIdpAae
	aQ5oWhouI8zrVLs3xGJVxy+mgxUEEvUm5VaWY2wJmAggx7J9D3A/rDF8HhXc+RaM/Rh+/B
	EyNAUVxb4W7OMR+pKlLVbC82cPYZHqQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FkcaaK1cN-u2NPcK6J67HQ-1; Fri, 07 Aug 2026 08:25:21 -0400
X-MC-Unique: FkcaaK1cN-u2NPcK6J67HQ-1
X-Mimecast-MFC-AGG-ID: FkcaaK1cN-u2NPcK6J67HQ_1786105520
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1686e23b9cso269600866b.0
        for <audit@vger.kernel.org>; Fri, 07 Aug 2026 05:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105520; x=1786710320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
        b=m5HhAmN0HhMXKOPjXzNH2iCY9B8JkVPxeAil8dksMYzG3wwJZ1YBiI+ibAKdPePabo
         IdrOA+8RaiL3BMq6xHKyY4WSdKOcpxtCc8q20t9VwgMWex0sSycybTanfNb4A/EjlYej
         UONj++0DEZxL9xDMpqRlRmzkVYJ8sWN3ELLVVlDhF/UUKjrsRFjLp/KI1HtHcGx6xJ7f
         sZOYxrbQm2rn+5sdwjkwWzxUavyWU+0D5QL+FvhvF3G+b4ahxwj2cw26tzZ0nmFEE4io
         LxjBLFZIXdHw7qv39X5JGj0SKbiymDYrg82T68Ze85aBbosD9MLv7VV4776O2pl7zmQ/
         1WGA==
X-Forwarded-Encrypted: i=1; AHgh+RpjP2lDhfLlt78xr4ePzZjvcPWssQzq+2aA08/LYFQ+gWrmkxVk+oNDpILNnoE27VDJm8EOog==@vger.kernel.org
X-Gm-Message-State: AOJu0YysaA4VmwptXFWTw59o1tV8adc3ThJ6f6NNroQRvYW+uImSsBrq
	BtWP8axYfgy5qp27X1wvttwujU6lHepNzJBStEPGFWiebr+NfrU60UEu8bPmJQgyC0MSwqrl0Zf
	3mHOrX6ybVhPwoWPq2cD/zauYLoCfou+1HprRzQwuCwHhAdNHxTCSSfE2taWUd9AVUrx9N6ePr7
	RrtZ54L8Xj2fxP7YSJOptnxvRqNcJESioGvuuRa3xlAw==
X-Gm-Gg: AR+sD11C1iDrU5JA1G0VCFzkYNNZ1lQG360E1EaDhVbLUOnmiZjJzyzSX6SnPO1tNUw
	BbFFbRqxptAU6JBAssTpahxnCYX9jtA1QH2iMJh5hLPRxp9VuZ7tmr7SyElzrl5k5YBbkqwf4nf
	srtXZrJ0zi1yvhdpmzzQg4GgIzM+8ykckLXIaFHP58B+Z6xGEaaY3AwCmmXJ8jRwfMICD4y1IM0
	nlv2RRPmVPMW8hP2KVZa794sY4qQlyBw3cC86RcWz10yQ==
X-Received: by 2002:a17:907:7ba5:b0:c12:67d2:3d6b with SMTP id a640c23a62f3a-c2039d2648bmr526428366b.11.1786105520507;
        Fri, 07 Aug 2026 05:25:20 -0700 (PDT)
X-Received: by 2002:a17:907:7ba5:b0:c12:67d2:3d6b with SMTP id
 a640c23a62f3a-c2039d2648bmr526424066b.11.1786105519943; Fri, 07 Aug 2026
 05:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
In-Reply-To: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 7 Aug 2026 09:25:08 -0300
X-Gm-Features: AUfX_myz0xLBSU21NiiwHaNKz0JlrAWhqLCIPB9tOEADbE79qPnJz3NgKL-BtIY
Message-ID: <CAABTaaAR4O188N6wazEuqMMUmMyWFxr2oX0WhyS7Hw_CauuC0Q@mail.gmail.com>
Subject: Re: [PATCH v2] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, 
	Roman Dolgikh <rmd4work@mail.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ekD-uIiV1GFZ911Ow1fufNHq409g1uAZxiE6x9FpXQ_1786105520
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:17=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com> =
wrote:
>
> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
>
> Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> Link: https://github.com/user-attachments/files/20751461/fix_audit_procti=
tle.txt
> Link: https://github.com/linux-audit/audit-kernel/issues/170
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v2: simplified to call single use directly before need in audit_bimprm
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..c12b5dfcb279 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
>  {
>         struct audit_context *context =3D audit_context();
>
> +       /* clear proctitle in audit context to allow replacement */
> +       audit_proctitle_free(audit_context());

Since we already got the context right above, it would probably be
better to use the context var instead to avoid calling audit_context()
again.

Otherwise looks good to me.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

>         context->type =3D AUDIT_EXECVE;
>         context->execve.argc =3D bprm->argc;
>  }
> --
> 2.43.5
>
>

-Ricardo

