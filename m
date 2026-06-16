Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A13C3443
	for <audit@vger.kernel.org>; Tue, 16 Jun 2026 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578550; cv=none; b=pLfySrtd/x7jv36XIRzfv8X3oyxaKFPfdCCjcBDyZY9HAfR6msYPey5x/3SDFhQSaHrmJX0dM955OTKdxDrpPpQ+5OPVFgd8hXa+duulIV9bT0aVs9n8wqJzZnyCueIP4Z1+fH1IJfFEQNgH5KrMzCjQdsx4RjrVQAlIznGmkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578550; c=relaxed/simple;
	bh=3FHJvZpakme4jKs8WzcGg7S3ioGeR3WKAqW1Iwgc/UU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=b3xIVZwTLUs8cB2BO28bB2C7GJSzv4YTg+Y7jhrsYP0FJk9EbZjJaw6feqLrNYhYULTBWJvKEMYrj3AgaVFCt34CtW9b7SGZppCL4PzNIsGQog+ecVQUd0bYzXhxvvC0fm33eRF4Vwigoc0k+ZLjB6QsrtW7FalNzmBoA0Q+ETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aSxS/7ys; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aSxS/7ys"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-51790c0a692so48623001cf.2
        for <audit@vger.kernel.org>; Mon, 15 Jun 2026 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781578548; x=1782183348; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrEBHC+BEo5PUK5QESqVkHwa8uLQvrvp4i2JuZAotfY=;
        b=aSxS/7ysL+/AyxFYLICpOCZiuJ/gyKFGFpbMaY/MPAp/YdFgshlpENuFtQNdRICN06
         seu7eEb1j63uRtDlG+ME4EPrKM1G7EFSNFMgGgBFpIFaO+GLlyBn3Y1WxThDMoHLgFp2
         kfH/xyViy1syDAkJjZ7iFoKu6lek5WB4H1F0aUcBadSZm+CkjcXA9KSv6J/99uy8mb7e
         msDNSey/WhW7GaJscQK0Cslj56LxmNRsn3Hd2TKEHCH+LGUrAp9zgW30Jt2sWqJfSYRl
         BFh7n/aU/u7Tj7aRtSy9zWfcHUPDmRUHh8O5RCCnsZCNVa3zlaGt5IqigvPWE20VP/PV
         j54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578548; x=1782183348;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrEBHC+BEo5PUK5QESqVkHwa8uLQvrvp4i2JuZAotfY=;
        b=OC2KnGwoYwwEi/qUZ9gbqYUXJFrdkOSvrg9kbm4g6GBLzpMw4m4Adv1OFmeLH6M3mg
         9E9f4irApllGf4BMfL2XaRohQJ1eZUIvhDh639qXdzIKVquybULQS1J4kDYuJvn2zZ1E
         gBk5Lt5vZtkZBQ7/Z+LoA2a/tgKXzuL/elQrJkKIkYYVIL47A6pUhGeacgVNdub4sdxs
         NrIyCEzgZAMofoiSfZIikxSFyvNlGGPaYZMGanBnh5nTYloXaMl7IdPgZ9tcABSHzffj
         smzUI/z96JVPH0fpcNAmoU8arAnTP+FGAnTekzg/WZXI4AsePFBTeYbqdCgDnxecH+AN
         XrIA==
X-Gm-Message-State: AOJu0Yyab4zXSWVrpgv/Y4zhE1AQx5DYHCji6Ql7KT05yG0WltpgLL2g
	HeV1Z4Bf5laP/rHxKgjV6eNtwpHxf7YZM/G8Gf5OlLRlY3LcQpIv/7T0xJrUAGjWgbE5NMgv1yB
	mBqIKJiJy
X-Gm-Gg: Acq92OHM83vqilgFQ9SjjASwQcAozP8NjLHhm1qDPTRLhWAphbgmtN5Tzr+JxrU2+xj
	BrMx1qJZP4FMXxyt3i1mG1J6BCBWklIzdE9FF+ZKPylKOFbUS5M/VttOry5xDP1wyDW7JnrWhyc
	Ix39XrCbGgoElIjNQHPqWN7Ociso9HHPbTPsMu6pg/ULqV0/E0sQDdtnpUhSAbhrFNDXQrxHJRq
	XNSIhKgQgbEM3aRP0tripM6FM9jXLzjtMyp5JjFBKjExjSWxxm1dN/qylEXWKt5THzFmkb2EUPs
	hI1J+LKRyoIPaMasAJSVA9GOZr/UH66k89fuKDvProZjgkX9yno7Dgyw33PifGicxyKuJ/5bCAw
	pPONdJ8OZEOQsYNElmQ6CaDM+PWENJ5nJtRf9fFr9qeUROFIxbIlsHsI0Ow/0OOmdGXEYziJdHp
	S9KRPXIPH9GI5hvIbGUf+rTXguqr+T9fV+LcTw8DPBY3zrjli/A2NL0t45kfZWjRFKXUJz
X-Received: by 2002:a05:620a:8806:b0:915:c917:5584 with SMTP id af79cd13be357-9161bccc2e3mr2501470685a.35.1781578547954;
        Mon, 15 Jun 2026 19:55:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1c5cdsm1325761985a.17.2026.06.15.19.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:55:47 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:55:46 -0400
Message-ID: <ed67171da998240452617bc681ac0e48@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260615
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Three audit patches for Linux v7.2, the quick summary is below, but I did
want to note that you will see a forced push due to a last-minute
correction to the git metadata that I noticed while writing up this pull
request; there was no change to the code and the tag is signed as usual.

- Fix a recursive deadlock when duplicating executable file rules

Avoid multiple lookups and attempted I_MUTEX_PARENT locks when moving
watched files by passing the already resolved inodes through the audit
code.

- Fix removal of executable watch rules after the file is deleted

Prior to this fix we were unable to remove an executable file watch where
the file had been previously deleted due to a negative dentry check in
the code that performs the lookup on the file watches.

- Convert our basic "unsigned" type usage to "unsigned int".

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260615

for you to fetch changes up to 81905b5acbe77284734438df3fbec1158e6429a3:

  audit: fix recursive locking deadlock in audit_dupe_exe()
    (2026-05-27 19:15:34 -0400)

----------------------------------------------------------------
audit/stable-7.2 PR 20260615
----------------------------------------------------------------

Ricardo Robaina (3):
      audit: use 'unsigned int' instead of 'unsigned'
      audit: fix removal of dangling executable rules
      audit: fix recursive locking deadlock in audit_dupe_exe()

 include/linux/audit.h      |    4 ++--
 include/linux/audit_arch.h |   12 ++++++------
 kernel/audit.c             |    2 +-
 kernel/audit.h             |   19 +++++++++++++------
 kernel/audit_fsnotify.c    |   34 ++++++++++++++++++++++------------
 kernel/audit_tree.c        |    2 +-
 kernel/audit_watch.c       |   25 +++++++++++++++++--------
 kernel/auditfilter.c       |   17 +++++++++--------
 kernel/auditsc.c           |    2 +-
 lib/compat_audit.c         |   12 ++++++------
 10 files changed, 78 insertions(+), 51 deletions(-)

--
paul-moore.com
