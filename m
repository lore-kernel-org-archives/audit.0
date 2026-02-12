Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5126E71F
	for <audit@vger.kernel.org>; Thu, 12 Feb 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919750; cv=none; b=M5nCaH0MuvuaTUQ3hKcB3AGoPuAuEH4gZpUGi9BCzr6uuVFnZLK65Gt9xKezWw27gBAkUrIDUwE8N44mgwziz36u6u0eeahA2sNRu7ePOecZaLLK6Li5kgsfqoOBnd8yoEznpk81Z8TX4ufgUq8q4KMpd4es0opc9OexT3krH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919750; c=relaxed/simple;
	bh=mzuI1FMO7QtuIRQ5U3mqDpk3IW3+dfzY829HS5JEBec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ftT9/4b8nbVwA/Tc2OTIxK4IiZTjJpSHs8YK5ggwA4eiqu6rUo1Pz7xLkfE0BjfC9ypLxsWx+fODTSfRAOyPz2F/vCrCmgEgL4Z2EDyKrWuH5Of0W8r8Y0dmlz1pDtjXlQ8xdc1ANs3FeKL2klNrwtCOaqaxX5aRQiV8fwHCqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuHwjRVW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuHwjRVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770919748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly2nA8ZJ0dJIvsrFKrjSkM+A6/05aZpz+ZyV0YXxmwQ=;
	b=FuHwjRVWkG+SbPyIrGYpvyUnCmpFxZc1bmsNvgBMagRwVbumqd2BlqAbhUMgQESxmBOoYq
	w+RtpDHYHgBrDf8lKZG5+/Fu9cmerlsykY/+DUrWFlL9It2PTUB0sIjGFJZQuVlbaGU0JW
	EljrWPssphWQgKBYteqzb2UipnMkdaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-sXX38uMZMKqCrfOjNrJs-w-1; Thu,
 12 Feb 2026 13:09:04 -0500
X-MC-Unique: sXX38uMZMKqCrfOjNrJs-w-1
X-Mimecast-MFC-AGG-ID: sXX38uMZMKqCrfOjNrJs-w_1770919743
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35B71800352;
	Thu, 12 Feb 2026 18:09:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9433F19560B9;
	Thu, 12 Feb 2026 18:09:00 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v3 0/2] fs, audit: Avoid excessive dput/dget in audit_context setup and reset paths
Date: Thu, 12 Feb 2026 13:08:18 -0500
Message-ID: <20260212180820.2418869-1-longman@redhat.com>
In-Reply-To: <20260206201918.1988344-1-longman@redhat.com>
References: <20260206201918.1988344-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: yo4Kwz_ERRFoXqaF1q6_69jmC1ORO2QRH_HRXwusfeE_1770919743
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

 v3:
  - Add a new counter in fs_struct to track # of additional references
    to pwd and add a new get_fs_pwd_pool() and put_fs_pwd_pool helpers
    to use the new counter.
  - Make audit use the new helpers instead of storing pwd reference
    internally.

 v2: https://lore.kernel.org/lkml/20260203194433.1738162-1-longman@redhat.com/

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

This patch series aim to avoid this type of performance regression caused
by audit by adding a new set of fs_struct helpers to reduce unncessary
path_get() and path_put() calls and the audit code is modified to use
these new helpers.

Waiman Long (2):
  fs: Add a pool of extra fs->pwd references to fs_struct
  audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd
    references

 fs/fs_struct.c            | 26 +++++++++++++++++++++-----
 fs/namespace.c            |  8 ++++++++
 include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
 kernel/auditsc.c          |  7 +++++--
 4 files changed, 63 insertions(+), 8 deletions(-)

-- 
2.52.0

