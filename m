Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3443D9DC9;
	Mon, 10 Aug 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368425; cv=none; b=VXwIZC4JLm0/looC2fCnZValgiUfhYMLMqD/u4aTqEaOJLWNPyD0C9h0B/mwcoiw68Up5I6BOQPeqfjfyAX3s2KCUlTf3ghLOVW7pd5/3HATxH7ly/XDfxju/l4ORzc4Dy8meo2Tf4YqFr0gUsehwq7mdYRT3bfIIussvUPU5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368425; c=relaxed/simple;
	bh=rYVq4hXlLZZs1GGfk6BSVoYk+Dg/pLAYKo4khMCXfHg=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FHgLYoSMjHlBXle2ygV5UDIlz6zAe9OOkGb7isMVewRUE8+omEounGlq3xaH/yZruRrGiA3QGyUcFQYbERx69D7/uLKqN9LkmUNgDvDqXsL8z+JpNXW3jg9yaKNEI7GZ04PjeVRjrT4roOL1oj24yEDxKwCN1/exdFq9RkFrLOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=M1rm7ug7; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="M1rm7ug7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786368413;
	bh=UvpTMhxmKnCiBtisEMb1Wx0FJYaIPgWDBQ3cSKofVkQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=M1rm7ug7wJIIH28J1TsMq/P2117N4t4LrXnuysVxKvUIrP4gaus0ToKNT5t7ibJYN
	 EJjAuV2KloTuxFWfiFfCmr+fEgH/5KRpoM0HhprEopvCwkKZWnT4PE7iqlfiPdkMyZ
	 F/9fGGn89rzSnpoDUTKAuOrfUFjK5hBYJ/tp9gkE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hJbBj33vNz10tB;
	Mon, 10 Aug 2026 13:26:53 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hJbBj01hYz10sm;
	Mon, 10 Aug 2026 13:26:52 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:26:54 +0100
From: Bradley Morgan <include@grrlz.net>
To: rrobaina@redhat.com
CC: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org,
 paul@paul-moore.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_audit=3A_use_copied_skb_le?=
 =?US-ASCII?Q?ngth_in_kauditd=5Fsend=5Fmulticast=5Fskb=28=29?=
In-Reply-To: <20260810125726.775689-2-rrobaina@redhat.com>
Message-ID: <D8FC4B83-AC7B-4ECC-AA70-17DCE5AB2AD6@grrlz.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ricardo,

> -	nlh->nlmsg_len = skb->len;
> +	nlh->nlmsg_len = copy->len;

Fine. skb_copy() does skb_put(n, skb->len) and nothing touches
copy->len in between, so the two are always identical. 
Which is also why "safer" is a bit of a stretch, it prevents nothing.
Feel free to bikeshed the changelog wording on that.

If you ever want a more interesting cleanup here, the real quirk is
the line above: the unicast path sets nlmsg_len to skb->len minus
NLMSG_HDRLEN, this one uses the full length.

Well, why not, please add:

Reviewed-by: Bradley Morgan <include@grrlz.net>
Thanks!
