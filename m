Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02C245005
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064512; cv=none; b=tEkcopGFCMtTWnw/RohqPjyEJa2oj9gnqjiKN8C6EGNez6AsnlQ/fFafCC8rOCZWUbXPuAwPbOZ9mk1AwQTUALFyP1IK5TelKR5KH5fJVpZwViwp6Hhp8//CL8LZ9Q140hUXgoY6ApeH9kMnSBNyjYwJ6apQbmpNlOGsFgng510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064512; c=relaxed/simple;
	bh=e3tkQE+YfKX/7hZDZzcdQK5NFYbWS59J0EjRsKa+l6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVMmvgEBru/ErgBMtgUtlQD3lN1c3WPzqdG3KyKH1wo+2jCzj6IqW5EUjnAZyulySr8lk3u/ydo6oGf2M1x6MwdoBVkP6wWhhVbUeaaMxnaMnx+81ZpGVEGAPjheGstcw5wlIwV0ncsySiuGrJ+D4TWvu3rMw580aye5RHh8rKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+eey9fw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+eey9fw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceab75934dso37116865ad.2
        for <audit@vger.kernel.org>; Thu, 06 Aug 2026 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786064510; x=1786669310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GuggX/pXpjezOWD83mhX4lKeZfHohXlOyI+wXNFtAk=;
        b=h+eey9fwxi+V93EUzrsV4bTAv59EmiMKeTb+hauLbQMLlbxJFjQlo8NKDCaU1qhtK8
         MxvWnTi2wRJr3awiP4BODR3nBZmBESGX43Qvx4VfYDn4b2ezhnHKhc2DSZlThEibiczk
         E9mppli2ooyF8w/iONpnZ/CoaC80tlcpLPLeJIuPBRfaD0LRbD0EDZsXyGRTvsZmItwp
         0qCqLd/gYeQpD7ep7zivA9KaL0GZYgx3lm2rhKm4F/hVvPMtLSoYfLWwNwRahfLasrW1
         PbZ07mxi+r4+tmvUrRvGAOsilMEsLvbjOCsJooxquO2Ff5KrEZ9oAmEjCrvjnnJ7fMB/
         Oh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786064510; x=1786669310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GuggX/pXpjezOWD83mhX4lKeZfHohXlOyI+wXNFtAk=;
        b=tVORWLzaDgjobbKT7TnntU+pDlTxg6mgesSiTO+qz+m6jv1gu+tYvOlcugWV1DRP9o
         SBIRt5hG3kVA0EyKaFDjaDvHss1Ffh0HUFVcyhVz9z69cMFZM4L/qbalKVtJywl1IlfR
         BPcars5/J3auc+mdYdniWDyvqrExOLptbFyp6kFbEy6LxBmK03CfbHaPzts8g/UpixZk
         nxdqa6r0kxvOj8KX9kd4e4nvaLQ7xtgFJjydt2kZxJY+GJ/7CHug5KmODQpub8621/dD
         By62J9ip2SDGM+Rx0RrG63pRafEpW2PAZ8cc7juXN+6drQDA5Od2QPcR2AQwrNO9PwOs
         5FTg==
X-Forwarded-Encrypted: i=1; AHgh+RpItJdgrzgYvhd88HsfMi0N4ToDFvTOEEaRa9G90NsojP7zsrYVzkWIskSMrmc2EHQcU4ECjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFRz3PO5w0UUrnuv+MRxerRvDtMTqTT4H5Mkbo0l6hOzNt3Wo
	vzfu5Lt0v87PNC45mCtMFXvSYOpTB8ggmuXIM7nIlDkqpz1qQhcDbuFB
X-Gm-Gg: AR+sD13/hXWeTlPDX0UMacEWY6hlFG8VW/Ub6TEL1gRDRku7w9gqjxVD11shN/9g69j
	LBOz/ZEMK+/6iUamBYu5M/2CCTrrSc/E43LqqttV8snIEkRlZbW8K2zAQiM/8JUpLP9Cv+bf1l/
	vWyytD3p/XPw+2Q9I72EotofH6QPAkXqP8CXx6xPHIMp2eeV0Q8owEjiHU8Mt7Wq+argkYo++iq
	+q9dmtToTxfOK22JhaKrd4+wG8JjRFAREE9cAA54x71UYcnd604a9S4cUsaTVkbN0Ii32NgYoAM
	nct70xpxybZnj4s+swjUVoFsvihv2jzU1vMKhBXkIx2TnueL2a4aGNSczsgFkAbmDpWCMKcwHq8
	9Ja7cHeVCfnMd/Rvg8XLIvt0Na43lCLueHclOkbJVMTcm8Gw2fYxUQVnI1QJmXiiG5NTskvgagY
	i+cFRhcVfNrdyzUqthOIiYWTJ5jFSFr0AOIlSrFaPVKhwMvnzX+y5VVcbfQfa2tJFbLhb5ORJfv
	SlKNFimDDHPXzFAdnFYqzkppJsGrioRcXQ=
X-Received: by 2002:a17:903:3903:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2d0ca751829mr238604445ad.12.1786064510270;
        Thu, 06 Aug 2026 18:01:50 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d7684f8sm1527725ad.33.2026.08.06.18.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:01:49 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 06 Aug 2026 18:01:21 -0700
Subject: [PATCH 3/3] audit: Skip exit filtering for syscalls without rules
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-audit-v1-3-ddd0d94ff0b6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786064505; l=6780;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=e3tkQE+YfKX/7hZDZzcdQK5NFYbWS59J0EjRsKa+l6A=;
 b=ZMDRwz8bBqyYWgD3Q0qo1HzxvjISmiQACD7mFn+6I5wORtD8tvXa3RCk0xAGAEnnvk8T1PzpM
 +mRyyD6NR7eDDTiB5KRKHplILEfKVW5OGb/MzUHPSpz67XvgfkvIORj
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

Audit walks every exit filter rule for each audited syscall, even when no
rule contains the current syscall number. Policies with many unrelated
rules therefore add linear overhead to otherwise uninteresting syscalls.

Maintain a reference count for each syscall bit present in exit filter
rules and derive an aggregate interest mask. Update the mask through the
centralized rule lifecycle helpers, which cover explicit and automatic
rule removal. Use the mask as a lockless rejection test before entering
the exit filter RCU traversal.

The mask is architecture-independent. Syscall number overlap between
architectures can cause an unnecessary scan but cannot suppress a match.

The aggregate bit must be set before list_add_rcu() publishes a new rule.
Otherwise, a reader could observe the rule after publication while the
aggregate mask still rejects its syscall. Move audit_rule_account()
before the list insertion to provide this ordering. Rule removal already
uses the inverse safe ordering: it unlinks the rule before clearing the
aggregate bit, so a concurrent reader can only perform an unnecessary
scan, not miss a rule.

To measure the effect, install increasing numbers of distinct statx rules
in a disposable VM and benchmark the unrelated getpid syscall after each
set is installed:

  for nr_rules in 1 32 128 256; do
          auditctl -D
          for uid in $(seq 1 $nr_rules); do
                  auditctl -a always,exit -F arch=b64 -S statx \
                           -F uid=$uid
          done
          audit_bench
  done

Without this change, the same unpinned VM produced:

  1 rule:
    median=55 ns/op
  32 rules:
    median=71 ns/op
  128 rules:
    median=428 ns/op
  256 rules:
    median=791 ns/op

With this change, it produced:

  1 rule:
    median=55 ns/op
  32 rules:
    median=55 ns/op
  128 rules:
    median=55 ns/op
  256 rules:
    median=55 ns/op

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 kernel/audit.h       |  2 ++
 kernel/auditfilter.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c     | 13 ++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 3176da464843..afcbdecc917c 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -272,6 +272,8 @@ extern void audit_put_tty(struct tty_struct *tty);
 /* audit watch/mark/tree functions */
 extern unsigned int audit_serial(void);
 #ifdef CONFIG_AUDITSYSCALL
+extern u32 audit_exit_filter_mask[AUDIT_BITMASK_SIZE];
+
 void audit_rule_account(const struct audit_krule *rule);
 void audit_rule_unaccount(const struct audit_krule *rule);
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 38a56278ae0b..55ab9d05fafd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -196,6 +196,54 @@ int audit_match_class(int class, unsigned int syscall)
 }
 
 #ifdef CONFIG_AUDITSYSCALL
+/*
+ * The mask provides a quick rejection test for syscalls which cannot match an
+ * exit filter rule.  The counters and mask updates are protected by
+ * audit_filter_mutex; the mask is read locklessly in the syscall exit path.
+ *
+ * The mask is intentionally architecture-independent.  Syscall number
+ * overlap between architectures can only cause an unnecessary filter scan.
+ */
+u32 audit_exit_filter_mask[AUDIT_BITMASK_SIZE] __read_mostly;
+static unsigned int audit_exit_filter_count[AUDIT_BITMASK_SIZE * 32];
+
+static void audit_exit_mask_update(const struct audit_krule *rule, bool add)
+{
+	unsigned int bit, index, word;
+	u32 mask, rule_mask;
+
+	lockdep_assert_held(&audit_filter_mutex);
+
+	for (word = 0; word < AUDIT_BITMASK_SIZE; word++) {
+		mask = READ_ONCE(audit_exit_filter_mask[word]);
+		rule_mask = rule->mask[word];
+		if (!rule_mask)
+			continue;
+		while (rule_mask) {
+			bit = __ffs(rule_mask);
+			index = word * 32 + bit;
+			if (add) {
+				if (!audit_exit_filter_count[index]++)
+					mask |= BIT(bit);
+			} else if (!--audit_exit_filter_count[index]) {
+				mask &= ~BIT(bit);
+			}
+			rule_mask &= ~BIT(bit);
+		}
+		WRITE_ONCE(audit_exit_filter_mask[word], mask);
+	}
+}
+
+static void audit_exit_mask_add(const struct audit_krule *rule)
+{
+	audit_exit_mask_update(rule, true);
+}
+
+static void audit_exit_mask_remove(const struct audit_krule *rule)
+{
+	audit_exit_mask_update(rule, false);
+}
+
 static inline int audit_match_class_bits(int class, const u32 *mask)
 {
 	int i;
@@ -249,6 +297,9 @@ void audit_rule_account(const struct audit_krule *rule)
 {
 	lockdep_assert_held(&audit_filter_mutex);
 
+	if (rule->listnr == AUDIT_FILTER_EXIT)
+		audit_exit_mask_add(rule);
+
 	if (audit_rule_counts_syscalls(rule))
 		audit_n_rules++;
 	if (!audit_match_signal(rule))
@@ -259,6 +310,9 @@ void audit_rule_unaccount(const struct audit_krule *rule)
 {
 	lockdep_assert_held(&audit_filter_mutex);
 
+	if (rule->listnr == AUDIT_FILTER_EXIT)
+		audit_exit_mask_remove(rule);
+
 	if (audit_rule_counts_syscalls(rule))
 		audit_n_rules--;
 	if (!audit_match_signal(rule))
@@ -1018,6 +1072,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 			entry->rule.prio = --prio_low;
 	}
 
+	audit_rule_account(&entry->rule);
 	if (entry->rule.flags & AUDIT_FILTER_PREPEND) {
 		list_add(&entry->rule.list,
 			 &audit_rules_list[entry->rule.listnr]);
@@ -1028,7 +1083,6 @@ static inline int audit_add_rule(struct audit_entry *entry)
 			      &audit_rules_list[entry->rule.listnr]);
 		list_add_tail_rcu(&entry->list, list);
 	}
-	audit_rule_account(&entry->rule);
 	mutex_unlock(&audit_filter_mutex);
 
 	return err;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2b9ce0b52511..ff1809df63df 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -861,6 +861,16 @@ static void audit_filter_uring(struct task_struct *tsk,
 	rcu_read_unlock();
 }
 
+static inline bool audit_exit_filter_may_match(unsigned long syscall)
+{
+	u32 word;
+
+	if (syscall >= AUDIT_BITMASK_SIZE * 32)
+		return false;
+	word = AUDIT_WORD(syscall);
+	return READ_ONCE(audit_exit_filter_mask[word]) & AUDIT_BIT(syscall);
+}
+
 /* At syscall exit time, this filter is called if the audit_state is
  * not low enough that auditing cannot take place, but is also not
  * high enough that we already know we have to write an audit record
@@ -872,6 +882,9 @@ static void audit_filter_syscall(struct task_struct *tsk,
 	if (auditd_test_task(tsk))
 		return;
 
+	if (!audit_exit_filter_may_match(ctx->major))
+		return;
+
 	rcu_read_lock();
 	__audit_filter_op(tsk, ctx, &audit_filter_list[AUDIT_FILTER_EXIT],
 			NULL, ctx->major);

-- 
2.43.0

