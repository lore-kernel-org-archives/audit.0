Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450127CCE0
	for <audit@vger.kernel.org>; Thu, 27 Aug 2026 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787791848; cv=none; b=lUnH9/PmqCbgYc/CWAqUomlhy+lLE4N35XmESlryJ9/FJG5mb8mEcSJTML2GspuFAkcp5WMXjA1H70CxRJCDsnjPlWGHfJVLxLJR2Aail3EqL8cff6nz2nLqurr1EX6Z+OdwuRQz3yFxjQLDkKvEvsOcSM/0eh9TJvS8EaF1Ovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787791848; c=relaxed/simple;
	bh=I91zT7bi8CbiqYpDL1hKBuFQfWl3eq5wnlYIHQII3IM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KYlp4VINZS7ag3v5gjdrUZ+kDJXdmnRmtLdlWwaFP/dlqW/PsAewm8jlmwurEJ370lWLqmIK5Bry++EbBB2GElepuRJ19Gptg9KszkoSgN8lOoT/7U//qgcCF8VGTpIPxSpsgfCj98FL7H1mkdlOcE8P2s/P6GGektc7fNMDZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495e058ca73so563082b6e.0
        for <audit@vger.kernel.org>; Wed, 26 Aug 2026 17:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787791845; x=1788396645;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myKNcAXHQHBzDxhBxtfw059JmFkfhbvcFY/BtTg3Qcs=;
        b=HXKi2+5iZdBEdo7DXpWpiL7UYnmj9UgmOUvrsK4h1b8ad6gd71IFVl57jrFd4m1y7+
         6RAiKTQeQDM/5DiPtDjB98/571qlQjrVbm9WrS5jTrzSmM6c8U+EzNUbyQP14tnX8XHb
         df9egu4yWcvGUYo8O9RFknH57FdBJA4U1ETW0vD8+yUGatVg6kCmy/AUZpD0J0mjO+Tz
         rRH6hf/yu3qNNsgMM8rynAPq8erwvuuqSFnbvGuni8rHq6tcB+KJWV5Wibzp/HkNiQb1
         S/OcNYK9/AS26m5JzPssfSr6WbZxozrJ5nXpPNKCVX76O0Hz/6Fjk62MC1drM9Ka9b7t
         kLzg==
X-Gm-Message-State: AFuF++kHwPUXLF9epWUjFRiFYw9ByrCR+RbgCHhR+Mos/MBOWgPEtJ7O
	0iRU39UF7MTcVyIVJDT6VDmB4Rx+GaG0AQy2ZfhCPApwYgOho2UP8hbvNebY7rYIDCXOC6SjJbp
	JjrXK6YK3gs21iNghfyT2oDwyrdR0U90LlhyIw0QB1g+278u+Mc+lcuARK0l9dw==
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:199b:b0:4b3:7efc:e970 with SMTP id
 5614622812f47-4b37f0c2d0bmr3488260b6e.5.1787791845588; Wed, 26 Aug 2026
 17:50:45 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:50:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com>
Subject: [syzbot] [audit?] BUG: unable to handle kernel paging request in integrity_audit_message
From: syzbot <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66fb95a52111 Merge tag 'caps-pr-20260820' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1560d549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0978f5ed2905b98
dashboard link: https://syzkaller.appspot.com/bug?extid=5ebeb3089ea6439c37be
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb4625580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7d9049723b0/disk-66fb95a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a04d6efe59a0/vmlinux-66fb95a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81e3f2b9c049/bzImage-66fb95a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffdc
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD eb97067 P4D eb97067 PUD eb99067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5818 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90003d77940 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff8207fb91 RDI: ffffffffffffffdc
RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000b7
R10: 00000000000006c0 R11: ffffffff8bc921d3 R12: ffff8880785a84c0
R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
FS:  000055555ec16500(0000) GS:ffff888123b86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffdc CR3: 0000000075fb6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __fortify_strlen include/linux/fortify-string.h:218 [inline]
 audit_log_untrustedstring+0x19/0x30 kernel/audit.c:2203
 integrity_audit_message+0x366/0x4f0 security/integrity/integrity_audit.c:60
 integrity_audit_msg+0x41/0x60 security/integrity/integrity_audit.c:32
 validate_hash_algo security/integrity/ima/ima_appraise.c:752 [inline]
 ima_inode_setxattr+0x512/0x5f0 security/integrity/ima/ima_appraise.c:775
 security_inode_setxattr+0x2d0/0x560 security/security.c:1940
 __vfs_setxattr_locked+0xad/0x2b0 fs/xattr.c:309
 vfs_setxattr+0x14a/0x390 fs/xattr.c:344
 do_setxattr+0x145/0x180 fs/xattr.c:662
 file_setxattr fs/xattr.c:672 [inline]
 file_setxattr+0x139/0x1b0 fs/xattr.c:666
 path_setxattrat+0x335/0x3b0 fs/xattr.c:732
 __do_sys_fsetxattr fs/xattr.c:782 [inline]
 __se_sys_fsetxattr fs/xattr.c:779 [inline]
 __x64_sys_fsetxattr+0xc5/0x140 fs/xattr.c:779
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f506239e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3373f938 EFLAGS: 00000246 ORIG_RAX: 00000000000000be
RAX: ffffffffffffffda RBX: 00007f5062625fa0 RCX: 00007f506239e0d9
RDX: 0000200000000380 RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f5062435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5062625fac R14: 00007f5062625fa0 R15: 00007f5062625fa0
 </TASK>
Modules linked in:
CR2: ffffffffffffffdc
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 74 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
RSP: 0018:ffffc90003d77940 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff8207fb91 RDI: ffffffffffffffdc
RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000b7
R10: 00000000000006c0 R11: ffffffff8bc921d3 R12: ffff8880785a84c0
R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
FS:  000055555ec16500(0000) GS:ffff888123b86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffdc CR3: 0000000075fb6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 fc                	add    %bh,%ah
   6:	ff                   	lcall  (bad)
   7:	df 55 48             	fists  0x48(%rbp)
   a:	89 fa                	mov    %edi,%edx
   c:	48 89 fd             	mov    %rdi,%rbp
   f:	53                   	push   %rbx
  10:	48 c1 ea 03          	shr    $0x3,%rdx
  14:	48 83 ec 08          	sub    $0x8,%rsp
  18:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  1c:	48 89 fa             	mov    %rdi,%rdx
  1f:	83 e2 07             	and    $0x7,%edx
  22:	38 d0                	cmp    %dl,%al
  24:	7f 04                	jg     0x2a
  26:	84 c0                	test   %al,%al
  28:	75 50                	jne    0x7a
* 2a:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp) <-- trapping instruction
  2e:	74 3d                	je     0x6d
  30:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  37:	fc ff df
  3a:	48 89 e8             	mov    %rbp,%rax
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c0                   	.byte 0xc0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
