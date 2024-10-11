Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F773199B8
	for <audit@vger.kernel.org>; Fri, 11 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660669; cv=none; b=pFnW5i92Cob3Q6W6lYlcG44ScGpq7QDAkhX6aR1+jFeuG8xVwl6XsI7EOy+RtuMjg37OlA+Y9IC44smeRLdSUWRssRqBLpyuKR3BzIiAfxRIa3WnEp8K41HOd6qwSb2PbSFiSGe92k6xqsA1h+h3TGm1igIHnKOtoYiq4JT2Ijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660669; c=relaxed/simple;
	bh=NsPGwHwnspM3wr8QfUs6BxeNGWF+VpsB+QOZ6tvMN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQfQUfRhA4jRxtuWUR5X1qHBbpVrJPNR4hbeACdHz76+/dFJLcDv64aGGkawH4FqUKaCtEzEt5Ym7y9mI5rBJYbngIcrfR3yrjw8AntKE0O/0z4tmUZv9waT0Xl5SKf0pxU5l1K0s1/XeW4oMhYhNL/cethl8mMPtm1nXKdROdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h3Cr1Sgz; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h3Cr1Sgz"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ9ZJ2v4CzMZH;
	Fri, 11 Oct 2024 17:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728660664;
	bh=U55SanGiVovRw6PJWPWfxK7Vw/FiEAp4FEVfyszMD+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3Cr1Sgzp8L4PP+ApIZ1K2Fb4iFt2qMbj9MuPm5xUojHvojzVs5OGes0QonIg5MGX
	 tdbp8xWfkDET5/K0Q9MOudj/UG0wnYtcfe6yv72g30yGOpBQWo1IVbv6RiSncgkFC5
	 Qe8yU8Gmk9OdYD7olLTVP2Qo4vur6fqrJhJgTmlA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ9ZH5kdZzb2s;
	Fri, 11 Oct 2024 17:31:03 +0200 (CEST)
Date: Fri, 11 Oct 2024 17:30:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.uu1Bieghaiwu@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwk4pYzkzydwLRV_@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
> > > > Yes, but how do you call getattr() without a path?
> > > 
> > > You don't because inode numbers are irrelevant without the path.
> > 
> > They are for kernel messages and audit logs.  Please take a look at the
> > use cases with the other patches.
> 
> It still is useless.  E.g. btrfs has duplicate inode numbers due to
> subvolumes.

At least it reflects what users see.

> 
> If you want a better pretty but not useful value just work on making
> i_ino 64-bits wide, which is long overdue.

That would require too much work for me, and this would be a pain to
backport to all stable kernels.
