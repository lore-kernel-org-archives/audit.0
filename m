Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73824A047
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064512; cv=none; b=HsYig0BPF7lCcjGaFm1+yT8h1gm3FTRX+vx4oJhjc7qeF2wPTLHnx6eRtkcQgPi+ini5y+S8wATuTK6gXDZroFh5rSYtFGyr8MQ5BZQQfe9ngXRA1Mi5/ZpwJWzUquty0/aMxpcqdbsVv1XSQVZKAG8IBHIhUD9l9s7r0DLoLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064512; c=relaxed/simple;
	bh=hO2zIVXsanarVAstUrUEC/wI+YDEQjhFgSc8QifAcHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5AbmZ8DbLTmguvEadkBCev8lrEa9bU4aIuxAqt68105aH1WKKEB7OiWpAggZGDWKDTwvYa9i4H+uNO/YNE64y84VB5rCHSU0eRhnJNpES0lkao8HjP1QsEbbUtK+LdqMbCSFfKcK5i2bMc7Jq0Wvm5Xt/Ehkxtrac2GyQ/+Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBt78xqn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBt78xqn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so27441575ad.3
        for <audit@vger.kernel.org>; Thu, 06 Aug 2026 18:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786064509; x=1786669309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOrYwMwMcKhjd1hcBSf/T5DT9YmmM3v7iOs2AT3Kchg=;
        b=dBt78xqnqIcbqDZ/NjKVmuDs70mtOjIy6/VfAcyUFkbbjznXITD8jdI/hcv+MLcSzs
         KgWOctpzuWRiy4zT4FQrB4y4YvdVAkBhEm+2Oqf4GMpoyF/O3ejLFAKuMUgmTcPtrPhC
         BCD3/qddHGW4vcLOs7+QDOJoti+t84g1lxXYNbLg4tqTYMb42IqxHJv/hValfdm5dst/
         LzAnmaMAYBibUzJXjZ7KzuSODLhZMf52YWCmiQH7FByp3C85NeDxuDar29kdyZqu8ut0
         oiLrnzDXoPlSX4JTMwbFqSFMMw6wimkCQhCz3mgxe0MjopYjGnjwmu80yyimDvO4xVcr
         OM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786064509; x=1786669309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOrYwMwMcKhjd1hcBSf/T5DT9YmmM3v7iOs2AT3Kchg=;
        b=gdIbKIXLWP5qb6Zr+bWhCvNdy5dwdXkTuUhLEf1jpQSBfvrXB7j3lkgojQdpJdTJgt
         PtWb+dZIqYcgsg6Y3I8Tn+R52aQP9ro1cPpf4+0BrfAB/A12cJEmbTz5ifSPEwP3MJfk
         0Gwnp5rGRCeb2qvUez6AfEF3LLnO3ucsJ7fLKfH7GwZEvh+cmhGwUe8XYE1s26VuFKy/
         l7+eBJX11kx2uCV62dUKYmKV2R9w8ZPfYZza2buWd2Jdj7CDH5FZxv39n8p/6tz3ZIAQ
         rJg5qQLFZbljBD9XXzTGfV2onmJ3HQAj3x7Lxbre35CoKdbLc4NuREvAZDDEJOoPYwh7
         dS7A==
X-Forwarded-Encrypted: i=1; AHgh+RoLK1IW8vl1EU5jppdmbsJzDFZLxlAscuJAiG9zAbws8bGF5a3tiqUPof20n8kihwgTD7TwOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAgbgQJ9VVaLLlqBwFjNYrm0i0XT+OgoiZuDDRWyL0hRCuTZJ
	JlnT4b8IyWHsOzf0tZb2CvyY6avGnfgODPCegnWdfKfEI/ETGuYrY7rt
X-Gm-Gg: AR+sD12NfDqbD0k6TlDpbpzNpvk/L2orYFWTEAliWhIpjqkTSt1J++RXfjxhDis7lZG
	zhZy+btiSbFW0sOLIsUg1dvciNOJaPKy/OOGgMkmEwkpEdRMsIQb+oeFwQB2baMsGr02e88Ksix
	+6+8Ul37rL4uXyjDwsvORXmHQfAVFV+0Y2eSy3eDHCllPmkuvRqENk0FPn8KMV7L4YF6kidKSpu
	4Ucd7fEyMfVlEnylpAp94fpTiYVobq38eXsYghlhHozG8bsDQQfKddqMZitc11pUpx1RXpetaId
	lMAkADYRvndTLZzOuA6wnBb8DF+78PiyGtAcDVbfAfj/9pcdRIKRz1Ol9uScQhm35YaPe14nxG2
	BcFAea50KXwI0FYNmSydkpHh9yQng6v0NK1eXcFViwgcoIYNM0J7y0Nbzmur4LS9rN/CdGNnATO
	yHt89bRWcoNkQXpAV+8T5dWqSkE/iC/5eg0kBGj0oejqaOAaZsf7ByNiHG0h/MNqdAg1x41lK+F
	eR2MIIQQj3BhAVgD2/5e9Dp7rsds179Hedq303csY6w6w==
X-Received: by 2002:a17:902:e787:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d106e333f0mr65082035ad.17.1786064509061;
        Thu, 06 Aug 2026 18:01:49 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d7684f8sm1527725ad.33.2026.08.06.18.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:01:48 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 06 Aug 2026 18:01:20 -0700
Subject: [PATCH 2/3] audit: Fix filter rule accounting after automatic
 removal
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-audit-v1-2-ddd0d94ff0b6@gmail.com>
References: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
In-Reply-To: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
To: Shuah Khan <shuah@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Amy Griffis <amy.griffis@hp.com>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, 
 Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 audit@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786064505; l=9360;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=hO2zIVXsanarVAstUrUEC/wI+YDEQjhFgSc8QifAcHk=;
 b=O3j92f4AyhUHfjs2ASYG+yoDK37hQWIocAmIfCo2js5SaETWgqyzfitgG2HpDJQAoElEjgood
 YhHt6m9Jo6SAUnZvxXlApSixj4OmoJ86MXNL4ikRI3vzbTqgPhaOl3S
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

The audit_n_rules and audit_signals counters are incremented when filter
rules are installed and decremented by the explicit rule deletion path.
Rules can also disappear when a watch or tree is removed, or when an LSM
rule cannot be reconstructed, but those paths do not update the counters.

As a result, audit_n_rules can remain nonzero after the last applicable
rule has gone away, causing subsequent syscalls to allocate non-dummy
audit contexts unnecessarily. A stale audit_signals value similarly
causes unnecessary signal auditing work.

This can be reproduced for an inode watch with:

  mkdir /tmp/audit-n-rules-bench
  touch /tmp/audit-n-rules-bench/watched
  auditctl -w /tmp/audit-n-rules-bench/watched -p r \
           -k audit_n_rules_bench
  rm /tmp/audit-n-rules-bench/watched
  rmdir /tmp/audit-n-rules-bench

The rm updates the watch after its inode disappears, and the rmdir causes
audit_remove_parent_watches() to remove the rule. For an audit tree, the
kill_rules() path can be reproduced with:

  mkdir /tmp/audit-kill-rules
  auditctl -a always,exit -F arch=b64 \
           -F dir=/tmp/audit-kill-rules -F perm=r \
           -k audit_kill_rules_test
  rmdir /tmp/audit-kill-rules

In both cases, auditctl -l reports no rules after the directory is
removed. Run the following before installing the rule and again after it
has disappeared:

  audit_bench --iterations 10000000 --repetitions 10

For the inode watch, the same VM produced:

  no rules:
    median=38 mean=39 stddev=4 (10%) range=38..53 ns/op
  automatically removed, before this fix:
    median=55 mean=56 stddev=3 (5%) range=55..65 ns/op
  automatically removed, with this fix:
    median=38 mean=39 stddev=4 (10%) range=38..52 ns/op

For the audit tree, it produced:

  no rules:
    median=38 mean=39 stddev=4 (9%) range=38..52 ns/op
  automatically removed, before this fix:
    median=59 mean=60 stddev=2 (3%) range=59..67 ns/op
  automatically removed, with this fix:
    median=38 mean=39 stddev=4 (9%) range=38..52 ns/op

Reboot between the unpatched and patched tests because an already stale
counter cannot be repaired by deleting rules which are no longer present.

Factor the existing counter updates into common rule insertion and removal
helpers and call the removal helper from every automatic removal path. All
of these updates remain serialized by audit_filter_mutex.

Fixes: 471a5c7c8391 ("[PATCH] introduce audit rules counter")
Fixes: e54dc2431d74 ("[PATCH] audit signal recipients")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 kernel/audit.h       |  5 +++
 kernel/audit_tree.c  |  1 +
 kernel/audit_watch.c |  2 ++
 kernel/auditfilter.c | 86 +++++++++++++++++++++++++---------------------------
 4 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 92d5e723d570..3176da464843 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -272,6 +272,9 @@ extern void audit_put_tty(struct tty_struct *tty);
 /* audit watch/mark/tree functions */
 extern unsigned int audit_serial(void);
 #ifdef CONFIG_AUDITSYSCALL
+void audit_rule_account(const struct audit_krule *rule);
+void audit_rule_unaccount(const struct audit_krule *rule);
+
 extern int auditsc_get_stamp(struct audit_context *ctx,
 			     struct audit_stamp *stamp);
 
@@ -315,6 +318,8 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
+#define audit_rule_account(...) do { } while (0)
+#define audit_rule_unaccount(...) do { } while (0)
 #define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b775912..2d68d2ec2b2a 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -558,6 +558,7 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 			rule->tree = NULL;
 			list_del_rcu(&entry->list);
 			list_del(&entry->rule.list);
+			audit_rule_unaccount(rule);
 			call_rcu(&entry->rcu, audit_free_rule_rcu);
 		}
 	}
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 4ac8a91e9ba8..28fab822ca0c 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -284,6 +284,7 @@ static void audit_update_watch(struct audit_parent *parent,
 			nentry = audit_dupe_rule(&oentry->rule, ctx);
 			if (IS_ERR(nentry)) {
 				list_del(&oentry->rule.list);
+				audit_rule_unaccount(r);
 				audit_panic("error updating watch, removing");
 			} else {
 				int h = audit_hash_ino(ino);
@@ -336,6 +337,7 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 			list_del(&r->rlist);
 			list_del(&r->list);
 			list_del_rcu(&e->list);
+			audit_rule_unaccount(r);
 			call_rcu(&e->rcu, audit_free_rule_rcu);
 		}
 		audit_remove_watch(w);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 7f791afe5791..38a56278ae0b 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -196,7 +196,7 @@ int audit_match_class(int class, unsigned int syscall)
 }
 
 #ifdef CONFIG_AUDITSYSCALL
-static inline int audit_match_class_bits(int class, u32 *mask)
+static inline int audit_match_class_bits(int class, const u32 *mask)
 {
 	int i;
 
@@ -208,30 +208,62 @@ static inline int audit_match_class_bits(int class, u32 *mask)
 	return 1;
 }
 
-static int audit_match_signal(struct audit_entry *entry)
+static int audit_match_signal(const struct audit_krule *rule)
 {
-	struct audit_field *arch = entry->rule.arch_f;
+	struct audit_field *arch = rule->arch_f;
 
 	if (!arch) {
 		/* When arch is unspecified, we must check both masks on biarch
 		 * as syscall number alone is ambiguous. */
 		return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
-					       entry->rule.mask) &&
+					       rule->mask) &&
 			audit_match_class_bits(AUDIT_CLASS_SIGNAL_32,
-					       entry->rule.mask));
+					       rule->mask));
 	}
 
 	switch (audit_classify_arch(arch->val)) {
 	case 0: /* native */
 		return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
-					       entry->rule.mask));
+					       rule->mask));
 	case 1: /* 32bit on biarch */
 		return (audit_match_class_bits(AUDIT_CLASS_SIGNAL_32,
-					       entry->rule.mask));
+					       rule->mask));
 	default:
 		return 1;
 	}
 }
+
+static bool audit_rule_counts_syscalls(const struct audit_krule *rule)
+{
+	switch (rule->listnr) {
+	case AUDIT_FILTER_USER:
+	case AUDIT_FILTER_EXCLUDE:
+	case AUDIT_FILTER_FS:
+		return false;
+	default:
+		return true;
+	}
+}
+
+void audit_rule_account(const struct audit_krule *rule)
+{
+	lockdep_assert_held(&audit_filter_mutex);
+
+	if (audit_rule_counts_syscalls(rule))
+		audit_n_rules++;
+	if (!audit_match_signal(rule))
+		audit_signals++;
+}
+
+void audit_rule_unaccount(const struct audit_krule *rule)
+{
+	lockdep_assert_held(&audit_filter_mutex);
+
+	if (audit_rule_counts_syscalls(rule))
+		audit_n_rules--;
+	if (!audit_match_signal(rule))
+		audit_signals--;
+}
 #endif
 
 /* Common user-space to kernel rule translation. */
@@ -943,17 +975,6 @@ static inline int audit_add_rule(struct audit_entry *entry)
 	struct audit_tree *tree = entry->rule.tree;
 	struct list_head *list;
 	int err = 0;
-#ifdef CONFIG_AUDITSYSCALL
-	int dont_count = 0;
-
-	/* If any of these, don't count towards total */
-	switch (entry->rule.listnr) {
-	case AUDIT_FILTER_USER:
-	case AUDIT_FILTER_EXCLUDE:
-	case AUDIT_FILTER_FS:
-		dont_count = 1;
-	}
-#endif
 
 	mutex_lock(&audit_filter_mutex);
 	e = audit_find_rule(entry, &list);
@@ -1007,13 +1028,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 			      &audit_rules_list[entry->rule.listnr]);
 		list_add_tail_rcu(&entry->list, list);
 	}
-#ifdef CONFIG_AUDITSYSCALL
-	if (!dont_count)
-		audit_n_rules++;
-
-	if (!audit_match_signal(entry))
-		audit_signals++;
-#endif
+	audit_rule_account(&entry->rule);
 	mutex_unlock(&audit_filter_mutex);
 
 	return err;
@@ -1026,17 +1041,6 @@ int audit_del_rule(struct audit_entry *entry)
 	struct audit_tree *tree = entry->rule.tree;
 	struct list_head *list;
 	int ret = 0;
-#ifdef CONFIG_AUDITSYSCALL
-	int dont_count = 0;
-
-	/* If any of these, don't count towards total */
-	switch (entry->rule.listnr) {
-	case AUDIT_FILTER_USER:
-	case AUDIT_FILTER_EXCLUDE:
-	case AUDIT_FILTER_FS:
-		dont_count = 1;
-	}
-#endif
 
 	mutex_lock(&audit_filter_mutex);
 	e = audit_find_rule(entry, &list);
@@ -1058,14 +1062,7 @@ int audit_del_rule(struct audit_entry *entry)
 	if (e->rule.exe)
 		audit_remove_mark_rule(&e->rule);
 
-#ifdef CONFIG_AUDITSYSCALL
-	if (!dont_count)
-		audit_n_rules--;
-
-	if (!audit_match_signal(entry))
-		audit_signals--;
-#endif
-
+	audit_rule_unaccount(&e->rule);
 	call_rcu(&e->rcu, audit_free_rule_rcu);
 
 out:
@@ -1429,6 +1426,7 @@ static int update_lsm_rule(struct audit_krule *r)
 			list_del(&r->rlist);
 		list_del_rcu(&entry->list);
 		list_del(&r->list);
+		audit_rule_unaccount(r);
 	} else {
 		if (r->watch || r->tree)
 			list_replace_init(&r->rlist, &nentry->rule.rlist);

-- 
2.43.0

