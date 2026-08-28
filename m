Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DF320A14
	for <audit@vger.kernel.org>; Fri, 28 Aug 2026 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881996; cv=none; b=YN7PYceCVrQlyP7hnkZLz/5vrkTpNpP3Y6h5tdsyIq90weKn4PEAJd9wOE11hwGR65Cn3gNqSjy4rZd7VTLLvxzHSsuGKntQgvjEQIcRLwHLqVgni+sMlLCBXzK316Infck3Dn9nOL/66iD6IXPfSWylwFX+HJP6TdU1Q6j16Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881996; c=relaxed/simple;
	bh=a879juwz7YnXRSU0aj4H9oqy8QG+UQ6p/1llyGoW7h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CJflxnZOH0EFGqf4wav4nvKwKlqdYzABeMpCmXT21IALI2PPWDKuysoXo6gCEHtPQDmQFOPNPKd+AguQHbdqTmKOKSq/yk6b7IBFSE4+O09OF+Bchj0sUpPAfZMLl9yrpLBtZhzGWO0wPfyO1mxayh1BA5vgWChx0tGyRxdo8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK3bA1gE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK3bA1gE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787881992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVa9ltN/AYxfIIR3vFfpODM3T6RUi+J6FBmrLKMnXUo=;
	b=OK3bA1gE1ESCr4nrsx5EgkrK2BBT6xAD17iV55vT4x/GUEE3k+W9qE8C+WYXyDlXhS0v9+
	fTRElR9iNBt3cMuSYsQ7P5QInVnxviLKQbOebx3D7d+eBu1QhGy04D2l1Xd+Fh/tC2jhg+
	HPtrN9frrTd97uLSIR1QqgbDCnS+l34=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-jo8oXn_8Ne6Y4KKQywx0iw-1; Thu,
 27 Aug 2026 21:53:09 -0400
X-MC-Unique: jo8oXn_8Ne6Y4KKQywx0iw-1
X-Mimecast-MFC-AGG-ID: jo8oXn_8Ne6Y4KKQywx0iw_1787881988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6056219539AE;
	Fri, 28 Aug 2026 01:53:07 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.76.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4CB5180059E;
	Fri, 28 Aug 2026 01:53:04 +0000 (UTC)
Date: Thu, 27 Aug 2026 21:53:02 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Roman Dolgikh <rmd4work@mail.ru>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by  fork on exec_binprm
Message-ID: <apDp/lou9KwOz7M/@madcap2.tricolour.ca>
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
 <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 2XmkPauOj7Igb1STN4tHn7oBb1b9NhLHg9VuKvyoB20_1787881988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2026-08-24 18:07, Paul Moore wrote:
> On Aug 18, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> > 
> > Between the actual process startup (fork systemd) and the executable file
> > replacement (exec), systemd sets a temporary file name (executable file
> > name in parentheses). If an auditable system call occurs at this point,
> > the audit context will latch the temporary process name into the cache.
> > This name will not change again. The patch clears proctitle into the
> > audit cache when the exec call is made, allowing the new process name to
> > be latched.
> > 
> > Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> > Link: https://github.com/user-attachments/files/20751461/fix_audit_proctitle.txt
> 
> I did drop the link above from the commit as it is contained within the
> link below.
> 
> > Link: https://github.com/linux-audit/audit-kernel/issues/170
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> > Changelog:
> > v3: use previously assigned context
> > v2: simplified to call single use directly before need in audit_bimprm
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Merged into audit/dev-staging since we're currently in the middle of the
> merge window, this will got to audit/dev once the window closes.

Thank you!

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

