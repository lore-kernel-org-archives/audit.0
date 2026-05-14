Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8C423A61
	for <audit@vger.kernel.org>; Thu, 14 May 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771636; cv=none; b=WSXN/yQj4TM3Qe+2VyN0Z+fuYy5IG//jc5oGJVtdFg3GlGvd55C0oZTAjQGCiY91mWwf1uJhYNfHWQo+f7YBCp7Bq2OwS9WiZSkr0V4FCLxiRj6lFwfeRByztTVy33cfH+Rxa2NtgIcYCTZwsnK0T7InyM8MHBSGOM8Ot3kOWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771636; c=relaxed/simple;
	bh=/Yk4lm14XdQZURfGTAXJTbeCmIGmWWBiApy2YByRaXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=psmpF9ONK74vQuzjFxltkdP0zkH7rmLi/tPpWg0xjeDOfexgKLT+W4tavEHhx6nt3zwSgXaXn0qabsWSr6fD5qEXD8Ar8GEkhvwtFgyu8sBYhUScco77aV4a7H2tXeGiqxtqaI44SPdpX7DwOjranXmf5Mso2DuHWZTiyhrDJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXj6fiWy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXj6fiWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778771626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DawUBnauaikbuh9k7QRM+pj1AjehQ+3S3/pPyPt/sw4=;
	b=cXj6fiWyKXLUeVFYGbuchUolvc/E+Jg+4Lx+0LArTClYceuX0cKBe1dJ8v0DrcxnrFBvlK
	nBpY/IDhcGZM2DH89hgoJnqTKWz6Vr+vyQzqV6kUtNZikv2rwvJWJRVZe2uS522Q9hW7OH
	grop/8vXJRz6TwXGx9pWfQwKJ7cMRuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-fhYMUrslO_uEo6Ds1qFspg-1; Thu,
 14 May 2026 11:13:42 -0400
X-MC-Unique: fhYMUrslO_uEo6Ds1qFspg-1
X-Mimecast-MFC-AGG-ID: fhYMUrslO_uEo6Ds1qFspg_1778771620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E8C19560B6;
	Thu, 14 May 2026 15:13:40 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D3AB30001A2;
	Thu, 14 May 2026 15:13:38 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: use 'unsigned int' instead of 'unsigned'
Date: Thu, 14 May 2026 12:13:20 -0300
Message-ID: <20260514151320.1939290-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 9qBYsDialg4W1nn6wdSBJPXn1kFop_YHrCKZ5ptQU_M_1778771620
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Address checkpatch.pl warning below, across the audit subsystem:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Minor cleanup, no functional changes.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/audit.h      |  4 ++--
 include/linux/audit_arch.h | 12 ++++++------
 kernel/audit.c             |  2 +-
 kernel/audit.h             |  2 +-
 kernel/audit_tree.c        |  2 +-
 kernel/audit_watch.c       |  2 +-
 kernel/auditfilter.c       |  8 ++++----
 kernel/auditsc.c           |  2 +-
 lib/compat_audit.c         | 12 ++++++------
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 803b0183d98d..45abb3722d30 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -133,8 +133,8 @@ enum audit_nfcfgop {
 	AUDIT_NFT_OP_INVALID,
 };
 
-extern int __init audit_register_class(int class, unsigned *list);
-extern int audit_classify_syscall(int abi, unsigned syscall);
+extern int __init audit_register_class(int class, unsigned int *list);
+extern int audit_classify_syscall(int abi, unsigned int syscall);
 extern int audit_classify_arch(int arch);
 
 /* audit_names->type values */
diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
index 2b8153791e6a..a35069a6c15d 100644
--- a/include/linux/audit_arch.h
+++ b/include/linux/audit_arch.h
@@ -21,13 +21,13 @@ enum auditsc_class_t {
 	AUDITSC_NVALS /* count */
 };
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+extern int audit_classify_compat_syscall(int abi, unsigned int syscall);
 
 /* only for compat system calls */
-extern unsigned compat_write_class[];
-extern unsigned compat_read_class[];
-extern unsigned compat_dir_class[];
-extern unsigned compat_chattr_class[];
-extern unsigned compat_signal_class[];
+extern unsigned int compat_write_class[];
+extern unsigned int compat_read_class[];
+extern unsigned int compat_dir_class[];
+extern unsigned int compat_chattr_class[];
+extern unsigned int compat_signal_class[];
 
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..a6f367a0d424 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2030,7 +2030,7 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index ac81fa02bcd7..a5926c83e61b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -233,7 +233,7 @@ static inline int audit_hash_ino(u64 ino)
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index ee84777fdfad..1ed19b775912 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct audit_node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[] __counted_by(count);
 };
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 33577f0f54ef..c9fe64f73ffc 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -244,7 +244,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       u64 ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 093425123f6c..b97c97495807 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -165,13 +165,13 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
 static __u32 *classes[AUDIT_SYSCALL_CLASSES];
 
-int __init audit_register_class(int class, unsigned *list)
+int __init audit_register_class(int class, unsigned int *list)
 {
 	__u32 *p = kcalloc(AUDIT_BITMASK_SIZE, sizeof(__u32), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	while (*list != ~0U) {
-		unsigned n = *list++;
+		unsigned int n = *list++;
 		if (n >= AUDIT_BITMASK_SIZE * 32 - AUDIT_SYSCALL_CLASSES) {
 			kfree(p);
 			return -EINVAL;
@@ -186,7 +186,7 @@ int __init audit_register_class(int class, unsigned *list)
 	return 0;
 }
 
-int audit_match_class(int class, unsigned syscall)
+int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
 		return 0;
@@ -237,7 +237,7 @@ static int audit_match_signal(struct audit_entry *entry)
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *rule)
 {
-	unsigned listnr;
+	unsigned int listnr;
 	struct audit_entry *entry;
 	int i, err;
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ab54fccba215..b0e809d4d2f2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -150,7 +150,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
-	unsigned n;
+	unsigned int n;
 
 	if (unlikely(!ctx))
 		return 0;
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 3d6b8996f027..fee1dfccd116 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -4,32 +4,32 @@
 #include <linux/audit_arch.h>
 #include <asm/unistd32.h>
 
-unsigned compat_dir_class[] = {
+unsigned int compat_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-unsigned compat_read_class[] = {
+unsigned int compat_read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-unsigned compat_write_class[] = {
+unsigned int compat_write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-unsigned compat_chattr_class[] = {
+unsigned int compat_chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-unsigned compat_signal_class[] = {
+unsigned int compat_signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
 
-int audit_classify_compat_syscall(int abi, unsigned syscall)
+int audit_classify_compat_syscall(int abi, unsigned int syscall)
 {
 	switch (syscall) {
 #ifdef __NR_open
-- 
2.53.0

