Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7253C0634
	for <audit@vger.kernel.org>; Sat, 17 Oct 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206009; cv=none; b=oU8wbBt0g5tQ6ViCZwepPplqcW4Q9Rqd4Py8YGb0wfuIB+PzRIUVGEfS/LFMEYZ2TLJiRO/jUs/Hsg5hT0LdkiKRZA+W8fcPKioBR8fgGl+24ZUqY13J85XmyuSUoCSiCpRY/38FiysBt5sC9Wqu9akd6r7txXPhyFz22Btqbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206009; c=relaxed/simple;
	bh=XKZ636C+0wZF282LG7kK4JTGRRg5tviYpbDi0A8qZDo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ffbYL3uUiQ7+6Sc3QVkCX1rbWLJZwaovk0/DnI5frx0Ksb1tGDAqjIpqmrUAX3/Ltm4Ygd4q4kNFElUusIbcV1jxGJUi5CRi4rwlcpzRrkrVxBQbBnz5At9Uyvu+Bp0LSB3lhnT0OfBDkNOMYtlg1YQ6KF2Vcx7TabJOC23usww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N5ToaYPI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N5ToaYPI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93efc0452b5so33343185a.0
        for <audit@vger.kernel.org>; Fri, 16 Oct 2026 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792206000; x=1792810800; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69p2wdFQwE6sYgQUmJukW/ziWDawqkeq3jAApKFhQsc=;
        b=N5ToaYPIwJJh3D9MNF/JHT+nTNn5KSod1OTqgifkNA5YnahST4QqvUmOK7XEhK8GEX
         x/5v5eA+GZ1Cy7fnNaAQfOUx2ff/ALgJtFiuXV4AFfxlGLOswG8AKIlsut8Lp4R9rA7s
         rPri5Z4NAZAE6nLafdKJkfTeTfdfqaNuwLfbJvnXyERvcXcYatsRe0E5xfO1M3eo77vt
         iOVLhEeh0sbgc1aR6Px+Q6RIvDjx/0r3Bz4FWRtFmMMmbf4reqIpSv378ZR2LyqHVtG1
         e03IFC2U6epmGy0p59XdmrGgm1c7tDq+P6jXI3wD2MTCY6vdN9gQk3X2UY2s+9/pKRqE
         puSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792206000; x=1792810800;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69p2wdFQwE6sYgQUmJukW/ziWDawqkeq3jAApKFhQsc=;
        b=p/EnUyArT578Nkx63aXKBzCQ/dfPWkf0K2b2/jtYrMDZU7GBibuCjkzzesqkGfWBAg
         4Mk8nFPfgvdUKsp45YVPwgGOlLbbkFvId2EZSIIUWV7mrcdI3PP+pHDynf9zbkpBy0hn
         WN+8erFgqWoU/H2kLkWx4yQ+1MXLQHDU9sE/sBiQaj0FRurc/Jz2PMIpfK+IsKQSH5MH
         M/RGYJ2E1ifWH2l1hgSY/MwotBzrWUKL+CDfk4vU3YiXVIGgHi9hKy1Njx2+wyqqzg+c
         5ToEzC5Jb0eQdSh8KDbcSOQPFo0GUIUkwVoun/GqfBadFwukaDiH4pTki/pjAVvJbpXs
         mBNA==
X-Gm-Message-State: AFq9FYK4aCpI78ViuatZfboUZR97oDACuWsPNU8ci6BI/EpYCTK1Ruyu
	amh7eoBajjNQ29j3jqNPhSdTsqt/AQPGOUP/U8G7BtM13m9t6OreznUroPqHPl2I2IUe+sEkmXy
	oZQQX9g==
X-Gm-Gg: AYBFou2+MdUlPAf87zQ/Xj4hKXbbTCA4Kj2RA6oDpoyM3pz0SWSknguHytVlyXLXFRS
	I1wq8Af5CJpzRKgFz02pqzTdq91hZX+GbcWuKX27RGqWVvOBOwlkd8d5GTS3v6DZBMkqeYNy2ow
	yuZ//e+uY3q17vb3QueO9mQtQhrfPRZSXmsnGVZutobAVt+JiWBXQYKfYBJ85QHOUXnrmocHKj/
	exKm8I+6c8UlcM4uysTPrsxYiPob/EgALW6rf2WBZPCZNd6WdmzbA4RlYa+KDILXqjR46ILkDU0
	yh8ezuVAuTgKSOFZfiE5DcObLlvJFuP/B7GILLTtJ3Aq8Q+yFirZ9buQQi1dt1IKGEdj/GAQMMq
	9/uhtRL+guXC38Au5voWXn/sJnhwXQBolqWZZHSI/poB4Vegl6n8pIwr+59hTdG35bU0SAIWI7q
	0TbrQ2h8vUldxLNEBzn8j06QgP+CSzPDVsg6vn+4b9hF0yTh+zPd9RkRK+t+92fy8cN6c7FpHpi
	v5KePC62+Pp0thffWptKSvmPEWiDyWrjS0Z/pXfDFHL34zh5athHa8qRgtcv+LYL2zMbzSpm94=
X-Received: by 2002:a05:620a:4395:b0:93a:2611:270f with SMTP id af79cd13be357-93f29cc7d03mr292326485a.13.1792206000328;
        Fri, 16 Oct 2026 20:00:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a16c21esm364494685a.16.2026.10.16.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 19:59:59 -0700 (PDT)
Date: Fri, 16 Oct 2026 22:59:58 -0400
Message-ID: <58518dd02336a6018abb7fb8b34f5212@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20261016
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Six audit patches for the Linux v7.4 merge window:

- Fix the accounting of audit filter rule additions and removals

Tracking audit filter rules is important as their presence can trigger
additional processing.  Unfortunately, the existing code did not properly
track the removal of filter rules, resulting in some cases where
additional processing was done when none was required.  This pull
request not only corrects the accounting problems, but also provides
a cleaner API for tracking audit filter rule additions and removals.

- Add a FSOPEN record to log the filesystem name in the new mount API

Close a long standing audit blindspot by capturing the filesystem name,
e.g. "tmpfs", when calling fsopen().

- Split audit's storage of process and file capabilities

Instead of a single structure that stores all possible capability
information, create a dedicated audit file capabilities struct and
convert the existing audit capabilities struct into a process
capabilities struct.  This saves 80 bytes from the per-task
audit_context on 64-bit systems.

- Ensure that the PROCTITLE record is reset on exec()

This fixes a problem where systemd would set a temporary PROCTITLE string
after forking a child process before calling exec(), effectively locking
the PROCTITLE string to the temporary value.  This pull request resets
the PROCTITLE state on exec() so that newly executed processes can set
their PROCTITLE correctly.

- Add some missing unlikely() annotations to the audit wrapper functions

- Clean up the audit netlink multicast skb length adjustment

Paul

--
The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20261016

for you to fetch changes up to 5d59024a6cc9aa9300da59fbf7e2c29f1f2393c6:

  audit: add FSOPEN record to log filesystem name
    (2026-10-04 07:33:18 -0400)

----------------------------------------------------------------
audit/stable-7.4 PR 20261016
----------------------------------------------------------------

Christian Göttsche (1):
      audit: separate file and process capability storage

Ricardo Robaina (3):
      audit: add missing unlikely hint to audit_dummy_context() wrappers
      audit: use copied skb length in kauditd_send_multicast_skb()
      audit: add FSOPEN record to log filesystem name

Richard Guy Briggs (1):
      audit: free proctitle in context so it can be re-set by fork on
         exec_binprm

Stanislav Kinsburskii (1):
      audit: Fix filter rule accounting after automatic removal

 fs/fsopen.c                |    3 +
 include/linux/audit.h      |   16 +++++-
 include/uapi/linux/audit.h |    1 
 kernel/audit.c             |    2 
 kernel/audit.h             |   20 ++++++--
 kernel/audit_tree.c        |    1 
 kernel/audit_watch.c       |    2 
 kernel/auditfilter.c       |   86 ++++++++++++++++++-------------------
 kernel/auditsc.c           |   17 ++++++-
 9 files changed, 93 insertions(+), 55 deletions(-)

--
paul-moore.com
