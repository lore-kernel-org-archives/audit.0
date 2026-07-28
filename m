Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731119E839
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248075; cv=none; b=nwwu93yaEf1bkSw2/K7oZYFeTVk6rwSce7GVguDvfKB1eA6sNdynqS8INuh6ytP+zbV5/+DlRlb8T5mgnkAf9AGTKUQP5t7YR4HV9tIPORK3k+FAxmPG7nGpcub7Z0nfJE1kfsiMAkCY5XVuB1DK03JR81/zeF+4nbui8sJupJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248075; c=relaxed/simple;
	bh=DRjW94m3ShUjioB+daBtohd7odskgBokUoy0ZnzvulY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=D258Y3nwd62ohhq9Opkf5MXgXt5Ydcic4bqJrsaQtZU0LLor5NukyYphFi871wOH05PEsTse8prGR8nz+CGLGs9ZHigVEtvTuFKBcqC75gWEq08CcnfPjSzaDD0B+8OmgJ/dALLeXpZNhNburFlOh7/H7VkZXSH6XwAUTKUOrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9vQTSj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9vQTSj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785248073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HPFiq98RO4cKQOs06pGBimPFP9JRN/fZYdGPmSt/pXE=;
	b=Y9vQTSj2JkJq2aPGUHdwGsrHrivyHLXOucBuea56P3cZ9TQfVyL5TVFvzbFOo1BaZMOCgj
	gzBFN+r1oOXKur2I7bPnmA66XeJt1YZJONGFtM+9mBr67KKm6mAw90CTuItHZXiQq8ICt0
	0mFAyu3huAXibQkhL3KZBZa80IlePhQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-viI457WUNy-J1tkPTP8d9Q-1; Tue,
 28 Jul 2026 10:14:31 -0400
X-MC-Unique: viI457WUNy-J1tkPTP8d9Q-1
X-Mimecast-MFC-AGG-ID: viI457WUNy-J1tkPTP8d9Q_1785248070
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2C619560B8;
	Tue, 28 Jul 2026 14:14:30 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5524D18004AD;
	Tue, 28 Jul 2026 14:14:28 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 0/2] audit: drop BUG_ON() calls
Date: Tue, 28 Jul 2026 11:14:22 -0300
Message-ID: <cover.1785246707.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ovbiPqQPZPSKrKPmeIxLMrO31gZrX_dH3e9znZL_S-0_1785248070
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series drops two BUG_ON() calls from audit_add_to_parent()
and audit_signal_info_syscall(), replacing them with alternatives
that avoid panicking the kernel for conditions that are either
debug-only assertions or defensive invariant checks.

Ricardo Robaina (2):
  audit: drop BUG_ON() from audit_add_to_parent()
  audit: drop BUG_ON() from audit_signal_info_syscall()

 kernel/audit_watch.c | 2 +-
 kernel/auditsc.c     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.53.0

