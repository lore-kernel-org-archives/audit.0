Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DA187561
	for <audit@vger.kernel.org>; Tue,  3 Sep 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391352; cv=none; b=SfaQupfc2OPWyBzu2lPfshdJnk+FefVqJhd6m+cOE+lC6LyGqbnyBg296LhNLR+Kd0oJM4jH92iA8o3xPqi4bmZVlzD5oCdwz3zqTpc1jfjdDImXF0Hh05veCf4Oh4seXfvnbwSUosxdxp73hTJUWMvO2xQ2Tj9WERSbF1YFcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391352; c=relaxed/simple;
	bh=QEEfzj8cshMsLiWYHrWLdIu75VlPejmgUQecR7Es5VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQt6BlMZTn80d0l7kpwpvAbcW7F5V/GCkKYodDle7neC4E7leZYo7Fb5dpw9EvFlJWFx5oO+3w3xjzrnxSr3E3BUIsOlsFMAsHEar1MmWc1/D6eqlwZJ+l2gUWUkbMhfF2YInoWomxPv24LwfJyaP20eEPi5Cjps9O+XkdNp7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GkFY83tf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GkFY83tf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d9f65f9e3eso18442627b3.3
        for <audit@vger.kernel.org>; Tue, 03 Sep 2024 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725391348; x=1725996148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GlawrwUSXe3aNQO89Xcrk7RQDofcGK9J3cXmeFFeLk=;
        b=GkFY83tfEr+XJEk0Daa7RAk28d+w0BBZ8rbGKKrhTzQlNNpabuvgootVVZIlhX6OSX
         cmBqG9gk9zPC0xij5Vd44OwOb+tky1Plz6vsWcpSR/3KrG996iOib0KdOWSgySndY4HN
         Po5oAIZWNPQxtENWK805vvcVStseNfWuvRbdmmIgG14t1GcRW4cgtvTJmz6H/PbkrYE3
         f6azn8zRVg9BqfHIusXJu5NYTAYFs0OHfqQzGSpikEIdqIobrUi1QWJs7s1lQi5nWnzB
         ao1m6SMORRmhLZF1jCxQQ2LWQZ32eZxpQXNhe3Os1y1Ffz4eMf/nLUkI6apk8GIrgAJd
         FzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391348; x=1725996148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GlawrwUSXe3aNQO89Xcrk7RQDofcGK9J3cXmeFFeLk=;
        b=w35uvprWyFGghOYDDuyHt8/lcb8B8awkaCUuSkve6IQKHcm9Zwn5fdU+NuqX3RKvhl
         313mq+cZVIrDQneFCMkd0owFtMl2ZgkvXhTD3kqznUGerz99Sa81z3J6OaoONuXUSvB7
         UNp76nEs0FOypyznkIOtGNxbO7en8ps5cF5blMTPLJ1QwBk4f/OH0v8C72IH/Zw6JE+a
         qzWZ6RS9DjHfIoyu+pjWwBoYrRGFbet4OMHo7TLsTPBDZCvUR5ukbVc53x0E+kL8L0Hh
         L8NElsKdICht6Wuav8BR/eGPL+uhbo+auNlWGxpJr6qxeYocwAvhAGUzT5IFEMNwqOuj
         24ww==
X-Forwarded-Encrypted: i=1; AJvYcCWK8Gs9lpIDGEvr1vWhjUES8YHkDg5HOYONmWO9C9R1BHDQjWs+4Ps027Ak0sr2BYHZmEuG5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHohqTLNsOU6dyAp4BzwiPhFoIgdbrZYx+V0IkfdlRaWUKNJr
	U+NNM/XO4fL3kkl0EgZCcNoszDmoYK35qFHiRJvdn/moy4v+kWd4XQz6QPCo2cnj+0Mfmvyx89v
	3rBtMQYD7A+6Q1KEuAHjp6MiTNiMw6EtxXDlc
X-Google-Smtp-Source: AGHT+IFN0fsoKVEfHX1GFKkuFIfj+8hJtVHznAdlkZj14xPfOba7Tx0v3FLFl1U8ao3IbZAgy0fldZIep07nD8sW/3Y=
X-Received: by 2002:a05:690c:4a0d:b0:6ab:e840:7f4d with SMTP id
 00721157ae682-6db14e75b14mr29715247b3.46.1725391348631; Tue, 03 Sep 2024
 12:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f11da7062091eb85@google.com> <87ikve78p5.ffs@tglx>
In-Reply-To: <87ikve78p5.ffs@tglx>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Sep 2024 15:22:17 -0400
Message-ID: <CAHC9VhTDqe8pYbmuNUu-Mdq6rmLo17z+eUTiOFh_PegbN99b-w@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, Kees Cook <kees@kernel.org>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:37=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Aug 26 2024 at 01:29, syzbot wrote:
>
> Cc:+ seccomp and audit folks
>
> > syzbot found the following issue on:
> >
> > HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15c8680b980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D897bd7c53a1=
0fcfc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4576eaa688ef7=
47b8d6c
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/d=
isk-6a7917c8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmli=
nux-6a7917c8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa=
/bzImage-6a7917c8.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com
> >
> > WARNING: CPU: 1 PID: 8527 at kernel/sched/core.c:8556 __might_sleep+0xb=
9/0xe0 kernel/sched/core.c:8552
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 8527 Comm: syz.4.642 Not tainted 6.11.0-rc4-next-202=
40822-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> > Code: a1 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ce e6 97 00 48 8b 4d=
 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 f8 02 f1 ff 90 <0f> 0b 90 90 =
eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
> > RSP: 0018:ffffc90009ab7a20 EFLAGS: 00010246
> > RAX: a60a1ffb5c104900 RBX: 1ffff11004257a6c RCX: 0000000000040000
> > RDX: ffffc90003e59000 RSI: 000000000001b727 RDI: 000000000001b728
> > RBP: ffff8880212bd360 R08: ffffffff8155a632 R09: fffffbfff1cfa364
> > R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: dffffc0000000000
> > R13: 0000000000000002 R14: 0000000000000151 R15: ffffffff8e0a492c
> > FS:  00007f4cf5b6a6c0(0000) GS:ffff8880b9100000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f7e0f003000 CR3: 000000001feec000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  might_alloc include/linux/sched/mm.h:337 [inline]
> >  slab_pre_alloc_hook mm/slub.c:3987 [inline]
> >  slab_alloc_node mm/slub.c:4065 [inline]
> >  kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
> >  audit_buffer_alloc kernel/audit.c:1790 [inline]
> >  audit_log_start+0x15e/0xa30 kernel/audit.c:1912
> >  audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007

The audit_seccomp() function allocates an audit buffer using
GFP_KERNEL, which should be the source of the might_sleep.  We can fix
that easily enough by moving to GFP_ATOMIC (either for just this code
path or all callers, need to check that), but I just want to confirm
that we can't sleep here?  I haven't dug into the syscall code in a
while, so I don't recall all the details, but it seems odd to me that
we can't safely sleep here ...

> >  seccomp_log kernel/seccomp.c:1016 [inline]
> >  __seccomp_filter+0xb38/0x1fe0 kernel/seccomp.c:1305
> >  syscall_trace_enter+0xa8/0x150 kernel/entry/common.c:52
> >  syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [in=
line]
> >  syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
> >  do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f4cf4d157e9
> > Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 90 66 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 40 00 48 c7 c0 0f 00 00 00 0f 05 <0f> 1f 80 00 =
00 00 00 48 81 ec 48 01 00 00 49 89 d0 64 48 8b 04 25
> > RSP: 002b:00007f4cf5b69b40 EFLAGS: 00000206 ORIG_RAX: 000000000000000f
> > RAX: ffffffffffffffda RBX: 00007f4cf4f15f88 RCX: 00007f4cf4d157e9
> > RDX: 00007f4cf5b69b40 RSI: 00007f4cf5b69c70 RDI: 0000000000000021
> > RBP: 00007f4cf4f15f80 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000206 R12: 00007f4cf4f15f8c
> > R13: 0000000000000000 R14: 00007fffe8828e10 R15: 00007fffe8828ef8
> >  </TASK>

--=20
paul-moore.com
