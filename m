Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7C1E481
	for <audit@vger.kernel.org>; Tue, 22 Oct 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604462; cv=none; b=TfMGOealIIXh/EBoBIXjtrheeG5C3IO+IFOntDBI5wF9daYVHFYoon3VN2Tasr0N6sL6kmDZdx7UU+5Jlfb3r2aJf1GO8Kk0r0KBTfwNHQZdR50EYZs2zTmtYE6owyyIxQji6YD9UQlqz3+iDGkGf8pVIrLhv/vgvS5SC9CD3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604462; c=relaxed/simple;
	bh=ZRWBov01eXAsx1lbt69OJqscShr2hbOSTVKlgw2vq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt71uHLGr1YaFUhItD/JJTC5qjnrHXEj8bKBBMVIiz1qqnrvrCK48AP7gA7F7Sh408ZZ5k2b6gQxz5aa1jOE+f0KHZzh35Z+kRY1AWukGjjdSF2w//XgQsATzCR1MJ8GGTb5CC/30WH7GqvFXtqQoK86ODiRuAp66WVyQuhPE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7uv0yoW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7uv0yoW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so59854685e9.2
        for <audit@vger.kernel.org>; Tue, 22 Oct 2024 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729604459; x=1730209259; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RzVpVc2yXVYDPsIXGrEweGpMjQjnV+zz+yrzd0Tbk8=;
        b=Z7uv0yoWD/j7UTXnGX0KbbtOQjgpvM2ZWhhqHCJP2OI6foQnYnFpbhEMI4+Y+1WF49
         1tKqYlaWZoxlkMlixU8Nv+hghlcszNNvu62SSkjuQzpLv74BBG7+ADW0Ekwn1TXvUEcu
         I7lH7BKV4N+xsbN20CB+IbjNQhDc9Z7KUBnI+0dFhHuNHF/42KNXRsyhFapGrTId1mbe
         CzamjKOKcQvgg6Vycopr8H0hPcJmPklavwoFbYK2RBNh0AjarE+XToR4Si6FlbxbzzU1
         Gg7tdOTj9Qaw3dNb51tZbQ8iusmuFll/ARsm84dyjhLDc3HFEyr74nF3IY+tijJIpk1L
         qWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604459; x=1730209259;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RzVpVc2yXVYDPsIXGrEweGpMjQjnV+zz+yrzd0Tbk8=;
        b=JnmBE0pPY9YVmvFc7ETvHRSL7kisyI3fitAXnlYQk7cqpYAqerOevHtGYnQq1ugpcJ
         oqYs6VT/CVAwDDECZfmIvfc3jq+LTmFMj8o6OdY5NkgDAvI4vIS5678E1109iY9hlDj9
         viggk7EaYKadorBcgp8kQhRDKSeP7rklN4nHJXLejSDjvY5tZggLOxUPbwktRIj2LaNJ
         aiYyQofZSphkEWO/QIv3JC5X+VkTm3gfVh4bf+gzKuVcWrqkWnBKnxSTv0pAaLe8Zqav
         nJHjvwUdZcLfm6j1iv08zrKBHoLtiAfg1HqdDMSMYZFweeA24HgxjPjyasKGE73bK4RS
         6PcA==
X-Forwarded-Encrypted: i=1; AJvYcCV1MYjNx0nlHtnhgtBjDDn+lNPsVXVadNFvBUE0kVg15r3Qz0Cy3U+P+zKFJ6vyDMLO+d1VXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMyfBCd6R/tbpfziWuEqf3ZtRmxMbmoWT0MgnbHsfbc1vjfa6
	qhaiXraQsoMzuTACnPdHNme1Qsr4p88KOTMvfaSDzNu4CNlLrnBZSq8BCfNgrA==
X-Google-Smtp-Source: AGHT+IE1VIEMCSR8cLm1M3rxDDHOUlkMLKyknpICPyCdtFc8sq9xlWb37UQ4n8+4Chs8FcACC/rknQ==
X-Received: by 2002:a05:600c:4450:b0:431:4f5e:1f61 with SMTP id 5b1f17b1804b1-4317caac4f1mr23454345e9.14.1729604458607;
        Tue, 22 Oct 2024 06:40:58 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:54b8:5e1b:8507:5f75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fdb2sm88081445e9.20.2024.10.22.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:40:57 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:40:52 +0200
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org
Cc: Alexander Potapenko <glider@google.com>,
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <ZxerZIxg8kAMCvYc@elver.google.com>
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022113131.GD16066@noisy.programming.kicks-ass.net>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Oct 22, 2024 at 01:31PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 22, 2024 at 10:06:23AM +0200, Alexander Potapenko wrote:
> > On Fri, Sep 27, 2024 at 4:57 PM syzbot
> > <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15f07a80580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=86254f9e0a8f2c98
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0ec1e96c2cdf5c0e512a
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/1be80941df60/disk-075dbe9f.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/494a9ac89c09/vmlinux-075dbe9f.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/919788d8c731/bzImage-075dbe9f.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com
[...]
> > +PeterZ, who added the KCSAN assertion.
> 
> Well, PaulMck did in d6111cf45c57 ("sched: Use WRITE_ONCE() for
> p->on_rq"), I just moved it around in e8901061ca0c ("sched: Split
> DEQUEUE_SLEEP from deactivate_task()").
> 
> I'm not at all sure I have any inkling as to what the annotation does
> nor what KCSAN is trying to tell us above.

ASSERT_EXCLUSIVE_WRITER(var) is to say that that there should be no
concurrent writes to var; other readers are allowed. If KCSAN is
enabled, it then goes and reports any violations of that assertion.
Main usecase is for already marked accesses where concurrent accesses
are _not_ data races, but the algorithm does not assume concurrent
writers regardless.

In this case it seems that Paul was trying to say that there should be
no concurrent writers to this variable. But KCSAN disproved that.

> Can someone please translate?

We can get the 2nd stack trace with:

	--- a/kernel/sched/Makefile
	+++ b/kernel/sched/Makefile
	@@ -10,8 +10,8 @@ KCOV_INSTRUMENT := n

	 # Disable KCSAN to avoid excessive noise and performance degradation. To avoid
	 # false positives ensure barriers implied by sched functions are instrumented.
	-KCSAN_SANITIZE := n
	-KCSAN_INSTRUMENT_BARRIERS := y
	+#KCSAN_SANITIZE := n
	+#KCSAN_INSTRUMENT_BARRIERS := y

Which gives us:

 | ==================================================================
 | BUG: KCSAN: assert: race in dequeue_entities / ttwu_do_activate
 | 
 | write (marked) to 0xffff9e100329c628 of 4 bytes by interrupt on cpu 0:
 |  activate_task kernel/sched/core.c:2064 [inline]

This is this one:

	void activate_task(struct rq *rq, struct task_struct *p, int flags)
	{
		if (task_on_rq_migrating(p))
			flags |= ENQUEUE_MIGRATED;
		if (flags & ENQUEUE_MIGRATED)
			sched_mm_cid_migrate_to(rq, p);

		enqueue_task(rq, p, flags);

		WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
	}

 |  ttwu_do_activate+0x153/0x3e0 kernel/sched/core.c:3671
 |  ttwu_queue kernel/sched/core.c:3944 [inline]
 |  try_to_wake_up+0x60f/0xaf0 kernel/sched/core.c:4270
 |  default_wake_function+0x25/0x30 kernel/sched/core.c:7009
 |  __pollwake fs/select.c:205 [inline]
 |  pollwake+0xc0/0x100 fs/select.c:215
 |  __wake_up_common kernel/sched/wait.c:89 [inline]
 |  __wake_up_common_lock kernel/sched/wait.c:106 [inline]
 |  __wake_up_sync_key+0x85/0xc0 kernel/sched/wait.c:173
 |  sock_def_readable+0x6f/0x180 net/core/sock.c:3442
 |  tcp_data_ready+0x194/0x230 net/ipv4/tcp_input.c:5193
 |  tcp_data_queue+0x1052/0x2710 net/ipv4/tcp_input.c:5283
 |  tcp_rcv_established+0x7e3/0xd60 net/ipv4/tcp_input.c:6237
 |  tcp_v4_do_rcv+0x545/0x600 net/ipv4/tcp_ipv4.c:1915
 |  tcp_v4_rcv+0x159c/0x1890 net/ipv4/tcp_ipv4.c:2350
 |  ip_protocol_deliver_rcu+0x2d8/0x620 net/ipv4/ip_input.c:205
 |  ip_local_deliver_finish+0x11a/0x150 net/ipv4/ip_input.c:233
 |  NF_HOOK include/linux/netfilter.h:314 [inline]
 |  ip_local_deliver+0xce/0x1a0 net/ipv4/ip_input.c:254
 |  dst_input include/net/dst.h:460 [inline]
 |  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 |  ip_list_rcv_finish net/ipv4/ip_input.c:630 [inline]
 |  ip_sublist_rcv+0x43d/0x520 net/ipv4/ip_input.c:638
 |  ip_list_rcv+0x262/0x2a0 net/ipv4/ip_input.c:672
 |  __netif_receive_skb_list_ptype net/core/dev.c:5709 [inline]
 |  __netif_receive_skb_list_core+0x4fc/0x520 net/core/dev.c:5756
 |  __netif_receive_skb_list net/core/dev.c:5808 [inline]
 |  netif_receive_skb_list_internal+0x46d/0x5e0 net/core/dev.c:5899
 |  gro_normal_list include/net/gro.h:515 [inline]
 |  napi_complete_done+0x161/0x3a0 net/core/dev.c:6250
 |  e1000_clean+0x7c7/0x1a70 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
 |  __napi_poll+0x66/0x360 net/core/dev.c:6775
 |  napi_poll net/core/dev.c:6844 [inline]
 |  net_rx_action+0x3d9/0x820 net/core/dev.c:6966
 |  handle_softirqs+0xe6/0x2d0 kernel/softirq.c:554
 |  __do_softirq kernel/softirq.c:588 [inline]
 |  invoke_softirq kernel/softirq.c:428 [inline]
 |  __irq_exit_rcu+0x45/0xc0 kernel/softirq.c:637
 |  common_interrupt+0x4f/0xc0 arch/x86/kernel/irq.c:278
 |  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
 | 
 | assert no writes to 0xffff9e100329c628 of 4 bytes by task 10571 on cpu 3:
 |  __block_task kernel/sched/sched.h:2770 [inline]

And that's:

	static inline void __block_task(struct rq *rq, struct task_struct *p)
	{
		WRITE_ONCE(p->on_rq, 0);
		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
		if (p->sched_contributes_to_load)
			rq->nr_uninterruptible++;

 |  dequeue_entities+0xd83/0xe70 kernel/sched/fair.c:7177
 |  pick_next_entity kernel/sched/fair.c:5627 [inline]
 |  pick_task_fair kernel/sched/fair.c:8856 [inline]
 |  pick_next_task_fair+0xaf/0x710 kernel/sched/fair.c:8876
 |  __pick_next_task kernel/sched/core.c:5955 [inline]
 |  pick_next_task kernel/sched/core.c:6477 [inline]
 |  __schedule+0x47a/0x1130 kernel/sched/core.c:6629
 |  __schedule_loop kernel/sched/core.c:6752 [inline]
 |  schedule+0x7b/0x130 kernel/sched/core.c:6767
 |  do_nanosleep+0xdb/0x310 kernel/time/hrtimer.c:2032
 |  hrtimer_nanosleep+0xa0/0x180 kernel/time/hrtimer.c:2080
 |  common_nsleep+0x52/0x70 kernel/time/posix-timers.c:1365
 |  __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 |  __se_sys_clock_nanosleep+0x1b2/0x1f0 kernel/time/posix-timers.c:1388
 |  __x64_sys_clock_nanosleep+0x55/0x70 kernel/time/posix-timers.c:1388
 |  x64_sys_call+0x2612/0x2f00 arch/x86/include/generated/asm/syscalls_64.h:231
 |  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 |  do_syscall_64+0xd0/0x1a0 arch/x86/entry/common.c:83
 |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 | 
 | Reported by Kernel Concurrency Sanitizer on:
 | CPU: 3 UID: 0 PID: 10571 Comm: syz.3.1083 Not tainted 6.12.0-rc2-00003-g44423ac48780-dirty #7
 | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 | ==================================================================
