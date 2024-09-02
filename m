Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894B185B78;
	Mon,  2 Sep 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266234; cv=none; b=BPkmvHmJmbk6hKC9cJ6OGqIH3aFUwcYz3ITFt7vvRAryG1Jl4SKXj2VzSeFaPdrfZaNLmaQSkRHRLG9lTiAAtbIdnCNiGoHCVj+ImkpO5elWybHLlO07OCpfklHkHfG5ZD0IiN4gQeLTAZR6cq4vu7zmZYTffJ8s0GTrZmqOCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266234; c=relaxed/simple;
	bh=oUstfHHiYNt0mP4C6vUtEFwvzDciWGU7q79k2eEG01o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mNzjcQt2wXeRAL98eR7vAIOSSllOwfLEz2pvmys9xqzmzV+HU98I7Jz7fjo+e8hGczI7zIEKGmBlcwkKrq41xW/wGg8IXpqBmc9uiffBdnGdjd/T212GbWtRPln+MNt/gzG4ynIS4dnRKyZwMJMhMxfuH2zZEHbtSRrV1MftaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pFr7AiK5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BwVJ9mc4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pFr7AiK5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BwVJ9mc4"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725266231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJMPn4CEeIgKZ3r2RQj2wbRGaDElDgUceUxREDFJ8M8=;
	b=pFr7AiK5YuoivSbxh8uXBTrTw/kf+m73zTV5eXWHCtGgYg3Mk6QbvZRTS3faDv6yP+QW5P
	maFJbd8Ig/zeUWugnqizFvCfxD8Y8Z8vtQvapf1F06WwIjdYYvDX/BxsS2Ux8W7uJnCegJ
	m+bxbLvV0QNdVZ44oGvrS2ru+L0/NAZAtgRVahtAVLhDpqxzzJuxZEPfeqgMqLpdamlbCM
	lr+jWx6mAmwOgGd5MBcuVa3AmPiA5rPXC9HG9MkeZiU5rTLccBi42heZyD4+DLW3/4foHN
	tDwgMrIn99trxAenmsRptl2q1xcwG42djYmJekYEJmPxpq0m9s8v47qy1Ceokg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725266231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJMPn4CEeIgKZ3r2RQj2wbRGaDElDgUceUxREDFJ8M8=;
	b=BwVJ9mc4DpeuX0SSMVb/1V6p6EyBB+lCnchpDb8oJp4fQHQDQN52cDQHZpVcAtzRnSr/wu
	W9myBV4sSFbRb/Aw==
To: syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, Kees Cook <kees@kernel.org>,
 audit@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in audit_log_start
In-Reply-To: <000000000000f11da7062091eb85@google.com>
References: <000000000000f11da7062091eb85@google.com>
Date: Mon, 02 Sep 2024 10:37:10 +0200
Message-ID: <87ikve78p5.ffs@tglx>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 26 2024 at 01:29, syzbot wrote:

Cc:+ seccomp and audit folks

> syzbot found the following issue on:
>
> HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c8680b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc
> dashboard link: https://syzkaller.appspot.com/bug?extid=4576eaa688ef747b8d6c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/disk-6a7917c8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmlinux-6a7917c8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa/bzImage-6a7917c8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com
>
> WARNING: CPU: 1 PID: 8527 at kernel/sched/core.c:8556 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> Modules linked in:
> CPU: 1 UID: 0 PID: 8527 Comm: syz.4.642 Not tainted 6.11.0-rc4-next-20240822-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> Code: a1 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ce e6 97 00 48 8b 4d 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 f8 02 f1 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
> RSP: 0018:ffffc90009ab7a20 EFLAGS: 00010246
> RAX: a60a1ffb5c104900 RBX: 1ffff11004257a6c RCX: 0000000000040000
> RDX: ffffc90003e59000 RSI: 000000000001b727 RDI: 000000000001b728
> RBP: ffff8880212bd360 R08: ffffffff8155a632 R09: fffffbfff1cfa364
> R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: dffffc0000000000
> R13: 0000000000000002 R14: 0000000000000151 R15: ffffffff8e0a492c
> FS:  00007f4cf5b6a6c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7e0f003000 CR3: 000000001feec000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  might_alloc include/linux/sched/mm.h:337 [inline]
>  slab_pre_alloc_hook mm/slub.c:3987 [inline]
>  slab_alloc_node mm/slub.c:4065 [inline]
>  kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
>  audit_buffer_alloc kernel/audit.c:1790 [inline]
>  audit_log_start+0x15e/0xa30 kernel/audit.c:1912
>  audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007
>  seccomp_log kernel/seccomp.c:1016 [inline]
>  __seccomp_filter+0xb38/0x1fe0 kernel/seccomp.c:1305
>  syscall_trace_enter+0xa8/0x150 kernel/entry/common.c:52
>  syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
>  syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
>  do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4cf4d157e9
> Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 c7 c0 0f 00 00 00 0f 05 <0f> 1f 80 00 00 00 00 48 81 ec 48 01 00 00 49 89 d0 64 48 8b 04 25
> RSP: 002b:00007f4cf5b69b40 EFLAGS: 00000206 ORIG_RAX: 000000000000000f
> RAX: ffffffffffffffda RBX: 00007f4cf4f15f88 RCX: 00007f4cf4d157e9
> RDX: 00007f4cf5b69b40 RSI: 00007f4cf5b69c70 RDI: 0000000000000021
> RBP: 00007f4cf4f15f80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 00007f4cf4f15f8c
> R13: 0000000000000000 R14: 00007fffe8828e10 R15: 00007fffe8828ef8
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
