Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26470253B58
	for <audit@vger.kernel.org>; Tue, 14 Apr 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196871; cv=none; b=UmkfhRtA1PTwrskCuvV5s7rNc7TSGDPF2AVkfufIkb3diuwB/95NNkIQLBdNv3/Rr+77gr8UEDaGtVb734BrwXCbmh69G9ANuJ+2BCGUeWUWEqyLIHG3xcPuzgrBLPwEyMHNBOJt5opnVx0WSyVhgrKoIjlcr+wL97ITIm6+VHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196871; c=relaxed/simple;
	bh=ZeylPU/6ctHBGi94xKyX+8VtQ/u7cwZ8qxt92Wo1BKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ShtiHAYX3wgSRl/AR6wWHM+47KPiD87hJ8p8auuwLHQmyL6k/qUHM5oNp9layIsopM6yFJZ2r2yeI1vcWWKOnM8S4PTScXt3Twk3jsIpIUvIf6i1Tm/E4/boRHC5cw/NGJgqN86AXrtBfLPassA7XDj2+sx3M3Z+G+cMzmnSCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwmev9Ny; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwmev9Ny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776196869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YxLXnNqH8MytDl6H33xGfEzvmWo2vvvIYuOOB3MVYVM=;
	b=Rwmev9Nyoa4vg7eBiLX4hgSHBeTogzTVrIbS6EB/pZUwrXNvcgb1+CJrMxdOs5Wr3sKoHP
	TNDEBNLHwn0viaeLHOx2jpljj5zzlgEdwMH7iaHw4BgHMTBMuuEDh/UmshiCKfWFv9oy2J
	6SNoXRoZC8NnX/egkfzgsGgeJU+VjFo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-yO3skRwvMcSR5heXTQ3iUg-1; Tue,
 14 Apr 2026 16:01:03 -0400
X-MC-Unique: yO3skRwvMcSR5heXTQ3iUg-1
X-Mimecast-MFC-AGG-ID: yO3skRwvMcSR5heXTQ3iUg_1776196862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A651195609E;
	Tue, 14 Apr 2026 20:01:02 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5073A1800357;
	Tue, 14 Apr 2026 20:00:59 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	longman@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 0/2] audit: fix recursive locking deadlock and dangling rule removal
Date: Tue, 14 Apr 2026 17:00:46 -0300
Message-ID: <cover.1776176104.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Cff-uIDmGIEtuwLvvaitlJAxZARzJxzR5ywIRfqq438_1776196862
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch series fixes a recursive locking deadlock in audit_dupe_exe()
code path, as well as, a bug that prevents the deletion of dangling
audit rules.

The first patch fixes the deadlock in audit_dupe_exe() by introducing
the audit_watch_ctx struct to pass the fsnotify event context down the
call chain. This safely bypasses the need for kern_path_parent() during
move events, avoiding a double acquisition of the I_MUTEX_PARENT lock.

The second one, simply removes the d_really_is_negative() check in
audit_alloc_mark() to allow dummy mark allocation, fixing the -ENOENT
failure when deleting dangling rules for unlinked executables.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Ricardo Robaina (2):
  audit: fix recursive locking deadlock in audit_dupe_exe()
  audit: fix removal of dangling executable rules

 kernel/audit.h          | 13 ++++++++++---
 kernel/audit_fsnotify.c | 29 ++++++++++++++++++-----------
 kernel/audit_watch.c    | 25 +++++++++++++++++--------
 kernel/auditfilter.c    |  9 +++++----
 4 files changed, 50 insertions(+), 26 deletions(-)

-- 
2.53.0

