Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E71EC002
	for <audit@vger.kernel.org>; Tue,  3 Sep 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398520; cv=none; b=qQaQy2WYciD4CZvolBHOgRGHACD3z0HTf0dBD40ZVEf4sWDbc7MjE/zsemPs2AFcSubeBhox3esMxrdLiM3iI8rYvDkKCU4lnWmmBPp4KBaBtXUoyBJtTLnq6QMzuz34vVbzbu4ZXXE+A9H9+kI7+jpX/oYHDZVBFk+393N2bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398520; c=relaxed/simple;
	bh=aRGN7Q4oM29wnNN5CoLkvA83kVg3g0cMPRDuipkS0t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2LCmf7meUsKDzdtaHpwgpRhdgFQkLkUhz80eouMLEGTFy4PDE3OCmBdmh5guFoBoplEyk5N8XHpPezejAjPRzmJFNXQisaD0yMCloYpobs+EJyGm27b0MnKbRRfWKdiYePE1+l2Zc0ugjhACSfwISbILi2kRzjenTeIkoxfehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VKkui1ra; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VKkui1ra"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5988612276.0
        for <audit@vger.kernel.org>; Tue, 03 Sep 2024 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725398517; x=1726003317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXA0xSJQlYROteWSt6u0tfLG7BWHJLI4oFboUAe4mGQ=;
        b=VKkui1ralVYvfFdS6OxBiNHusDBd0Coj0aSqjZajrE/b2HibjedB4lHoxMYOVLOYiL
         FiQUqIdqJBuGE5UvHDmTlblb6ui6ti3H7UPBx9MbhQAFk0nO4zZ5KWfqZNlXxe/PVlG4
         Fzne0V+xOipUWmes70o8E6jtoLVvFSuDaDrA3RGHTA9rS13mlAB8TS981F3TOQVcPznL
         Pf0cD79sAP5x/JSI45SSBuasSumxGIB5tFhA+0FwJc3BunTd5F+l8jCV76ECqB1na6S4
         b5/86LTSlPpD7eBpkOtJpMxmLtmn74v9qGeAKTkU2PgWsy0mqlflUY/NIHZeTWkghA4F
         K8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398517; x=1726003317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXA0xSJQlYROteWSt6u0tfLG7BWHJLI4oFboUAe4mGQ=;
        b=Y1N7Z2nhneX0jZyN8kiEry0K70DQyf4g2jYVdl1yGL+XopCyXivoO0F1IJtTR2tgcl
         A2QCedz6qbTcMOX3ydMwFzAoD2DFOGwsvaxg9fOmzjXVg7jzPj9fUOQCYqh1ND3XwS+W
         GpjCTQ/b5NgbDnLb2jOdzGd1n6nTlZirmahjRLhTsyEl+ExDPsczk2X0NPk9YtOR4f5T
         Tbf6YIKXZIYUhpznAO2k441KJYKG0oV8aKx1y6kNaauQ/TXSk1gMtFObmhKjn817JzjF
         at+qJwgclsdWYD7Alrd7z1JlBKPPtGurtyw675MohQbwmqxlJ29EAZg3z+zPdFjGL+1a
         305w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8iRGTJEpsN8e+lfO40KiteGGBtAWoqQ07DObQrEUL7Ta+whhfJfsdqgAj1/PI41L0fFugQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7TcbPXGDOblAltLO1QrNSIQTdWXrbb0IHUcauG5PpuY9TLgx
	yT2UII38RdlrjQbB3nj6g62nwZEgPsGPX3STwK8dvYyCA5xQv70R6EZ008kN5FAczp3pCviTadw
	/eLjbHiv2y+RLmfIB/C2lKsuo95tOIpEVV0PM
X-Google-Smtp-Source: AGHT+IH8n7CPH3uJVFcHVFs1uxYm7rpNIiyWYnL1DNE3C5hXZTHnf1EuK+wvQeq/lHzwj1Wxe4LAt4MQvfX7taYRwRs=
X-Received: by 2002:a05:6902:2788:b0:e1a:af1e:d3c7 with SMTP id
 3f1490d57ef6-e1aaf1ed70emr9898856276.46.1725398517432; Tue, 03 Sep 2024
 14:21:57 -0700 (PDT)
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
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Sep 2024 17:21:46 -0400
Message-ID: <CAHC9VhTAjuoGQerDwjwwiVGuvWM1ugxxUMjSshH1gTfcC0BJ0g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, 
	syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:54=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
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

Okay, with no obvious root cause and no reproducer, I'm going to
ignore this for now.  If we start to see this pop up on real systems
and/or syzbot finds a reproducer we can dig into it more.

--=20
paul-moore.com
