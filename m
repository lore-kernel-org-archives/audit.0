Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E314293;
	Thu,  5 Dec 2024 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364668; cv=none; b=MWO/eFSzylCfjHajsvmXCMR//fYBlM98DZGqauWyzmFaimMeVYfjW3x4RU851SWR7WnOibDkBUX8YPV0WVaAJzTuXE0Do+bXImx107lBMMzDi30TeI+rN+5ssg2p1ZkqQn0wxTgYaauYiVtttUVskoPr3rIxMZqWA1Nat8NfJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364668; c=relaxed/simple;
	bh=OI1C3FcwMoopDMPKdCCzMjgaBxq20WYQtvRagIuSgbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TeGUVQJjb2R8rJMwIRFSeTPiJBOgxs1C2HMs/RMNK01k35Uotpd7SrOBSA1RzF5eKzjKZhQbsayyZKptphiN3ZhkAqAEV2oMU9P2WHlFxd3b0BJU3FmS8/lL5G2R1xp8fRNpk/VymHKLu9m0kc8PuB6lVkiNZQYV7Mc5+VFdh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtG+cEs/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtG+cEs/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215ac560292so3663875ad.2;
        Wed, 04 Dec 2024 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733364667; x=1733969467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIFAae5/53dx1Db9qH0BBINR+01DcmVANh9NqUuaEGA=;
        b=FtG+cEs/dQPw2iFM058GKHXdSwHMMD3sOchthcu7BVPn0PAqUicmLebSCakb0zneaA
         SAonmWALMPGsYLMaaIq7kU7zSfb5RUhvHumOq/K5ytQgL/iJEE26ztK+EugRl/ArwDHU
         U4ql7wzMQhlxdojIUA9YhlaLDdRaIv58PXyWxnIseYwxxfH2BXW/cye9HoWs/3z7PsYG
         eFj3qAFc+LcM2pTy5qrrBetQWAfC5+TPzAUz135SIFM4XTXcZ+sCb450TcnZ0cVW8vkl
         oM6/j8yzK76wQjTg3Te2eGiNC0MVkEB3gvdtPK+1LkUJWmsp6bB3vPrK1R+D9eHT1RYT
         LwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733364667; x=1733969467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIFAae5/53dx1Db9qH0BBINR+01DcmVANh9NqUuaEGA=;
        b=TaCO5FRTrMKxC/MNiTlDR2pIqBaUoUPn7oD1iwyAiXPQnZ+2Hxh5SWNrEWGG7Gv/sM
         wjoT3g0G7PtMoLypuJf5pnYsAry3H2Z5qcCrSkMEa04+5k1axw0wNCuEsnH/q8KXusYb
         xnzFZXkUTX2Xt9x8ojzwFoGo1tw6ICPNV5q34iaMHSgEvIWy0zH+vkbpnabHkq7sQcXM
         bjEJNeHKp6417oASYpH8nrzpeH97/o+hHcVVPyIYSD8NP78JNJuS9kN8bHD9qtkAggRq
         04W4e+Yi5JL5CRYySI4U32S+tebbD6lFNo28JeW28hOlghazY8+xFuz87Le5RD3PdLz+
         mrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/WCJwLCCdvpIluCB81Wp2Ps7ZgHrzbpuDMUZgF6L3NrURDfZGFdBEhVgLBE1IaDxFJ97ehgVUExjTb7me@vger.kernel.org, AJvYcCXiDQ1ndX9BenX0iE8y2dixiAe/qSac36sVCEHa5dIDYbhXTLgc6nirWRA7cRdZfkc9eGt2bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38+mU9HpEHGN+B9fuJ+FtZo/ltip+as9ROFoG7tlfTML9DYYm
	EorKEsOIeJ19myKnhdsVBEmuYsGXcSsvBYYMFFGER3pYMhpAVbRJ
X-Gm-Gg: ASbGncsdDekzdLd055MdGjZMdWSKEWPFtHX+THzA2IKp9DO/1PqjyY0AmedmziL4L3u
	SlfGIwkvSJisszoaZ/rSFEYJQ1VpDVnPKYGqR7i39BkKtzF4wB1YZzgInIEKN41PdJW0e+ZaUwH
	zyYy3PjAPd8ZSAuH4rwwWwWcUpx1CPo0yHV09/lIMEXQwa7eqExRzgp7tkTNEfzdFNXppWk5Ba7
	s4WBOUlzzyG8BVoptA6iqMqjLE83ny8/3YxeB+BzeZkmOXYKW5TcNu2/hYrjafoRX1o0fcbz7+2
X-Google-Smtp-Source: AGHT+IFW+abQ1cQEgXYe1J9rz1r+lyp7l2EB8L6qp/dVlMkpxTmgrlpZcDxhRU9P2w93JlMBKtSxlA==
X-Received: by 2002:a17:902:d2c7:b0:215:b18d:e1 with SMTP id d9443c01a7336-215bcfc2ab1mr152750215ad.24.1733364666591;
        Wed, 04 Dec 2024 18:11:06 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f263b9sm2028915ad.226.2024.12.04.18.11.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 18:11:06 -0800 (PST)
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
Subject: [PATCH v2] auditsc: Implement a workaround for a GCC bug triggered by task comm changes
Date: Thu,  5 Dec 2024 10:11:00 +0800
Message-Id: <20241205021100.86390-1-laoar.shao@gmail.com>
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

A bug report has also been filed with GCC [0].

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117912 [0]

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

v1->2: Add the link of the GCC bug report

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

