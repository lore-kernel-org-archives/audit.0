Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8C4EBADC
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656035; cv=none; b=JGHjdEdwJv0F5o29vbkWqBaRTvX+U0m4CcEEOwYgflzi/XKaC7arVgA/0JXUsGnvoyoii/oYnSuBQxnJ+qhCRDepKH8QHsbR863ckwdHX9YGEPxL2GSYnfbKck0gqQm+Kye6lJZxvw3Gk8frTHOQZ5CIhnJMoRtnRQj89+1BjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656035; c=relaxed/simple;
	bh=vf7EtRHDT6Wigbh9BkMNyT+/UIw3krtix7SXCj4edmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMBUs+i/4lcOd0u2SSJxVVXy5DCkTETu0siInpsm080Xw+K2K0c0SZfhHKZIyld2w22MKbls3sGqAYYeF6jkctyNfPmD4VjMJ6WURQMcJXOJbXEhXP8osJv7jYDhpbQm5l8I/qrnwE8vtqdgy2jnnoo6BPwdhmLq2ycAg/7rgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qQAvKdjB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qQAvKdjB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789656023;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypJiKMl3dusWJGcqd78UtO3ySveLOiFfV/RMYjLlPuQ=;
	b=qQAvKdjBrHUZdsFPOQslo0mRO7IV+JqqoaGYS3jbVa5zKwo8XEOQjE9Ntm6SwbDOvsUZOe
	YR6CFVFr6/5kYVl5azd2Nvc/YHa5tTF8o09t1tifEK7GibuzeR0BMuS84y9/lJZXM5+IUc
	/baEhKWrFXyup9SX06lH0LM6Ee8CQVO0fOn5PJPwgJFzQ/6kbTtLCwBYCWGxEh0XuSDXt0
	T+U65iegQ//zOaPxQGudzZUpq6UhHdNdyuDxEIhin87/E7CbHFxeRNPYZ2b2Wp7NIJcoSE
	wi+MEm0gwgT3c90+IAeSUHL7WPCq2SVgzx79mvdqNHIgw4KPoHayMSrtJFlaOg==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 2/4] audit: compact name entries and context fields
Date: Thu, 17 Sep 2026 16:39:46 +0200
Message-ID: <20260917143948.106603-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-1-cgoettsche@seltendoof.de>
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
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

Group aligned name fields and small scalar fields to remove padding. Keep
file capabilities last so they do not separate inode and pathname metadata.
Store the per-name file capability revision in s16: it must represent both
the eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Keep
the existing formatter and its unknown-capability output unchanged.

Move name_count beside return_valid to remove two alignment holes, and
place personality before the task credential scalars. Preserve the first
int dummy member required by audit_dummy_context(), all five embedded name
slots, and the existing allocation and reference lifetimes.

On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
leaving room for descriptor paths while staying below 1 KiB. On the tested
arm64 configuration without property-bearing LSMs it falls to 872 bytes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/audit.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 7640d2c0fba4..bd798f8553a0 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -76,18 +76,16 @@ struct audit_names {
 	struct list_head	list;		/* audit_context->names_list */
 
 	struct filename		*name;
-	int			name_len;	/* number of chars to log */
-	bool			hidden;		/* don't log this record */
-
 	u64			ino;
+	struct lsm_prop		oprop;
 	dev_t			dev;
-	umode_t			mode;
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	struct lsm_prop		oprop;
-	struct audit_file_caps	fcap;
-	unsigned int		fcap_ver;
+	int			name_len;	/* number of chars to log */
+	s16			fcap_ver;	/* 8-bit revision, or -1 for NOEVAL */
+	umode_t			mode;
+	bool			hidden;		/* don't log this record */
 	unsigned char		type;		/* record type */
 	/*
 	 * This was an allocated audit_names and not from the array of
@@ -95,6 +93,7 @@ struct audit_names {
 	 * should be freed on syscall exit.
 	 */
 	bool			should_free;
+	struct audit_file_caps	fcap;
 };
 
 struct audit_proctitle {
@@ -124,6 +123,7 @@ struct audit_context {
 	long		    return_code;/* syscall return code */
 	u64		    prio;
 	int		    return_valid; /* return code is valid */
+	int		    name_count; /* total records in names_list */
 	/*
 	 * The names_list is the list of all audit_names collected during this
 	 * syscall.  The first AUDIT_NAMES entries in the names_list will
@@ -133,7 +133,6 @@ struct audit_context {
 	 * by running the names_list.
 	 */
 	struct audit_names  preallocated_names[AUDIT_NAMES];
-	int		    name_count; /* total records in names_list */
 	struct list_head    names_list;	/* struct audit_names->list anchor */
 	char		    *filterkey;	/* key for rule that triggered record */
 	struct path	    pwd;
@@ -142,10 +141,10 @@ struct audit_context {
 	struct sockaddr_storage *sockaddr;
 	size_t sockaddr_len;
 	/* Save things to print about task_struct */
+	unsigned long	    personality;
 	pid_t		    ppid;
 	kuid_t		    uid, euid, suid, fsuid;
 	kgid_t		    gid, egid, sgid, fsgid;
-	unsigned long	    personality;
 	int		    arch;
 
 	pid_t		    target_pid;
-- 
2.55.0

