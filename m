Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F7302CDC
	for <audit@vger.kernel.org>; Wed,  5 Nov 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338992; cv=none; b=gQiRkOLfBjsQ3Ht0VM71CZhrwM3f4P7+wh8mIHBNA/r8iFJ6LB0YHHnDyOM7YD1mZwAcZfdqVurSgkv19nXy7JVW8WSjPwztaXFjzAGPGUldFpfeFUAHT5KUzn9sDTg8uD1H+A58OPCMj2r3Jrl7+jpAcT1Mhy6zg+sUZrSqWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338992; c=relaxed/simple;
	bh=KhVQYgtLy/lZjMJVc/kTtZFYjzRY898BO4FylZpxBuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paMpXr8HurcB5CCB5/BEtzzd330sLtf4PgIzGH2fVQCnL8ST4tmzt7Uv2wLbI8KsnTS3KWtDcxeA/gz8O9Z2R868q/q+rfPmXCDLb+ocXtVreaAibfTuE8shrTdaqF/up8C8eJ6HRE+fWuGNiaexQSdZvieE5w+iAsODRp6pgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cwpMi1qx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cwpMi1qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tZ
	tXPz8G8Ta+6xYtNjx6aED98awUEA6hqIPRhy6FCGY=; b=cwpMi1qxwUyUHANhHF
	Q/Xpl56TE2Z15MPmoC1YhiXa6XHXdFHErF65W3UIrLdTT18qbLZ/Y30I2PJV+RUd
	VoRA3BbX1S587xyHNAAG14y3lmws6BWnBzNOmBxxgWAc57KEz6ojOfLbADCewBOP
	arHLQ+35mK7O73lGXGuCRXrzQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD39wSEKAtpS1hWBw--.11801S2;
	Wed, 05 Nov 2025 18:35:49 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: audit@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] audit: Use kzalloc instead of kmalloc/memset
Date: Wed,  5 Nov 2025 18:36:19 +0800
Message-Id: <20251105103619.110504-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD39wSEKAtpS1hWBw--.11801S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr48tF1DXw4rGFyDKr4kJFb_yoWfKFg_ZF
	WIqr1qkF4jyF10vw45Gay3uFsIva40kr4fCa4YvFy5Xw1kGw4Sg348ZrWa9rZrXrWktFsx
	uw1DCrnrKa13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUewa93UUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXAT8umkLH9zbDgAAsq

From: Gongwei Li <ligongwei@kylinos.cn>

Replace kmalloc+memset by kzalloc
for better readability and simplicity.

This addresses the warning below:

WARNING: kzalloc should be used for data, instead of kmalloc/memset

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 kernel/auditfilter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index f7708fe2c..db014d724 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -638,10 +638,9 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 	void *bufp;
 	int i;
 
-	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
+	data = kzalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
 	if (unlikely(!data))
 		return NULL;
-	memset(data, 0, sizeof(*data));
 
 	data->flags = krule->flags | krule->listnr;
 	data->action = krule->action;
-- 
2.25.1

