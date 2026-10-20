Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500637;
	b=UbJS+NpmUFp/KhcykQrNhiEdPeE6d9ZDImIUIxB+uSb8kJNT8gIcuEsA8m18wdoQO0rb
	 zWa2quMOq3qJWKoc376qOj9c++++G5+GnssTIPZrF80b4xaiKYKBjo5ez98ToGTygloQN
	 /Wu+xwzGtVqemhF7NYRSf7uKBrVDBvLbmSKPrlewAnn7dsoBFb1KMr8d98JarkCSI1w8n
	 y3c50qAT2rezeavb0SmBa3VXNOVG+by+rx/kxJa7ahVDsc9gQjLGM+x8XYn49a9GtDXl3
	 RWp49u52jisDllYcNVfG0yioskJMjzdUghu2w6l6jmqXd/mMtWKfBb82R4Oql89riYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
	b=3aNQh+/RlYgKQkXCjd5C3Z7i1vYAj4Dv4JI8SdD1sS5NRR6upTTO00UfD5b5Nmf/jfWH
	 ejzBB8dwvmcDUc0EC8xosZz+2Vo04xX5TJDa9sntXWYMRTv/0Wz/fJWfNg1ctfZhb0LQc
	 qNb2mH0DgVe3M2uheJjjD1R5zFzIfzpQoqls5wTzBRYm6fTUThDGMnihME32Jhd/1Aext
	 Ss8rjA3h0By5qRezG91Wy77fo368E+JNyp0mYTadDHhvik1XzxTgh/wc9nzGQbWfj21Iq
	 Q35yY9V4DZsw9VZ53SCSk/4MInZB5IdV2Hf3VCxdXpwM+ylMm2PWaZQcENjvmoH6KHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHCblJZf;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A3606A31F
	for <audit@vger.kernel.org>; Tue, 20 Oct 2026 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673A3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHCblJZf
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so9943245ad.0
        for <audit@vger.kernel.org>; Tue, 20 Oct 2026 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500631; x=1793105431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
        b=IHCblJZf3H7599IBWylg66gU0BdWkqOQqEm/SXRhQR1bUZoFbQktsi2LBaQRTQeR5m
         Hj+fW8zZoHJTNJj1PHYnEdUekhAcSKhL4rDIWZoe6EhAUiL5hKfkgkvhMNTkQXlu1Sgh
         Hf1lJR03QSEY4hAbCLfviHGJyrGpC4KByDFUnEAK1gJTpwW8CJn0Z66von5N0T2Mi7p0
         gwJK3UlGsFIPvB9DcM8nmC+TVpt7Yjf8Z+kBI5up04AXWwmWL+AFkfCre8ORKyhUzAtP
         jXXPUAbKE+Wna1Irkj7ES7OKkZ85qTx0YcsS2fuocZmn2xpypw3PyoU55nQuhoEDbm8l
         dTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500631; x=1793105431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
        b=1hp88kiYCu8vlWUVaRDf/cUHdwf+yGGBqX3ZajS2gz71C7Cydp8dHqefeLioaU99aS
         pJx5Nd3X8zBeVxo9cr98AZGA8szIXe+TSD9V0YqlnIt2S9qexXseyNqMtupZAOA9B5zw
         dr4fbYvfIuwWFQYa9Yvy7fywLE+jvCJnhNKwxpUlYYrZv01iJzTn36bmzJx2CDeX9uky
         +ufC3AJe1YgeSY708E+PS3WUOje8AzCkDrX5/T3S3MjKlGnglZOxMmjpnUcqLEODDLQB
         oofKswerDjUZ6cGKUGtGL31HTwOkZLEkUbM+u00+aNjH0JnBnCy/O8nTn9B2FzTOfOD7
         rr0A==
X-Gm-Message-State: AFq9FYLygy55iq9K5d6IV9rAlt1x3i2BV6XJFJooBo/JhJeb21Kzlh/P
	9mt+TsjPgxJ0TUq8cvQIx6UZzuG1LoWvImpwTwVhKgEXEditmgS0dLtk
X-Gm-Gg: AYBFou3h+cGDXiYygs3DcYnYPp/qfo9Dt0p8V04kYQ7FGfm59lFYpRbEgUQVwcweNcu
	YLTbYpnHz/GR2k2tILRn3sN2jz708xVwKXl+j6mj29rufT7/ZIhW1YuXbQdFmidS0VaKd3sSA4X
	SzN63mfayGVUQeIiX02GbA1D7mEJuAAlxJ5va80DiceKyNEV5WHIqSI3D3eEjIUsTwVPxD3VI85
	PJLekDqzqX3KpZ6nhXd5gGtWvvWUfzJSvVFW5aRmwrs8fcJl1PzMJzMBBtFbctcF83oiG1RCd6F
	nJp95h8tT1wuE3UljbNBFoTelBN9oN5Rb14GldEx8WWbv7zzUKPr9ywkSkbMKImEsaVA5rMhFHx
	/r95QoJO/jCTyXM5mcADBJ6zFSgi09wAKA1t7xo5QYswDBjH5Ofe5YH6VjfTXFbw+gCXxiHeMjP
	9EvfTk99t7ZzwsvcTv4sTKPE4vMMuL63LQfM8SZpx/FXAG9uZevdsi5W79xrez8WBeBDXlJgKbN
	01TkHqfgbY=
X-Received: by 2002:a17:903:41cf:b0:2d9:520c:38e7 with SMTP id d9443c01a7336-2e9a68346e4mr91135645ad.1.1792500630628;
        Tue, 20 Oct 2026 05:50:30 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:2646::3d0:4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151a2a85sm11467305ad.71.2026.10.20.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:50:30 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: paul@paul-moore.com,
	eparis@redhat.com
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] audit: don't use the caller's root when it has no fs
Date: Tue, 20 Oct 2026 19:50:24 +0700
Message-ID: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_log_d_path() calls d_path(), which resolves the path relative to
current->fs->root. do_exit() runs exit_fs() before exit_task_work(), so
a deferred __fput() runs with current->fs == NULL and d_path() oopses:

  ima_file_free() -> ima_update_xattr() -> ima_calc_file_hash()
    -> dentry_open() -> smack_file_open() -> smack_log()
    -> common_lsm_audit() -> audit_log_d_path() -> d_path()
    -> read_seqbegin(&current->fs->seq)

Without an fs there is no root to be relative to, so log the absolute
path with d_absolute_path() instead.

Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v2 (Al Viro's review of v1, which patched d_path() itself):
- d_path() is meant to be relative to the caller's root, which is
  meaningless here, so leave it alone and fix the caller instead.
- audit_log_d_path() uses d_absolute_path() when current->fs is NULL.

Reproduced in QEMU (x86_64, KASAN, Smack+IMA+audit) with the syzbot C
reproducer: without the patch the first exiting child hits a null-ptr-deref
in d_path(); with it the reproducer runs to completion with no KASAN/Oops,
and the audit record still carries path="...".

Al, does this match what you had in mind? A final fput() in some unrelated
task still logs a path relative to that task's root; this patch does not
change that.

 kernel/audit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..32085674d0be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2218,7 +2218,11 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 		audit_log_format(ab, "\"<no_memory>\"");
 		return;
 	}
-	p = d_path(path, pathname, PATH_MAX+11);
+	/* No fs after exit_fs(), so there is no root to be relative to */
+	if (current->fs)
+		p = d_path(path, pathname, PATH_MAX+11);
+	else
+		p = d_absolute_path(path, pathname, PATH_MAX+11);
 	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
 		/* FIXME: can we save some information here? */
 		audit_log_format(ab, "\"<too_long>\"");
-- 
2.43.0

