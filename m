Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F183019B9
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483577; cv=none; b=FMB7SXmhw55yapiJZCwsXrwR+OzGiP95QFO8UqgnVpwVUjexL7dhNTNHirqnBVximxv2/C1XDei7sfJ15A/RPKyf60wMYzXNXmGwq48YQtmNm/eSsP4OCiasFakLs6hbln95dlzykkw4E4styRaJvd6+uTzhKigiRntJGQE1fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483577; c=relaxed/simple;
	bh=yBSQDIAerL1pP8jBEJSFDm/XqydoQBHKsJlKkV81ReI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=L4d6W+iZtkJoqYgY4kImvJm/8UXaRODmaOXrRI9f7mLahFGj8k8VQATSDmi65Rw/p+J0u6xS/2qdn0cOAfFDufOfIn9/Xv4yUgtoEQkqb9EgDFpVpmXrpHDrhoebPoCqr8kIs0GiFPVGuuoD2PT/w7fMqSCIhMHw/yG+qpUaoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N1jMtUhr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N1jMtUhr"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8582a34639aso453165885a.3
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483575; x=1761088375; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=N1jMtUhrEsoqSqmuUt4dNAp2G91diUd+lxSNjM5PHpqvyt+msQmcGnTt8sMI+PzIB5
         zzCchOTWn2kMn2zqx6sDRH0X9lZEGpQ5gcZta/w8esbx27at03sPyIxE1Dv3vK1URwqf
         3mf9g2dDt3uMI3u3nAQs3WOaKlQgwUVDyR3ZQrzLeSEX9g/ngZI+7sIBub3GNgrYSVDn
         nlHPI0/575JpkkQt7M7qb4IQr+lW/ULVNlN2xjN7wdZ/2WXU48A+FE4NT+qviSkLxz4t
         ubNO21xBE4pteCCm3wm/5/ufpCajLYNUwkKl9lbzFY27+Q15CGDzJvSLvBGO24TuCgSF
         hmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483575; x=1761088375;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=key9vxkbTjERKAMy+RVUUn/1ldTQI/cKFyv/sCFEvXQfN2sgtIG/Dmub9chJNlMM/O
         wyhhjYxkCKZibJKilJ2e112eJhDsvyk3RnjtMPGaOMlo9L59B7Lnfu2mLrWToWxnoVKG
         Ik4GFHma8CLCVod4toOdnZ7vCh0xdGAyLCu+YkWKJAHxauyIK/jLazLeXXdvuHo6EFtM
         as3sCniL/RK0vkg4cmnyCk4S9iQ0qCc9hqEV2GjebUeicjJyR37u8dDqgqameFi5+GTh
         +1YRzAoVXrQV7PB/0isnCbmLakomqOIK0hznXFaFul8aQEITuXkMZBscmuiBH2DqRi5t
         zMng==
X-Forwarded-Encrypted: i=1; AJvYcCUQbmoPSys4aLPAOE8z8ZMWvkY6vdaVZ3m+Ax6R4bg5ZT6D4CSwc7U6ZXFdfGxzRPdf5H4LBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLQlpzYh+wIbjUN99kgsVY62Fvm9aAowR9kxzc2/c+hBMzsO6
	wd0FJz1fkSUMxiCT26pnQi30/ysKTmjWxcBS47nq1zjADTMaHqV6wZKlvK5Yn8o8URCZC0TrUPf
	KctAFjQ==
X-Gm-Gg: ASbGncsrmGDBSlv3ipPD/TmLqNDnlgNzBPZJBR8vOu4TBeGCwnRhSlMDctKAdRRsjO8
	0i6MVuqJNbxP8thprwBFxsxYpf2py2cFkSHFuWk3AxKASV2uAynAw0TeKdjFlZNMFjo4Mx8vFkf
	L6liiZeQFIANiCyN70n64awAXvxaV12oR48c8pbk9QhH6E/at+etRyF7m5Vws1bfBHdxSgk+Pp6
	dCn+RrJTpSZ9CckOlJVFD4Oow7Dlr06ch1oDiL3q63KUVMYSJrsQHWiuyEdlwxHX0qDUlCfv7mv
	C+jspAqvLP4cTCI6exuhOh1IwkQP5Q0ZUo3TRtY/5J8OgnWu1z4saj/7V0FjQWK5u2DezktEsMM
	2BPJHoUWwmKcfZ2MmDP8iZZv1qrRnGgeYDkqUT4CfoQemyFk4BMKY2D690TFFP8usaIvGRywER1
	vmcMnyTxf5dgPsTOmUXhaXdQ==
X-Google-Smtp-Source: AGHT+IHQuFhiVAIzWYGxERI883rLNluCPfSroNYywP2IoanX/gCv8E91aVZJ/MsGoz8MOXeF3+6hyA==
X-Received: by 2002:a05:622a:1989:b0:4ca:9c53:f1e8 with SMTP id d75a77b69052e-4e6ead793c4mr365706661cf.73.1760483574819;
        Tue, 14 Oct 2025 16:12:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881d2c71csm7370921cf.43.2025.10.14.16.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:53 -0400
Message-ID: <b73ddac399f78e46ba753f6bea4fcbb5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 9/15] LSM: Add mount opts blob size tracking
References: <20250621171851.5869-10-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-10-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add mount option data to the blob size accounting in anticipation
> of using a shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 1 +
>  security/lsm_init.c        | 2 ++
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  4 files changed, 5 insertions(+)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
