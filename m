Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BB205513
	for <audit@vger.kernel.org>; Fri, 11 Apr 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395263; cv=none; b=DsOME4hOD5tSg0P/rpXORYxY9/ycnKdL6dQgvbLP4EB7JYocnFV3X0fHxo01bJReFVKU7tari+ZahWMzjCEQ4iRlHVbQyqE3IROopMKjwBiUOMmNBpHQdaA9q6t+Zb6xqwHMN4eZw1WREEAqry6OEt12o6FGprrE6/1/lXLg+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395263; c=relaxed/simple;
	bh=+0uNU7Oeos0VO05Dwi4rcMvnJVrCn/uWmtDIXT53pwc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EBgQDJJz/NtYuUZSDfhPtPMN1cXpLzkPJXiYuQUc/a2qgOcnGVAkTxSlv5tXcIWFPRR9LXqprDMvYnflaI5e0P5/79ZJPhg/UAtr/uE6XRbH2Fpau+NBe8n0AqQhPq5l45l0WSMlBZ0U/00LMHIdt3bIlq2szhRZfMmWDoCJLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aPhTPd4M; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aPhTPd4M"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c597760323so222175185a.3
        for <audit@vger.kernel.org>; Fri, 11 Apr 2025 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744395260; x=1745000060; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpax22jUpEC8/o2V84iV6AYGXauCao5nHo6OcPn1kRA=;
        b=aPhTPd4MS61wzwm4pgEDBey+40jAtZyTSs5ISKVkta0oqb2AqYssvQbwN9sB7xXs1z
         APtOMOFEeP/Nyn3y89P8e7ihmAZ4nk9BJiiyvjvsYmmwaw+tMPRAPiZkt/uF5adePF7C
         0VCjZJoCB5M5aNMRj7F46bqVe3wHbuxkufx0Fl2CmeyDauqqsPNomg0UjSgcmQhIpNXf
         jO5qbG06J4v5cVbMcfOdpoPGJm9nj0IWmhfiFIxpk1hg95YcxUSBujM2hSTPRID+E1JM
         9SIHtBJRQuD0YckB/zIfNwhuSEQpnU/DJfNqECn32beAqEqkkHCzJIUUdCo6CZfHjtOy
         Xpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395260; x=1745000060;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpax22jUpEC8/o2V84iV6AYGXauCao5nHo6OcPn1kRA=;
        b=IdtxZEI6Ad5/XX+K02RRHanzMiE6fC34sfOx0cxOGWhpPTXiD3Cb/vXTybhKpIWY3d
         9VqvhQzIGPgYJcY+t4yfo3EEPpg1AcWFuJM0c+sIbAWk/BnJ18bFxFtph97uWYv+TntM
         gOXbQ5Qd0rC8QHhAFrXtFsvfZTYf9JOi34gG+MehSh9YvXRMQNyPD5cA0boi11P73uiA
         HUob0UeMb6RZbWjxQ9AbQlLR5qATRrt30T10IS6Ft0RjyOXQn2ApRaOxNKTn1eRbPs4n
         ub4JOnHJxk1H2DHrdBYsEMaMxAZcUI38wBFhDdOU8k1dM7dEcvgZ/6NzOpeyDYTARwV1
         mVjg==
X-Forwarded-Encrypted: i=1; AJvYcCXiPUkF/JHCjiPA3q7T81oYYlY5YkRL0T6hwfgpV0ZEAR4OkEIkXxZH3xH3SNa5aM8/w+BbWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p57kz/gMJ1p8XqJ+0MMDjwJ2tIx1anozBGl144h9j3h2Qz8O
	iNi2YPTdhVDaep8pu1OLmhhUtfz3FY+MvxJio29uh4V+UiZ6FnCG4s4+rUvpXA==
X-Gm-Gg: ASbGncvWXpvvMzeVPUACDQ+2Q5vAgWvjIsUZrjtBHoZyuMzMqKP+xEXHAUwj2kA2658
	SJr76qu9WnRvH515Kl9LmYaJhtLkhpC3rZ7DMTTBf1BViWIKAdj8cauKm5vhAsfE8wQR9pdq/ML
	o46/Q1dbt9xy7Xk/hM6uZOXCf4g1lgKXF7hi9Eavm30TdJLeIQC/yUyyRiOiQuZAg5nuX1PV428
	JH8+2xsX+3mqVIru8nwBeD/vt1KSpvbb5Dn8qmwUEndmSCLJ7oq1Q/DMXOQPX8EtbS6+t6doAvM
	VXU5+Zf46I4qem9xB9+OU8W4dqeKK55BdSaDBKLk9fe8FouuglozRxDyjpyJRWsBXsXMNa23BpU
	XSKt9cdrugQ==
X-Google-Smtp-Source: AGHT+IE83Ajq4beiDm1bFY4FGCw5MiahPXF6d4P6EXZKH9SzDGizkbA3x/o6nOpdUtJ2dcUATqen3Q==
X-Received: by 2002:a05:620a:3182:b0:7c5:5f08:3c5c with SMTP id af79cd13be357-7c7af116707mr505028685a.3.1744395260493;
        Fri, 11 Apr 2025 11:14:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a1c772sm294412585a.115.2025.04.11.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:14:20 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:14:19 -0400
Message-ID: <fb8db86ae7208a08277ddc0fb949419b@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250410_1510/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of presence  of rules
References: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
In-Reply-To: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>

On Mar  5, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-1367
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/audit.h | 8 +-------
>  kernel/auditsc.c      | 2 +-
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..d0c6f23503a1 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_openat2_how(struct open_how *how);
>  extern void __audit_log_kern_module(char *name);
> -extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> +extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> @@ -525,12 +525,6 @@ static inline void audit_log_kern_module(char *name)
>  		__audit_log_kern_module(name);
>  }
>  
> -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> -{
> -	if (!audit_dummy_context())
> -		__audit_fanotify(response, friar);
> -}

It seems like we should at least have an audit_enabled() check, yes?
We've had people complain about audit events being generated when audit
is disabled, any while we don't currently have such a check in place
here, I believe the dummy context check is doing that for us.

  static inline void audit_fanotify(...)
  {
    if (!audit_enabled)
      return;
    __audit_fanotify(...);
  }

>  static inline void audit_tk_injoffset(struct timespec64 offset)
>  {
>  	/* ignore no-op events */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 0627e74585ce..936825114bae 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2880,7 +2880,7 @@ void __audit_log_kern_module(char *name)
>  	context->type = AUDIT_KERN_MODULE;
>  }
>  
> -void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> +void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
>  {
>  	/* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
>  	switch (friar->hdr.type) {
> -- 
> 2.43.5

--
paul-moore.com
