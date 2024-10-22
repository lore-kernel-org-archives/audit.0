Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA9148318
	for <audit@vger.kernel.org>; Tue, 22 Oct 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584425; cv=none; b=QySXVJWdxwJUIRwQrwcyv8UJwKIDKDPybQLB9gs2uViDpPzLg60vKklXNDWvBJBhTzRsagLz+GhTMS+W7jBmXRuZx0rBmipriL1pEpqYJKW8PzMpF8vlVOMAeJMCRPyjfiJrvtQ4tWgXlbET5QaL6dwPfhmuhToRU/0Dl73BYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584425; c=relaxed/simple;
	bh=E+Qcyf2R4VqoNT88QhhDFXVyO/tMN5xowOwFIw6jnu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAjc5Zp73VRSoqhb8xLb+++ESvJXZNNDmW2haE4vj82W8oT9BsLjaKIKrmQw8qbkCbsLSk5KqIAB73xoEybXZtlMnnpHpKsgtsofbunYC4ZqRU7VqSPxWw1bU9fjbF8lCj98Nw5PjDCsAAoMsiUxoEmvfHYMGWroNKlXYn7uSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wg88QGlR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wg88QGlR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb97afcec9so36211406d6.2
        for <audit@vger.kernel.org>; Tue, 22 Oct 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729584422; x=1730189222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELbm3JVnl53LPg/IxUGNFkZyEH+foxKJzo0yb+04EnM=;
        b=Wg88QGlRE7nKqj+TD8WqUaelBkvB6gZA8Sh0Ll+BeKVfv03dvh/x1zdMT8NZ331sTd
         PRtrhY82XCoc54uPxqkD34P+PmChgJfGD9yXDRn9mWWRpJCyLXf0wP7gZzDc0/GMbH2m
         fopApVV7QrnPub/qQ91rDsTGEM9FlMc60uIfM79bA1lcsMf1milI2FbvNN46Bfo5LBvR
         0jo781WNuueNtb4Rpzv05f3F610cjf+SSqbH005hJtU/u9y+jgkwljJC5pdqA4LwQ94l
         eRyX5habNSrgu532WXI/qB0gjksnxMaVFNYutXeTqcvFSo9/JrY3m6/FMIKnyk/1nFzI
         KT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729584422; x=1730189222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELbm3JVnl53LPg/IxUGNFkZyEH+foxKJzo0yb+04EnM=;
        b=pfr6H+4unk3ibCA3Kyo3Ad9ziL2jGsooUhMJyLFyMHWAliWwe4t+sxolMZw+dfnm2c
         WBbiSAeBlyuRw+HcCYjBeT0e/Z+DPYNRRAWI662oM7HdVndOXFmZvGyaCaEE6hzPA4Xs
         hxBFNDrynw+ef9oxJK1GV+jGMYwDbIjkkWbzoNtdGlaXursExm+3RghNJ1N12a0ViWXY
         5VBwBH6i0jQJjlEGK3S7JnBBbU6LlKmN0HS50DmwT5LCcCne4PHdgT7p9ad6OVYivHH3
         4CzanUOQJ2jDSsbmgixHB5Cf+aWZFXyFlEhxB1QO7n1FRf0T6V4RUNbPSDV7KG4nEqi0
         1GOg==
X-Gm-Message-State: AOJu0YzpBeMh4I/A58qs0Dix4XPARuSrYMMne769zUIgZqX29OKklbSk
	XOntUsp/4FNyqsX2mdLjgzLc3jZmu3A+0WKWpOa49HD5byEVhmjJK0gyyuB78o9m9UwklyznNmx
	RsoSssB5WmxMpa+YEecmccMxtECGJpNEl08f/
X-Google-Smtp-Source: AGHT+IE2h4xi6u2hY44IcZINfyx+ej84FU7xu74JiueNpnln6ODTks80rwvWOAShzajy31QJi8anMxELslpH5A/7Y+8=
X-Received: by 2002:a05:6214:3983:b0:6cc:3673:ec79 with SMTP id
 6a1803df08f44-6cde150b8cemr181737386d6.19.1729584422258; Tue, 22 Oct 2024
 01:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
In-Reply-To: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 22 Oct 2024 10:06:23 +0200
Message-ID: <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
To: syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:57=E2=80=AFPM syzbot
<syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f07a8058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86254f9e0a8f2=
c98
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ec1e96c2cdf5c0=
e512a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1be80941df60/dis=
k-075dbe9f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/494a9ac89c09/vmlinu=
x-075dbe9f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/919788d8c731/b=
zImage-075dbe9f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com
>
> audit: type=3D1400 audit(6022412112.141:243086): avc:  denied  { read } f=
or  pid=3D2950 comm=3D"syslogd" name=3D"log" dev=3D"sda1" ino=3D1915 sconte=
xt=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r:var_t tclass=
=3Dlnk_file permissive=3D0
> audit: type=3D1400 audit(6022412112.181:243087): avc:  denied  { read } f=
or  pid=3D2950 comm=3D"syslogd" name=3D"log" dev=3D"sda1" ino=3D1915 sconte=
xt=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r:var_t tclass=
=3Dlnk_file permissive=3D0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: assert: race in __block_task kernel/sched/sched.h:2770 [inlin=
e]
> BUG: KCSAN: assert: race in dequeue_entities+0x6df/0x760 kernel/sched/fai=
r.c:7177
>
> race at unknown origin, with assert no writes to 0xffff888101764268 of 4 =
bytes by task 29 on cpu 1:
>  __block_task kernel/sched/sched.h:2770 [inline]
>  dequeue_entities+0x6df/0x760 kernel/sched/fair.c:7177
>  pick_next_entity kernel/sched/fair.c:5627 [inline]
>  pick_task_fair kernel/sched/fair.c:8856 [inline]
>  pick_next_task_fair+0x7d/0x410 kernel/sched/fair.c:8876
>  __pick_next_task kernel/sched/core.c:5955 [inline]
>  pick_next_task kernel/sched/core.c:6477 [inline]
>  __schedule+0x284/0x940 kernel/sched/core.c:6629
>  __schedule_loop kernel/sched/core.c:6752 [inline]
>  schedule+0x55/0xc0 kernel/sched/core.c:6767
>  kauditd_thread+0x56b/0x650 kernel/audit.c:911
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> value changed: 0x00000000 -> 0x00000001
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 29 Comm: kauditd Not tainted 6.11.0-syzkaller-11558-g0=
75dbe9f6e3c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+PeterZ, who added the KCSAN assertion.

Peter, I am also hitting the same assert on ARM while fuzzing KVM. It
is tricky to reproduce though (we probably need to stress the
scheduler hard enough):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KCSAN: assert: race in dequeue_entities+0x6d8/0x794
kernel/sched/sched.h:2773

race at unknown origin, with assert no writes to 0xffffff80039f91e8 of
4 bytes by task 27858 on cpu 2:
 dequeue_entities+0x6d8/0x794 kernel/sched/sched.h:2773
 pick_next_task_fair+0x84/0x394 kernel/sched/fair.c:5627
 __schedule+0x218/0x888 kernel/sched/core.c:5968
 preempt_schedule_irq+0x3c/0x68 kernel/sched/core.c:7012
 arm64_preempt_schedule_irq+0x2c/0x40 arch/arm64/kernel/entry-common.c:301
 __el1_irq arch/arm64/kernel/entry-common.c:539 [inline]
 el1_interrupt+0x3c/0x54 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 flush_ptrace_hw_breakpoint+0x4f8/0x6b0 arch/arm64/kernel/ptrace.c:221
 flush_thread+0x70/0xf4 arch/arm64/kernel/process.c:287
 begin_new_exec+0x9ac/0xcdc fs/exec.c:1307
 load_elf_binary+0x4d0/0x1330 fs/binfmt_elf.c:996
 bprm_execve+0x3d8/0x958 fs/exec.c:1752
 kernel_execve+0x550/0x57c fs/exec.c:2012
 call_usermodehelper_exec_async+0x18c/0x270 kernel/umh.c:110
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 2 UID: 0 PID: 27858 Comm: kworker/u16:3 Not tainted
6.12.0-rc4-00001-g517096192323-dirty #84
Hardware name: linux,dummy-virt (DT)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
