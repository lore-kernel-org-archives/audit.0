Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343842F1FE4
	for <audit@vger.kernel.org>; Fri, 12 Jun 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273691; cv=none; b=gubdhv8iTJhMOkyid0GqfmiP3Bhsk0iGhC1kBoYJMzq8ghai6JF8BasZy8KdMoHLt3fbkikpgQqFR6MsQ+dPn4szKE3UWWv5lFVM7HLTHsynZMMsQUiG6tAhI+RIKn3jQCSWzBk+22+lfRHg8/yCVYqKBk9vQVU/Y6O5F4EyrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273691; c=relaxed/simple;
	bh=Zebk62J7NRpW3SkTs8pUMwqkT3NgzSOMLPjiXRd9KWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KXE4PBrRVSX4Q541xSO4xKOPOpcwLP8ZvcTDw3xnD1bb5y1gvrCwlBH1U/b5tU187tzCXw3QvEoPtNf67uOZHD3+o/R+SS2QK9jE/4Cb1uFRBpCEDnwPn8tF25uY3Jc8WBlXdaQEqkeN8C78SgmDfo9aO1iqwo9jEn1OWS1Ilio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5Cr5MgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5Cr5MgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781273688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y3MQpKCShTW8JvaRHAcnH0u3oKwnRUmD7ODT7NaGVxs=;
	b=W5Cr5MgKw8wKPxHqKLG0Xj+MkxBuPthf4RUiJBCyAROGTBUM/01XNbrtfCO1gE6tNSE+cd
	oOcsVLKQbs3yB1bJG1+PPt2ic4+VxHIyj1oTE+9tPOkJxi8xVo9W2JCYXIcHSXaTY4UfJc
	4Il+mqbrjsdIiGAc9e1BszKyAHMqVkA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-VTRz5LQ4MK2Xfrq9ZN01EQ-1; Fri,
 12 Jun 2026 10:14:44 -0400
X-MC-Unique: VTRz5LQ4MK2Xfrq9ZN01EQ-1
X-Mimecast-MFC-AGG-ID: VTRz5LQ4MK2Xfrq9ZN01EQ_1781273683
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62160195DE10;
	Fri, 12 Jun 2026 14:14:43 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.108])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8315C36917;
	Fri, 12 Jun 2026 14:14:40 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	arnd@arndb.de,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: add missing syscalls to PERM class tables
Date: Fri, 12 Jun 2026 11:14:36 -0300
Message-ID: <20260612141436.3137694-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: X7sGolyWAQLBEGlNdAOI34uwtgtoSrpM2wGU79XiNc4_1781273683
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add missing file metadata syscalls to the audit PERM class tables,
addressing gaps where certain file operations were not properly
classified for audit rule matching.

Changes:
- audit_change_attr.h: Add file_setattr

- audit_read.h: Add quotactl_fd, file_getattr, stat, stat64, lstat,
  lstat64, fstat, fstat64, newfstatat, fstatat64, and statx

- audit_write.h: Add quotactl_fd

Architecture-specific and conditionally-compiled syscalls are guarded
with #ifdef.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Added stat64 family syscalls (stat64, lstat64, fstat64, fstatat64) to
  audit_read.h for 32-bit architecture support.
- Dropped timestamp-related syscalls (utime, utimes, utimensat, etc.)
  due to potential audit log volume increase impact. Those will be
  addressed in a separate patch after closer investigation.

 include/asm-generic/audit_change_attr.h |  3 +++
 include/asm-generic/audit_read.h        | 31 +++++++++++++++++++++++++
 include/asm-generic/audit_write.h       |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index ddd90bbe40df..94388da3490c 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -40,3 +40,6 @@ __NR_link,
 #ifdef __NR_linkat
 __NR_linkat,
 #endif
+#ifdef __NR_file_setattr
+__NR_file_setattr,
+#endif
diff --git a/include/asm-generic/audit_read.h b/include/asm-generic/audit_read.h
index fb9991f53fb6..d8dc3dd6bf63 100644
--- a/include/asm-generic/audit_read.h
+++ b/include/asm-generic/audit_read.h
@@ -3,6 +3,9 @@
 __NR_readlink,
 #endif
 __NR_quotactl,
+#ifdef __NR_quotactl_fd
+__NR_quotactl_fd,
+#endif
 __NR_listxattr,
 #ifdef __NR_listxattrat
 __NR_listxattrat,
@@ -18,3 +21,31 @@ __NR_fgetxattr,
 #ifdef __NR_readlinkat
 __NR_readlinkat,
 #endif
+#ifdef __NR_file_getattr
+__NR_file_getattr,
+#endif
+#ifdef __NR_stat
+__NR_stat,
+#endif
+#ifdef __NR_stat64
+__NR_stat64,
+#endif
+#ifdef __NR_lstat
+__NR_lstat,
+#endif
+#ifdef __NR_lstat64
+__NR_lstat64,
+#endif
+#ifdef __NR_fstat
+__NR_fstat,
+#endif
+#ifdef __NR_fstat64
+__NR_fstat64,
+#endif
+#ifdef __NR_newfstatat
+__NR_newfstatat,
+#endif
+#ifdef __NR_fstatat64
+__NR_fstatat64,
+#endif
+__NR_statx,
diff --git a/include/asm-generic/audit_write.h b/include/asm-generic/audit_write.h
index f9f1d0ae11d9..378128dc31e3 100644
--- a/include/asm-generic/audit_write.h
+++ b/include/asm-generic/audit_write.h
@@ -5,6 +5,9 @@ __NR_acct,
 __NR_swapon,
 #endif
 __NR_quotactl,
+#ifdef __NR_quotactl_fd
+__NR_quotactl_fd,
+#endif
 #ifdef __NR_truncate
 __NR_truncate,
 #endif
-- 
2.53.0

