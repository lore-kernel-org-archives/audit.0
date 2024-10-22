Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE251C9EC0;
	Tue, 22 Oct 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624373; cv=none; b=fno0rDZGT3N/VDnCWZ9aZxe6PCZ2J15/XRyikd5gsGKimZx81u+Wnv0kNANjpovqA6R+bb8Pg/XzDLgwDITGOPi0s1e+LQ72GurW4heP83qvHzODRWEajB/kpJvMvu5m8Ts7QpSecr1AMZCTJufIHFGpu3D+vCpZo9fVBdx/AhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624373; c=relaxed/simple;
	bh=2ElciyA8j+bcr3KSKpFrhrYhf77IoHrspCERoE/gMBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL6KNK8Dp7+6WXfLbi8V77OagQL0/txbXCg/mxh4Ny1skUNW9u/CFFCk6NRokf10/AL88xaOrxzxAcJ0eCGkMkgfmFg5PB4bi4CnPUWU/WunienFxTcayx1Cz/PCeikQ7ZnBy+MNim39/X0VhDXCY68aljn6cKD4i34r2Qze/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V8Bw54Vw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8Bw54Vw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NyBn1Ps/cKiHnj+q5tWxSAnKnyG3+UZjgcGjvB8gXlc=; b=V8Bw54VwUHs19zJZs0nY5KFr7W
	Akz7ilXOgSAqfBUWNDrPBMykU/Vw4ZBsrHuky3PMAtaif81/KLsJvGQOmC6fy3y4hSxJLxH9Fic34
	3X5gVIE5JumVsYA2ZQNllYdFG+/51o2Z260g8uaSKsnkUMF443y2oSuzXN0uQZ70ju0VIznHhCUa2
	VvawoHlLrMg2EPIl33M1TzAOaOKkhBe+ROQ7VNroIz1udgb+cnW8IFhACl7RBxdjtYsldXVcEM22i
	teDOcWiJnOfGr16PuXHuu07cvJl2ggSNlrMthXLbfhawc4DTnff9wlLs9+lOGqZf6CHc37wdyiB/G
	EZ4kNAbA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3KJB-00000008GJG-3AUt;
	Tue, 22 Oct 2024 19:12:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EAC7D30073F; Tue, 22 Oct 2024 21:12:44 +0200 (CEST)
Date: Tue, 22 Oct 2024 21:12:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>,
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <20241022191244.GB9657@noisy.programming.kicks-ass.net>
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net>
 <ZxerZIxg8kAMCvYc@elver.google.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxerZIxg8kAMCvYc@elver.google.com>

On Tue, Oct 22, 2024 at 03:40:52PM +0200, Marco Elver wrote:

> Which gives us:
> 
>  | ==================================================================
>  | BUG: KCSAN: assert: race in dequeue_entities / ttwu_do_activate
>  | 
>  | write (marked) to 0xffff9e100329c628 of 4 bytes by interrupt on cpu 0:
>  |  activate_task kernel/sched/core.c:2064 [inline]
> 
> This is this one:
> 
> 	void activate_task(struct rq *rq, struct task_struct *p, int flags)
> 	{
> 		if (task_on_rq_migrating(p))
> 			flags |= ENQUEUE_MIGRATED;
> 		if (flags & ENQUEUE_MIGRATED)
> 			sched_mm_cid_migrate_to(rq, p);
> 
> 		enqueue_task(rq, p, flags);
> 
> 		WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
> 		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> 	}
> 
>  |  ttwu_do_activate+0x153/0x3e0 kernel/sched/core.c:3671
>  |  ttwu_queue kernel/sched/core.c:3944 [inline]
>  |  try_to_wake_up+0x60f/0xaf0 kernel/sched/core.c:4270

>  | assert no writes to 0xffff9e100329c628 of 4 bytes by task 10571 on cpu 3:
>  |  __block_task kernel/sched/sched.h:2770 [inline]
> 
> And that's:
> 
> 	static inline void __block_task(struct rq *rq, struct task_struct *p)
> 	{
> 		WRITE_ONCE(p->on_rq, 0);
> 		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> 		if (p->sched_contributes_to_load)
> 			rq->nr_uninterruptible++;
> 
>  |  dequeue_entities+0xd83/0xe70 kernel/sched/fair.c:7177
>  |  pick_next_entity kernel/sched/fair.c:5627 [inline]
>  |  pick_task_fair kernel/sched/fair.c:8856 [inline]
>  |  pick_next_task_fair+0xaf/0x710 kernel/sched/fair.c:8876
>  |  __pick_next_task kernel/sched/core.c:5955 [inline]
>  |  pick_next_task kernel/sched/core.c:6477 [inline]
>  |  __schedule+0x47a/0x1130 kernel/sched/core.c:6629
>  |  __schedule_loop kernel/sched/core.c:6752 [inline]
>  |  schedule+0x7b/0x130 kernel/sched/core.c:6767


So KCSAn is trying to tell me these two paths run concurrently on the
same 'p' ?!? That would be a horrible bug -- both these call chains
should be holding rq->__lock (for task_rq(p)).

