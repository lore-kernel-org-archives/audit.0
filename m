Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F21D0E0D
	for <audit@vger.kernel.org>; Thu, 31 Oct 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415230; cv=none; b=MN5z65MetT9WRNhHPu/5sZE5ZIWBWtUblwka0xJzekr5GOcJaRrrYEC5rx5Mr8re/G0vc4eeJjlvkjRe7zCqvFdCA4Xr/DWJYLm7oiIDWEaAu6Xtt5wHXKQPHNcppqZeJNuSoJwrz1hTkooM0A5bZhQq8dPNUCRJ4j42mm91MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415230; c=relaxed/simple;
	bh=d+KWwf0GkCHU+dO7dz7Ix9366JgUxkGbxc68is0rego=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uQWE/SvoypjKMmXyEkZL+rFAkTJoyJNGbG+6OYLUfM+1cIoVpujFX1Ou7w+omYAWg6+36qnnnd/kHkIwZ5xA7odOCwurS81cx1Oz1VwL/W2cI23YVEaacLBtOwMO1HVh70EHjqyHtOcYKGY0UwK4WLb3XdCIycZpxtFtehqhrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HwhAHJM3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HwhAHJM3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b155cca097so123565685a.1
        for <audit@vger.kernel.org>; Thu, 31 Oct 2024 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415219; x=1731020019; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=HwhAHJM3tGqQd5r1l+ZE2Yf79wCAK3bP28oxsvotyurrRNEy46/9sjDN7Nb/tCOQLZ
         Hhb5QsdiXXy2BEMFk6Lw+t2y2JtNJCnArD//sJ8UCnrxT72AcDqYtpcyBDI6RN8dK+mH
         zoxp99b8QxPVllEDJA8BJTPTkD8q5gkl+qUsrgR9dWZaZxQ92Zu/YBzYenTxTk/8vMbW
         B0gzbjS9nnoepjR2aOd+BJtxlyLZH0ykx9Jq/6JPkBcEs6SBSVwK5b9xRw5oD0hqAACd
         /JYdkye1PvTHRqxEbVRUiAPQLszfIdxMuenem/A7QL0ywJOytU7XaS9PGtP5Lr70d4kO
         +N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415219; x=1731020019;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=Miyjw/V9IqwXpKWr0wRNzcoyWBnKfpCBb4AmqlYMU4HsmaIYNsSfyki54iko/kkvNE
         WjbQ1kjeRKk28G8U2CdYtid5V9LvjYoLcpqdzX1671YhK0Aqstblfv+bVZsJVTpXM78o
         zr3sDI785BGfveNxyGq3/w5XtEFqupEnyamURWaIHNdp2TXT1Woys7Rs4TvqMxlvEuPa
         Px/8xLbQ/B7LOqz1OUB3PCnDVYq8aX3On5ZOse6ebQ8MxA7i4fQAJ+s+ZA+VbU9GH7h5
         Fw38IdJ2Uf1/Np9Jj+0MjgEgT6KgS3aVlpjhXrCzhkOtq4Yz8ChGki8TCChUHOhdEZai
         QPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDT8ZaBcQNym5x0KBHESkOEwYqngsVsJONhD1bjlZGrMmze6x5rAvPVFLJZ0im7EINDEnZqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjKracJGa7S7y6rk9jgt545rHhaiCLRkgAvpmBXlQqqw5zIW6
	CKatFbXmYKVga9lLz/3nWBquvz9xla4ot8Tv2tSDWqslHeyXUf5cP1Oa28VKMIDP3uBZjgsHfSE
	=
X-Google-Smtp-Source: AGHT+IHejnUcO00gdkp6GIPiLQ9d5ZeTLg4Tg4eKKtHh64s2L4WuXTwedaEARJS6sJEf6l71xF95Rw==
X-Received: by 2002:a05:620a:248:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7b2f3cd68f1mr599328885a.5.1730415219210;
        Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f820dsm115059585a.32.2024.10.31.15.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:38 -0400
Message-ID: <68a956fa44249434dedf7d13cd949b35@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
References: <20241023212158.18718-3-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-3-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single
> lsm_context pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> security_secid_to_secctx() and security_lsmproc_to_secctx()
> will now return the length value on success instead of 0.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c                |  5 ++-
>  include/linux/lsm_hook_defs.h           |  5 ++-
>  include/linux/security.h                |  9 +++---
>  include/net/scm.h                       |  5 ++-
>  kernel/audit.c                          |  9 +++---
>  kernel/auditsc.c                        | 16 ++++------
>  net/ipv4/ip_sockglue.c                  |  4 +--
>  net/netfilter/nf_conntrack_netlink.c    |  8 ++---
>  net/netfilter/nf_conntrack_standalone.c |  4 +--
>  net/netfilter/nfnetlink_queue.c         | 27 +++++++---------
>  net/netlabel/netlabel_unlabeled.c       | 14 +++------
>  net/netlabel/netlabel_user.c            |  3 +-
>  security/apparmor/include/secid.h       |  5 ++-
>  security/apparmor/secid.c               | 26 +++++++--------
>  security/security.c                     | 34 +++++++++-----------
>  security/selinux/hooks.c                | 23 +++++++++++---
>  security/smack/smack_lsm.c              | 42 +++++++++++++++----------
>  17 files changed, 118 insertions(+), 121 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com
