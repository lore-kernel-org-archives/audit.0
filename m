Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93C188733
	for <audit@vger.kernel.org>; Thu,  5 Dec 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380257; cv=none; b=D3o5zulA6ox7NhtiDjJi7MhBi/OUIlC8ZVUBly+KG0JLB7bdWfneQMEISZNPomFD3MLi7dKZmr9Fs3hxixRyR7WwE5o2zPye0tJ01bKkcbjzhTBPIleNBhdifd07WLKIhkYcY+x1QzteO5UTQLPlTaCl474LUuhq7R6P6ni5OrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380257; c=relaxed/simple;
	bh=Fm9YrXRysYXyDfff3Ci+cfubWw//QL7Mco9SPMG9zHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wjmwfi0gvWIvp8sD48/H3n4iSfcaNY3tlfa+tNQ52cq3NgdT5AU5w/Va/xtiBy7yyKqbgsya9/o8ivHNrITLSX1tj0Nbp1B4nip0Ked0Qu7pWLLMns6oEwOVTJjXQAPv3IIJXVmibRGynXiSWNLTo1KtjufwCHNqrEwKDmyi2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dstoax3H; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dstoax3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EI71h
	sm/eCwWFydS1jrp4j5+TkQYohrvk27pq7qwnJk=; b=dstoax3HIRZJx2YwFqGda
	2WBAPX0YIRhKArhy/RBuymtDYHX69aLrZ+7jltyM16kV35ZET3BilMYOzMz4iTOs
	ejhdrP5AUfRI1vqNpOLjtsf1nOSXlwpVOu7yqkzwwjsDYzBUkTZYtmtGIgL6wnMC
	4idhYQWRtZdRoqb0UtUjGI=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3vTB4SFFnbhQ8DA--.41687S2;
	Thu, 05 Dec 2024 14:30:17 +0800 (CST)
From: 15074444048@163.com
To: audit@vger.kernel.org,
	paul@paul-moore.com,
	eparis@redhat.com
Cc: 15074444048@163.com,
	lihaojie <lihaojie@kylinos.cn>
Subject: [PATCH v2] kernel/audit: reorder the member of audit_context
Date: Thu,  5 Dec 2024 14:30:23 +0800
Message-Id: <20241205063023.744685-1-15074444048@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHC9VhQwifyzueutyzy56D-G=7erf6KK=r__B9RWJY04fN3dJA@mail.gmail.com>
References: <CAHC9VhQwifyzueutyzy56D-G=7erf6KK=r__B9RWJY04fN3dJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vTB4SFFnbhQ8DA--.41687S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1DZrWkZw15KF4DCFy8Xwb_yoW5Gr4rpF
	4fGa1DKFsrJrZ3Z34xArs7WryY9w18Gw43GFyfJw1fAr98tFy7KF17Ka13uF98ZFWrur17
	XFsYva4FyanrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULmR8UUUUU=
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiMQisUGdRQYfdHwAAs3

From: lihaojie <lihaojie@kylinos.cn>

Adjust the positions of target_ref and target_comm to
reduce their direct proximity. This can prevent the memset
operation on target_ref from potentially affecting target_comm

The compiler's static analysis tool considers that the memset
operation might affect the adjacent struct member target_comm,
potentially causing subsequent writes to target_comm to exceed
its boundaries. Even if an overflow does not actually occur,
the compiler may issue a warning because it cannot fully
determine the safety of the operation.

Verification:
- "pahole" shows no size nor member offset changes to struct audit_context.
- "objdump -d" shows no object code changes.

Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---
 kernel/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..77c140228a4a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -144,8 +144,8 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	struct lsm_prop	    target_ref;
 	char		    target_comm[TASK_COMM_LEN];
+	struct lsm_prop	    target_ref;
 
 	struct audit_tree_refs *trees, *first_trees;
 	struct list_head killed_trees;
-- 
2.25.1

On Tue, Dec 3, 2024 at 6:13 PM Paul Moore <paul@paul-moore.com> wrote:
>
> That's obviously a cut-n-paste error above, please fix that.
>
> You also sent this patch three times, that's very annoying, please
> don't do that in the future.
>
> Finally, can you provide a link with an explanation as to how the
> struct_group() union/annotations is the only way to do this?  It's
> kinda ugly and if there is another way to do this I would like to
> understand what it entails.

Hi Paul,

Thank you for your feedback.

That's obviously a cut-n-paste error above, please fix that.

- Corrected the verification section to refer to struct 
audit_context instead of struct vlan_ethhdr.

You also sent this patch three times, that's very annoying, please
don't do that in the future.

- This is my first time submitting a patch to the community, I 
will pay attention afterwards

Finally, can you provide a link with an explanation as to how the
struct_group() union/annotations is the only way to do this?  It's
kinda ugly and if there is another way to do this I would like to
understand what it entails.

- I found linux codebase change, memcpy() change to strscpy() in 
audit_ptrace(), struct_group() cannot pass parameters to strscpy()
so i submit patch v2, please check above.

