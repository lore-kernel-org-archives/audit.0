Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D527874F;
	Tue, 21 Jul 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606473; cv=none; b=XqJ+vMuNvk8ia0qVmBKYIpo2l7GhMaR8Qy+S+6IANzL1Y5vbQzTI5lW7v/22Kexeb0oG04gLPLrHLBSwMGkIGQagcHWK3sPirp6g1Zmo1W0lM9+17UBcazZIS2odNqBad5ISR+Z3dHclCAGgMvzkASFHQKLqdI1WiHqHCwGLs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606473; c=relaxed/simple;
	bh=9NHtO84qr8LqCwqTMBmoKHZH5mUKRBu4BSGgop3buUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGTzZ15NF22hhl5m/QRT+cnTHeL38UeuIzpZv9Xmt6VcJ9jRfI7s1Fb6eB6bS3EmKvNmp6NLVq8T9QSMf6hG6ZCSfeMmepdGlY4wYNojFHO8MLH5k32KQFWNK0lv3LIkPVQEvrl/x0/1eeFwX0LdS5YowC5ldY3MZjk3Flg24vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1R1xf5HM; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1R1xf5HM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3lXJWOeqtWySY6sVozUtCxie+D0dp+1VeooOzwOiea4=;
	b=1R1xf5HM27V0nbU2Td2B4GiiS/eKcmB42xVkU9kzYSgQnTqAHMdXTmC+ViNpAmAXJuwE9OYK+
	iiBEaOMMQrgs7itcxYBCz/mZHp1By69jePZs+qqungiDXmEhK88GOoza0YbCLbvHpvObhmdseFy
	3RvrBOb4sHMIDJmJOUVJrrk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h43NK3QMwz1K96m;
	Tue, 21 Jul 2026 11:51:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D5FC40586;
	Tue, 21 Jul 2026 12:01:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jul
 2026 12:01:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul@paul-moore.com>, <eparis@redhat.com>, <tglx@kernel.org>,
	<audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] audit: Force audit_context() to be always inlined
Date: Tue, 21 Jul 2026 12:01:18 +0800
Message-ID: <20260721040118.1000554-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

commit 6f25517010dd ("entry: Rework syscall_audit_enter()") relies on
dead code elimination to remove the call to syscall_enter_audit() when
CONFIG_AUDITSYSCALL is disabled. However, with s390 GCC 13.4.0 +
CONFIG_KASAN, audit_context() is not inlined despite being marked
inline, causing an undefined reference to syscall_enter_audit().

Force audit_context() to be __always_inline to ensure the conditional
can be constant-folded and dead code elimination works correctly.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607181530.2nx8zb3J-lkp@intel.com/
---
 include/linux/audit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..d79df1b75e74 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -343,7 +343,7 @@ static inline void audit_set_context(struct task_struct *task, struct audit_cont
 	task->audit_context = ctx;
 }
 
-static inline struct audit_context *audit_context(void)
+static __always_inline struct audit_context *audit_context(void)
 {
 	return current->audit_context;
 }
@@ -623,7 +623,7 @@ static inline bool audit_dummy_context(void)
 }
 static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
 { }
-static inline struct audit_context *audit_context(void)
+static __always_inline struct audit_context *audit_context(void)
 {
 	return NULL;
 }
-- 
2.34.1

