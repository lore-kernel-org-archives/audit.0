Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE61E991B
	for <audit@vger.kernel.org>; Fri,  6 Feb 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409197; cv=none; b=efoPc5X08X6Hy7ZimXr8sWed4SnhqlhwzUWiiehh1STpeVtraYzxG3KCWc2Ynb4TccpSvcIMXjDk9EIY9HvzqygoLva2heAL7KCWy+9QKj5RlUlfL+IMJ7rk5zZiyvoRUdbYdU0m1U1GhSdISWTvSiYpi3S3YA+39U5syz+Ew3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409197; c=relaxed/simple;
	bh=ZVr+r/LBqXQgcI+sBykKKfmAoe4khgXbrhxb1OvV5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fo7vVrSwLiTLtwmNVUEH0JgIvyBrqb4+SCJiyxjNtHYoUa8kMrOdmLxVeMWwU/zrO6Clb4j9ZrHpel0r2ZslKDu1HplKlbZIlmHDr5qCCvp0Miku6QpXCShUXty8uSM5/x9T8jXg+MfE/A8ZOsD9CC6CV1a396XjUS+M/0toqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpV+5MWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpV+5MWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770409196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfg1XVDNrOrliMld15NJAv7vzlhGMGaxrtLKhQhHwig=;
	b=VpV+5MWOG+UfV1bpXUxcOjaG/Hh6RSl9O60/nyyISJFZvhPNTYNze+i/RHibdo7BXhd+RN
	Rii/VfQiheJfxeQQwrBZjuFIL/tRqZ4Ub6pJz6MwR12MlLajEFDraDM8UUpA7Zdga2gUu9
	JimFOWhidVk9+uPn+7uJvwI1Gd9mH2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-OToOorXPP7SUH9VkcyvM0A-1; Fri,
 06 Feb 2026 15:19:53 -0500
X-MC-Unique: OToOorXPP7SUH9VkcyvM0A-1
X-Mimecast-MFC-AGG-ID: OToOorXPP7SUH9VkcyvM0A_1770409191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A00D01956089;
	Fri,  6 Feb 2026 20:19:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1033018003F6;
	Fri,  6 Feb 2026 20:19:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd references
Date: Fri,  6 Feb 2026 15:19:17 -0500
Message-ID: <20260206201918.1988344-3-longman@redhat.com>
In-Reply-To: <20260206201918.1988344-1-longman@redhat.com>
References: <20260206201918.1988344-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: RtC0kj1LEZuvbr3P6UfWlsI_L-89bQkodWRay0ftkms_1770409191
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

To avoid this kind of performance regression, use the new
get_fs_pwd_pool() and put_fs_pwd_pool() APIs to acquire and release a
fs->pwd reference. This should greatly reduce the number of path_get()
and path_put() calls that are needed.

After installing a test kernel with auditing enabled and counters
added to track the get_fs_pwd_pool() and put_fs_pwd_pool() calls on
a 2-socket 96-core test system and running a parallel kernel build,
the counter values for this particular test run were shown below.

  fs_get_path=307,903
  fs_get_pool=56,583,192
  fs_put_path=6,209
  fs_put_pool=56,885,147

Of the about 57M calls to get_fs_pwd_pool() and put_fs_pwd_pool(), the
majority of them are just updating the pwd_refs counters. Only less than
1% of those calls require an actual path_get() and path_put() calls. The
difference between fs_get_path and fs_put_path represents the extra pwd
references that were still stored in various active task->fs's when the
counter values were retrieved.

It can be seen that the number of path_get() and path_put() calls are
reduced by quite a lot.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/auditsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dd0563a8e0be..af22f8be4d70 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -931,6 +931,9 @@ static inline void audit_free_names(struct audit_context *context)
 {
 	struct audit_names *n, *next;
 
+	if (!context->name_count)
+		return;	/* audit_alloc_name() has not been called */
+
 	list_for_each_entry_safe(n, next, &context->names_list, list) {
 		list_del(&n->list);
 		if (n->name)
@@ -939,7 +942,7 @@ static inline void audit_free_names(struct audit_context *context)
 			kfree(n);
 	}
 	context->name_count = 0;
-	path_put(&context->pwd);
+	put_fs_pwd_pool(current->fs, &context->pwd);
 	context->pwd.dentry = NULL;
 	context->pwd.mnt = NULL;
 }
@@ -2165,7 +2168,7 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
 
 	context->name_count++;
 	if (!context->pwd.dentry)
-		get_fs_pwd(current->fs, &context->pwd);
+		get_fs_pwd_pool(current->fs, &context->pwd);
 	return aname;
 }
 
-- 
2.52.0

