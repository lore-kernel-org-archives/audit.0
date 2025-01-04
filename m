Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1B4A3E
	for <audit@vger.kernel.org>; Sat,  4 Jan 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009279; cv=none; b=iebW/nIkBa7j7G2cQX3jF+rdSixGNxJGAKfC9GQtULtxra+WkNK57oMaRjOog6R1/7vpKO0yD5PkWDePZ+zWo91Jfr2I0OHLzZCYdAgQL1HI2rAc1kBUEYGTJ1wnVVEdlOKzPM6p+0EJfp6Q8ynNDX5opfFgHze1uY5aAoMnWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009279; c=relaxed/simple;
	bh=h2tIki7bjEXiM/8jYOiqm11/Uqn3d7vqDv10DCbrnQ8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=X7Mfn491/1P3SVD8FPU08V+f/vhB3gFVbqoJhW8Nti6xB11Kogo9WYTFSJJFYOpBvYCo76AkFqMXBW86fjJxC64zz0n9n6kU2F1tiebjEaxOTwioGt0C69b+hBepO6A/5tphor3DcDgReJhomrdLm9kwvo51RGKH3ptVlQdnafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fJylvwYr; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fJylvwYr"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd01781b56so58723356d6.0
        for <audit@vger.kernel.org>; Sat, 04 Jan 2025 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736009276; x=1736614076; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd5Gcpcx32k0ZpzwyDHTdQhUj4sAgjDRDgH5tS6ZrE0=;
        b=fJylvwYr6U+FTfTNhAlWBCwmJw9YgHasPovYNPT4UT5dmwto0yXULKaIxfQIy39hA9
         0MbhqcrKgzpQTAC0lCoYr37sta8KTIb/l5kFWwbR+qAUBTJahAUWkjUgH8x9UXjxHT1K
         R6faKzhqdgAfV4uzypuCeJKxKfOG6zONzJ8i9uLtF4yDlprJYb1n0TrNQAS3RJaasLIP
         l67MzoKbzZoqOPQcPdOV69FJ2SdJrUvxDySRyGH6K9125JOCxfzQhOh/KIrBQ2yafNNH
         xHPQQ9X7Bvngp7su7UncefjeJq5PcJIeWQdI7pRH+r44UZyJxiWzduEvNR6cZKO4fE9i
         0JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009276; x=1736614076;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd5Gcpcx32k0ZpzwyDHTdQhUj4sAgjDRDgH5tS6ZrE0=;
        b=LG/7fhdPFX4y0mD+XOGKqXvKXYsQyaRDXQBXxGEhWov/8kVriZeJi/En3gOc3nXRL4
         3PHd6/xrfikuu0zm2KWJWTfdldo9MjeBpykRe8OvtSRbTOXkxdRItAK+EwDl/7WlrCqT
         8DlkYsAomhd9Va82jo5hFjSeh1nXqPbh2aoaADrChKX2H7wuA07VjaO1PAfO+mOhaVoE
         M9C6pprX40WWyu5w/c4pEWs3guxa2iT3ScCwMtXWr8IFIZRo8e4+oXlQ/LbsIgbgy9Wf
         MifgRNwyg1p4e4g3NWhaQrdCCkN/J+T1Sbo/ITWH9mXFjuwF+/kMUUt8NT8zu77tzl0B
         4iag==
X-Forwarded-Encrypted: i=1; AJvYcCVJtXDWiSAQWjU/XXlIG+cMPfLI6XAUIARKUWCyrxah/tiF7YVcKWvPMUZFIE5JbOfO0He7FA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6h6YXmptDPj9gaS/TIuNPrbtwWBTLrgUBwbGaqADapX7REYU/
	+Tfokl/2XwdVqkkwX/rGpMcHLB1PdKXkPc47WwhN621gB8jfasKRK9UhfLmfuQ==
X-Gm-Gg: ASbGncv9+eHNWsb0scE4QxwNJPwuJdxWhfbQQtUbj4i0nLFM/Am10TTts0JwPd2oh4V
	6glawmhw2ahVY3/GC3AYNSFWmP7T51D8JxYzsDkaUusOCgJfSSdnRnkP8Q2x/UO8ertPG88OlNF
	h2SNcAse82j7hyufvhFn1T8qAx5ZncfVi98pwUoXm7RsYQzqBempThqoNkKGNK/GRbPzQwajX6I
	w1u0556YPI6ct4hDsLWoeN2arOj3vd0x0IVFd2OZwxp8OEMbFA=
X-Google-Smtp-Source: AGHT+IFPLFZsnBfSRo+5eexgcUQBdUzzkhBzACl/CPaB5hudagsKQ0zX1q4RnI10Mrc/Xdn8h2Ph6w==
X-Received: by 2002:a05:6214:5f11:b0:6d8:a730:110c with SMTP id 6a1803df08f44-6dd2339b10dmr1115611796d6.38.1736009275804;
        Sat, 04 Jan 2025 08:47:55 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea73esm151471096d6.18.2025.01.04.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:47:55 -0800 (PST)
Date: Sat, 04 Jan 2025 11:47:54 -0500
Message-ID: <4892093687d106c160329d4d6d9d775f@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/23] lsm: Only build lsm_audit.c if CONFIG_SECURITY and  CONFIG_AUDIT are set
References: <20241122143353.59367-2-mic@digikod.net>
In-Reply-To: <20241122143353.59367-2-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and the
> dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> are found by the linker.  dump_common_audit_data() should then failed to
> build when CONFIG_NET is not set. However, because the compiler is
> smart, it knows that audit_log_start() always return NULL when
> !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> a side effect, dump_common_audit_data() is not built and the linker
> doesn't error out because of missing symbols.
> 
> Let's only build lsm_audit.o when CONFIG_SECURITY and CONFIG_AUDIT are
> both set, which is checked with the new CONFIG_HAS_SECURITY_AUDIT.
> 
> ipv4_skb_to_auditdata() and ipv6_skb_to_auditdata() are only used by
> Smack if CONFIG_AUDIT is set, so they don't need fake implementations.
> 
> Because common_lsm_audit() is used in multiple places without
> CONFIG_AUDIT checks, add a fake implementation.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-2-mic@digikod.net
> ---
> Changes since v2:
> - Add CONFIG_HAS_SECURITY_AUDIT to fix the build with AUDIT &&
>   !SECURITY, reported by Guenter Roeck.
> ---
>  include/linux/lsm_audit.h | 14 ++++++++++++++
>  security/Kconfig          |  5 +++++
>  security/Makefile         |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)

This fix should probably stand alone from the rest of the patchset as it
is a worthwhile fix independent of the Landlock feature additions.  I'm
going to go ahead and merge this via the lsm/dev branch now, if anyone
has any objections please let me know.

Thanks!

--
paul-moore.com
