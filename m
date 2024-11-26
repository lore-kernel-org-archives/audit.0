Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967191D54E3;
	Tue, 26 Nov 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633991; cv=none; b=qDU9Wy37zmNFq0RVhoapaAYFtR44MMr61kj2k+zMz5vj4zm4iOwGjCeXXbg2JG8HIPigBZpYz9O8KzkK7khx37WwYu9beFn2FAtJM91u29OaXGMchzW2LJr6Wu47HeHPHL0/1a/+a9zfOU14zSkJYLNMEwHZnpoSNTziOy6nsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633991; c=relaxed/simple;
	bh=09qdqt8gx+Pt0FyVLcARJoCsRJAEPy9MkT4OKKUAsqk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A8u/6llaMLI3nu1hLk1s1pNssEZCGw+z9y3k438Tla/P0cHurs3FCq3Nf0G4ozObV26/eyIsQF/YN9tfgMqkofz98ea5cl0X8TYJs5zzIr3fpm7o1f9Ps7HRTkaK10nfn4sriFjbf74TFS79L1pkgUVVvoVNmzamXVPo+bwVALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mY9cqW6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fGHa8JY0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mY9cqW6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fGHa8JY0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D6FE1140094;
	Tue, 26 Nov 2024 10:13:07 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 26 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732633987;
	 x=1732720387; bh=KArY+wRAq4+tAmshhSnviX78KHjT0+xunqtTv5VSLzU=; b=
	mY9cqW6S0UDCwVWDNEnXZNERlef8V8q8vGN00snn5hoxRRgkQq8kPDW9y3HwLn5+
	s+XINfbgssAVFLnS0JFBXxH75f+AQao0Rhp721saYUEiVl+JIe2Llp+hqGcZIHCn
	jgFNFqJUWHfQL4PFDxrwCElwNn9vmFstvt+Rknlthhv88Advard3NM6BFteJBZBd
	fQH3hz3y5VNASwjxpaTnDij87QhGEHdgrmOz9ugBT9J4fJokUJYfrxU/BF2pfXmp
	e0XoDNoGzPDXQ46Z3IvBBMXiEnyfCsuoThN6/Sjy4q6ES/th+RcLJG9ivemiVggv
	Coukv+dO7ttbehr+OetUNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732633987; x=
	1732720387; bh=KArY+wRAq4+tAmshhSnviX78KHjT0+xunqtTv5VSLzU=; b=f
	GHa8JY0fM0z9st5fsN7CILUwxegd5o2UmRRmNrlks4eOA1iUMTZdZn9xnHZbfd1O
	p0MRJh1zOQb6HOezWbV0h07ucYspzhubCSz3nPvrEkJeEU+9fMZA2Ut8MpWmftAx
	oWvUdD4+qIgNPggB5ROvBBDW16dlUqYGD34WlAEJqKqlmtEplGo0C1lSLJFuFsPH
	L+z4eUIyjdO3bO6YFseJbYXVkm6bQ5TsRz5RFvlZd1/oOZG7Q728OFDivOoow5dP
	C0EXC5e/5R8CDWK6swdv4eslwwlU/14rE+uphg2FKfkXonoYcRTbsEqmgAbEkp4+
	54M1EDhHn/lkVK4S3Ouhg==
X-ME-Sender: <xms:guVFZ21d6S-LoZAnorRnQO2brWaAzN_SIi1G8SmTelTIaaXvDNhtgA>
    <xme:guVFZ5HRvv7rgANytyfHFtApasnKcbzXOBbsRf66zZwQK0VMKbtp1IEPuXcVvg08I
    fF1xwRX3yJFcT16dIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlrghorghrrdhshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgu
    vghrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrg
    hrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgr
    mhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvg
    eslhhishhtshdrlhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhn
    sheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehprghulhesphgruhhlqd
    hmohhorhgvrdgtohhmpdhrtghpthhtohepvghprghrihhssehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegruhguihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:guVFZ-7Yk84joLjezYyGmV8VZTv1lHAS62S9RMb9Qy0Ks4jJg6yhsA>
    <xmx:guVFZ32dJG7VVuMvxBy-g9KP1CBKMr4Ame4FyzGbKDSkqdL77PuIdg>
    <xmx:guVFZ5EglZwbcplgR_vL7I4fajKZfY2xJhNRDBFe1_Vby0T3lVWaeQ>
    <xmx:guVFZw_AU-vnqPl25-S3doEEDlcaASVNznivic2zVI_fX3flLhwCLw>
    <xmx:g-VFZ4AXQJr_Ou9N66JhAEIlhWocwcZeW2D6q3_R_SJiMMbBDfdG2Bx1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C0CC2220071; Tue, 26 Nov 2024 10:13:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 16:12:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>, audit@vger.kernel.org,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Eric Paris" <eparis@redhat.com>, "Paul Moore" <paul@paul-moore.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Yafang Shao" <laoar.shao@gmail.com>
Message-Id: <29ab783d-86e2-4528-a6ad-083f8baf56d1@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvWkS-8f9kOBTzixjGSNN8262StoVv2ERk7mRKcU+p+BA@mail.gmail.com>
References: 
 <CA+G9fYvWkS-8f9kOBTzixjGSNN8262StoVv2ERk7mRKcU+p+BA@mail.gmail.com>
Subject: Re: include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 26, 2024, at 15:58, Naresh Kamboju wrote:
> Build error:
> ---------
> In function 'sized_strscpy',
>     inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> include/linux/fortify-string.h:293:17: error: call to
> '__write_overflow' declared with attribute error: detected write
> beyond size of object (1st parameter)
>   293 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
> In function 'sized_strscpy',
>     inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
> include/linux/fortify-string.h:293:17: error: call to
> '__write_overflow' declared with attribute error: detected write
> beyond size of object (1st parameter)
>   293 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:229: kernel/auditsc.o] Error 1

I have run into this specific one before but failed to
come up with a working fix.

I think the specific warning started with

https://lore.kernel.org/all/20240828030321.20688-3-laoar.shao@gmail.com/

but reverting that just replaces it with a slightly different
warning. In my randconfig tree I have a patch that comments out
the two security_task_getlsmprop_obj(), and I don't think I get
warnings at the moment, but I no longer see why I would have done
that.

      Arnd
