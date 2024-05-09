Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60A149C7D
	for <audit@vger.kernel.org>; Thu,  9 May 2024 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242469; cv=none; b=jlZBN/rBQEqE0+Z00Ys0anx/xfyQ+8lfzjsojdZnpfNgU6BoMqZOLU9QN9lbtF02IgpTLKud9PXsHg91FMJ0MTFj3n48azX0sQODfrXI5xeV5v9cVK21t2ABLH1hcEtpYlNZlZp1JhNMUsFsTq5XWeom/rvFjGNE18gK317j+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242469; c=relaxed/simple;
	bh=S+++mKsRIHHx7sZeviVcG6JunQ5p0RGx6gJDPMnwkF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DuQ7tlQJOyIqvnPaR2jUryappym0GF/dolwTG/+DsUVi6fuW0in86znLjr+j6U7wFLXw3kmHZY55AnEHjLRZzz5LRH93RzC1Af7lvz91xGpjf9baxY7FRfSsY+VVQE8uy0bbQIkjhYaTHT3n2q0/t4bp7BmVAyf+Ezv54qB+HpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1a9dabe13so36118039f.3
        for <audit@vger.kernel.org>; Thu, 09 May 2024 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242467; x=1715847267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2wEFOkf970B/8gVOx1KK4iqXyrR3ivy0jgsSs7YWss=;
        b=VIkevo6hKc2UvmOsfu9iofahaudWEMiQ2wsfgwWkYsHgFBWmnGCIVnDDQ3XvnMwAOh
         jfvEn9TppEHQEYC5GO4Vyc+chSh2MTLyEiuqV4ANBGT54hiw+uAQfLQSR4lFtvZbq+FS
         q4Cla7BjrXssZ5WmIU2B3ng0wQGx3+F/9hYOjYovGSqyarKkCG8fd36Vt14zTTEsVDIm
         gQd8uxD0h1D5OnO3aGDoS4UuFmINklJh6bkL10w6zXh5a0Uz6Qz2icnBBer2ILbTHS17
         ZfArdn5zHZZlSwwa33rxQHMmSNYIQOQJ7xGGd6BpHgaMCjWMYuRlL6oP58HPqShLkNZT
         be6g==
X-Gm-Message-State: AOJu0YxOfTkAIAvtJ+wZYuMn4tDNmbdCrt+Ymxw/IxUUTL7RzNedm5i4
	onh504DnfIrwgHJrpq9tp394o5Mht1Zx8g8XHG6fcuLQ91zV9VUIBFC/GXKwwSflrtDgD8xwRfw
	WUsrWEqximvJ0z5d72KO9+e40kPI0d5VbozLpGMVhDybCAKkdFUWocFI=
X-Google-Smtp-Source: AGHT+IGdBWhaOUyhvH0HXpnyNmpHUtiReK74EtGA1qz2s4yQpc9tTEXsfEIRuq8hdUhaFQqRqlNa5WA2hKejrWShLZ/Kjw4W48Zi
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270e:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-488fd34f405mr298385173.0.1715242467191; Thu, 09 May 2024
 01:14:27 -0700 (PDT)
Date: Thu, 09 May 2024 01:14:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5f83206180101e7@google.com>
Subject: [syzbot] [audit?] BUG: unable to handle kernel NULL pointer
 dereference in kauditd_hold_skb
From: syzbot <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c901b8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=758bb5b8f724c7ba
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffdaad8822cadf6ff4e
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ed19b8980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-6d7ddd80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c2b52b97a0d/vmlinux-6d7ddd80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73131a832637/zImage-6d7ddd80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com

audit: type=1400 audit(66.700:100): avc:  denied  { ioctl } for  pid=3015 comm="syz-executor.1" path="/dev/loop1" dev="devtmpfs" ino=636 ioctlcmd=0x4c01 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t tclass=blk_file permissive=1
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 30 Comm: kauditd Not tainted 6.9.0-rc7-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at printk_get_level include/linux/printk.h:21 [inline]
PC is at printk_parse_prefix+0xc/0x90 kernel/printk/printk.c:2137
LR is at printk_sprint+0x10c/0x164 kernel/printk/printk.c:2177
pc : [<802bc524>]    lr : [<802bc6b4>]    psr: 60000093
sp : df8d9d70  ip : df8d9d80  fp : df8d9d7c
r10: 8262a180  r9 : 00000000  r8 : 00000000
r7 : df8d9dc8  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : df8d9ebc  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84b70e80  DAC: fffffffd
Register r0 information: NULL pointer
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: 2-page vmalloc region starting at 0xdf8d8000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
Register r4 information: NULL pointer
Register r5 information: NULL pointer
Register r6 information: NULL pointer
Register r7 information: 2-page vmalloc region starting at 0xdf8d8000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
Register r8 information: NULL pointer
Register r9 information: NULL pointer
Register r10 information: non-slab/vmalloc memory
Register r11 information: 2-page vmalloc region starting at 0xdf8d8000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
Register r12 information: 2-page vmalloc region starting at 0xdf8d8000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2797
Process kauditd (pid: 30, stack limit = 0xdf8d8000)
Stack: (0xdf8d9d70 to 0xdf8da000)
9d60:                                     df8d9d9c df8d9d80 802bc6b4 802bc524
9d80: 00000000 00000000 dddc5595 00000000 df8d9e24 df8d9da0 802bc918 802bc5b4
9da0: 81fce794 df8d9ebc 8029d704 0000000f ac9b579a df8d9dc0 0000001e 81fce794
9dc0: 60000013 00000005 00000000 df8d9ebc 8263bdf8 00000000 00000000 8262a22c
9de0: 60000093 3fffe339 00000000 75613501 00746964 3d7ed298 df8d9e44 00000000
9e00: ffffffff 82622ec4 00000000 00000000 00000000 81fce794 df8d9e64 df8d9e28
9e20: 802bda40 802bc718 df8d9ebc 3d7ed298 df8d9e7c 82ee8000 df8d9e6c 82ee8000
9e40: 85080000 00000000 8033fd34 8462d6c0 00000000 00000000 df8d9e7c df8d9e68
9e60: 802bdbdc 802bd948 df8d9ebc df8d9e78 df8d9e9c df8d9e80 802bec18 802bdbc0
9e80: 81893374 818cdd00 8462d6c0 ffffff91 df8d9eb4 df8d9ea0 818a62e0 802bebb0
9ea0: df8d9ebc 3d7ed298 df8d9ee4 df8d9ec8 803404e4 818a62bc 81fce794 00000579
9ec0: 85080010 00000000 826fb6ec 8462d6c0 00000000 8033fd34 df8d9f24 df8d9ee8
9ee0: 8033ff54 80340414 df8d9f04 00000001 00000000 8289fa50 df8d9f24 826fb6ec
9f00: 8289f9f8 00000000 00000000 82e98300 00000000 00000000 df8d9f84 df8d9f28
9f20: 8034080c 8033fe64 8033fd34 80340408 8027cd5c 80340408 8033fcdc 8033fd34
9f40: 00000000 82ee8000 802a5074 df8d9f4c df8d9f4c 3d7ed298 df8d9f84 82f26480
9f60: 82ee8000 8034058c 00000000 82e98300 df819e50 00000000 df8d9fac df8d9f88
9f80: 802702a0 80340598 82f26480 8027019c 00000000 00000000 00000000 00000000
9fa0: 00000000 df8d9fb0 80200104 802701a8 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace: 
[<802bc518>] (printk_parse_prefix) from [<802bc6b4>] (printk_sprint+0x10c/0x164 kernel/printk/printk.c:2177)
[<802bc5a8>] (printk_sprint) from [<802bc918>] (vprintk_store+0x20c/0x450 kernel/printk/printk.c:2279)
 r7:00000000 r6:dddc5595 r5:00000000 r4:00000000
[<802bc70c>] (vprintk_store) from [<802bda40>] (vprintk_emit+0x104/0x278 kernel/printk/printk.c:2329)
 r10:81fce794 r9:00000000 r8:00000000 r7:00000000 r6:82622ec4 r5:ffffffff
 r4:00000000
[<802bd93c>] (vprintk_emit) from [<802bdbdc>] (vprintk_default+0x28/0x30 kernel/printk/printk.c:2363)
 r10:00000000 r9:00000000 r8:8462d6c0 r7:8033fd34 r6:00000000 r5:85080000
 r4:82ee8000
[<802bdbb4>] (vprintk_default) from [<802bec18>] (vprintk+0x74/0x94 kernel/printk/printk_safe.c:45)
[<802beba4>] (vprintk) from [<818a62e0>] (_printk+0x34/0x58 kernel/printk/printk.c:2373)
 r6:ffffff91 r4:8462d6c0
[<818a62ac>] (_printk) from [<803404e4>] (kauditd_printk_skb kernel/audit.c:546 [inline])
[<818a62ac>] (_printk) from [<803404e4>] (kauditd_hold_skb+0xdc/0xf8 kernel/audit.c:581)
 r3:00000000 r2:85080010 r1:00000579 r0:81fce794
[<80340408>] (kauditd_hold_skb) from [<8033ff54>] (kauditd_send_queue+0xfc/0x16c kernel/audit.c:766)
 r7:8033fd34 r6:00000000 r5:8462d6c0 r4:826fb6ec
[<8033fe58>] (kauditd_send_queue) from [<8034080c>] (kauditd_thread+0x280/0x2d8 kernel/audit.c:890)
 r10:00000000 r9:00000000 r8:82e98300 r7:00000000 r6:00000000 r5:8289f9f8
 r4:826fb6ec
[<8034058c>] (kauditd_thread) from [<802702a0>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df819e50 r8:82e98300 r7:00000000 r6:8034058c r5:82ee8000
 r4:82f26480
[<8027019c>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf8d9fb0 to 0xdf8d9ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8027019c r4:82f26480
Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5d03000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e89da800 	ldm	sp, {fp, sp, pc}
   4:	e1a0c00d 	mov	ip, sp
   8:	e92dd800 	push	{fp, ip, lr, pc}
   c:	e24cb004 	sub	fp, ip, #4
* 10:	e5d03000 	ldrb	r3, [r0] <-- trapping instruction


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
