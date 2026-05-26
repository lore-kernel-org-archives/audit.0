Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC03C2B8F
	for <audit@vger.kernel.org>; Tue, 26 May 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830582; cv=none; b=XQggnAfMzzQRyvBWBZsu4PBBjesuzN14E98/whmSU0PgrrPQioqzHyuycxgpq0GNhp9TtUg8d1VVZqeo3JyPJ+tPQq+AcfoLebtha1c8XT8LCGJ2a1jZ8qFYQzXQqaZ0tJGLphW5X0BHz+y8uoqaGhLODYa6xLj1Pzj41ueKbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830582; c=relaxed/simple;
	bh=ZQn5yrrrHMJBfs9zAiUN+wgCx+jYUncrSk1sFBZZj18=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rOljeO/G7vPsP31HeYm2iH4/AuWPmFwShPlC3J1GWI8peGbZZTlk2ia40QmBaYt3lTS28DHk+FXphap0etcOyIq5kr5eheO6fqvCo08QLsZQ0I3WuD5aMmV+bhfxjo795Z0dsCdje8cLyoFpjXJ5PqOjEWVFPzYoSBAUBiPBg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WmcOD9kI; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WmcOD9kI"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-911dfc86903so1286198685a.3
        for <audit@vger.kernel.org>; Tue, 26 May 2026 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779830580; x=1780435380; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R+wfiQiZ3WfbCe6np5TQJtFiWfh5o9MPwGS1FSU+/Q=;
        b=WmcOD9kIO+lZY+Lhj32Mzt4pTp0ciQLhbH9938h4gJBGBaFUqXVgYLV7MOX7u3240/
         z1op8Ij8hFFr/1tEhJrdKIMr+mCug8/kYkqMgG4pcPkwqpV7s/taQ3069e3d4ZhT0+Ks
         +ZFPi73Y8aGCMw5zi/bgDtNNDnzriwmXP5NyaunAE2QtAqPZ78hMjT70WDRN6uqRmg9T
         IJWAX5YRK4+TpmxmINVo/ugbG2xo/U+gn85pDkhhcCOJogpvKcLkYPbg8iSWadpScSxo
         vHUzs6ZskhUUOVtqJ41IaCl87qsQWXtHbse3oM8NmKOUANH5ZnN6uz7ExmCWaIgf49QW
         CyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830580; x=1780435380;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R+wfiQiZ3WfbCe6np5TQJtFiWfh5o9MPwGS1FSU+/Q=;
        b=Vx4Is3Wc0zmNPIexZFCJpc9au04WtzALYl+p8i/YAqBRd8MIn9zqGG9GTd2b0544mG
         kjGtAjw5Zo8i3QKKDiAmSK9HrGqTHyZirpwqbISu2blrxmtYIcQwOB+SHWkK7wtjpNCo
         H6/FEatfS2U2u4PXLCjoXgkVQqzVDROzobe+6Aa382QyRf9WiSmEutme8XldKEAtLSHD
         uMXprgX/rSUmx+uR3DSMeTSZ7kxJo3DpOHX/g8/Q9SxyOYk891ykE3uPXhYhGQ5TjXug
         AwRirXhU2k8I8q9XybHMdOgf+8vRjSzJ93AN4MV8gWqNAaXsIqHotucvnjPYvsMDlEsS
         nUYw==
X-Forwarded-Encrypted: i=1; AFNElJ+i8tIgitBw4+la0INOLS3PWCVu28we1cKxiU6EsEQ9KWbuAhmQxdqHezeE2ekfkcn/SLnN1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qdUdscsU3XAb0t2RhFiw/NnUPBPCHKHe3Cvj+aju2UdJnxJZ
	Ti3sVIfusqabOXdw37cKKW5UiR2miPHhVva7mJ6QDyS5rUq+SYlaArVxBJ5tanOcqA==
X-Gm-Gg: Acq92OE9MO3OVJ+oJ2mCFYqw7UMDxzxbDKt9h5vrpU4CR73yv1RHenn+Y+PYmCiTazX
	v4n8W8z6zzhnQHrwkL/tGFGnuk3E8nnyD2bVrM23i5okUs8QSitGR1W1//apXwOeKdG9Mdp3D8l
	JrFEqg8NRGdoRuxtfLxRoRyGLfYncm1Yu+V0Xa7m7Zit7dxWYEfyI08N4BpcZQtw0GGWapYYGZH
	uFFYpxIhyjijvBVhISx7qtYjTbkjyGitUrFsLwV/X6pycG0n5z47f2MgALHhwFsFwmy7xfd1TPn
	Vu2i49Y5L4N8szn/14gbUU+hPAynHPPbhVQRnJQGhhyxqPmVoVJmvAS1W+vGPHiEa8svenl94g4
	NcThsp7vkZ+fXxpq59fhdFOrzwPz2pbhSPp/p1G7OGAaZvjbAcs2NRkF6I1z4ZqbOaMgE4qC1Mv
	WtYs3Ndcz5dcfgN5OFPcddnOJG3s3JDqY9vA7V444VgK9630Q7aU6qhWZiEC99aCOxggOI
X-Received: by 2002:a05:620a:690f:b0:8cf:d804:456a with SMTP id af79cd13be357-914b49186d0mr2753139585a.20.1779830580263;
        Tue, 26 May 2026 14:23:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e8e1esm314289385a.7.2026.05.26.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:22:59 -0700 (PDT)
Date: Tue, 26 May 2026 17:22:58 -0400
Message-ID: <c94ce54e232d50dcfc7cef9ada654ed7@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260526_1654/pstg-lib:20260526_1539/pstg-pwork:20260526_1654
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: fix potential integer overflow in audit_log_n_hex()
References: <20260513130843.790380-1-rrobaina@redhat.com>
In-Reply-To: <20260513130843.790380-1-rrobaina@redhat.com>

On May 13, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The function audit_log_n_hex() calculates new_len as len << 1 to
> account for hex encoding, where each byte becomes two characters.
> However, when len is passed as size_t but new_len was declared as
> int, this could lead to integer overflow for large values of len.
> 
> Additionally, the bit shift operation itself could overflow if len
> exceeds SIZE_MAX / 2, leading to incorrect buffer size calculations
> and potential memory corruption.
> 
> Fix this by changing new_len and loop counter i from int to size_t
> to match the len parameter type, preventing signed/unsigned mismatches,
> and by adding an overflow check before the bit shift operation that
> calculates len << 1.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e1d489bc2dff..32ac50996451 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2076,7 +2076,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
>  void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		size_t len)
>  {
> -	int i, avail, new_len;
> +	int avail;
> +	size_t i, new_len;
>  	unsigned char *ptr;
>  	struct sk_buff *skb;
>  
> @@ -2084,9 +2085,14 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
>  		return;
>  
>  	BUG_ON(!ab->skb);
> +
> +	/* prevent new_len overflow */
> +	if (len > SIZE_MAX / 2)
> +		return;
> +
>  	skb = ab->skb;
>  	avail = skb_tailroom(skb);
> -	new_len = len<<1;
> +	new_len = len << 1;
>  	if (new_len >= avail) {
>  		/* Round the buffer request up to the next multiple */
>  		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);

I might suggest using check_shl_overflow() instead, mostly because it
helps document a shift that could potentially overflow.

--
paul-moore.com
