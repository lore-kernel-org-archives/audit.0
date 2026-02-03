Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA072EE608;
	Tue,  3 Feb 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148988; cv=none; b=WUljSI6QBRBj+WP8VCGecCGoJakJQoRgbJYFqp+n+tS5sKWMUYSzCZQpiFUSXnuq030MKZFxSMnzCN1jwevJm52KfTxaDB7TkRHdQpOB4hdl18YlEzzxganLrkpD4e1fByuulFQxx+SggdGqX7UoeudWAQS28T4Z5y8D6DWhKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148988; c=relaxed/simple;
	bh=daUYIEA/YFBRD551KmMoMSqHOY/QTPCin4qYJBN7gW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukP6xV6fFm5dJxZR7y4hb/1rxz/d0DUxmsf51hCxWERVRnxawbJPWi7kmypLfpNUAOvdyxW7IWtEPX73NzrJHek68AcpwkHe7Kf+4FIKB5ieFsQ9ZYIQd+YTIn5mjz3tQbepTV1zKsR60qNZVaW1Jt5T2isFfx+RNCUGojpnXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gthxq9h3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gthxq9h3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3jVlfwXtp72vuSs1fBEEFI/hNX5tukl8DN8/0spju94=; b=Gthxq9h3ZBI2rTPlWwiZRz1n+C
	3ccTiUVJz4tswJIthldeuXeyXBbT2wE5SMgGh+g0N/kYpOor84iUEOM0gH8Mcenxgn+BeU8Zm+RPK
	TNlW53SGjtGnjMTdDPebU4Mpx46AkF9Ctp48mA82uKEZmRLNIeBRrrEDvSvmfwfUTCjh4rs93Mmxl
	Kv9qqbL+CMgffdlXHFZM/xQrNXk8ydJGpM0xsAWapfQSMhuP5od3Ie6zbiagis+7VPcj6RIqxXnZn
	Wtpkrr2gw1BmfydXJBlFLsgRka723/GRPhz4N2dz1jsLZZ03PQ6x+9JInwn0UxiH5crSAlTVK7INf
	o8spWY+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnMe1-0000000HYto-2urt;
	Tue, 03 Feb 2026 20:05:05 +0000
Date: Tue, 3 Feb 2026 20:05:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260203200505.GH3183987@ZenIV>
References: <20260203194433.1738162-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203194433.1738162-1-longman@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 03, 2026 at 02:44:33PM -0500, Waiman Long wrote:

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 7c401729e21b..03f3539b10e7 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -133,6 +133,13 @@ struct audit_context {
>  	int		    name_count; /* total records in names_list */
>  	struct list_head    names_list;	/* struct audit_names->list anchor */
>  	char		    *filterkey;	/* key for rule that triggered record */
> +	/*
> +	 * pwd_reset is set if audit_free_names() has been called from
> +	 * audit_reset_context() to reset pwd, but pwd is still holding dentry
> +	 * and mount references to be used in later audit action without
> +	 * the need to reacqure the references again.

That's a delicate way to say "we have mounts stuck busy inexplicably for userland"...

Generally a chdir(2) away from something immediately followed by umount(2)
is _not_ expected to leave you with -EBUSY when nobody else has been doing
anything with the mount in question.
