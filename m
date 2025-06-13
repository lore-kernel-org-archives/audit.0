Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12F2E11A4
	for <audit@vger.kernel.org>; Fri, 13 Jun 2025 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844712; cv=none; b=kygG9rTYAtWaYJ+uutd6lje31YEv/s0QA5L8S2C+4RyDENN62jv8tyOHnpbGaRCykAzGW4SGF3xqvvzN78V8drEmZq89LmyeHLK2qy1pK3pugszu7dytQ3XsTNGyWXebJ7oCDnnuDKMj0+w8GF9DQ6HPD0Lq+BVIfrgrSacpLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844712; c=relaxed/simple;
	bh=IeYwvKyDtkdNwkXBmUEPUfygtldoD6XTQDr2/SAnxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=hU1C9LAc5U+6RuYB0+/HUPDZp389GwGRbC23fy1ti+5D4UZsY3pjOvFNSP3OXA4T07MqJ3+kAKq+Za9skDHuanVmYH6c5BNlaU8JL3eZQtOZYU7ZKdqMI1XEKSO9FAfLbUjbCAl78RoIxxWXu7V8y2/56tz9Uvw13F7fcndrK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4ww2Vei; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4ww2Vei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749844710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3q6Z4753+JxM0nf5lTzUU2EKJgTUXryaQ/k3iYZUiHs=;
	b=H4ww2Vei2xqQ17/atVgN1ZqVw3ZNLLQ/V3MNT1nAuXuO3B0s1Was3TfFOy07wczcPmv6nq
	KwvUAFd3YGDbDkij3eIiuOmMrJQGVHQqc6UnRaWx43PiQH1KO7C7jHh7UbYARnqZPsMAt5
	Zu53g78Pk8HC3SOmSU8/1hNFWAXDaqM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-vi28vK1pM_68bzEqqbgThQ-1; Fri,
 13 Jun 2025 15:58:28 -0400
X-MC-Unique: vi28vK1pM_68bzEqqbgThQ-1
X-Mimecast-MFC-AGG-ID: vi28vK1pM_68bzEqqbgThQ_1749844707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0D95180034E;
	Fri, 13 Jun 2025 19:58:26 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CF3E18003FC;
	Fri, 13 Jun 2025 19:58:24 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-modules@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v3] audit,module: restore audit logging in load failure case
Date: Fri, 13 Jun 2025 15:58:00 -0400
Message-ID: <9b7b21e5f37f5718fe9176a36ebf670bbdfdd54a.1748462545.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The move of the module sanity check to earlier skipped the audit logging
call in the case of failure and to a place where the previously used
context is unavailable.

Add an audit logging call for the module loading failure case and get
the module name when possible.

Link: https://issues.redhat.com/browse/RHEL-52839
Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Changelog:
v2
- use info->name for both audit_log_kern_module() calls and add const
v3
- use "?" rather than "(unavailable)" for consistency with other records
---
 include/linux/audit.h | 9 ++++-----
 kernel/audit.h        | 2 +-
 kernel/auditsc.c      | 2 +-
 kernel/module/main.c  | 6 ++++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..a394614ccd0b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -417,7 +417,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
-extern void __audit_log_kern_module(char *name);
+extern void __audit_log_kern_module(const char *name);
 extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
@@ -519,7 +519,7 @@ static inline void audit_openat2_how(struct open_how *how)
 		__audit_openat2_how(how);
 }
 
-static inline void audit_log_kern_module(char *name)
+static inline void audit_log_kern_module(const char *name)
 {
 	if (!audit_dummy_context())
 		__audit_log_kern_module(name);
@@ -677,9 +677,8 @@ static inline void audit_mmap_fd(int fd, int flags)
 static inline void audit_openat2_how(struct open_how *how)
 { }
 
-static inline void audit_log_kern_module(char *name)
-{
-}
+static inline void audit_log_kern_module(const char *name)
+{ }
 
 static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 { }
diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..2a24d01c5fb0 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -200,7 +200,7 @@ struct audit_context {
 			int			argc;
 		} execve;
 		struct {
-			char			*name;
+			const char		*name;
 		} module;
 		struct {
 			struct audit_ntp_data	ntp_data;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 78fd876a5473..eb98cd6fe91f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2864,7 +2864,7 @@ void __audit_openat2_how(struct open_how *how)
 	context->type = AUDIT_OPENAT2;
 }
 
-void __audit_log_kern_module(char *name)
+void __audit_log_kern_module(const char *name)
 {
 	struct audit_context *context = audit_context();
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..4860e534de05 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3297,7 +3297,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_allocated = true;
 
-	audit_log_kern_module(mod->name);
+	audit_log_kern_module(info->name);
 
 	/* Reserve our place in the list. */
 	err = add_unformed_module(mod);
@@ -3458,8 +3458,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * failures once the proper module was allocated and
 	 * before that.
 	 */
-	if (!module_allocated)
+	if (!module_allocated) {
+		audit_log_kern_module(info->name ? info->name : "?");
 		mod_stat_bump_becoming(info, flags);
+	}
 	free_copy(info, flags);
 	return err;
 }
-- 
2.43.5

