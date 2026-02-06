Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8133B6E0;
	Fri,  6 Feb 2026 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361901; cv=none; b=K/T26PrsRzndDNNnu/O29gLmWLuoHVWTRO5d7BwQWCVm+AjkRkQxAJSyk8o8qje/adfaJEgHQUXfEayQX49GQrMEG5oo0/au+tx2xBwkJ2UTmdVMtmWBED/0nCFyTLbLp6/P5rpBVpGy79URQqDGYDNHnlKQRPwTBWi9+vJq9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361901; c=relaxed/simple;
	bh=ESHxK46Pp195Pbj5nCBSxf5dTCvDcKVwFKYUPZcQje0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5HsUsfEPB1S9DvsAXVBPMLX9ETlPldYyfuRS1E0XH+bQAJpF+xPjQs2GuYz7cbqQakAawuTEJWOqBK1GXQosUm3L4zdZoaPlcFlbMEV4PCwxG2aFNRAkccKOi2SG4uzSXLHS4uLyofHjEOB9ji+UCwa6Fk5l0t/Rqs+iLORD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LFCo4OBG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LFCo4OBG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1rzOEriOO79igMc9s7879b8agxoEU+Vd19O62sMBiI=; b=LFCo4OBGw0xFjd7VU2ovEX0j8s
	VZ+IYG31tLYrOy1VwDUQqq3yvp3KHT9X9QrSftOU2qLE4S5aBxiUdIUlkuAj6kF1RbL6nbTip53dD
	yFr+8EF1yHADTbgzL+wSBvXCZtrhir3IevPZrXN4ci9sj0YM6OMljmwG551Dr9l8esqUdhpptTkj3
	iCbTEgEoGCPPP2NCpVwDTxV2gxl7og+GAbwWAs9mXMihJ3EnwdPOBYI9VFRnoBzhzXCn20FdhRpvp
	rSd3xZpS4rHmFP210moNQMAxHW66pj2qUJU5phPp36pxQoiPPgjQ8e7EM1RsV1i9EYJnsqZJhn9+B
	z1a6wnpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1voG2B-0000000CTVW-1gNl;
	Fri, 06 Feb 2026 07:13:43 +0000
Date: Fri, 6 Feb 2026 07:13:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260206071343.GY3183987@ZenIV>
References: <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
 <20260205235351.GU3183987@ZenIV>
 <8a456257-6f7e-4d0a-b38d-3c2aefee76bb@redhat.com>
 <3a5f84fc-5c4e-4ce1-b2dd-6e07b109ce78@redhat.com>
 <20260206052218.GV3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206052218.GV3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 06, 2026 at 05:22:18AM +0000, Al Viro wrote:

> callers.  There are 3 of those:

4, actually - prepare_nsset() has
        nsset->nsproxy = create_new_namespaces(0, me, current_user_ns(), me->fs);
again, without CLONE_NEWNS, so won't get to that loop in copy_mnt_ns()

(que the obvious references to Cardinal Ximenez...)
