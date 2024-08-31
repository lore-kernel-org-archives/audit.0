Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35003C30
	for <audit@vger.kernel.org>; Sat, 31 Aug 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097486; cv=none; b=XPP4/LI+y9bjjL2mjNS0xiIKg9yyadQc3Qq8OHvgW0XbSGXsb1CmtOHFXTkSfhTq3g4IO1+DaMWGJXd0mS/xCzsV9sILS64CUeZo9vZNreouYAJ8ba7nQVKjYGjCFTJSncB6onMrPChBtWrEyr0u8uJo2BaPBTr5fv1/ofqK6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097486; c=relaxed/simple;
	bh=esh6EhYUkmbiQcaRS8VjEf8L4OFs7R2ZKWai+oqm718=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/WtxVfV/LtuV1S5JiclCowJuVWZYslJOT9m83z5XacU+hhIXFinrvHm5A64MXr4slp/6ZSjozT9ODcRLF5CdvVjT7BCXIizYZxvB8esNssjKwsehnIX5gpbcFhsShgkEndl/oXoABfxUAmCt/MBVAMs+6Dqkaawu0tFcRVDSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wwqq96S9pz1j7pT;
	Sat, 31 Aug 2024 17:44:21 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D67DF1A016C;
	Sat, 31 Aug 2024 17:44:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:44:36 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <paul@paul-moore.com>, <eparis@redhat.com>
CC: <lihongbo22@huawei.com>, <audit@vger.kernel.org>
Subject: [PATCH -next] audit: Make use of str_enabled_disabled() helper
Date: Sat, 31 Aug 2024 17:52:51 +0800
Message-ID: <20240831095251.4163011-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use str_enabled_disabled() helper instead of open
coding the same.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9f6b86acab62..1edaa4846a47 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1706,7 +1706,7 @@ static int __init audit_init(void)
 	audit_cmd_mutex.owner = NULL;
 
 	pr_info("initializing netlink subsys (%s)\n",
-		audit_default ? "enabled" : "disabled");
+		str_enabled_disabled(audit_default));
 	register_pernet_subsys(&audit_net_ops);
 
 	audit_initialized = AUDIT_INITIALIZED;
-- 
2.34.1

