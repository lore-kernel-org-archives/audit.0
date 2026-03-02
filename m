Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD93750B6
	for <audit@vger.kernel.org>; Mon,  2 Mar 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487067; cv=none; b=PDmKUNxEiGE2INasnn32P2R97MCf6ub5sf8+EmCJTi/oeMPZbKzzrYu531gdo+lxN29Nwmg1GdQL7dvcrIe7geo1dQwjeVIa57uOyL3/wQMlNZdJEA1lFoWYTQkUHAnm9WCn8o32ei0K0t1FC5twoQXyLMcco4X+CaE00PBQ3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487067; c=relaxed/simple;
	bh=xeq/JliYqND1pP7L0yebjvPCa4N5WEHWDMDdTXPrrFc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FkWDr7PPMi2FXuqLYjS/wXLVqP8Xzb4mxdfgEtXgh+TTDu0qLvMA/LIFpIW/9j8rDIzkf9IpNTkJf9JK4llwqZBPpQuRmVneob8IS2pjAh5EkRotq6PYJ4HJgYs/e4Gzf67Odp1LeW1RJAjqNABmW8dEow2givawofcTY/ih0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R4bRFlj2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R4bRFlj2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899ee491af3so20290346d6.1
        for <audit@vger.kernel.org>; Mon, 02 Mar 2026 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772487065; x=1773091865; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmD+LZ01dK2EEXbRScwmOBI4beBwoJ5UhOhQ/5z+VAU=;
        b=R4bRFlj2R0kQOqt675Blom5GfcKz522VoDdrnPb1l7nE+weWcy1QgdCK1rkGywKePo
         eK99OzjKahiBHCY6s0Cc4/RVCRoQKSxbSQwnjfshdVnNEyBG8fFjnnXVr9g8JLJt+jsX
         tIQ4R+TuQXKmFR/QxEtBPnXvUac5mWCIfUt1OrF89V1Ip8FsmgF19yqFY0lZepjaa9zv
         o8MpcSVBZkupneTT2sPOwEdRH3u5cMlTuV/zX+Uf2hxnQhUiN+xywmxR3O32v0w7OrXq
         /UzkrJtJu7dTWvTki2VnveZnmEOm/6zxWwYh3R4IYh7+nDNJE03AT2cf0W6xUs/QPkcK
         5p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487065; x=1773091865;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmD+LZ01dK2EEXbRScwmOBI4beBwoJ5UhOhQ/5z+VAU=;
        b=vtOT9eMxeBPHgJHH8Ku4d00RyoiwEeSIoGKUQ16KOmBu97u/qUGs6NmCAKheWGi3Lb
         3qVpOq7AcPEaJQ9dA90LpcPHZNZko7m88OED8paLv9I0T0rp8yLkGZAtJUv6SJ3AmnTx
         Oqoq2rWbpky1g1yJyQXmBzBnf0Zd1Y5sDTsmO3uB32J8R8tqh/JAmYxfuq7NRAVzOUOH
         srNYsqJi7nEVLkgJdCeRUPnyr4gWDFZHaffT7E8jw5wGcszLVcYZjSZ6hnY9C9icxw38
         oldDrCwHeD9kEGgKkl8B3bDLLv0QqV2OwLSRT7Gjf52Ow1tZZ9ae9LcuVDolyrPh09vQ
         AjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcuNvrZvVGFR+PQWqUpmcuY4EQL99+TFByF+C9lNi2pTxKX3JQcxo8vbdHX/+l7rAEdfdLtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0DLK/YdPLi0t5xlqqYqzKj6LwUA/0rtdw/tnkr6tLJqsNu0O
	Yt1LTuZYVCLLiWxpqkmuebL4Efi/m5BzmSK0mJpfK3FsvDI9q4W6nRUHQgEXNWwyxQ==
X-Gm-Gg: ATEYQzzg/ufiyc1VGO6+DK3JRibrvyj+UAIb5OCLWtKOYJfx590dXBxHCMF2Z/sUgRI
	CRmNvNFVLEd/veHIlRlAVt6cTsi8FhA9hY1oXDyIzq0Ox/vdoOCu7yeQ7WyOqhfq3w9onoElABs
	vp5rMCeEkSWEskD5AOLAP5+m3fKGiLavQK2GH9ZoMYCUPXJ+owAYczyMX+IybBJljoZ0ZOkIlxX
	o0H3CL+jIQtVzuyb2D/jCOX/Yog2gt0qj7DLGdjqfuIoEPX5otJ0QyBjeobF6jUIb0U3g2X7ASg
	c9nnN1ND7aiVu3fzA0YjvOj/1kVaqVxw2vNDZsGWetSL6EqjKaKgL117VgKvd1DjlYKQGmu21qH
	MUI1y+QLnvKdz4RcmbAMteuPHlO9Mv23KrEq4n0lqGrGc0/MQWUafswz8Fe8Zs7c0uFE6gg7jIo
	5UNjnbAJhaB+sZAR0yFVSEaU+VvdrtxGKvJ1CLDPu87IVKGAEd/F3xFZ+xsIX/t+5TUpB2/uwJz
	daqFG0=
X-Received: by 2002:a05:6214:2b0b:b0:899:fb77:a1de with SMTP id 6a1803df08f44-899fb77a492mr68879936d6.5.1772487065021;
        Mon, 02 Mar 2026 13:31:05 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd4c992277sm79408085a.25.2026.03.02.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:31:03 -0800 (PST)
Date: Mon, 02 Mar 2026 16:31:02 -0500
Message-ID: <ec57713c0a9c8b1f13f74d1cbb0b18fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260302_1612/pstg-lib:20260302_1053/pstg-pwork:20260302_1612
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: fix whitespace alignment in  include/uapi/linux/audit.h
References: <20260226171546.2231505-1-rrobaina@redhat.com>
In-Reply-To: <20260226171546.2231505-1-rrobaina@redhat.com>

On Feb 26, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Fixed minor indentation inconsistencies in the audit macros
> to align with standard kernel coding style using 8-character
> hard tabs.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/uapi/linux/audit.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 14a1c1fe013a..410dfb41b810 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -350,7 +350,7 @@ enum {
>  #define AUDIT_STATUS_ENABLED			0x0001
>  #define AUDIT_STATUS_FAILURE			0x0002
>  #define AUDIT_STATUS_PID			0x0004
> -#define AUDIT_STATUS_RATE_LIMIT		0x0008
> +#define AUDIT_STATUS_RATE_LIMIT 		0x0008

I had to fix a space-before-tab issue in this line, but otherwise this
looked fine to me.  It is worth mentioning that checkpatch.pl would
have caught the space-before-tab problem; please get in the habit of
running checkpatch.pl before posting patches.

Merged into audit/dev, thanks.

--
paul-moore.com
