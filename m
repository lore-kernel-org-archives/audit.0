Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7315ECDF
	for <audit@vger.kernel.org>; Wed, 28 Aug 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844397; cv=none; b=B5rtHuIikJQIs5k6W6+tLjnL0DyKxvKmpqCWmnZ/CjQNO3LERDTmPu1YoXhfPFEnjZd78e+xOhv8EnrbTlktkpNFL/RFzixJVDsv873z/iJEoNbSiTZXy5mfWAzCpjwODHmy/LSrFbHEaej2KbN2YBzzdd9tGuVZkAh7FOI70AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844397; c=relaxed/simple;
	bh=1lW4rHkYfKN6aTUGiJr17kgBBwohBBWY1TtkDVc3V88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff+v8Lz6kcSjLSFtnrG6O1hTdeJ/TJQWAxUqoP9nuYXKGFmy6W176Aseinih3v7r7SiseqSZI9ssQP5vySNUtwUJk/YuTcG313tSsrm25zzCL5G8phAxPpNfoRYWBUyF9tBYKkgjtuASRwk6JHfFEAKbMGhA+9sINahcYtSiaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6eLyfwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6eLyfwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724844395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCsKHhEXZlOWdQXJLRcvaixcQZE/bIQcZ4s3f8ZjN3E=;
	b=U6eLyfwM8BYCFDcwilfqB8m/I78634u/Z8AgeMq5unzwSiJ9TwlHyZCHJrintvXis4WOaM
	jdpUF/7US+zx5Ko+srtt8hFJv8dQAqevmwQQmOBPpUgZw0CLVfZ40fDHoEEI7Y4nwfsTRl
	kzZO8tGbvgvHGAl+2DUkwhmdXoIuVQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-Sr36sfm7Om2lnfvSfixrrA-1; Wed,
 28 Aug 2024 07:26:31 -0400
X-MC-Unique: Sr36sfm7Om2lnfvSfixrrA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 941AB1955BF1;
	Wed, 28 Aug 2024 11:26:29 +0000 (UTC)
Received: from ws.redhat.com (unknown [10.96.134.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C07991956048;
	Wed, 28 Aug 2024 11:26:26 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com
Subject: [PATCH v2] audit: use task_tgid_nr() instead of task_pid_nr()
Date: Wed, 28 Aug 2024 08:25:06 -0300
Message-ID: <20240828112528.954163-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In a few audit records, PIDs were being recorded with task_pid_nr()
instead of task_tgid_nr().

$ grep "task_pid_nr" kernel/audit*.c
audit.c:       task_pid_nr(current),
auditfilter.c: pid = task_pid_nr(current);
auditsc.c:     audit_log_format(ab, " pid=%u", task_pid_nr(current));

For single-thread applications, the process id (pid) and the thread
group id (tgid) are the same. However, on multi-thread applications,
task_pid_nr() returns the current thread id (user-space's TID), while
task_tgid_nr() returns the main thread id (user-space's PID). Since
the users are more interested in the process id (pid), rather than the
thread id (tid), this patch converts these callers to the correct method.

Link: https://github.com/linux-audit/audit-kernel/issues/126

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
V1 -> V2: Added a more detailed commit description

 kernel/audit.c       | 2 +-
 kernel/auditfilter.c | 2 +-
 kernel/auditsc.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7a62ebbf4d1..9f6b86acab62 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1612,7 +1612,7 @@ static void audit_log_multicast(int group, const char *op, int err)
 	cred = current_cred();
 	tty = audit_get_tty();
 	audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
-			 task_pid_nr(current),
+			 task_tgid_nr(current),
 			 from_kuid(&init_user_ns, cred->uid),
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			 tty ? tty_name(tty) : "(none)",
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d6ef4f4f9cba..470041c49a44 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1344,7 +1344,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 			switch (f->type) {
 			case AUDIT_PID:
-				pid = task_pid_nr(current);
+				pid = task_tgid_nr(current);
 				result = audit_comparator(pid, f->op, f->val);
 				break;
 			case AUDIT_UID:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..cd57053b4a69 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2933,7 +2933,7 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 	audit_log_format(ab, "table=%s family=%u entries=%u op=%s",
 			 name, af, nentries, audit_nfcfgs[op].s);
 
-	audit_log_format(ab, " pid=%u", task_pid_nr(current));
+	audit_log_format(ab, " pid=%u", task_tgid_nr(current));
 	audit_log_task_context(ab); /* subj= */
 	audit_log_format(ab, " comm=");
 	audit_log_untrustedstring(ab, get_task_comm(comm, current));
-- 
2.46.0

