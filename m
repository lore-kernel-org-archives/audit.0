Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD740DFBD
	for <audit@vger.kernel.org>; Sun, 19 Apr 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614021; cv=none; b=Tz9vXAD5a2nijo0trEtP0gBFE/Uk82qpoyyhnhj+eqROnOrS9dY2cByFkT7aVwJkYEYv/7hpmXUHb592EY+VNW3LEsBiEZb8e0DQvMCMdFpDR6vtZF2oGRHAwTfLKLvgDecmCWNWDmrQj0N6S2P7BdRvY3Qny0OHE4nPYz0k0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614021; c=relaxed/simple;
	bh=PpDxvXzMiMj4RdNwO7Mop/PlYBi5KToFnHcF1g3Jbk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=Fr7QLsdx4AfoeeuU1rEfIwmafQ6afD1F0Lo7XHn6cUPjq0WVa6KU6g+3FGB4uD5Ij/wmlz3MzaBQ1IUztr5E922Cy6IkVIp7wRrufjkbnVTKA46lXMu2BItpQrsVwJInujZCuxgoVzauV/9mWmcIZSEsH+VXaelH6Ldh4ifkhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6pAHDqx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6pAHDqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776614018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Lv8wO+GYLduAU1dY5LiTNLqX0a381WHRoSIaxoulE8A=;
	b=V6pAHDqxaddXl1tHSoRSSp6lc2BGNa0KqizPWHfPLjRcJgR4E3Itocdysd6BF1f25aUbZz
	lChaAg5w3ICkOrAd+kCOrXOLwqTZfF2C/2zXC4QjMvKo3rNGza4Q+7uyfTxASDakMt4LWP
	N7vxgbqH6A+e+zOwU3BYfjnnqEA8slA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-1k-V8zgZNSSDlsqf-Kx8eQ-1; Sun,
 19 Apr 2026 11:53:33 -0400
X-MC-Unique: 1k-V8zgZNSSDlsqf-Kx8eQ-1
X-Mimecast-MFC-AGG-ID: 1k-V8zgZNSSDlsqf-Kx8eQ_1776614011
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D7A018004A9;
	Sun, 19 Apr 2026 15:53:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.56])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 28A4C3000C20;
	Sun, 19 Apr 2026 15:53:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 19 Apr 2026 17:53:30 +0200 (CEST)
Date: Sun, 19 Apr 2026 17:53:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Drewry <wad@chromium.org>
Cc: Eric Paris <eparis@redhat.com>, Kusaram Devineni <kusaram@devineni.in>,
	Max Ver <dudududumaxver@gmail.com>,
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] seccomp: drop syscall exit events for rejected
 syscalls
Message-ID: <aeT6dasGDZYPMQ_h@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aeT6T7ZJ45yAtdZs@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sCS_aXGLSGSEJnaae9esutE9b7bFUejAz3gliM3dFOw_1776614011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

seccomp_nack_syscall() calls syscall_rollback(), which means that the
syscall exit path sees the original syscall number as the return value.

This confuses audit_syscall_exit(), trace_syscall_exit(), and ptrace,
causing them to report completely bogus syscall exit events.

Add a new SYSCALL_WORK_SECCOMP_EXIT flag set by seccomp_nack_syscall(),
and change syscall_exit_work() to return early if this flag is set. After
all, this syscall was never actually executed.

Note that syscall_exit_work() has to clear SYSCALL_WORK_SECCOMP_EXIT for
the !force_coredump case, and that is why we actually need the new flag:
seccomp_nack_syscall() can't just clear SYSCALL_AUDIT/TRACEPOINT/TRACE.

Reported-by: Max Ver <dudududumaxver@gmail.com>
Closes: https://lore.kernel.org/all/CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/entry-common.h | 9 ++++++++-
 include/linux/thread_info.h  | 2 ++
 kernel/seccomp.c             | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 535da46c3ee9..403802eed387 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -34,7 +34,8 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
-				 SYSCALL_WORK_SYSCALL_EXIT_TRAP)
+				 SYSCALL_WORK_SYSCALL_EXIT_TRAP |	\
+				 SYSCALL_WORK_SECCOMP_EXIT)
 
 /**
  * arch_ptrace_report_syscall_entry - Architecture specific ptrace_report_syscall_entry() wrapper
@@ -235,6 +236,12 @@ static __always_inline void syscall_exit_work(struct pt_regs *regs, unsigned lon
 		}
 	}
 
+	if (work & SYSCALL_WORK_SECCOMP_EXIT) {
+		/* Rejected by seccomp, no valid syscall exit state */
+		clear_syscall_work(SECCOMP_EXIT);
+		return;
+	}
+
 	audit_syscall_exit(regs);
 
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 051e42902690..167c850ae16e 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -40,6 +40,7 @@ enum {
 #ifdef CONFIG_GENERIC_ENTRY
 enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
+	SYSCALL_WORK_BIT_SECCOMP_EXIT,
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
@@ -50,6 +51,7 @@ enum syscall_work_bit {
 };
 
 #define SYSCALL_WORK_SECCOMP			BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SECCOMP_EXIT		BIT(SYSCALL_WORK_BIT_SECCOMP_EXIT)
 #define SYSCALL_WORK_SYSCALL_TRACEPOINT		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
 #define SYSCALL_WORK_SYSCALL_TRACE		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 #define SYSCALL_WORK_SYSCALL_EMU		BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index cb8dd78791cd..35703dceb6d2 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1262,6 +1262,10 @@ static void seccomp_nack_syscall(int this_syscall, int data, bool force_coredump
 	syscall_rollback(current, current_pt_regs());
 	/* Let the filter pass back 16 bits of data. */
 	force_sig_seccomp(this_syscall, data, force_coredump);
+#ifdef CONFIG_GENERIC_ENTRY
+	/* No valid syscall exit state after syscall_rollback() */
+	set_syscall_work(SECCOMP_EXIT);
+#endif
 }
 
 static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
-- 
2.52.0

