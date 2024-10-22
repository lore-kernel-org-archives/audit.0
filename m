Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887513D516;
	Tue, 22 Oct 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596698; cv=none; b=JBK3cdCCzqk9f23Lv5U7XYmregvm298I4DUFXrBqEGFV95oBGIpukwopsWqhG8stRpvHPhMz9Howm6D+yPj8X3ValiS3C35P5u2Xfrvi2FGX/TmE/s4ncAIJNl/fBJG+2g6uXisW19IXkzrVf0/wc+n8VnlBSBA1yr50W+rSjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596698; c=relaxed/simple;
	bh=K0ZAIC0ih1OgAYGkxb/Y7IwopoPqXD+tHGWSN4/6UDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCw44adRY8C1NsPDziFQT2Dedb0GE5ROwIYPgd5TODvHN/pMNLJETnA1LNQpGmIeJcGiFDsPeEErBReKBNdRpuPGOwO3w/R3/z2qojJNmx2XaAS0XN3Cs+2tqCoXh6o3wbqKr/W/AdUJ8lm1PEFEC5KDcGySV65cpsBnfJtoTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K+Miy2N8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+Miy2N8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=45VhlSmrcqHM0fJmLndR/+hMewp2TUptqFBD/F7XlaY=; b=K+Miy2N87uFDpEv6MRafnX6rlO
	/+ijhGjh2TF5iRGIAGPTmcdyy7bt8miAd6I15KttI8Ec4Jv/z8duNmDoImt4VicB5Rx6SH1+jFITP
	vN2vei599XxcZi3g+d8D9JpLGzsirkMlE2GZZCjQ8eX561DTZ65ovA7W/R14Zix+EaOQlaw22/T/g
	R0el4fAEMQPB0LqlLbKli6+R+hOHc5lYqpnGz2ju/u4VYu6UwsZBbIhU3+T2CkovA1rqwPiyHyZEi
	IvhBelCyZBMtJwCtMf+izNYQDiSHrvQWb8G0sUmMtynguCAqCa9fbnrnNo6oaXGPIopc2r2psS9ml
	nm2H/0ZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3D6p-00000001ZcL-19AU;
	Tue, 22 Oct 2024 11:31:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7CF8B30073F; Tue, 22 Oct 2024 13:31:31 +0200 (CEST)
Date: Tue, 22 Oct 2024 13:31:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>,
	audit@vger.kernel.org, eparis@redhat.com,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
Message-ID: <20241022113131.GD16066@noisy.programming.kicks-ass.net>
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
 <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>

On Tue, Oct 22, 2024 at 10:06:23AM +0200, Alexander Potapenko wrote:
> On Fri, Sep 27, 2024 at 4:57 PM syzbot
> <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f07a80580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=86254f9e0a8f2c98
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0ec1e96c2cdf5c0e512a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1be80941df60/disk-075dbe9f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/494a9ac89c09/vmlinux-075dbe9f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/919788d8c731/bzImage-075dbe9f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com
> >
> > audit: type=1400 audit(6022412112.141:243086): avc:  denied  { read } for  pid=2950 comm="syslogd" name="log" dev="sda1" ino=1915 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:var_t tclass=lnk_file permissive=0
> > audit: type=1400 audit(6022412112.181:243087): avc:  denied  { read } for  pid=2950 comm="syslogd" name="log" dev="sda1" ino=1915 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:var_t tclass=lnk_file permissive=0
> > ==================================================================
> > BUG: KCSAN: assert: race in __block_task kernel/sched/sched.h:2770 [inline]
> > BUG: KCSAN: assert: race in dequeue_entities+0x6df/0x760 kernel/sched/fair.c:7177
> >
> > race at unknown origin, with assert no writes to 0xffff888101764268 of 4 bytes by task 29 on cpu 1:
> >  __block_task kernel/sched/sched.h:2770 [inline]
> >  dequeue_entities+0x6df/0x760 kernel/sched/fair.c:7177
> >  pick_next_entity kernel/sched/fair.c:5627 [inline]
> >  pick_task_fair kernel/sched/fair.c:8856 [inline]
> >  pick_next_task_fair+0x7d/0x410 kernel/sched/fair.c:8876
> >  __pick_next_task kernel/sched/core.c:5955 [inline]
> >  pick_next_task kernel/sched/core.c:6477 [inline]
> >  __schedule+0x284/0x940 kernel/sched/core.c:6629
> >  __schedule_loop kernel/sched/core.c:6752 [inline]
> >  schedule+0x55/0xc0 kernel/sched/core.c:6767
> >  kauditd_thread+0x56b/0x650 kernel/audit.c:911
> >  kthread+0x1d1/0x210 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > value changed: 0x00000000 -> 0x00000001
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 UID: 0 PID: 29 Comm: kauditd Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > ==================================================================
> 
> +PeterZ, who added the KCSAN assertion.

Well, PaulMck did in d6111cf45c57 ("sched: Use WRITE_ONCE() for
p->on_rq"), I just moved it around in e8901061ca0c ("sched: Split
DEQUEUE_SLEEP from deactivate_task()").

I'm not at all sure I have any inkling as to what the annotation does
nor what KCSAN is trying to tell us above.

Can someone please translate?


