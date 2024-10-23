Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CFE56A;
	Wed, 23 Oct 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692810; cv=none; b=IakpfQ+9hx8wtgkFIsMomoDCaSgqT95Gg5/KAmkvcLDxb9JxCO+BdaLUC2ENqKix93eZrBFsBLWs1vicjuJs2mDXtUZOtqxpmDfMGt+NJSyy8RPcVk0wh5rVTRZrtLWNb9p073Dh2bnoD5cPRc6FcFg9owBeE5yp/uD8rpv+vEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692810; c=relaxed/simple;
	bh=DRsQZEpKAIkSCrYNFl29TQ2Np20hDYQEUl6eYXBYn38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSvpdleYQA8cD5wl0IKBjwsoCBdcI664vUW3ZdQzre7e+Y+Jq/6ycn44MOPLCalvdTytUtq6WNTuQOTHsHEc+1m3eIytDTO5OIIyu3TNroa7Fbq+bK8Zg57H/7j+fPYFE5FgxY0NFoRau4/yC8Dlf2eUo35Uqg3k1ir9CkYnhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDm3HzdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDm3HzdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706AFC4CEC6;
	Wed, 23 Oct 2024 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729692809;
	bh=DRsQZEpKAIkSCrYNFl29TQ2Np20hDYQEUl6eYXBYn38=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FDm3HzdXbvAO3GG+Tr2GgRNHWtstN4nUS/iR9XdsWVcWhARha+fiQ8Gmtnvcv/P0r
	 jzeOnmbBlDu3X/YeF+/Y2naHATMCydpwG9serua+2l9/Orl+Ix/UvtviYqvCct7qIn
	 0OHBJQ9OZrXs4ReYwDjsHUK5nfVsWXi518UDJnN2YIPxeWuEJaV4Qtz+RBp4jjXUEe
	 zcL9HhOVU0bmRHXv36dkRvSWDB2IlOEPA8t/hNLXnW42gHbxRRkNOA6lJjXkezoh2J
	 uy85CKDxrYsNaG05PVqNEbCwqG8CrSAJRUKZZI/p3KPkOe4NF+FnUlVX/9XclZeiJG
	 6ZXzg3Hlq42RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0ADD7CE0F74; Wed, 23 Oct 2024 07:13:29 -0700 (PDT)
Date: Wed, 23 Oct 2024 07:13:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <fae16781-3b08-4315-b916-bee2bbc0c495@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net>
 <ZxerZIxg8kAMCvYc@elver.google.com>
 <62aaa141-e41d-4e7e-95eb-c48e4f7fc558@paulmck-laptop>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62aaa141-e41d-4e7e-95eb-c48e4f7fc558@paulmck-laptop>

On Tue, Oct 22, 2024 at 07:31:28AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 22, 2024 at 03:40:52PM +0200, Marco Elver wrote:
> > On Tue, Oct 22, 2024 at 01:31PM +0200, Peter Zijlstra wrote:
> > > On Tue, Oct 22, 2024 at 10:06:23AM +0200, Alexander Potapenko wrote:
> > > > On Fri, Sep 27, 2024 at 4:57 PM syzbot
> > > > <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15f07a80580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=86254f9e0a8f2c98
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0ec1e96c2cdf5c0e512a
> > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/1be80941df60/disk-075dbe9f.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/494a9ac89c09/vmlinux-075dbe9f.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/919788d8c731/bzImage-075dbe9f.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com
> > [...]
> > > > +PeterZ, who added the KCSAN assertion.
> > > 
> > > Well, PaulMck did in d6111cf45c57 ("sched: Use WRITE_ONCE() for
> > > p->on_rq"), I just moved it around in e8901061ca0c ("sched: Split
> > > DEQUEUE_SLEEP from deactivate_task()").
> > > 
> > > I'm not at all sure I have any inkling as to what the annotation does
> > > nor what KCSAN is trying to tell us above.
> > 
> > ASSERT_EXCLUSIVE_WRITER(var) is to say that that there should be no
> > concurrent writes to var; other readers are allowed. If KCSAN is
> > enabled, it then goes and reports any violations of that assertion.
> > Main usecase is for already marked accesses where concurrent accesses
> > are _not_ data races, but the algorithm does not assume concurrent
> > writers regardless.
> > 
> > In this case it seems that Paul was trying to say that there should be
> > no concurrent writers to this variable. But KCSAN disproved that.
> 
> Just confirming that this was my intent.

Except that it looks to me that Peter added this one, not me.  ;-)

> And for all I know, maybe it is now OK to have concurrent writers to
> that variable, but if so, would we please have an explanatory comment
> (or a reference to one)?

							Thanx, Paul

> > > Can someone please translate?
> > 
> > We can get the 2nd stack trace with:
> > 
> > 	--- a/kernel/sched/Makefile
> > 	+++ b/kernel/sched/Makefile
> > 	@@ -10,8 +10,8 @@ KCOV_INSTRUMENT := n
> > 
> > 	 # Disable KCSAN to avoid excessive noise and performance degradation. To avoid
> > 	 # false positives ensure barriers implied by sched functions are instrumented.
> > 	-KCSAN_SANITIZE := n
> > 	-KCSAN_INSTRUMENT_BARRIERS := y
> > 	+#KCSAN_SANITIZE := n
> > 	+#KCSAN_INSTRUMENT_BARRIERS := y
> > 
> > Which gives us:
> > 
> >  | ==================================================================
> >  | BUG: KCSAN: assert: race in dequeue_entities / ttwu_do_activate
> >  | 
> >  | write (marked) to 0xffff9e100329c628 of 4 bytes by interrupt on cpu 0:
> >  |  activate_task kernel/sched/core.c:2064 [inline]
> > 
> > This is this one:
> > 
> > 	void activate_task(struct rq *rq, struct task_struct *p, int flags)
> > 	{
> > 		if (task_on_rq_migrating(p))
> > 			flags |= ENQUEUE_MIGRATED;
> > 		if (flags & ENQUEUE_MIGRATED)
> > 			sched_mm_cid_migrate_to(rq, p);
> > 
> > 		enqueue_task(rq, p, flags);
> > 
> > 		WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
> > 		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> > 	}
> > 
> >  |  ttwu_do_activate+0x153/0x3e0 kernel/sched/core.c:3671
> >  |  ttwu_queue kernel/sched/core.c:3944 [inline]
> >  |  try_to_wake_up+0x60f/0xaf0 kernel/sched/core.c:4270
> >  |  default_wake_function+0x25/0x30 kernel/sched/core.c:7009
> >  |  __pollwake fs/select.c:205 [inline]
> >  |  pollwake+0xc0/0x100 fs/select.c:215
> >  |  __wake_up_common kernel/sched/wait.c:89 [inline]
> >  |  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
> >  |  __wake_up_sync_key+0x85/0xc0 kernel/sched/wait.c:173
> >  |  sock_def_readable+0x6f/0x180 net/core/sock.c:3442
> >  |  tcp_data_ready+0x194/0x230 net/ipv4/tcp_input.c:5193
> >  |  tcp_data_queue+0x1052/0x2710 net/ipv4/tcp_input.c:5283
> >  |  tcp_rcv_established+0x7e3/0xd60 net/ipv4/tcp_input.c:6237
> >  |  tcp_v4_do_rcv+0x545/0x600 net/ipv4/tcp_ipv4.c:1915
> >  |  tcp_v4_rcv+0x159c/0x1890 net/ipv4/tcp_ipv4.c:2350
> >  |  ip_protocol_deliver_rcu+0x2d8/0x620 net/ipv4/ip_input.c:205
> >  |  ip_local_deliver_finish+0x11a/0x150 net/ipv4/ip_input.c:233
> >  |  NF_HOOK include/linux/netfilter.h:314 [inline]
> >  |  ip_local_deliver+0xce/0x1a0 net/ipv4/ip_input.c:254
> >  |  dst_input include/net/dst.h:460 [inline]
> >  |  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
> >  |  ip_list_rcv_finish net/ipv4/ip_input.c:630 [inline]
> >  |  ip_sublist_rcv+0x43d/0x520 net/ipv4/ip_input.c:638
> >  |  ip_list_rcv+0x262/0x2a0 net/ipv4/ip_input.c:672
> >  |  __netif_receive_skb_list_ptype net/core/dev.c:5709 [inline]
> >  |  __netif_receive_skb_list_core+0x4fc/0x520 net/core/dev.c:5756
> >  |  __netif_receive_skb_list net/core/dev.c:5808 [inline]
> >  |  netif_receive_skb_list_internal+0x46d/0x5e0 net/core/dev.c:5899
> >  |  gro_normal_list include/net/gro.h:515 [inline]
> >  |  napi_complete_done+0x161/0x3a0 net/core/dev.c:6250
> >  |  e1000_clean+0x7c7/0x1a70 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
> >  |  __napi_poll+0x66/0x360 net/core/dev.c:6775
> >  |  napi_poll net/core/dev.c:6844 [inline]
> >  |  net_rx_action+0x3d9/0x820 net/core/dev.c:6966
> >  |  handle_softirqs+0xe6/0x2d0 kernel/softirq.c:554
> >  |  __do_softirq kernel/softirq.c:588 [inline]
> >  |  invoke_softirq kernel/softirq.c:428 [inline]
> >  |  __irq_exit_rcu+0x45/0xc0 kernel/softirq.c:637
> >  |  common_interrupt+0x4f/0xc0 arch/x86/kernel/irq.c:278
> >  |  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> >  | 
> >  | assert no writes to 0xffff9e100329c628 of 4 bytes by task 10571 on cpu 3:
> >  |  __block_task kernel/sched/sched.h:2770 [inline]
> > 
> > And that's:
> > 
> > 	static inline void __block_task(struct rq *rq, struct task_struct *p)
> > 	{
> > 		WRITE_ONCE(p->on_rq, 0);
> > 		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> > 		if (p->sched_contributes_to_load)
> > 			rq->nr_uninterruptible++;
> > 
> >  |  dequeue_entities+0xd83/0xe70 kernel/sched/fair.c:7177
> >  |  pick_next_entity kernel/sched/fair.c:5627 [inline]
> >  |  pick_task_fair kernel/sched/fair.c:8856 [inline]
> >  |  pick_next_task_fair+0xaf/0x710 kernel/sched/fair.c:8876
> >  |  __pick_next_task kernel/sched/core.c:5955 [inline]
> >  |  pick_next_task kernel/sched/core.c:6477 [inline]
> >  |  __schedule+0x47a/0x1130 kernel/sched/core.c:6629
> >  |  __schedule_loop kernel/sched/core.c:6752 [inline]
> >  |  schedule+0x7b/0x130 kernel/sched/core.c:6767
> >  |  do_nanosleep+0xdb/0x310 kernel/time/hrtimer.c:2032
> >  |  hrtimer_nanosleep+0xa0/0x180 kernel/time/hrtimer.c:2080
> >  |  common_nsleep+0x52/0x70 kernel/time/posix-timers.c:1365
> >  |  __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
> >  |  __se_sys_clock_nanosleep+0x1b2/0x1f0 kernel/time/posix-timers.c:1388
> >  |  __x64_sys_clock_nanosleep+0x55/0x70 kernel/time/posix-timers.c:1388
> >  |  x64_sys_call+0x2612/0x2f00 arch/x86/include/generated/asm/syscalls_64.h:231
> >  |  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  |  do_syscall_64+0xd0/0x1a0 arch/x86/entry/common.c:83
> >  |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >  | 
> >  | Reported by Kernel Concurrency Sanitizer on:
> >  | CPU: 3 UID: 0 PID: 10571 Comm: syz.3.1083 Not tainted 6.12.0-rc2-00003-g44423ac48780-dirty #7
> >  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >  | ==================================================================
