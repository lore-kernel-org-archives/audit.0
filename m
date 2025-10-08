Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641429E116
	for <audit@vger.kernel.org>; Wed,  8 Oct 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933651; cv=none; b=tjaz7Fkb7iByJ0QCMEcQm6XnO/FFgzpBoED9AbI71fVmq88B+gHjee96hYHJqWqLa7vHAxqGFBijNEFFo2d8e5SH40iI4ZtgUybRsPxYNz4A4JVvce8HTxuGsVWwqAeWMZQzx/DpX8IZeLy2BbrFz0+Bbgtu0PPVbGOxCSxJavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933651; c=relaxed/simple;
	bh=j8l61WfJXrdGwEiWLyZGscKlDsv2o88a3cPKi76HS24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aj3sJRK/HNuG+X2c11RPQYcztPrwcVobEOPbMAKxQysaDCFv2z1Yy/FN0aZFf+DIyx3KQIAgWOWU22xqQwzM5VuOnbBvUEfxfMrXer1zKENaUgVHmkYqCqPgge3uZe9NAIvxBMUWEEumZC7jdzkD8VtyKj/l1aCSqqr/nlsrQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8Ml+1HC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8Ml+1HC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759933648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l2VVjO+UvW1gH/jxFzQoi3Ka97IplfFW++LJ8JenSXk=;
	b=O8Ml+1HC3PXtYoRP6ulXQbZgM7j1dgqeW7smmQ2txF2ayZVyh+NFCiPV791aWLpKtqoQy9
	gq+CFarLY/E/SdpHRnME77QbhGYbII/77GhyUoLNN46j6PczNaZTCYP5rcgM/qMkjVyfA+
	R/R2WR+mZ0xb1sFu3QKuA47QJx9FlRo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-sbMmFv6tPyyYX9pf2yJh3A-1; Wed,
 08 Oct 2025 10:27:26 -0400
X-MC-Unique: sbMmFv6tPyyYX9pf2yJh3A-1
X-Mimecast-MFC-AGG-ID: sbMmFv6tPyyYX9pf2yJh3A_1759933645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D84801955E88;
	Wed,  8 Oct 2025 14:27:24 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.205])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C76C180035E;
	Wed,  8 Oct 2025 14:27:22 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: fix comment misindentation in audit.h
Date: Wed,  8 Oct 2025 11:27:19 -0300
Message-ID: <20251008142719.2564034-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Minor comment misindentation adjustment.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 2a24d01c5fb0..5f277394e945 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -133,7 +133,7 @@ struct audit_context {
 	struct audit_aux_data *aux_pids;
 	struct sockaddr_storage *sockaddr;
 	size_t sockaddr_len;
-				/* Save things to print about task_struct */
+	/* Save things to print about task_struct */
 	pid_t		    ppid;
 	kuid_t		    uid, euid, suid, fsuid;
 	kgid_t		    gid, egid, sgid, fsgid;
-- 
2.51.0

