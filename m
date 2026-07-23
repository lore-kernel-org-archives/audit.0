Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC83515E8
	for <audit@vger.kernel.org>; Thu, 23 Jul 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828641; cv=none; b=Zz7DAlTbD3LVU8srmm08s0Ob7VHF4/1QokGdr0JY8Y818ZSaHvBx0TOuCNMcXdGZ935BzIRgodNPVao574mIAD9PPW9ek0ETjdBoW1GwNwCP9r43tSakxz58usmIOQL7lJIqkYkvfbmX5l2okkY7LZZlb9L3NcBsU7iVRxvCPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828641; c=relaxed/simple;
	bh=7CfLiwE5M0TCOSUKAJEyT22HQx9DD5s4V+fJwhTJWV8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aO0DLXAFZgqUQ88cP775ghg0Lu0YuRVGjl0m1CmgohwpgNc2ZGQMKO2ruDrx3+Js9+EhJg0FMk0ic6hg95I7BidmRJ0TqGMk0/cOeM3MXBpAMbIGIpIwTd6WLwhTuZfvoWhgwv9AsbZgSV35GLZcBl1tAasxaJ2Mk2aLLHEADs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vr71dgUz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vr71dgUz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so8694796d6.0
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784828621; x=1785433421; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brmtQMY+PCLY5SqHqKFMvLTgXx8Pdh/IhOMrgYqDWxI=;
        b=Vr71dgUzOAqYSVvjqBnD6ZQCE3SPE5Mmk4qfCKiMbM9zK5Zr4I8p928xXutV5b6dN+
         qgIWEu4UiU7JjrDa4b/fmYS/1mGAkKcs8vnDR9BihkanA6IU4TSVc0gY7gO4hTu2D3z2
         iMkBy1bOnr6rYTzrO+OgDRZuRPEedoExVPsjfD2V8miArtLe+od5z8UwDMSxPFDM791O
         HSySg46wlvWky8fNj4rDm7MS/iWMRHLeKpMjF6GEjdk5jCudU61Zv1QSKC5OcyzE4miH
         QRWLNdXpD5oyRK8mRueLgoJ59UDZJQLfMqeafDuPdrCKWKSvHT7uYiA9DzJqSKPJkgEi
         nfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828621; x=1785433421;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brmtQMY+PCLY5SqHqKFMvLTgXx8Pdh/IhOMrgYqDWxI=;
        b=X/cRX0XecePx9kls+WQcqlV9/06Bn9c/piOPy2egS7mUNEsj41Xr00uAzDU+d/Pd2u
         1FHyy+laKrM0vaG3yEM1L8qAf5pjy47NBeA4dPoWiyjiEgpVOAocjL4ldWY5KxXBpfbk
         umdG2S4H87q75S2gCFlsY/akQmggku5y7Bw5EG3CSh13Q+HehqIs7emGOvlfgaxHv9i/
         Iwi/PEw3FD59PBaPk1T7YXos7rA1SPLisPiSOz4OE0PZFfzduEm3A6WhteFkK1vWaS5r
         286uWqcD4oeUzcj781VWzzZrASQpTqAK2dvJauwUxVruBQOabDW7b/VYtDFCQt/h3hKJ
         E5vg==
X-Forwarded-Encrypted: i=1; AHgh+RoT3LFEHGmXI/w4RR3OuKnD3TU5d+FdWIvKgrjA1vI+kD/YQUZ+hWvdYARsRq5cy4WujyGl0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxujwDXqNhvUtM2slLhjW8fnsishCFmyDmsSv9KTKVJKhXJ0gt
	1EBdPmUOQRufZxVx5j1w0r84nCDE2KXAvovgLMRtc/EAtIZiC/epho1wvZNl9a5WhQ==
X-Gm-Gg: AR+sD11hklqbxpb4qm+kzjFKi1zkaBukViD7IMZkelBza59JTZq8HLq04/bwjZMkC+E
	fMNId7VHGt+OwHmRNQelo5Qw3tm4tH+Rx/2cRUSPO5iGeWfwoYqY5bnjkP5bKs5M9PTDEtxT9+P
	/G6xswWf1KHzJfYPbI3Bgn4zNwKBUsaLo3MKn/rMLBZW+zlqkDu38Ere6j24IU6LW5oRQGBgg/E
	Pmjre0EsU4cs4h0e+wU0mM0PljcA5YThjJN8P0S8VAb7017xuq/8mcLv9HrO+i9x4mNLTo5NIgm
	tJusCZd55b2kdQuHbig6dog0gIkf5PB87oM94BbcKqJ9Lk6iSinwm7FlompHHy1zz9R8uujLauf
	wrJpLosZPGJqoztCEe/78LPlWylY/T2117yI57mwP6UmXpMALhkG1bwTkEftMOaQ7v4OUfxjNnZ
	1htNfYONohVnE+s95Bud95NdSA9A5SPZcVrELbHvOUnBR1Y+rLinHZ2jIDjw==
X-Received: by 2002:a05:6214:508d:b0:907:6fce:b82a with SMTP id 6a1803df08f44-907cd19b0a6mr33743506d6.23.1784828620932;
        Thu, 23 Jul 2026 10:43:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba901c24sm49954856d6.21.2026.07.23.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:43:39 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:43:39 -0400
Message-ID: <d79fe8753ff88268bbd9bcd601cc4aa1@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260723_1338/pstg-lib:20260722_1430/pstg-pwork:20260723_1338
From: Paul Moore <paul@paul-moore.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH v2] audit: fix potential integer overflow in  audit_log_n_string()
References: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>

On Jul 18, 2026 Zhan Xusheng <zhanxusheng1024@gmail.com> wrote:
> 
> audit_log_n_string() computes new_len as "slen + 3" (enclosing quotes
> plus the NUL terminator) and stores it into an int, while slen is a
> size_t.  For a sufficiently large slen the addition can overflow and/or
> the result be truncated when assigned to the int new_len, so the
> "new_len > avail" check can be bypassed and the subsequent
> memcpy(ptr, string, slen) can write past the skb tail.
> 
> This is the same class of bug that was fixed for the hex sibling in
> commit 65dfde57d1e2 ("audit: fix potential integer overflow in
> audit_log_n_hex()"); both helpers are reached through
> audit_log_n_untrustedstring() with the same length source.
> 
> Make new_len a size_t and use check_add_overflow() to catch the
> overflow, mirroring the audit_log_n_hex() fix.  No functional change for
> the in-tree callers, which all pass bounded lengths.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2:
>  - drop the unnecessary (size_t) cast on the constant (Paul Moore)
>  - emit "?" instead of "\"?\"" on overflow, matching
>    audit_log_n_hex() (Paul Moore)
> 
>  kernel/audit.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Merged into audit/stable-7.2 with the intent of sending this up to Linus
once it has gone through some testing.  Thanks!

--
paul-moore.com
