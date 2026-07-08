Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F9439333
	for <audit@vger.kernel.org>; Wed,  8 Jul 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524731; cv=none; b=kPWV4yGDtH/U0W7POQ2eCnQ8msSHWwXtgwFkpDXkAJMrhcJduAm+rFhC7kyve1IRBV4VsJgD+JgrvEoGcX13NJsP+CYJSyB8EFsjZR809W4GcuoZ8iXjYVUH9HCx5ejPgnji1EElAA+lFhGraxkSrFLFdqwrW6lFqzEvr67kJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524731; c=relaxed/simple;
	bh=lw90Ou02Ofle4m8YuZ1/7KBANeeVcQTtXR3ThEOLYUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m0l5Lkdw+fbXKIpaul6OLe3VwUeHPoptqUaRcc3plqEpQleI/Xwz0rn/2SFbv/b4lpBDOIlIEYa7YwajqIVdtiT20HkNAiUCeoi4hY/ISulcuLMtOq1vxvgRZw+Y6GyyEmE25IA6Iq+ztOvu9UhNSQUUAj+QIkgTbSc2PU3TqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RT6XOBum; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RT6XOBum"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kOouu6c8JJciYITIK9tcB9pQm+6XnEGzs3sAs5BEiYM=;
	b=RT6XOBumBpf3V3Il2teLNdATflZUhNEiGT/Hl5mzBV+aqOZbNl6M568wO1Vwqv2Kbe6+GQN6o
	/Oxbxb/nm6XBxbm2VeHhUEK+0U/18stvEHmoESQ8murxJ1v2alSfB8zYE+CIY+v0kRXIcoeiKYZ
	E4H/glO6M44G31bPfiMndU0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwMLM5lyrznTW2;
	Wed,  8 Jul 2026 23:23:23 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id AD6834057C;
	Wed,  8 Jul 2026 23:31:59 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jul 2026 23:31:59 +0800
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jul 2026 23:31:59 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <paul@paul-moore.com>, <eparis@redhat.com>
CC: <audit@vger.kernel.org>
Subject: [PATCH RFC,-next] audit: add syscall fastpath to skip audit for uncovered syscalls
Date: Wed, 8 Jul 2026 15:29:57 +0000
Message-ID: <20260708152957.150112-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500013.china.huawei.com (7.202.195.103)

When audit rules are configured, syscalls not covered by any rule
(e.g., futex, nanosleep, epoll_pwait) still incur full audit
overhead.

Add a bitmap fastpath: at syscall entry, audit_fastpath_skip()
checks a precomputed bitmap; if the syscall is not covered, set
dummy=1 so the exit path skips both filter traversal and context
reset.

The bitmap is the OR of:
  - All EXIT rules' masks (not including watch/tree rules, ORed
    under audit_filter_mutex during rebuild)
  - audit_inode_syscalls[]: native syscalls that may trigger
    __audit_inode()/__audit_getname(), built at init from the
    file-operation audit classes plus audit_classify_syscall().

Compat syscalls are excluded from the fastpath because native and
compat syscall numbers share the same flat bitmap but belong to
different namespaces.  in_compat_syscall() guards the fastpath
so compat paths always take the original full audit processing.
Accordingly, audit_inode_syscalls[] only includes native audit
classes, not their _32 compat variants.

The bitmap is read lock-free via READ_ONCE on syscall hot paths
and written under audit_filter_mutex with WRITE_ONCE per word —
the same no-guarantee-during-rule-change policy as audit_n_rules.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/audit.h       |   6 ++
 kernel/auditfilter.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c     |   3 +
 3 files changed, 149 insertions(+)

diff --git a/kernel/audit.h b/kernel/audit.h
index 92d5e723d570..87fb5e570651 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -218,6 +218,12 @@ struct audit_context {
 
 extern bool audit_ever_enabled;
 
+#ifdef CONFIG_AUDITSYSCALL
+extern bool audit_fastpath_skip(int major);
+#else
+static inline bool audit_fastpath_skip(int major) { return false; }
+#endif
+
 extern void audit_log_session_info(struct audit_buffer *ab);
 
 extern int auditd_test_task(struct task_struct *task);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4401119b5275..9b497b7b3196 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -10,6 +10,10 @@
 
 #include <linux/kernel.h>
 #include <linux/audit.h>
+#ifdef CONFIG_AUDITSYSCALL
+#include <linux/audit_arch.h>
+#include <asm/syscall.h>
+#endif
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
@@ -165,6 +169,81 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
 static __u32 *classes[AUDIT_SYSCALL_CLASSES];
 
+#ifdef CONFIG_AUDITSYSCALL
+static u32 audit_filter_syscalls[AUDIT_BITMASK_SIZE];
+static u32 audit_inode_syscalls[AUDIT_BITMASK_SIZE];
+
+/**
+ * audit_fastpath_skip - check if a syscall can skip audit processing
+ * @major: syscall number
+ *
+ * Determines whether the syscall identified by @major is not covered by
+ * any audit rule and can thus safely skip the full audit entry/exit path.
+ *
+ * The fastpath bitmap is a merge of two sources:
+ *  1) All EXIT rules' masks (not including watch/tree rules) ORed into
+ *     audit_filter_syscalls.
+ *  2) audit_inode_syscalls is always ORed in, covering syscalls that may
+ *     trigger __audit_inode()/__audit_getname() (open, execve, etc.).
+ *
+ * The bitmap is read lock-free via READ_ONCE on syscall hot paths, and
+ * written under audit_filter_mutex during rule changes with WRITE_ONCE
+ * per word, following the same no-guarantee-during-rule-change policy
+ * as audit_n_rules.
+ *
+ * Return: true if the syscall is not covered by any rule (can skip),
+ *         false otherwise.
+ */
+bool audit_fastpath_skip(int major)
+{
+	u32 filter_word;
+
+	if (in_compat_syscall())
+		return false;
+
+	if (major < 0 || major >= AUDIT_BITMASK_SIZE * 32)
+		return false;
+
+	filter_word = READ_ONCE(audit_filter_syscalls[AUDIT_WORD(major)]);
+
+	return !(filter_word & AUDIT_BIT(major));
+}
+
+static void audit_rebuild_filter_syscalls(void)
+{
+	struct audit_entry *e;
+
+	lockdep_assert_held(&audit_filter_mutex);
+
+	for (int i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		WRITE_ONCE(audit_filter_syscalls[i], 0);
+
+	list_for_each_entry(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
+		struct audit_krule *r = &e->rule;
+
+		if (r->tree)
+			continue;
+
+		for (int i = 0; i < AUDIT_BITMASK_SIZE; i++)
+			WRITE_ONCE(audit_filter_syscalls[i],
+				   audit_filter_syscalls[i] | r->mask[i]);
+	}
+
+	/*
+	 * Always OR audit_inode_syscalls into the filter bitmap so that
+	 * syscalls which may trigger __audit_inode()/__audit_getname()
+	 * (open, execve, etc.) are never skipped, regardless of whether
+	 * watch/tree rules currently exist.  These syscalls must always
+	 * run the normal entry path to set up the audit context; skipping
+	 * them would leave the context uninitialized if a later part of
+	 * the kernel (e.g., audit_log_start) needs to emit a record.
+	 */
+	for (int i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		WRITE_ONCE(audit_filter_syscalls[i],
+			   audit_filter_syscalls[i] | audit_inode_syscalls[i]);
+}
+#endif
+
 int __init audit_register_class(int class, unsigned int *list)
 {
 	__u32 *p = kcalloc(AUDIT_BITMASK_SIZE, sizeof(__u32), GFP_KERNEL);
@@ -183,9 +262,59 @@ int __init audit_register_class(int class, unsigned int *list)
 		return -EINVAL;
 	}
 	classes[class] = p;
+
+#ifdef CONFIG_AUDITSYSCALL
+	switch (class) {
+	case AUDIT_CLASS_WRITE:
+	case AUDIT_CLASS_READ:
+	case AUDIT_CLASS_DIR_WRITE:
+	case AUDIT_CLASS_CHATTR:
+		for (int i = 0; i < AUDIT_BITMASK_SIZE; i++)
+			audit_inode_syscalls[i] |= p[i];
+		break;
+	}
+#endif
+
 	return 0;
 }
 
+#ifdef CONFIG_AUDITSYSCALL
+static int __init audit_build_inode_syscalls(void)
+{
+	unsigned int arch = syscall_get_arch(current);
+
+	static const struct {
+		unsigned int nr;
+		int classify_result;
+	} table[] = {
+#ifdef __NR_open
+		{ __NR_open,     AUDITSC_OPEN },
+#endif
+#ifdef __NR_openat
+		{ __NR_openat,   AUDITSC_OPENAT },
+#endif
+#ifdef __NR_openat2
+		{ __NR_openat2,  AUDITSC_OPENAT2 },
+#endif
+#ifdef __NR_execve
+		{ __NR_execve,   AUDITSC_EXECVE },
+#endif
+#ifdef __NR_execveat
+		{ __NR_execveat, AUDITSC_EXECVE },
+#endif
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(table); i++) {
+		if (audit_classify_syscall(arch, table[i].nr) == table[i].classify_result)
+			audit_inode_syscalls[AUDIT_WORD(table[i].nr)] |=
+				AUDIT_BIT(table[i].nr);
+	}
+
+	return 0;
+}
+late_initcall(audit_build_inode_syscalls);
+#endif
+
 int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
@@ -1013,7 +1142,11 @@ static inline int audit_add_rule(struct audit_entry *entry)
 
 	if (!audit_match_signal(entry))
 		audit_signals++;
+
+	if (entry->rule.listnr == AUDIT_FILTER_EXIT)
+		audit_rebuild_filter_syscalls();
 #endif
+
 	mutex_unlock(&audit_filter_mutex);
 
 	return err;
@@ -1060,6 +1193,9 @@ int audit_del_rule(struct audit_entry *entry)
 
 	if (!audit_match_signal(entry))
 		audit_signals--;
+
+	if (e->rule.listnr == AUDIT_FILTER_EXIT)
+		audit_rebuild_filter_syscalls();
 #endif
 
 	list_del_rcu(&e->list);
@@ -1458,6 +1594,10 @@ int audit_update_lsm_rules(void)
 				err = res;
 		}
 	}
+
+#ifdef CONFIG_AUDITSYSCALL
+	audit_rebuild_filter_syscalls();
+#endif
 	mutex_unlock(&audit_filter_mutex);
 
 	return err;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..4471fa9b4101 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2010,6 +2010,9 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 			return;
 	}
 
+	if (!context->dummy)
+		context->dummy = audit_fastpath_skip(major);
+
 	context->arch	    = syscall_get_arch(current);
 	context->major      = major;
 	context->argv[0]    = a1;
-- 
2.43.0

