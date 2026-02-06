Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF652E175F;
	Fri,  6 Feb 2026 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409651; cv=none; b=Jlj/zbo9IMQUrXU3seRgqjX5+I2DYJwdGIlM7cJCpDF5dJUqiidStawegrycy7Unyn2yfcP3Kh2K3Lw3vbCLDdQCpQBtjwoDSkcAJhnQB19Q8ryFHZ3tMWCQglLQhqWRdXCK4e9OQkqGLPVgpZqof5kNpvloQ7mU7UvktUkhrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409651; c=relaxed/simple;
	bh=jMmgldSoHqjJizzPBOppw3d0hY7ooQnAGTS1EJOY7x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhgBNJzcVmcyvSGwv5S+Q2We1lVWEqBYozhdsMVp4LZmqw7wQjC8NRc43JZwh3mqtDoEUPfYtfW6ZJSCTGfmwNMcrQoGpL3h2BfTljc0yQkc/I69L51iRCLDdIZSt+VBWfSeUf9idal59yReRzUWpEiiVZVgQsunIo7HFO6Qjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LO5rgoiT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LO5rgoiT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=8qSEX9Ts8AI2jxhTJ7GPMKjsWPL7fz/teYTp9DY/eog=; b=LO5rgoiTU6BRj8k/OnbTaUYmyU
	gLRkegIMYLjWFhgx1kvu6e1ccHM1zfhQxace1gSuhFANCIi9jHy8YGMaIRyoHi2Usgm7V4Kg1ATh2
	vAMcwGSr1HQ36dmXd0MTdHPex4LK2kGjRPyWBet0pl6RTKu7pvTT0ks1yHGtPLizN11Z3y0v9UkBj
	y/qJxL4ExzeIhYM6uj+Fps9SujS1Yf5u4SGKf+mA96b/tbnbOdAmdYgKQoqsgG8TzVjqfE/Gs+sJu
	5J9wKNQEbqcTQu8Ma9u6zYw3kbaWxRnvDEpoVscKNsFmtwhQ3G4tYe4XIhf7EuRSgZT+PVT7f98gM
	y8fs5LOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voSSL-00000001dxP-1cbW;
	Fri, 06 Feb 2026 20:29:33 +0000
Date: Fri, 6 Feb 2026 20:29:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206202933.GA3183987@ZenIV>
References: <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 02:16:13PM -0500, Waiman Long wrote:

> > In all cases when we get to that point, new_fs is always a freshly
> > created private copy of current->fs, not reachable from anywhere
> > other than stack frames of the callers, but the proof is not pretty.
> > copy_mnt_ns() is called only by create_new_namespaces() and it gets to
> > copying anything if and only if CLONE_NEWNS is in the flags.  So far,
> > so good.  The call in create_new_namespaces() is
> > 	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);
> 
> Thanks for the detailed explanation. After further investigation as to while
> the pwd_refs is set, I found out the code path leading to this situation is
> the unshare syscall.
> 
> __x64_sys_unshare()
>  => ksys_unshare()
>   => unshare_fs(unshare_flags, &new_fs)
>   => unshare_nsproxy_namespaces(unshare_flags, &new_nsproxy,
>                                          new_cred, new_fs);
>    => create_new_namespaces(unshare_flags, current, user_ns,
>                                          new_fs ? new_fs : current->fs);
> 
> Here, CLONE_FS isn't set in unshare_flags. So new_fs is NULL and
> current->fs is passed down to create_new_namespaces(). That is why
> pwd_refs can be set in this case. So it looks like the comment in
> copy_mnt_ns() saying that the fs_struct is private is no longer true,
> at least in this case. So changing fs_struct without taking the lock
> can lead to unexpected result.

CLONE_FS is the red herring here (it will be set earlier in ksys_unshare()
if CLONE_NEWNS is there).  I really hate that how convoluted that is,
though.

Look: the case where we might get passed current->fs down there is real.
It can happen in one and only one situation - CLONE_NEWNS in unshare(2)
arguments *and* current->fs->users being 1.

It wouldn't suffice, since there's chroot_fs_refs() that doesn't give
a rat's arse for task->fs being ours - it goes and replaces every
->fs->pwd or ->fs->root that happens to point to old_root.

It's still not a real race, though - both chroot_fs_refs() and that area
in copy_mnt_ns() are serialized on namespace_sem.

And yes, it's obscenely byzantine.  It gets even worse when you consider
the fact that pivot_root(2) does not break only because the refcount
drops in chroot_fs_refs() are guaranteed not to reach 0 - the caller is
holding its own references to old_root.{mnt,dentry} and *thar* does not
get dropped until we drop namespace_sem.

IOW, that shit is actually safe, but man, has its correctness grown fucking
convoluted...

Grabbing fs->seq in copy_mnt_ns() wouldn't make the things better, though -
it seriously relies upon the same exclusion with chroot_fs_refs() for
correctness; unless you are willing to hold it over the entire walk through
the mount tree, the proof of correctness doesn't get any simpler.
