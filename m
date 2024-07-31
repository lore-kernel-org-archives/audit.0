Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB21495E5;
	Wed, 31 Jul 2024 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412013; cv=none; b=Y5XEwIckua1RY8hEHyvabCHFEUQztl+IvSZ6TLeJ+btkiJFXQcnb2E3wiBKroWpVbo1pCwASlAYsyj0j5q/SIjUi3MdLa7+fcUpoNS4W0VmaIyrvZQDfmAO+Fi5leTmyZSD9an5CXSuQvSCkdSkXJJl97FcyBTHLpOsiOmRkTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412013; c=relaxed/simple;
	bh=KJI3Yr47uV0b5qmsBI4d5HraZ9Wxicq8mtuB/V+h5/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnxsCUcclyA972OwosX25Bw8/vtR7ogRytK0Iw8LzZoSdAMH/0om2XKG3tK3R+UIucx3A5WRylLsulK6V9WslQgOkRQisK6iPZw75m14la4EHcLIuc0ZhLaP7vEKA6rs9wYZW68cJVTywS/D2Y9IHxlXwxkcMSAVwFBmXRKk5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYkgd5vcSzxVxk;
	Wed, 31 Jul 2024 15:46:37 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F7D3180104;
	Wed, 31 Jul 2024 15:46:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 15:46:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul@paul-moore.com>, <eparis@redhat.com>, <audit@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] audit: Use strscpy instead of memcpy when copying comm
Date: Wed, 31 Jul 2024 15:52:25 +0800
Message-ID: <20240731075225.617792-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

There may be random garbage beyond a string's null terminator, memcpy might
use the entire comm array. so avoid that possibility by using strscpy
instead of memcpy.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/auditsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..e4ef5e57dde9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &context->target_sid);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	strscpy(context->target_comm, t->comm);
 }
 
 /**
@@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getsecid_obj(t, &ctx->target_sid);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		strscpy(ctx->target_comm, t->comm);
 		return 0;
 	}
 
@@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
-	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
+	strscpy(axp->target_comm[axp->pid_count], t->comm);
 	axp->pid_count++;
 
 	return 0;
-- 
2.34.1

