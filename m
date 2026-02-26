Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC512275AE8
	for <audit@vger.kernel.org>; Thu, 26 Feb 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126172; cv=none; b=paIva1FY7a4VZCihGAXqwQ8MboolGQjBIYrwC2FjW/A9mSSyh2V9amOkl+Injn4fttSAEIAjgivd9zk3PZyuRgVSePOOJg7iP52DkNarhiP1cBwAhsF8nFJ+CKInEbHAYadwGzJ5osj5zFaA+t4xr+EVPIHhulmltAp4+ctRkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126172; c=relaxed/simple;
	bh=er3YLsu0PjmXmahtlZFUFbJK4Y0hT9LyBSf4vwSrLr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=aMgjkMGfaKqVMVB+qtzUmSVyimW3u/c0EYrQdshXbGV4t3BcB00nDhdtY6c1bdZ+8aQRvUfdbfSwfD3XmNl49c+lYzgK0HJLZz49aQQmx98xJkY05hWHP4k47qovWkut2Nbr5MQjE98TVl43bBOoaNafPnuyvmt1vmu7yGzo9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vspurhhf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vspurhhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772126169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z+1JDyujSu60K8dPP6XZ0y9FQQhVN8HUDjhy9gIaN/0=;
	b=VspurhhfK/ii020o4SpFeMkwa2sqwleZYhRZk0HBIMDgcJWVjsGDekJU5BRC7OZ7uvSC73
	VMRje8RAqcVKI0vD9VngZdWQ3Ed5ZL4oV08h1T1t1Syv7xqq4aYQny9ZPRxpW0gEic53WB
	Wxc9ozWywH0EFYJ/UCtGNdBA045Q3dI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Ndfjon-CNx2tcNYEHRVraw-1; Thu,
 26 Feb 2026 12:16:05 -0500
X-MC-Unique: Ndfjon-CNx2tcNYEHRVraw-1
X-Mimecast-MFC-AGG-ID: Ndfjon-CNx2tcNYEHRVraw_1772126164
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94C971955DC2;
	Thu, 26 Feb 2026 17:16:04 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.51])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A5E61800666;
	Thu, 26 Feb 2026 17:16:02 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: fix whitespace alignment in include/uapi/linux/audit.h
Date: Thu, 26 Feb 2026 14:15:46 -0300
Message-ID: <20260226171546.2231505-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 80KD02-WSUVvwepoY3xdv8-_nEl2sMOObxNh7x641Ao_1772126164
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fixed minor indentation inconsistencies in the audit macros
to align with standard kernel coding style using 8-character
hard tabs.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/uapi/linux/audit.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 14a1c1fe013a..410dfb41b810 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -350,7 +350,7 @@ enum {
 #define AUDIT_STATUS_ENABLED			0x0001
 #define AUDIT_STATUS_FAILURE			0x0002
 #define AUDIT_STATUS_PID			0x0004
-#define AUDIT_STATUS_RATE_LIMIT		0x0008
+#define AUDIT_STATUS_RATE_LIMIT 		0x0008
 #define AUDIT_STATUS_BACKLOG_LIMIT		0x0010
 #define AUDIT_STATUS_BACKLOG_WAIT_TIME		0x0020
 #define AUDIT_STATUS_LOST			0x0040
@@ -386,8 +386,8 @@ enum {
  * These bits disambiguate different calling conventions that share an
  * ELF machine type, bitness, and endianness
  */
-#define __AUDIT_ARCH_CONVENTION_MASK 0x30000000
-#define __AUDIT_ARCH_CONVENTION_MIPS64_N32 0x20000000
+#define __AUDIT_ARCH_CONVENTION_MASK		0x30000000
+#define __AUDIT_ARCH_CONVENTION_MIPS64_N32	0x20000000
 
 /* distinguish syscall tables */
 #define __AUDIT_ARCH_64BIT 0x80000000
-- 
2.53.0

