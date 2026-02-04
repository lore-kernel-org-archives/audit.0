Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546571400C;
	Wed,  4 Feb 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236175; cv=none; b=WDYRwsaiytO0yl190UmpHaibIGsVdSXFalcWIVMk30t7Ai3LCZPUNkRSYtpdRHIlEnr8tg0CenNlfSMKde79BjuzD/X++0bHOU8MR1iT4bMTZbgUk2wODwSq39ruWQZiJ1PF5GSNKU3zTA35pcpptXO0E/pWBySmiDvYBHeq+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236175; c=relaxed/simple;
	bh=QbraldHBFFwbPxZFoM43GhuBISS/dLdCiBnbc3rJmQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9sO/8GdTwuL2zwUkTSBe1mOpXYxoRDdyNCw8kZzG1vVkkqKbl2kaa3Zj/TaN50IT6YXzF0QS6yjPGGaQN0nLWvvgX78WCZh4Jzd56MOzDWlt5gy6wpXuu8GZ0P8OLqOmeYC+OFgxE4IMrygt8yuQ1tItzwk9KJEr5xUUd/3cvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n+NobGrB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n+NobGrB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kf1eyn4/oWB+N/Z592gbiEwp0OsWuD3LZ2K3TYa9M8s=; b=n+NobGrBzzFtR9g+D8aaNSOAIt
	99IxYghOCeikMEr+gw9TwDMoAR4uy7zLyeGiVmJ5Rk/7FUr3+3aYrrwwUMfqyQJn8DqTZ4alPkYMn
	EbeQhApVP4Tmmr7kpDn461KSi6T6uC1YOjahMzCYBAydb0jliJLHIwCEgOvrIOi9+oC2WpPOGZhA3
	o/hUT0NDHEAyKob3PMyI17FJE4/iJB2i6GJr+6IS/9qQ3nGbghzc6mnM302bEkDufUZt9+7/xTEJb
	q1C4v1LXpEQ29zQqfvU/79F7JFdLp546ggdquqgKK6DdjTZaLrbDDfJZYF/PFf9YrXatRIkDffwGE
	B2Bf3HXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnjKJ-00000005c1s-3aw2;
	Wed, 04 Feb 2026 20:18:15 +0000
Date: Wed, 4 Feb 2026 20:18:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260204201815.GP3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 04, 2026 at 01:16:15PM -0500, Waiman Long wrote:


> Thanks for the detailed explanation. I am thinking about something like
> the code diff below. Of course, there are other corner cases like unshare(2)
> that still needs to be handled. Do you think something like this is viable?

Deadlocks aside, the immediate problem here is that consensus number is too
low.  Take three threads sharing the same fs_struct instance.  The first one
calls your get_fs_pwd_share(); then the remaining two threads call set_fs_pwd()
(e.g. by calling chdir(2) in userland code).  The reference stored into
fs->pwd_waiter by the first of those two gets overwritten by that stored
by the second.  When the caller of get_fs_pwd_share() gets to put_fs_pwd_share(),
only one of the sleepers gets woken up...

And it's very easy to end up with something as simple as chdir("foo") deadlocking -
we start with resolving the relative pathname we'd been given, audit wants to
record the current directory, on the theory that relative pathname is none too
useful in logs without knowing what had it been relative to.  Then, in the
same thread, you call set_fs_pwd() - after all, that's the main effect of chdir(2).
Deadlock...

IOW, it's not just unshare(2) that needs to be taken care of - chdir(2) would need
to be treated differently.
