Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930631632DA;
	Tue,  3 Dec 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205850; cv=none; b=VQRsVlHCiCqFYtOQXIdW5GRL4Q+Jc0S7oXldaigcUH6fnyC9hbK3W0ePUdwyHU3pV2ljYBOy0aubImvduoey6XM0z86qGfRPYE5BdVvrT4MUfshekTmLs/hulUBqfxaWZoci2qsKCeXcpuTCqVkB62QA0gmokWWGNsMSVZwa3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205850; c=relaxed/simple;
	bh=LKWkIYeNaeUX1VbYiO4MEr1omwRKKa0CAEDzdnG6YDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+QbfcPwTp87L7Ab86YUqPBDqXtTTUVeQYio8uwRHyX7zijPgqxgQUcmiJAXZ4drCqyIqiTEQre2mrRe3hlxOwuSJOXJgoqyjw2ej856mZnWhqiyhvPcO0rJbDO2QjWrrV65LNgr3xJ4xEkTMVEDGYv+Svsvsm8FSq/yiSxD9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVYNs+u6; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVYNs+u6"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29e70c9dc72so921881fac.0;
        Mon, 02 Dec 2024 22:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733205847; x=1733810647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58nYp1zWf0X7j1NYT3FBTG8N4TZB7I5pgvtXv7XqyBs=;
        b=kVYNs+u6FoPic8FvXZvQ55fD50gOtoQpRRLts4RZGgZvslRICEmkvIF43dgpUobuzE
         2T48BnOX55yDwijnnrdvyNRbeyHgXQc30EL3pLxArEdZ05kYxTf49MyDIvb00dXoHV6B
         9qfCHwKf9VdQi/eeA7ScE9zj5bKuORO0fhyJMNWsaZb3gcXoUrpJvbeMthZlL7MbE3gj
         K9V7qAl9L78IJb4XRG8JFOBGrWS/SbXqXlQpbtMGwS87bRhZkV5BGAaqlCuv0/J551cH
         P0Zxiw8DHBjuHwwNIZwZx4gbAxqwuCcV9rSoVO7rcZpDqCzEbf0hN8nM5d9sC+m3Wne8
         X+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733205847; x=1733810647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58nYp1zWf0X7j1NYT3FBTG8N4TZB7I5pgvtXv7XqyBs=;
        b=PZaEKgd+61hbLLO/ghthp3XhwiFik/p81wpiXeqK+TjuZQySn/kOA/oBunUmaOQaGN
         0O/UcVDsBwGbagNS+jfPIGD5A/7WjuK89zZG0ort/yFaqylekP2QmAahEpKONFztTwfJ
         +RLJywpljPJkBb3hrF1aVma6MauklFR731EwQJTp+kg52jf/7RqmIkHNE7QyD2LJjOYH
         OzpNtVLw47L92/mIepeaMsH784Bx5abvoHU3w75uL+3FFmJvXYNNU2LdjVOT4MJcYneT
         R8/h9BEpYLEx1dzaY6KlwyumV5fn6ktvcW2SsVzDymRJK7XKbkUp/r1UgqQSqa2z1Uwx
         eN8w==
X-Forwarded-Encrypted: i=1; AJvYcCVBtgC224euinuabAgFwuFgHjR4+CezqUwCLc2LLGFuetaSbepeB47W7GNNZGfoP9fChDEaP5cqpVA45S/Y@vger.kernel.org, AJvYcCW25QysZaMgiemOzO1s2ADx3Bn1eMB3KmQamcTEWgj765tWwxrtQnR+t7ISvALH2UGfvDLSbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvldF4rfFr8GtgpmpYvn3UWiO3iq08bnP07f5PXg7tzSQh8uj
	m8g1BTg+mcuqCTucDT1bjyy0j/6zEv55gRU89laz8ege5UAPV0nc
X-Gm-Gg: ASbGnctCurA+lfe+CYGGCLEUOGf3rEmIewLYwivQTbZZCUKCo8ljrDKdfn8kc0bt7NC
	HUlVgQq2ccYTveG9KNPsz1UlXbCUaaXAxkAjJLXz3TUZzu+ckpePvCWROoZizKBTJnSltlJHapK
	yrgYKZw7hwOTC3BQKgxLX7DhF5nM5LaVUfmKx9NdO+UI+v2ptESs6oevvOsd/XqwasqylXQx7sg
	5irPBWcN7MrtpS8eJyk165wWsUet3vDZ00lFuT/PlzMh9+imhz21uEAGk7676oaIMCEzI5EwHw5
X-Google-Smtp-Source: AGHT+IGCA+XGSbmmnllYuaCoWFwK1ZCSMRimh3uYTeqBCIVvvpkEM0dAcJdycqkYNiBsiePc9nFjOA==
X-Received: by 2002:a05:6870:b293:b0:29e:362b:2148 with SMTP id 586e51a60fabf-29e88690b23mr1141350fac.19.1733205847522;
        Mon, 02 Dec 2024 22:04:07 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c385ef8sm8861201a12.56.2024.12.02.22.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 22:04:06 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: paul@paul-moore.com,
	keescook@chromium.org
Cc: qiuxu.zhuo@intel.com,
	rostedt@goodmis.org,
	lkp@intel.com,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang shao <laoar.shao@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] auditsc: Implement a workaround for a GCC bug triggered by task comm changes
Date: Tue,  3 Dec 2024 14:03:50 +0800
Message-Id: <20241203060350.69472-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yafang shao <laoar.shao@gmail.com>

A build failure has been reported with the following details:

   In file included from include/linux/string.h:390,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/auditsc.c:37:
   In function 'sized_strscpy',
       inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
>> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
     293 |                 __write_overflow();
         |                 ^~~~~~~~~~~~~~~~~~
   In function 'sized_strscpy',
       inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
>> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
     293 |                 __write_overflow();
         |                 ^~~~~~~~~~~~~~~~~~

The issue appears to be a GCC bug, though the root cause remains
unclear at this time. For now, let's implement a workaround.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@intel.com/
Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local.home/
Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF389362@CY8PR11MB7134.namprd11.prod.outlook.com/
Originally-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
Signed-off-by: Yafang shao <laoar.shao@gmail.com>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 279ba5c420a4..561d96affe9f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmprop_obj(t, &context->target_ref);
 	strscpy(context->target_comm, t->comm);
+	security_task_getlsmprop_obj(t, &context->target_ref);
 }
 
 /**
@@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		strscpy(ctx->target_comm, t->comm);
+		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		return 0;
 	}
 
-- 
2.43.5

