Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199104;
	b=g+Omg3OXcUFIzOvIwL+umaAxRN+3ggbuumNC1nOEzU1jp1gca/T4TfkKnDZ8O6rkjKTh
	 uSjUuFq525LWowfod+0NjjH24Nh9JKNc+ujlkaFmByKuqW83K8hktmQ9ZQVmd/mpM4XwO
	 mGDI4wrYGLdTGcrO/qRjIZwDJnTOdQeDgjO48EJ/viYhtyBjgX6QV9xAWrBTkISkprRS6
	 YrBegfWF5jYfT6MukuiqR5gI7GpbceBmjJf7p6IOL+7WKZ07mLMSZ0+yJbor2NOm16+2z
	 b8WQMmLn359O0ue+/jtiF2Mp9b+xdOyZ5jJ4lfINnG2SN15lGEvxig7joHwdxRJP26g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199104;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l/IGrW0wLRlk6MmB8QGln1kVgPwVq4hC+UHlUVA2ADI=;
	b=OjqRyQOWdwi1NUzt0o3l4Hg0+6CTLLJDgn2MLnI51A5sXhtEHYgyzhVHN1Nn9K1OQ+FR
	 MO1iNLX/xZ0dvxDtaT85oTVgVuiYn9qIFx4TYaHc26U6F9qVABxuf2DANVzZsDGSZdK6w
	 S8huNNl798hbNqD0LoCZo0oVhbcqJQ9f4t8eJ6j+R17XPsz/mBhp12GsKts8UqncW8LlB
	 5sDI+wcPzchmGauA5K4vAShUM6frhOiMqi8aluWCdC5zmBG1TRltXebHAJHityTrxCMRx
	 BXEXktUU7q/Y13htnomn7Ormff0XCLePt5w8qi1mWyBJS+9aH3UvXkjCe1Wn4k7LojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YmfULGrA;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC22606A334;
	Fri, 20 Nov 2026 18:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC22606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YmfULGrA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795199097; bh=l/IGrW0wLRlk6MmB8QGln1kVgPwVq4hC+UHlUVA2ADI=;
	h=From:To:Cc:Subject:Date;
	b=YmfULGrAURlheje/boJCBc9dGugN/c/LNg2OXmxCzhHdfKOrX/Zgcrqdj0gqaEDRK
	 OiJsJQWWT2SszI7Xv2QzZnsmRw3rHp96c3WgQMZnj3dD+RQlOnHP/z/79/zB/ZyyQE
	 BT+JB2xWwXGFwaEAlLyau9snLfWhzRWSsY2zb6CE=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 637840EB; Sat, 21 Nov 2026 02:24:55 +0800
X-QQ-mid: xmsmtpt1795199095tyb88pdse
Message-ID: <tencent_1E23FD4E29A6F151723EDD513FA9BEDF1408@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5sZjGuWKUWut+H/bzlI/2FmXFlAN5it5o4v48m0+5E7fKv43frO
	 j2+Uoxiyie1389di/qWz2NzvDzw7Kedv0tqnD+23cYw25lyDW5Sol3ltZadoWbgmfhqMS5t04FiO
	 YpdriWS3bMz+3qMVDfBNSgmQ3QvOPuR0VTZcpSdlFwKfq3kTUjn/AiC/n+/Gw8iRhfzUjIyp0GU7
	 OFhrovmjZcAaxOIktR9b4A7yWD7EnoOLR1pBdvLg9gPBA8XQKXbW03UfojKDT5b65XfDRpB1W9Kt
	 V8XUTJwohkCkjDAx/Vj5hNy3UJWJIOpqftn+cGW0qW+JHYZDNe/YzkGDPw50h0B7GgpUHtrwacKe
	 HB11Pq7LnslN9c3Dm9Rfw7qN2R8pcNdC3EFEzysbGC+exVi1MFTiuDMBs2WsY1UYEXHvTHTM2YqW
	 gEIIO+luQ/QL/Hd0biCowD9OAKtZ8PydropZ0loBW5sibSBEUauNAsntILV+8cg5x5lbEC40odUE
	 PqJKVl+ZY9iPQcnmjR91iak3SPIrTqX9tL2c/VrtITC5k8KctH2AJKpgDHNe9SlNlJNs5HjrnjIO
	 77pm8QEpPXBiYDfY9Sijg4j6dP+KNfkwOudLRBWxKQzhvoz16FsvAHY+82yeQBLLyvqgohCbNEdk
	 n+t6Lny+3CuiXvUcddEKRDxYjjatkmJRivDyu76Rt8djydrkKlLUJ5hsDHV1TTN6Cz2+Eia4IP9T
	 qXEJ0PS0yNNMqkGWcjanD7k5uH8lKmaGLmoeyplUswO8vq5p+GQI/Nt49EEflqZHAiOVPf4hTXn5
	 Gc6OKCRcG1/MvgVGhbcS5eBHdGm1dNAd1T+7C+CnOJWDwr0cM6L32K5bLx9b0yLy3RNUyLpPM6j1
	 +VNjTYWmJj6enrdzay3/Ks3LyyhapSLFGOFfkipodoSs/N2oXdsyd7SfaeBc4JT45PvzyZuZwcO1
	 5DkYOZ+VIIv8/2mwNOwqCi7voOkNzcrO0mk5o0clNsQs2RAgpOzAqqvdQ4DjtBUOsAfvs3hXtgYR
	 B7xIiDpWwVU7VAAJqocktjsOgHXdTwTJnIGgi5ZFl3PAGoBzpE
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guikun Yang <yangguikun19@qq.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Bug report] audit: fsnotify autoremove handler reads a freed
 audit_entry when the rule is deleted while the handler is blocked in
 audit_log_start()
Date: Thu, 19 Nov 2026 10:00:00 +0800
X-OQ-MSGID: <audit-fsnotify-mark-rule-uaf-20261119@qq.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Paul, Eric,

An fsnotify watch rule (-w) keeps a raw back-pointer from its mark to
the owning audit_krule (audit_mark->rule, kernel/audit_fsnotify.c:108).
When the watched directory is renamed or removed, the autoremove path
runs in the fsnotify event handler, and a concurrent AUDIT_DEL_RULE can
free the rule while that handler is still inside the SRCU read section
of fsnotify event delivery. The handler then reads the freed
audit_entry.

  BUG: KASAN: slab-use-after-free in audit_mark_handle_event+0x42b/0x450
  Read of size 8 at addr ffff888007225138 by task init/104
   audit_log_key+.. <- audit_mark_log_rule_change <- audit_mark_handle_event
   fsnotify <- fsnotify_move <- vfs_rename
   ...
  Allocated by task 1:
   audit_data_to_entry (kmalloc-512, offset 312 = audit_entry)
  Freed by task 95:
   kfree <- rcu_core <- call_rcu <- audit_del_rule+0x44d

## The mismatch

The deletion side waits with plain RCU:

  kernel/auditfilter.c, audit_del_rule():
        list_del_rcu(&e->list);
        synchronize_rcu();               /* plain RCU */
        ...
        call_rcu(&e->rcu, audit_free_rule_rcu);

but the consuming side runs under fsnotify_mark_srcu (fs/notify/mark.c):
fsnotify_handle_event() takes srcu_read_lock(&fsnotify_mark_srcu) and
calls the group's handle_inode_event under it, so a handler that blocks
(e.g. in audit_log_start() with a full backlog) is an SRCU reader that a
plain RCU grace period does not wait for. When the handler finally gets
an audit_buffer and reaches audit_mark_log_rule_change(), it dereferences
the already-freed rule:

  kernel/audit_fsnotify.c:129        struct audit_krule *rule = audit_mark->rule;
  kernel/audit_fsnotify.c:139        audit_log_key(ab, rule->filterkey);

The second return path has the same problem: when the backlog wait times
out, audit_log_start() returns NULL and the handler falls through to
audit_autoremove_mark_rule() -> audit_del_rule(entry), which itself
reads the freed entry through the same back-pointer.

## Reproducer timing

The window needs the handler to block inside audit_log_start() long
enough for a concurrent DEL_RULE to complete a full plain RCU grace
period, which requires an audit backlog. The reproducer orchestrates:

  - one -F exe= rule installed via AUDIT_ADD_RULE (CAP_AUDIT_CONTROL),
    backlog_limit=2, backlog_wait_time=8s;
  - a fake auditd child that registers (AUDIT_SET PID) and then never
    reads its netlink socket, so kauditd blocks in netlink_attachskb on
    the full rcvbuf and the backlog stays over the limit;
  - 8 private-socket AUDIT_USER senders that push qlen to 8 within
    milliseconds, so non-auditd tasks sleep 8s in audit_log_start();
  - thread B: rename() of the watched directory -> FS_MOVE_SELF ->
    the autoremove handler enters and blocks in audit_log_start();
  - a deleter child: chroot() into a mirror tree so the rule's exe path
    string still compares equal (the EXE field match is a plain strcmp
    of path strings) but nothing touches the renamed directory, then
    AUDIT_DEL_RULE; list_del -> synchronize_rcu -> mark removal ->
    call_rcu -> kfree of the audit_entry about 0.3s later;
  - B wakes ~8s later and reads rule->filterkey -> KASAN report.

One run out of three hit the report on the queue-drained path; the
remaining two verified the deleter's DEL_RULE returned 0 and the entry
was freed while B was still blocked (serial console shows B inside
audit_log_start at that point). Not reachable by plain syscall fuzzing:
it needs CAP_AUDIT_CONTROL rule management plus a multi-thread timing
window that fuzzers do not model.

The window also exists on the DEL_RULE-same-rule path without any
rename event, whenever a watch rule is deleted while an event handler
for it is blocked in the same way.

## Versions

Reproduced on 7.3.0 (KASAN inline, GPF/KASAN build, QEMU). The
back-pointer and the plain-RCU wait are unchanged in current mainline
(kernel/audit_fsnotify.c:108/129/139, kernel/auditfilter.c:1053).
syzbot has no report for this path; the audit entries in its dashboard
are all on the data plane (audit_log_*/kauditd), none on rule
lifecycle. No CVE or list thread found for this mechanism.

## Possible fix direction

The deletion side already knows the rule carries a watch mark
(e->rule.exe). For such rules, the free must not proceed on plain RCU
alone: waiting for fsnotify_mark_srcu readers before call_rcu (or
routing the free through a work that first does
synchronize_srcu(&fsnotify_mark_srcu)) would close the window, in the
same spirit as the exe-rule lifetime work in 888a0396e1 ("audit: fix
removal of dangling executable rules").

The reproducer (self-contained C, PID1 in a VM, netlink rule setup,
flood/B/deleter threads) is available on request.

Thanks,
Guikun Yang

