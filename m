Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3301DE4D1
	for <audit@vger.kernel.org>; Fri, 22 Nov 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277948; cv=none; b=h+j29KqWskJdfdCZCr9ZOlmw3nnWYfkyhx17JL08y4IoH5/uKVN9FHgC9P1sWY0QasktmaWPsusOaH8n01iXWo61DafNWbMNiu1XfB+nZ6sJnoWNfaE3MXoXpKMjfiVE6ghmQoTbEoScZq/M+JrdQLE7X8wySfIWcGBFSarcyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277948; c=relaxed/simple;
	bh=VWXwxT6C04496A1cVsoRh7lUJvhum687xzhvABnJSZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emzKrxS8H9qZjA9Rwo1rAjeRvIxxIBVwY/QqlF6VfvyGt3UKYMTh/BvYzeSRhIxOmMhUwm2esBH/FpZJbb6CNDQ8B0L5fj/YZrzpH9QChugdZgnmXiQ+xTP6bjfvQPpU4W64EPii8wwba/sODYiLQS/YW/T+A5vVCSmg4XX7zd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbNLgyJN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbNLgyJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732277945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GcHNY1eSU0YYTVzz1uNfEpo2YJnO5f/D5LNtLBfIkp0=;
	b=BbNLgyJNZlOX/suFUXzs7ibVixXuJM47SovsONBRdvxgXTONglTq+DiW+NxgVL0RHYa9A/
	e7XuireiSUniXQG15YyNCVZmxE+Yh7HWBYGtT2dqp5zpBv5ji/o5p5HXLqrP7C/ZGCok/3
	HLa00nOQke7Ocu3xp8G0zbfn27ci4bw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-IuhjdbhZPr-L8WOfN6osVg-1; Fri,
 22 Nov 2024 07:19:02 -0500
X-MC-Unique: IuhjdbhZPr-L8WOfN6osVg-1
X-Mimecast-MFC-AGG-ID: IuhjdbhZPr-L8WOfN6osVg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A500C1956048;
	Fri, 22 Nov 2024 12:19:00 +0000 (UTC)
Received: from ws.redhat.com (unknown [10.96.134.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA2C030001A0;
	Fri, 22 Nov 2024 12:18:57 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	viro@zeniv.linux.org.uk,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: fix suffixed '/' filename matching in __audit_inode_child()
Date: Fri, 22 Nov 2024 09:18:43 -0300
Message-ID: <20241122121843.641573-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When the user specifies a directory to delete with the suffix '/',
the audit record fails to collect the filename, resulting in the
following logs:

 type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=2 name=(null)
 type=PATH msg=audit(10/30/2024 14:11:17.796:6304) : item=1 name=(null)

It happens because the value of the variables dname, and n->name->name
in __audit_inode_child() differ only by the suffix '/'. This commit
treats this corner case by handling pathname's trailing slashes in
audit_compare_dname_path().

Steps to reproduce the issue:

 # auditctl -w /tmp
 $ mkdir /tmp/foo
 $ rm -r /tmp/foo/
 # ausearch -i | grep PATH | tail -3

The first version of this patch was based on a GitHub patch/PR by
user @hqh2010 [1].

Link: https://github.com/linux-audit/audit-kernel/pull/148 [1]

Suggested-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

---
v2: handling pathname's trailing slashes in audit_compare_dname_path()
v1: https://lore.kernel.org/audit/20241114040948.GK3387508@ZenIV/T/#t
---
 kernel/auditfilter.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 470041c49a44..8ddccdb4a2a7 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1319,13 +1319,20 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
 	if (pathlen < dlen)
 		return 1;
 
-	parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
-	if (pathlen - parentlen != dlen)
-		return 1;
+	if (parentlen == AUDIT_NAME_FULL)
+		parentlen = parent_len(path);
 
 	p = path + parentlen;
 
-	return strncmp(p, dname->name, dlen);
+	/* handle trailing slashes */
+	pathlen -= parentlen;
+	while (p[pathlen - 1] == '/')
+		pathlen--;
+
+	if (pathlen != dlen)
+		return 1;
+
+	return memcmp(p, dname->name, dlen);
 }
 
 int audit_filter(int msgtype, unsigned int listtype)
-- 
2.47.0

