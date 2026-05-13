Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572F26B742
	for <audit@vger.kernel.org>; Wed, 13 May 2026 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708912; cv=none; b=LEpM5pTM9nn6qGkxPG2Sn1Sx/+pgSg+kmRle/yd68fszh+wMe/XdROSWvdSBAHIN0nXBLF1gNLya41zilfSAF8DTJxDsr8Wpc7wq6qAGn2jXP7FxUAeqX2hQS6OIGNO8zrg9/K3bEH0XQsYs4sRSivslwCzLz9nG78Y86HJvzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708912; c=relaxed/simple;
	bh=uu+bktVHC//HeqT3EC+V/mJaCzeHvEil0EeIkn1suLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ar0lUCqnXKaxq+ReBadWX9fWe0f5LXEuczzY6r8/bd7jH41cPvRhe45CafuzULH25oFVlr5Y6e+4f8Ca4mnrfX/j3U7X0ujcxu6NvrKGZo46fgPxu/p2FlFaz2GFKAhBKXerMVWrvv6EB0a2O1T0l0UdoH/naLc3IxP7r3nPFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbOWq+wV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbOWq+wV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778708910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paYre+lXXBmot/+mhqXIObNvV0JozfP0u0qd+2X1e58=;
	b=GbOWq+wVaHRaDSRFhLjsfH+EmgF9TxFy6z6m8OzY+r9xa699hkgHac2C0tMBk4XHuAV/jR
	yGW143j96S4R2pAbeaez5G5jSm2j5QX/I8f+6CdtDsCTYmMFaZet+GnQdjXCZzN3Q2L4li
	FrZxKwg2LEwk50KN0uFP8D5jJow8aPg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-dv6ZE3SdPe2iH0hh19xO-Q-1; Wed,
 13 May 2026 17:48:26 -0400
X-MC-Unique: dv6ZE3SdPe2iH0hh19xO-Q-1
X-Mimecast-MFC-AGG-ID: dv6ZE3SdPe2iH0hh19xO-Q_1778708905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A41195608F;
	Wed, 13 May 2026 21:48:25 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.76])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFACC19560A2;
	Wed, 13 May 2026 21:48:22 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	longman@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2 1/2] audit: fix removal of dangling executable rules
Date: Wed, 13 May 2026 18:47:59 -0300
Message-ID: <7f0a259c6e6b5a1da6578fb83b531276425aa030.1778704210.git.rrobaina@redhat.com>
In-Reply-To: <cover.1778704210.git.rrobaina@redhat.com>
References: <cover.1778704210.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: vLpTVy2i5AlxjAgXIa-EiX0apxZV9KPbTkP4hlByono_1778708905
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
Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- New patch order: now patch 1/2 (was 2/2 in v1) per maintainer feedback

 kernel/audit_fsnotify.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 711454f9f724..ae0e75403f76 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -84,10 +84,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	if (d_really_is_negative(dentry)) {
-		audit_mark = ERR_PTR(-ENOENT);
-		goto out;
-	}
 
 	audit_mark = kzalloc_obj(*audit_mark);
 	if (unlikely(!audit_mark)) {
-- 
2.53.0

