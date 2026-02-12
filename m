Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69926ED48
	for <audit@vger.kernel.org>; Thu, 12 Feb 2026 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919754; cv=none; b=Mnh8BWZJlfJMGFkcKv38ehNTUSWfJlN8twyEejGhqEd5gf8oq64LZgrl7szd4D2Ej3mhtFkoxXaVg6qAU6mF5AVJq99ap4O0vEE3sb8ojb4iGuD2Jjq12bYmeX685Frp/JNwcl2bSn59C5cghfMINnvl010uLJf1IPUjOJCOlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919754; c=relaxed/simple;
	bh=ZVr+r/LBqXQgcI+sBykKKfmAoe4khgXbrhxb1OvV5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=o33ETdDrspd2UG+KoIEkmyW4XpXdVimFm59BCqJ0AxaTXzfkg24NqQasJzsD22+qy11X9ZsovqpUuMvgHYQytefb86oeGEHhyS38RYLRGPSA9Cc2VThhceNan91o04eEjd/gD1dBM9vAFrwf+FhPYI/SCRRaLWI12gZVbQXnerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp+6dj0W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp+6dj0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770919752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfg1XVDNrOrliMld15NJAv7vzlhGMGaxrtLKhQhHwig=;
	b=Xp+6dj0WQDo/AULl8FOGjf0Tf8o+oQQ3KOgpStxUSANv6OQjcylqUIHK7vAT2I/EYM3mfK
	lBgSV4H7t4wjusu9QPWemJ/LSm43jUHgXKCqISGV2CiiPO0VsC8ASqpw3OHMyN94Bq6dWC
	1+3UqmDHMLrQ2zzibLnDnfd8DLdz8W8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-3doP8PF5Peqi68zGV4iYbA-1; Thu,
 12 Feb 2026 13:09:08 -0500
X-MC-Unique: 3doP8PF5Peqi68zGV4iYbA-1
X-Mimecast-MFC-AGG-ID: 3doP8PF5Peqi68zGV4iYbA_1770919747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE1D18003F5;
	Thu, 12 Feb 2026 18:09:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7085519560BC;
	Thu, 12 Feb 2026 18:09:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd references
Date: Thu, 12 Feb 2026 13:08:20 -0500
Message-ID: <20260212180820.2418869-3-longman@redhat.com>
In-Reply-To: <20260206201918.1988344-1-longman@redhat.com>
References: <20260206201918.1988344-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: BV0HDG_bCKpfCircrzILVfe_RoiBuluJzPuAumg8Eg4_1770919747
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

