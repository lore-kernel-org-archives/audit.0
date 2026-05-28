Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BF1DBB3A;
	Thu, 28 May 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010943; cv=none; b=efqxnyaTYs4HlXaX1SikqmvlDKM3MtMFAjX3jaGcLoxbVktr+4S0LFs1gg/mcyiNet6Yonw7KfKRIfuhxU79pQWTauqCJu7CA7vgAEj5vOlm/J0KeZn3Auoo02IZO9nmY93ItVYF7s1D1tkenxksX6mPAuf3zIKm/HkYzh5Gk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010943; c=relaxed/simple;
	bh=JiC2ZXR5o5RuRvWtBMIhBz8Bt7AysbRI+tZGiWA+qEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liptk5FQWAQE+r5ZuzvYng2Ln/freH76SSyMbQilEwSNRTv10KSEqW2Lf5SB8O0DczN9Bvom+F0Ld8yDgT9eTBw0QDXZeb+rd4GYpVTIJ+DK36YGTGXo5TfPHD4wOGzbU31HtVUaiRtMRYTtSQAhZobdVhI4kQS94H4KbjhHzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn7H1iMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn7H1iMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C891F000E9;
	Thu, 28 May 2026 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010942;
	bh=TSbbAi6AxwOZw7EN9L734+yNxSco5cVfngQEMKLubdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dn7H1iMcOsAK3rg/m1++i0NJ2OQbnjlXCfN0qBBgfFapxteFR/xKZYhbyme+bAsSp
	 2AzFYYeEo4/nchah0qH3YzyY6sJkV6ok6XOzcqiuc1MCp+mp2begLQ+6H/FKX77Qlc
	 C1CkZWI+D7jFWwjJQ+BwdAN4ie78346lNCjWsV//srxxyKhQV75dkDh0TCd8Lw9ATW
	 zK1jKI5Lkbkn5rKtbhIVYMKnT5ISIvFkyfq+Vvyhm4IioNXINB5efpuNxXVqgGTLTO
	 FTzuTNiRUlHpaGOXb+z7H+HvHV6OXSvbuLf80qMWsvV0Jg1MDA3i+6pE+eAICPiW2Z
	 Mc+a2wP6zm1Pw==
Date: Thu, 28 May 2026 16:29:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260528162901.2d68e2e0@kernel.org>
In-Reply-To: <2143396.Jadu78ljVU@x2>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
	<CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
	<20260527152936.001d5d28@kernel.org>
	<2143396.Jadu78ljVU@x2>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 18:40:44 -0400 Steve Grubb wrote:
> > > (3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
> > > kernels where this bug is actively impacting users  
> > 
> > Which commit are you referring to? Isn't that flag itself ancient?  
> 
> You're right, it is. I see how this flag would fix the pathological behavior 
> that was reported. But as I have looked at this suggestion, there seems to be 
> one wrinkle. User space should not need to know that the audit code in the 
> kernel has this retry mechanism. 

It's not about the retry mechanism, at least in my mind - I read 
your reply as "user space should not know that there was congestion".
Why? It's not very useful, I get that, but user space can just clear
the congestion signal and keep going.

> It seems like the audit subsystem should set the flag on auditd's
> socket at registration time in auditd_set(). The kernel is the right
> place for this because it's the kernel that manages the retry/ hold
> queues and sets the sk_sndtimeo that triggers the overrun path -
> auditd has no knowledge of these internals.

We have to carry this code somewhere, either in user space or in 
the kernel. I'd prefer not to carry it in the kernel.
