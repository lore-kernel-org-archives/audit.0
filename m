Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B70155303
	for <audit@vger.kernel.org>; Sat, 17 Aug 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912005; cv=none; b=PFS3UTygDNydf53GbH/i3oQTWMI2bmA42XOtvsO7rShWRZAyvZ4PA4Dl8Fg/4FmWtNN6KzAQi8H5+oxsBKY7AzHiYCIShCeAC60oUi0jsrIkLxrP+VhbnPXUugVU9MAHel4C8VZxQ2fPR1p0oxrvbcnjbKwUXhmEAjiKaAH8uQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912005; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOaa5nGbJP08+wlyAZ3YACNVWIm5f+LfTyOJO8BxiIJyv3Lnlkm5ZFgNE1aXGWsm96YgL66TJBrdCB3ii5Y8Mcv0kLUJiilKEAoOQGyRvD3sIsU+/oEVMwWJVnk5fcXpzXdm9BM6F1pSsXZRI4c0cJZT/ShSm5k/fuWmkXtnIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wb8Qxq0Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wb8Qxq0Q"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5332f488c6eso1024052e87.1
        for <audit@vger.kernel.org>; Sat, 17 Aug 2024 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912001; x=1724516801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=Wb8Qxq0Q6QlvbrL4LYHVdGcdP1ReqQ6RM71H9fGG7sYMu2jIALrtu4opf2UmjB/bDW
         EttNaZssMQoiZ5rBDaPL3jPPV56ajuJx59Z98XGZWo/EZ8HZEjBVvp1SZxOwQcJnm5HH
         bUJgmTz4wZmxQT05vumNN2OOUSwr6LKhmtKYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912001; x=1724516801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=Tu2ZoGhP50Cq3c7TkyTlx9RVBTn2LvzFhWRHAJYAkRTTIf13T3D3nGpi0nKdpea4dB
         v1HE6rIvX6XE+pK6xOotnLUfjbsj5+i6kvLbYjnSrQwqIGB7rM76duzd4zsb3YJGX1ie
         H2V1Kumj/7a/ii+LT301x5F61c2+XoublZSjZ4SQ3olpJesa6TVveTOKSFofEFwK1+kg
         HDjJK+gSkRu15PW+4QrW4H/8eRlVTnutC6xt6n8/GvTCxL62m6D6hsu/E0CbbkdokSjl
         zvfk7+Y76cGTTFEXcaFcXBZ0IuRkiZkVu1AUj6sQSHT924eoVRQm2Y0kyhw0VRTh5p9Z
         lmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS+Rg/KGLL/APZQEU+ZGAc7hux4527DyK81HsX2G5oW8n0SUodoG6lnJJ9przzQ3Q74yrna+TT6dmMqne5FKM0xozWRYw=
X-Gm-Message-State: AOJu0Yx9rMTrk4gclrP5LLDpUl6g0dJkRRwWbGKINGWsJA65ENzh/fRV
	/Ost9NPIwQ9CpxhS53LtrcIRmzVSYCUEYEOLbpe4zXirIY9lIqQMrlXNhACWDHWyZKGTFwcqXJu
	8JJj9IQ==
X-Google-Smtp-Source: AGHT+IEbdDLnEqiPnxjRC25uLSBlDgvj9IbQH9Nu6lwAdl5sIZlsfpg6+haprr6LOKvndfrW34riPQ==
X-Received: by 2002:a05:6512:ad0:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-5331c6dbb04mr6052464e87.42.1723912000811;
        Sat, 17 Aug 2024 09:26:40 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935984sm417218866b.116.2024.08.17.09.26.38
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a2so530663a12.1
        for <audit@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV391y4slCUCpm52KqXn3a3i7AmfnXtVMJINQ5b5WH9bYcSeXE3ifn202XNagz3wPPS0zeZAc9n3s2BJ16QyoZ/upmj0BI=
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus
