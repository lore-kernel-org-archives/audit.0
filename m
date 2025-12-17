Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B62522A7
	for <audit@vger.kernel.org>; Wed, 17 Dec 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008995; cv=none; b=UM6QFJUb2PXS+U6wHj8D7twQxRNyP+dFUIrrnrQnag1yJy3VqoRZLzyNRqnE1ZZnDbTZXgNyT1ZLTM1hEv7bH+uTmT84wIXvtR9bX7WvrV4p+howhfN2karJff5dfcLC3urZpZr/brd1J92/nfeRorgu1fKb9fdKUnIWLrt0kO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008995; c=relaxed/simple;
	bh=lFWlzRjftaee3q/5YDBVJ+Nguk9c76wRd/f+/PuMdmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xb0j7WyLv0yJ1mDAi3F/0O2YChgebp3jhzfBNsndwbmDX6BBjTUaWDLsTI2sL2dMSoUv5Xy9yfRohyLGJZqLQ+/DfCIcd0Qe6aVK/xTMwqfRRwY02bXOKA7VIM9sbNl2kQT+q5Vp2mI2/EYfqX7IqI8sSvhQDuHPiQ2n4Eu5Q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ygvkb4N7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygvkb4N7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766008992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkhsudaR5WD/qdcFGwkGBMJwFGZtk3+8LY8HIXteJB8=;
	b=Ygvkb4N7UBr4xMTfZUVwD7znQXTKjAdrXfjVgTSEJXaNI0gECilsCL/RSTZRLxo/2Me/Hi
	A/fZRwZiqh6X8ZJb7nV1pnA/AMyjr7Wxmvhmo0vYqSWnVIn/7v/gUEwSkNob1YCxFbuy3J
	BvQai+t8AW7VjW6ufg2Yz3ymZ9olNxI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-go3JovIiMbGOef9xasXODw-1; Wed,
 17 Dec 2025 17:03:11 -0500
X-MC-Unique: go3JovIiMbGOef9xasXODw-1
X-Mimecast-MFC-AGG-ID: go3JovIiMbGOef9xasXODw_1766008990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3C4018002F9;
	Wed, 17 Dec 2025 22:03:10 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.74.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAB191800576;
	Wed, 17 Dec 2025 22:03:09 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:03:07 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org
Subject: Re: [PATCH] tests/netfilter_pkt: allow for a greater number of
 netfilter fields
Message-ID: <aUMom2SYZVVplJ5t@madcap2.tricolour.ca>
References: <20251216160059.58230-1-paul@paul-moore.com>
 <CAHC9VhT3OW86ALFRBeyJsLPE+ZzTrfG_NGwKhnZ-+hKMZCqC5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT3OW86ALFRBeyJsLPE+ZzTrfG_NGwKhnZ-+hKMZCqC5Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q0gMBDmY5_0xKK6RRC3887f80n3-cLSr06SODRUJHE8_1766008990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2025-12-16 11:12, Paul Moore wrote:
> On Tue, Dec 16, 2025 at 11:01 AM Paul Moore <paul@paul-moore.com> wrote:
> > Current in-development kernels include source and destination port
> > fields in the NETFILTER_PKT record, adjust the test so that both
> > old and new formats are supported.
> >
> > Future work could include verification of these additional fields,
> > but put this quick fix in place now.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  tests/netfilter_pkt/test | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged.

Thank you.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

