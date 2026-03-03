Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FF2288E3
	for <audit@vger.kernel.org>; Tue,  3 Mar 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544940; cv=none; b=uFBCwrmrZPsbG3NvXQjPX0XPvNJk6p2DGHuusHwC8wu219vAm94LFy9jLsb9zS53uk45Db6JcDgU3BxpRhOjT2MRbI//JYmcX+18+7lAV5vhXRrKxyWh5fvlmS9uzE3lBnSW8eSuF6kd+fOi1AS3Al6T1wHkBjPGAjIt7loj4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544940; c=relaxed/simple;
	bh=SKyjPdrhJ2g9n09UmeaLZl1eBt3MGgfyHjhInAHr7dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=o5HU6GHIxQsTYc8ED8NLi6sIEHEvvcfxr1igSdI3pLR4JexVPlMKWV7yZ4MymB4Cuwjp5ryxtPzMO54umJj+K0Xlxr6tv3m1CyjmSc8yiCfnfknC7Lfmu5kSVVOK90pYdoiNoK6ZekS6PAQQcEaimCFV5klXmrcYZaItXt5Ich0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2DkFxZd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2DkFxZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772544937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6hvJOaz7zfwU+QvAYqSk0UN1ZhdUHk1TmYJOg0XU6xU=;
	b=U2DkFxZduTJs1ZHVYnQrfx+B2eNZLCOiMjLm1lJxstx0GQN2OvA90c/6/wHpkftiyn0I8h
	G+fKsMoy5c+oTmGNWuKfygLpLYxcf0CYsmJjsU4sfDTdQjcBxukhp7Ny2eoKY2TuYBfGSS
	H3mkx33aiAeqq/xuc9oCsGVz7yQqST4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-BOgLP0d_NNGRsGsSO5bpKQ-1; Tue,
 03 Mar 2026 08:35:36 -0500
X-MC-Unique: BOgLP0d_NNGRsGsSO5bpKQ-1
X-Mimecast-MFC-AGG-ID: BOgLP0d_NNGRsGsSO5bpKQ_1772544935
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4BB81956088;
	Tue,  3 Mar 2026 13:35:34 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 460121800349;
	Tue,  3 Mar 2026 13:35:32 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	akpm@linux-foundation.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: fix coding style issues
Date: Tue,  3 Mar 2026 10:35:28 -0300
Message-ID: <20260303133528.704135-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: gkzF5qgtYM1pwyg1gDeHjrj2bXEuZOYmKoEl6Oqj2dw_1772544935
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix various coding style issues across the audit subsystem flagged
by checkpatch.pl script to adhere to kernel coding standards.

Specific changes include:
- kernel/auditfilter.c: Move the open brace '{' to the previous line
  for the audit_ops array declaration.
- lib/audit.c: Add a required space before the open parenthesis '('.
- include/uapi/linux/audit.h: Enclose the complex macro value for
  AUDIT_UID_UNSET in parentheses.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/uapi/linux/audit.h | 2 +-
 kernel/auditfilter.c       | 3 +--
 lib/audit.c                | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 14a1c1fe013a..de4015430476 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -508,7 +508,7 @@ struct audit_tty_status {
 	__u32		log_passwd;	/* 1 = enabled, 0 = disabled */
 };
 
-#define AUDIT_UID_UNSET (unsigned int)-1
+#define AUDIT_UID_UNSET ((unsigned int)-1)
 #define AUDIT_SID_UNSET ((unsigned int)-1)
 
 /* audit_rule_data supports filter rules with both integer and string
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 6e3abbf08e3d..093425123f6c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -303,8 +303,7 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
 	return ERR_PTR(err);
 }
 
-static u32 audit_ops[] =
-{
+static u32 audit_ops[] = {
 	[Audit_equal] = AUDIT_EQUAL,
 	[Audit_not_equal] = AUDIT_NOT_EQUAL,
 	[Audit_bitmask] = AUDIT_BIT_MASK,
diff --git a/lib/audit.c b/lib/audit.c
index 738bda22dd39..bc07fbd3a698 100644
--- a/lib/audit.c
+++ b/lib/audit.c
@@ -42,7 +42,7 @@ int audit_classify_syscall(int abi, unsigned syscall)
 	if (audit_is_compat(abi))
 		return audit_classify_compat_syscall(abi, syscall);
 
-	switch(syscall) {
+	switch (syscall) {
 #ifdef __NR_open
 	case __NR_open:
 		return AUDITSC_OPEN;
-- 
2.53.0

