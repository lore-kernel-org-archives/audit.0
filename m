Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C726266C4
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JCxi/+KI"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07619DD
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 09:16:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d2f3bb312so30507976d6.0
        for <audit@vger.kernel.org>; Tue, 24 Oct 2023 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698164204; x=1698769004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGB3PEMG+MujKL6b8e6fvaXxyQ58mXdijTNUEg4qoSw=;
        b=JCxi/+KIdqEjW77+YHpQsYLAyiSrXQq2fjgpTN8mEmQpCWCDgWSigjjRiaeIetlUXn
         3MXjTFyDX/02o69Vw5B8ktUyEswn5hQry6fzjlQkRMGO5w+xSsvtE9NV0Ix1S+k2HjCr
         BdUBblWnw+xxUgkIXJ18OihwJWaCp9K7iTDQ2Vr5emNAAbA6Ac+QG+ZIa/+G/tKOkgzY
         ymjYJAn6evoz4zdaVFXacVqfFbPu8isD5y7nUOxewKvZzRlfXuDXd44hismAZYTQvkIU
         KWedfH1QlyGlsdbQvpxZzFAQch/CJNsbAQOQt9Gj/wKv3/d1j693Qd6MvLJEAAVco9r6
         rj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698164204; x=1698769004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGB3PEMG+MujKL6b8e6fvaXxyQ58mXdijTNUEg4qoSw=;
        b=bzTG1VSipLLorWCN2+fy2me94TpQFq4TX+AtiEYf4kH2Bzb6+Zl8LUNYYHTkVezwmj
         mdcUdXDmP2TNFijMI1KD1xwXoKeggu/+efzBDqQfNDzb2On2VVHoasMA0Nw3d1vjP4R7
         UFAploLrX9Rl8CvZxoLEoGQeLRg1alN0UAE7pRM6AQohsUePa7oKpVfaxY+GFFongfGu
         3+JTAJ2m1VY91NANkjOJri35qKGl2SQnC7NzADS0/7xgqLP0V+HO96vfCj3FnDQ8lx6k
         wHnT/zlNn/1Gpkigf+0TI9VfhKybkpwIih+53G4yajbYKRURlCWjV2UpZ/vg76PjHNEd
         QHkA==
X-Gm-Message-State: AOJu0YxLBk6U7tG/JYqFrk5pt2C+A4ZwrlZ742x2fbekxLlEfmkCumAR
	VPE/KSZ7iHqvshBhPnDkN2t1M4m07vJfP26Mrg==
X-Google-Smtp-Source: AGHT+IHS7/02j5a2Wk9MqrTnZ92I0boXSCPpK9oxriRG8LpoGtVT2YDX1S8oRU12aHpGgsMizpYaOg==
X-Received: by 2002:a0c:f383:0:b0:66d:8184:dd8c with SMTP id i3-20020a0cf383000000b0066d8184dd8cmr15043937qvk.54.1698164203753;
        Tue, 24 Oct 2023 09:16:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id di12-20020ad458ec000000b0065b229ecb8dsm3757152qvb.3.2023.10.24.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:16:43 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Cc: Andreas Steinmetz <anstein99@googlemail.com>,
	John Johansen <john.johansen@canonical.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] audit: don't take task_lock() in audit_exe_compare() code path
Date: Tue, 24 Oct 2023 12:14:33 -0400
Message-ID: <20231024161432.97029-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=paul@paul-moore.com; h=from:subject; bh=/9zOAzmNwzVuGa3PTX8ygePMiJl7AUtVJLPUtUNNZUU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlN+1otZ+QInkIHfU8ftareLM/EjoDTi7Q2cnuO O2GNyuN1aGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTftaAAKCRDqIPLalzeJ c0EGD/4jDdQ2J8Ro76k1L+8/4Pk0F86StykzDRNmITXFTAyjJ1rD21wOgeKxj+8ScJwHlYBUdd0 S9QJHTzZFGOPpadl8X2QifAbcZemujuXhvP0AqFY4OnwUjlrlD1MAfWzARE/dfbuSMzRhgRZ1cA VOAQiwDpHhp6CkJCSWB+lWCODHDn4O+ykhWCSH9IRiIc+Thk3RKTlAZgLLlAxA3iWfzuQHgIX1O ALTztfZlILqnWYekzYlLBRx5Urn1Ld0xMHcqBgcu2HutNCgvqeu6NJsNsyIYnS81lM6OBlc7snT 4kYsIYU7qGegHZybmeN1gHPKKxK56wNogvBii9AxLKzfXjmySJHZJRTekPjyyKoHSQGC0cF8pbT AFgypSlLdorByRcpEpEo4Uf49vrFaSYcY6slB8sXkno/DZKrHzsdJFjCxtkPtsiVKzCCQni24tA BF6smOcvwhvc423zmS//TtstK5Epgf5p1KvbhHGif9rQzmY9GwIIj7/+zThbFlBrICuH2ydc+nu kK8+iHeEVRCIDsFdI5jV4nnYzBaCaXSyj44mw20B0wg4e4FyoGyHSkTI2FuZDRoHc45LDpuKg0B PnMz4GXNimCshUBWvflNRfhr319NULmQEnIVWj79TqAGljqLeCDuomepe+esSu+YRBg2kiBy3GF sKbsrZjTLP9A/Hg==
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
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
- v2
* dropped mmget()/mmput()

- v1
* initial revision
---
 kernel/audit_watch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..99da4ee8e597 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -527,11 +527,16 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	unsigned long ino;
 	dev_t dev;
 
-	exe_file = get_task_exe_file(tsk);
+	/* only do exe filtering if we are recording @current events/records */
+	if (tsk != current)
+		return 0;
+
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

