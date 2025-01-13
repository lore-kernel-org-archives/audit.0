Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812820F08A
	for <audit@vger.kernel.org>; Mon, 13 Jan 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787319; cv=none; b=DKfr8YihC9dGz5d4rTCLdtrjKYKvd/AirMxb2yTjxpkP6BBWmZmGhaUoZJR0VcF7utvthglo+DAdIcYMb+X5WfurdFIW80PRJ0SSOzekBLKP0UCQzqyy9LZVNgRPI+ExegOtQVQhe3aFfWcFIQ3mIzO1+ILvGZYx9sQ+FE+8DyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787319; c=relaxed/simple;
	bh=qLUCj4+v855t1YCsjLrlfp+4wroedCeIDxAO6+kNeNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvGeSVYG9zIDPILQj765VFc6kZ5jKoVslO7jS9+rqvZYu8Nwo19i7dwc+CMD/1NiuOVvXNaWDe1ZfftFcV1osuuXqcfyF4NoxaI2/9/mv6xhz8Yi5WxSgLpkS0f9ympXaegJyeh31D7QgdPlbD9P5UOLZAcJRLNTDIEEzsr9m3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Kdzdi8Ee; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Kdzdi8Ee"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWyzv5R7jzVS;
	Mon, 13 Jan 2025 17:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736787307;
	bh=B0Ctjno6Rr2OrapklIDpFZARF75CzMPd8IbhzPZudUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kdzdi8EeZvscWAObVwVYzuWFGMLvRgpTuGhCplp/frWilFt/qRcAzOCwtlQAmIbyz
	 ScTf2xjH2xlQPJw+qIYQOrgFY77YkiARzrFaIIs2VTMuq9lm/ynOX2kHLoubIY/4Az
	 TTX5v24BKPPMOnneStPwX23pKcj2ie9uc8zEeoew=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWyzs6k6vzVkL;
	Mon, 13 Jan 2025 17:55:05 +0100 (CET)
Date: Mon, 13 Jan 2025 17:55:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY
 rule type
Message-ID: <20250113.sicai7phooXe@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-29-mic@digikod.net>
 <CAG48ez3oTpoVH=en8yAwS2u=kuyh8rKqPQFjDCe_Muh7N9E_Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3oTpoVH=en8yAwS2u=kuyh8rKqPQFjDCe_Muh7N9E_Tg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jan 13, 2025 at 03:55:42PM +0100, Jann Horn wrote:
> +Christian and Al Viro to double-check what I'm saying
> 
> On Wed, Jan 8, 2025 at 4:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > -static const void *get_current_exe(const char **path_str, size_t *path_size)
> > +static const void *get_current_exe(const char **path_str, size_t *path_size,
> > +                                  struct inode **inode)
> >  {
> >         struct mm_struct *mm = current->mm;
> >         struct file *file __free(fput) = NULL;
> > @@ -93,6 +96,8 @@ static const void *get_current_exe(const char **path_str, size_t *path_size)
> >
> >         *path_size = size;
> >         *path_str = path;
> > +       ihold(file_inode(file));
> > +       *inode = file_inode(file);
> >         return no_free_ptr(buffer);
> >  }
> 
> This looks unsafe: Once the reference to the file has been dropped
> (which happens implicitly on return from get_current_exe()), nothing
> holds a reference on the mount point or superblock anymore (the file
> was previously holding a reference to the mount point through
> ->f_path.mnt), and so the superblock can be torn down and freed. But
> the reference to the inode lives longer and is only cleaned up on
> return from the caller get_current_details().
> 
> So I think this code can hit the error check for "Busy inodes after
> unmount" in generic_shutdown_super(), which indicates that in theory,
> use-after-free can occur.
> 
> For context, here are two older kernel security issues that also
> involved superblock UAF due to assuming that it's possible to just
> hold refcounted references to inodes:
> 
> https://project-zero.issues.chromium.org/42451116
> https://project-zero.issues.chromium.org/379667898

Thanks for the detailed explanation!

> 
> For fixing this, one option would be to copy the entire "struct path"
> (which holds references on both the mount point and the inode) instead
> of just copying the inode pointer.

Yes, I'll do that.
