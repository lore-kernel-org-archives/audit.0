Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49A3101DB
	for <audit@vger.kernel.org>; Wed, 18 Mar 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855265; cv=none; b=CSKu5/TnJKmo+iHpZdj7ASJyp3JnPBYBp5mOibMMHdAFk9X0XFW9lcbcmVAa3cXPEblPw/d9E4wqg51MuaneSgsQsVjdScr7Eldy5iK344h0MCuuE3xJ3+RZf2BLqFfhSkBDNKJjm51/lebCicmjUyjq4RnCi6YH4PyJV9DKvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855265; c=relaxed/simple;
	bh=FZxvRu+85EWsxqRmuAs5TjqTbVp8lAzOjEKZsLeBTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP9CwbKEmZBsGELCA6DK0R9yL9yLPb5pbuc6b0c310ehIZZmmAJnjDs0KCrwDdayDeEczJwP60lFLHFLdUQCvDPAzWWahqWqIzhvoLapeoQmu0Me+Dq0a/cWyL2hePxMkF5HIYs88HG17mLLMS0L9BrhgrpvHsSN3RfkR7DS4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZIQ8Y8q2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZIQ8Y8q2"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d73ccee442so107585a34.1
        for <audit@vger.kernel.org>; Wed, 18 Mar 2026 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773855261; x=1774460061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeEa0ZafBH05FmgYmVQzG8J+24xX/BkM77vv1zD8SU=;
        b=ZIQ8Y8q2up0WQADu+jzFDuMldHGgfqAA3c3j4H3T5Lcxfe4ftsyHELNmFik8FV8e8z
         w1PLCvdfsEBJkEn9+5kO8ZW+eXOSQZD5rk6PLm+FEZYiu/nCEUpj2T/jmT60Dg/g1CIs
         CrYOXi04XdvU2IBMEMVyxYjZNz1IMc6tE+G7rfzA6axZlhdnQWS6kgAp1mWQOmY+56i3
         80Fmpv18cqRt8rAfjsHpSReittFy2zgwKQl8goe6sbUWMxzRopoUWXbESr+9XoJlvnJG
         vgjo5oNJbpCubomqywdW8+KH14/Vri90Kw7Qu1EqhcZzuIKvEjXPcjOKGJ95WXD2AJvn
         bXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855261; x=1774460061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWeEa0ZafBH05FmgYmVQzG8J+24xX/BkM77vv1zD8SU=;
        b=Vy8LWQfByp0Vbuxjv8Ekg1Qv+ecxUyLgQ0YOeT1o1Kr4+6BSPVnjQiv+s7ZtH8JjHe
         o6rvJKE5ajbC6pb5TFfzBXxvhqNKDdjg2+hes9nksCoUhhhVL/lNzj5c93RU9mK71PGz
         of9B3Nch1yAUP9j+u6ZEqyYIxFXh8T0wRuIRK/bcqnnd6nTD/0jm5iSuAenG2aWhvsQ0
         GK8MbiU6TXAM2Ygwgb4LjrchGCl4NyEeKbsMM/idv5/+Fw3pqcX2imzH3FhQBSslnM8E
         dqYmNcc8yFYzxhgrJu3goRUwdvuFMR3LmNIcsntUwsby591B5a+99GIOtxsrJn2t021d
         d+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaj2EoJmyN/9uA7pak8rGr6OSABUZcPoivJOOypQ0usrKprt542YZ/WkSmZHR80viMeX54rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzugGXS8YwE9JZORhWaOrVW6TcZU2qD1abUcpRMixYVp1El8VPO
	MBlQbFTDhWV+33T4X3IOMc7V4QlkuwWKLY9Q/d9XT/RJm4PvK0T+2l1aQCZ+5ufBzs4=
X-Gm-Gg: ATEYQzwBZYVkyWqvv7Mu4R1lYkUKgcsh8d/nGGgnIoRbHAqXw9LDHv0ccBvu2nN6J/D
	FnsESEf3ajQmBeh1fMvbvtLQBjMQv4TivHuGvvghlUlrsa9o0IciojC151aqoZAw92wlCaVxy4S
	mdxLu4hWxM5IAn07dxcPXDH+R1trwEGvVMpAX0kwQhmB1D6UkDbJiO95EoWAoZ0ZQQDK3B9L1KA
	PVbZ67EK9ywD2wxZCun33EwRCwp3Npq6uDhbopZrd5dHW4qXc7hUfeDSUlWORaWBz2I9bXIEPPk
	rmcGyyWSEkZyLT9MZS3pCdc6u93HGBr/kuIQQEk1E3kQdW5e2mGKxRHL236MRez/fxbTL6SuxK+
	GSOH3WObTQxl7Xe9giDeTnIYX7Hb/Fqt9Hyv4rqvkwon9zq5wk3qjtPVDU/k6R9E+4WdEUDLYGT
	eiOGg6
X-Received: by 2002:a05:6830:64c8:b0:7d7:4d85:eb05 with SMTP id 46e09a7af769-7d7ca775284mr2522284a34.22.1773855260727;
        Wed, 18 Mar 2026 10:34:20 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9950ef9sm2751073a34.2.2026.03.18.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:34:20 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:34:17 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF
 LSM programs via BPF kfuncs
Message-ID: <abriGVbtYY1zhupD@CMGLRV3>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>

Hi Kumar,

On Tue, Mar 17, 2026 at 03:43:36AM +0100, Kumar Kartikeya Dwivedi wrote:
> On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
> > 3. All bpf_audit_log_*() functions are destructive
> >
> > The audit subsystem allows for AUDIT_FAIL_PANIC to be set when the
> > subsystem can detect that missing events. Further, some call paths may
> > invoke a BUG_ON(). Therefore all the functions are marked destructive.
> 
> I think the first part makes sense (i.e., the policy simply configured
> the system to panic on failure).
> However, in the second case, if the program is somehow able to trigger
> BUG_ON() relied upon for internal invariants, it would be considered
> broken.
> I tried grepping through and didn't find anything that would cause
> this, hence the whole thing about BUG_ON() in the cover letter only
> adds to confusion.
> Please drop it or describe cases which you were concerned about.
> 

bpf_audit_log_cause()
 -> audit_log_untrustedstring()
   -> audit_log_n_untrustedstring()
     -> audit_log_n_hex()

Was the primary call chain I was referring to, and yes this relies on
internal invariant of the SKB existing. I can remove from cover.

> >
> > 4. Functions are callable once per bpf_audit_context
> >
> > The rationale for this was to prevent abuse. Logs with repeated fields
> > are not helpful, and may not be handled by user space audit coherently.
> >
> 
> This rationale feels weak. What abuse are we talking about?
> The LSM program is already written by a trusted entity.
> 

I learned through off-list discussions that there's "undocumented" or
"unspoken" rules of log formatting and how auditd expects logs. Without
knowing exactly what these rules are, I can't provide any stronger
arguments other than to reduce duplication of fields in messages, or
exclude wrappers that supply unverified data.

WRT to unverified data, the socket wrappers accepting a netinf int.
In that case, the variable is at least verified via lookup to
report the interface in which it belongs. I left out wrapping
LSM_AUDIT_DATA_ANONINODE due to the passing of arbitrary string,
LSM_AUDIT_DATA_IPC arbitrary int. Others like for infiniband,
lockdown, nlmsgtype, were left out due to specificity, and not general
purpose usage.

Some of the rationale behind this is _not_ trusting BPF LSM authors as
much due to BPF LSM flexibility and accommodating user space audit.

Best,
Fred
