Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9B329E76;
	Fri,  6 Feb 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365598; cv=none; b=HWmtoMokTasbHco8DOOhLE22yM2pvFukBTGrsjm2NPy35KYC9DqwTd5BBz/3pbfRdFpD+/PcQGE96euoEpSW378W0bGCxaPjXNzcSjRNug9z1uxPPiSHFvsMc50sjuogiLy4GbEIZpAdj6IYyGpdjchivdTCaII3KepI0gyc6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365598; c=relaxed/simple;
	bh=QXraXYJ1WOJf/BOkkCK5e/CSWUaO1sFl/O3grFVb+UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMnJ5ISxBbo/3AnIcCc/as48izB0uKFHcfbgwUkXWoIPM4Zj9Pk25Zll87pIumXcoSI31PTtK4u3h7/g982S8TnKqZsTKOObAkef77vYQhgQpFVTn7nHe9utSzGmixnHluZwb4IP7kZWbyxM5aa/ZjtLWFimnkT57vO239t0OY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jfyaB09g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jfyaB09g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=tOFgNLj9BeKyp82ViD9mWSoSssHOp6N0lXjehKkov7I=; b=jfyaB09gcTLQ9XQyWLllTqQ4t6
	pY1p05FD9i/vHupfUHTDbl/IkxRZ1taSne4ugIv2hlZbiIV5Xd7UmCRqOGvywMJ5URXeC9YVdtFoo
	VnQ7xR6PouOVuT48TyCbClGPADnmziIxnbTjqedNJXLKXkNMn+OlFwoHjxutZCEI+QXTE2d+s8Fkg
	iWYBOk9cXLPC4807WkPkScTjiNlYJFImotGgbDEDw0sPvNkyxlwn9t9pfqA/N4qEz69AcIMDAWHUq
	7J6p6Udp74Y4i3M8RkLLE2CaDLX8LUGYX2+FuRa15eUpXkHCXxFJn8W1uJIteyPLi40WYBOoESHMo
	Rc7sf/Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voGzm-0000000DReC-3d7p;
	Fri, 06 Feb 2026 08:15:19 +0000
Date: Fri, 6 Feb 2026 08:15:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206081518.GZ3183987@ZenIV>
References: <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205235351.GU3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 05, 2026 at 11:53:51PM +0000, Al Viro wrote:
> On Wed, Feb 04, 2026 at 11:45:17PM -0500, Waiman Long wrote:
> 
> > @@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, const
> > struct>
> >                                 count++;
> >                                 path_get(new_root);
> >                         }
> > +                       count += fs->pwd_xrefs;
> > +                       fs->pwd_xrefs = 0;
> >                         write_sequnlock(&fs->seq);
> 
> Nope - you only need that for threads that have ->pwd equal to old_root.
> Incidentally, I'd forgotten about that sucker - it kills the idea of
> fdget-like tricks dead, more's the pity.  Third-party modification of
> task->fs->pwd (under task->lock and task->fs->seq), possible even with
> task->fs->users == 1.
> 
> FWIW, I'm going through the fs_struct uses at the moment; will post
> whatever I get when I go down (or earlier, in the unlikely case it doesn't
> spill to tomorrow morning), will keep posting incremental followups
> until the documentation is done.  I'm sick and tired of half-finished
> docs - let's see if I can push through that one this way ;-/
> 

All right, I'm going down - it's 3am here; the current notes are at
http://ftp.linux.org.uk/people/viro/fs_struct, will update when I get
up tomorrow^Wtoday.
