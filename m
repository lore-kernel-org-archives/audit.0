Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD9188917;
	Tue,  3 Sep 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396858; cv=none; b=LHj7Wo5emrZD0AbUbm/aLeKdhg0e6KAzv1NMOPZR4k8H2aVtLAfCOIUI/Yztot0xJLhwNQ8Atc1UDg6pWqvXmxpqDWkOeczimgvYwkHm5+4RMVf8YZDdiP8lYVHh5CrEKxxJ8e3290Mx4Md+5rOYCDveRDQ56sHUkg0/uJqa9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396858; c=relaxed/simple;
	bh=h8pyLcGsMX1aXwow837+ar2LRu2tlGdcTwMdN9G99Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Trq8E4GreiL0ai/xARAh4W+lMqAUH++Axxo46mYMgDgFTgFy2+9IlQIWCr0PCDKb+6qSW8zzVJZ8eTJ7vSWr+tS284uLEXjcE/2l2LJlk1kBd26jEBpTTPKMou1RPhCbwKHWIEwfX7x9PNzbaoFYCF/B03GQbrbEUk/iVHuwxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6wKcsmG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nxMGCq2G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6wKcsmG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nxMGCq2G"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725396854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+D+yIk15l0SvEQ0rI80F0C0VgX0cJLMxkQR7hxFB6Q=;
	b=U6wKcsmGQanALeJCQvSK6tTTLkHPmcU41do8r7dLc5oJJmISBAaXdczSiYJJf38YjdN6D2
	NF4VyqdO+3QvL2PDyKDPPlQV7GXazj7X0uVEQ9rRbQkMxXOaS0HMy47kPWI3R6Ytu8D1QX
	YGo8duleqaNlQJzg44dLD5NPlebBigSTIa7P3ZgL/6I2BgMsqg4ifMfK0CLAiLjEvGpPeb
	qGPyaZALMYJEdETcjtZVfx2KJEOSkxVqYEZfR77NZvExdo6L3M4lV7eMDXtLb+i9KybrIZ
	BLsqDfl2f54MfqJ95BTrIHIP/B0n8n9H6/3/Tkd23+qQXWPOfsI/Y5Xkml3Vxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725396854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+D+yIk15l0SvEQ0rI80F0C0VgX0cJLMxkQR7hxFB6Q=;
	b=nxMGCq2Gm4P85gCKipUAHcMybaCKFpCJO+/NpMjAPT2Ks/m9xDRe6oCKvFdE93lPh5aHx8
	xSNLbQquWthKD9DQ==
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, audit@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
In-Reply-To: <202409031223.018C3D1@keescook>
References: <000000000000f11da7062091eb85@google.com> <87ikve78p5.ffs@tglx>
 <CAHC9VhTDqe8pYbmuNUu-Mdq6rmLo17z+eUTiOFh_PegbN99b-w@mail.gmail.com>
 <202409031223.018C3D1@keescook>
Date: Tue, 03 Sep 2024 22:54:14 +0200
Message-ID: <87seug791l.ffs@tglx>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 03 2024 at 12:24, Kees Cook wrote:
> On Tue, Sep 03, 2024 at 03:22:17PM -0400, Paul Moore wrote:
>> > >  might_alloc include/linux/sched/mm.h:337 [inline]
>> > >  slab_pre_alloc_hook mm/slub.c:3987 [inline]
>> > >  slab_alloc_node mm/slub.c:4065 [inline]
>> > >  kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
>> > >  audit_buffer_alloc kernel/audit.c:1790 [inline]
>> > >  audit_log_start+0x15e/0xa30 kernel/audit.c:1912
>> > >  audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007
>> 
>> The audit_seccomp() function allocates an audit buffer using
>> GFP_KERNEL, which should be the source of the might_sleep.  We can fix
>> that easily enough by moving to GFP_ATOMIC (either for just this code
>> path or all callers, need to check that), but I just want to confirm
>> that we can't sleep here?  I haven't dug into the syscall code in a
>> while, so I don't recall all the details, but it seems odd to me that
>> we can't safely sleep here ...
>
> I had a similar question.. this is at syscall entry time. What is
> suddenly different here? We've been doing seccomp logging here for
> years...

Correct.

syscall_enter_from_user_mode() enables interrupts. At that point
preempt_count is 0. So after that the task can sleep and schedule.
Nothing in the call chain leading up to the allocation disables
preemption or interrupts.

From the actual console log:

do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff81908f9e>] audit_log_start+0x37e/0xa30

I have no idea how that state would leak accross schedule_timeout().

Thanks,

        tglx

