Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB6364947
	for <audit@vger.kernel.org>; Thu, 26 Feb 2026 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129632; cv=none; b=OSOlAj7W0Od4mamD3l5Wpr4zcvW5Hx9+p4dLbUd/ImZ6JifHDvcHqxdZjuiXcQMsL84Cjh0+pmVId6kloFJM34YutfYXUWxuWyUF+Rd2/KANQEH62UCQpohcxif1lPy0ark3taMyGk3MKl5HwBeXk81fofaNv5JqAcPpSMrUPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129632; c=relaxed/simple;
	bh=TKtyPv/fUkMLoB48HfHVIQzQqfQau+NU52aJHmhZk1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AFGcjynuYcdQr92HfuauqQHbSAdTT3/tlGcABrMEk9HA44BebfIKT76yspmo/CuvydBNa9JnbFCEhBVdtmi/3gi7Hubp1bpO5hhlfKhhewCX+qrNTPMX5n+mnv41H+KQlWkyGPMC8HhhMfDk6WVJReKrHT3NQqH3zyOq5txWdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lqrtq+gd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lqrtq+gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772129630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8/TyEfe76Y6Kiy4VsURDps2mRDuc/UO2jHi1HRNucPI=;
	b=Lqrtq+gdIioyaiEP40IFoZhJSX+4qkxp8IMI8yFbs257yhBwUxfB57A/YWclDbp3lO4z1i
	iQy9Jvx0gFfF9oQxoyIN1ogOAT13D5Uw+3plvA3BKwf4ViFjAflJP9n97XGK3LVLk5Cyj4
	6KXoa0m8q1jPuhqT6PqWho8XVm+2OUk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-VwNu4PR_O7yVNexRbgIGeA-1; Thu,
 26 Feb 2026 13:13:47 -0500
X-MC-Unique: VwNu4PR_O7yVNexRbgIGeA-1
X-Mimecast-MFC-AGG-ID: VwNu4PR_O7yVNexRbgIGeA_1772129626
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2699E1956063;
	Thu, 26 Feb 2026 18:13:46 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41ED71956056;
	Thu, 26 Feb 2026 18:13:42 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: remove redundant initialization of static variables to 0
Date: Thu, 26 Feb 2026 15:13:38 -0300
Message-ID: <20260226181338.2526777-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: SlXYdgNfO4pMUbqm5PhWpi0B12WLjBtOFmV3M8Gchw0_1772129626
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Static variables are automatically initialized to 0 by the compiler.
Remove the redundant explicit assignments in kernel/audit.c to clean
up the code, align with standard kernel coding style, and fix the
following checkpatch.pl errors:

 ./scripts/checkpatch.pl kernel/audit.c | grep -A2 ERROR:
 ERROR: do not initialise statics to 0
 +	static unsigned long	last_check = 0;
 --
 ERROR: do not initialise statics to 0
 +	static int		messages   = 0;
 --
 ERROR: do not initialise statics to 0
 +	static unsigned long	last_msg = 0;

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5a0216056524..08793e71b975 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -355,8 +355,8 @@ void audit_panic(const char *message)
 
 static inline int audit_rate_check(void)
 {
-	static unsigned long	last_check = 0;
-	static int		messages   = 0;
+	static unsigned long	last_check;
+	static int		messages;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
@@ -391,7 +391,7 @@ static inline int audit_rate_check(void)
 */
 void audit_log_lost(const char *message)
 {
-	static unsigned long	last_msg = 0;
+	static unsigned long	last_msg;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
-- 
2.53.0

