Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888D310635;
	Wed, 21 Jan 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973090; cv=none; b=Z0ll9Sbrsr1175n2FcaB7yhHyPq3UOl04xN39l0BYJYIhT7jrg7kr5CkVackwaS+RtOAs0WgNV7BM5Vwu0Zj7w7Kf7rzqHt9reB0p7b7Ow+TufYpyEeiHBJSATBi0rlX1ulwISc+9cyptkHf4d4dWF8ImKcH1qi71s7na8PbBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973090; c=relaxed/simple;
	bh=PW5sLFelfzkWf2PgORncC+GbWtAqrFsD9/+V7cPhz5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDMCTH23NUisVgO9gx9IN2B5SDR6PGqrqFpOZ6wK0Zk/n0M26ajJ65PdytVmZ0Mbt6dZsFiBzEpTKtWLaRxRsl8Mw08axvNFXnFnB2q9//HwYPO3d3A6DB87fLcgNnZAmzU+dbrEYr9MbIE5tf6IwV7/LgsUP212ECG+SlvgSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=um9aPN41; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="um9aPN41"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OCm2eQjvb6FIRev++XkPgSaAW/Md7LcfwGLM6PXShk8=; b=um9aPN41QKphfu2rOzJFpy5KZ/
	mTWFurNPoG3+vlR/rhnBSanHFamd3nsemWnjmPbVa8D1j2KM2QwloxE4g2Cm8F9WmCZLC5CFoiUIL
	d+e31MhRsgjj8lz3JLF12DS7m/BjSsEIEFBA3MIDgaglomfGSiVmsVer34g3uUwtOdNWBOvLcoJk1
	Ph3/bOgkV1iWCha4jJWkTDhh/nk8ecgr3aYLKToohrji3xxVDecw53VX5Nn5/S6tAPG98iGahBoTv
	38ErYjc+HYoFVGlFiaLnUZZDzA6Hu7UmUsTA1+T5milr2QYnzopor4Xd6JKQsT/0B26SfBNJibGLz
	xx7LTzFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1viQjX-0000000F1VI-203C;
	Wed, 21 Jan 2026 05:26:23 +0000
Date: Wed, 21 Jan 2026 05:26:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 1/2] audit: Quit audit_free_names() early if name list
 empty
Message-ID: <20260121052623.GC3183987@ZenIV>
References: <20260121023509.410423-1-longman@redhat.com>
 <20260121031105.GB3183987@ZenIV>
 <84955de9-823f-4b3d-9107-f7d4aee38b88@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84955de9-823f-4b3d-9107-f7d4aee38b88@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 20, 2026 at 11:08:45PM -0500, Waiman Long wrote:
> 
> On 1/20/26 10:11 PM, Al Viro wrote:
> > On Tue, Jan 20, 2026 at 09:35:08PM -0500, Waiman Long wrote:
> > > Optimize audit_free_names() by quitting early if the name list is empty.
> > > This eliminates the need to acquire and release the fs_struct spinlock
> > > in path_put().
> > Why would path_put() go anywhere need fs_struct spinlock???
> > 
> path_put() is defined in include/linux/fs_struct.h. It calls
> read_seq{un}lock_excl(&fs->seq) which, in turn, acquires the releases the
> spinlock underneath the seqlock_t.

Really?  Which kernel would that be?  On mainline we have

; git grep -n -w path_put include/linux/fs_struct.h
; $ git grep -C 6 'void path_put\>' fs/namei.c
fs/namei.c-/**
fs/namei.c- * path_put - put a reference to a path
fs/namei.c- * @path: path to put the reference to
fs/namei.c- *
fs/namei.c- * Given a path decrement the reference count to the dentry and the vfsmount.
fs/namei.c- */
fs/namei.c:void path_put(const struct path *path)
fs/namei.c-{
fs/namei.c-     dput(path->dentry);
fs/namei.c-     mntput(path->mnt);
fs/namei.c-}
fs/namei.c-EXPORT_SYMBOL(path_put);
fs/namei.c-
;
