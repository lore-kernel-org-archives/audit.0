Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52098126BF4
	for <audit@vger.kernel.org>; Tue,  3 Sep 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398586; cv=none; b=OUOr5y7m2oI5cyh6vTva9bE/HSWFa4C8UaMLCFTZYiLSMdcNzN1MPNxC6kqi8XZt2JP4OMDbOgHzZairXH/Bciebo/LmwNxdDxw73j+Xb6DZ8Q2tqAp4FERif/tgnh1/UX+cSPE6/EJ99vsfbbGwe//MSay3+4vH/f9+j9GBeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398586; c=relaxed/simple;
	bh=jO2uDQBQnhOE+b3Vs86Pj9s/3kQUgRcS0rRhGWRV3/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec3MvmWRaWxY/CxLFt7jeHwTMYMcj7uPXPZRagza187UZxAUmIuc3e85K9RoieQtB+lQNQRHV/RTp+f4vHHrxNiGbYb8u4yLozE42WpC2JCJce54IofaRmNw3NZKVeeq6bjF6MEIidQNkPEOce9V1E0DX00T7PC+p+kH/falu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKvtYAoE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKvtYAoE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20573eb852aso445285ad.1
        for <audit@vger.kernel.org>; Tue, 03 Sep 2024 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725398584; x=1726003384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBCYUVY+kyEAQihHfAIpXMzgk6XSFFHDEmSopvaE4g8=;
        b=bKvtYAoEyzCTl+bNb9QNqbO5k8hexcEI8R5qHQfSv00dAD9dYSDTwR/wOhcDVfnLQF
         4qsrqFl8e9pV6satWxpbu+5JGdUt6ScDvo+onldpoARImKj4KLk9FWR7PAaSDovstkZJ
         CZM0Y8kKhO6UkjyNTagz7CT7D3XriJ6Ugs/cTZw8EKTHJiz1IqXLoWvQyor63XIxS8A5
         prHV4vlet4D5fSyFMh/nj9iY111b0pcYvv2Y94dDL62FV5CERwQIkLslNRVm3DC1N/d8
         epXOG04xeAuIGGtYhX+K2bnMnf7Miiz2/Sg/eczCei55TRo5te11TWlE+b/pNonreN0y
         xwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398584; x=1726003384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBCYUVY+kyEAQihHfAIpXMzgk6XSFFHDEmSopvaE4g8=;
        b=Ubhv1YqDsgIS8EFkFeBwNBsF1f9pIeQtBYLUBlgHq3N8o3SjregHHKVz6+l/aOqcy4
         bc9BdDXh/5dN5EG5Rxsa8LxAKd04DQ1wyZdMNyJSfnVUHhk55YxOVS+/hSM7zQFYNOia
         ekeMU3A0xOYMP2E2g61y0VrtFou7rXq2QZCmcpag79UDZE88WTRNhnq9CRIdYjstW7p7
         hu0cpKVjca9waNIOtwTLyK25BSkkhsGdLt6HGKup+zZr0+aDSXTD7YuVI96jz8bFKGGx
         p+z1/pgX4mojs7wrtBWlgHaKe0zDwswr9tQUwSeC6ASkGWoJsrsKeq2W5LHitbG2/9Ur
         D0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL83hLwMH4C+5+EAoMa+80Mc/Mz82I/YMI74Wc8EOTMOkG9T7Duak0uCy3mUxmLN5yIiUZVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBP4lk7iOFp0TKBFG530hhsB/0rU8rmn7f1sTPosc2TuUvN13
	Rs8HSXJ7Rs4b3m96nvwOCj6ZWC+1S1XKOVNXuqI36gHvi4jGEgY3fJ16PFfxfkoLpPb14eMQwh1
	d7ChJlOhgKm4QtMOZJg+OZfPgkoEB298Aia+C
X-Google-Smtp-Source: AGHT+IGrH1VC2unY7qDM/hzJ5+tZtVXSRYKJ4GEGN+T3NsiZnSUBdB37jw0R28zr1qAGFIUyrd/mpxuW+gMPnLXeFFY=
X-Received: by 2002:a17:902:e749:b0:205:950e:1c85 with SMTP id
 d9443c01a7336-205950e1cf6mr97417405ad.10.1725398584234; Tue, 03 Sep 2024
 14:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f11da7062091eb85@google.com> <87ikve78p5.ffs@tglx>
 <CAHC9VhTDqe8pYbmuNUu-Mdq6rmLo17z+eUTiOFh_PegbN99b-w@mail.gmail.com>
 <202409031223.018C3D1@keescook> <87seug791l.ffs@tglx>
In-Reply-To: <87seug791l.ffs@tglx>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 3 Sep 2024 23:22:52 +0200
Message-ID: <CANp29Y5qbxYhLzq7vwjkp-jsCX3OVfUcokk76Zbbs5pBC7uS6w@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:54=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Sep 03 2024 at 12:24, Kees Cook wrote:
> > On Tue, Sep 03, 2024 at 03:22:17PM -0400, Paul Moore wrote:
> >> > >  might_alloc include/linux/sched/mm.h:337 [inline]
> >> > >  slab_pre_alloc_hook mm/slub.c:3987 [inline]
> >> > >  slab_alloc_node mm/slub.c:4065 [inline]
> >> > >  kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
> >> > >  audit_buffer_alloc kernel/audit.c:1790 [inline]
> >> > >  audit_log_start+0x15e/0xa30 kernel/audit.c:1912
> >> > >  audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007
> >>
> >> The audit_seccomp() function allocates an audit buffer using
> >> GFP_KERNEL, which should be the source of the might_sleep.  We can fix
> >> that easily enough by moving to GFP_ATOMIC (either for just this code
> >> path or all callers, need to check that), but I just want to confirm
> >> that we can't sleep here?  I haven't dug into the syscall code in a
> >> while, so I don't recall all the details, but it seems odd to me that
> >> we can't safely sleep here ...
> >
> > I had a similar question.. this is at syscall entry time. What is
> > suddenly different here? We've been doing seccomp logging here for
> > years...
>
> Correct.
>
> syscall_enter_from_user_mode() enables interrupts. At that point
> preempt_count is 0. So after that the task can sleep and schedule.
> Nothing in the call chain leading up to the allocation disables
> preemption or interrupts.
>
> From the actual console log:
>
> do not call blocking ops when !TASK_RUNNING; state=3D2 set at [<ffffffff8=
1908f9e>] audit_log_start+0x37e/0xa30
>
> I have no idea how that state would leak accross schedule_timeout().
>

There has been a spike in strange crash reports on linux-next lately,
supposedly due to this large patch series:
https://lore.kernel.org/all/20240727102732.960974693@infradead.org/
So if this report is not easily explainable, possibly it is best to
take it with a grain of salt..

Aleksandr

> Thanks,
>
>         tglx
>
