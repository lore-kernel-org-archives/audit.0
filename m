Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8572EEE86
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111535; cv=none; b=AjNdJw85DvFEurL818zj6zOZwA4OAxSOWdMLPeA8/aJfDrx6uvEqgKDzLDH4U39UTx4FxG3vhpAuafCtpxbBdS80JgHki2Doj2VBcqLcKdNr2NUHRJYw2NPy18Zm1QCfpC9Lc9LeyPJl+FjqDiVCW9hsz4PqzyDkTRR3Ih+UcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111535; c=relaxed/simple;
	bh=Q/QhbKYIqaII2PS2SJFBGQ9dz2J7lBZuq/ISmSzyn6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=VbL+HxjTcBU2ZwNe15421DFb/1EjU0/kUYGxu+NCd/1JJg+Obo+JbnaSGir2h+CmRSMCTfA5wHrgXDNAmQzdy5652ik6YYsuX/TBohCozoqAw9Ikj1zr1nCHGg5LPpWgtnY/r69p6WpHQ3ECue0yHGUqMiwz73T2eT5QSfhp+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4ownV1H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4ownV1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786111532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=peLD2LgaGaFiGt5fzCOvxc8lLzEVoCDwGcOMMobX7Bs=;
	b=O4ownV1HVgpAPpzum8cmRi7Qf4ioy6OHZUH8h9vxMtRBzN3inhVmC5GsvEd3Nd1zGhJ98z
	F/YrSrRgXyU8r4oF64eQxEKmwpxW28qXvlAsXBh6z81X2Xy7Oz6p+MMtfHgfuJ+lmQD7sw
	IkGGLUxlKsmdXrgqKzCsIzHvrIvk2+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-YfjRKsBcNMmig0Y7NKc6EQ-1; Fri,
 07 Aug 2026 10:05:29 -0400
X-MC-Unique: YfjRKsBcNMmig0Y7NKc6EQ-1
X-Mimecast-MFC-AGG-ID: YfjRKsBcNMmig0Y7NKc6EQ_1786111528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA2019560B9;
	Fri,  7 Aug 2026 14:05:28 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D880180049F;
	Fri,  7 Aug 2026 14:05:25 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add missing unlikely hint to audit_dummy_context() wrappers
Date: Fri,  7 Aug 2026 11:05:21 -0300
Message-ID: <20260807140521.510904-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: x4iSLeoJqePamPfayLKa_bwMuvosPCb82SJceMBam3w_1786111528
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The inline wrappers: audit_log_kern_module(), audit_tk_injoffset(),
and audit_ntp_log() check audit_dummy_context() without unlikely(),
unlike every other wrapper in the file.

Add the missing annotations for consistency.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/audit.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..18b44a1c5397 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -547,7 +547,7 @@ static inline void audit_openat2_how(struct open_how *how)
 
 static inline void audit_log_kern_module(const char *name)
 {
-	if (!audit_dummy_context())
+	if (unlikely(!audit_dummy_context()))
 		__audit_log_kern_module(name);
 }
 
@@ -563,7 +563,7 @@ static inline void audit_tk_injoffset(struct timespec64 offset)
 	if (offset.tv_sec == 0 && offset.tv_nsec == 0)
 		return;
 
-	if (!audit_dummy_context())
+	if (unlikely(!audit_dummy_context()))
 		__audit_tk_injoffset(offset);
 }
 
@@ -586,7 +586,7 @@ static inline void audit_ntp_set_new(struct audit_ntp_data *ad,
 
 static inline void audit_ntp_log(const struct audit_ntp_data *ad)
 {
-	if (!audit_dummy_context())
+	if (unlikely(!audit_dummy_context()))
 		__audit_ntp_log(ad);
 }
 
-- 
2.55.0

