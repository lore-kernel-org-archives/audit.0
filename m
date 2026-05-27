Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CF3B4EA3;
	Wed, 27 May 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919255; cv=none; b=IGmMcUbXxP7zaHJIskUcg0h9Wu5VPJEuKnikRYZnZYFoA8CJOi39AuRryS4CEWr+o2RdxraZrMZoFahCsBDh2hMmxOw0w1WK5zNapp1a68ki4oltvgjZcP85x72bp//Yfy6jObO82+lXqwSjqmKBsPQuPBefZROH1oNYQeBct14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919255; c=relaxed/simple;
	bh=K+2PBOTkglAW3miJSMhH9wApdWPjmdrMRgBpbNA4E1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3jVmhCQ1bdYLyFyocfm68D/EJJIwZmEkjZ+D7Rl7FXuIE8ENV6lk08dxT3k9tRrs8FSeExRsEFqdZnGjNjIFT0QT+Dn7oxpnIHoO3eqiTf1SXJqnabjg1gLKxJkGRQMAgE5CFzoiVdLaPOtoPD04yH5ylFpLrcggZvfyLkm2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMynz8ee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMynz8ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B62A1F000E9;
	Wed, 27 May 2026 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919253;
	bh=x0pxT4HZIhcs1HqpqHxsIDiMExdPoz+EHtFOvLXYu9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GMynz8eeNUxQboU0DGK57X7n0j/Eh1ZhKqhlSmEYcT5h7nyrPvC/o5aNmKRO72cCm
	 1AJeyDhqFqVssTE81BqEcsvOI3gXCn40UIjXhp1Nq7rN1x5m5rl8bJ3+eoBUVNRdr8
	 eEElKDA/hsxq50ecSoWtIr11JirnvufB9aJZPErlilcQdocmnnHl2lvWoXel/ew/Ju
	 G6eOU+DWZp4Bzbd03th51HcvS+lFd2TNBLjKqeDi6pe9a69XnUcOYFA2BueS+7LK5b
	 DeAP2QDZ4l/jI1wXyi4LNgEoQWstlYSTcMyxhpuJbU7mpoKsi3I5ChP/dMKYbCa+op
	 URhuv0fOHIBwg==
Date: Wed, 27 May 2026 15:00:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Steve Grubb
 <sgrubb@redhat.com>
Subject: Re: [PATCH v3] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260527150052.68edb415@kernel.org>
In-Reply-To: <20260527192150.949400-1-rrobaina@redhat.com>
References: <20260527192150.949400-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 16:21:50 -0300 Ricardo Robaina wrote:
> When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks
> on the netlink socket wait queue (nlk->wait). If the wait timeout
> fully expires (timeo == 0), netlink mistakenly interprets the zeroed
> timeout as a non-blocking request on its next retry iteration. It
> then triggers netlink_overrun that drops the event and poisons the
> socket with ENOBUFS. This bypasses the audit subsystem's internal
> retry backlog and falsely returns an error to user-space:
> 
>  auditd[]: Error receiving audit netlink packet (No buffer space available)
> 
> Unlike standard netlink users, the audit subsystem has a hard
> requirement to never silently drop security records. It uses a short
> finite socket timeout (sk_sndtimeo = HZ/10) to escape a stalled
> auditd and safely requeue the message internally. However, once
> netlink_overrun() executes, the ENOBUFS state is set on the
> receiving socket, and the audit subsystem has no mechanism to
> intercept or clear this from the outside.

This provides no improvement over v2, let's keep discussion on the v2
thread.
