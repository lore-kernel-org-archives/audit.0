Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792951C84CB
	for <audit@vger.kernel.org>; Fri,  2 Oct 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903837; cv=none; b=Mdd147qvdFeJDTWBY2pZmPUEVM7zN4/EWm+LlqU8I3JlNqZ087NdC2e9+ySSxXCcytAFtNisGORKcCN98ZnsKmh7rmv9qXpPWCDJ9lkgASSVUyVZfpfcPsWxqvimKrxjYW+biWJCNEQIeuUvLl8sNUX0npEGkSF636BszScDBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903837; c=relaxed/simple;
	bh=EUQpMp+HuBObEek7Ult8oxgw73nO1dLMx1OkhJCL4sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTXgWr2j8UAMZxIO6l6Nhj69DAIrTCi+ZfM8TZ9+Y1kQsjHTdj/xt2qxXS+/gOrR8clI3yBTkIowjj+2VfSJmJzSx220xLFFbhQZwmiz4IeKrad8vJo4uuEKaruLfo9GrTuzMJX8JLeAAmDu0eu3SjUhy1f9WamfhkFJSm/Q4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8vPwnXj; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8vPwnXj"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so3241022a91.3
        for <audit@vger.kernel.org>; Thu, 01 Oct 2026 18:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790903836; x=1791508636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oq9HxvdSXBzAJf/nprhhibhJaAVoDfA7xrnhjl8vR10=;
        b=p8vPwnXjPrkSFLPbf/KpCraKLe+44qdSEOEaBDSmP/P5a2i3b65lJNs+W7vMzw0fB5
         wA/OQyUY3rvmlRUx0AQg8cek7rC1VrVD96WU6KV+3aOMbvUMvhXqptKNuKhkCg3KZab2
         LWCcFWRFUiwYslVQ+RbfIopeAhAgkXAhyNaru73RGC5+QD02rlMLYbg9Jn9Bxnqgt8ZU
         IKMybKWVkfjiY+lgTI9PESiiKA47uVGhyaJh5t7beyZLL8UCyVuX8bsw4qUiUgCYXNmK
         a/Ut4vV012L1nTOIf/X7iFtomZ6NyuxpXKXZL+BfeqMpuqvDersRohoJeUcAWJ2T7yRi
         33bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790903836; x=1791508636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oq9HxvdSXBzAJf/nprhhibhJaAVoDfA7xrnhjl8vR10=;
        b=SZpY66qNZMkPnxxjCjCHw282at5MRowQpx5Ah0TRlldB9GEiUUEuJvADX7BoufLinX
         Ykd5/ZmPe36/0BJod7uPHcFx/z7uSZeF1pH55Y16dG73KRHA4m/Z3u6LVg/+B73EP3GI
         nfGBnF8MgAZ/IMvKXCSG5JAFiFHdbH1YLCtlKb5iSr3Rjo7cFWh7vdpk4BiStAq9ALPp
         xxrAmKf7kTZY9+FlOn1NGQwAKacxOZCx1VD+EwQHtQ9xbGAbYl/cVuTVHpDWmjRi2xT5
         ess4/92qVD1QhvzS5FRExms7NxFJBE6oJdeA93GwLPztpR17/UDQVNUzmDi6lwdyEejN
         yA6A==
X-Gm-Message-State: AFq9FYLUe1nBobUNk7HvqvR2iMUq56m4tg4x22XJs27Cq2ajcKttgzDa
	ZdYJSWb6XVKh9wM1xpQOPoBUslcHBIdPqQyl2iRJrR/E1n9qMmB0o3ZTNNavUyQ6
X-Gm-Gg: AYBFou308x4bAor/kWFl22mvosj07MW48pf0BfKb0U9QWSfPBASUDq8SQHM9DvWr/xa
	6+ZGmE7DD/xISVVDOa2x1N2Tsg7sFYVk71O3dS95+4gVJNcVGQfp/P+BRTc8+GLY2+naSsvIUFr
	0AGT5Qh0mo+ZJZ2YWuczBhTvlrpGsomTJaSZxU5JgFvb2ewtIlKAnwytzFrlfLjCVrX4c7i15Q+
	PPifQnZJMYzHw6JsU4GWMuCrGXtWcOOInhglTbXk8j4MrmJITuOMuogkqBdYYBpoENEtXEcYasb
	wwQqbNIb3QX+iyYP1w0H+zwFddGKTQoEOJXGFgdjXZtx6f8OVg+2Oy5NmjwSmuBVr9HNA0LfezW
	gnn89XCGQV5hJ3wNP8Err3XNpmGerEGLSHJjWEcXpCzQQLFnJMb/y8O2hfyHOrFE9Q/EbBMkHjb
	6a+CSsrutVVjP82M2bVoOymYmwyB/n7leokPK9oGDs2srqwJphke2fToZFOtQ5NWXaMNFaYg==
X-Received: by 2002:a17:90b:52:b0:3a4:97ea:f0da with SMTP id 98e67ed59e1d1-3a6cec1421emr1084529a91.17.1790903835882;
        Thu, 01 Oct 2026 18:17:15 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc92646sm1564066a91.1.2026.10.01.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 18:17:15 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Subject: [PATCH] audit: annotate the lockless read of the audit control lock owner
Date: Fri,  2 Oct 2026 01:17:12 +0000
Message-ID: <20261002011712.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_ctl_owner_current() reads the lock owner without taking the lock
and KCSAN complains about it. Only the current task can store itself as
owner, so the check can't give a wrong answer. Mark the accesses with
READ_ONCE() and WRITE_ONCE().

Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39b8fea0641107a1ccee
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
Paul, you looked at this race in 2022 and asked whether READ_ONCE()
was worth it and what it would cost:
https://lore.kernel.org/all/CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com/
Compile tested only (gcc and the KCSAN instrumentation diff); I could
not reproduce the race in QEMU.

 kernel/audit.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 631d6d4a23cfd..f8c43ac6d5b82 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -247,7 +247,7 @@ int auditd_test_task(struct task_struct *task)
 void audit_ctl_lock(void)
 {
 	mutex_lock(&audit_cmd_mutex.lock);
-	audit_cmd_mutex.owner = current;
+	WRITE_ONCE(audit_cmd_mutex.owner, current);
 }
 
 /**
@@ -255,7 +255,7 @@ void audit_ctl_lock(void)
  */
 void audit_ctl_unlock(void)
 {
-	audit_cmd_mutex.owner = NULL;
+	WRITE_ONCE(audit_cmd_mutex.owner, NULL);
 	mutex_unlock(&audit_cmd_mutex.lock);
 }
 
@@ -268,7 +268,12 @@ void audit_ctl_unlock(void)
  */
 static bool audit_ctl_owner_current(void)
 {
-	return (current == audit_cmd_mutex.owner);
+	/*
+	 * Lockless read: the owner can only equal current if current set
+	 * it, so another task changing the owner concurrently can never
+	 * make this return the wrong answer.
+	 */
+	return (current == READ_ONCE(audit_cmd_mutex.owner));
 }
 
 /**

base-commit: a8bdcf944504980635c2069b4a4cfcf677b09bbb
-- 
2.43.0

