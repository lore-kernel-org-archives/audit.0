Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0330E858;
	Fri,  6 Feb 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410194; cv=none; b=fAAinehudrt8Y6UMg4tzws9htOocO7HPRORGs4CvLKmpydXOXhVViWMSGYn4kK9EY8iY0hNAPesJjxPiGvc/K3KZv8cCcq0cmDtFNg6Bqz1Rb6uFW0h8quOjL6JSSNNL/eCtMrkvXIJFSNqfWIoC/JhHE3Et2hs68uQPqZ78ljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410194; c=relaxed/simple;
	bh=jxMGW6dWt9VsQwmCWVJZr9i4dS98eWp6ookQUIIQoVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMYNWnil8DX2i6JbfJAO5AG5/pdnrUScWxO85OfESKUhryxn2CrwDeRdWpENcHfkH0jTo6FKfkQRBPp/t+Q9sNoZ1Nm+QQeIDikvySBZQ9RO3ARdByuvTfGoFyZQOoGy4tHv3aQT3L96yVMyBxhm87YOZpTpQbk/Nmc45fsmg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XI9K1gu/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XI9K1gu/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X/JiXKWB8lllbl/AEGTE18JPgYzTXTg7NTaUiOuM90U=; b=XI9K1gu/qsKWaxWlZ7ZlsJhAMO
	L2CMjbGxVIwRKpl3mpQcZSIIpP8DtOefmzPaWFnB3YQfeN5Z5Wb5FedNqNdiCMC3bsHycSCBs2bnp
	y+fOnjIs/QzN10aJEVc+rxoSpq21FXNQ+tiGG2sgKPQo5arvCXehmRVsZuv7bzUc64guxvoyBE7Mg
	V4Gp7jCmNsTsiA3rLIj7pM58dqoUemosg7djKI7M8EUCT3JLwsR9niXEu8oW5BS+cw3GkR42hjImO
	nufWKuOUTVTD3MI/XTR5i/t9bZPGeQD6ja+qXmH2IWTjT5eF54xauxCWr8RmLx1AC8m5KJ95IxMdA
	7TfmUiOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voSb8-00000001eeS-1LJT;
	Fri, 06 Feb 2026 20:38:38 +0000
Date: Fri, 6 Feb 2026 20:38:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206203838.GB3183987@ZenIV>
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

> I guess if private means fs->users == 1, the condition could still be true.

Yes.  And then there's an oh-so-lovely wart wrt. chroot_fs_refs() and
exclusion for it.  See another reply re unspeakable[*] elegance of the
proof of correctness for that stuff ;-/

Annoyed much more than usual,
				Al

[*] there are some limits to what I'm willing to say on a family-friendly
maillist...
