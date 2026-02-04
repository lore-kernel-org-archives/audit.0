Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1733A00C;
	Wed,  4 Feb 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186254; cv=none; b=ctAt0FrmI5COBnqQSALHOUvN0sOJTPCEh0foo3cfszI2Tb+J15Z8hJhHVbuuVzNM2VTxX63od/JrPixLVac/hax47zEhTEG4v88ibuUgMTghUwsTLsesdHwYqafS2CNKKdtIuitQpqXgu9wT/zt1F7/czRdVNBx/5Xn1yHhVlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186254; c=relaxed/simple;
	bh=1ZjEkA48XhAlXqV3JrfGzjjQxYRn8Bf0rVD3Zn5cq/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM79aeG0UlLlMEwVhr1vDFawkPHFQEkmxwYLE2aO8GIjeQALdEy6ZjjLOxJJeOSU10MgvblO2q5ZHtEQx2XEZXw+ZbxnuxBxxVXbH7/wwb82N7ASv9eb32mcNbfrgbZ0VuiNrdfnOpMfJeq/+Rl7ZiMsA7Yr1NzzS2qjOQlyBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ljejCGlT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ljejCGlT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=k2XnWdRYF3fheWBLx86eP7WPMVWuIqQQQvTxNbIZXcs=; b=ljejCGlTIH8kDDu6rI2x98NF0r
	19uPNst1vkVGe/cC/Suwtoqfh6PFcs4lXfLtxFyBDGRhSEGE5UoVC6LnYWIxmlO1E9UHcmiaxbnvn
	K9L1L1yXePMIXUZoA5kb03SJjPyN9wgAed3gFI2Pp21rlZ3KX3RCkkWkkAyd5EyLLTgN3PkyODZqi
	iChwRJAitdsM+MhjqtjtcQdlBZD8XwgWFSsJ4GeVghZnknY8ygFfkzIdrBpIi+Dp4Put73997TZIQ
	tVmvrage+T6ZqAsZWMShLhzCpRS4Z1hyyKSmZUwu71uGHlivjx/Pox3b+2s6Uz9ef2XitKbkNMN68
	i9J+BkZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnWL8-000000046dt-0Pft;
	Wed, 04 Feb 2026 06:26:14 +0000
Date: Wed, 4 Feb 2026 06:26:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260204062614.GK3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 03, 2026 at 11:21:23PM -0500, Waiman Long wrote:

> Interesting. So are you thinking about a reference on the pwd inside the
> fs_struct?

No.  fs_struct has pwd pinned - both dentry and mount.

Each thread has a reference to fs_struct instance in its task_struct (task->fs).

It is possible for several threads to have their task->fs pointing to the
same instance.

A thread may modify its fs_struct pointer, making it point to a different
fs_struct instance; that happens on unshare(2).  In that case new instance
is an identical copy of the original one; reference counts of mounts and dentries
(both for pwd and root) are incremented to account for additional references
in the copy.  That assignment to current->fs happens under task_lock(current).

A child gets either a reference to identical copy of parent's fs_struct or
an extra reference to parent's fs_struct.  In either case child->fs is
set before the child gets to run; as the matter of fact, that happens before
anyone besides the parent might observe the task_struct of child.

That's it - no other stores to task_struct.fs are ever allowed; no other
thread can change your reference under you.


Other than initializing a new copy, *all* stores to fs_struct.pwd are done
to current->fs.pwd; access to any other fs_struct instances is read-only.
The only way another thread might change your pwd is if that thread shares
fs_struct with you.  They can observe its contents, as long as they take
care to hold task_lock(your_thread), but no more than that.

What's more, if current->fs is the sole reference to fs_struct instance,
it will remain such until you spawn a child and set it to share your
instance (CLONE_FS).  No other thread can gain extra references to it,
etc.


What it means is that if you are holding the sole reference to current->fs,
current->fs->pwd contents will remain unchanged (and pinning the same mount
and dentry) through the entire syscall with very few exceptions:
	1) you spawn a child with CLONE_FS - that has to be either
clone(2) or io_uring_setup(2) (the latter - via worker threads).
	2) you explicitly modify your pwd - in chdir(2), fchdir(2),
pivot_root(2), setns(2) (with CLONE_NEWNS; it switches you to the root of
namespace you've joined)

As long as these exceptions are accounted for, audit could check
current->fs->users *and* skip incrementing refcounts if it's equal to 1.
It would need to remember whether these reference had been taken -
rechecking condition won't work, since other threads might by gone
by the time we leave the syscall turning "shared" to "not shared".

That way we can avoid grabbing any references in a fairly common
case.

> I am thinking about instead of getting a reference to pwd.dentry
> and pwd.mnt, we can just get a reference to the pwd itself. We have to grab
> the fs lock in get_fs_pwd() anyway.

HUH?  pwd is a path_struct; it has no refcount of its own.  And an
extra reference to fs_struct will not prevent modifications by other
threads that happens to share that fs_struct.

> This spinlock doesn't show up as being
> contended in the customer bug report as each process can has its own
> fs_struct instead of many processing sharing the same working directory.

<wry> I sincerely hope that you don't mean to hold current->fs->lock through the
entire syscall. </wry>

> In the case of audit, fs->pwd is copied out at the beginning of the open*
> system call and then put back at the end of that system call. So it should
> last a pretty short time, i.e. the reference will be released
> shortly. However, that will make the set_fs_pwd() call a bit tricky to
> implement, but I think it is still doable.

Huh?  You can't make fs_struct CoW, simply because if you clone a child with
CLONE_FS and do chdir() in it, it will change *your* current directory as
well (and vice versa).
