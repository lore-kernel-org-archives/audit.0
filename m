Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD07647
	for <audit@vger.kernel.org>; Wed, 15 Nov 2023 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KLrBy9RN"
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB7C2
	for <audit@vger.kernel.org>; Tue, 14 Nov 2023 16:31:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b58d96a3bbso3547419b6e.1
        for <audit@vger.kernel.org>; Tue, 14 Nov 2023 16:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700008283; x=1700613083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0QBTdx9SEDtes3snJLqUjgrY8mouIZlEJk8I8Juc+s=;
        b=KLrBy9RNbcX29Rydq0yy+Bs2uPp+kFwfVVb8lZjG0e1LGG1Fm+uQ2+qGMlsrlGqFI/
         swbVTuW2ViFS4BdazXvdhd352wv8AHWJvywm4e6aKakkm672/9qQ1M7xabVjAWPe2Fb+
         lw/zr1vGvB2/UWObzPEKisUDTbo4evnRq5jzXLPk0pfnWHU1Oz0i/dnrIDkw5onTPh/G
         /q4Sybw33VjWNoX9ZP9wc7wyOEwuTUAi0yLmKGauAxvEWtvypny51IrEmDLOo9+NvIQY
         IPQ23m3Z/fpcw/bcrswkUtjKEPPrP2wQ3Rfe6X2sRZiqygGele7r/UMa4KeF87xtb/64
         y3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700008283; x=1700613083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0QBTdx9SEDtes3snJLqUjgrY8mouIZlEJk8I8Juc+s=;
        b=Jb6IPZ8pAb9vs1MLrhRQhssqWUP95rVrK/P/1JZX8F17aP9XxIdIiwuQcHZjEV5r7a
         rB1mW5bQ9R7LoJHz+bujTzuy18nM1t4oaRqOkKrWwcQkbLvgweOsNqsk8+DGUZ4NIvKE
         6Sej1aYWRONCXjN6RharBEAh++If1gr0nP0k4eshLmZP6vzfrKC2AZp442beR8wks2x9
         thQaO0gPgKGuq9ZsTVdhZTkXMxx6we2HNmPrcyMR0PO0JM5WelGqWSt1Ku00bL35RcHI
         zFG5jTYHv141tC+GhPqV1QjPFoTXQPrXG4QarvII+HTOsO4pEnpmcIdM++D2S5nSvHdv
         dOEg==
X-Gm-Message-State: AOJu0Yxc3Kz0FuAx2vV7RKWY777E2Jbv6Bxz23auM8kzF5dIcZm/s9JT
	BFEb7cNo7jzyjMI/yeiOMe+KzTKNCoMbtCk6Hg==
X-Google-Smtp-Source: AGHT+IGdOdjRocWa3CRq4bfMv5ItELW6gRsuoAJ56l31A439TrrEPVz+jzXJWW3uqg5FZpGqY6P0Zg==
X-Received: by 2002:a05:6808:1804:b0:3b6:cdc2:51a0 with SMTP id bh4-20020a056808180400b003b6cdc251a0mr14250340oib.29.1700008283464;
        Tue, 14 Nov 2023 16:31:23 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id tq21-20020a05620a3d1500b0076eee688a95sm3042510qkn.0.2023.11.14.16.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 16:31:23 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Cc: Artem Savkov <asavkov@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()
Date: Tue, 14 Nov 2023 19:31:14 -0500
Message-ID: <20231115003113.433773-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=paul@paul-moore.com; h=from:subject; bh=2tAvYOQG6Os14H3e8pmYsLssDYzP62DnjxyzZawQaPA=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlVBFR5qwvuDiCPKEuudFgNso+ylYfTc+gUt1PT TplBnHZJ+OJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVQRUQAKCRDqIPLalzeJ czZMD/9yI0I85yZ5yoYJCx76FJxvhHPtLfs+RyuFiSpD0PuQtCV1N/IC5hcCdL5ge1OzA8AQzGT L5RXJgBKdNGOz4mOFTV0Km0+4hXyshQABRXU1QKl01x46yoosudsB86e2mG7AA9EK8ooyw6xAa1 c07a5dcV90kpvFgWDRrFy5PE1jA7yAqOv3sUGkkP45nlIgXJYbkxR2DG/r+TMZdTVXZYbC7Zdkk Z0AqVYW8IMSGeLLXn+v6IldwD1OOwAQasQxsxLO+5lCarjXwOrtLxhgCPo0n5ldKz4hN6WHGT7F efRyVW9zACkKuJpoDXJFSp9yRwq1WErpY4H5sZFUCdKZwE/ZZ7FIdMXLFd1AnMsMZmcbREFjsB1 5Qrk5/WqzrJ6oFuSNLVcHRuFHxOwzV9gD0o/xmoqXGOFGHUdSbxGQQOlOxUnejo3HSjbgjKaDoV VA50aio2o0zEzUE3fNaTFMtFEPuljfUuttNSsAusU6/MMK0mMbBua8RnIXFDMTguBugEPwuybtx 5TA/AYuHRwoxfjFERf9WJKjkaktAuibCWGpEs9j4sJimjsrxzSV4qlOK0tOJ2+wm/V5r32dLCqs 8jsqlOL54Rx1gh9m748oQzEalggRiPPWpxUaOKbuIMgQh4qGy7O26l8aWTvYwCj5tkYWZOe1hyT Dawi57OOKR+hbcw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

eBPF can end up calling into the audit code from some odd places, and
some of these places don't have @current set properly so we end up
tripping the `WARN_ON_ONCE(!current->mm)` near the top of
`audit_exe_compare()`.  While the basic `!current->mm` check is good,
the `WARN_ON_ONCE()` results in some scary console messages so let's
drop that and just do the regular `!current->mm` check to avoid
problems.

Cc: <stable@vger.kernel.org>
Fixes: 47846d51348d ("audit: don't take task_lock() in audit_exe_compare() code path")
Reported-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 91e82e34b51e..7a98cd176a12 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -531,7 +531,7 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	if (tsk != current)
 		return 0;
 
-	if (WARN_ON_ONCE(!current->mm))
+	if (!current->mm)
 		return 0;
 	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
-- 
2.42.1

