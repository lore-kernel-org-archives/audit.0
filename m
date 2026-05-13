Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648D3C8C7F
	for <audit@vger.kernel.org>; Wed, 13 May 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708896; cv=none; b=ZRrgRFsMpEBQAl8f6M4sYqNgGwsptMZAYlKmVGki9OHwi0nAvsrRxuep2PC2EPefbihvZ8gJ0hfbGNrTRr4aodGM+RmyRS5LMfWiiPuixABL36DbUaI+PpKn89/6syh4/C3dzc3ObPkwLn8WM4Nu2Hxx9aZ3Pwg9RpIeveWjIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708896; c=relaxed/simple;
	bh=xzwed1JUc0GGKuc0tKo54Q2W4U2O8szAHg2x0faSlm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mbytVXmluGK9Bds1MoOjPGHazoGJzN+gwLZi9LKqTxzKny2VBqPbzuaV8yFueHxMCM1G8Ml3fHPamdMBVtH5uiqAZAvbQtTccN1K9069cceWVCiJG1RwnDkYiUC7dDtVYZ8QseF4JGywP/m5E4sx/DtJ7S2uXw7ZKbIvxGTjubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4Ip/bPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4Ip/bPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778708893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KF6G67RqKVVQwKSjywAmE6+B1kVOwvp1sieNz6K9BbM=;
	b=g4Ip/bPoHH8F1zMGHVXSTsYUmHYr88HIc7OPg6zUXYMjFWhJ6RRaDp9ajrF3WrN34HCX+5
	6K+r9Ar8obaB52m/BueS5oSEL5e1Lt1HdZ8kyRSMx0G3Qg/u2icSYLpdgFc3OKE+h7N7q1
	FEE41qN0Ag+1bLkA5v1Fpt+Mh1BkKiE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-a4zj_qoaODuukNfcOF89ow-1; Wed,
 13 May 2026 17:48:10 -0400
X-MC-Unique: a4zj_qoaODuukNfcOF89ow-1
X-Mimecast-MFC-AGG-ID: a4zj_qoaODuukNfcOF89ow_1778708889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 062781800283;
	Wed, 13 May 2026 21:48:09 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.76])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1DA919560A6;
	Wed, 13 May 2026 21:48:05 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	longman@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2 0/2] audit: fix recursive locking deadlock and dangling rule removal
Date: Wed, 13 May 2026 18:47:58 -0300
Message-ID: <cover.1778704210.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: iJlUmPFIj8mweVhVSHMs25jxjhJoLFRiSyJp4ykCwDs_1778708889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch series fixes a recursive locking deadlock in audit_dupe_exe()
code path, as well as, a bug that prevents the deletion of dangling
audit rules.

The first patch, simply removes the d_really_is_negative() check in
audit_alloc_mark() to allow dummy mark allocation, fixing the -ENOENT
failure when deleting dangling rules for unlinked executables.

The second one, fixes the deadlock in audit_dupe_exe() by introducing
the audit_watch_ctx struct to pass the fsnotify event context down the
call chain. This safely bypasses the need for kern_path_parent() during
move events, avoiding a double acquisition of the I_MUTEX_PARENT lock.

Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

---
Changes in v2:
- Reordered patches
- Refactored audit_alloc_mark() to eliminate code duplication by introducing
  local dir/child inode variables and unifying the critical execution path
- Added allow_dups variable to preserve original behavior: manual rule
  additions use allow_dups=0 (no duplicates), fsnotify events use
  allow_dups=1 (allow temporary coexistence during rename)

Ricardo Robaina (2):
  audit: fix removal of dangling executable rules
  audit: fix recursive locking deadlock in audit_dupe_exe()

 kernel/audit.h          | 13 ++++++++++---
 kernel/audit_fsnotify.c | 34 ++++++++++++++++++++++------------
 kernel/audit_watch.c    | 25 +++++++++++++++++--------
 kernel/auditfilter.c    |  9 +++++----
 4 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.53.0

