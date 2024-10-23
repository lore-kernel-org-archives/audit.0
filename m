Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55B16130B
	for <audit@vger.kernel.org>; Wed, 23 Oct 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673663; cv=none; b=PlTqaAi3UJQpxXZr44ScaQ3An/Pt/N/7agSREiy0jb6LTF6aRX3aR9Lste2+5ewCrXSiO5p56/wiQu4134C24R6oqrptTLRweGkvwjZiJ40tE6XIzOx/9n3nmtYLw853tq6rkw+UPTLvU0EL8HQ0dRGcjnvBG4oNRKzVp5RvBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673663; c=relaxed/simple;
	bh=i0v8NqkgCJS4oUAsjADb8vN9BsoNo9Isn4HAY2bf7X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS1juLt77mJwYCYtsfEu+Uoko5m3LA8OaD2SCGspakauP35ZCpKJ357/8qvzXS0LOkFA6oARCwNdZXdz2DnDMBJWJJVAkIHiHA5lv7keL+ielchBGJn0rlcfPKsSRLjPVTghd7jWYLpPLv+MIQTcEgDV5o5CTxDIerBRlV6MhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSD20GFe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSD20GFe"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314a26002bso72210565e9.0
        for <audit@vger.kernel.org>; Wed, 23 Oct 2024 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729673660; x=1730278460; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn6D9C4Nk5A26tLymLNhSqt+/4kvLrxnp+L0ML6CXxE=;
        b=xSD20GFexLsrpPOXmcBCUarnzjCNMwJCwTqym+VjHJe8syIaBBY/IXRgH/7DFs5GV1
         WmZP6gdc/BnPYVRwdfpVVGqQsaU+LYpCt3dImM1w64Ui6AQSCILrM4Wj9PsC3p8X9zfc
         OVyZm7Yk+qJxPzH8gZVZqWCbR05Of4i0xI0uEdzRfrxqnO23rUeWsi2V0ozKn8H4KL1+
         3j8urVLJZAsdt4ik2/KliDwH7E9cMhzSdHsaYHvKBIo36CeW06WnxmV6A/w5KB4RNlSA
         ce+Vg4IMLa5tC1xbGsgXVxEFnE+z7wcC+qQIedvtcQ3IbEUjTc/Zjdb8czxgW913Vf0p
         v0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673660; x=1730278460;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn6D9C4Nk5A26tLymLNhSqt+/4kvLrxnp+L0ML6CXxE=;
        b=o8ZdYyJ4zmgFARZ6YpLEGqessMeKzkeatky301oxj307BmRmvU6jQfqIQ7IwlM0LB9
         OXupzvwO94MlavWEcvRB9zV1LRwanFQ3BoL3Yna3XeKQ8hX5QF9bjw/Dw3OFdpicMA82
         aRDJXEdn4piSHpCwjI55bv/plzcWyYK9nW+GSoenCWxst5EmzqBCBoQUCNgJarkV3r7m
         8IAlNyg6Y1ob0lAbRCU0x7hVgknv4xOcObtKxTvu9XnawWCjsIDFvBaBLdLTYPKbHpSU
         OOpLKwRRKbc3UBlnPwcxq6O8Q31XfMiNWqceoR9feuBvnbZnC0am+QB7ULx0yLfEKU4V
         Ht4A==
X-Forwarded-Encrypted: i=1; AJvYcCUJmRzKWvT+5I1QCy9MnM46PozexqS0XmvexaG0ELNzpiKVUUXtgEQAFzRayQ6gEO0TuYwrTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZeSYG07xgLapfq5q2ftajjQbIqv9Nm+zt1dJ3N7lSOSCZP9C
	dkc+sHVDYgM2x169T/ZkwoltOO+jotorZ8egYJFWMKd6GLVQFBgKJM0BXuCwog==
X-Google-Smtp-Source: AGHT+IEVC83zUuL9opC/X3Jk8Gy5499uzbP7zH9NX9bAIUudRipSQ4pdP+Ig1rYK5rXvM5MXOX1J6A==
X-Received: by 2002:a5d:47ac:0:b0:37d:4d21:350c with SMTP id ffacd0b85a97d-37efcf0f6b0mr1434165f8f.13.1729673659651;
        Wed, 23 Oct 2024 01:54:19 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:d6e8:cc05:b777:fa6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9405asm8433383f8f.87.2024.10.23.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:54:18 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:54:13 +0200
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>,
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <Zxi5tbLnhoG4pEcm@elver.google.com>
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net>
 <ZxerZIxg8kAMCvYc@elver.google.com>
 <20241022191244.GB9657@noisy.programming.kicks-ass.net>
 <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Oct 22, 2024 at 09:57PM +0200, Marco Elver wrote:
> On Tue, 22 Oct 2024 at 21:12, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > So KCSAn is trying to tell me these two paths run concurrently on the
> > same 'p' ?!? That would be a horrible bug -- both these call chains
> > should be holding rq->__lock (for task_rq(p)).
> 
> Yes correct.
> 
> And just to confirm this is no false positive, the way KCSAN works
> _requires_ the race to actually happen before it reports anything;
> this can also be seen in Alexander's report with just 1 stack trace
> where it saw the value transition from 0 to 1 (TASK_ON_RQ_QUEUED) but
> didn't know who did the write because kernel/sched was uninstrumented.

Got another version of the splat with CONFIG_KCSAN_VERBOSE=y. Lockdep seems to
think that both threads here are holding rq->__lock.

| ==================================================================
| BUG: KCSAN: assert: race in activate_task / dequeue_entities
| 
| write (marked) to 0xffffa2e506240068 of 4 bytes by interrupt on cpu 0:
|  activate_task+0xfb/0x130 kernel/sched/core.c:2064
|  ttwu_do_activate+0xee/0x2b0 kernel/sched/core.c:3671
|  ttwu_queue kernel/sched/core.c:3944 [inline]
|  try_to_wake_up+0x509/0x930 kernel/sched/core.c:4270
|  default_wake_function+0x25/0x30 kernel/sched/core.c:7009
|  __pollwake fs/select.c:205 [inline]
|  pollwake+0xc0/0x100 fs/select.c:215
|  __wake_up_common kernel/sched/wait.c:89 [inline]
|  __wake_up_common_lock+0xc0/0x110 kernel/sched/wait.c:106
|  __wake_up_sync_key+0x1b/0x30 kernel/sched/wait.c:173
|  sock_def_readable+0x19a/0x460 net/core/sock.c:3442
|  tcp_data_ready+0x194/0x230 net/ipv4/tcp_input.c:5193
|  tcp_data_queue+0xfd8/0x26b0 net/ipv4/tcp_input.c:5283
|  tcp_rcv_established+0x8e5/0xeb0 net/ipv4/tcp_input.c:6237
|  tcp_v4_do_rcv+0x606/0x620 net/ipv4/tcp_ipv4.c:1915
|  tcp_v4_rcv+0x16e9/0x1890 net/ipv4/tcp_ipv4.c:2350
|  ip_protocol_deliver_rcu+0x382/0x6a0 net/ipv4/ip_input.c:205
|  ip_local_deliver_finish+0x1bf/0x290 net/ipv4/ip_input.c:233
|  NF_HOOK+0x274/0x2f0 include/linux/netfilter.h:314
|  ip_local_deliver net/ipv4/ip_input.c:254 [inline]
|  dst_input include/net/dst.h:460 [inline]
|  ip_sublist_rcv_finish+0x22a/0x2c0 net/ipv4/ip_input.c:580
|  ip_list_rcv_finish net/ipv4/ip_input.c:630 [inline]
|  ip_sublist_rcv+0x2e3/0x560 net/ipv4/ip_input.c:638
|  ip_list_rcv+0x275/0x2b0 net/ipv4/ip_input.c:672
|  __netif_receive_skb_list_ptype net/core/dev.c:5709 [inline]
|  __netif_receive_skb_list_core+0x4fc/0x520 net/core/dev.c:5756
|  __netif_receive_skb_list net/core/dev.c:5808 [inline]
|  netif_receive_skb_list_internal+0x516/0x720 net/core/dev.c:5899
|  gro_normal_list include/net/gro.h:515 [inline]
|  napi_complete_done+0x161/0x3c0 net/core/dev.c:6250
|  e1000_clean+0x7c7/0x1a70 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
|  __napi_poll+0x6c/0x2c0 net/core/dev.c:6775
|  napi_poll net/core/dev.c:6844 [inline]
|  net_rx_action+0x433/0x8e0 net/core/dev.c:6966
|  handle_softirqs+0x15c/0x450 kernel/softirq.c:554
|  __do_softirq kernel/softirq.c:588 [inline]
|  invoke_softirq kernel/softirq.c:428 [inline]
|  __irq_exit_rcu+0x72/0x110 kernel/softirq.c:637
|  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
|  common_interrupt+0xa7/0xc0 arch/x86/kernel/irq.c:278
|  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
|  finish_task_switch+0x11c/0x3e0 kernel/sched/core.c:5189
|  context_switch kernel/sched/core.c:5318 [inline]
|  __schedule+0xf23/0x14a0 kernel/sched/core.c:6675
|  preempt_schedule_irq+0x9a/0xf0 kernel/sched/core.c:6997
|  raw_irqentry_exit_cond_resched+0x52/0x60 kernel/entry/common.c:311
|  irqentry_exit+0x6a/0xa0 kernel/entry/common.c:354
|  sysvec_apic_timer_interrupt+0x50/0xb0 arch/x86/kernel/apic/apic.c:1037
|  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
|  __seqprop_sequence include/linux/seqlock.h:211 [inline]
|  get_counters net/ipv6/netfilter/ip6_tables.c:774 [inline]
|  alloc_counters net/ipv6/netfilter/ip6_tables.c:820 [inline]
|  copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
|  get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
|  do_ip6t_get_ctl+0x665/0x9d0 net/ipv6/netfilter/ip6_tables.c:1677
|  nf_getsockopt+0x14e/0x170 net/netfilter/nf_sockopt.c:116
|  ipv6_getsockopt+0x13c/0x1b0 net/ipv6/ipv6_sockglue.c:1493
|  tcp_getsockopt+0x9e/0xd0 net/ipv4/tcp.c:4670
|  sock_common_getsockopt+0x5d/0x70 net/core/sock.c:3776
|  do_sock_getsockopt+0x18f/0x220 net/socket.c:2391
|  __sys_getsockopt+0xf1/0x170 net/socket.c:2420
|  __do_sys_getsockopt net/socket.c:2430 [inline]
|  __se_sys_getsockopt net/socket.c:2427 [inline]
|  __x64_sys_getsockopt+0x64/0x80 net/socket.c:2427
|  x64_sys_call+0x120e/0x2f00 arch/x86/include/generated/asm/syscalls_64.h:56
|  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
|  do_syscall_64+0xec/0x1d0 arch/x86/entry/common.c:83
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
| 
| 8 locks held by syz-executor/24825:
|  #0: ffffa2e5031a2f48 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x5e/0x230 net/netfilter/x_tables.c:1243
|  #1: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
|  #1: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
|  #1: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb_list_internal+0x24e/0x720 net/core/dev.c:5884
|  #2: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
|  #2: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
|  #2: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0xe1/0x290 net/ipv4/ip_input.c:232
|  #3: ffffa2e5072201d8 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x1677/0x1890 net/ipv4/tcp_ipv4.c:2346
|  #4: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
|  #4: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
|  #4: ffffffff9a357d18 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0x91/0x460 net/core/sock.c:3439
|  #5: ffffa2e503a65858 (&ei->socket.wq.wait){..-.}-{2:2}, at: __wake_up_common_lock+0x26/0x110 kernel/sched/wait.c:105
|  #6: ffffa2e506240930 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
|  #6: ffffa2e506240930 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x50/0x930 kernel/sched/core.c:4154
|  #7: ffffa2e57dc2f398 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:593 [inline]
|  #7: ffffa2e57dc2f398 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
|  #7: ffffa2e57dc2f398 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1804 [inline]
|  #7: ffffa2e57dc2f398 (&rq->__lock){-.-.}-{2:2}, at: ttwu_queue kernel/sched/core.c:3942 [inline]
|  #7: ffffa2e57dc2f398 (&rq->__lock){-.-.}-{2:2}, at: try_to_wake_up+0x4ce/0x930 kernel/sched/core.c:4270
| irq event stamp: 89470
| hardirqs last  enabled at (89469): [<ffffffff978623b3>] seqcount_lockdep_reader_access include/linux/seqlock.h:74 [inline]
| hardirqs last  enabled at (89469): [<ffffffff978623b3>] ktime_get+0xf3/0x2c0 kernel/time/timekeeping.c:848
| hardirqs last disabled at (89470): [<ffffffff9971605e>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
| hardirqs last disabled at (89470): [<ffffffff9971605e>] _raw_spin_lock_irqsave+0x4e/0xb0 kernel/locking/spinlock.c:162
| softirqs last  enabled at (89413): [<ffffffff98f80605>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
| softirqs last  enabled at (89413): [<ffffffff98f80605>] release_sock+0x105/0x130 net/core/sock.c:3635
| softirqs last disabled at (89462): [<ffffffff976fb3f2>] __do_softirq kernel/softirq.c:588 [inline]
| softirqs last disabled at (89462): [<ffffffff976fb3f2>] invoke_softirq kernel/softirq.c:428 [inline]
| softirqs last disabled at (89462): [<ffffffff976fb3f2>] __irq_exit_rcu+0x72/0x110 kernel/softirq.c:637
| 
| assert no writes to 0xffffa2e506240068 of 4 bytes by task 16 on cpu 2:
|  __block_task kernel/sched/sched.h:2770 [inline]
|  dequeue_entities+0xde4/0xed0 kernel/sched/fair.c:7177
|  pick_next_entity kernel/sched/fair.c:5627 [inline]
|  pick_task_fair kernel/sched/fair.c:8856 [inline]
|  pick_next_task_fair+0xaf/0x820 kernel/sched/fair.c:8876
|  __pick_next_task kernel/sched/core.c:5955 [inline]
|  pick_next_task kernel/sched/core.c:6477 [inline]
|  __schedule+0x5e0/0x14a0 kernel/sched/core.c:6629
|  __schedule_loop kernel/sched/core.c:6752 [inline]
|  schedule+0xe7/0x1a0 kernel/sched/core.c:6767
|  schedule_timeout+0xaf/0x160 kernel/time/timer.c:2615
|  rcu_gp_fqs_loop+0x2d8/0xd40 kernel/rcu/tree.c:2045
|  rcu_gp_kthread+0x28/0x2f0 kernel/rcu/tree.c:2247
|  kthread+0x1dd/0x220 kernel/kthread.c:389
|  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
| 
| 1 lock held by rcu_preempt/16:
|  #0: ffffa2e57dd2f398 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:593 [inline]
|  #0: ffffa2e57dd2f398 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
|  #0: ffffa2e57dd2f398 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1804 [inline]
|  #0: ffffa2e57dd2f398 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x1f9/0x14a0 kernel/sched/core.c:6575
| irq event stamp: 791056
| hardirqs last  enabled at (791055): [<ffffffff99716270>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
| hardirqs last  enabled at (791055): [<ffffffff99716270>] _raw_spin_unlock_irqrestore+0x30/0x60 kernel/locking/spinlock.c:194
| hardirqs last disabled at (791056): [<ffffffff99706ad7>] __schedule+0x1d7/0x14a0 kernel/sched/core.c:6555
| softirqs last  enabled at (788540): [<ffffffff976fb3f2>] __do_softirq kernel/softirq.c:588 [inline]
| softirqs last  enabled at (788540): [<ffffffff976fb3f2>] invoke_softirq kernel/softirq.c:428 [inline]
| softirqs last  enabled at (788540): [<ffffffff976fb3f2>] __irq_exit_rcu+0x72/0x110 kernel/softirq.c:637
| softirqs last disabled at (788529): [<ffffffff976fb3f2>] __do_softirq kernel/softirq.c:588 [inline]
| softirqs last disabled at (788529): [<ffffffff976fb3f2>] invoke_softirq kernel/softirq.c:428 [inline]
| softirqs last disabled at (788529): [<ffffffff976fb3f2>] __irq_exit_rcu+0x72/0x110 kernel/softirq.c:637
| 
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 2 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.12.0-rc2-00003-g44423ac48780-dirty #8
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
| ==================================================================
