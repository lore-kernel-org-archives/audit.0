Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167D10957
	for <audit@vger.kernel.org>; Fri, 18 Jul 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752871099; cv=none; b=JQwiqa5qTSkVEm8fmsCPFNduTP6jmlJyxJDjwAHJyGY7a+4sXKB9N7v61pcLaLUQBO2zPMyopHbZAMmZT5nqHxDtc/f/ACE8niQSVTbS8QY/KFGWPTVNN6hLSYo+gCnu35b4G+QMMFZg1vBK/tvdwnkWuPjCh3pBL0UGgxZXC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752871099; c=relaxed/simple;
	bh=AlSsbH4kX1OcQbvP9Y1wqo3dCVOQoo2TxQ9akrFfIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5UpRvCfBEZE7ZpJrsHqYVOnalRlU1lmwoo+8xsjgotidiCy/sHGvRfOhn1hewPSOtXbvsDmjIPHQsI2cVfgHTrErSRyQ7ZmE5vNMNKAO09GKajuu9jqxLycb7qR2ATtjvzEf4RzSf5m+nyIQoNoTp0m//3841hOXbz6N+TN+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHfjIPne; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHfjIPne"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752871093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=50pMAbyQnwdgTZJ9btJV+F/njGuW6C2RnKWeUz9kqlA=;
	b=cHfjIPnelcGPMwyHpn7fAW+3yO9rm+BYezUNfIMp9/0tTfvK2IBBVgHNm66GWYrUu15jdp
	AplKmxmUNpeUu2T6/INAbaqsKG3GXK+yo0wLIwZdrDkqms7qU8L3z5urv+rnMZtCsbnXw0
	XPiT96dfTJvaC1xi6TeaUIfGYpuDhdE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] audit: Replace deprecated strcpy() with strscpy()
Date: Fri, 18 Jul 2025 22:37:34 +0200
Message-ID: <20250718203734.347091-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/audit_tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b0eae2a3c895..1605df0a171e 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -93,8 +93,10 @@ static struct kmem_cache *audit_tree_mark_cachep __ro_after_init;
 static struct audit_tree *alloc_tree(const char *s)
 {
 	struct audit_tree *tree;
+	size_t sz;
 
-	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
+	sz = strlen(s) + 1;
+	tree = kmalloc(struct_size(tree, pathname, sz), GFP_KERNEL);
 	if (tree) {
 		refcount_set(&tree->count, 1);
 		tree->goner = 0;
@@ -103,7 +105,7 @@ static struct audit_tree *alloc_tree(const char *s)
 		INIT_LIST_HEAD(&tree->list);
 		INIT_LIST_HEAD(&tree->same_root);
 		tree->root = NULL;
-		strcpy(tree->pathname, s);
+		strscpy(tree->pathname, s, sz);
 	}
 	return tree;
 }
-- 
2.50.1

