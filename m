Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F830C35D;
	Fri,  6 Feb 2026 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411361; cv=none; b=iehABvWk/Z7q9YD60D+NIG6Z+OboizzoMePyN3wfTmLSlkLZjZC+F4JFQh2RTW5ZCVx3xme/FcxEfSbU7OgbuYrZ0fHrNw34YAU7Z0TX7Ij709lsV3eiWyLBHlCylOTgtUKr1gutnjdY08Ahq8gcrTVlDNpJVD0jQ8tsEgWFmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411361; c=relaxed/simple;
	bh=JFR85/+anUN2fT6fCXjc1yJoQceCdSnrdUhql1bhsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VirY/7t4ElHYrxItZ+33GroV6MxG5R/Z65IjpL7kdKtBpHp0q+JtocSE7ZTAC2WOqkmWCjjtVr855+gCuSVQ8VtyK+55db296+0O8KmWFNgUycHrkzQRdWKAuuZJfbayFuvy9awsa9RE0eHZD6BfBvLdtWgzPOb0Q8f3IEHrWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hOlr8/Ww; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hOlr8/Ww"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CphMeoyn3AnZjndCpK55nx5/OTuSf1YvZjJuSy9m9K0=; b=hOlr8/WwZHh/W+tpyF0BL5Fuyj
	vBUAvw1rXqKPj1WGQVAhIFXam+Cl3US+e4M1CZnHXWTFA5a06TEQZKZ1OqivJtU23X9tC6d99/1xu
	xbA3mkigNK6lpVkRRmjq7J0CIwGSwD7tYYjX0DbEVmq8R4UmrhWMHjRpyr7LUEoVXs6+WUEDiA+Yb
	PUpf7S1luiPebb7aEOC1ZVf0mJg9zvVnODSjChphpzq5+qLqL/55Gk1vp7caW9jv5Y6W86dX8iIf4
	Ljnwjg8lR1eQ4E+kXE4aThvphAbhplGM54PQvWdpsuUNtP0pehjj19M0+RPYAZX4O3+e8RG9xz+HQ
	HbBNTdtw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voStx-00000001h8p-01IX;
	Fri, 06 Feb 2026 20:58:05 +0000
Date: Fri, 6 Feb 2026 20:58:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: setns(2) vs. pivot_root(2) (was Re: [PATCH v2] audit: Avoid
 excessive dput/dget in audit_context setup and reset paths)
Message-ID: <20260206205804.GC3183987@ZenIV>
References: <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <20260206202933.GA3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206202933.GA3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 08:29:33PM +0000, Al Viro wrote:

> Look: the case where we might get passed current->fs down there is real.
> It can happen in one and only one situation - CLONE_NEWNS in unshare(2)
> arguments *and* current->fs->users being 1.
> 
> It wouldn't suffice, since there's chroot_fs_refs() that doesn't give
> a rat's arse for task->fs being ours - it goes and replaces every
> ->fs->pwd or ->fs->root that happens to point to old_root.
> 
> It's still not a real race, though - both chroot_fs_refs() and that area
> in copy_mnt_ns() are serialized on namespace_sem.
> 
> And yes, it's obscenely byzantine.  It gets even worse when you consider
> the fact that pivot_root(2) does not break only because the refcount
> drops in chroot_fs_refs() are guaranteed not to reach 0 - the caller is
> holding its own references to old_root.{mnt,dentry} and *thar* does not
> get dropped until we drop namespace_sem.
> 
> IOW, that shit is actually safe, but man, has its correctness grown fucking
> convoluted...
> 
> Grabbing fs->seq in copy_mnt_ns() wouldn't make the things better, though -
> it seriously relies upon the same exclusion with chroot_fs_refs() for
> correctness; unless you are willing to hold it over the entire walk through
> the mount tree, the proof of correctness doesn't get any simpler.

Speaking of the race that _is_ there: pidfd setns() vs. pivot_root().
pivot_root() (well, chroot_fs_refs()) goes over all threads and flips their
->fs->{root,pwd} for the ones that used to be at old_root.  The trouble is,
in case where we have setns() with more than just CLONE_NEWNS in flags, we
end up creating a temporary fs_struct, passing that to mntns_install() and
then copying its pwd and root back to the caller's if everything goes well.

That temporary is _not_ going to be found by chroot_fs_refs(), though, so
it misses the update by pivot_root().
