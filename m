Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F0CDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJRWUf (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRWUe (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 18:20:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB982111
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:20:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7781b176131so137375685a.1
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697667630; x=1698272430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxCEfihGPhE4CcRlvsov45x1kZKFnCAgjmABL1WH3aM=;
        b=S0KVT4SqBlJ+YSYcvSY6XzQVxDyDAckP/yZ6tTWiexNSxKijSIVC2AWr3awGUdci+1
         0vZ+O/o/xzYTUXAEszLMYQgKGtu94ulKehNPSOSjcQWSDJBbxN22bNAOwP3f1Kwhlkth
         Kj+n9NitVAsZiP/HU+Y+/87WPd9YGZSxBNzNkRRaoolhHfmyf4ckjSw1OaZVm7CBjpIp
         Oeqzks4Nt5gHv4AOtiqKST321t72f2VcMz3t3W5HC8x9Ircvnk0c7RSiaYxtlhAbCBUL
         XXYu6CVUpkaSZVvlygR/ljUbvlTfnwfRCEZqjT4iioRdjZOhW+vVZ67/k+DQnudk5Y/t
         rS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667630; x=1698272430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxCEfihGPhE4CcRlvsov45x1kZKFnCAgjmABL1WH3aM=;
        b=VWZfDrWQt8vlcgxdIqx076NqWe0hpNsuFDdUpFK9F68DqWloqxlx9aoELisA9Gavg1
         SW28k1If0B7zT9GHKV66rxwTUhvqnIx1ugYrIzH4qA5qIprFgcHOvBZLKPCY8oOQcZRS
         TDqz9OHsrL1ysfMuXZVNM5nnCTZgNg1hchNuFzzlizH1PHMIhDegVfHjlgZ0oczbDWpM
         4NpKlDI3YeCSZaco/1vb7pNPOIkr1j2CZN82xTCEP2sprhM3PExxhtYXF5P7OpyfnEe2
         OUuOGT9A/E/vOkIyD+KCxruBXZnfr/GCLhdjKJjzh5EQMcotRu5p1vFUNztaAUS7pGZ0
         eMJA==
X-Gm-Message-State: AOJu0YyeN0g6Z6+hTROpnzpZ+7LeKSPF0pL8pXyZ3TZdyR+RYSRKfTFk
        Q6c3PuANVf37AUspE9k/mxRsUYxwkuYD/cHlew==
X-Google-Smtp-Source: AGHT+IExpOXlMMKn7U5ru5sm+1FVGwcWN3w7mFZabMkm1MLSp9cDRJueVgVXh5iHAnYC+EWSzZ5zow==
X-Received: by 2002:a05:620a:29c5:b0:778:8c0f:b9b4 with SMTP id s5-20020a05620a29c500b007788c0fb9b4mr636484qkp.28.1697667630630;
        Wed, 18 Oct 2023 15:20:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i24-20020a05620a075800b007742bc74184sm278670qki.110.2023.10.18.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:20:30 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     audit@vger.kernel.org
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>,
        Mateusz Guzik <mguzik@redhat.com>
Subject: [PATCH] audit: use mmget() instead of get_task_exe_file() when auditing @current
Date:   Wed, 18 Oct 2023 18:20:24 -0400
Message-ID: <20231018222023.371274-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=paul@paul-moore.com; h=from:subject; bh=OFVg1vlWv5JP04SKoEkf+vxQEGoJuIBq+JJr7g0WP/o=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlMFonFuHAcElItyXSOku3HjY8WSZTma1zFcSeP 43VUlooCRiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTBaJwAKCRDqIPLalzeJ c9NID/sEeSNqwn4FmA59Zp0q6P8BiMyb0naNTmt4GdXZR53SG5V4x5i57BLbGd3q5KVvgnuh0yd 3mc/rCS8GFeiVxUGNseh6rMIHhnFzN30wqUnaZ71r8HBhfGOpTkJebhgaTtIDNGjROYwOQO9e7H WmuZJWOsDxpe7ki6/RWbc43bVUMMOuc+FE/h1ojKewuHO0TnUF6n0M1wagJCTCSeOxDkRDDHmXr LiDk5q3qDyZnozdV7WfGIjk+uBQD8aGiz4TgESM78GOx76/OA5VCTG39ttjzaYx+0R1UuNxSjgS wj4dH14cmyDZQM02EWeuJexkoLnJH2YpwlplnjxS5S7oxnp7nNYOU9HkBkWgryuxNC9suGyMoS2 ZW4UqEVPkbBwtidBxymfvsu6Yis6CHjxOY5YVizi3X8EqiRiQVl0u3EAShWGHu3xv5tczzYuzUi SXRpjIcNhhuD+ZucXRrBbgFDfWXJGmOph2cpSxbVxvDImcXL2b8l9gIx4RG2gZuwNYY16gFAxpA UKdOj+lSTgFEiOHxVCTH9f6CoG0o4o6JEYmgPsJrSldy2F7NcwlEIYZ+ejwRncQOrc1OHP3x6Rt rj9XATDHa2EcJB2AS7gU+CHdHGHoK4JDkCC2iVK+xwpWm8g1Z3aFRn7gv2ANuXiKjRenkLrgR3j jS3v/i2DwUoK53A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

The get_task_exe_file() function locks the given task with task_lock()
which when used inside audit_exe_compare() can cause deadlocks on
systems that generate audit records when the task_lock() is held.  As
we should be able to safely access current->mm we can drop the call to
get_task_exe_file() and get a reference to current->mm directly which
we can then use in a call to get_mm_exe_file() without having to take
task_lock().

While the audit_exe_compare() function takes an arbitrary task_struct
parameter, all of the callers outside of fork/clone, call
audit_exe_compare() to operate on the current task_struct, making it
the common case.  In the fork/clone case, when audit_exe_compare() is
called on the child task_struct, it should be safe to use the
get_task_mm() function as no other task should be holding task_lock()
at this time.

Cc: <stable@vger.kernel.org>
Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit_watch.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..fa3e6ea0e58c 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -526,8 +526,20 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	struct file *exe_file;
 	unsigned long ino;
 	dev_t dev;
+	struct mm_struct *mm;
 
-	exe_file = get_task_exe_file(tsk);
+	/* almost always operate on current, exceptions for fork/clone */
+	if (likely(tsk == current)) {
+		mmget(current->mm);
+		mm = current->mm;
+	} else {
+		/* this can deadlock outside the fork/clone usage (see above) */
+		mm = get_task_mm(tsk);
+		if (!mm)
+			return 0;
+	}
+	exe_file = get_mm_exe_file(mm);
+	mmput(mm);
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
-- 
2.42.0

