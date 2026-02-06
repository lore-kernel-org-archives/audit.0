Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D623EAAF;
	Fri,  6 Feb 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412033; cv=none; b=E1/s+pSFhPR2P/JWChVIjF/sZ5M5arI5UyWJRfkSzeSnUH7wPgHtkxfCZrdFbAsZE25CpDRUfK2qEifwEcwvDfofjQMaGsdj2H1b60tJMcWNs51pIAbMlvVXbcGZb0Fusp55JVgTJSzHzi9qwuz1Tj1RY/XOezfg9eOEok90Tu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412033; c=relaxed/simple;
	bh=YomsokXQxhZCrQhS35LPKxpITFDBq+r2ioovXHwceTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovq2lgC7vil+9unDGT2dc5pjxIgyx+WqYATLvKaS0LwmqfYiCCyBcOOS70/M6l1ShfqYx5IjhNzjUwALdcEgT366rh1wlRdfzFr0qwqNUNxRKgvn6jr6RLIeIy5Ym0bevsDoKKnxdwUK+GeqS5OJOX6xPRWkj2qoqCoO5Hr65j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I3C/HVvl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I3C/HVvl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lOcZF7fcn0EhmXyYyMjl2h7kKc3N6YZDO1s4+QbLWhU=; b=I3C/HVvlNZdIOzh3+tJgR4S8on
	wYtyXwh07CMhcgZZdQ5oN1/0o3U3rUfLVFPkkjMcyj7eTmAvsz4x0xjVvng11tnMkXyfS47yctorq
	0u1/4X18v7qWaMt9W7vgE1kIWBwRJ3P2LzoXf5aEcMSUO2DIxMSAxtOjiitkKIqcVz6pdFw+Ts8/B
	KxXzPc5pE+ptoUTXnuDG77IkhWLFu4SLZU+pQk/jXuLBBVyXUuNYm/KJFD4gNMAvXNRTrvzDbstuu
	p30/3ngKRDLeC46b80SzJ56w63ICV8ne1P4dXXfVmyXZ0PQmjG9KuuNYFhxWPNvkUYZ7cMujEA7AI
	iFqStWnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voT4m-00000001isU-1S8g;
	Fri, 06 Feb 2026 21:09:16 +0000
Date: Fri, 6 Feb 2026 21:09:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: setns(2) vs. pivot_root(2) (was Re: [PATCH v2] audit: Avoid
 excessive dput/dget in audit_context setup and reset paths)
Message-ID: <20260206210916.GD3183987@ZenIV>
References: <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <20260206202933.GA3183987@ZenIV>
 <20260206205804.GC3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206205804.GC3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 08:58:04PM +0000, Al Viro wrote:
> On Fri, Feb 06, 2026 at 08:29:33PM +0000, Al Viro wrote:
> 
> > Look: the case where we might get passed current->fs down there is real.
> > It can happen in one and only one situation - CLONE_NEWNS in unshare(2)
> > arguments *and* current->fs->users being 1.
> > 
> > It wouldn't suffice, since there's chroot_fs_refs() that doesn't give
> > a rat's arse for task->fs being ours - it goes and replaces every
> > ->fs->pwd or ->fs->root that happens to point to old_root.
> > 
> > It's still not a real race, though - both chroot_fs_refs() and that area
> > in copy_mnt_ns() are serialized on namespace_sem.
> > 
> > And yes, it's obscenely byzantine.  It gets even worse when you consider
> > the fact that pivot_root(2) does not break only because the refcount
> > drops in chroot_fs_refs() are guaranteed not to reach 0 - the caller is
> > holding its own references to old_root.{mnt,dentry} and *thar* does not
> > get dropped until we drop namespace_sem.
> > 
> > IOW, that shit is actually safe, but man, has its correctness grown fucking
> > convoluted...
> > 
> > Grabbing fs->seq in copy_mnt_ns() wouldn't make the things better, though -
> > it seriously relies upon the same exclusion with chroot_fs_refs() for
> > correctness; unless you are willing to hold it over the entire walk through
> > the mount tree, the proof of correctness doesn't get any simpler.
> 
> Speaking of the race that _is_ there: pidfd setns() vs. pivot_root().
> pivot_root() (well, chroot_fs_refs()) goes over all threads and flips their
> ->fs->{root,pwd} for the ones that used to be at old_root.  The trouble is,
> in case where we have setns() with more than just CLONE_NEWNS in flags, we
> end up creating a temporary fs_struct, passing that to mntns_install() and
> then copying its pwd and root back to the caller's if everything goes well.
> 
> That temporary is _not_ going to be found by chroot_fs_refs(), though, so
> it misses the update by pivot_root().

BTW, in the same case of setns(2) (e.g. CLONE_NEWNS | CLONE_NEWUTS in flags)
we end up defeating the check for fs->users == 1 in mntns_install() - for
the temporary fs_struct it will always be true.  Unless I'm missing something
elsewhere...  Christian?  Looks like that went in with 303cc571d107 ("nsproxy:
attach to namespaces via pidfds")...

