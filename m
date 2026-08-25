Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C35C2EA
	for <audit@vger.kernel.org>; Tue, 25 Aug 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616532; cv=none; b=b62hHdvyg3r6rMnYybmPtAIziUB+B7TynqpPzuQYr5ubq8bH3k1XVI1VZ6ua3r4QnV7V+0XlkDpQFMbg//4LkwGLKTyNS3dH+Ugc+PMU4gFFod/FBkbeNDkPeod00P+937c70cWe5N0uhq4JecH/r3UFoZrFzHtvJTOXJ/789I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616532; c=relaxed/simple;
	bh=zNt8ul5Dug+HD7DqsrQH280x7qPjPH0DLVMLUclrytk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ixAkYsCg14u7g8uyElq6Kaw7LdVMyFfp36eTgQagLbvWR/CWO/4wu0qTbCkJwouis94Cv2dbLUVndTHFEAwlcXuZSME/L4C6wLrZNT0+Go9CfX40IekJ1sZ3ZJ3NysbLuHjMgCV5or7s+5go+AAIZVtr7zGvwFBE2ym2IUWhXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PdZDM98u; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PdZDM98u"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6c4a867cso239148085a.0
        for <audit@vger.kernel.org>; Mon, 24 Aug 2026 17:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787616529; x=1788221329; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZYG0rGmvOndqq2+XvkG4bcHzhwd5RvRGcgzNkG8xqE=;
        b=PdZDM98umYl/3pFR9//i9uiRywTTocZHnOWXRUQlMdW2GaLzatgB3DQKdtdR33aqUi
         0lndTJ6JNR0fU2y56OlhqKnzBU4eh6nsZcrEyjFGAi6+aULTXTmA2t1vx06+PCbwukyc
         S4CvCnppLdTcDFpwItOz0wlUR+/yx/oq6Zq6HaBieFW9J3lFsMCkYNHtqi6N7iz58vgk
         sD9Mez24lxVgoDG+QW5wGXnW78V4Gk14H6qFBspjiI634gch77oewkPD9df24XIaR1uB
         9UlXBZ/+DQu6H0ft50bpxUbsENLLgl0XJWjtEUQFureDQZvGRc6R4Q84ZxyPYHVS56AG
         32gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616529; x=1788221329;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZYG0rGmvOndqq2+XvkG4bcHzhwd5RvRGcgzNkG8xqE=;
        b=SFKlM41IYfud0vXJtrJgkk30ZVx8s3D7jVmpy+YtXbsKiyiLipEshItSzP/y+zuLEd
         q2K5Ns1uo2lJooDjlGRkb1QpDLw9Y6qccnynKJGaGNgBR8QTZaybjGY4mWL7qOeO17n6
         rabSy9OsiBfLv6tSRX4+CjI88p1eOlHF50R0iA8p5bBDpxErSk5QKUK7FgUwIErgLxAu
         GUxvhvXXF9i9269EDMf7TfRFLIKzSc/HEOdqmGKwRn2CaKkGnI7fLGgXtk5uU2h1R8Ro
         0JfF0HltzS8lnDpZWb7V7nU5j3u6OczoJD1kTKJSJtXxPwceIdxYjYCD2Wc/ixsw3laj
         yfdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLr4fSiWodkOd39uisjh7441B+gFu60heIxWGBn6osFMaII06VVxHsueynpkIUTpptz3NR4A==@vger.kernel.org
X-Gm-Message-State: AFuF++nNIdOawu1JnTwF/RamZGPIyhXoGW0Wkyhr0+fmeFnoaovYZpAf
	3KP9ijglINSjv12OtdRE6fe36zSEKLaZ6KjdloAPKbzejIQ/3qRQEtHNYopiQ2UcZQ==
X-Gm-Gg: AR+sD11SJN82cHmIeylt6DSvDvbX+OnrH2jn8v7wRXIJ+fXGWo2mLS39LZXCe7jBZBN
	XuvPQwh+U3YsRzlmnltZg1itbfN0LIXUEPF+ENLe6HxarlJ6v21FkbOPOJjAPToUBdIO4RUlWIQ
	X3oBurglvMWYqEGxfvqUkiI2sKXspNg8gyRLvydRw4c2XxF8EVIe+wX4qeQeaisJKtiEePTCHsD
	uWUfsbj10+d+QzM4HI6ttvE2RiiRayNd5iwvT0iTewIgGDOTkuEzMnI2R3GWhe97BQjPggkqEcE
	A4RTDrYeGB88+Wgn9UdWKoifcY1GMMQJUvShVggZE3xsydFDwJ8M45ezlaDGAhjIAzebpGK+0jJ
	9cWZyOn0FAVla5IxzWsSLRRCC581kT36+4usWgnhFd8q6cuRPvfhUKdLtFPmN87etSc0HHNkMZu
	A82gpsRKhR6H8+JXsybUXXRPTRi444KT5YhwBWUCS75mvwrvjsOR7WdMAgN0RkunE8VmJdI66aJ
	6+wP2szlLpXjGjGlxgY/mFxkjlzaNGdyLEGIvaRiHhY
X-Received: by 2002:a05:620a:668f:b0:934:97c1:ca5c with SMTP id af79cd13be357-9376f994ecbmr245172785a.16.1787616529334;
        Mon, 24 Aug 2026 17:08:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749da86eesm615566685a.34.2026.08.24.17.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:08:48 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:08:46 -0400
Message-ID: <552658f244965a3dca8081f0020155e8@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260824_1800/pstg-lib:20260824_1107/pstg-pwork:20260824_1800
From: Paul Moore <paul@paul-moore.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, include@grrlz.net
Subject: Re: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() to  send time
References: <20260814010153.14488-1-include@grrlz.net>
In-Reply-To: <20260814010153.14488-1-include@grrlz.net>

On Aug 13, 2026 Bradley Morgan <include@grrlz.net> wrote:
> 
> Right now the auditd breakage (nlmsg_len gets set to the payload
> length instead of the full message length) is applied when the record
> is queued, in __audit_log_end(). That is why
> kauditd_send_multicast_skb() has to deep copy every record and then
> undo the length on the copy, just so the multicast group still sees a
> standard netlink message.
> 
> So flip it: finalize the header with the standard full length at
> queue time, and apply the auditd length at send time in
> kauditd_send_queue(), right before the unicast. Records stay standard
> netlink messages the whole time they sit in the queues, and the
> multicast copy stops needing its own fixup. The copy itself stays,
> because the rewrite still lands in the data region the listeners
> already hold.
> 
> auditd sees the same bytes as before: the fixup is computed from
> skb->len and that does not change between queueing and sending, so
> records that come back around through the retry and hold queues get
> the same value again. Reply and rule list skbs are built with
> nlmsg_put() and go out on their own paths, none of that is touched.
> 
> This came out of reviewing Ricardo's "use copied skb length" patch,
> where I suggested moving the fixup as the more interesting cleanup.
> 
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Tested-by: Ricardo Robaina <rrobaina@redhat.com>
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> Link: https://lore.kernel.org/r/20260810125726.775689-2-rrobaina@redhat.com
> ---
>  kernel/audit.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc..bcfed6e3678e 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -802,6 +802,12 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  		if (skb_hook)
>  			(*skb_hook)(skb);
>  
> +		/*
> +		 * auditd wants nlmsg_len to be the payload length, not the
> +		 * full length, so break it here at send time.
> +		 */
> +		nlmsg_hdr(skb)->nlmsg_len = skb->len - NLMSG_HDRLEN;

One of the reasons we set the length in __audit_log_end() is so that we
only do it once, plus the multicast fixup.  In this patch we still set the
length in __audit_log_end() as well as potentially multiple times in
kauditd_send_queue().  This patch does drop the multicast fixup, but it
isn't as clean a solution conceptually as the current code in my opinion.

Ultimately, in this patch we still have at least two length calculations
with the potential for additional unnecessary calculations/assignments if
we need to loop through kauditd_send_queue() multiple times.  The existing
code is capped at two calculations/assignments.  I appreciate the time
you've put into this, but I think the existing code is the better option
at this point in time.

>  		/* can we send to anyone via unicast? */
>  		if (!sk) {
>  			if (err_hook)

--
paul-moore.com
