Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280D2C3255;
	Thu,  5 Feb 2026 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335509; cv=none; b=rG1TLBc9JHpPdkzzNwuGdDYjzGa1jNU/mRGR1tzzO8P8sBoRLJ+q5v3x9lVM1B6ttvAZ4dm2UHefZ2yCaC8uXWPZRD/xd5cZNoLsJrt95+1GFYt6Tj/9QGwAhq3z6a7Xfcx4pC65i3KC54gG3VEqL2a5VS0enZhaFpXJroFGGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335509; c=relaxed/simple;
	bh=02q3IlVyOg3Kg6TGJ3a6C2JfjZfhQPzuyrJCtzsGOvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh1xwXpCgCKRyiH9PUFql8fqSCIb13/XZIbquAriKdOaPmPc9LCMUHB8P/oRdpucTasSxoRM2GjyIQTr9Y0mnrTKy13y/fONfddmcjZY+NPLp0PujEkRKikff9Fav311SkHN3M7ISk/i9fnhJ6Xh9IKY1Ve0/uaetuttJ3DwBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JlRhNDTE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JlRhNDTE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=BmbtPLiomNnXFMKvIx77pyI+/mJDQedvXWSk0YkiuF4=; b=JlRhNDTEESmmM36XaMmO8/7xFw
	bp4PQ65ouXKWl6w1qbzO1Pkt5yDYdYSyx8iSpByWa+4msRz/NoGEY8XK9j3V7e345MNcuV0Hzh9pb
	vlzxarXG8RwC23gGmF3z8IbLK/0yiVAH/kweLK2VdcklUFgzCGIQepfCkTrEkKQTDCqrzvBt+5R/+
	m2zUS/JJv3O0qBZIGPXhfZdTckgZyScJMqa0XM/HbBu8sBdL5g3XwiTQ0rR7kWaeKBMlzuNxnq4Lu
	cibKpjwaAXcETCCdEJEhFkoTGEMoxrIMtDq1XCcvuF+ikLYND24clnbvxypf1L8X+cYKLwQ5tskB6
	yo1FsOfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vo9AV-00000006iPX-0pcD;
	Thu, 05 Feb 2026 23:53:51 +0000
Date: Thu, 5 Feb 2026 23:53:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260205235351.GU3183987@ZenIV>
References: <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 04, 2026 at 11:45:17PM -0500, Waiman Long wrote:

> @@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, const
> struct>
>                                 count++;
>                                 path_get(new_root);
>                         }
> +                       count += fs->pwd_xrefs;
> +                       fs->pwd_xrefs = 0;
>                         write_sequnlock(&fs->seq);

Nope - you only need that for threads that have ->pwd equal to old_root.
Incidentally, I'd forgotten about that sucker - it kills the idea of
fdget-like tricks dead, more's the pity.  Third-party modification of
task->fs->pwd (under task->lock and task->fs->seq), possible even with
task->fs->users == 1.

FWIW, I'm going through the fs_struct uses at the moment; will post
whatever I get when I go down (or earlier, in the unlikely case it doesn't
spill to tomorrow morning), will keep posting incremental followups
until the documentation is done.  I'm sick and tired of half-finished
docs - let's see if I can push through that one this way ;-/
