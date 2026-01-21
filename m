Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19A1B4223
	for <audit@vger.kernel.org>; Wed, 21 Jan 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962944; cv=none; b=NOWnPHXPeBOucaMe+OIKg4AtW6fyxIWGV0XKMLCkfCZt5+QMB7nzzrGZECs4yIejIDwTMLd1akT456FD2cLloxMoFAwI65C4Sk3e+IaDUEq/SoNdIH1UwgOIvpVphSq/P69WRPOx3yxeyfTkKYH4oHonfAqxNWTGKrU3sSlI6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962944; c=relaxed/simple;
	bh=I8o/jmnhgHluJuCrX+5dQTnSexBoyh1i3RFKJDjGv1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0+Jrg/lGORPWgsjZanywODr5Lrqz+EEshJpBukP9//xRmlwdqkcdXD3OA/VA9LjziCGq60SLGe4jW52XwgxCibzJ9MIzSCIz6aYiHRxEoI8CCLF2E7n608EnnA7cD03dGE2L0O2kfxqSR3p/7bYUfUp2A9ge6nHie4MFkKIJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwZaRTYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwZaRTYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768962941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCLuxTdTqxkmNE6ZnT4aMHdG/dWpsKBxaTWm/Gzqjs0=;
	b=NwZaRTYNZESjMTUQNqMTglNPUi1DxfBZSqRl618duj/ZW49avJxtn97Oixh80f3YT1bDnr
	ovd5rXOLWIQjCDdUu2szf6lcKm11FaBjUpFaGOju/Z5FTyvLE/UDVnm3QlTqY01uLW2lVh
	uIBzVxlvO8ak1eRY49W3T9uprUuB0kM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-3-an-osrPXSLtaP3L6tXyw-1; Tue,
 20 Jan 2026 21:35:38 -0500
X-MC-Unique: 3-an-osrPXSLtaP3L6tXyw-1
X-Mimecast-MFC-AGG-ID: 3-an-osrPXSLtaP3L6tXyw_1768962937
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A383F1956088;
	Wed, 21 Jan 2026 02:35:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.122])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57BD21800240;
	Wed, 21 Jan 2026 02:35:34 +0000 (UTC)
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
Subject: [PATCH 1/2] audit: Quit audit_free_names() early if name list empty
Date: Tue, 20 Jan 2026 21:35:08 -0500
Message-ID: <20260121023509.410423-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Optimize audit_free_names() by quitting early if the name list is empty.
This eliminates the need to acquire and release the fs_struct spinlock
in path_put().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/auditsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dd0563a8e0be..824b6fd98561 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -931,6 +931,9 @@ static inline void audit_free_names(struct audit_context *context)
 {
 	struct audit_names *n, *next;
 
+	if (list_empty(&context->names_list))
+		return;	/* audit_alloc_name() has not been called */
+
 	list_for_each_entry_safe(n, next, &context->names_list, list) {
 		list_del(&n->list);
 		if (n->name)
-- 
2.52.0

