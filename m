Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7868137742;
	Wed, 23 Oct 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676212; cv=none; b=sdx2KUOY+v3nfku2kdbTq58zD//KJvuQvZWuQTx3cJQN7yingY5HoRwY49ke2C+K+ZT/YHQwxTvy3X1y2kI1DfkI9+5RvUVj5KKCeBLtOSK8CBPzzePmMXKmtHTWgqvvPaIVzI+4T3ffQRkaxbsQRs7qQCAYrnHMEgx9ruTSz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676212; c=relaxed/simple;
	bh=P6uiAhHDu0rXECDnGfYxIZMD7DHw4/fhTlSUQXpBGSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsEbwjl7+QHLYOe5eVzFWshPQS5C8rXh9L6bSmWUejyuN55Dgi+LwZUTYdLUnjGyfLCL4wv+KOBCHM9MSGlArphxYHC5lgny0bW1rc3gP9U9IfE5nZF0EkvuLLIQulmIumiEWyLKElU6u7xsK9iG0qb+FjalMkdfq5BQuxcK74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SKj85vqj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SKj85vqj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0QqaVJw955tDo7xTEh8OO1zPRB/LMf4vrfcbek+Xm60=; b=SKj85vqjTxPYvsGhq2TRllbw3N
	rt6whtd2EoGrhmun05Q6glR4IW6qaF135DRJxT6DBA9f6pKU6bQ0VX3SD40ZIIocwuNc1Dj/16T1m
	jIjFzaOiQ1Z7OCusiD18jgwP1gkkxtpUHAYp3j3zDzzt6bqzitvD/2//GJAyeRa5sXTjw49wkpsRv
	ep1PStofJpp5qCswOxfu0CZxs/C0DJe+ioBBBkD1eqkiY2tXrqGMAmuDQ34NQWaoM5V/j78SACY/s
	faQki0K0RWyOWrEE9CZl/FxG0GUgLTOUZbdptmdkW+zIo0v83w/SkLZ4el0HowR7IO2SSmC+hiIgR
	xBd+kWmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3XnF-00000002i1C-0YR4;
	Wed, 23 Oct 2024 09:36:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B1C130073F; Wed, 23 Oct 2024 11:36:41 +0200 (CEST)
Date: Wed, 23 Oct 2024 11:36:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>,
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com, kent.overstreet@linux.dev
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <20241023093641.GE16066@noisy.programming.kicks-ass.net>
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net>
 <ZxerZIxg8kAMCvYc@elver.google.com>
 <20241022191244.GB9657@noisy.programming.kicks-ass.net>
 <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
 <Zxi5tbLnhoG4pEcm@elver.google.com>
 <CANpmjNNx6QM67jSaAtkYdxA+A5_FGPLBkBxdVXQ_XOLB8pgzNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNx6QM67jSaAtkYdxA+A5_FGPLBkBxdVXQ_XOLB8pgzNw@mail.gmail.com>

On Wed, Oct 23, 2024 at 11:03:11AM +0200, Marco Elver wrote:
> On Wed, 23 Oct 2024 at 10:54, Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 09:57PM +0200, Marco Elver wrote:
> > > On Tue, 22 Oct 2024 at 21:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > [...]
> > > > So KCSAn is trying to tell me these two paths run concurrently on the
> > > > same 'p' ?!? That would be a horrible bug -- both these call chains
> > > > should be holding rq->__lock (for task_rq(p)).
> > >
> > > Yes correct.
> > >
> > > And just to confirm this is no false positive, the way KCSAN works
> > > _requires_ the race to actually happen before it reports anything;
> > > this can also be seen in Alexander's report with just 1 stack trace
> > > where it saw the value transition from 0 to 1 (TASK_ON_RQ_QUEUED) but
> > > didn't know who did the write because kernel/sched was uninstrumented.
> >
> > Got another version of the splat with CONFIG_KCSAN_VERBOSE=y. Lockdep seems to
> > think that both threads here are holding rq->__lock.
> 
> Gotta read more carefully, one instance is ffffa2e57dc2f398 another is
> ffffa2e57dd2f398. If I read it right, then they're not actually the
> same lock.

Yeah, as explained in the diagram below, the moment the ->on_rq = 0
store goes through, we no longer own the task. And since
ASSERT_EXCLUSIVE_WRITER is after that, we go splat.

The below patch changes this order and switches to using
smp_store_release() and ensures to not reference the task after it.

I've boot tested it, but not much else.

Could you please give this a go (on top of -rc3)?

This also explains the SCHED_WARN_ON() Kent saw, that is subject to the
same race.

---
 kernel/sched/fair.c  | 21 ++++++++++++++-------
 kernel/sched/sched.h | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258dc71f..8edac978edb2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5625,8 +5625,9 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	struct sched_entity *se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		SCHED_WARN_ON(se->sched_delayed);
-		SCHED_WARN_ON(se->on_rq);
+		/*
+		 * Must not reference @se again, see __block_task().
+		 */
 		return NULL;
 	}
 	return se;
@@ -7170,7 +7171,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
 
-		/* Fix-up what block_task() skipped. */
+		/*
+		 * Fix-up what block_task() skipped.
+		 *
+		 * Must be last, @p might not be valid after this.
+		 */
 		__block_task(rq, p);
 	}
 
@@ -7187,12 +7192,14 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
 		util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0) {
-		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;
-	}
 
-	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	/*
+	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
+	 */
+
 	hrtick_update(rq);
 	return true;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b139016cbd9..32e9c41b7ec0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2791,8 +2791,6 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
-	WRITE_ONCE(p->on_rq, 0);
-	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
@@ -2800,6 +2798,38 @@ static inline void __block_task(struct rq *rq, struct task_struct *p)
 		atomic_inc(&rq->nr_iowait);
 		delayacct_blkio_start();
 	}
+
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+
+	/*
+	 * The moment this write goes through, ttwu() can swoop in and migrate
+	 * this task, rendering our rq->__lock ineffective.
+	 *
+	 * __schedule()				try_to_wake_up()
+	 *   LOCK rq->__lock		  	  LOCK p->pi_lock
+	 *   pick_next_task()
+	 *     pick_next_task_fair()
+	 *       pick_next_entity()
+	 *         dequeue_entities()
+	 *           __block_task()
+	 *             RELEASE p->on_rq = 0;	  if (p->on_rq && ...)
+	 *             				     break;
+	 *
+	 *             				  ACQUIRE (after ctrl-dep)
+	 *
+	 *             				  cpu = select_task_rq();
+	 *             				  set_task_cpu(p, cpu);
+	 *             				  ttwu_queue()
+	 *             				    ttwu_do_activate()
+	 *             				      LOCK rq->__lock
+	 *             				      activate_task()
+	 *             				        STORE p->on_rq = 1
+	 *   UNLOCK rq->__lock
+	 *
+	 * Callers must ensure to not reference @p after this -- we no longer
+	 * own it.
+	 */
+	smp_store_release(&p->on_rq, 0);
 }
 
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
