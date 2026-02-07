Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817721D599;
	Sat,  7 Feb 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452604; cv=none; b=om6Tfelq7JHKqyS1Nd6gWq72I/ChEeITrama/XmQx6AVTtMzbzvSgNAluN4oOi1Tb1hi3IEtHIAGRojKHK7BRMOEEQ8t35BhGpfED8XSETPWFXNJk1cVQoySNAx71i+j1VKZQO/Va1GQY9xoSNgDh2xoOdKcwxyJisphTzn+Hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452604; c=relaxed/simple;
	bh=6p8ki8g86OjJe/JJ+E7lSrSzWLr03tXrxn/pjRDrueM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opc2wWqwZxlMZZSEF+BQia1jxCU5QGNe2JEzmGoRouf/RK+CzkgUqykTaXktAdq3u8eEjBAItgRhWZobBn/1C5wuZnVyJYmBKxZnL1VWZLf+ItIujElA98pvLRxiynWCb0F4UeZEwZyNk9mAkw4kn5iDuYy/cYWfulxsbLzPzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NStHtr+a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NStHtr+a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qEjtORmwh6ICYPd76LyX5/IPP5UoSBxJuAlU6jcvkjY=; b=NStHtr+avMepKYRluBEe7DggN6
	6Imdzbqo7B0E8181eqlbSL9mf0rQMS4+mRBWjcCh8z9zNS33//WAFO7ukzY4JC0S7+ZJVFs+pFpI2
	w/EUneiFS1gnSEx5LY35wo8dY9nTyo+cM+TpYOp/eyvvKQTm4B5Ef5szUiFNeeoRFt1nmUjpz/RQw
	GfixRMmMOUXfP31ab8B4Hon59J5WuPLsxh6KiDHLNMi43MCbkZex6povsgjbhao0GCSzzdwhEJiIi
	QDB+5xpDr+Hk0SjvsyE4IfLHPPlDobnqin42yndBHqKuxKXGvcglkudk46d9FC2ksodyK5ohew3fw
	0HQbdFTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vodd6-00000008atA-3vRV;
	Sat, 07 Feb 2026 08:25:26 +0000
Date: Sat, 7 Feb 2026 08:25:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <llong@redhat.com>
Subject: [PATCH][RFC] bug in unshare(2) failure recovery
Message-ID: <20260207082524.GE3183987@ZenIV>
References: <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <9bc83901-3819-4cf1-a1ba-cc2f52f53504@redhat.com>
 <5cb07c57-9dca-4086-af88-f866f765c7fb@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb07c57-9dca-4086-af88-f866f765c7fb@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 03:04:53PM -0500, Waiman Long wrote:

[summary of subthread: there's an unpleasant corner case in unshare(2),
when we have a CLONE_NEWNS in flags and current->fs hadn't been shared
at all; in that case copy_mnt_ns() gets passed current->fs instead of
a private copy, which causes interesting warts in proof of correctness]

> I guess if private means fs->users == 1, the condition could still be true.

Unfortunately, it's worse than just a convoluted proof of correctness.
Consider the case when we have CLONE_NEWCGROUP in addition to CLONE_NEWNS
(and current->fs->users == 1).

We pass current->fs to copy_mnt_ns(), all right.  Suppose it succeeds and
flips current->fs->{pwd,root} to corresponding locations in the new namespace.
Now we proceed to copy_cgroup_ns(), which fails (e.g. with -ENOMEM).
We call put_mnt_ns() on the namespace created by copy_mnt_ns(), it's
destroyed and its mount tree is dissolved, but...  current->fs->root and
current->fs->pwd are both left pointing to now detached mounts.

They are pinning those, so it's not a UAF, but it leaves the calling
process with unshare(2) failing with -ENOMEM _and_ leaving it with
pwd and root on detached isolated mounts.  The last part is clearly a bug.

There is other fun related to that mess (races with pivot_root(), including
the one between pivot_root() and fork(), of all things), but this one
is easy to isolate and fix - treat CLONE_NEWNS as "allocate a new
fs_struct even if it hadn't been shared in the first place".  Sure, we could
go for something like "if both CLONE_NEWNS *and* one of the things that might
end up failing after copy_mnt_ns() call in create_new_namespaces() are set,
force allocation of new fs_struct", but let's keep it simple - the cost
of copy_fs_struct() is trivial.

Another benefit is that copy_mnt_ns() with CLONE_NEWNS *always* gets
a freshly allocated fs_struct, yet to be attached to anything.  That
seriously simplifies the analysis...

FWIW, that bug had been there since the introduction of unshare(2) ;-/

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..68ccbaea7398 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3082,7 +3082,7 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 		return 0;
 
 	/* don't need lock here; in the worst case we'll do useless copy */
-	if (fs->users == 1)
+	if (!(unshare_flags & CLONE_NEWNS) && fs->users == 1)
 		return 0;
 
 	*new_fsp = copy_fs_struct(fs);
