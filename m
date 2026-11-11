Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395910;
	b=s8ki6HU5H3fpQGMVa+KgzYMnBAKiMuAEbzy82oSvw6QH/8e7tvtazj0y8jFNU0NV7Qkf
	 EWeR39d3z1oMpR/rL9JjuiQxnb3iBNSPelwN50ba43KcI5IiQtmtVejRzmvJhn03ozmud
	 qzVm/W2xxTnBcrdYPyfJXHJq0TKJIoWpmfophX9M2UniOzs/ZtIY0y8EWD4gpsEVUzXXB
	 4K6PRu50vrLoeeyaObaLWcGzIhlLE1vIu7f2UhhlzopCF3TidWXcDWI8JssD1Y12WAKfk
	 jJVKO9BuDbfKx0UYFHqoItNaa2KvteXipKqBAU/J5OnAxvoCpLfwW1LJTJuAOHcNrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=2naI8V6x44s+b3e0fqUVTpUd5KiO9jYz1ZEuXTSEtHc=;
	b=UX1bPgm6s1jZ7x/e15/I4emtKoJrRozu6s5VK5K3Yvd25QM2xsQQLL0qJ1HzEnNT3nXs
	 O2ICEiXDJQDCHnX3iIODjMYsr9G8nF8GyrdKMQYRJt9tt8L45+nD8A1ReWxrXEzbgw/bC
	 rhXhurufapk6mhbpn0ac4ITbTYKVdyi8E8IIEXufl/MqHjfIkJIfnfjl8/wsbsKns1/ya
	 t6l6g0bv15CimaFM8NuCWZvqCq43Jq7fkIlQTNo4v+E+UecArOgKJ3KZE7fTTEom7fbD2
	 GQMuooNaCM7zXUb1ixPruQLLBYBUVkRFrMeXD/EMZ3AG5tfGWG0M9RsBaf0hcUUr6Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=DANd6YRb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RDgbgZk5;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E10606A31C
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 11:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=DANd6YRb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RDgbgZk5
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA36414000DB
	for <audit@vger.kernel.org>; Wed, 11 Nov 2026 06:18:27 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 11 Nov 2026 06:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794395905;
	 x=1794482305; bh=2naI8V6x44s+b3e0fqUVTpUd5KiO9jYz1ZEuXTSEtHc=; b=
	DANd6YRb6JnLSJlZxt0H/DrJgMRh6Bwi+3uwNYrWjLz+D1n7StDZ7GhA5n3Pgl3Q
	QA2GO9AOOlbd2U7fG1itud6TZKs1wuB7YQw8DF29RYpoiDtQjqEGu2Xem9KiuXiD
	ywQ3D1H9bpZNQuqAr8DEZpEeZafD30lSSQwthAPfDQUEUhGfk3cffB4K/xSN6o4o
	YlytyspignpmGXqYOonGd1zVPNPC+xWIDfroQqSAMhPfGgq9J6ntJpbinCNotcNx
	zVX2PUKrod8HXHa2mTexvRMS6g1+uXQpHoCxpY1VKGNXTyQ0pYCZp+2CbzLXX6mB
	abypSxQW72D1Ua+Lo9Wc0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794395905; x=
	1794482305; bh=2naI8V6x44s+b3e0fqUVTpUd5KiO9jYz1ZEuXTSEtHc=; b=R
	DgbgZk5DdHL+slhmhBkM2Js5wx0DEIQMxcx3uqNgfVVjTNi3LYkmidAM45U5RBT5
	tBwvAp8eiJgmWemShWmuYarq3Izvx8VVIWgc5/sxGj7dqNiGX7uDM9OK1dMVuzzL
	rPx88zZelyzVkF4KRIxY3cjdNRBXC53SnlPYAZy8Npfo9vBsYjWu4ThSdIK8aOXZ
	R4xuc7kOAp8vDgA2pV69uCIdWJTzJSJHRqyB299JxY+mA33Wq2G2Mjhnf8rddl1b
	plSP15mTVjxn3aBn6mvRa6oeQP0bc5ctzi1I6ngs4eyRQ+4iJq/6+CKnUglwhqwF
	EpBqutLuXgRTHuNlvI9ug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794395905; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PGF1ZGl0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:PNNsAtu5kveGHEd/9dtLXR3fXzMkcdFM65T0l9H0MPFrfvZ
	gER1m4eVX8ylU6+ZMYGn49rXIigGP9mRB45rr1UttwfKxFVDOg5GEtceigKnnaa1
	7ilIRYGq6se/oVv4YdL1nTEGliZgak6XGb8SDjYpCJK07WQHUkc0RQOBA+4ElupA
	7s8yZ1/ukA9VSKAyRP12m0YccMAt4/mIrzxrqceH073IEwKMw5uAsvnZCaPxKJ9P
	R4CWv0MpirIGrBXs3SyyLTc+PbWWH3tvfOtKiFhxELcXDvygaMB5i5uZ/3qfdiz1
	PxaLv7g5QgMNWxx/CNopfJyapeCfUf0QYeNYrlg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8Mi958utAakp2sYxBNcZabiO06Gm3v8zp1gjOI3Wo0o=:bICPIpF/J9LCSVxxGsuyc1UB0Kkifxs4nyUb4LlfVbQ=;
X-ME-Sender: <xms:_k70ahc-fQTpUwTJ9TQb5A75LqpbQmfc_t76yCItVKenqNr8QS-HOQ>
    <xme:_k70aqDt3nnNk7L1NYBr0glSiD3BZ3tP9YzzzLcPmG56UZW3BVORUK3IbYnEVPwJV
    tkEX99v63aXy-tG4HD76rs8j7BtJMQOLR-_pqfr3ivOdq4PS8hwT94>
X-ME-Proxy-Cause: dmFkZTFboftFQnktVHHeCwK8Qq4eUL/jmPMFmYesiFAf6XsVAajF8mVles1YhuR5y6FN1c
    UrDA9MSOSOM/sxCmWqE9dyCLtqseCcJg0yWk4dT9DWq6ReBhV8II7NUB9tvuaRBfOoo5/2
    ljEBV4aZHn09/XqRWrCzuT4hK2TKMyLnli77tHwdyqPSBAKM+3Eb7MJNzv9hZmQonEYdZw
    sWBK284ikST/Rdy3KQRmxG8Fm4ov/hyQktNjys8b8hpBw5jtkkwYV3ZgQH0k1CdHCFPw+s
    r91V4KzJZl4JMgMkQZb0fUXTmRt95XW6D+15o2lv8NG4aQd9g1FP8LKC5vftzY3QC2IuLZ
    3O0rQv5OMnzauQYRe2EgtUFIzHee5MYoZSxBjMU4yM8JKFwad4mARpuuQxE1+O2aAHRpGL
    7LjH8AgTz+AOZbfO++P2O32r4+ju0/msqvq+FWLhuLZlk/aPgj6FZk2Dke1+jP9Rfb2p26
    IVENzzWUG7aPIXfJdcNo68lU4cFUeTlUNxbh0TPH3Gi0Hk99cExAgHt9Yvk6/GOF3eBnIn
    Q7Wb9G7HytZPodblVsrQX829fW6WoQnQLCCTAxua9mnayHF6DroGYrwfLmtQ9R+3Hwwo84
    Pj9EaLS1HOZAkqo7jjbWXHEMahTJOWo04z/nQK8J3i+DQIFvIt8OduUVN6gQ
X-ME-Proxy: <xmx:_070anCiSlkFqJB4u1hK6DnPzTESE6rR-NAkHEcmFW17fMjdkERDjA>
    <xmx:_070avzNxfAImndN5QEReW2dIGfGRKyizWJ00A3ANsUT2OQFPGJEDQ>
    <xmx:_070ak343JJ99NJGTM-49rzdZ_fFPSU1R-TOxBEkIgQeEA5G5497PA>
    <xmx:_070avxU1koAQIOvRUS02VHJd_hFoV4b7BlmN0pnI_qEQgWsND6hiQ>
    <xmx:AU_0aulfXZvb40rC2PQkJLs7y_kbOkruk1QJiSEnFZFqJAZCs8RE2j6n>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 34DB232A009B; Wed, 11 Nov 2026 06:18:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AgpoH-kgjtug
Date: Wed, 11 Nov 2026 12:18:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeffrey Bencteux" <jeff@bencteux.fr>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, audit@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>
In-Reply-To: <20261111110200.30415-1-jeff@bencteux.fr>
References: <20261111110200.30415-1-jeff@bencteux.fr>
Subject: Re: [PATCH] audit: add missing syscalls to signal class
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 11, 2026, at 12:01, Jeffrey Bencteux wrote:
> diff --git a/include/asm-generic/audit_signal.h 
> b/include/asm-generic/audit_signal.h
> index 6feab7f18a53..65336a9aef7b 100644
> --- a/include/asm-generic/audit_signal.h
> +++ b/include/asm-generic/audit_signal.h
> @@ -1,3 +1,12 @@
>  __NR_kill,
>  __NR_tgkill,
>  __NR_tkill,
> +#ifdef __NR_rt_sigqueueinfo
> +__NR_rt_sigqueueinfo,
> +#endif
> +#ifdef __NR_rt_tgsigqueueinfo
> +__NR_rt_tgsigqueueinfo,
> +#endif
> +#ifdef __NR_pidfd_send_signal
> +__NR_pidfd_send_signal,
> +#endif

Why the #ifdef checks? These should be available on all architectures.

     Arnd
