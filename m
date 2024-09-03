Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0A1D5CC6;
	Tue,  3 Sep 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391457; cv=none; b=cQZK+F5epgm6rYOku7vrRtprkdu8HYWHkoJeVptU6CW7JUSMEwtgih8EoODooQSxKrtcDJUaT6vdJ8vBaG1o6tRMl+SW/L9k1klfvagNofDeoN3AnRv9oS1BvrCbW9r7QCUQ9SnorA2VI/JRD/icpRMJUCC4cSWsk313h1mhEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391457; c=relaxed/simple;
	bh=yzjXcx/NnZ8eSRt90MXvNsYwuwH4TNKsuiBeKMiNsKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R88LNfQC7/YC5EGhgy3svQ8y0k/zFFwrVdULQ11f4jAMY8GPzH7fcXtzfGorbZyFhDbWni9L1XSMmwEMb67cJAH18Hfae6ub+YyU6wJSBQFn2uNSManeIYhsqKD3Rxt7yRzhlrq5GoDfUJaB8DH60p6v/DNP8N7qwRr28V4NONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6BlV2a2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6BlV2a2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FA5C4CEC4;
	Tue,  3 Sep 2024 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391456;
	bh=yzjXcx/NnZ8eSRt90MXvNsYwuwH4TNKsuiBeKMiNsKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6BlV2a2Guj/8cfRjw0Ut4ERA83HrSdifosJNeTJShjCZ3dymhK/R5iVFonZuXaXI
	 +O8gSira5m6+tRzy/cevWU4G5BnBiLBPE07tI0dwN1I1yrmd7VjhyHXX1rXsQ/Eg1D
	 8MKNhGCXduFDskAxbFWVP2UHM7sFFVbmDTQCeIJmu41LlRkkr/FCuWNF3okifidWZF
	 FF3VTFGD466zQJ34Dt3sCm5CPvVhHnLdXBI4i4YsVNrTOBvjWT49IutFck0hWkSF3i
	 hHMxiWk4bmE2X1cElqg28fDEjoUbvqStHNt0M38jp2QzHcj6DUDmDt4Gbk62KPNTVh
	 Exr1pq+azCyMg==
Date: Tue, 3 Sep 2024 12:24:16 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, audit@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
Message-ID: <202409031223.018C3D1@keescook>
References: <000000000000f11da7062091eb85@google.com>
 <87ikve78p5.ffs@tglx>
 <CAHC9VhTDqe8pYbmuNUu-Mdq6rmLo17z+eUTiOFh_PegbN99b-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTDqe8pYbmuNUu-Mdq6rmLo17z+eUTiOFh_PegbN99b-w@mail.gmail.com>

On Tue, Sep 03, 2024 at 03:22:17PM -0400, Paul Moore wrote:
> On Mon, Sep 2, 2024 at 4:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Aug 26 2024 at 01:29, syzbot wrote:
> >
> > Cc:+ seccomp and audit folks
> >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15c8680b980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4576eaa688ef747b8d6c
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/disk-6a7917c8.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmlinux-6a7917c8.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa/bzImage-6a7917c8.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com
> > >
> > > WARNING: CPU: 1 PID: 8527 at kernel/sched/core.c:8556 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> > > Modules linked in:
> > > CPU: 1 UID: 0 PID: 8527 Comm: syz.4.642 Not tainted 6.11.0-rc4-next-20240822-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> > > RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> > > Code: a1 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ce e6 97 00 48 8b 4d 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 f8 02 f1 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
> > > RSP: 0018:ffffc90009ab7a20 EFLAGS: 00010246
> > > RAX: a60a1ffb5c104900 RBX: 1ffff11004257a6c RCX: 0000000000040000
> > > RDX: ffffc90003e59000 RSI: 000000000001b727 RDI: 000000000001b728
> > > RBP: ffff8880212bd360 R08: ffffffff8155a632 R09: fffffbfff1cfa364
> > > R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: dffffc0000000000
> > > R13: 0000000000000002 R14: 0000000000000151 R15: ffffffff8e0a492c
> > > FS:  00007f4cf5b6a6c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f7e0f003000 CR3: 000000001feec000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  might_alloc include/linux/sched/mm.h:337 [inline]
> > >  slab_pre_alloc_hook mm/slub.c:3987 [inline]
> > >  slab_alloc_node mm/slub.c:4065 [inline]
> > >  kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
> > >  audit_buffer_alloc kernel/audit.c:1790 [inline]
> > >  audit_log_start+0x15e/0xa30 kernel/audit.c:1912
> > >  audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007
> 
> The audit_seccomp() function allocates an audit buffer using
> GFP_KERNEL, which should be the source of the might_sleep.  We can fix
> that easily enough by moving to GFP_ATOMIC (either for just this code
> path or all callers, need to check that), but I just want to confirm
> that we can't sleep here?  I haven't dug into the syscall code in a
> while, so I don't recall all the details, but it seems odd to me that
> we can't safely sleep here ...

I had a similar question.. this is at syscall entry time. What is
suddenly different here? We've been doing seccomp logging here for
years...

-Kees

-- 
Kees Cook
