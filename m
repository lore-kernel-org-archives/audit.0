Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A7266AD
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c5ngpabt"
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECBEB9
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 11:39:11 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b6b4c2f1a0so1766896241.1
        for <audit@vger.kernel.org>; Tue, 24 Oct 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698172750; x=1698777550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teVKDeXSry2hQHF7npnKOzDDEfx+I5yZGfXECTTMfKU=;
        b=c5ngpabtMvmDlz0OyJ/L+HCvh8kbyv9fNvORVYgKoNzWaZK8/82MegSWv0sPAtI0hM
         vrpPF2yy6uDHDZ4+4zgAvBeqly600o+J2MULGcBpmRrfDeF22woxuqi8gbbJ9N2ROSl4
         5EBRag4WtLbBOzPQBFOkDf2tcPS0TSKtT0X6YyPZ3wZUv+dSBg9uxdMlet1359bZmCC3
         D4Qs+V5XyYaebguCJDVx/+xLG+aXtRnBmUMNlNZNB7ynjTNk4S7HhKCmlOd2byHFaz9R
         Ko6EsyXmZB+WApwCtk2BO0kd9nr4MzBiKCrMED5W3FhynS6yBMJkERfhOB+8InfONnEc
         Qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172750; x=1698777550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teVKDeXSry2hQHF7npnKOzDDEfx+I5yZGfXECTTMfKU=;
        b=J4FiFNzguXbMPZ58+BCCfzsM7WwMQ5OkwMjK78WBbPqEhowHSJATpJhh1iMCkISOzm
         gNSYCyHsOFUlRUMXZ9w9SqIB/gpr8CJmKRemsz2AKYrETIrJFRRWa855y6N4Z1sKhF7W
         9WGUgXH1MygpDr1EcQhL9NdjjtvkW/5wQG5PdQTTz7OtQzB10dldPRxk5642b2PjZafm
         RBBZDzRqtFTGxWkcZbTzI8/BZOSIKc8nK/poueswhHXoLso+KifTVcZP/w/SX8mFSxrQ
         5znIithBz56Zp+Yf8Ws6zoKewoF9fDAvy+I9UCkzTqTXbFL6Wcx2tSfZYP+TdUuHzaOC
         wKpQ==
X-Gm-Message-State: AOJu0YxsdBM71/klEFUXisv14nDMaUolqowN6AdPBQnukC5qfsUINNtE
	1CrT5nfjGa9pv7TfvkD98w0gWpxjFuufgnLGvTDu
X-Google-Smtp-Source: AGHT+IFb2OpfGX+Y0XnXrUcJMfytB7S0Mi44V/hgmkY95IDn5F7AFvTNJXoCv2J7TexKSbw9weT+qg==
X-Received: by 2002:a05:6122:4e14:b0:495:e530:5155 with SMTP id ge20-20020a0561224e1400b00495e5305155mr13468659vkb.3.1698172750358;
        Tue, 24 Oct 2023 11:39:10 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k19-20020ad44513000000b0065862497fd2sm3763155qvu.22.2023.10.24.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:39:09 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Cc: Andreas Steinmetz <anstein99@googlemail.com>,
	John Johansen <john.johansen@canonical.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] audit: don't take task_lock() in audit_exe_compare() code path
Date: Tue, 24 Oct 2023 14:38:29 -0400
Message-ID: <20231024183828.209525-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=paul@paul-moore.com; h=from:subject; bh=w6hfVUmmAt0bBhORMspbrDpZyEP+okY9UQh3w4O/NA0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlOA8kyzjShEdLIi0UGENt3d6iFLvEgA6VRucRg NLZXOAx79+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTgPJAAKCRDqIPLalzeJ c+jDD/9FXrk2UaIHvkIIyyMOyMLrfesgdXrl4aYqZK6q3qwp2rg8xXcxlfvvha1WR9etLBzZNYN EsoMuBKb5hIDXDYFO7ZyVoC4if9E20k64x/w8pBfRkIBFsxxoL1g+2XT5xdJxVwnkaAEYw0m0a+ tATTXPm4qq78N1sJ5qj+MhFcljvHlQdV5VVzU147FgHcNTFVJy1Gn89Juc0U1JDd6ogXbBBu/Q7 acIRlWvjvGh77NzcVSeMaHbFpTZYzcMMKt4d8P6gT1FoL6N4IkbK9SI/1fxF3Z94Sq8vkogJzuK eQCSEUS5UtEp23PI8i3kDfJz4PQWzEgK1XiCRqrf2+zyaMyH59khEouKiJ6vU1078GaojYFwkiT lTD1l0pZ5su3KwlJA1/vRw1JCB0639bj5hNFy+uBvO5PFKjoLLW/hPbmlehixroJAGX5//bHCMS J89YyN/UxSNjElPm64nkUNfWqF5MlRpqamlJTn/WAos+0wpteNyuz98pwm6bXiJj2HjTODjVn37 8jUg30obYDShqR+tea49J94C3EHZ6aUFX9RI8vcGXpU0sIlYQ3DU7NbEYoxBLmKCXC1wKkOxvKi OeMgfCAA2S9WyyOsNybNelWmCd5EO4fvtIv4xragsqr2zxeNRhjw4kV5YTO+S52g0ikmAbOgwkC m7bTMoPUyKieaGQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The get_task_exe_file() function locks the given task with task_lock()
which when used inside audit_exe_compare() can cause deadlocks on
systems that generate audit records when the task_lock() is held. We
resolve this problem with two changes: ignoring those cases where the
task being audited is not the current task, and changing our approach
to obtaining the executable file struct to not require task_lock().

With the intent of the audit exe filter being to filter on audit events
generated by processes started by the specified executable, it makes
sense that we would only want to use the exe filter on audit records
associated with the currently executing process, e.g. @current.  If
we are asked to filter records using a non-@current task_struct we can
safely ignore the exe filter without negatively impacting the admin's
expectations for the exe filter.

Knowing that we only have to worry about filtering the currently
executing task in audit_exe_compare() we can do away with the
task_lock() and call get_mm_exe_file() with @current->mm directly.

Cc: <stable@vger.kernel.org>
Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
Reviewed-by: John Johansen <john.johanse@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
- v3
* added a !current->mm check
- v2
* dropped mmget()/mmput()
- v1
* initial revision
---
 kernel/audit_watch.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..91e82e34b51e 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -527,11 +527,18 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	unsigned long ino;
 	dev_t dev;
 
-	exe_file = get_task_exe_file(tsk);
+	/* only do exe filtering if we are recording @current events/records */
+	if (tsk != current)
+		return 0;
+
+	if (WARN_ON_ONCE(!current->mm))
+		return 0;
+	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
 	dev = file_inode(exe_file)->i_sb->s_dev;
 	fput(exe_file);
+
 	return audit_mark_compare(mark, ino, dev);
 }
-- 
2.42.0

