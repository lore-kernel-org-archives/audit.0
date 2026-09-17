Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1159D628
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656041; cv=none; b=nnHqjiMZKEniEWiucJgi0mQZIr/KhBc7Wl6fshfQpUi99tPfYHs1FrSDEVLQU8WYZ6qtSb09E8gpUEbdg19nE3n2DEFRyyLBpSTqRpJ3P8B7E9xpbPTW+rKNQ3pn3W/zlldqGJseybQBVLFf92W5O40n7qn0dfRW5uDghwTNPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656041; c=relaxed/simple;
	bh=pk8WLMn53075doP6kt9Vb20wCZEhNKzH9OgPmH3M84k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5TOyjxj6cvqr6mtFPpRUbW0iVX03iAIQtFToVYSGt0SR9DW4Jk9qzf6ltynkuzFzcEYgk9E3+KOgxZ3mMqY+JI3QZ7kq4fksz4zEi7I1MbXUXmUySFkLGhZ8TSdXbMQpHpaqO3gvsq3C4/TEATPfz6/GidTEb+kkiSFwCAfvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t45AnhBH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t45AnhBH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789656023;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e6uikrgAGkZIIEpWfUoMeZBXfI608xl3cC+bL0ysVc=;
	b=t45AnhBHo2IEckk3ivRvecDBEGd5xMa92x8bpo24DIemvLQbLY9Te7XlxzLR3CE/8F6+pb
	7vEAKWKqpf41VLq1HHhsCV7qqbyZzJVLgIDNdlejXZ/+EOgfiNzyFo8TSiJq50+p35AJ0i
	lUTE2B1f4X9/1lS18Kn0WwbgTcCwLkcNxmzSwGg5zDOADn90OWO7OCf/L1Kjpw8fC/3itq
	yPYWig8bOIbrNcj/Lfq/LDZAaMQXHzRM/moAoZfc6lIsU22U7L07tlJ7uk+0SeH18NY1nq
	Q0uitmG8R6DCiFGsWxO7WVF4iTL5k6d7OvpbMhd0l4KeZSMRLW0W6MjV25QwhQ==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 4/4] audit: retain file paths for descriptor PATH records
Date: Thu, 17 Sep 2026 16:39:48 +0200
Message-ID: <20260917143948.106603-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-1-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

fchown() and the other audit_file() callers collect inode metadata but
emit name=(null), even though file->f_path is available.

Retain the path with balanced dentry and mount references, and use the
existing audit_log_d_path() formatter when no filename was collected.
Release references on context cleanup and entry reuse. Filesystem
exclusions continue to skip entry creation.

The name reflects d_path() at event emission: concurrent renames and
unlinks can affect it. Original lookup names retain precedence.

This adds sizeof(struct path) to each audit_names. With the preceding
capability and layout changes, audit_context grows from 880 to 960 bytes
on the tested x86_64 SELinux configuration and remains in the 1 KiB
kmalloc class. Other LSM configurations can have different object sizes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/audit.h   |  1 +
 kernel/auditsc.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index bd798f8553a0..ef8d25af18c8 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -76,6 +76,7 @@ struct audit_names {
 	struct list_head	list;		/* audit_context->names_list */
 
 	struct filename		*name;
+	struct path		fd_path;	/* owned audit_file() fallback */
 	u64			ino;
 	struct lsm_prop		oprop;
 	dev_t			dev;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b14765cdd56f..3d2f130bc0f8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -935,6 +935,7 @@ static inline void audit_free_names(struct audit_context *context)
 		list_del(&n->list);
 		if (n->name)
 			putname(n->name);
+		path_put(&n->fd_path);
 		if (n->should_free)
 			kfree(n);
 	}
@@ -1530,7 +1531,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 			audit_log_n_untrustedstring(ab, n->name->name,
 						    n->name_len);
 		}
-	} else
+	} else if (n->fd_path.dentry)
+		audit_log_d_path(ab, " name=", &n->fd_path);
+	else
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
@@ -2222,6 +2225,10 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	/* An entry can be reused for a different lookup or object. */
+	path_put(&name->fd_path);
+	name->fd_path = (struct path) { };
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
@@ -2358,7 +2365,15 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 
 void __audit_file(const struct file *file)
 {
-	__audit_inode(NULL, file->f_path.dentry, 0);
+	struct audit_names *n;
+
+	n = audit_inode_entry(NULL, file->f_path.dentry, 0);
+	if (!n)
+		return;
+
+	/* Resolve at event emission, so renames and unlinks can affect the name. */
+	n->fd_path = file->f_path;
+	path_get(&n->fd_path);
 }
 
 /**
-- 
2.55.0

