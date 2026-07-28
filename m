Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD542BC3D
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248099; cv=none; b=XG8GoSgy0xRGcPQpSHZxq87QInkyPXSyDNpu9JMZcFRoi/tBCxN0mve/d/603PvOY5Cljt8HzWXuR4/bcZ6H9hlH/TxKLLNXHqxIHxrI7QyPy+0t9HXVgMgo2SEnhB8lHQaGlgazyGROK/m7EXJ7hDb+TfgQIn+H7ric6efXcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248099; c=relaxed/simple;
	bh=xbglV4iZ8SKtBkHRrZ+hm6zyLpHZNWbfyNzRlHy063g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aDewTF5+9M2DbMicIRTmf1tOYkPYb81sXHtVliYsURSP8NdQeE6UkglhPlaUuMYb5SnbkRjCk7yx629AP8Y75swlfbnPgxzNUfBwZa3mdoTg2kBzeOCc6Lh/IRBLL43pqhiUnouyeUHA7j3SRxOK7CRYdjgwGct6NujA8I+Xa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kf4d7TN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kf4d7TN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785248096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqT1i+1wnTsffmeruSjzKW+ynR/BHOQweFjl4rifmLM=;
	b=Kf4d7TN0zamgtvipO3KrRWJsOz0GDdRtQ+KddqzeGzVbYg3vq5LHP6Np3sSA9x0xgpMHL0
	a2096IzzQDCvm3rcHxqnAEr8C7Vt7q+TMHk6MQ0YRn+Sgq59SU92rWav8uSZ9i0SzIrpWE
	AoIi6Tmjx/nLBGnsPnUrB3+cHUp/yvU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-dQE9lAqmNRmLB7Wcz8AYng-1; Tue,
 28 Jul 2026 10:14:52 -0400
X-MC-Unique: dQE9lAqmNRmLB7Wcz8AYng-1
X-Mimecast-MFC-AGG-ID: dQE9lAqmNRmLB7Wcz8AYng_1785248091
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188DB193531A;
	Tue, 28 Jul 2026 14:14:44 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2AE21800480;
	Tue, 28 Jul 2026 14:14:41 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 1/2] audit: drop BUG_ON() from audit_add_to_parent()
Date: Tue, 28 Jul 2026 11:14:23 -0300
Message-ID: <e0e6505a3f80912216dd834d25f330b818d73263.1785246707.git.rrobaina@redhat.com>
In-Reply-To: <cover.1785246707.git.rrobaina@redhat.com>
References: <cover.1785246707.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: itz47J2NSS3x4Q0YM13CayLxgOJxU24gKPn2RpbbyMg_1785248091
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The BUG_ON(!mutex_is_locked(&audit_filter_mutex)) check in
audit_add_to_parent() will panic the kernel if the mutex is not held,
which is too severe for this situation.

Replace it with lockdep_assert_held(), instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 06dd0ebe73e2..4ac8a91e9ba8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -372,7 +372,7 @@ static void audit_add_to_parent(struct audit_krule *krule,
 	struct audit_watch *w, *watch = krule->watch;
 	int watch_found = 0;
 
-	BUG_ON(!mutex_is_locked(&audit_filter_mutex));
+	lockdep_assert_held(&audit_filter_mutex);
 
 	list_for_each_entry(w, &parent->watches, wlist) {
 		if (strcmp(watch->path, w->path))
-- 
2.53.0

