Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E61F3B98
	for <audit@vger.kernel.org>; Wed, 12 Mar 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823501; cv=none; b=MZE5PWxO+XfBEKJaQnB6WN1iWUydgjRFvGAgh7f+s3/FERFJfhpF6yrY2JBTwVmO8Fk5Jw61FPMwoVAWPByCvgHOzfJpHMQCZDkf12t+zkWBy+s5UDAlxQLshxux10btgZLnZHbOAvGMHRSTmUwRiUa7/ghqq8JKVomb5g4OUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823501; c=relaxed/simple;
	bh=VSZeQ/my8BFqmlDPi2QBVw79lfsnEAPO9LqbIejJYXQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ByRAGwHKpLUWynRTVJaGd3QNCuXNrNKRiw8cbAhaNqO3t6R6D9PANlLWwKYKWVkWAfSI8vvxsxnrWB1n8WlMIhVLl5UyI0gcN9o81hPEUSgX75cNyp8WGYmn81HBvjilF124tCuuY+HIffWh1Y0DZ9x85mMlqnlp9lH2YXNWHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TQrCwuVA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TQrCwuVA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47691d82bfbso6930571cf.0
        for <audit@vger.kernel.org>; Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823498; x=1742428298; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRaBKu8m0fRQQzayD1HUneCZ9kYje/3LUrxSORvh3Kg=;
        b=TQrCwuVACi3327wPdgzR0SDML+pF/XcI9PC9SyMInupIDKsIlkfqzFp9gZdMVvXnlU
         B/3sSKt0ltF2K5L9GWGOi9o96pb3X/YjQPyXOjHeN7F/dkq1HDSteNKqDF5dWiIWf8O7
         x5Hbah1bypjIGEXck/OGnM1oY0qeKv8LHN+BeUXbm2HteRjEe2eJDjPRIh6JYfrCXfW3
         1MpTv0UfOikmMgAaI0eSXMVVBZdSPVTZu9s4Igdme1XjuVDauTMahqMDc6ibH4h4G61k
         ChRhgZr1xPuI2VqPUxGqBI9TZLnG01urllqmsFsL3XTG6SGJ4StbqaYglMfgRpHRkmKR
         iFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823498; x=1742428298;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRaBKu8m0fRQQzayD1HUneCZ9kYje/3LUrxSORvh3Kg=;
        b=JAEEgZoP2iW0UkJDLxicgxTUoI/pRODb9oHFR4rAbx2paKwxBFaE3CPPKqplOurLKh
         XA3VuMELcEEfmgxeRqYoYI+FAu0DK18V3CEEblxdmG8AUDJq76oPNCN84nGNM/GcbsnT
         rqUXv928vK7GazujdcQDzHgQTNcv6zXoVDL2NRAJA4rVW0k29IbkhdANPp4mmOakEKE+
         Xx4CQ2euExYmLAhFc3iwuUSdbBrdiM3RgBYXt/2ZSARSueWUZwr4kHLNkXPghTpsprYp
         U191gXmTUQ6kEpLpdHEHiquOfU3E/Fy7dCb0+YFgYzWRLzV97hbTPn+BZfrBwj69PzMi
         Npvg==
X-Forwarded-Encrypted: i=1; AJvYcCXWL5sKIFEjwV+0jmtdb+OUYxme/uHe7lVdCOkqhYslcbN5jDbAB0kuBK/IForT9vVdQYgciA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRTzEq/vTzpJFDwlnx3SunAWvxHjPe/OaOhSlemxNpDJtMFW0
	kJ14LeiWSfhM/Y6NAK+4Kc78c5Jj9eAmIV1A3Q5UviYjZIcUy9TbtLLPFcpQgA==
X-Gm-Gg: ASbGncvmieCykMryicVjjt4c/cc4Mssne0da1XxJdDR8tf5DP8llc3rBfIKulpELvP5
	FpSjuFpcNwds0j0LzL0sabpXLMx15dZG2m9qSQriI/PwR+79r01bRH+9YpBI8AZK56vy84OlvRh
	twjo5VGoNe6O1cAKO+51LIS9eOPi0LucrMoAAN5xNDJ7ODpwcMO7CfvefIkoXbU/A/c3o59HS3g
	DKcSmXrnLyVv5q0JAgTRk8YbIQZIp9JodBkvl+uUHJUDanGWtZGy3F/gQB/eCHM7LpJhfnE0EqJ
	3erQqpVsibp5rnlBdvZn+3bPWSqO0cS4yJ+/0AFSqrKMKCVKoAyCHBCmVGhzA9vb7p3Jgi4bg4y
	NHQqXzwttvwlVyQ==
X-Google-Smtp-Source: AGHT+IGWu+3ka+Y4IH7wMg46s96MmAivhTh9BUXmfCkIPlUhY7zH5Ov4Q5CiLvjyN5NPXeFeiE15Gg==
X-Received: by 2002:ac8:7fc6:0:b0:476:7d74:dcfc with SMTP id d75a77b69052e-4767d74dff3mr226896341cf.4.1741823498434;
        Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb82bca3sm1412251cf.70.2025.03.12.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:37 -0400
Message-ID: <4d544b6fa041fec084c3d70a9f101418@paul-moore.com>
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
Subject: Re: [PATCH v2 5/6] Audit: multiple subject lsm values for netlabel
References: <20250307183701.16970-6-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-6-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Refactor audit_log_task_context(), creating a new
> audit_log_subject_context(). This is used in netlabel auditing
> to provide multiple subject security contexts as necessary.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  8 ++++++++
>  kernel/audit.c               | 21 ++++++++++++++-------
>  net/netlabel/netlabel_user.c |  9 +--------
>  3 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..ee3e2ce70c45 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -37,6 +37,7 @@ struct audit_watch;
>  struct audit_tree;
>  struct sk_buff;
>  struct kern_ipc_perm;
> +struct lsm_prop;
>  
>  struct audit_krule {
>  	u32			pflags;
> @@ -185,6 +186,8 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern int audit_log_subject_context(struct audit_buffer *ab,
> +				     struct lsm_prop *blob);

Let's try to keep the typing down, how about "audit_log_subj_ctx()"?

--
paul-moore.com
