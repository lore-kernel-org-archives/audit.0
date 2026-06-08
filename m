Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61C39AD34
	for <audit@vger.kernel.org>; Mon,  8 Jun 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950845; cv=none; b=KnveAtcbD9Zd4ZmUE8qWnvSvjcYcw5x+u1tic70xhOS2cWl1YmeZEOfiy6nx7WJnMNLdhDZLfebn3T0J0AL/MSKeMMdnBrXSKC7iibN9HEXeBb5HjSDl6no+sXOiuaAq43Nbbc3UwjrY3yvPUOlnLb1iOB1LZdnlzr/kT4UqsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950845; c=relaxed/simple;
	bh=A/cN/4s66uj3+Bj8UW4PJJ7AM5RqTWOAdj6iHE8esEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=idv5ySWjb2kuMSZnf/G7zzDghxiFrNFULW53yNkoDv56mN19dzeEvOYT8qv/agEuB5AXlKuhN0/Ifb/QImQ4zCcAbCrjmhOe9T8S1TJUzLkjF0a+ERrilgQG20CTNHzV5Kf+2jCOBVljAKd9bXiQlW5IZnrbgv7TUf96SUl7zeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWbzFjdr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWbzFjdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780950843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1JGIssG7QjpNtoVXsThrg/iR9EXA+aWqywImW2IBdI=;
	b=iWbzFjdrFuwmHSGlf/znsfDG11eGpRop/+04pT9pfpdYJeQJ9SsES4W5bwxtkKhi9p3gP1
	kna+Hj5RdABZR7LGByj3Ay+4exga56pR/yRmoSPjsIwtSJWBPDqmHkPG/SooGW3mPLs8tK
	Mr/yQ27JKVoPQdFnBV7vVG7vwvHnXGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-IXjDgUEzPfCDnSv6gsMszg-1; Mon,
 08 Jun 2026 16:34:00 -0400
X-MC-Unique: IXjDgUEzPfCDnSv6gsMszg-1
X-Mimecast-MFC-AGG-ID: IXjDgUEzPfCDnSv6gsMszg_1780950839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506C01944B20;
	Mon,  8 Jun 2026 20:33:59 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5347619560A2;
	Mon,  8 Jun 2026 20:33:57 +0000 (UTC)
Date: Mon, 8 Jun 2026 16:33:54 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com
Subject: Re: [PATCH v2] audit: fix potential integer overflow in
 audit_log_n_hex()
Message-ID: <aicnMvOhZlng++dB@madcap2.tricolour.ca>
References: <20260601130951.1418695-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601130951.1418695-1-rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: XfBvxEm8O2E86UCj4gZFSt4hKMIjyjK23Wcq4uYDLIA_1780950839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2026-06-01 10:09, Ricardo Robaina wrote:
> The function calculates new_len as len << 1 for hex encoding. This
> has two overflow risks: the shift itself can overflow when len is
> large, and the result can be truncated when assigned to new_len
> (declared as int) from the size_t calculation.
> 
> Fix by using check_shl_overflow() to catch shift overflow and
> changing new_len and loop counter i to size_t to prevent truncation.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> Changes in v2:
> - Use check_shl_overflow() instead of manual overflow check.
> 
>  kernel/audit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e1d489bc2dff..8ca268610641 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -62,6 +62,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <linux/sctp.h>
> +#include <linux/overflow.h>
>  
>  #include "audit.h"
>  
> @@ -2076,7 +2077,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
>  void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		size_t len)
>  {
> -	int i, avail, new_len;
> +	int avail;
> +	size_t i, new_len;
>  	unsigned char *ptr;
>  	struct sk_buff *skb;
>  
> @@ -2084,9 +2086,13 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		return;
>  
>  	BUG_ON(!ab->skb);
> +
>  	skb = ab->skb;
>  	avail = skb_tailroom(skb);
> -	new_len = len<<1;
> +
> +	if (check_shl_overflow(len, 1, &new_len))
> +		return;
> +
>  	if (new_len >= avail) {
>  		/* Round the buffer request up to the next multiple */
>  		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
> -- 
> 2.53.0
> 
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

