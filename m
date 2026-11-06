Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977447;
	b=a45imXqi1UCisJRC0nb86d7KbOqZjnLB1RoupYOO5tWFEHy+L344BevQKTweAveb/gMr
	 xORPB40uzhsfkRypzI+DjBBuV3CQh9JikcIQ5kyfW3Yy7532fo90jBwek7JVpzbTefqJC
	 b7FN0cISrMGv4fitriV7OCleIVJ/k2tbjB59CuA4Begmg2QxSMQreg/7K+tH5hJBuGGaW
	 NF7jtXp2lPlzxSXDAoJG9al7AqjXvztbDzCTAr/oAp6GFYuwzeyTkO/bAaFkKcfAfLR96
	 3DwE3B2mMzuvdWHL7FowTm6vXZShN9tS37aobWfiIqdQp75/lKd6F+9hpKU41lByXxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977447;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X3FwBj/ufz9KFwM+g9HQy4eo/6u7CBtC0GICumJm7o4=;
	b=ZJsqz+041pNIQHcWMd1UeHCitQdLJke/7ErFrK0w9bkVNJRR++uzCDGM741+biY8Uy1U
	 pL45oZrlqaZ57boTXvScHI9TQvKlEwZt8mmphTaHYXzExUrXP5TApsZy0PcD6Jx53BWgy
	 Cuyki1SG3TBjEiRjELG8v29TZeI4INchE1/tP9qc/3SZVJue0Da7nO0wToDJtUFe/KeBl
	 7m3aaC+g2OX4RyC/T5JqAcmhewUpv/uI29sy9uoviNjvaf+98nwH3IUS7S3ulc/ARV5lh
	 92Gzr9sgB/jCU+2FISjgBPnrNqZfMN7kswEHeNp2Xy3QTQ9qDGyaZ9okjrY1nUu/ngA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=gvoqr3u0;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521ED606A329
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521ED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=gvoqr3u0
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793977444;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3FwBj/ufz9KFwM+g9HQy4eo/6u7CBtC0GICumJm7o4=;
	b=gvoqr3u0l9X9BQquNZ5S7nLZSeZE6zniqJ3p0fz7+okO14F+2yb4XiJlNZSUUgFEAN/MHP
	AlZnEMIcVK3NbQKZQW7DplLJpUzsmOJFMdhkn2+KEqvyeSWVJMjVQRg/tLqBWuNGlo3RYa
	6ZxY5O/P4Igu1HApNGZ8YKLo4Q1+6HS3HFPBpOie4nAVUI/Km+RIuZpKuN1DPYhNfM2TrY
	3JJ784gXjhJIqHlwxuHsTVnlzxHcytPMTRpg4MOZNCr+mPWRR1Bx+T2NTjTz/hZ+dw5UMq
	acRPPU0teW5FcNormN2sjeB+fSt+LZjQbQgbkBxgqwYwd8xp0L2PHYLky4a6mA==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/3] audit: return the collected entry from __audit_inode()
Date: Fri,  6 Nov 2026 16:03:41 +0100
Message-ID: <20261106150342.670199-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106150342.670199-1-cgoettsche@seltendoof.de>
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Return the selected audit_names entry, or NULL when collection is
skipped or fails, so audit_file() can attach descriptor-specific
information reliably. The existing audit_inode() and
audit_inode_parent_hidden() wrappers ignore the result, and collection
behavior is unchanged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: return the entry from __audit_inode() instead of adding a private
    helper
---
 include/linux/audit.h |  6 ++++--
 kernel/auditsc.c      | 14 +++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 767e349d4834..1f456f954c2e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -35,6 +35,7 @@ struct audit_sig_info {
 
 struct audit_buffer;
 struct audit_context;
+struct audit_names;
 struct inode;
 struct netlink_skb_parms;
 struct path;
@@ -327,8 +328,9 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern void __audit_getname(struct filename *name);
-extern void __audit_inode(struct filename *name, const struct dentry *dentry,
-				unsigned int flags);
+extern struct audit_names *__audit_inode(struct filename *name,
+					 const struct dentry *dentry,
+					 unsigned int flags);
 extern void __audit_file(const struct file *);
 extern void __audit_inode_child(struct inode *parent,
 				const struct dentry *dentry,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 552ba9f4fb0a..b740e056cd80 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2242,9 +2242,12 @@ static void audit_copy_inode(struct audit_names *name,
  * @name: name being audited
  * @dentry: dentry being audited
  * @flags: attributes for this particular entry
+ *
+ * Return: the collected entry, or NULL if collection was skipped or failed.
  */
-void __audit_inode(struct filename *name, const struct dentry *dentry,
-		   unsigned int flags)
+struct audit_names *__audit_inode(struct filename *name,
+				  const struct dentry *dentry,
+				  unsigned int flags)
 {
 	struct audit_context *context = audit_context();
 	struct inode *inode = d_backing_inode(dentry);
@@ -2255,7 +2258,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	int i;
 
 	if (context->context == AUDIT_CTX_UNUSED)
-		return;
+		return NULL;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, list, list) {
@@ -2267,7 +2270,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 						f->op, f->val)
 			    && e->rule.action == AUDIT_NEVER) {
 				rcu_read_unlock();
-				return;
+				return NULL;
 			}
 		}
 	}
@@ -2321,7 +2324,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	/* unable to find an entry with both a matching name and type */
 	n = audit_alloc_name(context, AUDIT_TYPE_UNKNOWN);
 	if (!n)
-		return;
+		return NULL;
 	if (name) {
 		n->name = name;
 		name->refcnt++;
@@ -2339,6 +2342,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	}
 	handle_path(dentry);
 	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
+	return n;
 }
 
 void __audit_file(const struct file *file)
-- 
2.55.0

