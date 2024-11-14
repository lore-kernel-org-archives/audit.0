Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8413D53E;
	Thu, 14 Nov 2024 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557393; cv=none; b=loW8uN1ydohos/JfEikDK+LQ2CodR/6UUJaQYp0zJ4A+6q8fz7PjakPUc8FlqHa4qdYD/mLGk7BZf8SsKWr6HrVM19EAq5JMf2ZNflQf28+cg0UvARUWujwnCKdCdQrrxqnJ7rO3/Cx2Bdf/LhZbqi890GboNdDhMjggOlgulJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557393; c=relaxed/simple;
	bh=5I4vNI7ezrDm6Sctj4+VCmNzhsOtZTrWrECDkKxcRmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTgBGjcsUjcY4I1hlQL1fmNrfTzmwECwx3RrYN3h73SAuzbAkyneqeZqW9Frt5TGa2wjXp7LmfNEJAsGzhhONViw8ZaYMMqEW6GpHazJwvd4Tn6ETgiwL0ULday0/vBhPpjhPkhBxAQyVjirRYSAYasflUvrJ2uiPSLPb78AdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wsNZ6xUI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wsNZ6xUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S1GxM8IiUiT5x4KujkgQywaLGjoplrnynAOlm4LVcMQ=; b=wsNZ6xUISD4zg5yocAqKayCyq+
	7OZrsmQreaT+OZbzq5/o2alQSZZGv7c6XdjScI9tzS4wtR8sARmcexCojXUMJe6neBkSH3L+DzLpq
	hZeP2OQmwXDJ6VtaRY0XFnmtKzlYjulCNbHTFuYmZ63m0EBR5MMGiokGN3x52xgCWw1nOVzX72QJ+
	wjDZkp77JOWUoz/03GjPAiZxY0FMc7AD0NlvtmCXgf2F3XCMAxKSKzvUboNpNm8z8E33DEycqv7yw
	2WdlvNlyQZf8S8xVLd7s4OcUeom6oVMNPxqZ+m7mu1fYkGvMs34M5tQFBPb9jXraIZxY4Api/Cx5Y
	rdCwgF5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBRAy-0000000Elgd-0UHI;
	Thu, 14 Nov 2024 04:09:48 +0000
Date: Thu, 14 Nov 2024 04:09:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, eparis@redhat.com, rgb@redhat.com
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in
 __audit_inode_child()
Message-ID: <20241114040948.GK3387508@ZenIV>
References: <20241105123807.1257948-1-rrobaina@redhat.com>
 <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
 <20241113230425.GJ3387508@ZenIV>
 <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 13, 2024 at 10:23:55PM -0500, Paul Moore wrote:

> > And while we are at it,
> > parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
> > is a bloody awful way to spell
> > if (parentlen == AUDIT_NAME_FULL)
> >  parentlen = parent_len(path);
> > What's more, parent_len(path) starts with *yet* *another* strlen(path),
> > followed by really awful crap - we trim the trailing slashes (if any),
> > then search for the last slash before that...  is that really worth
> > the chance to skip that strncmp()?
> 
> Pretty much all of the audit code is awkward at best Al, you should know
> that.

Do I ever...

> We're not going to fix it all in one patch, and considering the nature
> of this patch effort, I think there is going to be a lot of value in keeping
> the initial fix patch to a minimum to ease backporting.  We can improve on
> some of those other issues in a second patch or at a later time.
> 
> As a reminder to everyone, patches are always welcome.  Fixing things is a
> great way to channel disgust into something much more useful.

> > 
> > > +       if (p[pathlen - 1] == '/')
> > > +               pathlen--;
> > > +
> > > +       if (pathlen != dlen)
> > > +               return 1;
> > > 
> > > return strncmp(p, dname->name, dlen);
> > 
> > ... which really should've been memcmp(), at that.
> 
> Agreed. See above.

OK, my primary interest here is to separate struct filename from that stuff
as much as possible.  So we will end up stomping on the same ground for
a while here.  FWIW, my current filename-related pile is in #next.filename;
there will be a lot more on the VFS side, but one of the obvious targets is
->aname, so __audit_inode() and its vicinity will get affected.  We'll need
to coordinate that stuff.

Anyway, regarding audit_compare_dname_path(), handling just the last '/' is
not enough - there might be any number of trailing slashes, not just one.

Another fun issue with looking for matches is this:

mkdir /tmp/foo
mkdir /tmp/foo/bar
mkdir /tmp/blah
ln -s ../foo/bar/baz /tmp/blah/barf
echo crap > /tmp/blah/barf

The last one will create a regular file "baz" in /tmp/foo/bar and write
"crap\n" into it.  With the only pathname passed to open(2) being
"/tmp/blah/barf".  And there may be a longer chain of symlinks like that.

What do you want to see reported in such case?
