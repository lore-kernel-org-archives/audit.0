Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA32F83C2
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483575; cv=none; b=ACDD/Rb9xoOaeUxdrx5SN35cFFx20ui37Hv/rRkw+bFi+4lkCdPgD5JvyiVLtgOq8CLTtfbhnMaJKH2GmNT4fu0hfLhw7W2Mn4ch1izB1f0w3HVwBtld4ibyuG8u1cnV2s8oDDcuZ+UrPRR/FGjXNtrtoN+c+QjufHl1rIMtG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483575; c=relaxed/simple;
	bh=uSN4FXEH/3MuffBTCj2UYI2kGTHCWhQlnhaFfdx8IkU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=O/DjVs1JdBDyN6i75EZri3bE/nbCGZiEOS6XBE060fg4GRNaeR01cJ15S++OOpygcyu50s1R1oVnJhMF8unnAVaN4cxU9dNCX4YGmbMdl2SkNSqzB7oBCTiNQOfehRJNiKW3+f+UmKU0qok31QE6R8ReQqSDH/NmeUMTV27CnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J+cgwIPm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J+cgwIPm"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87499a3cd37so54039196d6.3
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483571; x=1761088371; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=J+cgwIPmIeXNQNd2aqaNp4EwgZMRN0nTy1A1qxO+DCYGlQ+5TmPjYWZay/7B+UJxmY
         hRCOploooNk+X6W9qkzr56EIjWijWciQVXzdyaTmFV27azILROFQedAiQTog55nT3CZn
         GNZCP4LsHSEf+XssbeNDWjs81InSeC4mijblXPqyZEpNYcRop2sOEE5Vi8YfqVUdyLj5
         a2nXYg1Ru8L5+kPQZk++Rs2Znl8rrDlzPNYE3yNS34UAqDvWnyj9otwMr8q4FoWsNMle
         2KzcykpUaIsCfnD8QLOwqTQA/ZNqDtXvdKSBgCq27SBy2FuvRXm0IvHd2ABTl6lslHLZ
         Yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483571; x=1761088371;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=MvtebytrqiK1wJHbWrAwJLahO+8lJfL/qB43AhljoxZre/kJ6VGKbH0XnCbWa1u3oo
         5vpANFfbzoHXsi2mhnqlMGur+hD5SaFb70cCqerSNJs4CLPdz5AqJvMCIYXnfjVgPrgT
         R3FJPvzl8mJfOrF76p5UhM74IjZFakgHTqSSA2RTmIWD2Or9HJcmK/MKLzUEZPCbrf6E
         0L6IA5xLczoeC/YUf8wjodAi9ZMP4YJHYxImQLArUuOo0T2H+8InrUNTov7XfFALlhi2
         i8zh+omvM2lJvmzilYMzjekOgegmRb5if/GnOdPI30I87nSTB6bHWwSnSu+ka0efEMbX
         SXQw==
X-Forwarded-Encrypted: i=1; AJvYcCW+9gcLXWoX0Ajt9ANs7zGE5yfnuGE/Kc7+isP7p+iER3i28v0cbyqc3ywy75W0LJs+/uJVzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMfahg4J/7zIkyBJ61M5wQfC4kHPGFY0rmzZ5Tb+AEIdMEJjh
	EjPk+H3Jr5CHa0z3EMv/4q7SxT48WUR7jWLdsnw5MZB5qeq/4F6klLgJHHD5CYn+Ew==
X-Gm-Gg: ASbGncsK7DAvKy5dPMVRFKMXVukjP1FGhiZFoJr+3g8aUU8t8pmRqE15ivcWRgmJ6Re
	WTl1f+RCredf7R+9a/yvZcbJ8qcYM8+DB7/8Sy4glJIv/ss5P9JpJ7ELyMa4AwFCc02yG7yzLG8
	P2M3WHmD4L2P+L9CvlPl9RK86p+TZcfEQKU3EjyXsGNwiiOy3ZJqF+pjHZry8pmhT75JOn47AQq
	OuejOYT+3PwggkNqyM2PFuk5KXZ3zU5VfYGMIrlPKJ/9LHQBvobgrklYc5+ut7Hl3hsVoyRcN93
	+df/vkku40qJCRW8peNhMlaP9nUXy20kwr+8BS+i5TX8+avNK44+jV5zau62iqSVc2/SoPVajvJ
	4dtOQxL+72LVRbGGm3qJ8sUjaa1CTqZlzyPwUmWVOiWYWX/3KT5T6x6RxwsAxf8NT+6XT+487qW
	6QRXAwHg2EPkv8wf2LkvumqQ==
X-Google-Smtp-Source: AGHT+IHCPlsD9zAsKBhE3Wi8fF8+vdSGhRlXGGKb3DnpK8wXKCrf1dLszTeWmxiFrIx4cZK1oq7OBA==
X-Received: by 2002:a05:622a:4814:b0:4b7:964d:a473 with SMTP id d75a77b69052e-4e6ead5803bmr401868921cf.52.1760483571078;
        Tue, 14 Oct 2025 16:12:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c0120ce79sm7028506d6.10.2025.10.14.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:48 -0400
Message-ID: <7cccbd87d3ca12f377fca6cbc564eb69@paul-moore.com>
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
Subject: Re: [PATCH RFC 6/15] LSM: Exclusive secmark usage
References: <20250621171851.5869-7-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-7-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules
> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and
> AppArmor.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/lsm_init.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
