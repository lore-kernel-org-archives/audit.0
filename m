Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803635DCE3;
	Tue, 17 Feb 2026 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333939; cv=none; b=J0kyCGs34AitwfX+SCdbIgAB14c/m350NSFsfOnIee1oZX1yArwl+UrvTKPWNiNu5DQ9aZ2GmpDTMEZOf6uSCIRAS9Ab2nmn0L2h8/6E3ICWBRyXRZdqccQ+1zau/BguGBmDUqZSF/XTkIAtSnSm3gl3Wy2ihTzdK1I9iwAbaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333939; c=relaxed/simple;
	bh=QiTJi4zkweBB3YjRdYSaDULit5FD0L+noOa+GkklVf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1Uy1OF8GarjOnZwkgvnS28CiWHaUKYdLh/+sgaEHgOKATQK5cqU0kYFFB2vFJC+mZ3ZViOCs5t3nh3aoIr2REoSGW3Pc802FDzdWtT2P9u3NRjCCK9eO4KYvmwTKuVNlVOZ0wwSNTprkG1DbjBX/htdwsODFWipJyPsqMxI2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRFEAxnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRFEAxnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D5C4CEF7;
	Tue, 17 Feb 2026 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771333938;
	bh=QiTJi4zkweBB3YjRdYSaDULit5FD0L+noOa+GkklVf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRFEAxnzFGT3EGyEnj+rZXNcHiNKPYQQxuU1okufudhF6brJb/waPpu4VjHBF42mj
	 NwJms7hWGRnrDowfHZeb7yiX688fdlA581JIIh/5IPiPlAcjPcxIqumO+gdogktf3T
	 s4/ueWsi+LYlP9MWYASEDKoQ8MRdml77IOzubTvoTOBFlZ6aVuc7vHL477ZgSrfHmL
	 E21p9lBjUAjcHykk4GJaZJA6I+jBXeTgXwtx9ojnQlRexVxrf17bM6OVz9YSjlWLQ4
	 SpFkto5IJVeNHk9cgW0/nX1ohLgjv2TCb93eD9ubYK0gOXDRQg0syL4eqIfkpr6gZ5
	 NttAdPbj8lFog==
Date: Tue, 17 Feb 2026 14:12:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Waiman Long <llong@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: setns(2) vs. pivot_root(2) (was Re: [PATCH v2] audit: Avoid
 excessive dput/dget in audit_context setup and reset paths)
Message-ID: <20260217-ungnade-neuwagen-17868f57fdad@brauner>
References: <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <20260206202933.GA3183987@ZenIV>
 <20260206205804.GC3183987@ZenIV>
 <20260206210916.GD3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206210916.GD3183987@ZenIV>

On Fri, Feb 06, 2026 at 09:09:16PM +0000, Al Viro wrote:
> On Fri, Feb 06, 2026 at 08:58:04PM +0000, Al Viro wrote:
> > On Fri, Feb 06, 2026 at 08:29:33PM +0000, Al Viro wrote:
> > 
> > > Look: the case where we might get passed current->fs down there is real.
> > > It can happen in one and only one situation - CLONE_NEWNS in unshare(2)
> > > arguments *and* current->fs->users being 1.
> > > 
> > > It wouldn't suffice, since there's chroot_fs_refs() that doesn't give
> > > a rat's arse for task->fs being ours - it goes and replaces every
> > > ->fs->pwd or ->fs->root that happens to point to old_root.
> > > 
> > > It's still not a real race, though - both chroot_fs_refs() and that area
> > > in copy_mnt_ns() are serialized on namespace_sem.
> > > 
> > > And yes, it's obscenely byzantine.  It gets even worse when you consider
> > > the fact that pivot_root(2) does not break only because the refcount
> > > drops in chroot_fs_refs() are guaranteed not to reach 0 - the caller is
> > > holding its own references to old_root.{mnt,dentry} and *thar* does not
> > > get dropped until we drop namespace_sem.
> > > 
> > > IOW, that shit is actually safe, but man, has its correctness grown fucking
> > > convoluted...
> > > 
> > > Grabbing fs->seq in copy_mnt_ns() wouldn't make the things better, though -
> > > it seriously relies upon the same exclusion with chroot_fs_refs() for
> > > correctness; unless you are willing to hold it over the entire walk through
> > > the mount tree, the proof of correctness doesn't get any simpler.
> > 
> > Speaking of the race that _is_ there: pidfd setns() vs. pivot_root().
> > pivot_root() (well, chroot_fs_refs()) goes over all threads and flips their
> > ->fs->{root,pwd} for the ones that used to be at old_root.  The trouble is,
> > in case where we have setns() with more than just CLONE_NEWNS in flags, we
> > end up creating a temporary fs_struct, passing that to mntns_install() and
> > then copying its pwd and root back to the caller's if everything goes well.
> > 
> > That temporary is _not_ going to be found by chroot_fs_refs(), though, so
> > it misses the update by pivot_root().

I don't yet understand how it is substantially different from someone
holding a file descriptor to the old rootfs open and then re-fchdir()
and chroot("/proc/self/fd/<nr>)ing themselves. The main difference
surely is that during setns() it's unintentional. But the circumstances
under which this happens appear very arcane to me so I'm really
questioning whether we need to worry about setns() here. IOW, is this a
mere correctness thing or an actual bug.

Again, the scenarios where a pivot_root() happens with multiple tasks
already populating the mount namespace is very very low. So I'm fine
with just not caring about this particular thing especially if the fix
is involved. But I might be missing the actual bug here.

> BTW, in the same case of setns(2) (e.g. CLONE_NEWNS | CLONE_NEWUTS in flags)
> we end up defeating the check for fs->users == 1 in mntns_install() - for
> the temporary fs_struct it will always be true.  Unless I'm missing something
> elsewhere...  Christian?  Looks like that went in with 303cc571d107 ("nsproxy:
> attach to namespaces via pidfds")...

Sorry, just seeing that whole thread here now. No, there's no additional
checks. 
