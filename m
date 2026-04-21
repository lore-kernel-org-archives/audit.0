Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218837BE66;
	Tue, 21 Apr 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790359; cv=none; b=gEdhWUIv0Hfbc5qLwcH2vkNKwjJV2ZcDb1Lus+Tr+JVJgCBOPDBQZdlGr+guBNjGxlCF38FE3dInF7FJ/c23zMrUa2WR1LX8FbszWZ/pe5AOoqRs/MPOz+eYOlaAGO0tL/QD00Y2bq10t5X4IN4Lunzdx+teOxDu6b2YVCeqO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790359; c=relaxed/simple;
	bh=Fnria07dzxyjZ3R/MfEgproF5fm9396Lvzq5FKjseis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxZEhYCQ542dJNO3WQOmHhSo1ZfS+3Sm1WLQ9L/ecp17jTX03q2SwqO5l/mEPfZ76trUQcQQJbjNvd/22y+bC66U/O8L5Hn+4vPaXZgmT9OGliLoDXrtkTTjvjzgfmj6mCxAbRe/TLO+3Bms9L5luZcFju5+4bYFLsur9UxcaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVobLMjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVobLMjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC0C2BCB0;
	Tue, 21 Apr 2026 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776790359;
	bh=Fnria07dzxyjZ3R/MfEgproF5fm9396Lvzq5FKjseis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVobLMjqNU1DMwEkhE3AEfrF6unzuo5FeDCT7nj3Nv0Z+YEi8WeaPVfGr+VTVYI9S
	 GWGMbNHLTL7Zy+3MNai16G08E7XUBgJ2rtetuqMkJwuthn9fyJNLSBLp4E7aJH7X5O
	 Q6nJufFEEWqznHrPtE7Jr+ErMGNw7+JDDRNMNqF6gV+vEC1u2REjzEaB7rpo2DXjKm
	 h+dSfGUOKAJ80iPVh3tFWuHOehYDsBrQYk8HNwKxRmrNEPnGZHd+e3XfXeJ1Ef+igx
	 BLGruNGDfSrgTv7WEdYHhj6uSjPPiBPokNPeaPq8tgzhAokFzhcraeQRiZ8VidwzFl
	 InGkw5TCuxkww==
Date: Tue, 21 Apr 2026 09:52:39 -0700
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Drewry <wad@chromium.org>,
	Eric Paris <eparis@redhat.com>,
	Kusaram Devineni <kusaram@devineni.in>,
	Max Ver <dudududumaxver@gmail.com>,
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] seccomp: drop syscall exit events for rejected
 syscalls
Message-ID: <202604210951.7FFD917D@keescook>
References: <aeT6T7ZJ45yAtdZs@redhat.com>
 <aeT6dasGDZYPMQ_h@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeT6dasGDZYPMQ_h@redhat.com>

On Sun, Apr 19, 2026 at 05:53:25PM +0200, Oleg Nesterov wrote:
> seccomp_nack_syscall() calls syscall_rollback(), which means that the
> syscall exit path sees the original syscall number as the return value.
> 
> This confuses audit_syscall_exit(), trace_syscall_exit(), and ptrace,
> causing them to report completely bogus syscall exit events.
> 
> Add a new SYSCALL_WORK_SECCOMP_EXIT flag set by seccomp_nack_syscall(),
> and change syscall_exit_work() to return early if this flag is set. After
> all, this syscall was never actually executed.

I think this looks good. I'd like to cover the non-generic syscall
paths, though, too? (Otherwise we immediately have a behavioral
difference between e.g. x86 and arm64.)

-- 
Kees Cook
