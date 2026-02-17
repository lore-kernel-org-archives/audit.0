Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E726F2B0;
	Tue, 17 Feb 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332558; cv=none; b=SIbAZWTU1SsZTTmcgqFC4CoTDAnhWw2BFjAhUuoN3RekfW9Te3rvgClMbs25acEXvkzHlQBnO299dIKVk/jUXsE6JadHmTbFEHRhbgjlLCUApysgy/LgUx6Ak93JeWAW0+iJMGZ9c+A4GRjGIu5+HnRS1gbLzM64RUH2rJKObWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332558; c=relaxed/simple;
	bh=i+tQZhHhKYK5TxpaUUQRuwDsn5yE/4cd1hYBO/BJhRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ+TLNNiHxDpHRX2uIVFWGyok1FvEX0rdTeJOfDBnc8SwF24oWAKO0X8bzJmCGos1ymNcMJo450jIfy6BxA1OXBCEvSAF4IFymiJUNKbThLUXWt43Hao9BAn8s0pdMOTwCUSIdU6Z1+Iw2tvu6HqFaT4/jBvIOKvDKWLvLMtOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV5faeMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV5faeMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0C9C4CEF7;
	Tue, 17 Feb 2026 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771332557;
	bh=i+tQZhHhKYK5TxpaUUQRuwDsn5yE/4cd1hYBO/BJhRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VV5faeMF0NaAdRXKoFru0qFcz6PQtUsqs8t26kI+Jfqsbtz65HdQN+nB2h0Zt7d1c
	 ++/5H42bJbg4tHuEM/1hfAf2RerFAEpCvssubDtN/OmVD0G7SkIJoo3oLjyQA1f4Eu
	 ghLyXAySH7XhuwE06JZ5mMWxRYLWMwT9tXHNH+EG5VNQ1uBGCCgx9s6xGSRcsWN3cb
	 WLILUpq0jsBO6P/kFING5Ptg1aE2ws+lCqS4qd7nPAwWgtFnUULOgvRv2iBSuf5Vpp
	 BILqpfckS13aVOm0McG0UjydlBSDxHoybK4v3Cn3KrV78rgS9lC+c5hfLDKj4ZlqeD
	 yNi/8K5RI/7aA==
Date: Tue, 17 Feb 2026 13:49:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, 
	Ricardo Robaina <rrobaina@redhat.com>, Waiman Long <llong@redhat.com>
Subject: Re: [PATCH][RFC] bug in unshare(2) failure recovery
Message-ID: <20260217-betrug-irrten-ad6a3098abd5@brauner>
References: <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <5cb07c57-9dca-4086-af88-f866f765c7fb@redhat.com>
 <20260207082524.GE3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260207082524.GE3183987@ZenIV>

On Sat, Feb 07, 2026 at 08:25:24AM +0000, Al Viro wrote:
> On Fri, Feb 06, 2026 at 03:04:53PM -0500, Waiman Long wrote:
> 
> [summary of subthread: there's an unpleasant corner case in unshare(2),
> when we have a CLONE_NEWNS in flags and current->fs hadn't been shared
> at all; in that case copy_mnt_ns() gets passed current->fs instead of
> a private copy, which causes interesting warts in proof of correctness]
> 
> > I guess if private means fs->users == 1, the condition could still be true.
> 
> Unfortunately, it's worse than just a convoluted proof of correctness.
> Consider the case when we have CLONE_NEWCGROUP in addition to CLONE_NEWNS
> (and current->fs->users == 1).
> 
> We pass current->fs to copy_mnt_ns(), all right.  Suppose it succeeds and
> flips current->fs->{pwd,root} to corresponding locations in the new namespace.
> Now we proceed to copy_cgroup_ns(), which fails (e.g. with -ENOMEM).
> We call put_mnt_ns() on the namespace created by copy_mnt_ns(), it's
> destroyed and its mount tree is dissolved, but...  current->fs->root and
> current->fs->pwd are both left pointing to now detached mounts.
> 
> They are pinning those, so it's not a UAF, but it leaves the calling
> process with unshare(2) failing with -ENOMEM _and_ leaving it with
> pwd and root on detached isolated mounts.  The last part is clearly a bug.
> 
> There is other fun related to that mess (races with pivot_root(), including
> the one between pivot_root() and fork(), of all things), but this one
> is easy to isolate and fix - treat CLONE_NEWNS as "allocate a new
> fs_struct even if it hadn't been shared in the first place".  Sure, we could
> go for something like "if both CLONE_NEWNS *and* one of the things that might
> end up failing after copy_mnt_ns() call in create_new_namespaces() are set,
> force allocation of new fs_struct", but let's keep it simple - the cost
> of copy_fs_struct() is trivial.
> 
> Another benefit is that copy_mnt_ns() with CLONE_NEWNS *always* gets
> a freshly allocated fs_struct, yet to be attached to anything.  That
> seriously simplifies the analysis...
> 
> FWIW, that bug had been there since the introduction of unshare(2) ;-/
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I'll take that through my namespace tree as a fix.
Thanks!

Christian
