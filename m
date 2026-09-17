Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD059D61E
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656032; cv=none; b=OaxTWLvyJ67nLF5U7mWMmZdyyDQsjAe6qz2V+Kbp+qVNhjV5JBu+rYL9JqmZNvPMgbVyUpVogqe+vBbWYZjy9AuSjIj64pKc6WggJjhLHaLBD3155dIx3pXfPcHVgbdHtbKIpTiReD87NFgH7gj0kKQCzY9Mafg+brh3BYQEvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656032; c=relaxed/simple;
	bh=GmtiXVbaEXAn9cQgxisHuyH5ukeWYWexIPpDQTTFDiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcvcUXzRLClAUAhiQm/J+eX0zl1JjsavVOSoHCJGbJ+fdGSrteLxVUa+IL4d5XXXzVaACUGDNf3tXabsrXBoTnVjd6EIBJsSOq4Vws0yTAPVuixmSP6BuOeg4ehYXi4357qIRTIVC65Cvcti2LqKcUiImhhZIuX/JeQspjtrb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bH7yHQy4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bH7yHQy4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789656023;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1cYPtlgSvScx0+jFMMti+6/1CtRr78qfBxoy5zRF2Q=;
	b=bH7yHQy4MkF2WX7wmGaZNXjd4ysVTEtk74xXy9hfhrn4/zaE331VZk7jGXFotzesEEnC1K
	r5YLg7m/Z6fl1KmIuUBEZJfO3UucPuKBCDYReOX4ns8X8Ix/YNn4UpeIInwkPglWau0WTx
	ZupR7SuD55ivIs2gfz0guyrlmhnO6rxnrmKVBGmAwVtUCqH1WfJO8Togg/xV59BiHzipYV
	mBy2h5yiPlM+b09peAaRVqjct5rP4qgOE227N6HVWUA9+A87x9FdsFLgrf893nEwubsq0w
	P7qdprjLFcXEFltoQ9q2yprOg9EY4e3W+r5gOLAoFHeqyoVvUL5RNQQKq4q4yA==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 3/4] audit: return the collected inode entry from a private helper
Date: Thu, 17 Sep 2026 16:39:47 +0200
Message-ID: <20260917143948.106603-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-1-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Keep the __audit_inode() interface and collection behavior unchanged.
Return the selected entry, or NULL when collection is skipped or fails,
so audit_file() can attach descriptor-specific information reliably.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/auditsc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 464736499c83..b14765cdd56f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2237,13 +2237,16 @@ static void audit_copy_inode(struct audit_names *name,
 }
 
 /**
- * __audit_inode - store the inode and device from a lookup
+ * audit_inode_entry - store the inode and device from a lookup
  * @name: name being audited
  * @dentry: dentry being audited
  * @flags: attributes for this particular entry
+ *
+ * Return: the collected entry, or NULL if collection was skipped or failed.
  */
-void __audit_inode(struct filename *name, const struct dentry *dentry,
-		   unsigned int flags)
+static struct audit_names *audit_inode_entry(struct filename *name,
+					     const struct dentry *dentry,
+					     unsigned int flags)
 {
 	struct audit_context *context = audit_context();
 	struct inode *inode = d_backing_inode(dentry);
@@ -2254,7 +2257,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	int i;
 
 	if (context->context == AUDIT_CTX_UNUSED)
-		return;
+		return NULL;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, list, list) {
@@ -2266,7 +2269,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 						f->op, f->val)
 			    && e->rule.action == AUDIT_NEVER) {
 				rcu_read_unlock();
-				return;
+				return NULL;
 			}
 		}
 	}
@@ -2320,7 +2323,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	/* unable to find an entry with both a matching name and type */
 	n = audit_alloc_name(context, AUDIT_TYPE_UNKNOWN);
 	if (!n)
-		return;
+		return NULL;
 	if (name) {
 		n->name = name;
 		name->refcnt++;
@@ -2338,6 +2341,19 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	}
 	handle_path(dentry);
 	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
+	return n;
+}
+
+/**
+ * __audit_inode - store the inode and device from a lookup
+ * @name: name being audited
+ * @dentry: dentry being audited
+ * @flags: attributes for this particular entry
+ */
+void __audit_inode(struct filename *name, const struct dentry *dentry,
+		   unsigned int flags)
+{
+	audit_inode_entry(name, dentry, flags);
 }
 
 void __audit_file(const struct file *file)
-- 
2.55.0

