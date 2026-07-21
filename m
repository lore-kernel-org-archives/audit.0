Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343146AA9B
	for <audit@vger.kernel.org>; Tue, 21 Jul 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648277; cv=none; b=eeNQsJd7Bg6xSfTSPRT9itTKmi8YzNmrR3LhcvKmh50yPhVZSto4awV3zDeu63G83aderUT3iWQrJfSyy0D0MVTEKXCBFfaBa16dn8HQOY3KsImAs/hFJQmQ14ITkBChypEkByeRg/AZp2Y7rUGi6CQGuULdX2Ayol6FdE2Q7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648277; c=relaxed/simple;
	bh=XnrF4jM3VsNJbq39W1l1NtVusqGO9Pw3VlDvaFcWu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi+gnXSQogEzRk5z2WWWf0pmNRFVxWm79e3Ds7AJjaf/uONTvNMjjQ7woas8Yj41JaKouVYtmFmIOr1MEEfg8v6lfsYceJekNWOLGcLytdjMcLL7r24w06V9QaBFIEbf/MGvFTGbcxlj7jIXzCu88mWgb+qpSrxyX5JfnaoAq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZWqB9m8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZWqB9m8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce7d2adef4so115830775ad.3
        for <audit@vger.kernel.org>; Tue, 21 Jul 2026 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784648275; x=1785253075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7n0GnfdVUUajTbZpgoZz/1nP3FrPusnKT7AQr3jWXuw=;
        b=KZWqB9m8YdwhDAzD8GVaEJhwglDt3xqCp7/HAuwimmQNemii1b0ucljknyKnVO4OMo
         OwY3+nwdfqgHFjI/yOTCVaHYnya6c/GqNzWWP9ChyYowRZG0khSTf4LK8YAt5siX6giE
         7EMRjQjDSy2vUMBPqV7B7geWwxOO0Zdy0MS4JYEFnKXBPHun4m0+aspegbxrAJxVs4Lu
         Vg2trDHrs61LRKq4huR8ucZex9tB1zrXZC3IIYaTqmssNwMShsWTmvaiGnFbeD58mEui
         xVLchAKOWkHHNirE39Hqy3kU/WjZNTknfF0CY/WWX+lG0RvLvotwOTPJSLA2Fv9wN556
         5QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648275; x=1785253075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7n0GnfdVUUajTbZpgoZz/1nP3FrPusnKT7AQr3jWXuw=;
        b=NKacIcsy3n4ZxlaWVsU00KVmAa1ln1jHhNV9nDMXcsdn5ZRsgRR+wDgICukBZwfirs
         eOPUrm5IG6ny4HLnTyPcfPqiMRfY2gW4a3EvTTYbjfOpavpeVvxUAyqOIk0BS1rBX75C
         uXPgrR+72nl1BhlQGQhcyD/VY3+GgTLLmltSETmHVCycKK/DquDOT9NDF+EjXSo+dYXm
         ECVlYWPiOkNYGDWdVuJMpZD3CchAr5NHP6Dw7n34TpO51WQtaKGOE06lccMUNFICjjwQ
         My5PSfDnH5HxRj3eglphMRy+pXhtBYGsUyCpH3n1gPJkiKKcVlvSU1xv+aWP4x0/DgmG
         KXVA==
X-Gm-Message-State: AOJu0Yy/WL4TWwBHidL6H4Wut1Tpufr9kvN26aUhyFSF6tyyAm87mwK1
	h9/va4BxB1+uj0dJvLZEUk7wYWVsCTAQvsYwm4HWw3JEtP9y5cI0dubWmi5NTMGw
X-Gm-Gg: AR+sD12gX3+XLbqCbDXUMNP/iKszJ5V5ibZ2iTqv8DWm2U0qCf7iqdG2q14THqbJo+o
	GQnr3AEiPCnAkNULv8r6yENWT3+A7xpmmChaOfP68j0DsecWA4yr7tJHLK8kDB6sWmCRHHWooYb
	Bcr79Ul1aHFvo3U80euOKWB0mXV4sUEpsSdxQwaE/hZK5+xbpmjyI93N0l8yjAPk4r7/etHUJlg
	T1xMNMDPFveRl8sS06ayrWfdZzq8n7WNfKUvexq0+aM4RCaYJ2oNSV2tIbnd7YpiVx6IJ8f2vW3
	IY5W6zVjPH42WoABJHySI0jy+87LmFo5XLAAJ7WTXIsrhNljsKL39y0EX556WhyqWRPJJCp4VY3
	2Q59R/TbpL+F3oBVMb5PLLBpztvkXNZwg02XbuKjleatQtP4jJVBxTwMU1yPH2pTUwqqJTn5H0J
	SmEYYUjjbCpKIijLXTqetXBlQwx4KJ
X-Received: by 2002:a17:902:e848:b0:2c9:b2c1:13ec with SMTP id d9443c01a7336-2cf348416fbmr224038085ad.11.1784648275639;
        Tue, 21 Jul 2026 08:37:55 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1ef8sm81759245ad.21.2026.07.21.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:37:55 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: audit@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] audit: fix potential use-after-free in audit_del_rule()
Date: Tue, 21 Jul 2026 23:37:41 +0800
Message-ID: <ffdeea400054f4d42e394d09003cb4dd5ffe862c.1784611349.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784611349.git.rakukuip@gmail.com>
References: <cover.1784611349.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

`audit_del_rule()` destroys `e->rule.exe` via `audit_remove_mark_rule()`
before unlinking the rule from RCU-visible filter lists and waiting for a
grace period. Concurrent readers in `audit_filter()` and
`audit_filter_rules()` still dereference `e->rule.exe`, while the fsnotify
mark can be freed on an independent lifetime path. This creates a use-after-free
window during rule deletion.

Fix this by unlinking the rule from the RCU-visible lists and invoking
`synchronize_rcu()` before calling `audit_remove_mark_rule()` (and other
rule removal helpers). This ensures that all existing RCU readers have exited
the critical section before any underlying resources are destroyed.

Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 kernel/auditfilter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4401119b5275..7f791afe5791 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1045,6 +1045,10 @@ int audit_del_rule(struct audit_entry *entry)
 		goto out;
 	}
 
+	list_del_rcu(&e->list);
+	list_del(&e->rule.list);
+	synchronize_rcu();
+
 	if (e->rule.watch)
 		audit_remove_watch_rule(&e->rule);
 
@@ -1062,8 +1066,6 @@ int audit_del_rule(struct audit_entry *entry)
 		audit_signals--;
 #endif
 
-	list_del_rcu(&e->list);
-	list_del(&e->rule.list);
 	call_rcu(&e->rcu, audit_free_rule_rcu);
 
 out:
-- 
2.43.0
