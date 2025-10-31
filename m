Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E73128CE
	for <audit@vger.kernel.org>; Fri, 31 Oct 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914025; cv=none; b=tL1pn2kd9bf41dl+MzPSiR5mXH2uudu1+Ya/Zmbpci5vRFbt3phsZFCM4QdPdMNiUAcoKd31/xBzHCoLzPDKyT2qt5ss2huRogFNO2LHQVSw8VscI6JOtSGJgrexDwutCnQjJllG8OLu4BZEBjXuBKGkiBkHPmushy+Q+3gBGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914025; c=relaxed/simple;
	bh=hhvoDG1p4Idmhj90naB+8tfs6n6cweOVDReT+ZoN46o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZvWbJqWhQIixtvTbI/ePxWxfpNGOEy494zs3k44tY0X5doAfWUVBJ2OAGvcUD2PKdb5+dXHvjLTaCppF/RuqQqfS+kENBGAFFlN96I3O2eQ+EOk/BgnzlrqeVlh6CcISJnJQG3LCKgBqhT/woGK+UFqMdSOTSJtY+YN9cdP+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/6ddAeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/6ddAeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761914023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lqTzzOfqb2xXUL+MIDv385l+thVQ8udUyxoY+CmjZCs=;
	b=f/6ddAeKbrOVhXA/SAv4hj6AAZNjEC/ce9ECe347Vs3GJobOB3N8WOoUTTIDwWByq13Fwl
	mSessDOwGpUCRvzrNoUfNEbIxeYE4SMRtI45s9kulnpSQAgCn+UjrO2XQ06xWzq3Ai/uXx
	GzSJZ/st3I/2vVDOt8R0r5gTH2DnK2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-NzbbOq0BNM6ap0_x8crshg-1; Fri,
 31 Oct 2025 08:33:39 -0400
X-MC-Unique: NzbbOq0BNM6ap0_x8crshg-1
X-Mimecast-MFC-AGG-ID: NzbbOq0BNM6ap0_x8crshg_1761914018
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91CCB1800451;
	Fri, 31 Oct 2025 12:33:38 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.34])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D90F18004D8;
	Fri, 31 Oct 2025 12:33:36 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3] audit: merge loops in __audit_inode_child()
Date: Fri, 31 Oct 2025 09:33:28 -0300
Message-ID: <20251031123328.1758743-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Whenever there's audit context, __audit_inode_child() gets called
numerous times, which can lead to high latency in scenarios that
create too many sysfs/debugfs entries at once, for instance, upon
device_add_disk() invocation.

   # uname -r
   6.18.0-rc2+

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m46.676s
   user 0m0.000s
   sys 0m46.405s

   # perf record -a insmod loop max_loop=1000
   # perf report --stdio |grep __audit_inode_child
   32.73%  insmod [kernel.kallsyms] [k] __audit_inode_child

__audit_inode_child() searches for both the parent and the child
in two different loops that iterate over the same list. This
process can be optimized by merging these into a single loop,
without changing the function behavior or affecting the code's
readability.

This patch merges the two loops that walk through the list
context->names_list into a single loop. This optimization resulted
in around 51% performance enhancement for the benchmark.

   # uname -r
   6.18.0-rc2-enhancedv3+

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m22.899s
   user 0m0.001s
   sys 0m22.652s

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1966144bdfe..dd0563a8e0be 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2416,41 +2416,36 @@ void __audit_inode_child(struct inode *parent,
 	if (inode)
 		handle_one(inode);
 
-	/* look for a parent entry first */
 	list_for_each_entry(n, &context->names_list, list) {
-		if (!n->name ||
-		    (n->type != AUDIT_TYPE_PARENT &&
-		     n->type != AUDIT_TYPE_UNKNOWN))
+		/* can only match entries that have a name */
+		if (!n->name)
 			continue;
 
-		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
-		    !audit_compare_dname_path(dname,
-					      n->name->name, n->name_len)) {
-			if (n->type == AUDIT_TYPE_UNKNOWN)
-				n->type = AUDIT_TYPE_PARENT;
+		/* look for a parent entry first */
+		if (!found_parent &&
+		    (n->type == AUDIT_TYPE_PARENT || n->type == AUDIT_TYPE_UNKNOWN) &&
+		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
+		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
+			n->type = AUDIT_TYPE_PARENT;
 			found_parent = n;
-			break;
-		}
-	}
-
-	cond_resched();
-
-	/* is there a matching child entry? */
-	list_for_each_entry(n, &context->names_list, list) {
-		/* can only match entries that have a name */
-		if (!n->name ||
-		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
+			if (found_child)
+				break;
 			continue;
+		}
 
-		if (!strcmp(dname->name, n->name->name) ||
-		    !audit_compare_dname_path(dname, n->name->name,
+		/* is there a matching child entry? */
+		if (!found_child &&
+		    (n->type == type || n->type == AUDIT_TYPE_UNKNOWN) &&
+		    (!strcmp(dname->name, n->name->name) ||
+		     !audit_compare_dname_path(dname, n->name->name,
 						found_parent ?
 						found_parent->name_len :
-						AUDIT_NAME_FULL)) {
+						AUDIT_NAME_FULL))) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = type;
 			found_child = n;
-			break;
+			if (found_parent)
+				break;
 		}
 	}
 
-- 
2.51.0

