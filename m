Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531E13B58B
	for <audit@vger.kernel.org>; Sat, 27 Sep 2025 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942451; cv=none; b=h2cuxa69JzQIxmtwjiPVavDgLW0sOlYQhrbJhJFNAJOw62w9GwRn8ngT4AUAezvCdBmIEBfT9NIZvSZSYso3bYvMZa+Z+T5ozjAxY37tc1BBsk3a+SAzo0uTxTnMh1Bd38znCToYjhJA1lBATloRCK57x6wpALuGdPuI0Du0FIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942451; c=relaxed/simple;
	bh=KIWllFg56if3TbC6uvy6hmJ9HqcpA05vzmey5qzXPvc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=XG+o5Vwwdz1HWbOSO5hTtkNNK5qq/4dPGlOvkpZTZjUaiwV0RM2w6L2QabrJiUEPsTQcm6qS4t/cmfrdVer5/DcXgzU4d088LtoosHjwNPOUeNIQSSMOWHONOn1NB9zLnbTlHCVrBrYbuykIp3aA+n0++oWyMSHg6K+sTXYa5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XB7lOwWV; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XB7lOwWV"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-799572d92b0so25369536d6.3
        for <audit@vger.kernel.org>; Fri, 26 Sep 2025 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942449; x=1759547249; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSAgZfMkE5F9jENlrny3LvdLwkaNKorgXutltGU+x+0=;
        b=XB7lOwWVBawLFA2yKand2UwL2+v/I3rFVXMysduEPrlZ3MBX09NPq8tQApRKmAUusi
         SyY0yE/GghdcwTrVvibaUzBH4Nq9a1dIYEuR4yQYwDraUMiqLvSdo84nXJoVEUDmCzER
         Z68ZwVEoDR7md99XHvtvJWvksja/0VB00PeYCHpK9qgncBq+lupRcTLuuad2PPJCTSEF
         l+M72j+3gsn+KXQ8f/jrtselF7AZadLdsueTKIF2R7xTjYjRVYYvos3nuTrZ7SmvlXhh
         dAFMCra7qYkqCxvpJZ93tlE2qJc0W9j189yJL0hB+LUK5WQPO0ZC75uVuteKXbm7hcBd
         ZRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942449; x=1759547249;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSAgZfMkE5F9jENlrny3LvdLwkaNKorgXutltGU+x+0=;
        b=vWn2e2c0bIa01E31KTS1FyR4sPk0nhIC0E7rOzD7Gb46lLtWfbOqP+6NIZbmubTSei
         lnXJgd53tIHnu6f92uvxesLvrcv645eKmAz8BOjpQQ5wsh+PkK4Q+IxtQXtHUMvASbPw
         GJDcXYAjx5US5DjKh+XZOIBEsUZ9Axc0XOANLOCK0UbRUh9GVFoLINdfMiSPiYoMM7K8
         OiOB3R9ZVFTtDejt1vULi7irnY9taEf3oHHvgwq1wR4UPLtVNAuqJ46PsXmWz872qgta
         UTyM0J2u38aSP2Jx7aDjVgWBvIU7+Yf3ZEZLGjNH7Db1QvYMq01zPx0Jm8RTuG9vodBa
         lU5w==
X-Gm-Message-State: AOJu0YxE4m5jB7snNHFakrXyh4So5N96SpqYksa+/Xz2eIAsV3pqL+Lg
	PhCR40FGRihjUg8NKgxHLn7FK8U5HIxcYIe79RHmPAHRcZ253mYiaGFkP5jXKMiScA==
X-Gm-Gg: ASbGncvYE5WPa5LPgFjp8URBw0sWb/yT9tvL8DuqtUW68GiYoch81i8YZ7ldMwRnqaa
	Fim4m5IKRXFKcEr4DifM+t2AmMs8wKq3JjoSdWKxM6p07X5A1mTmAD5kEdjw1waq+LjotMXcRD6
	xCKM1+MFmIVp7Rl2qkcvpSrcmVSV6tIX5h3hjne4UgAdD0hkT60YVwR256ejgiBWKhdCBHtPpUw
	MHDuMWD9lR7Ao2UQk7es5zYQcwSdwNHu4DUpwhRkB1ajzJKtSUribzMjXGOp0zp8NYxGo/RclKj
	OZGLGPD8JZCl53Pkj6bR1mAEEys+4pn6fqfswNBmCrJTRQA2m4uRiIj6gWnqP+Cj+dieVNnEmcK
	wC7JAmqR6ABMiuNmCsCSf8gnN5xbIIv+2vmxYpoeytPVy/j0tB2kOAL3xMEdxwrcjHV2s
X-Google-Smtp-Source: AGHT+IFoAiAET4/RXIIfogT0oBdVsHUQY8o6xwNhVDRzeLKHFonA8GbaIF5LImVO4PtEuu8oqTAuUA==
X-Received: by 2002:a05:6214:43c3:b0:801:7267:3cd8 with SMTP id 6a1803df08f44-80172673d7fmr139528036d6.39.1758942448929;
        Fri, 26 Sep 2025 20:07:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8016ce9a34bsm35543566d6.57.2025.09.26.20.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:28 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:27 -0400
Message-ID: <3161e6addb7d3e6c8297ff058ad8236d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250926
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Here are the audit patches for the upcoming Linux v6.18 merge window:

- Proper audit support for multiple LSMs

  As the audit subsystem predated the work to enable multiple LSMs,
  some additional work was needed to support logging the different LSM
  labels for the subjects/tasks and objects on the system.  Casey's
  patches add new auxillary records for subjects and objects that convey
  the additional labels.

- Ensure fanotify audit events are always generated  

  Generally speaking security relevant subsystems always generate audit
  events, unless explicitly ignored.  However, up to this point fanotify
  events had been ignored by default, but starting with this pull request
  fanotify follows convention and generates audit events by default.

- Replace an instance of strcpy() with strscpy()  

- Minor indentation, style, and comment fixes

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250926

for you to fetch changes up to d2c773159327f4d2f6438acf1ae2ae9ac0ca46a9:

  audit: fix skb leak when audit rate limit is exceeded
    (2025-09-10 19:55:00 -0400)

----------------------------------------------------------------
audit/stable-6.18 PR 20250926
----------------------------------------------------------------

Casey Schaufler (5):
      audit: fix indentation in audit_log_exit()
      audit: create audit_stamp structure
      lsm: security_lsmblob_to_secctx module selection
      audit: add record for multiple task security contexts
      audit: add record for multiple object contexts

Dan Carpenter (1):
      audit: add a missing tab

Eric Dumazet (1):
      audit: init ab->skb_list earlier in audit_buffer_alloc()

Gerald Yang (1):
      audit: fix skb leak when audit rate limit is exceeded

Kieran Moy (1):
      audit: fix typo in auditfilter.c comment

Richard Guy Briggs (1):
      audit: record fanotify event regardless of presence of rules

Thorsten Blum (1):
      audit: Replace deprecated strcpy() with strscpy()

 include/linux/audit.h        |   25 +++
 include/linux/security.h     |    6 
 include/uapi/linux/audit.h   |    2 
 kernel/audit.c               |  280 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |   13 +
 kernel/audit_tree.c          |    6 
 kernel/auditfilter.c         |    2 
 kernel/auditsc.c             |   63 ++-----
 net/netlabel/netlabel_user.c |    8 -
 security/apparmor/lsm.c      |    3 
 security/security.c          |   18 ++
 security/selinux/hooks.c     |    5 
 security/smack/smack_lsm.c   |    5 
 13 files changed, 334 insertions(+), 102 deletions(-)

--
paul-moore.com
