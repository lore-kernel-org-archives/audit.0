Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1859D61C
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656032; cv=none; b=JhibuQ6K8GXWjYbhMerFGGA0lxS+manDFtxEjc7IgqhTKG+FQsOBteu8D97uR6ZiXGeRwyilBCNGA+YU/37NVTdH/gQtO/0p/9sqsdVD3aU2VIfazrBwfX1UQTJ2R9yngTyg9X7f1XtIlA5mUsRYohI/oW3hYesFL8rFwc0p3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656032; c=relaxed/simple;
	bh=SWhfGLVD0sT3VEe5Y8snr0LSyJH5RrEfg9VxlATQ8lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3g6JwYFX0O6jx86xwRZPkkZ6c2uxMyaSGukHDoUMd7Kthkgjf0X/a5nT+pfaYHKolXixztfKU55EzWsHaFoV7Iyz3xmU/ursXU+NvIh9FdKOCsOBlfLOqv8NM624fY9cYfqbPeIRUvi3eBm6yeiGz0+iwyrz56XY3IWFGJqhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dy0DnUS4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dy0DnUS4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789656022;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YVElyX5xnAFEfja8L/Wi/CJhW00IbuIkuY9PH3SeGPc=;
	b=dy0DnUS40EcTDszilv9WFiV3BkkiYxJf60jXoYIq5fFvUOnvBFeZc9Ik1C1UmM//d23gNA
	vzRs8aBIXjqi2Tk8dpGyik7UQuec1TKG3UES6gZPvmy8EQmVJJ+TCF8PgfShNCQmoTtSem
	FEXxQ7ybdryBRW3tGmUstM0PJt/ljXRW4BwwCn0wSVep40xM3icn1kyA34Bqu7+sptaoSM
	MUa/tqcCgYR4ypqU6y2+oykwJs7zKuXT9y8b8xeO6gLcICvvhJvx2MXkFGu1/ZVPZeBlWq
	A5Cofr9CuZ0J/tSLXfmdIYNuIm+h+5xqvdJWyRmeepHNbGh8YgZiuMKdh2jRQQ==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 1/4] audit: separate file and process capability storage
Date: Thu, 17 Sep 2026 16:39:45 +0200
Message-ID: <20260917143948.106603-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

File capabilities need permitted and inheritable sets, an effective flag,
and a root UID. Process capabilities need four full capability sets but
neither a file effective flag nor a root UID. Give file capabilities their
own type instead of storing both representations in audit_cap_data.

This reduces each preallocated audit_names entry by 16 bytes on the tested
64-bit configurations, saving 80 bytes per audit context. The BPRM
capability auxiliary object also shrinks from 144 to 112 bytes. Retain all
logged fields, including file root IDs and process ambient capabilities;
record formats and collection behavior are unchanged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/audit.h   | 15 +++++++++------
 kernel/auditsc.c |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 3176da464843..7640d2c0fba4 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -53,15 +53,18 @@ struct audit_entry {
 	struct audit_krule	rule;
 };
 
+struct audit_file_caps {
+	kernel_cap_t		permitted;
+	kernel_cap_t		inheritable;
+	unsigned int		fE;		/* effective bit of file cap */
+	kuid_t			rootid;
+};
+
 struct audit_cap_data {
 	kernel_cap_t		permitted;
 	kernel_cap_t		inheritable;
-	union {
-		unsigned int	fE;		/* effective bit of file cap */
-		kernel_cap_t	effective;	/* effective set of process */
-	};
+	kernel_cap_t		effective;
 	kernel_cap_t		ambient;
-	kuid_t			rootid;
 };
 
 /* When fs/namei.c:getname() is called, we store the pointer in name and bump
@@ -83,7 +86,7 @@ struct audit_names {
 	kgid_t			gid;
 	dev_t			rdev;
 	struct lsm_prop		oprop;
-	struct audit_cap_data	fcap;
+	struct audit_file_caps	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
 	/*
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ee7e53d2cd52..464736499c83 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -107,7 +107,7 @@ struct audit_aux_data_pids {
 
 struct audit_aux_data_bprm_fcaps {
 	struct audit_aux_data	d;
-	struct audit_cap_data	fcap;
+	struct audit_file_caps	fcap;
 	unsigned int		fcap_ver;
 	struct audit_cap_data	old_pcap;
 	struct audit_cap_data	new_pcap;
-- 
2.55.0

