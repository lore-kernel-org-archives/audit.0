Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569A376A16
	for <audit@vger.kernel.org>; Thu,  8 Oct 2026 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431047; cv=none; b=aRgfSzHpRtGIwYraai7xV7L7lUrpbkOSv4SSd5k2jKJYDBWO4dJ9Vmup8+oIDEPH2MArAojY83awsBWJ94WcDiUA9VskOAjpoo9pqJIPhb2tO6lUVqfyJ8Z5gpuKYX9KBQZrPnIGqyk80+xSE2VXyyTvGtXAMzNsupIo7PHyAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431047; c=relaxed/simple;
	bh=Cigqw7alaqMD6veKjChnhLsYweDGOcKz7YUcqTCBfzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9HwN0/zdaDIMdclDmmFa4WhhI3TWi5D0oClSFban17kK+w8XySrn7pz+qeRnfI8v0rQ9yZR4Ml/jdJJd0M8YFzVvAum8GX/NjWmRqbd+9+bNkgKX5DVxVrBzUwMF/OlhUhp/cuXxTqiPAtOVYZLOYhHCC8DeVhQv6Ol8aSiPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT5Ivd84; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT5Ivd84"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd9cbb661bso20213795ad.3
        for <audit@vger.kernel.org>; Wed, 07 Oct 2026 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431046; x=1792035846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UWwPXhJHy9dia16H9fR1NKH9kFmP3Q3JfyJUA2WzN0=;
        b=TT5Ivd84+8fJ6DSLKJOaVdR1ZcybNDZF6cV1QMMpUa4aJQmAJT9SawW1OeGvkpMwSO
         cGINbsWmvBCabboVKphOHk1EF/jYWGocaYzwyair2d8Xk3Pomrz1mqEK/eJTEm/aBIYD
         ZEfIU+v8GKpcQVavzB0X6dPJ/XqXkqWbsKHlxdFoExnEUzqMqOEy2mqBr28M3oD7JGyf
         YA/7l1VRYFZd3imTkR66rX+kZQ/b6hy4XsorBrfav7OpcZSB97yjYYOAR9aNPmqo8b+G
         cD+MzRSy++T+nd4hlLcVAHZGix0omZKKnEFdlB2ZsGN2/1EloKBvy6s2f1Z2YowE9uTD
         01fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431046; x=1792035846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UWwPXhJHy9dia16H9fR1NKH9kFmP3Q3JfyJUA2WzN0=;
        b=PQHX9kEbPgVd8AYdmtcwPnUlukwQIydDWHgdv73Hmrri00zACcyX79S3TrfmZhdY4b
         fKcQsQRDlWI3wkCzi12DRnhCcvG+5iIVLtyb0fUMm62uiOgHDOoPAm7VwiRdLFXQ85GI
         fbDiTxdl9O6bOiQMpAD2QrxONt+o6Ajy5YMeG09wXn1Cyl71l/zvPDcwOLCXeMzDcTDv
         Y1qfAwuZvEbkBnF2vYu9aCoClRb/oxJLgeUODahk9ynubXAD+3VXcISDSBBL5hAe69Vu
         dRYDzE64p3IM7ftZ4Sfs6w1Z0GP5yL6LJn6xLYHC56n9W8F1+o98RqfqtPBdCWZ+t2gm
         FLxQ==
X-Gm-Message-State: AFq9FYIRCygunsn5aKDHzMl2XKG71Y9q6GWH71xJcAvJbo6FCXwIF179
	U8I7qhZZtorg0gx6/pu5Uyw8DNTpqdHmYI170fXg+bNpDa5QkoPcyYfc
X-Gm-Gg: AYBFou0Inc0XdSIPpW4u45uk90iRObyBVOt1DeZE7Dsd05IqlC4VbE+BilsVUtlc/lv
	xCzoPEhDVlt+hwpZTl3mVTFlZRMR4yPK/Q3/r22p0JymHrBCN1e/+g8pRDfGqVvzTSRlNKA6/Xz
	ykqpvtt16pyXt953qkZCNntl1tNdRD7vMdr4M1U3cY56DzF+MpUCk4PUDdydFDE36MBf6DlUzle
	V4V8ZUT3539hRh+rMEq59q+uHwLoVl71iRPzxeSPZo3uEEY5aB297eAnvIP0kEUVobQpgYd4YDC
	3Fdx3tXiAxM+B/5a3nbVVI4shH6/BctbuuXlaT0N3v5uK9vcMu3IFulPUztK+2ZltfkN0ESWD/P
	gAlOdtWSjV46p3s+vfzG994PRN45jPHz4qHf6M/qJUEG+gHb1dFmuOEYjT9PW/iMuRAaIYpnXNU
	OxyR/typbhR7EgFCPwllldads12VibkgrLi7wNX0LSqBtuofe9/dPifnb1FUyYVTJETMYY/Q==
X-Received: by 2002:a17:903:110c:b0:2dd:c100:943d with SMTP id d9443c01a7336-2e60057c861mr46793765ad.59.1791431045966;
        Wed, 07 Oct 2026 20:44:05 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482ccb3sm18614595ad.51.2026.10.07.20.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:44:04 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Subject: [PATCH v2] audit: annotate the lockless read of the audit control lock owner
Date: Thu,  8 Oct 2026 03:44:03 +0000
Message-ID: <20261008034403.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_ctl_owner_current() reads the lock owner without taking the lock
and KCSAN complains about it. Only the current task can store itself as
owner, so the check can't give a wrong answer. Mark the accesses with
READ_ONCE() and WRITE_ONCE().

Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39b8fea0641107a1ccee
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
v2: drop the comment in audit_ctl_owner_current(). The KCSAN build of
audit.o disassembles the same as v1.
v1: https://lore.kernel.org/all/20261002011712.7-1-bbnpreetsingh@gmail.com/
Compile tested only (gcc W=1 and the KCSAN instrumentation diff); I
could not reproduce the race in QEMU.

 kernel/audit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 631d6d4a23cfd..d0c2036bde759 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -247,7 +247,7 @@ int auditd_test_task(struct task_struct *task)
 void audit_ctl_lock(void)
 {
 	mutex_lock(&audit_cmd_mutex.lock);
-	audit_cmd_mutex.owner = current;
+	WRITE_ONCE(audit_cmd_mutex.owner, current);
 }
 
 /**
@@ -255,7 +255,7 @@ void audit_ctl_lock(void)
  */
 void audit_ctl_unlock(void)
 {
-	audit_cmd_mutex.owner = NULL;
+	WRITE_ONCE(audit_cmd_mutex.owner, NULL);
 	mutex_unlock(&audit_cmd_mutex.lock);
 }
 
@@ -268,7 +268,7 @@ void audit_ctl_unlock(void)
  */
 static bool audit_ctl_owner_current(void)
 {
-	return (current == audit_cmd_mutex.owner);
+	return (current == READ_ONCE(audit_cmd_mutex.owner));
 }
 
 /**

base-commit: a8bdcf944504980635c2069b4a4cfcf677b09bbb
-- 
2.43.0

