Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C54A3F3F
	for <audit@vger.kernel.org>; Tue, 22 Sep 2026 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105104; cv=none; b=ApCaynxkUtOXoZ1RSuHxEIK9oSfehVjjB/dxdbnWffdXgm14mnT/oa1wLrCcbjQXZAsuxSasIs/FAX1zU/zp9E8EBuUc7ikRi+f4F7+oAYem9mq7eJFQCAjP69s40iCY0URxC8iag4b5O55m4Ajt+wzYhtazgq8cqTzS/wPce7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105104; c=relaxed/simple;
	bh=5zqxZ2fMrgeFI0IviH9NhO2Po/9ZuxvL1LWrp6wrFng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sTQoh/AgtT84eV0KBk5aMhN7qz4G3QbUPfm3GXZk2mRgDD/SmGbwTzG36szJLD5cC4aTofLd0dEkOC4OwCKLHZi32jhlI+R9Z3GTR0aM8n+CdYrgPul7p3heGLyU5zggfIzzpfg03BU5bPiUNNHsMOdRJi4ROgQIRFo06nWDn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+UTiPJf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+UTiPJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3tG3UXSO9esh9XEohfwLr6jDVetgvbetn2t8cbip0E=;
	b=L+UTiPJfuk+JzLvTqqArJdKWhVY8NZVCig57YqDUPkymp34Jxh1tLl8vRi2Pq0R/WhAEaS
	iZloAY6j6ZSyc3ZnCtRG0b3BYltjbYFi2Zcflt7aAggMmRqKI1i4gvzoSg8trQsODMhSVq
	kuvx0KpUqiL4zAhRkwVeodnVvA+SRxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-G3QXsmNyPDu_3hqtRLUBaw-1; Tue,
 22 Sep 2026 15:24:56 -0400
X-MC-Unique: G3QXsmNyPDu_3hqtRLUBaw-1
X-Mimecast-MFC-AGG-ID: G3QXsmNyPDu_3hqtRLUBaw_1790105092
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B137A18007FD;
	Tue, 22 Sep 2026 19:24:51 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFA8A3000223;
	Tue, 22 Sep 2026 19:24:35 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3 12/14] um: pass pt_regs to audit_syscall_entry()
Date: Tue, 22 Sep 2026 16:20:04 -0300
Message-ID: <c84739d9254fd1398840d907e525eaac648b6e17.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: S7rOEGro9cGCOhLhDXv7oAi_ODVuzsv2SE2gWsV39ow_1790105092
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/um/kernel/ptrace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 7da0a5223aa6..17c285e49ddc 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -123,11 +123,7 @@ static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
  */
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	audit_syscall_entry(UPT_SYSCALL_NR(&regs->regs),
-			    UPT_SYSCALL_ARG1(&regs->regs),
-			    UPT_SYSCALL_ARG2(&regs->regs),
-			    UPT_SYSCALL_ARG3(&regs->regs),
-			    UPT_SYSCALL_ARG4(&regs->regs));
+	audit_syscall_entry_regs(UPT_SYSCALL_NR(&regs->regs), regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
-- 
2.55.0

