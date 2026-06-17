Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDC35292A;
	Wed, 17 Jun 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698542; cv=none; b=FGEoQ30VZagNp1FQ8GAu6/vFR4nhx/5bx83bZpS6AidbL8jtUAstmVnpwyZGqHkd9HZfZk6aekgsKxcCX4Ih4608A6SYZQDoY8JNa38ezhUnrd4K0g2mS2y+07WCTybn9TjItbi0SRw07pSokQKYdIZomJbcKBZ0OcBs1urPvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698542; c=relaxed/simple;
	bh=Tf1/khh9z6R5y9h4eJ+zydpnoUQBDprt0v7g3rqhKeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PF6sqBLzvZudxxJYCPiFQCzmiyd24g40KqE+TogcyHQOAk77Nm5WStMZdN/pkATr5ce6jiA7oCUD9GvleDh+iCudtYF4XMjLx313iRRshegbVGlxOXAXMluY4oGFDX2iM22r7q+/+LCHOcnLqNRYxPV1SxPt0xvtVLElBiyojB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J2hWAVju; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J2hWAVju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=C9VMHOa2VCdcD/z/LqDiyi6lIyMM2P9QHS3VdbmZDjs=;
	b=J2hWAVjuh7hDhIPS82GaMfAtiJPClcp/TElBbIdEb5mM7CSb4H69kdAclzvd2Z
	TJI7p9X9y9Dv7Jk289WBG12iBinS3HjQDbykV8eejBYzLBDsfly3wOw3sz+mt8+3
	1lZNgVEE4fCgRsWlbLM+a7pb5PDMCqnlQ9UhwycoLlMFU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHD_7WjzJqUv2fCw--.63726S2;
	Wed, 17 Jun 2026 20:15:18 +0800 (CST)
From: Chi Wang <wangchi@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangchi <wangchi@kylinos.cn>
Subject: [PATCH] audit: Fix data race in audit_log_start()
Date: Wed, 17 Jun 2026 20:15:16 +0800
Message-Id: <20260617121516.4023092-1-wangchi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHD_7WjzJqUv2fCw--.63726S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxtFyDuw4rtFy3tryDtrb_yoW5Gw1fpr
	yDWFWIyrs5ZFyUX3W8A3WUZrW5ta15KF13Grn3tr1ayr98GF1UWr18Ja1aqryUCrs8A3W7
	JF98tayqvr4DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
Sender: wangchi05@163.com
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC4RZAY2oyj9bvLwAA3V

From: wangchi <wangchi@kylinos.cn>

audit_log_start() reads audit_queue.qlen via skb_queue_len() without
holding the queue lock or using READ_ONCE(), while kauditd writes to
this field via the skb_dequeue() → __skb_unlink() path with WRITE_ONCE()
protected by a spinlock. This constitutes a data race.

KCSAN reports the following conflicting access pattern:
==================================================================
BUG: KCSAN: data-race in audit_log_start / skb_dequeue

write (marked) to 0xffffffff8512ee20 of 4 bytes by task 661 on cpu 57:
 skb_dequeue+0x70/0xf0
 kauditd_send_queue+0x71/0x220
 kauditd_thread+0x1cb/0x430
 kthread+0x1c2/0x210
 ret_from_fork+0x162/0x1a0
 ret_from_fork_asm+0x1a/0x30

read to 0xffffffff8512ee20 of 4 bytes by task 36586 on cpu 1:
 audit_log_start+0x2a0/0x6b0
 audit_core_dumps+0x64/0xa0
 do_coredump+0x14b/0x1260
 get_signal+0xeb2/0xf70
 arch_do_signal_or_restart+0x41/0x170
 exit_to_user_mode_loop+0xa2/0x1c0
 do_syscall_64+0x1a3/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0xe0

value changed: 0x00000001 -> 0x00000000
==================================================================

Resolve the race by switching to lockless helper skb_queue_len_lockless(),
which internally uses READ_ONCE() and properly pairs with the WRITE_ONCE()
write accesses already present on the writer side.

Fixes: 3197542482df ("audit: rework audit_log_start()")
Change-Id: I766cc99f6a567b898a08e1d68cd13bae5699e5b2
Signed-off-by: wangchi <wangchi@kylinos.cn>
---
 kernel/audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 34dc7cb246ff..e4c095017302 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1933,7 +1933,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		long stime = audit_backlog_wait_time;

 		while (audit_backlog_limit &&
-		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+			(skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);

@@ -1953,7 +1953,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 			} else {
 				if (audit_rate_check() && printk_ratelimit())
 					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
-						skb_queue_len(&audit_queue),
+						skb_queue_len_lockless(&audit_queue),
 						audit_backlog_limit);
 				audit_log_lost("backlog limit exceeded");
 				return NULL;
--
2.25.1

