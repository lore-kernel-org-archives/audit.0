Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5A1D47DC
	for <audit@vger.kernel.org>; Tue,  5 Nov 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810338; cv=none; b=sVqRVaVpLH+iphpvinbxMmpUgaRoXlcMnvO6HU4Zn6UHiVOQyutMmTHe72RFLTqcTpJiWckLyl3C7UWmJpbggQNy9uqFXBiiRcSKdTKtZKvL+h6cIQjlsZbecAB5/Gfu+g8t04ZT/QmlOonKzK3itkmPHTdmaBo/Snrpg0pRIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810338; c=relaxed/simple;
	bh=8vpLGRsbdzrgowyBxatraUmVvFAaJH8vb/3SuBlujxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pI/asSJMnt/ethZ/DdHu+2UwOpqYXoFvJ/e8MXmZwZUFWiMCQMWMfGytA+wEIf+iofXBns2s8dzY3FiAR3WpEzv1bfhpcv+fIyg9V++UDJrsWfB/MiY08GdGD1awI83N2TSv5Mq6CXPQP5iNVxEK8RnY0IilPb0Y/dL9AXpSPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYtAHjyf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYtAHjyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730810335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LoG48yjHOEp53ZdqtnIWg0fqBNZJBlJaQRNwyMDWelo=;
	b=BYtAHjyfOksHjlhZCZD3RIuNUiB+nzkUzSeW1r1ADmEDGYGvjOHawbPiqDKdVKQsUBuRWT
	mztT56da8Fyxvc719e4frg+atE8DzqWq1TZmFoWjlU31IwU85QLc8MTowEa/ZmGFn+ce7x
	iYa8Bry7Q+RZeDGe0b4unmItwp9b9GE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-F26dhSz-Npa44YvTYstkwQ-1; Tue,
 05 Nov 2024 07:38:52 -0500
X-MC-Unique: F26dhSz-Npa44YvTYstkwQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B46891955F69;
	Tue,  5 Nov 2024 12:38:51 +0000 (UTC)
Received: from ws.redhat.com (unknown [10.96.134.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C75630001A3;
	Tue,  5 Nov 2024 12:38:48 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com
Subject: [PATCH v1] audit: fix suffixed '/' filename matching in __audit_inode_child()
Date: Tue,  5 Nov 2024 09:37:39 -0300
Message-ID: <20241105123807.1257948-1-rrobaina@redhat.com>
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
treats this corner case by cleaning the input and passing the correct
filename to audit_compare_dname_path().

Steps to reproduce the issue:

 # auditctl -w /tmp
 $ mkdir /tmp/foo
 $ rm -r /tmp/foo/ or rmdir /tmp/foo/
 # ausearch -i | grep PATH | tail -3

This patch is based on a GitHub patch/PR by user @hqh2010.
https://github.com/linux-audit/audit-kernel/pull/148

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..d4fbac6b71a8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2419,7 +2419,8 @@ void __audit_inode_child(struct inode *parent,
 	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
 	struct audit_entry *e;
 	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
-	int i;
+	int i, dlen, nlen;
+	char *fn = NULL;
 
 	if (context->context == AUDIT_CTX_UNUSED)
 		return;
@@ -2443,6 +2444,7 @@ void __audit_inode_child(struct inode *parent,
 	if (inode)
 		handle_one(inode);
 
+	dlen = strlen(dname->name);
 	/* look for a parent entry first */
 	list_for_each_entry(n, &context->names_list, list) {
 		if (!n->name ||
@@ -2450,15 +2452,27 @@ void __audit_inode_child(struct inode *parent,
 		     n->type != AUDIT_TYPE_UNKNOWN))
 			continue;
 
+		/* special case, entry name has the sufix "/" */
+		nlen = strlen(n->name->name);
+		if (dname->name[dlen - 1] != '/' && n->name->name[nlen - 1] == '/') {
+			fn = kmalloc(PATH_MAX, GFP_KERNEL);
+			if (!fn) {
+				audit_panic("out of memory in __audit_inode_child()");
+				return;
+			}
+			strscpy(fn, n->name->name, nlen);
+		}
+
 		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
 		    !audit_compare_dname_path(dname,
-					      n->name->name, n->name_len)) {
+					      fn ? fn : n->name->name, n->name_len)) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = AUDIT_TYPE_PARENT;
 			found_parent = n;
 			break;
 		}
 	}
+	kfree(fn);
 
 	cond_resched();
 
-- 
2.47.0

