Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489723D2B1;
	Tue,  3 Feb 2026 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148684; cv=none; b=bm3TB4le2mWXUz+SvLKYxuRIek5np6CSr5TQAel7v02H9aAPut5Ya0m9YUPoMrJmxPsAQAileEdOBolcgr3nt0XlcQP48prXg8DpaYLIQ17eMo/IBnGiBE3KXY+HzpvwKeGkIVWN+VPY42bJQvvazsuQeOHDM9CrsyqssHJzNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148684; c=relaxed/simple;
	bh=aZnoX8uy59S7GZLjBIzlWLhpTs7AwFt2t+alhuZbvm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njzJE8b+6iKyyfGI3ASEj6WgXWPBZ6tBJ9uZihiZLwMTEyAOlDjENNKspo84cTRobYnolfX6JyBLVhOuIoRo28iG+DFWuXZyZqeholpKWfrfwreXBAd9SeMSge2wYO0rJOmMEIqX8Cn5HZkBDp9EDfkeMaEGNHznjHTmNK3E4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WNfTSWUn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WNfTSWUn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=femTVMpw7M4Fo6SzH7Zc70ZTK3GbYD786LSTuEzoM14=; b=WNfTSWUnQnhYL8VEyLFl4U1DtA
	AbarV2uleQmALqnqmFullZhnf1AdNNdIfGhwLvwEoIePjvSLrGJlHmXgpGJj9Tf41VFtNiDi6NZ60
	/tFKbmBBA4Z31Dp4W35SzCYzj/rEoSn9R37xFxVQpzRmTHAf5Ocezh5mDJZestfXrUtplLbieFW4b
	9SeMFdvqFqc2/QjjU6OqSzW7iLNIb0T+jCar33gXpwbuSCYU7fg30rgz+aZaMdEeNEdjtP/eoCiyn
	Fkw/0buGS4zkAfWbuMrqWIo5dNucFRAY1ODHo0eunzPnWMohUDGO3r1pMUQuNADD7qo4MU8l821lJ
	VzXkEnuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnMZ4-0000000HWP5-49uT;
	Tue, 03 Feb 2026 19:59:59 +0000
Date: Tue, 3 Feb 2026 19:59:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260203195958.GG3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203194433.1738162-1-longman@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 03, 2026 at 02:44:33PM -0500, Waiman Long wrote:

> +		/*
> +		 * Defer the path_put() call of the old pwd to workqueue as
> +		 * we may be in an atomic context that cannot call path_put()
> +		 * directly because of might_sleep().
> +		 */
> +		pp = kmalloc(sizeof(*pp), GFP_NOFS);

If that really gets called in atomic context, this kmalloc will
in itself be enough to fuck you over, won't it?
