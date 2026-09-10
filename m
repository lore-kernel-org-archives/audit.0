Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C52DC798;
	Thu, 10 Sep 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051737; cv=none; b=fj5jzvZqwmv/y/BWfycZohsEFdC17SLSBlH+C2OtBMsUbxB/aOdwVXRybQ2QQnqtHtQiCX/ZmEu0kF9vEld8k9f3axjweL8pVwwQziEsIdLTxviWh5HnWiIgtVW+Nwt3lhxIMx+AMB2/zjVTI3IfEN4ECXJE9D1apVxedP4iuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051737; c=relaxed/simple;
	bh=aRf6EMKKxqVt7oDa+cGdwXhR2DHh28e3Wm7u4d9FBlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tJzkyGGZDAtUmuBgD/MOHBtfs1vwUiQ0ESRgyApjwUu+tBcrVC4pdnAsf1tk9onBDtwpZUzVmvp9cx1PZDTl53EoctKM2kLBDbp81PHYYYfI/tz2BFZqWsrOlj+kLA3ayjMs/f6mo0JaOy6y4lVVDL+X8Df8QXLQpc1WUZUgV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xv9mmcdk; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xv9mmcdk"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hggXt54r5z6S4;
	Thu, 10 Sep 2026 16:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789051726;
	bh=0SbVx6O13QeDJHDCgZeaEus7rB8CybpIq3hc5vCtIV8=;
	h=From:To:Cc:Subject:Date:From;
	b=xv9mmcdktC3XMf7lPpMYV4JbdpC7uO+YGu2CF11wg06DPdYGJciASGBbQ4SyW7Eo8
	 NBBHladEZxUo8f/U669epe6g7TpmuMZsShHBA/0/bN6h4HU5H7zRCwMZZR8P+hQ99d
	 M9IKFRW9eCyyMxJH/4RVIMFp4TTP6H0LlU5ITmqk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hggXs3S64zw0r;
	Thu, 10 Sep 2026 16:48:45 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Nick Kralevich <nnk@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v1 0/2] lsm: Preserve full ioctl commands in audit records
Date: Thu, 10 Sep 2026 16:48:32 +0200
Message-ID: <20260910144837.381855-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

Ioctl commands are unsigned int values, with conventionally encoded size
and direction fields above bit 15.  However, struct lsm_ioctlop_audit
stores only a u16 and the common audit formatter uses %hx.  SELinux also
narrows the command before constructing this audit data.  As a result,
LSM audit records can conflate distinct ioctl requests; for example,
Landlock currently records 0xc00ffeee as 0xfeee.

The narrow audit field dates to its 2015 introduction [1] alongside
SELinux ioctl extended permissions.  Using the low type and number bytes
for those policy checks was deliberate, but the mailing-list review
contains no separate decision to truncate the audit value.  Audit
discussion instead identified ioctlcmd with the ioctl request in syscall
argument a1, and the audit field dictionary defines it as the request
argument to ioctl.

This also exposes an audit2allow -x assumption: it copies ioctlcmd
directly into a 16-bit SELinux extended-permission rule.  It needs to
derive that rule from the low 16 bits of the full audited request;
otherwise checkpolicy rejects generated values above 0xffff.

Patch 1 preserves the full command in shared audit data without changing
SELinux's low-16-bit policy checks.  Patch 2 updates the existing
Landlock test to exercise upper command bits.

[1] https://lore.kernel.org/r/1428616171-14767-1-git-send-email-jeffv@google.com

Mickaël Salaün (2):
  lsm: Preserve full ioctl commands in audit records
  selftests/landlock: Check full ioctl commands in audit records

 include/linux/lsm_audit.h                  |  2 +-
 security/lsm_audit.c                       |  2 +-
 security/selinux/hooks.c                   |  6 +++---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
 4 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.55.0

