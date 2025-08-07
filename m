Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6A25C802
	for <audit@vger.kernel.org>; Thu,  7 Aug 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575475; cv=none; b=ffMPMtCSAj5qWTgPFt0ZJJAsUpx1gZ10aWgtJMWpssXVJoZPyvjjZ9ypQczH+7lLHr76fbtaQhi9rMYIcauTcx5HDlSYebWc5nI7WAmoFKMv2TynFwZIP3H68kiCFuKo71BaCHWB8k+OrVdALwLqHEe4BKGEEFbTVtXa4R2/YSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575475; c=relaxed/simple;
	bh=CMk97Nfce9AYr014fyggN19TjxQ2vwV9jnv9i012M/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPQcuYEdQf9hpbHpmrRkZkitmMnqWIFcH+wO55H62v4mK9SUdyLngkLjrRaZ6v8LP+l2DG3z72p8yrVHYwZBNRofdF+uBNRIh3DZjAQkCCUj+dzskhkV+zYOX9wi2JUcfxkQXRZi5zHwSQvjqihR1/JNIPp0NC39xWPhYKYGRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Soz6XNQe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Soz6XNQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754575471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d16O4y9nXsFhk/FwMerVNXw25kYspWhC/njJ93UTAx8=;
	b=Soz6XNQe1ELABm3teDzDNURvq1AjZxb/RTUvbyyOnCNyTol3Xza8gGjarFZKePqCu2Hq5m
	54qoa09G0NC2K3Tq2jAwn2FNhnsQMe/Wv4+bsA0IlGzA2frIhTH5WYpf2evC2oof3MhhYm
	LuwlO1llXkicSAQsT+AiivWYc5BjAX0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-8DOqnMv2NWut1-jgmgt8-Q-1; Thu,
 07 Aug 2025 10:04:28 -0400
X-MC-Unique: 8DOqnMv2NWut1-jgmgt8-Q-1
X-Mimecast-MFC-AGG-ID: 8DOqnMv2NWut1-jgmgt8-Q_1754575464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9680A19560B5;
	Thu,  7 Aug 2025 14:04:23 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EDC91954185;
	Thu,  7 Aug 2025 14:04:18 +0000 (UTC)
Date: Thu, 7 Aug 2025 10:04:14 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence
 of rules
Message-ID: <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
 <74767dff9834360b2100907df5142ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74767dff9834360b2100907df5142ab9@paul-moore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2025-08-06 21:47, Paul Moore wrote:
> On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > 
> > When no audit rules are in place, fanotify event results are
> > unconditionally dropped due to an explicit check for the existence of
> > any audit rules.  Given this is a report from another security
> > sub-system, allow it to be recorded regardless of the existence of any
> > audit rules.
> > 
> > To test, install and run the fapolicyd daemon with default config.  Then
> > as an unprivileged user, create and run a very simple binary that should
> > be denied.  Then check for an event with
> > 	ausearch -m FANOTIFY -ts recent
> > 
> > Link: https://issues.redhat.com/browse/RHEL-9065
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > changelog:
> > v2
> > - re-add audit_enabled check
> > ---
> >  include/linux/audit.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged into audit/dev-staging with the plan being to merge it to
> audit/dev once the merge window closes.

Thanks Paul.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

