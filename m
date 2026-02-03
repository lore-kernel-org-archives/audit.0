Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C72BD5BD;
	Tue,  3 Feb 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161079; cv=none; b=lJp/HsMHpAEi4YcdElQ+6zbMEog1HCIYRE3H5S7mHFSS29YTEMijwHCje32YeA9trK7G1GrO073tbvgrk2rTVQafc5LSOygbs5/k5LmY9+zdDUv4JnJJ1SeBcpUTyRtu1ImT1B3TghdadLipXjHLmO9tyx/2ThqDYG1DhhQanDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161079; c=relaxed/simple;
	bh=8a9FK/P0wXppVfhH1g1y2pJc+MYG+reHV8wqFunbDEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5BtVdplGpHQni87ZA+9mIRWYBzBhcPAjbF9qVSIXZqp+n7t//2vy6lXn3MtpGqtS2UClnTCxF7+OIJITaYZWye/TrLnoSslOonhd/XZAqSDFWZLtZTim1btvKw5DunIiCteX39Z15XPlLRsTUtbRGNvXVEanhiT23ChxmQ0d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ETTk3rFs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ETTk3rFs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=+cwZylvg0T3iDQtfKqjvPKA4sXaqyusrXvmAoCVT3is=; b=ETTk3rFsi5MfAAjp1ONS1K7khf
	x/5Ol0IX+aFkCGUawNfDGQVAnM0kpY3NgwAN/hQJ9EBZk64HFVM1gyNppW6+Egj16klC6PYmWZEcY
	CV6QZe++qHeI7FhipE3Q2CzRAGujiS+VD1syZWNsQNgVqqmd2yrClXy9lDjyLX2sLeBKl8ddTeqf1
	o855n8eHcPaECg2fmtoqvUymeGQlgBMHZBN6VK75Dws7NhIjnn9ozsseBmKLEX90SvhpF4Ij3zx9e
	8N1gsgpvgPGUXvMItbK99Y0xdM6VNftJRgtaIL1pj1mHwuFJTh+CsVBSnQmi5aT5aj2Ndh6ud6E9X
	2WlfKxsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnPn0-00000001XTw-3jJf;
	Tue, 03 Feb 2026 23:26:35 +0000
Date: Tue, 3 Feb 2026 23:26:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260203232634.GJ3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203215002.GI3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 03, 2026 at 09:50:02PM +0000, Al Viro wrote:
> On Tue, Feb 03, 2026 at 03:32:04PM -0500, Waiman Long wrote:
> 
> > That is actually a concern that I have at the back of my mind. I can modify
> > the patch to cache only the dentry and do get/put the mount every time which
> > is much cheaper as it is a percpu counter.  In that way, a chdir(2) followed
> > by a umount(2) shouldn't cause a -EBUSY. Right?
> 
> Quite - it will just retain a reference to dentry, with filesystem shutdown
> being very unhappy about somebody retaining references to objects on the
> filesystem about to be taken out...

Sarcasm aside, I wonder if we could do the following trick:
	* a new primitive for "grab or borrow pwd", similar to what fdget() 
does for struct file.  If current->fs is shared, do what we do now and return
true; otherwise just copy the contents of current->fs->pwd return false.
	* paired primitive that would take a boolean + struct path * and
do path_put() if boolean is true.
	* syscalls that might alter ->fs, ->fs->pwd or add extra references to
->fs would start with grabbing an extra ref on entry and drop it in the end;
that would make that primitive safe to use there.
	* audit using that thing and storing the result along with the copy
of pwd; on the way out it would use the "put unless borrowed" primitive.

Might or might not be useful - hard to tell without knowing the job mix of those
audit-afflicted production systems.

I'll try to put something along those lines together...
