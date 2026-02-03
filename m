Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A138E5DE;
	Tue,  3 Feb 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155287; cv=none; b=S86FJeJVSvHFTUaNOllCx6Hy2cUcqIggmvD3etrT6kHmOez4dwGdtF0KPoAONO1v8PTuQHKGQQRrUoLH9gRRqyy5dCrNX8Dyot7Vxx3yDkHT3VQnERawnEtiNZNVMzIr7lRhJ95zyVaj09lrRMX585Xx3v5Nc+fpc1iMM/UvmCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155287; c=relaxed/simple;
	bh=YEmKbyfaCzNz5ph4UknYPhDsiok+OdJndgJBGegIjkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBckoty7DuTlbRzZGW5KhQWB1Hu7mBAdSOxBDMlDB12pQH7jGG0hTMAKOS0tgiD+fMXHkL0Afpf2DkyxxkVGn4iFXXCLF/Zp4A3UwQ8zO/Mh7MYoX5tPUr4PIVEd80mgt78JIKbJzS+SWLdUogQQ/fNs+DsLapLC9H0gpL15A8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vtvtztqJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vtvtztqJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=YEmKbyfaCzNz5ph4UknYPhDsiok+OdJndgJBGegIjkA=; b=vtvtztqJ+IEwLeZGWWeKjgZHbr
	m3KxadjBoFrujcTTMeB2KuqGdGqjXUiaDDXRHkmRRIW3VKe1YENlz8lB8p5S/ccU8uUeTIw71JlTk
	G/63whyQ22VHziqQPDUMIfWahBxFW71Aqfh9OXDKkZ6exjYlN2Uhl8i1CI9dI8PgXinGSpaOmeay4
	vwGY/ZGgc16/Prn7c+jSU/nx4IAbZxdiwRK3DL0CtBWhp1/TDDpI8IO7bORyjoEQOUpXmubPvWCpX
	QZ2RB2bFT6vbL6X87mm6yM3xsOlZ77ura6qFWfXw014UMzYfn4pFbVhMzp4CJYhS7IgNRXhi2q8Dx
	r1xEqr3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnOHa-00000000oq2-1fB2;
	Tue, 03 Feb 2026 21:50:02 +0000
Date: Tue, 3 Feb 2026 21:50:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260203215002.GI3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 03, 2026 at 03:32:04PM -0500, Waiman Long wrote:

> That is actually a concern that I have at the back of my mind. I can modify
> the patch to cache only the dentry and do get/put the mount every time which
> is much cheaper as it is a percpu counter.  In that way, a chdir(2) followed
> by a umount(2) shouldn't cause a -EBUSY. Right?

Quite - it will just retain a reference to dentry, with filesystem shutdown
being very unhappy about somebody retaining references to objects on the
filesystem about to be taken out...
