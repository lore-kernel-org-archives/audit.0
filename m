Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D867435ABA;
	Tue, 21 Jul 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620772; cv=none; b=F+mTr/drbp33FkXYllsW/wwu53GlqN1uioukkbpmyEpVbbisoHAmRA/q3AK1z8YFJPHZYgaUnlDUqfMv/ZS8ElN5eNOLy7KF1qMa+e/bRZM7gqsINErE2WuMIQfSW/RgzUfJTJLetBVcCdteyXHZLIlcXaU4YnzAFCvhuUQCfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620772; c=relaxed/simple;
	bh=LWtSQAZC46e3PUQWVL+CkQY/LT4DkLbPaJBY4gvmYwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RC6j/FmLg6Ok0nwP61e45J6PU3v0ass5UU23xBCYzVxS9PrZHeg6wydpWrFuokoxxSalfVk+iMbDyqHP7VNL5kKfs6sdFuaYxreIOLCOXsY44hHhXpTTxl2Sptkc8rU/GTo5VhQ8ASwiCPLVVChf5whVbaULqVUM5iV0DGnEcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDgjjr5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDgjjr5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B31F000E9;
	Tue, 21 Jul 2026 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620771;
	bh=LWtSQAZC46e3PUQWVL+CkQY/LT4DkLbPaJBY4gvmYwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oDgjjr5tYFgj4q2n5cwg/J5t5n0DII6+uxMIA2cziV1U/tQJDuJzF89IYXb6a1Xp5
	 uubNZ1XVnhXdroDqJdfM+sVI3RB7hTlXe2j/pnIrM2yiOdjqZJIq3ggeiJgpj3Ovk9
	 WRrvkXoOnM7eKXu0p9VmSapMBZGedVKlZX4/S9sQdaM98nqkSC2RE4LH58FmT6uI/n
	 EBUM0XfQULoFeP2ILVtju9gCdB9PTx+ZWtIbSfhwgU9C3Xim0LMiNC7xIprTMlVCr/
	 pvHw4CfhsFDyBpXVO7VLWP2pTlaxNA99LC5Ac8SpaZA/Nh8qTVQaPoZOLu0pjJWd/Z
	 9nLqTYjEt4Rjw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul@paul-moore.com,
 eparis@redhat.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH v2] audit: Force audit_context() to be always inlined
In-Reply-To: <20260721040118.1000554-1-ruanjinjie@huawei.com>
References: <20260721040118.1000554-1-ruanjinjie@huawei.com>
Date: Tue, 21 Jul 2026 09:59:28 +0200
Message-ID: <87jyqolqn3.ffs@fw13>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 21 2026 at 12:01, Jinjie Ruan wrote:
> commit 6f25517010dd ("entry: Rework syscall_audit_enter()") relies on
> dead code elimination to remove the call to syscall_enter_audit() when
> CONFIG_AUDITSYSCALL is disabled. However, with s390 GCC 13.4.0 +
> CONFIG_KASAN, audit_context() is not inlined despite being marked
> inline, causing an undefined reference to syscall_enter_audit().
>
> Force audit_context() to be __always_inline to ensure the conditional
> can be constant-folded and dead code elimination works correctly.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607181530.2nx8zb3J-lkp@intel.com/

Obsolete. Is already in:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=core/entry&id=6f25517010ddd3f8080d7e06b9b1cb1b64b73772
