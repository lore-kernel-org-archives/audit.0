Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945F198E74
	for <audit@vger.kernel.org>; Fri, 29 Nov 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874186; cv=none; b=GL7O7GFKRZ2rag8CEruIaAG3LfJb9txbQjOGRINzYl8+lduWUEJ4oGM08d9yml2/GbeF52l37WcShtn9olIleDoiry1utC8Bp3ate+fplbSphmnSJ43o+vyDU4jxbiM31FX05GwvYYtwnnPbP+zMo7rlHNll9Dtwtzf5XohrDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874186; c=relaxed/simple;
	bh=h37FQeWqEAfYDoNzAEiN61QOTKLR9s1TA0+T5JaWMVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O85pEgYlKX/Emefm9aLmgCb/Txi//ham/I5a3KvkVTzL0Sb44ZiVGcixMI8Y+CWq0LTUFfIEYfYxDXCY1bOTo8VCaKRRt8Jf1icxwcaBQXXZFc2J4A42BZ19DMW3HZ00uePA+uEbSfaNlu5v30t7+0p/lC5Z28C8rAldPsO2TSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IcOjIJLR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IcOjIJLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HStnT
	OZHnW8G3VwSWyU2OLVzOmApbcEaPS8zDDtrIno=; b=IcOjIJLRoKKl8jrYf9i4h
	eWzwoMYTWNxtJDCh0y6rRNF1164DzFSgkvuS1s1wLNgFMlIed/sAI+v+zsmlp3Xi
	zz/hBFlYMMrfVma7aUl/pgE6pxq4p3tOzjjHFQi12cAd4LkwqJzC2BTc8VruDukl
	keGKAXYXOHqA6GKuPO8UOo=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB35QK6j0lnmmZsFQ--.44405S2;
	Fri, 29 Nov 2024 17:56:11 +0800 (CST)
From: 15074444048@163.com
To: audit@vger.kernel.org
Cc: lihaojie <lihaojie@kylinos.cn>
Subject: [PATCH] kernel/audit: Use struct_group() for memcpy() region
Date: Fri, 29 Nov 2024 17:56:14 +0800
Message-Id: <20241129095614.1614637-1-15074444048@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB35QK6j0lnmmZsFQ--.44405S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13tF17JrWfKw4xAryUGFg_yoW8uryUpF
	n8CayDGrW7JFy8Ar48AF4kuryYqw1rGw13GF93Jw1fAr98trykKF48KF47Was0y3WF9r92
	9FsYvayaywsrJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVv38UUUUU=
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiLhWmUGdJi5N53gAAsc

From: lihaojie <lihaojie@kylinos.cn>

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct audit_context around members target_comm[],
This will allow memcpy() and sizeof() to more easily reason about sizes,
improve readability, and avoid future warnings about writing beyond the
end of target_comm[].

"pahole" shows no size nor member offset changes to struct vlan_ethhdr.
"objdump -d" shows no object code changes.

Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---
 kernel/audit.h   | 5 ++++-
 kernel/auditsc.c | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..20483670ea02 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -145,7 +145,10 @@ struct audit_context {
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
 	struct lsm_prop	    target_ref;
-	char		    target_comm[TASK_COMM_LEN];
+
+	struct_group(comm,
+		char target_comm[TASK_COMM_LEN];
+	);
 
 	struct audit_tree_refs *trees, *first_trees;
 	struct list_head killed_trees;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 91afdd0d036e..e279762463b0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2729,7 +2729,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getlsmprop_obj(t, &context->target_ref);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	memcpy(&context->comm, t->comm, TASK_COMM_LEN);
 }
 
 /**
@@ -2756,7 +2756,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getlsmprop_obj(t, &ctx->target_ref);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		memcpy(&ctx->comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
 
-- 
2.25.1

