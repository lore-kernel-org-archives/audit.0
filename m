Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3821FF33;
	Thu,  5 Feb 2026 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268803; cv=none; b=DUWanwqM80S40ZpcrJcuDLQmFvLUeD97sv8eYEIKHMXRdyUu82e2snixaUjUxWgIcHgis6rM1tch3YmCQBkmJ3JHV/PabyuIOvikNrSMzRaIkDYXlXDbXwsQ/VP/3edQQFHx24lFkKwBrdeKjqyEGAOQuA5nsIs1s9JM4smWIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268803; c=relaxed/simple;
	bh=i9tohFpQ/bALDBUaCAvA2CjvDemUb62nOoTEMEG9mQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bax3jaiJJNaEk7TXQZPYnDQQ9jlRC0urGeCZENk6fi7nJd6ZXnOPu0JFEGW83RaZnQUnZw/IGi5L9QR/ezkKD0LkfmTAOoQvo29RyI9hOoJQcnom5PtaiaxZRzLJsCHGDzBwsrqgnQYaJkSv7R4F/YlTUEAfilGQK+tIv9KbbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nnFzbzpE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nnFzbzpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KQ7hoCiOE4dm6bGlIZTe6R0thPftwCYDRedy7myIrXQ=; b=nnFzbzpEasfYjTcSZdJjQ3uXOy
	NsMZUoCH53tER1JUCcJhoCJTroqcIFRbPZ8zxs8PKnKXoHO7K0sxz4BS/Uooqa8ftqJWYegIbu8Fz
	jSNho1OdSZoaqz0YSoeuIQlYzOdJ4WmFkYrjGs7PiHWHMzgpJrY0C9T/pIolbfyN428S1Yc3Fmn3O
	0N2OqQr82cndL0sg4CChecJpHr6Ey4d0T3m2HKyF5J82foUNnXZmn+TDopqnCs0nrI8L67hpySYGB
	VFMRFLB0lSHQoMPiAI3PX7+67kOjfLixr2gQwdDl5kp2rSKp8R93drkWOnO9PPN/AUTN+rf9v8TgM
	x6HrT9wA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnroY-00000008c8T-3roX;
	Thu, 05 Feb 2026 05:22:03 +0000
Date: Thu, 5 Feb 2026 05:22:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260205052202.GQ3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 04, 2026 at 10:03:33PM -0500, Waiman Long wrote:

> Now I realize that there is indeed a deadlock problem. Scrap that. Now I
> have a simpler idea that shouldn't have this type of deadlock problem. So
> what do you think about the sample code below?

That it's rather bizarre, TBH.  Basically, you are allowing to park
a number of (identical) references in there instead of dropping them,
with your 'xrefs' being the count of skipped drops.  get_share either
clones a reference or uses up one of those skipped drops; put_share parks
the reference if possible.  And set discards everything not used up...

It could be made to work, but... ouch.  It looks like a special-cased
variant of something fairly generic, with really confusing calling
conventions.  Let me poke around and see if we have any other candidates
for something similar; if nothing else, current->fs->root is interesting
and not just for audit pathologies...

Note, BTW, that there's chroot_fs_refs() to deal with, along with
free_fs_struct() (at least).  This stuff is encapsulated in
fs/fs_struct.c and include/linux/fs_struct.h...  Oh, hell.

"fs: inline current_umask() and move it to fs_struct.h" had been a bad
idea; I'd missed it when it had been posted, but...  exposing the damn
thing all over the place *and* bringing sched.h into it?  Microoptimizations
are fine, and this one might have a measurable effect, but it grows
the subset of the kernel we need to audit when we deal with changing
the damn object by at least a couple of orders of magnitude ;-/  Sigh...

Mateusz: *is* there a measurable effect?  Because if there isn't, I'm
very tempted to simply revert that thing.  "Churn of adding fs_struct.h
as needed" is not the problem - try "exposing the object internals to
far larger subset of the kernel".  We had interesting bugs with weird
shit deciding to poke in there, locking and refcounting be damned.
Encapsulation is really called for in some cases...  And yes, I ought to
have caught that one back in November and asked _then_; mea culpa.
