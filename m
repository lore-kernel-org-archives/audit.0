Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105461B4223;
	Wed, 21 Jan 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964972; cv=none; b=OGEz9prBakqF1JhdJvSFu/JPUzNWIQGTt/0JDCMAV2flsOUeK9+TfuVTwyIf38JYsURSACLlkdGr0tA9nT2YY3Hz6DeRKeell1KSdLcJCS/RLbo+wPwXDbMd4tFEbvLrjELOo7zNSLVWyRqtHz3nWFf69arMsxOFeEYYTLdMa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964972; c=relaxed/simple;
	bh=blWnm4OLKKZJGbKD22h+s1Ly2sU4KwoNjJGee+N+RNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC8Yp8I8+SXfIU2kcRlMMH9pkntaLh2vq5pkgIHMADi0qQLzeVv0hjB6tM0t64vrD9PEA+Qm/OpUQfh+qa+ksst4cEckXTC4HNpRgPGCL2d8CpRycgwJu4bUPyKrOF52K3vOKpijsWXYHhfx6S5/E/2bveLqSpyc8xCQtpOMbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=etTq15+l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="etTq15+l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=blWnm4OLKKZJGbKD22h+s1Ly2sU4KwoNjJGee+N+RNk=; b=etTq15+l+BVHsf4IsFEoj0YqiF
	IJJwEmp3Nqkv2tWHU2CumMc6LKHCUgbQBSjumEWvY4Si0Iwg1WVg/7A6tho4VFi8O1gdqNqEydJwB
	A6tHH2Y4I1t5nPbfq6mV4wkwi9Zy+cSFsYUZZcqaLIg1Jtbm1XIBhk3K19K58ig6G7kYgTnXC8bqC
	PbqdxJXCfCFTNx2loQXtcHgW58QTyGToCHaRxQFMeGnW8zgoWokSIj9QrPz3o7KlW6a51SFfTlRpv
	1O+zsVF4b2I64H+sofAtnn32p9dpNruuBM2LUTAOIIjR3IkPxXCeKyBB61OH1iGNYyd9T62LfrzM9
	RNUy8FTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1viOcb-0000000EFVP-1wCL;
	Wed, 21 Jan 2026 03:11:05 +0000
Date: Wed, 21 Jan 2026 03:11:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 1/2] audit: Quit audit_free_names() early if name list
 empty
Message-ID: <20260121031105.GB3183987@ZenIV>
References: <20260121023509.410423-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121023509.410423-1-longman@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 20, 2026 at 09:35:08PM -0500, Waiman Long wrote:
> Optimize audit_free_names() by quitting early if the name list is empty.
> This eliminates the need to acquire and release the fs_struct spinlock
> in path_put().

Why would path_put() go anywhere need fs_struct spinlock???
