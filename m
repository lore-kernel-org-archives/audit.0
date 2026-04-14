Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CC199E89
	for <audit@vger.kernel.org>; Tue, 14 Apr 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196903; cv=none; b=Uo7plphlnBwE6FiOGb4HW1IqW5+v0pSLisaJKGT/JzA4rXRhBBOAzDIxYmVe7JOJVedxWtiQs9kgp6U7yFjKz01cjUyjRidI1htF+fWrY0s0GdOYbSIHkBvdv2bTA5HyoFPA45mUod+UjZsjqqLMcNMKjpCYPnW5CeWQUiypjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196903; c=relaxed/simple;
	bh=D/YsPj/pCznsUbS4A0ijdPQGAhvX13MCEY0OglBMUR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XB9DgtTwBDqrFCyisa51KjYI5fD0VXwd2DQC4nIqTOJSdr/AXEMyNG9Xmfcld1U5jHhrIg+glxEFEGdymk0pZb+HrPchmBOzydGFXFh8aZPuFTaVsyX5QKEJT9kAWUq1Q8EbpvYCekNMx0ESyBxM6Iwek5Z5eITjiaIxaEZpi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhZ4TqxF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhZ4TqxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776196900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6GvuGAwqAGBMD+EbLO+xEfAoOAT1VhucIhlQPQJHWg=;
	b=PhZ4TqxFPjOKWUBeu/8RaePBWQkWgGj8E7RAH61cqFJ9XOWDYjAzMYuZi2j4TSVTtqWgiT
	wDrIqX1KoxZ9DNuIC0lQ+Yb0kWxuizE8ACegWqvxaIK4EOex4fNlqc7eBEI2pvMqRhdJh6
	gl15Ew3uSma8vMKxRAfV7SMB8JeHa1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-MSsZdWYqNh6QSyWtAfWPew-1; Tue,
 14 Apr 2026 16:01:31 -0400
X-MC-Unique: MSsZdWYqNh6QSyWtAfWPew-1
X-Mimecast-MFC-AGG-ID: MSsZdWYqNh6QSyWtAfWPew_1776196881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F4CA1955DDF;
	Tue, 14 Apr 2026 20:01:16 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A0EE180057E;
	Tue, 14 Apr 2026 20:01:12 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	longman@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 2/2] audit: fix removal of dangling executable rules
Date: Tue, 14 Apr 2026 17:00:48 -0300
Message-ID: <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>
In-Reply-To: <cover.1776176104.git.rrobaina@redhat.com>
References: <cover.1776176104.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: zCk010-A8jIQrVmnTp23LvCqECSGPLUYDG1g4Uwyi54_1776196881
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When an audited executable is deleted from the disk, its dentry
becomes negative. Any later attempt to delete the associated audit
rule will lead to audit_alloc_mark() encountering this negative
dentry and immediately aborting, returning -ENOENT.

This early abort prevents the subsystem from allocating the temporary
fsnotify mark needed to construct the search key, meaning the kernel
cannot find the existing rule in its own lists to delete it. This
leaves a dangling rule in memory, resulting in the following error
while attempting to delete the rule:

 # ./audit-dupe-exe-deadlock.sh
 No rules
 Error deleting rule (No such file or directory)
 There was an error while processing parameters

 # auditctl -l
 -a always,exit -S all -F exe=/tmp/file -F path=/tmp/file -F key=dr

 # auditctl -D
 Error deleting rule (No such file or directory)
 There was an error while processing parameters

This patch fixes this issue by removing the d_really_is_negative()
check. By doing so, a dummy mark can be successfully generated for
the deleted path, which allows the audit subsystem to properly match
and flush the dangling rule.

Fixes: 76a53de6f7ff ("VFS/audit: introduce kern_path_parent() for audit")
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit_fsnotify.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index eee589bca86e..703a110cebd4 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -86,10 +86,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 		dentry = kern_path_parent(pathname, &path);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry); /* returning an error */
-		if (d_really_is_negative(dentry)) {
-			audit_mark = ERR_PTR(-ENOENT);
-			goto out;
-		}
 	}
 
 	audit_mark = kzalloc_obj(*audit_mark);
-- 
2.53.0

