Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD312BDC13
	for <audit@vger.kernel.org>; Thu, 27 Aug 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793752; cv=pass; b=kPxCa8tQuHl8sq78cc1kSC20y2aDClf5ImoiL2PLjMXqJ/okbLEdfM9+P3sNtIJ3uab7Ey8F0j5Atv3oGIXakE5Cw6mU+ah3Lm+ELgEn/WsZft+RSFuN2d2i1I6iQGJIoWKHcVRIidiA/4IhCRT3stdJJC9wxBGRT4epA5lmNRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793752; c=relaxed/simple;
	bh=6my6Rbe9hoRTmVEb8pjTS/ygGkOLLImmDRVshZSy60c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgzOqbWJpup0fkHdbVbXX8f7szJgrNuQMlxH1r2T+1pyvCEiMKBf6HKx9BiU0e2PVcuKtXZpgDbpNDSK2/w7OfjENOs4VVKNZcetl8OChakdpIA18qlJlf+6uso0tOs84SOCiyeytngKHmhN0jGLv0vlrsjyBNA3Inl6iJ3TeEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RzXmsVdq; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RzXmsVdq"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2063488a91.3
        for <audit@vger.kernel.org>; Wed, 26 Aug 2026 18:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787793750; cv=none;
        d=google.com; s=arc-20260327;
        b=DOQfZ7/ELRM04ttvQlv4DcHHPYpNErEAO5cDUm28sPUB8ACP8GkbhlEby9FRISJyXr
         59Rfe8j4U1WXtw+yd3c3hub8f8VomJzhGfWcbddZiU6HNWeJkHtQTnfxLtiABMRjDNDa
         5Tsm1DG8fG468N/elx+igzNP414d2X3o2Lc9z7U37V7Dc8TxQZYBDj39nXv88zWS40yJ
         fnbKFEJ+mnBs6A8+I1LVU3u2DMgBqMjgYqRj+JPYeddtd8KHRRnlINCLZcPdADwWiH0o
         SyRs2tGhLwBsebtBw8A1WyAr7Sz56T9eo2LK/kiDB75DpdObQ0+1Cx07wNmL5PUkhroq
         b1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/kxjHtQoTs9r1PEGWctB7z+AQyNDSJTM7xtEIDj4Z/g=;
        fh=Tk8BsBDkKx7iJNCyXYrbpunm5LqRyZ3RaUKlUJyHuI0=;
        b=f12Z8vylw71/UzdVwyLlaytzE05qOMDRl3w4Gv8HD+QimFRuQWLHxtaUE6pa108eEu
         OZ/Im7z//vMiedSGsY8uGO/ZBmyFvUetrS4MtbrAXLH8F8ZwPm2CsytirX7jorx/HMVG
         QtF8kfn/gv1EuSJg8UwEnYdO2DKVehZxxR0vdK7/ha+yt6M4MF6hWl65LTylzS8c8o4K
         Vs7el4YB4NtqxeFPu2zPUw5rNacWwWnIaDK1MlV6ik4Ky5/Ad2ZvERxrflIHp7kOBAre
         X9xstU+J6ssdphoHoeVUNPYE5B7/QWkQZ0CQoaa7OvkSz1B1LomfGP2fj5F2cg8946Nd
         gWgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787793750; x=1788398550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/kxjHtQoTs9r1PEGWctB7z+AQyNDSJTM7xtEIDj4Z/g=;
        b=RzXmsVdqDOA3dEpwWKHFEtfHneM3h8QPDb9+cG+t+dljf3yO5IJof97mAsm3IkjnCN
         tiVTTFuxjWdpT0PJ6IkL766uMRYfYCienYO78gKVvEttnn8XW/0b+vuYkdjO9icePMER
         NaaRoC6sQFY2/dKt3IEeQa+84bPuFyeLTwBWLYSamBO6f27YtKIt/mtOd5a3yrnPlHI2
         25V86TXZvZYn9LJeug87NLfJiC7mCt+Zjmn8a8lQBqntMp3/OoYLveU1XZFSm7ihvv8o
         /DAE4Q9E1uMVdWtFe+2et9h8WIVDgBqDnEw6RpVpjD6gHEs2B0JhCESE3vEZs7fTcxYl
         nRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793750; x=1788398550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/kxjHtQoTs9r1PEGWctB7z+AQyNDSJTM7xtEIDj4Z/g=;
        b=j1BZTn/MEORwAdboC18jBSIUeHGDsTxWNaguLpd94erErGrnBMdNKHzS6cM5jZ6H1L
         cJ14ReTVdlLfjkrNEJye4m6coUkfpo7PwIKfzzY9MPE3tTUL/jLKXe1UKY5lbxayW71k
         kDX7LQ8Nu1tWKo28CcYdgu5z9SdWTOGzKuNt68cCjkoXr9FZsyjG9vO7X4YHddEo14m4
         K5IbBdHbcZJpkgTL2nx5CbiL3n/oQnOh5GqU4m7NyKbdR1CgLv3vV3PREIYzC721OPJ3
         lyM0HsxBOPIQvVdmf4fWNvJ4EAPuU/3Nb1R12GPKPLsuOlfsp8n408O4vrn5CdO7S/ZV
         ezsQ==
X-Forwarded-Encrypted: i=1; AHgh+RolIex4uHXK4tRsDjJ7/XLF0v0vmbCbckbyvqV7HPpixgOyE57cyZxMx+blegYYUzydKzEGmg==@vger.kernel.org
X-Gm-Message-State: AFuF++lYFM3KUYTKkSux8far8G/om2cHydr1Olf0K2P5O3g3WmyjM5e6
	IqJVA6dYUZt8WhKDgy26kwfwiWokmAnYXXFpsY//PV/wMXqJ31nclcnR5cbdiPch8/JdRom3+tD
	FQy7iBQYS7z15GlcMaY9JLrlHR13i0S8ymDMIqW5U
X-Gm-Gg: AR+sD139nsYbCA6SSZVCukBb+62NrajyYsdWyUsN0Ac4yY0tQYCL2zGeyvpXsGfxXZT
	ic5mhdIzM5NUXQEM8OTNeNJqYQXASGhvHvDU3z3tx9AX+tWvKfeNd0NWer0e2199hZdLmU61tkR
	ly6oneLE5esSg/E6g5ik5kJOct/+qK7f8xrUIr380cldpw56Et5kB97kzsCWXcLDhOx/wRKZeP1
	5ob+HlIlKZyb21/snW6ZEmWnaj7xSHB64XZ3QrKjhh2GX4uZr8Zk52Yr+pCclV/+BR8Y43aeSXH
	xDZu0zjZOR7Vb9QxzAs9MyM8b0b7oBBopn6ubQ8NU7Sg
X-Received: by 2002:a17:90b:388e:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-3966d364af9mr22642101a91.2.1787793749572; Wed, 26 Aug 2026
 18:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com> <7F4D890F-C006-4855-888A-62ED786A32ED@mainlining.org>
In-Reply-To: <7F4D890F-C006-4855-888A-62ED786A32ED@mainlining.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Aug 2026 21:22:17 -0400
X-Gm-Features: AcwNN1VT5whZXg1VeLLPP9smaLz8-zHRmxlwBY2ml9d33Av8g2PxBy3YiGmv6Og
Message-ID: <CAHC9VhRvoDkJ0Pn1WHgTAEJ5RwZTmD4vChFGgqATn90C-Aae+g@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel paging request in integrity_audit_message
To: Bradley Morgan <brads@mainlining.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:06=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
> On 27 August 2026 01:50:45 BST, syzbot
> <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com> wrote:
> >Hello,
> >
> >syzbot found the following issue on:
>
> #syz set subsystems security:
>
> Note:  here's my suggested fix, in security/ima_appraise.c
>
>  path =3D dentry_path(dentry, pathbuf, PATH_MAX);
>  +if (IS_ERR(path))
>   path =3D NULL;
>
> apparmor and tomoyo both IS_ERR check their dentry_path calls, ima
> is the only one that doesnt. NULL fname is already handled by the audit
> side

Thanks for taking a look Bradley.  Adding Mimi, Roberto, and the
linux-integrity list as the security/integrity/ima/ima_appraise.c file
is their domain.

> >HEAD commit:    66fb95a52111 Merge tag 'caps-pr-20260820' of
> >git://git.ker..
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=3D1560d5495800=
00
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db0978f5ed290=
5b98
> >dashboard link:
> >https://syzkaller.appspot.com/bug?extid=3D5ebeb3089ea6439c37be
> >compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for =
Debian) 2.44
> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16fb462558=
0000
> >
> >Downloadable assets:
> >disk image:
> >https://storage.googleapis.com/syzbot-assets/e7d9049723b0/disk-66fb95a5.=
raw.xz
> >vmlinux: https://storage.googleapis.com/syzbot-assets/a04d6efe59a0/vmlin=
ux-66fb95a5.xz
> >kernel image:
> >https://storage.googleapis.com/syzbot-assets/81e3f2b9c049/bzImage-66fb95=
a5.xz
> >
> >IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> >Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
> >
> >BUG: unable to handle page fault for address: ffffffffffffffdc
> >#PF: supervisor read access in kernel mode
> >#PF: error_code(0x0000) - not-present page
> >PGD eb97067 P4D eb97067 PUD eb99067 PMD 0
> >Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >CPU: 0 UID: 0 PID: 5818 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(=
full)
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >Google 07/16/2026
> >RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
> >Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 =
ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 7=
4 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
> >RSP: 0018:ffffc90003d77940 EFLAGS: 00010246
> >RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
> >RDX: 0000000000000004 RSI: ffffffff8207fb91 RDI: ffffffffffffffdc
> >RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000b7
> >R10: 00000000000006c0 R11: ffffffff8bc921d3 R12: ffff8880785a84c0
> >R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
> >FS:  000055555ec16500(0000) GS:ffff888123b86000(0000) knlGS:000000000000=
0000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: ffffffffffffffdc CR3: 0000000075fb6000 CR4: 00000000003526f0
> >Call Trace:
> > <TASK>
> > __fortify_strlen include/linux/fortify-string.h:218 [inline]
> > audit_log_untrustedstring+0x19/0x30 kernel/audit.c:2203
> > integrity_audit_message+0x366/0x4f0
> > security/integrity/integrity_audit.c:60
> > integrity_audit_msg+0x41/0x60 security/integrity/integrity_audit.c:32
> > validate_hash_algo security/integrity/ima/ima_appraise.c:752 [inline]
> > ima_inode_setxattr+0x512/0x5f0 security/integrity/ima/ima_appraise.c:77=
5
> > security_inode_setxattr+0x2d0/0x560 security/security.c:1940
> > __vfs_setxattr_locked+0xad/0x2b0 fs/xattr.c:309
> > vfs_setxattr+0x14a/0x390 fs/xattr.c:344
> > do_setxattr+0x145/0x180 fs/xattr.c:662
> > file_setxattr fs/xattr.c:672 [inline]
> > file_setxattr+0x139/0x1b0 fs/xattr.c:666
> > path_setxattrat+0x335/0x3b0 fs/xattr.c:732
> > __do_sys_fsetxattr fs/xattr.c:782 [inline]
> > __se_sys_fsetxattr fs/xattr.c:779 [inline]
> > __x64_sys_fsetxattr+0xc5/0x140 fs/xattr.c:779
> > do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> > do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >RIP: 0033:0x7f506239e0d9
> >Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> >RSP: 002b:00007fff3373f938 EFLAGS: 00000246 ORIG_RAX: 00000000000000be
> >RAX: ffffffffffffffda RBX: 00007f5062625fa0 RCX: 00007f506239e0d9
> >RDX: 0000200000000380 RSI: 0000200000000080 RDI: 0000000000000004
> >RBP: 00007f5062435024 R08: 0000000000000000 R09: 0000000000000000
> >R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
> >R13: 00007f5062625fac R14: 00007f5062625fa0 R15: 00007f5062625fa0
> > </TASK>
> >Modules linked in:
> >CR2: ffffffffffffffdc
> >---[ end trace 0000000000000000 ]---
> >RIP: 0010:strlen+0x30/0xa0 lib/string.c:402
> >Code: 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 =
ec 08 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 50 <80> 7d 00 00 7=
4 3d 48 bb 00 00 00 00 00 fc ff df 48 89 e8 48 83 c0
> >RSP: 0018:ffffc90003d77940 EFLAGS: 00010246
> >RAX: 0000000000000000 RBX: ffffffffffffffdc RCX: 0000000000000000
> >RDX: 0000000000000004 RSI: ffffffff8207fb91 RDI: ffffffffffffffdc
> >RBP: ffffffffffffffdc R08: 0000000000000004 R09: 00000000000000b7
> >R10: 00000000000006c0 R11: ffffffff8bc921d3 R12: ffff8880785a84c0
> >R13: 0000000000000007 R14: 00000000fffffff3 R15: ffffffffffffffdc
> >FS:  000055555ec16500(0000) GS:ffff888123b86000(0000) knlGS:000000000000=
0000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: ffffffffffffffdc CR3: 0000000075fb6000 CR4: 00000000003526f0
> >----------------
> >Code disassembly (best guess):
> >   0:  00 00                   add    %al,(%rax)
> >   2:  00 00                   add    %al,(%rax)
> >   4:  00 fc                   add    %bh,%ah
> >   6:  ff                      lcall  (bad)
> >   7:  df 55 48                fists  0x48(%rbp)
> >   a:  89 fa                   mov    %edi,%edx
> >   c:  48 89 fd                mov    %rdi,%rbp
> >   f:  53                      push   %rbx
> >  10:  48 c1 ea 03             shr    $0x3,%rdx
> >  14:  48 83 ec 08             sub    $0x8,%rsp
> >  18:  0f b6 04 02             movzbl (%rdx,%rax,1),%eax
> >  1c:  48 89 fa                mov    %rdi,%rdx
> >  1f:  83 e2 07                and    $0x7,%edx
> >  22:  38 d0                   cmp    %dl,%al
> >  24:  7f 04                   jg     0x2a
> >  26:  84 c0                   test   %al,%al
> >  28:  75 50                   jne    0x7a
> >* 2a:  80 7d 00 00             cmpb   $0x0,0x0(%rbp) <-- trapping instru=
ction
> >  2e:  74 3d                   je     0x6d
> >  30:  48 bb 00 00 00 00 00    movabs $0xdffffc0000000000,%rbx
> >  37:  fc ff df
> >  3a:  48 89 e8                mov    %rbp,%rax
> >  3d:  48                      rex.W
> >  3e:  83                      .byte 0x83
> >  3f:  c0                      .byte 0xc0
> >
> >
> >---
> >This report is generated by a bot. It may contain errors.
> >See https://goo.gl/tpsmEJ for more information about syzbot.
> >syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> >syzbot will keep track of this issue. See:
> >https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> >If the report is already addressed, let syzbot know by replying with:
> >#syz fix: exact-commit-title
> >
> >If you want syzbot to run the reproducer, reply with:
> >#syz test: git://repo/address.git branch-or-commit-hash
> >If you attach or paste a git patch, syzbot will apply it before testing.
> >
> >If you want to overwrite report's subsystems, reply with:
> >#syz set subsystems: new-subsystem
> >(See the list of subsystem names on the web dashboard)
> >
> >If the report is a duplicate of another one, reply with:
> >#syz dup: exact-subject-of-another-report
> >
> >If you want to undo deduplication, reply with:
> >#syz undup
> >
> >
>
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.ne=
t/



--=20
paul-moore.com
