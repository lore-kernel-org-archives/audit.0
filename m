Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B12727E7
	for <audit@vger.kernel.org>; Sat, 30 Aug 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563320; cv=none; b=oKA8pIuUvGhUlFktCowDm5bWtrTsj3F7FFhzQfSe6LIrCfKwTdakKHiNAa2lDwu5Ulq1Wmkc39qvMPAI5DRCPBnyWbBwgUQ/iTuwZpAzQ26vzZihBi/vTtx/euszZJG8XTrG9hRnhDgfZ+zycK1oJnGCJuLyfrYT3sP9s4043Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563320; c=relaxed/simple;
	bh=JUvCDmRXFunAkEsF1GRXbXtYikzq0w1vDWUP6HCoymU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MoNXWJ0FCVCtDIRkiarvY+mx12ZmBBwUg8h122Ir01fRqoFnBGbOuEV+QHM61G1QFeqIa29Ssa+OR2TSTs+Nw9vrLdFznT13PN0iajMMHkoG+1lQ4Jhnnsn/G0UZSLNowmeE5W+BIpxpEFQ+Wmzuo2PpVVtrOkdPl/86Nt+Ue9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PAcJ58PU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PAcJ58PU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b476c67c5easo2057202a12.0
        for <audit@vger.kernel.org>; Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563316; x=1757168116; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=PAcJ58PUHfp4hMcxmDTRQ7mRryINHbS+m+lSZ7TAjVR3iI99kawAFbYvh9WVYxrpZy
         getGeM4yZeVviSxsCRg1BL0FC2KgdgiGS6GK+3kilIhXLCwmi0prmwRKWJrCDKLXncCV
         1WgHT2JADs/f8s2meak1aqvHkLdnW3+8gwlGrcuNT2ZXwo2AI9sWZfyH4Dlxp3LJhgbm
         aaotxR3RztfRL1ELuPgSUdr7EHIpdewzIu+11FRlShCkvz9Vtue4KdL3vBm+zHyvxKum
         SGcelhgtLcSUAgUgRiZPDVvKO6sla5ijwCfYLtYHqvseiL8NvfK0lmKCJOYWykMDswix
         Ci9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563316; x=1757168116;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=XAV1NTRATcOK/ocqHefyL8WAazoK4KZ2jIHD24pU2IiUhP9tpejpc4vRm7szAFNO+O
         fcEebXd66FqdlSBrqVaPYeTiLrS0zkacJGAF440hiWA3A1nl3sogEFGb7eCzwJ3fwknN
         fbAAyQ3A5+ltTE14Naz2FJmgjm47R5kULY531NeaOX6HM2/sU4AC7wNPe9yU33ATrfUk
         zE6eem+UrlS3nfYNU+PsoJVVuX/dQ+EYGmYr4ckWF3TUc+PXv16fzfRD7RM0Nv+b06JW
         1hLBaQJHC75J6AoU2Suwpr81EYuPTlzpllzAs4x2YSOu0SGwM2YQQ0YfnW+rel1gI+P8
         A0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ygibynBFLAVwLOUzjKSpnq3E80gbZnUkvzeyI4Xv+31cmyrcVcqEc8fJToKhUA5bsRLmSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN9a8JTX4hhD/LzCnE+YGXDBN59GV+u8KVkgcLiyiOFxcmwma
	QvKgDfQyGrIwJ0eapRbyyuzOqB2oHRghITMvPuSQXXP3dH6GV/dPS5tqi4kUdLS/Uw==
X-Gm-Gg: ASbGncsXkYQSjdWpsTiLIUdNGd8eybY9mea6i71+/EF5UncoE4pUMyAVKHHCX6RC6nY
	BQPSuVRLo+tluRVMVlYGunv8KZsOwUev8zuRzE8sxdLpwmQxMHT+8wPcNUaKvdzlJhdSwwLnjTG
	uvtwEQHcwaoiu2dPz9+F8i6St2rXKt78J6qp7SDj0qPx2AaU9fTpbkuhkKUi4wuLqY9DK3ll91A
	7d7z6mBjTKn4wIAHhOw/A+M6+zIZlYaBSx9II3Ey0EJCleWRGAw3SpNlei+GhRWX7APXfl9f6Ow
	sLhfXIK4OL+wZSDXUV9yCEV8O6SJCXWUFNhZ59MiveF+QB5JFgdN9FFolsvddj8+q14MwE2q/u1
	NxEoCQhj6qEhaZjtq30F4LQij
X-Google-Smtp-Source: AGHT+IEQEsGM+8lfyVtjTlgkC5lbtII1qVz6+A4KiCnqNKckDNqV+kxRsJNCugaEBNYu7LYPVzpTNQ==
X-Received: by 2002:a17:903:186:b0:246:2cb3:5768 with SMTP id d9443c01a7336-24944b4323fmr31449135ad.30.1756563316240;
        Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903755851sm53673845ad.56.2025.08.30.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:15 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:06 -0400
Message-ID: <1c0e40a52934243b9721df47aa604734@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 3/4] Audit: Add record for multiple task security  contexts
References: <20250816172859.6437-4-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-4-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 208 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  7 files changed, 202 insertions(+), 41 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
