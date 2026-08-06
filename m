Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1144A40F
	for <audit@vger.kernel.org>; Thu,  6 Aug 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047383; cv=none; b=U2FgK4U4QC39c/zDR5jV75aV1AgIS2UP4JqDMbk26ZwJmoQ9q0u5gNhkOARWido/q5A73tH+vrKlruyKu5TGb86zDxcsJAajG2KgBfROY2uNiL5B659RPgf8A8LlcW9iVSXmokWWzWLx060I6lJQx4OO80iKglel6XHeVy3wZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047383; c=relaxed/simple;
	bh=iO3qoa9nWB6AZNwYVsc67efJhEGt5zYcjAApR0Or+DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vrpp6eJzqFwP/H4Od4Vg87QtSg9LC3Ax0kSLY1m++rbYSD/bheTvg7nNObgT6OEqa4FPglHWEz6yWBKUAMsmEn5BtLCV71QBLJ9vuwPHLaEbehlju55P9veiP3UmDOtYxrUtoiAOefeAr+30CiBNlqMAeB0Yaw/vVO/AS/zE0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FF+lkBZb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FF+lkBZb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495509b08ebso1185e9.1
        for <audit@vger.kernel.org>; Thu, 06 Aug 2026 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786047366; x=1786652166; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p2xgAL4A/uZNv8wN6KWA5a6qdPc39oZTmGCx5UXjDpo=;
        b=FF+lkBZbOP+S1pTX5Kz/5brx3NniubS2GwiFrhjkwJTJ9BBVbXhCOxa9WhiPGDz6mr
         AvMWePBwWVbtdy1vZ+LUtmO0sH3aZ5ueKytxSsLT8t0+w32mJJBlqoG9kPuAjWd5XHG4
         tISyxTCcb0ZGaNvoJfj2Aoa4Np2m2wpquwbJwjvs7FXCG1PwrsS7uc+/rMS9C45O7mw/
         jlnU6VqaguPcSIRci74xU84xYgCwHoJSg/BExa0onWcFEAvber5uQRT+AUy/e6aA3dim
         ZbiaEieeCdlnd8kWZJpZJ/oiPi4Hpp7yducQxHOXykR69eCEcVPy+p2a3oIWN7Ueih5z
         rcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786047366; x=1786652166;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p2xgAL4A/uZNv8wN6KWA5a6qdPc39oZTmGCx5UXjDpo=;
        b=aS+n9LxBIvrN+mFQaK7crhaA6SqDaC/bc0ahpYoDOfQ1GQjTZXN3TzecicivX293Th
         zd4PKniB6bDRlBYjNGMu1bv13p/D7fm3X/DOnc2THIo99EX6SmHHWfXySF+xsbzIpVLW
         CEIWGvFb6Hk0CS7kKba4qnIw3dEHqnWymkug4S9CDR6HczggLRjVaqc6JgqadR8PGsu3
         vHY/f8fQC94wDkMjIMU2pB+36jupXpTUbF5mSgFd+uJiqQAxIZ3UyReZMLWOf9DZAGm+
         OFr9uTtQgmnf0NnA42Hmt+kcq9JzBgfekfTVjbEvwqoYArhljHaO83/AfpwRFwh50BGN
         u5Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpBdtcZhvG+xLB7fPK0Fjbc6VW0FOZMsrGho+XjpFqvMAg07cRq8jEsAS54gEtlmLIadaEOdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjaJX56C/OIiuNl6+VJYad89/KXpIuJrQqgjEkMLrNxFe2N8Aa
	4biUp+coJNQaKBMLI4PYTFn+WT6qcREkNbidJFyRd5Y5A0WzkMY2thlOlN//IMHxBQ==
X-Gm-Gg: AR+sD13Xr64ELEIDprbNujBP8kEKxTVCLBldI4clGmo896uORd40Tw4yjUr+w9OpJOQ
	ggwM4dsu0OnOJhVx8uvvmIiVj42di1zUkKZTJizlyT/1ejVSZ4Yk1Elw7ILQWwqgERpfQGkbAMM
	gDvmilEZqBlBK+FxiVb5bkHA02XZRLSpJhzPRiNRZWt8DU2vEj/bgr/UOPMugc8zd8q+VIFI4as
	LGaKsY3NdbZwcU1S8zEuF0e2zd5dMAo0FJWCn5IOsbF4I66Tnyb3JY26JDqn4bxzses7RWlPmb1
	qTgob8rEgkck3zR+qDoVDSxPo8eu7QfiG0ecSqYo1aPcVyecjzskcNt0/4oIddzkTeNVohi2KdL
	lUGeZuPsB02/zVR6bYsH9kvakjTeRHe9MkfmBqpBqAhx5zzPo823i3mbDciC6VLUKcpeO2guagM
	n1yLaRWsIoXsFo9t4tqGwGsmygoV5SdO4/BLB1V1VZDWx2qGiMybtDSy+gF9StjlFyokEnBvCBY
	fytChGHBMLVUn+QLw2aOYdZpMNeYkfz1bYj7lOj4Gc328+/
X-Received: by 2002:a05:600c:42d4:b0:495:5dad:b3de with SMTP id 5b1f17b1804b1-4995c0d3d01mr231515e9.10.1786047365829;
        Thu, 06 Aug 2026 13:16:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:8b80:1ac5:3668:4014])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bddfe99sm5333715e9.3.2026.08.06.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:16:04 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 06 Aug 2026 22:15:54 +0200
Subject: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
X-B4-Tracking: v=1; b=H4sIAHnrdGoC/yXMQQrCQAyF4auUrA2kU2nFq4iLmWnUuMhIZipC6
 d0bdfk/eN8KlU24wrlbwfgtVYp69IcO8iPqnVFmbwgURjrRiNl4Ri1qecGoWlpsfsGbfDAmStM
 xTGnoCRx4Gfv8wy/Xf9clPTm3rwjbtgMkpm5XfgAAAA==
X-Change-ID: 20260806-cred-nonrcu-annotation-fix-ab0b7427b310
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, audit@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786047359; l=5431;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=iO3qoa9nWB6AZNwYVsc67efJhEGt5zYcjAApR0Or+DQ=;
 b=QQnAkpll9HVAsA3Opte32VlGPtYA1gGl6MA7NGuCOE+bn4PHJ0wkZPykjncJG5jZWlPWYu0y2
 sobJ58CChMKCcuZgyPl5A4070j8y050n4YLr6QgjzaFunlVNC45Bd2E
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The `cred` field in task_struct is currently marked as __rcu, but that's
not true: It can point to credentials from access_override_creds(), which
do not get freed with RCU delay.

What actually protects task_struct::cred is that accessing it is only
permitted for the current task (except for setting up a child during fork()
or tearing down a dead process).
(There is currently code in Smack that violates this rule, but that's a bug
and causes UAF, I have sent a separate fix for that.)

Clarify this, remove the __rcu marker, and remove RCU helpers from all
accesses to this field.

Signed-off-by: Jann Horn <jannh@google.com>
---
For context:
There have been at least two UAFs of struct cred that I'm aware of, both
caused by wrong use of task_struct::cred:

 - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db7
 - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26@google.com/
---
 include/linux/cred.h  | 17 +++++++++++------
 include/linux/sched.h |  8 ++++++--
 kernel/auditsc.c      |  5 +++--
 kernel/cred.c         |  2 +-
 security/lsm_init.c   |  2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index c6676265a985..650aefd1416a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -180,12 +180,18 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 
 static inline const struct cred *override_creds(const struct cred *override_cred)
 {
-	return rcu_replace_pointer(current->cred, override_cred, 1);
+	const struct cred *old = current->cred;
+
+	current->cred = override_cred;
+	return old;
 }
 
 static inline const struct cred *revert_creds(const struct cred *revert_cred)
 {
-	return rcu_replace_pointer(current->cred, revert_cred, 1);
+	const struct cred *override_cred = current->cred;
+
+	current->cred = revert_cred;
+	return override_cred;
 }
 
 DEFINE_CLASS(override_creds,
@@ -293,11 +299,10 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 /**
  * current_cred - Access the current task's subjective credentials
  *
- * Access the subjective credentials of the current task.  RCU-safe,
- * since nobody else can modify it.
+ * Access the subjective credentials of the current task.
+ * Nobody else can modify it.
  */
-#define current_cred() \
-	rcu_dereference_protected(current->cred, 1)
+#define current_cred() (current->cred)
 
 /**
  * current_real_cred - Access the current task's objective credentials
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d1..6f489c2cf5ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1163,8 +1163,12 @@ struct task_struct {
 	/* Objective and real subjective task credentials (COW): */
 	const struct cred __rcu		*real_cred;
 
-	/* Effective (overridable) subjective task credentials (COW): */
-	const struct cred __rcu		*cred;
+	/*
+	 * Effective (overridable) subjective task credentials (COW).
+	 * Only accessible for the current task and during task creation/freeing.
+	 * This pointer is not managed by RCU!
+	 */
+	const struct cred		*cred;
 
 #ifdef CONFIG_KEYS
 	/* Cached requested key. */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..646145a66196 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -459,7 +459,7 @@ static int audit_field_compare(struct task_struct *tsk,
  *
  * If task_creation is true, this is an explicit indication that we are
  * filtering a task rule at task creation time.  This and tsk == current are
- * the only situations where tsk->cred may be accessed without an rcu read lock.
+ * the only situations where tsk->cred may be accessed.
  */
 static int audit_filter_rules(struct task_struct *tsk,
 			      struct audit_krule *rule,
@@ -476,7 +476,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 	if (ctx && rule->prio <= ctx->prio)
 		return 0;
 
-	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
+	WARN_ON(tsk != current && !task_creation);
+	cred = tsk->cred;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
diff --git a/kernel/cred.c b/kernel/cred.c
index 3df4e15bd67f..0bd6a58bc12d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -414,7 +414,7 @@ int commit_creds(struct cred *new)
 		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 
 	rcu_assign_pointer(task->real_cred, new);
-	rcu_assign_pointer(task->cred, new);
+	task->cred = new;
 	if (new->user != old->user || new->user_ns != old->user_ns)
 		dec_rlimit_ucounts(old->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	if (new->user_ns != old->user_ns)
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..1328a2ceef4b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -476,7 +476,7 @@ int __init security_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
+	if (lsm_cred_alloc((struct cred *)current->cred,
 			   GFP_KERNEL))
 		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))

---
base-commit: fcaeecb8b0cd44f77d03b28de0671258d4db18f8
change-id: 20260806-cred-nonrcu-annotation-fix-ab0b7427b310

Best regards,
--  
Jann Horn <jannh@google.com>

