Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789414D2AC
	for <audit@vger.kernel.org>; Wed, 23 Oct 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689575; cv=none; b=WD97zmgYwUmtEpS9JIPA49Q/IPPENYIfpz4ok+H1tyGMXwHxPdbDzeL7+7qXbmaQkXa6vj0A5uo60UwkQgB8kySurWEIfYrIFgygkGg7kAl4ufUouIIdujYZ/8URgEeRMTLVRndOq+kAPRh4cy7dIWD685ppOXD1MAA5pfxZoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689575; c=relaxed/simple;
	bh=cE1kzxn9XszxmbepX83IoLC4BhoWMR+VzWypJktAOrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3+rrb7bLODBElhCddPiVqCuG0Z5z/ZZqEkc0nB9PNussOyad6MYYdDtX2/y9xSNvvokm38nZuYT/FEM+VZAHZy2OKnH0JHnZs+ntGj91748QWcpNVdNO58wcKLBXNaxsgslZHwodd7FAiAetkE9WrAwbu6oOxNouW476/k2vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KD4aZd1L; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KD4aZd1L"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so671799a91.0
        for <audit@vger.kernel.org>; Wed, 23 Oct 2024 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729689573; x=1730294373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nhfAJoe99t9qmdltkllJ52oMwmGFCPSY0c/8BmjTZ0=;
        b=KD4aZd1LRvmQUmdK0uqgraKgHrgtvnWnp207VwjOG26iIU2pnj69ts9z+OvRb7lVlB
         lKPVJsS7ntNj1Lj2VNtP47yQZ1CFu/f74hGSw8odNThZuMqZZXTumtUxHOZl7LcvWrC0
         tgBzJ5RxmB0FHW8+gKZCztZOZJ8FjoCT8/LIHpHDAIwu+S7/5id814OHptzq+1irfLcj
         dzqMc516kBDP7OL3U6GZT6PamRUHoCezyccpceGVfWxP0B9m8I5m0N4gSkqwUprwPXXg
         BDbvN2XpUerhRdCToEJ9SFhlUHcEZUrPeQslh/uzOHEsROTTQZj9h/9amLRuGSX6eTKm
         lvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689573; x=1730294373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nhfAJoe99t9qmdltkllJ52oMwmGFCPSY0c/8BmjTZ0=;
        b=ArYr467fh3JdyVWMNnxj00DJ9VGwPKOXwCJrcqX+rfVgxGf/fTQeEEeHn5+gxlbr6n
         ijs4r5OkcIUl+7PY+MWXzEEBrtoGqKBgCRFCKODDhGRw0ns3tUFxEUUObwvvy8bxdISE
         C5PMbvQq1tGiu0lDqNHjteMfCi7l6RtQiLuu+Nt+u1xF/1IKvBy+0RDSQVabErdZniIn
         RDD0s5gsevNksmX5suDfdpdMQvTVcPgW3QE1uiOHfDill/hjx32HUKH+FPXz7mTBVfpa
         PtGsnd9hv8DwYHrPgd94xSNIShXcpktS0CD33RORKbMZLp9MLKNETWRvE/1eNsQtcz/F
         RPjg==
X-Forwarded-Encrypted: i=1; AJvYcCVvZIZxLtN5DRsHCL1mGLg+XwvhtwVn2a/NRHIqQQPPDQrM0qlwltRkI70YGX6410JInQI2ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCJ9Kr4pKFLWxSriiLtb8BBxJoBt4WDT98fyMl5FUth5pf64I
	kmn3UwxewVymMLzaCcDe11DsPAeBM6vUP6oQijiyVbB1ZprthhhZWtowvJSWLm0WBgvrTnx78eS
	ercSpwkk7W2spjKe4uE4/FxLlu5bRMqkIABh9
X-Google-Smtp-Source: AGHT+IEM8nviiqGAZm+EjyEe2ziPKXYXWb/DuENWSh1OOSFcDS/U7oiKqXNRLKyss4ZqQWigkAnieWpX/dFEkm6BEBI=
X-Received: by 2002:a17:90a:3e81:b0:2e2:ad14:e467 with SMTP id
 98e67ed59e1d1-2e5db91088bmr9596722a91.3.1729689573092; Wed, 23 Oct 2024
 06:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com> <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net> <ZxerZIxg8kAMCvYc@elver.google.com>
 <20241022191244.GB9657@noisy.programming.kicks-ass.net> <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
 <Zxi5tbLnhoG4pEcm@elver.google.com> <CANpmjNNx6QM67jSaAtkYdxA+A5_FGPLBkBxdVXQ_XOLB8pgzNw@mail.gmail.com>
 <20241023093641.GE16066@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023093641.GE16066@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Wed, 23 Oct 2024 15:18:53 +0200
Message-ID: <CANpmjNNXOhRvdFDLAeTSyjLSZSb4qQWVbRgPcvxV_=zKUXrBqw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>, 
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Oct 23, 2024 at 11:03:11AM +0200, Marco Elver wrote:
> > On Wed, 23 Oct 2024 at 10:54, Marco Elver <elver@google.com> wrote:
> > > On Tue, Oct 22, 2024 at 09:57PM +0200, Marco Elver wrote:
> > > > On Tue, 22 Oct 2024 at 21:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > > [...]
> > > > > So KCSAn is trying to tell me these two paths run concurrently on the
> > > > > same 'p' ?!? That would be a horrible bug -- both these call chains
> > > > > should be holding rq->__lock (for task_rq(p)).
> > > >
> > > > Yes correct.
> > > >
> > > > And just to confirm this is no false positive, the way KCSAN works
> > > > _requires_ the race to actually happen before it reports anything;
> > > > this can also be seen in Alexander's report with just 1 stack trace
> > > > where it saw the value transition from 0 to 1 (TASK_ON_RQ_QUEUED) but
> > > > didn't know who did the write because kernel/sched was uninstrumented.
> > >
> > > Got another version of the splat with CONFIG_KCSAN_VERBOSE=y. Lockdep seems to
> > > think that both threads here are holding rq->__lock.
> >
> > Gotta read more carefully, one instance is ffffa2e57dc2f398 another is
> > ffffa2e57dd2f398. If I read it right, then they're not actually the
> > same lock.
>
> Yeah, as explained in the diagram below, the moment the ->on_rq = 0
> store goes through, we no longer own the task. And since
> ASSERT_EXCLUSIVE_WRITER is after that, we go splat.
>
> The below patch changes this order and switches to using
> smp_store_release() and ensures to not reference the task after it.
>
> I've boot tested it, but not much else.
>
> Could you please give this a go (on top of -rc3)?
>
> This also explains the SCHED_WARN_ON() Kent saw, that is subject to the
> same race.
>
> ---
>  kernel/sched/fair.c  | 21 ++++++++++++++-------
>  kernel/sched/sched.h | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 9 deletions(-)
[...]

Tested-by: Marco Elver <elver@google.com>

Previously syzkaller would give us that report within ~1h of fuzzing.
Have been fuzzing with your patch applied for 3h now, and this report
has not resurfaced.
