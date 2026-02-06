Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190F2DA776;
	Fri,  6 Feb 2026 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359363; cv=none; b=UTDMwiyxTMGr/9Borak48P6WesOzNaHoP1lkm6EStmVHz/HgWVwA/nvkCk7r7wsYi+AwAPN9IyLuejJMXRYKFO9J59uuDsOYcP9kZxFwlS/BOx/ZGIMkxnlu+EZ+jZDuqrPCXBQu12F+l76YSt3fe6/tBTFkLauuzIoRBRf/v00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359363; c=relaxed/simple;
	bh=d8PHGnI5cfcqtwToMioYnrBQLi41m/B4Q4vGI1ev1eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9dpCgWpvl0NPZavDglCOenBKwdjCIlAQ3GPaoyS/izXqzXrEtwCQZNT1TnK991Rf/lqBpg7PwUPY/GGlUVqR+tqU9VWA0yF2xVT4SmRBHOJj/BBhGZvy6LsI8gCQSWV6lDrUpURLoAh/1CmQT//RN1LoCj/xoxNsYdAfJT5HHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Oxt2Xq2d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Oxt2Xq2d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=lFByEc584Sun+jPTyxTBsCvU9XH3HwMVfRKiQZ3E1u4=; b=Oxt2Xq2dEYEANXpToS0pRHFJ6f
	ynDCFpzI4dfJHFqoevtGfzYRVPNginUtN3fZw+7U4ck1Bz9rbZnV2uWUso1oOAFXGHZWic1XL14VE
	1qhtlaJXWmvMzk5x/NM0y62txPSAe9I5orVN3dIgHaMcNNz2HleJCxpWHQ5Hsc8JDv7T8OFS6b8P/
	m2rYVtQJGhaI1+aRiMf11zUWPjPSZYpTV4SpgL8D7/9uG2ackcOkBeAzXj3iEphJ94OAyBiWDtY2T
	4jpmtIiZMnXHUa5nLa6/l2kjgOAsxE4kYNQsXzzCNKFa5udNY2N+LNLdkpzquSGKZtZ+ifJMtLzFr
	7QwtP/Qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voFNE-0000000BnOS-3NK5;
	Fri, 06 Feb 2026 06:31:25 +0000
Date: Fri, 6 Feb 2026 06:31:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206063124.GW3183987@ZenIV>
References: <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206052218.GV3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 05:22:18AM +0000, Al Viro wrote:
> On Thu, Feb 05, 2026 at 11:11:51PM -0500, Waiman Long wrote:
> 
> > __latent_entropy
> > struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
> >                 struct user_namespace *user_ns, struct fs_struct *new_fs)
> > {
> >   :
> >                 if (new_fs) {
> >                         if (&p->mnt == new_fs->root.mnt) {
> >                                 new_fs->root.mnt = mntget(&q->mnt);
> >                                 rootmnt = &p->mnt;
> >                         }
> >                         if (&p->mnt == new_fs->pwd.mnt) {
> >                                 new_fs->pwd.mnt = mntget(&q->mnt);
> >                                 pwdmnt = &p->mnt;
> >                         }
> >                 }
> > 
> > It is replacing the fs->pwd.mnt with a new one while pwd_refs is 1. I can
> > make this work with the new fs_struct field. I do have one question though.
> > Do we need to acquire write_seqlock(&new_fs->seq) if we are changing root or
> > pwd here or if the new_fs are in such a state that it will never change when
> > this copying operation is in progress?
> 
> In all cases when we get to that point, new_fs is always a freshly
> created private copy of current->fs, not reachable from anywhere
> other than stack frames of the callers, but the proof is not pretty.
> copy_mnt_ns() is called only by create_new_namespaces() and it gets to
> copying anything if and only if CLONE_NEWNS is in the flags.  So far,
> so good.  The call in create_new_namespaces() is
> 	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);
> and both flags and new_fs come straight from create_new_namespaces()
> callers.  There are 3 of those:
> 1) int copy_namespaces(u64 flags, struct task_struct *tsk):
> 	new_ns = create_new_namespaces(flags, tsk, user_ns, tsk->fs);
> That gets called by copy_process(), with tsk being the child we are
> creating there.  tsk->fs is set a bit earlier, by copy_fs() call - either
> to extra ref to current->fs (when CLONE_FS is present in flags) or to
> a private copy thereof.  Since in the very beginning of copy_process()
> we have
> 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
> 		return ERR_PTR(-EINVAL);
> and we are interested in case when CLONE_NEWNS is set, tsk->fs is going
> to be a private copy.
> 
> 2) int unshare_nsproxy_namespaces(unsigned long unshare_flags,
> 	struct nsproxy **new_nsp, struct cred *new_cred, struct fs_struct *new_fs):
>         *new_nsp = create_new_namespaces(unshare_flags, current, user_ns,
> 					 new_fs ? new_fs : current->fs);
> That gets called from ksys_unshare().  Earlier in ksys_unshare() we have
>         /*
> 	 * If unsharing namespace, must also unshare filesystem information.
> 	 */
> 	if (unshare_flags & CLONE_NEWNS)
> 		unshare_flags |= CLONE_FS;
> so in our case CLONE_FS is going to be set.  new_fs is initially set
> to NULL and, since CLONE_FS is there, the call of unshare_fs() has
> replaced it with a reference to private copy of current->fs.  Again,
> we get a private copy.
> 
> 3) int exec_task_namespaces(void):
>         new = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
> No CLONE_NEWNS in flags, so we don't get there at all.
> 
> Incidentally, one bogosity I've spotted in unshare_fs() today is
>         if (!(unshare_flags & CLONE_FS) || !fs)
> 					^^^^^^ this
> 		return 0;
> 
> The history is amusing - it had been faithfully preserved since
> cf2e340f4249 ("[PATCH] unshare system call -v5: system call handler
> function") back in 2006, when unshare(2) had been added; initially it
> had been a stub:
> +static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
> +{
> +       struct fs_struct *fs = current->fs;
> +
> +       if ((unshare_flags & CLONE_FS) &&
> +           (fs && atomic_read(&fs->count) > 1))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> 
> The thing is, task->fs does not become NULL until exit_fs() clears it, at
> which point we'd better *not* run into any syscalls, unshare(2) included
> ;-) The same had been true back in 2006; as the matter of fact, I don't
> know if it _ever_ had not been true.  I suspect that the logics had been
> copied from exit_fs(), which also has a pointless check that seems to have
> been added there in 1.3.26, when task->fs went kmalloc'ed.  The thing
> is, in 1.3.26 copy_fs() a failed allocation aborted do_fork() (today's
> copy_process()) with exit_fs() never called for the child-not-to-be...

Actually, now I remember - until 2.5.<early> we used to have kernel threads
that did exit_fs() and normally followed that by manual switch to extra
reference to init_task.fs.  Mostly - by calling daemonize(), some - manually;
there had been some (mtdblock definitely among those, might be more) that
didn't bother with the second part.

The upshot had been that we could get transient task->fs switching to
NULL and then back to &init_fs (that could happen only to kernel threads)
and some of those didn't bother to switch back to non-NULL.

None of that had ever been relevant for unshare(2); the last remnants
of that bogosity went away in 2009 when we got task_lock(current) over
all changes of current->fs, with NULL never being stored there for
as long as the thread remains alive.

Mea culpa - mnt_copy_ns() (all way back to 2001, when it had been
added as copy_namespace()) is in the same boat as unshare(2); none
of those kernel threads would ever spawn a new namespace, let alone
doing that right in the middle between exit_fs() and setting ->fs
to &init_task.fs.  Which is to say, that
	if (new_fs) {
in there had always been just as bogus - condition is never false ;-/
