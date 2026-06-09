Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348963559F8;
	Tue,  9 Jun 2026 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040961; cv=none; b=RnbyxKY+lf5VJbwmDvNSC37oWv3JYpc56BBFBhCoh/CKbmfH+h4XFCHGnmLPmVSBAHUY2piKn4beo+Xs82Sb0POyZxSErhUIj0mRd4MjoO8helbkZkeWMamgJ4u2fiNFX/Xxkmo5xdmOXn2gtuk9T6L51J3QZal6XC+PQaAjRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040961; c=relaxed/simple;
	bh=6yb47jyHXegDHsehtxP5Uvn7/Z7Yn5r3M2gfbFu8MB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsIjPxnkoG6RIDjiLOsrCnFdxMemGjSivdBPSqWpDc3XPd7c3fNiOL+g0bkUb2ZUFMfEw4DDV8Y2Jg0HH53vqj14wgAR2itZ0UCUjsZ9n+gPf+tAw+oFC2lIh8kgluRSZUo7E1SqCZFg/z0SnHudJQFqTh0Urtfp8ukFGVWmXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHud669n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHud669n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4930B1F00893;
	Tue,  9 Jun 2026 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781040959;
	bh=ggD3WzIVX4wqGJPJeDoCT2PRxRqvWH2szMMGD6/H1GA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kHud669nBOrGOYiQB3I1/VXoG/l2Gjpoiy77YHWLFXJwX/hj4ebCz8yMr2ykpkGdJ
	 vBt3LzfASCnz9H/9mNIxbytL6NR/DojBBvda1wXjcPLVcc758rAdPuFObIRy1X3nKq
	 mVHRkvW72bfM/YNW7Cs4Hxz07sGd8WUbJ3t1ijHdIsP4A1WJ/9rPDd8V6LUgq5ldcK
	 U6s1O6++ViBZNp9prcL88tWpkd+T5fnGBAydOTBc8Sm9YmZvwjttfBa4z/TuRn3xHl
	 Rqk7yyZ8j4uIx4y2KFNwfBsxICeWjgC7B96RAgl/GlFJ9M//R/6GOCZ80WVwdPseNB
	 vNml8yrfjk7qQ==
Date: Tue, 9 Jun 2026 14:35:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260609143558.49d96656@kernel.org>
In-Reply-To: <2756655.vYhyI6sBWr@x2>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
	<2143396.Jadu78ljVU@x2>
	<20260528162901.2d68e2e0@kernel.org>
	<2756655.vYhyI6sBWr@x2>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 13:40:23 -0400 Steve Grubb wrote:
> > > You're right, it is. I see how this flag would fix the pathological
> > > behavior that was reported. But as I have looked at this suggestion,
> > > there seems to be one wrinkle. User space should not need to know that
> > > the audit code in the kernel has this retry mechanism.  
> > 
> > It's not about the retry mechanism, at least in my mind - I read
> > your reply as "user space should not know that there was congestion".
> > Why?  
> 
> In the audit case, it is not useful. I know there can be an endless supply 
> and there's not much that can be done except dequeueing what's next.
> 
> > It's not very useful, I get that, but user space can just clear
> > the congestion signal and keep going.  
> 
> How? The recvfrom man page doesn't even discuss ENOBUFS. Which is one of the 
> strongest arguments for a kernel side patch. The fact that there is exists a 
> socket option to declare that you do not want ENOBUFS on netlink sockets is 
> esoteric knowledge. The netlink(7) man page does cover the flag. But even 
> where it discusses ENOBUFS, it does not mention that this is preventable by 
> setting a socket option. I do appreciate this being pointed out. But getting 
> from the recvfrom man page to a solution is not obvious.

socket errors are generally "consumed" when they are returned.
The user space should see one ENOBUF and then once the rcvbuf
is drained completely the CONGESTION bit should also get auto
cleared. This is my mental model how Netlink works, LMK if
you're seeing different behavior, my memory is faulty...

> > > It seems like the audit subsystem should set the flag on auditd's
> > > socket at registration time in auditd_set(). The kernel is the right
> > > place for this because it's the kernel that manages the retry/ hold
> > > queues and sets the sk_sndtimeo that triggers the overrun path -
> > > auditd has no knowledge of these internals.  
> > 
> > We have to carry this code somewhere, either in user space or in
> > the kernel. I'd prefer not to carry it in the kernel.  
> 
> I can put this in the audit daemon. But whoever else writes a similar app 
> will have to independently discover the same solution when faced with the 
> pathologically bad behavior. A kernel side fix would have made it easier for 
> future app developers to be successful.
