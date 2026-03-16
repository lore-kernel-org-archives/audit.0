Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264B366058
	for <audit@vger.kernel.org>; Mon, 16 Mar 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699284; cv=none; b=egSdBBLeUL4euopAnLGqA6QQsePUb6rK3THrtn0zU8tYJTlkrZHVHqK1AdYFdsOPMpgi53ZJCGyhuTb2/x0uv2lXeXXSX38VxxeebbzLqft1OwZd6YwpemT7H0gUF/XbtD+2y7ooHlZwX+lruVjw4MuZVvPRBU8XihqpqS3RK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699284; c=relaxed/simple;
	bh=HGj5yiUG7iKWATjOzUz8OSk7F9PspHcBFX+MhNveJts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaUOodzq5YLBCy12vxsrcBva0/WSlyOeTBMSdbRVf9XKFT7ZpAaQnOuoWZPu3CrNP9uXgrIAME+BStZjwKMLRELYCZQHkiu+P4YIUhZMQ4yXyQYkZhhW8vYGwcLV6BWErTo/75MzZOZ8ZDhJ7hZDvLswImW6kBrFR1xtyZHO+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTH+pELL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTH+pELL"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c40b33bddso1720536d6.1
        for <audit@vger.kernel.org>; Mon, 16 Mar 2026 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699282; x=1774304082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=gTH+pELLcKYJsiNcJvWi2+XVvonHdHeESyISqkJ/8XBdU31sJZU54Dafsf+tOfcO7S
         LZzyi6Q27OscB9DBKM9PSCFNq3bIKRKI8AzHzvgxAHOFdvk69VUkYpszBl0bMrG4o+qm
         CwmF7fOYP9iFPaXJtuSJY6C3P99CZv0dmNHpssHaizJu4v8p7xTVxvu8E+VKDP9XyYbh
         bsCGmdfxFVAydBEnEm8d5FNfbjZhIDOlfDb/GdiFjs729HlD/PyygvwmB898d4lbFH77
         chh4j6zq4JEDejcZCjtpD+Tj/P4lZ76LcXgXMzYv+feMt9RPGjhgVGCYOHqugQ2mI7VP
         EKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699282; x=1774304082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=IpYzyOjivQIcu1otLvzop6BnXuN9hyPBBuYkknAMn1ZtplCNwIeuGHlltY/uWVneqI
         d05NbkvAvGtyYocGjAuEfAie7MaFfTWDRFSDhgaOprp4vYrZ16vmbg+HtI4wY96WZ4mn
         mqr0rRu+2TkfMGetVPxzAi7ksKkKuYlZrls0FlWhQPk0a0mJLHrpkjSn86lXx2BXU+QZ
         KieOtGtOVMJN83zSYU9wgUGrgH9OeSvD+uuJUGJv+Qc1o+aiI4Di0J6pziLK8fgdriYQ
         4ft65vnxPtjjeOTR8N9gKMI7DxxMEWKM0ukLCBO19Wk6I22bLlwNAJYYm3+P5zN7v9Ex
         RPGg==
X-Forwarded-Encrypted: i=1; AJvYcCXxZFmp6N5X0oBRdy9FhD3O72yEnZf1BWw+wupkqZ38Z175gtTNBJ2oUDMbpNvaGXR40/GmwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTn6KQI4wZCEEFXZuOZrc+OWdWbyfqQw5esyTzLLztPY47OV9v
	SGN766Q/2wmhKP4I4NW+UxqQMEtzBn5+v7IdhC32gI3jMyafjvEsvyH6
X-Gm-Gg: ATEYQzxeUgui1HyG+uij7IKwtKFmSRMxSm0QrWJ6qgMgXbPW4wxx4Cf4cxX2Ou5f8XA
	QHkdvOGcKymC+SwIAzIwEZfy7onPO7h7HqIWeWqORtgm+LWsZCXdH0y1S7zORMDgxRivkzgSpUs
	69idY5gKJ23eplM+Y/voAkFojTri0ZufNGQuJRiB19LrK5dFsv3hIgowX+SWDpwdHDXeuJ23+Vm
	1MwSTE/ekSsVwqe64czEzlGvhmUEbb5SQQzx98g307ra0C//d7PK0Z+KyWPPzSM6byJsw2x0Sce
	dAHcs+wikLe8gdgIggYJv/EJYsr4fqQPC1tqt5ZtWl2qesMJAhBvqv2CJUx3xPcQOAK4I7j7hsV
	tUJXf78k7KjZu12ryYRTh3iClUtcEH/1b8ur9VkhpjuYueOfTQa4j20aNs+IQx9ApV5pvdYxSY7
	LxEbcPKnrsOiteo11sRVdvSxMe8rdb64LLO3SvhPWW0P7xe/7HHWM1GL72gauZhVRCczyK2QywB
	3kPe/LW3JRJolANMoZdaQbx5t9V9pujiTdDA/ibMg==
X-Received: by 2002:a05:6214:252a:b0:89a:424:984b with SMTP id 6a1803df08f44-89c5e3c81ffmr17623666d6.31.1773699282359;
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm145596556d6.19.2026.03.16.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: fred@cloudflare.com
Cc: paul@paul-moore.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kpsingh@kernel.org
Subject: Re: [PATCH RFC 1/4] audit: Implement bpf_audit_log_*() wrappers
Date: Mon, 16 Mar 2026 18:14:40 -0400
Message-ID: <20260316221440.2043299-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frederick,

On Wed, Mar 11, 2026 at 04:31:17PM -0500, Frederick Lawler wrote:
> +__bpf_kfunc int bpf_audit_log_cause(struct bpf_audit_context *ac,
> +				    const char *cause__str)
> +{
> +	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_CAUSE)))
> +		return -EINVAL;
> +
> +	audit_log_format(ac->ab, " cause=");
> +	audit_log_untrustedstring(ac->ab, cause__str);
> +	return 0;
> +}

Rather than putting everything in the cause field, could we perhaps
have a separate kfunc here that appends normal stringpairs (not
format strings) to the audit record:

  bpf_audit_log_str(ac, "result", "denied");
  bpf_audit_log_str(ac, "op", "read");
  bpf_audit_log_str(ac, "scontext", ctx_str);

I know you didn't want to wrap audit_log_format(), which makes sense,
this would be a midway point between that and stuffing everything in
one field.

> +__bpf_kfunc int bpf_audit_log_net_sock(struct bpf_audit_context *ac, int netif,
> +				       const struct socket *sock)
> +{
> +	struct lsm_network_audit net = { .sk = sock->sk, .netif = netif };
> +	struct common_audit_data ad;
> +
> +	ad.type = LSM_AUDIT_DATA_NET;
> +	ad.u.net = &net;
> +	return __audit_log_lsm_data(ac, &ad);
> +}

Should we also wrap ipv4_skb_to_auditdata() /
ipv6_skb_to_auditdata()? Smack uses it in smack_socket_sock_rcv_skb.

Thanks,
David
