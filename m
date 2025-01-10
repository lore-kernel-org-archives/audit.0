Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459520B7F9;
	Fri, 10 Jan 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508311; cv=none; b=mZJhFx2RIBdI9pnW5pTLiLmUSZ6+RvYqcsudXo3fJ2k02A7Zc7JZB5dnH2qTYZeuuqZWYtAv8mUKiYoly3AT2+xweciEUKRy8fzqk7/vBvazJH/TKWFESwTPHPUJHIoOlQxM41u4DS0rtiOZWqHh6ya1DyefxiOEv8YCGwJ42SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508311; c=relaxed/simple;
	bh=V96S8atOGBPNtoXMTrqHCISLdr0+nXPnbShwh4wABUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOnz2su/wrEbzK5pg7stf0Fou1fuQyyqbnf3gcDkAMajNYs2mnyCdwubEMFRwdWEel7Z73LR59AzfiLxU+M0GuZiXczu2vOjrDbWp7l1WNMRhPzJA317Q6dAuo/JUuCgt4h/xaHpIv7ExkhdMtQSuehSnhsN4WJ+UFBeSBg/9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xepXkp8t; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xepXkp8t"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzpN4WLTzXDC;
	Fri, 10 Jan 2025 12:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508300;
	bh=lq4ITW/C24B19F232u8HmGhyPgw2oJR1ShrV4/TLxbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xepXkp8tZA/5uRwGTGgunLNu+pRVxkTgsvojGku2syCoyDoK1L08ceB5YO1d+mUoF
	 9ZrCCTFaOA1ns/VBg0Qx4BwTcpmuZAFicTw70tU/PFVJ2FRyZJaVl/G4STIgwX8axR
	 C896eVbQdrMSBC/fk+JGbuD92/R4SYzThcd+VLFI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzpM73F9z4Zr;
	Fri, 10 Jan 2025 12:24:59 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 21/30] selftests/landlock: Add wrappers.h
Message-ID: <20250110.shietei1eGh7@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-22-mic@digikod.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-22-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:29PM +0100, Mickaël Salaün wrote:
> Extract syscall wrappers to make them usable by standalone binaries (see
> next commit).
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-22-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v3:
> - New patch.
> ---
>  tools/testing/selftests/landlock/common.h   | 37 +---------------
>  tools/testing/selftests/landlock/wrappers.h | 47 +++++++++++++++++++++
>  2 files changed, 48 insertions(+), 36 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/wrappers.h
> 
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 61056fa074bb..8391ab574f64 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -9,17 +9,15 @@
>  
>  #include <arpa/inet.h>
>  #include <errno.h>
> -#include <linux/landlock.h>
>  #include <linux/securebits.h>
>  #include <sys/capability.h>
>  #include <sys/socket.h>
> -#include <sys/syscall.h>
> -#include <sys/types.h>
>  #include <sys/un.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
>  
>  #include "../kselftest_harness.h"
> +#include "wrappers.h"
>  
>  #define TMP_DIR "tmp"
>  
> @@ -30,34 +28,6 @@
>  /* TEST_F_FORK() should not be used for new tests. */
>  #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
>  
> -#ifndef landlock_create_ruleset
> -static inline int
> -landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
> -			const size_t size, const __u32 flags)
> -{
> -	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
> -}
> -#endif
> -
> -#ifndef landlock_add_rule
> -static inline int landlock_add_rule(const int ruleset_fd,
> -				    const enum landlock_rule_type rule_type,
> -				    const void *const rule_attr,
> -				    const __u32 flags)
> -{
> -	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
> -		       flags);
> -}
> -#endif
> -
> -#ifndef landlock_restrict_self
> -static inline int landlock_restrict_self(const int ruleset_fd,
> -					 const __u32 flags)
> -{
> -	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
> -}
> -#endif
> -
>  static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>  {
>  	cap_t cap_p;
> @@ -250,11 +220,6 @@ struct service_fixture {
>  	};
>  };
>  
> -static pid_t __maybe_unused sys_gettid(void)
> -{
> -	return syscall(__NR_gettid);
> -}
> -
>  static void __maybe_unused set_unix_address(struct service_fixture *const srv,
>  					    const unsigned short index)
>  {
> diff --git a/tools/testing/selftests/landlock/wrappers.h b/tools/testing/selftests/landlock/wrappers.h
> new file mode 100644
> index 000000000000..32963a44876b
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/wrappers.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Landlock helpers
> + *
> + * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2019-2020 ANSSI
> + * Copyright © 2021-2024 Microsoft Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/landlock.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#ifndef landlock_create_ruleset
> +static inline int
> +landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
> +			const size_t size, const __u32 flags)
> +{
> +	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
> +}
> +#endif
> +
> +#ifndef landlock_add_rule
> +static inline int landlock_add_rule(const int ruleset_fd,
> +				    const enum landlock_rule_type rule_type,
> +				    const void *const rule_attr,
> +				    const __u32 flags)
> +{
> +	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
> +		       flags);
> +}
> +#endif
> +
> +#ifndef landlock_restrict_self
> +static inline int landlock_restrict_self(const int ruleset_fd,
> +					 const __u32 flags)
> +{
> +	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
> +}
> +#endif
> +
> +static inline pid_t sys_gettid(void)
> +{
> +	return syscall(__NR_gettid);
> +}
> -- 
> 2.47.1
> 
> 
