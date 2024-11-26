Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2DBE46;
	Tue, 26 Nov 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638425; cv=none; b=d95P/KMOitO/UlnUiHJ4HqKPW/ZagBpGRUsKF//cBlcydMpTD5ehTGyJSsnOdURyVlcAlTVcBOrM1wwlRFhXPyl1GB3QVa/QOGBGNQ61j3m+5FvBLFD4dJrz9uqrefwYnkGnfpCcC5zsnFUmSf0OHJ/usHO/7YV6h5ZK75yAymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638425; c=relaxed/simple;
	bh=tdF3p5jMfre5WPiRhxJ6n7OSlkK3elNOqhBX4D1qj+I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pGkBc3j0HpC/BMPEj24hzKWn+GKq9bRFkwIxJsXDFY90yXupUn1dKMB4k/MzChrzk/6u62LoBnZikIXT92wwXcDnEmThL2fESsGplhrKaOX+gjRJdKPWUJmk3ma+8rzwf5zBPOkqjMVX/0MhX0dPusboXOYGoOE284yOOqHQ6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qGlB97sx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfsZIWC8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qGlB97sx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfsZIWC8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 547161140199;
	Tue, 26 Nov 2024 11:27:02 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 26 Nov 2024 11:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732638422;
	 x=1732724822; bh=JEcS3cFLegK0rV+tV4ShlO64Vj4HRyL/7l6/xZXe0Ts=; b=
	qGlB97sxykjDRisvkkVbxsMQHNOEAI6fkyCQbhNeNJVTEjTEAZTp0Ep/BmFdJl7Y
	VWjd/Z6Zclv/PtgZyJhH0bCPa6C3nj7EVCi0AJn8zsS46BvB/YOD1bsH9QMF+aX2
	MBWcu85db/Tlu3Y2bLHlGijtKRN6F+8yIMVAunfs05WNbV9sJ17lrX9W0dqg3VO6
	ahJTaPtXqp/4lyI2UuVTGMQh8DPthbDTyyd9Nq+3KMADq40xfmE7l9K1vvfdsQqq
	RzezTDxBWS8OYsDPKv2KO76TVUWSkGwymaBiIp1VT5tlDgaRHoeI8KyjTu4CuLEX
	zmN/34y4vDRD58pXJ9GrbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732638422; x=
	1732724822; bh=JEcS3cFLegK0rV+tV4ShlO64Vj4HRyL/7l6/xZXe0Ts=; b=T
	fsZIWC8hhuhSDlbSYAx0O7kEeJRXQeJOnM03R8mkpsjKnPXn3b8/LY94dszKqvFr
	ZT45pI2/cLtrBPqlFa+7iWTlp3JsxHDlXhR1oJZumxx25qgK65V9cl4e6tJDYv3P
	hRz1nsDiBxXODnAAIbAKigWFAOZgF6X+m665dHyLpknxpFMbH7+RCtxFceIET3mg
	C7bIClY87RqkLndLSCN06QMhePt4twNmGup03NywQ/REl4vk4MUV7uBKDPjexAd3
	4AsVSf0NKW1N89T0guq5v9aPHlgQueCZ+okRknC57iORmxBP4dEVfx4toLEjc6hD
	Z3p59cScd2Sy9uM88XZPQ==
X-ME-Sender: <xms:1fZFZ9zBWL-wOzuf78R6UtqJswZcbdreBoq8fNGd5vuSSuLDgDglAA>
    <xme:1fZFZ9ROvP0M-CA_5uq-NUERuJalH-pRKpo6EahTevj3ZrPd8UwBC8pwlX9HuEF_r
    y4UdGDckYrWCGADvIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlrghorghrrdhshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopehguhhs
    thgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdr
    ohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrgh
    dprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhr
    tghpthhtoheplhhkfhhtqdhtrhhirghgvgeslhhishhtshdrlhhinhgrrhhordhorhhgpd
    hrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdp
    rhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhm
X-ME-Proxy: <xmx:1fZFZ3Vg0LJ-BaMH0XPy9Ekjv_rc2ELuSnWcbn3kF1NlXbE51x18uw>
    <xmx:1fZFZ_ibIQCFPeXS-hU56vxBYIbn_n347eNkjQnKO3YYJWxSIlg3yg>
    <xmx:1fZFZ_D8U1W8u3mnAgqhRoAbVYB-jaHjJ0V_06J9FPVqb26Po8Z3Wg>
    <xmx:1fZFZ4LuKJhxliIAtgFfwmdNNcFubpCM8PNfSxQfo63iH-GSIeyEew>
    <xmx:1vZFZ8KlvwVB_BnmaG2gXMCvhqWnxzFTEYucLR9e43_jb6v9WmFJDQgi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0EB42220071; Tue, 26 Nov 2024 11:27:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 17:26:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>, audit@vger.kernel.org,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Eric Paris" <eparis@redhat.com>, "Paul Moore" <paul@paul-moore.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Yafang Shao" <laoar.shao@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Kees Cook" <kees@kernel.org>
Message-Id: <4153e658-0ca9-469c-ae96-4ac615d894b8@app.fastmail.com>
In-Reply-To: <29ab783d-86e2-4528-a6ad-083f8baf56d1@app.fastmail.com>
References: 
 <CA+G9fYvWkS-8f9kOBTzixjGSNN8262StoVv2ERk7mRKcU+p+BA@mail.gmail.com>
 <29ab783d-86e2-4528-a6ad-083f8baf56d1@app.fastmail.com>
Subject: Re: include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 26, 2024, at 16:12, Arnd Bergmann wrote:
> On Tue, Nov 26, 2024, at 15:58, Naresh Kamboju wrote:
>> Build error:
>> ---------
>> In function 'sized_strscpy',
>>     inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
>> include/linux/fortify-string.h:293:17: error: call to
>> '__write_overflow' declared with attribute error: detected write
>> beyond size of object (1st parameter)
>>   293 |                 __write_overflow();
>>       |                 ^~~~~~~~~~~~~~~~~~
>> In function 'sized_strscpy',
>>     inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
>> include/linux/fortify-string.h:293:17: error: call to
>> '__write_overflow' declared with attribute error: detected write
>> beyond size of object (1st parameter)
>>   293 |                 __write_overflow();
>>       |                 ^~~~~~~~~~~~~~~~~~
>> make[4]: *** [scripts/Makefile.build:229: kernel/auditsc.o] Error 1
>
> I have run into this specific one before but failed to
> come up with a working fix.
>
> I think the specific warning started with
>
> https://lore.kernel.org/all/20240828030321.20688-3-laoar.shao@gmail.com/
>
> but reverting that just replaces it with a slightly different
> warning. In my randconfig tree I have a patch that comments out
> the two security_task_getlsmprop_obj(), and I don't think I get
> warnings at the moment, but I no longer see why I would have done
> that.

Update: this seems to reliably avoid the warning, but I'm
still a bit lost about what exactly gcc warns about. I assume
this is a false-positive warning somewhere.

Added Kees and Gustavo to Cc in case they know what's going on.

      Arnd

diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..31cc41b167ae 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -145,7 +145,9 @@ struct audit_context {
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
 	struct lsm_prop	    target_ref;
-	char		    target_comm[TASK_COMM_LEN];
+	struct_group(_target_comm,
+		char	    target_comm[TASK_COMM_LEN];
+	);
 
 	struct audit_tree_refs *trees, *first_trees;
 	struct list_head killed_trees;
