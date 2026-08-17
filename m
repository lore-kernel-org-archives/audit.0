Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B8399340
	for <audit@vger.kernel.org>; Mon, 17 Aug 2026 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008595; cv=none; b=PAO5TmSg9A9pcx1DNheaOabFucjpwaz78D7zRjSeqeo5plZLhwqZ3X+xl2nhVbbR45R4QWZ5E4yDeLyeBVSFWJPd64ilOVmEBbLFuxzQmB3u9Uoxs0DEqbVMs6lvWgVfjbCI9J8s+GPIuiAsYHK9a9XjW6wKTKQ4iXI4aP4X5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008595; c=relaxed/simple;
	bh=zous+kJOvu0pQ5vWoBLAWvfbF20qVCi9FazL4EQa4IE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=cqUZPRQUL/c38bBVfRplu05ChJXHymSiST84/IBcf6aKI/sQRMQnQ7mZpEbk60Y78sFuyRk/VEYmeixzh0kYrzNb5sLj04AstnCOg7H/BgfAn/7AfntsdJzKPheBrpC++kUobgWseViXoRTDW1cBvmk06LbyKFkyKi16KIIPLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=He1Y+WFM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="He1Y+WFM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-936cda0e3fbso332984485a.3
        for <audit@vger.kernel.org>; Mon, 17 Aug 2026 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787008592; x=1787613392; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rHAbNp5NOybfUHThKAx6tAvckbqh/5pUlxMdpjuHZS4=;
        b=He1Y+WFMrVhAwbwz6VktgNN/f/5QyikFj3rA7tcpKHUVt9L7T60vuaaxYwhDqQW2z0
         t6m7rYykL25brPHF0vElLB1NyKEcFJIepEyExKfjp28dRA/FDDl3g3SUa9u7Dzfi1MLl
         M5oEBKqoCnsK9bfwC1rxKn/LDFe5k/k4bqyis4UiRNPawuD6jkgIGKhzcoYofqQMu1p/
         u4VIVA/KAG0S6/jtCvBONc6/SNBIpYqW/mgeLy0i0aP9nv/UyD5KJmL9Sq3UX//epr4x
         VzGbLK1euQ+7LXsMHS8MqDPv5GE9wtpDJTcS/Is+gBIaJz53o7wQomt/44Mhcp2q13iJ
         pAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787008592; x=1787613392;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rHAbNp5NOybfUHThKAx6tAvckbqh/5pUlxMdpjuHZS4=;
        b=Mk4AeMVe4xjl6DBemCBo94OmYX1aVlmUcNKXizm0kg70I7jFlYsscuitA0aKWyiMpW
         XiEjzCdLEKbgN24kKgo+qXKnpfCm4F0kPSUKwFV21hNp3h/zxWKOQ48xUoJ8BXWJkDpG
         y2bGxiaKsRLdKRUs7nYrV9Hg3KvO78qzlK9P+RhtQwEBgUY+bAxCKyfLmBLtCf/0C90u
         bj7fjdHtLEYMkV2T8ePPvzkHZTqEeQg7lDYwAQ/VfLdIKO0VHQ87ckja+1EWQmrpgCjC
         bb8YsQmt4solCkjmligHpkritkSYQQgyCc1knLU9IykYChtXYBgVsgrbtTi7udgOl4dT
         CQag==
X-Gm-Message-State: AOJu0YxO62OD4zqwlTVe0webl1SYMpdhn6caJBQMZV22EHXeX7Yp+oEx
	8WWJOUdEIpiTraiFGaSalFgkKUMvSXrNlEfp7Y1pNoKPpC8oTXXEC1dQlmYSHlNUR9fRzVSwMDx
	BVTkqWA==
X-Gm-Gg: AR+sD11PjiuaYgTaFFC/5DlPh3wU1lVbUexk+NZUxMxhaDxkmfOU9XnOyuwNP5C5Rf5
	e0cAQ1F7EBxRQ86XGNv0GfP5XoPzotzvF8x9Y30XxU90acmCYpXffyYUhKbMQqRxwP8HHjIxMmv
	GMyYYcNs+Q1G29BOoHGwNNImFToMyy1PX3hORZYKfhsTVWqGbhkl+Qf2mTYFsUjZZUe4BPApjnk
	m8JSljUHWV88ymwmwERjmDLcEcKi/6ZwYLe9NWUjUz9L3MLQ0LFbCzrUGIok8Pf/aAx1mysHWaA
	xeREvq2MtZ67F/WF8rSTNdgkVmCQ8zm0XDuk2r4/72WP3x51EWKHszlekx7zT8l5l0ILBD5iKf7
	WzKwAhHVUHiJngZEo6DlVujaNaPOcyTYIJyem0BnFrGoozAmrKMQkdwNHNvc/B+rDNzJo+5t+BX
	h8e2YDorHTgIjHO31fb4mZesrln/+im/IRmB08mOWVp8cquF8Kl9YphJiM87K7SrFen+USz7rdE
	lHlEqazuN4JUc5zHnAZFvxF57DOFyYqOCFWEWIG7Dji
X-Received: by 2002:a05:620a:45a0:b0:92e:6b16:6a0a with SMTP id af79cd13be357-936d231102dmr2889889985a.40.1787008591961;
        Mon, 17 Aug 2026 16:16:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010d62casm197479485a.12.2026.08.17.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 16:16:31 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:16:30 -0400
Message-ID: <d226b8d2ddfb61be0e6a096f31049de0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260814
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Four audit patches for the Linux v7.3 merge window, the highlights are
below:

- Drop BUG_ON() assertions from two functions

While I don't recall any bug reports from either of these assertions in
recent memory, neither of these checks warrant the kernel panic that
could result from BUG_ON().  One of the BUG_ON() calls is converted to a
WARN_ON_ONCE() and the other to a lockdep assertion.

- Fix an audit tree reference counting problem

Fix a corner case where audit could end up unintentionally dropping
the last reference to an audit tree while the tree was still in use.

We should probably revisit the audit tree handling code in full, but
this patch works, and should be easy to backport to stable trees and
downstream kernels.

- Update the audit syscall classification tables

Add some missing syscalls to the PERM class.

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260814

for you to fetch changes up to 783f0f0974c156aca630f4ffff248671082a098d:

  audit: avoid dropping live tree ref on fsnotify rule autoremove
    (2026-08-12 16:46:55 -0400)

----------------------------------------------------------------
audit/stable-7.3 PR 20260814
----------------------------------------------------------------

Jérémy Jean (1):
      audit: avoid dropping live tree ref on fsnotify rule autoremove

Ricardo Robaina (3):
      audit: add missing syscalls to PERM class tables
      audit: drop BUG_ON() from audit_add_to_parent()
      audit: drop BUG_ON() from audit_signal_info_syscall()

 include/asm-generic/audit_change_attr.h |    3 ++
 include/asm-generic/audit_read.h        |   31 ++++++++++++++++++++++++
 include/asm-generic/audit_write.h       |    3 ++
 kernel/audit_watch.c                    |    2 -
 kernel/auditfilter.c                    |    6 +---
 kernel/auditsc.c                        |    3 +-
 6 files changed, 42 insertions(+), 6 deletions(-)

--
paul-moore.com
