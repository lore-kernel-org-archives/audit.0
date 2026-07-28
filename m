Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACB448BBD
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248117; cv=none; b=aEJSz+Ec9rplKOS8Jts2kpFXIZZ5Qd0kmd1qmSZT/O0CLD14ro0REg1EsTLyXHh8tsKQZextKxkZTdcyK/cCYEPJLcaZFbesC7B4dVngOFz13PKXKIL9WQozzRKubjsVFZGLoceLsVj1p/Gb8Hp6/DgWXYPxepe0BI9TzjM3GgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248117; c=relaxed/simple;
	bh=z0E5sq0E6BedNZSbG1Ta/V7KGZUvWPdCv9yhsNszASE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mxAC88zIZ12TnzKdf4TA4PJMxjA0xPrP9FTXpGa0AB9yb84eyehSrnC/Dx3rbi6y1tUGt/lUAWwBJHtsuJL8qgOW5mp6AzIpPp+doP5Fi/oeNYG71Muid6Z3jI2mjdcYPIwPb53ggMejzCu4tG1qyQrT/cWSs6gN+j2uB3BufPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxlA4Xw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxlA4Xw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785248115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vob2+CnBOfoHzDTBPvquR0ip+nHAQQOCLFjnk1EBmQM=;
	b=TxlA4Xw6mSvKPM8ZmWPBC+AoDlPMTQzoY6NKcJi1cmcOgBaeDHTcPcEwiUF/tuZTl38UfS
	BiJ+Pwh8yRsuxjGFIy9V3nnMtrRc6r4dBqBn94mWM2v7VP9MyhfjcEArrUdko3cFY74gAo
	tutbwcZuqst9qZPfAVds/ve3byRLG8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-vy8D0WrVO9eGK9SZolVMlQ-1; Tue,
 28 Jul 2026 10:15:09 -0400
X-MC-Unique: vy8D0WrVO9eGK9SZolVMlQ-1
X-Mimecast-MFC-AGG-ID: vy8D0WrVO9eGK9SZolVMlQ_1785248107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C027D195396E;
	Tue, 28 Jul 2026 14:14:55 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 926A7180056E;
	Tue, 28 Jul 2026 14:14:53 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 2/2] audit: drop BUG_ON() from audit_signal_info_syscall()
Date: Tue, 28 Jul 2026 11:14:24 -0300
Message-ID: <32c8fbc6f680e8309f64fd04f580b6a51bec0176.1785246707.git.rrobaina@redhat.com>
In-Reply-To: <cover.1785246707.git.rrobaina@redhat.com>
References: <cover.1785246707.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: O6Hl8UMbMrMrlYgSuI8cFVQ9ai69pQY7aEXBt2BlNA0_1785248107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The BUG_ON(axp->pid_count >= AUDIT_AUX_PIDS) check in
audit_signal_info_syscall() will panic the kernel if the signal target
pid array overflows, which is too severe for this situation.

Replace it with a WARN_ON_ONCE() and return of -EINVAL, instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..2b9ce0b52511 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2712,7 +2712,8 @@ int audit_signal_info_syscall(struct task_struct *t)
 		axp->d.next = ctx->aux_pids;
 		ctx->aux_pids = (void *)axp;
 	}
-	BUG_ON(axp->pid_count >= AUDIT_AUX_PIDS);
+	if (WARN_ON_ONCE(axp->pid_count >= AUDIT_AUX_PIDS))
+		return -EINVAL;
 
 	axp->target_pid[axp->pid_count] = task_tgid_nr(t);
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
-- 
2.53.0

