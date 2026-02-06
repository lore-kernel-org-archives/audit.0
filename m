Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505D2E1C6B;
	Fri,  6 Feb 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359814; cv=none; b=b0ZX1VuPujVsH/nPu77KuJbxceXgqxJlgDqU81YBETA0fJs5eoZJLynIOyNrjiyE1A2hqGC435Q4OZZ1Xci0UXhN0n2GAdxVZ2g0EdLaX0Oi/fCSS6jGIboa06Ux63KPVf2r7Kdkr8aZOdyh7Qkd7Q54N7Y/9d+uD4JYjtQQLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359814; c=relaxed/simple;
	bh=t9XYj0OAj9xh7CvT6eHmyMtIfs2lhFQWNk8UFIl/Kf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA5VG4zcHXDq0NM8UhsJyM6lbFHPp2xvfo/veK4SF922A6zgEa4prDESMcyP7ClBrDLg/+A5xO49Z/bwPbXQG8zyvC53iMLu4SXjjzqPyeVZ4fl8qXX/RHplrdP4mjMjOWLHSAoSKAqa1WxNms+enoOtYICjTNHVe1vPQM/aHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jhLrsKXI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jhLrsKXI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t9XYj0OAj9xh7CvT6eHmyMtIfs2lhFQWNk8UFIl/Kf4=; b=jhLrsKXIP9+eFgi1YRJhM/+m0e
	TloCKziji3sOTa0gCRwFEkbz7ovYGe5vQQjT4OXI2mi83hozLBQisIZMqj4CcPxKH5B3x+HUrMw4y
	4EJE7T7geREqbwg2E5aqhw0FRH0oAr7D6zeCrjrwgXdkoGKXfK49MNUlrhY76VR/HKfizFlJGHiKV
	oHMGaR5T0nn6TRc7bnJlsEcMHl8ql9KC46gmA0bE0wOVt00lRA10VgB/W+a9JzA2F5Vu8UkC4Lm0Q
	UQZjG5XaC8IfkZzgHOMHzwryuXudrcDI1dLs6swE1lgKxdDgiz/7Mc1FfIK7GPAySundOcgZGlCE6
	SiOqN7Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voFUV-0000000BuOr-3f5G;
	Fri, 06 Feb 2026 06:38:56 +0000
Date: Fri, 6 Feb 2026 06:38:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206063855.GX3183987@ZenIV>
References: <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
 <20260206063124.GW3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206063124.GW3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 06:31:24AM +0000, Al Viro wrote:

> Mea culpa - mnt_copy_ns()

copy_mnt_ns(), that is...
