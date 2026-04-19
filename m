Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459412CD8B
	for <audit@vger.kernel.org>; Sun, 19 Apr 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614013; cv=none; b=NX4MrS1zxO6dvz8d2waBi/pusIri/ZAx5aBYXQLCrqAqPTr9Lql4cweucukzqyCdl9zf3QgoJv1SLR9Q0slzt0R8ld5L8QMHnwSGwn0sKcAYtNZlhiq3lxzsTLgcY2U4mtXBPHJtwTswiJixmW95CXuwwxtmO72PXxQMliHsUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614013; c=relaxed/simple;
	bh=p8tf9brEw6sXzyN8rPTtq7oW1mfos8yma8dbTbRUqsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=axbMHGhopZtg7IB1Z2ZGndq6g2/OsPpdsxKdc9Y9ROoXCVCtKs4Sns4kks2OKe3cbcWtDlM3G37cBHFoWgEtJ7YorVTx0wNg96D2We/RfVOC3ytt6LE33Eml8wAmhNQICCL5FgE+qDDRUjEDJA9Tb7PAY6GzmBlt7Ue0ZD59mLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/9Vty2E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/9Vty2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776614011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=R9Oid93PnVrQy+LikjbR5Hy3F0zFMiTTmcgd9FAZbfo=;
	b=R/9Vty2E7yA0HDoNKg42xj2iVasngi9ahTsVAtKJ2YwlV0vm6HG5kH6MrOcdu04U/vIyan
	mjOTXKGHPbnOEwvrGEsgLz6/RNOKVw0dWNGMVwJyE3aBxPQChw9dQ7MWOPTZ7JftolJYlE
	T7VREk/UkOpz1P87En9IMaFPew08zA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-_7uab2HjN2GHIN3c1sXo8w-1; Sun,
 19 Apr 2026 11:53:27 -0400
X-MC-Unique: _7uab2HjN2GHIN3c1sXo8w-1
X-Mimecast-MFC-AGG-ID: _7uab2HjN2GHIN3c1sXo8w_1776614005
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A13F180036E;
	Sun, 19 Apr 2026 15:53:25 +0000 (UTC)
Received: from fedora (unknown [10.44.32.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 06BB319560AB;
	Sun, 19 Apr 2026 15:53:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 19 Apr 2026 17:53:24 +0200 (CEST)
Date: Sun, 19 Apr 2026 17:53:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Drewry <wad@chromium.org>
Cc: Eric Paris <eparis@redhat.com>, Kusaram Devineni <kusaram@devineni.in>,
	Max Ver <dudududumaxver@gmail.com>,
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] seccomp: introduce seccomp_nack_syscall() helper
Message-ID: <aeT6b-NL23x5a-Aw@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aeT6T7ZJ45yAtdZs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: zZYiplvft5AC13jU56U3TCQEq-ujBPZWRfbf6A2Co30_1776614005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To factor out the code and simplify the next change

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/seccomp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 066909393c38..cb8dd78791cd 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1256,6 +1256,14 @@ static int seccomp_do_user_notification(int this_syscall,
 	return -1;
 }
 
+static void seccomp_nack_syscall(int this_syscall, int data, bool force_coredump)
+{
+	/* Show the handler or coredump the original registers. */
+	syscall_rollback(current, current_pt_regs());
+	/* Let the filter pass back 16 bits of data. */
+	force_sig_seccomp(this_syscall, data, force_coredump);
+}
+
 static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
@@ -1285,10 +1293,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		goto skip;
 
 	case SECCOMP_RET_TRAP:
-		/* Show the handler the original registers. */
-		syscall_rollback(current, current_pt_regs());
-		/* Let the filter pass back 16 bits of data. */
-		force_sig_seccomp(this_syscall, data, false);
+		seccomp_nack_syscall(this_syscall, data, false);
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
@@ -1360,10 +1365,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
 		    (atomic_read(&current->signal->live) == 1)) {
-			/* Show the original registers in the dump. */
-			syscall_rollback(current, current_pt_regs());
-			/* Trigger a coredump with SIGSYS */
-			force_sig_seccomp(this_syscall, data, true);
+			seccomp_nack_syscall(this_syscall, data, true);
 		} else {
 			do_exit(SIGSYS);
 		}
-- 
2.52.0

