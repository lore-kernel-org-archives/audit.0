Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501532AF12;
	Wed, 13 Nov 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731539071; cv=none; b=bZPkX8apgEw5ceBnpZZVYY2BfHp/Km7x7wB3OWdmXiaI94cmf0CBvKxuijDadsimeAEWVwbj14ZnXbsssrYkVFwevfCo8gZ3Y4OGzQTTkN0lCXLvgrnshH+GnMwAvICFHzVU5oIgCSajjl9393eyZB3PSCC+s8ajoBM2ZSg4eRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731539071; c=relaxed/simple;
	bh=uR9NATavVdqBFxZjrZU/rolzN5aVtKkj87DhUnu+qvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYmYi2GH7rpyECxwI9edykFqhHaEwOWxKA64Fw5ByF9yPbjxu1cuFKq/nhSGtwP3YgLkQm0dFYNj3sY6BxRDtZtaWrRjEdF7p6ZzipC7isVyaigRJe1rFbKb7nSU+Nm3NQF2Sl2mgv/KM5O8hjMmEx8m9oOQ0SvarBtNF8bt6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eG9Qqb6b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eG9Qqb6b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ze0AbtK166ELiFcHD2qD6VO3tkL8ltMTzPW7ESfMS2I=; b=eG9Qqb6b4qVRwKx52HYWlCGQKu
	EKNAe1TNUzisKBHDy1aiDZ/rhiH45kTi4ANYu8UHm7NWUxw4bIez0/AWCrJYhLAnHuXqBOckLFNxy
	JVTOalp3dA0usILZ2AbpvZ8HzS66mMB51z1Sg6zQ9BHebEa7t0bQsYqzJFmE5jo03Aq1wSj7xhDC/
	LM/K0U5kYR6eiGuQ8om9rgMSEDZ5S4DJIWou57URgZQW8iqyJQTDyfcn/H8iA0IqdVxvJWb3GHANS
	yKdqLCnCbmLgikI85penRw5urAVNhGhuKzRLiTb0EU4zXbSssYRASXFxZLmBxSGE4tQtGAJWLuC7s
	vUfPz2Bg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBMPR-0000000EgPX-3yG9;
	Wed, 13 Nov 2024 23:04:26 +0000
Date: Wed, 13 Nov 2024 23:04:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, eparis@redhat.com, rgb@redhat.com
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in
  __audit_inode_child()
Message-ID: <20241113230425.GJ3387508@ZenIV>
References: <20241105123807.1257948-1-rrobaina@redhat.com>
 <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 11, 2024 at 05:06:43PM -0500, Paul Moore wrote:

> This is completely untested, I didn't even compile it, but what about
> something like the following?  We do add an extra strlen(), but that is
> going to be faster than the alloc/copy.
> 
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 470041c49a44..c30c2ee9fb77 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1320,10 +1320,13 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
>                 return 1;
>  
>         parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
> -       if (pathlen - parentlen != dlen)
> -               return 1;
> -
>         p = path + parentlen;
> +       pathlen = strlen(p);

Huh?  We have
        pathlen = strlen(path);
several lines prior to this.  So unless parentlen + path manages to exceed
strlen(path) (in which case your strlen() is really asking for trouble),
this is simply
	pathlen -= parentlen;

What am I missing here?  And while we are at it,
	parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
is a bloody awful way to spell
	if (parentlen == AUDIT_NAME_FULL)
		parentlen = parent_len(path);
What's more, parent_len(path) starts with *yet* *another* strlen(path),
followed by really awful crap - we trim the trailing slashes (if any),
then search for the last slash before that...  is that really worth
the chance to skip that strncmp()?


> +       if (p[pathlen - 1] == '/')
> +               pathlen--;
> +
> +       if (pathlen != dlen)
> +               return 1;
>  
>         return strncmp(p, dname->name, dlen);

... which really should've been memcmp(), at that.
