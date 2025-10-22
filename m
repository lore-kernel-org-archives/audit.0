Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364A340A4A
	for <audit@vger.kernel.org>; Wed, 22 Oct 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136614; cv=none; b=cBmvKn1rUbb4f4q72LPq2uCRSckKpecQkoDtq+P3QDURdTil2HXoCRsJe3zBIPmMM7c6MLgO75cZ6/ESweiXrSWkVliEw2TvYyUnabfWTuirEC3tVvugyiwOl1Cur+/LYBmbMUdS5LWEDG2p/FQhK1Z1qQrny/7JqfAM3/mHfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136614; c=relaxed/simple;
	bh=iKiEP6vv4sNtLvacEmEiDTM778xhHijon/hKh1Y6nc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnOyhRSkFKf3nPDVKZR6wD65CUCCYGTnIbftEgaaEsa6hLh+BpM5bklxvRpr7RGkOIq7I8RyxOEw8mS0R8O2GqHBnAFUwCwBrH9doYnOVhrguw0P5aDPV9aYTSxigZ0dCtwtpv7hLSSwfOV0fFxmQMjIPMcWw0cDBOARQaKIAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBs4K/oe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBs4K/oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761136611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cX/q4yonuMS0uvonyZflX3aBw4/XPspEcSP4VXB6npM=;
	b=NBs4K/oeAQVLuMdzs+vN1fluPM3mZDoc3QksfXrT8LQznaKVISL65uGC/2BXOB9I64BveU
	YtRdVHbk4dSf/VZkIzdMyBFFc/6sgJNaV6QqWLLFNshpsRk9cuk3EcL3WnlsdnIgeox3U8
	/9BB2bG4CqI7pZ0kMHdmIYBjfh7goCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-nYA9gZ-eO--HM5QVoRKWgQ-1; Wed,
 22 Oct 2025 08:36:50 -0400
X-MC-Unique: nYA9gZ-eO--HM5QVoRKWgQ-1
X-Mimecast-MFC-AGG-ID: nYA9gZ-eO--HM5QVoRKWgQ_1761136609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97ACC180035D;
	Wed, 22 Oct 2025 12:36:49 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.73])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C1B41800451;
	Wed, 22 Oct 2025 12:36:47 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: merge loops in __audit_inode_child()
Date: Wed, 22 Oct 2025 09:36:44 -0300
Message-ID: <20251022123644.1560744-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Whenever there's audit context, __audit_inode_child() gets called
numerous times, which can lead to high latency in scenarios that
create too many sysfs/debugfs entries at once, for instance, upon
device_add_disk() invocation.

   # uname -r
   6.17.0-rc3+

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m42.753s
   user 0m0.000s
   sys  0m42.494s

   # perf record -a insmod loop max_loop=1000
   # perf report --stdio |grep __audit_inode_child
   37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child

__audit_inode_child() searches for both the parent and the child
in two different loops that iterate over the same list. This
process can be optimized by merging these into a single loop,
without changing the function behavior or affecting the code's
readability.

This patch merges the two loops that walk through the list
context->names_list into a single loop. This optimization resulted
in around 54% performance enhancement for the benchmark.

   # uname -r
   6.17.0-rc3+-enhanced

   # auditctl -a always,exit -F path=/tmp -k foo
   # time insmod loop max_loop=1000
   real 0m19.388s
   user 0m0.000s
   sys  0m19.149s

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1966144bdfe..8cebc016d9eb 100644
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
+		/* look for a parent entry first */
+		if (!found_parent &&
+		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
+		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = AUDIT_TYPE_PARENT;
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

