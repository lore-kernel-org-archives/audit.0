Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750351;
	b=dPCOi1I6793CF9Eq5cU55oAc+8og4inU3rVpaSr+z87I4zWVUmbd9MkiRN7V1ivbAUFS
	 pureG67wCHlJcmjVn6XeidbkaA9VXrpV41X+MFs5RXdlSnxYN26B480bfyakrCnROvKhO
	 6zmSMFlU7gAvyJSXaoSb2yIWQ8nUUJWdIV9oU3Dxq5TTsWwAlZyBdNiBB2MsoTIPnO2bV
	 lnXo2ZNgwnzoZgRQtRa4huMtEcvr1vAE5SCegl/DZlSFv3rkDFHAbZjvIL2wt9RgcEZXC
	 htym+MpTTkjNbOC7jBnwFm9wVc5oqFfJWRMNryh1B1em1b+Q/E5zLjpsd1/06LzRcAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=9DuBOINHsvAa3+oM/36urWwZH0M8ilFtVOkyiuzlS/o=;
	b=fqBMc6p3gMjFbeSuIw5Iznzu1ogoCuUW/3j74/0ueuIrYEJ7ZzPoYkIH9UAMdjkw/rjx
	 dP8tycHnFuboX1pdW4lgY6V9KBQWiZDOKwLEsub3+8lxuCLGcRyTujnzb2T/Nse1Rywsa
	 bEVaCro1Uz9231j/8o8/Mgjc1Zs2QHDRDF0N20xUtBtb6iMTADtzyOw3qsCrmPv8kj8h1
	 jictYUIkyNV4b9FwRMPjOTnHOJU9dyR0GWlHEr1EPVYyv8JRKgduHSibx8K+LnsCNsHRU
	 IupNAYKYFop/dW4IdFGQplhfZ+DT4rHi60CxWW3GF4XLFxboV1PnD+YWuwsf7I/zj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GWG7UwpN;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E4606A339
	for <audit@vger.kernel.org>; Tue,  3 Nov 2026 23:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA4E4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GWG7UwpN
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e503815adso15006185a.1
        for <audit@vger.kernel.org>; Tue, 03 Nov 2026 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793750350; x=1794355150; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DuBOINHsvAa3+oM/36urWwZH0M8ilFtVOkyiuzlS/o=;
        b=GWG7UwpN2KPZH27oO5d/4HC7WWkiFgi3ICdUtpzqJbrVN0U4tmJxh8GcZuwUKzrDDM
         +Mum8kxq6dypiIEfZZKbvMK/qa/cGldqYRq5p6TmaKamcYG86RjMQ0XfsywiUnYRnsDo
         wXezLtC4esgw1qf8wWkJLA6wh/fpA0vsGNpoEyxCCo8DNvIMQx/B1LiD1YCH2p8RoeK2
         WFmGby7MVTHCfB5x+IzcticE+vF9zDblJcNQ9ophdFQAcsIk4e849Mx2VFumAy7ERqNE
         llOva0i6xLDM4PAWpIa5mXLy6gP8hiZ3nUjf5OOjr8TNfY3zfKtU8+poJqLIsqdvDT+v
         C04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793750350; x=1794355150;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DuBOINHsvAa3+oM/36urWwZH0M8ilFtVOkyiuzlS/o=;
        b=YNWP1Hnzx8iZIwIATN1ZaVe2lH96Wbc9jYFKpAB3DjJWDlVgC+ACsG4zAAcRJhGC4F
         10jiu2xJBdFvF0ym/hvaBdYpa2HI8glleRMQkZTaz6XvqDvaLsnvsnSY3iFL/nBImWj6
         1WzfXy2142eORtaIkssMycHntHjdaf6sDkMbYoHCv0kXtUe19tNnqyMH1sdC9egdbmKA
         A9eJKpR3fYokhxnsdvtoJgPZImT1MUWGia5bte8R9OaVwCAx9P5qvyZppZ0L6cb7HuV9
         ZCLHfMwbD7HE29fmp3jstMLfPmmAfAkaN7FMxLJfznasGCjvyvjC7mG/oXinNt/i0SUa
         /g9g==
X-Gm-Message-State: APuU4Z8CLO73Om6ergqF6W13a6/FBNXQdVeu+U7Z7avUnB4VSnbP5gCM
	+Oxt+lRxnzOVue0eD/WznxT3/piDk9ln02ZS3flmDbXIOOvEw2wJXoe9F3ZAx4bsUO/zC7yfYT0
	SNP0mug==
X-Gm-Gg: AYBFou1OFtf0Hndebh8uowhkOe+VnkmpRlDTyIDosQWYEWOnMhhdmi/w2Ned+jVIcay
	+BYEhacBpngBZ8RkUgBbv2sNVYhNHZWdjJQA76tro3+EylEvC9kntHhsN7Dc7YIW3jx4CV3S1td
	m8KjmRaO/VzoSai0/sDVGq3zunSesgjPIoYDL2r7BOjvmE1zVkzkl1DbMAMTrwKfWnkjYm9E6Aj
	6BrsvtKIbZHrWngUz0LyFGYJQ0YCrQTwmAy99VPs81kD4GIQxYOdgPrTgm8YLdHf3/gIEcpbZHh
	joWyeHGwkuyYT1VXiT0owz9Ratn1A5MaotmRh+4Ey3vH3pgi9H3E2OJAsfXsFiw8GI7NvEfMZUu
	xs+yOg87id5E/4FNV6ss0zMBn3wrW0jjkW7zp/NzKx8YsilsQC/Jgx2mAX1BDwdE9SmxGUI9v5J
	ldZ24j6niRwhJrtvhBx8xHxr68kEjT4lTJV8QaIhcEGtHN6ZU2t2Ar0y6aNQWKa1NnBB/D2j2/6
	lsXwicJ4UhDnTb53gIqetBRZ0qU5WJkTZPnGsnbOz4g9DvqqcN+lrguIAoc4xtsqn6//KKfouhw
	1OMzBY3nSfFurCe62p7vF1fucEn8hD815rAb8im38ovDjLtcRb0MMlyZ1rgVBu6ZWw06hLd1Pd1
	u7Hq/ddOr9+QN1Kr/cPu0CRlZzzNOrA==
X-Received: by 2002:a05:620a:319e:b0:93e:c12c:f12f with SMTP id af79cd13be357-944217fe8ebmr2401561585a.74.1793750349668;
        Tue, 03 Nov 2026 15:59:09 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48316f4sm57268885a.25.2026.11.03.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:59:08 -0800 (PST)
Date: Tue, 03 Nov 2026 18:59:07 -0500
Message-ID: <e43dbe68bfabfbaa2984ea5d923c6149@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261103_1853/pstg-lib:20261103_1851/pstg-pwork:20261103_1853
From: Paul Moore <paul@paul-moore.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Babanpreet Singh <bbnpreetsingh@gmail.com>, syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] audit: annotate the lockless read of the audit control  lock owner
References: <20261008034403.7-1-bbnpreetsingh@gmail.com>
In-Reply-To: <20261008034403.7-1-bbnpreetsingh@gmail.com>

On Oct  7, 2026 Babanpreet Singh <bbnpreetsingh@gmail.com> wrote:
> 
> audit_ctl_owner_current() reads the lock owner without taking the lock
> and KCSAN complains about it. Only the current task can store itself as
> owner, so the check can't give a wrong answer. Mark the accesses with
> READ_ONCE() and WRITE_ONCE().
> 
> Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=39b8fea0641107a1ccee
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Tested-by: Bradley Morgan <brads@mainlining.org> # Power10
> ---
> v2: drop the comment in audit_ctl_owner_current(). The KCSAN build of
> audit.o disassembles the same as v1.
> v1: https://lore.kernel.org/all/20261002011712.7-1-bbnpreetsingh@gmail.com/
> Compile tested only (gcc W=1 and the KCSAN instrumentation diff); I
> could not reproduce the race in QEMU.
> 
>  kernel/audit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Merged into audit/dev, thanks!

--
paul-moore.com
