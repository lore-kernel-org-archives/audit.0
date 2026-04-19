Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89A40DFBD
	for <audit@vger.kernel.org>; Sun, 19 Apr 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613980; cv=none; b=bLQY/c6ytwChfePcTIV9CQv5KFiNKo2MRCghz/BntsjKAuojWMLpf1fug1/1Xp/vJZdOnc6Z+HsBriJyOzQMYEIS7d3HsalxXTEzFqfMnP8buxdWyesDE1v3dsLKm9Qg4fFDZCLXm9jyDHLgsRUzZJgAKZrxFQEpEWnyTt2PxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613980; c=relaxed/simple;
	bh=f/q9BNEy4I8hkWnOQKKk/OO0o1bd5Z7pLW7L7OChjgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IB+R31HWKmRu8cbRaN3y6h//h4f1eTsUIrYYH+EhHbhZ89qmWIiOxQ7joABo9umX8S9oApDeMHUPBbTOkfMEpTL4ubxQC6WdYz3hXkQrchqWZOgLIAdJpmn/oyYpKMtNorey5HeDaCMMsmVmZ4R5az55WeoM2dCTtBe/lBgYJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YP9JyFc9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YP9JyFc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776613977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cS9DLCb4fHoZ6AmAJrFPAc096MgiYBUgefSBwW4yLMg=;
	b=YP9JyFc9xj4TIpp+ZuVq0sYn3IPxRp4AgAzeudfJulrQHMeyTMyABDczIPm1hbEyc36hVX
	4X560bJDj0FAFdzEJv+GOYRsXIP4nOW58IdQVT72hmx/pLXAndrUWeIgDQjuQBZunXIA+e
	W8dLjS/PVWCtWzAMoHUtGAYBP/QuK6g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-cVycg8fEOf2aJa7imq1WvQ-1; Sun,
 19 Apr 2026 11:52:56 -0400
X-MC-Unique: cVycg8fEOf2aJa7imq1WvQ-1
X-Mimecast-MFC-AGG-ID: cVycg8fEOf2aJa7imq1WvQ_1776613974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F6801800454;
	Sun, 19 Apr 2026 15:52:54 +0000 (UTC)
Received: from fedora (unknown [10.44.32.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7D5151800357;
	Sun, 19 Apr 2026 15:52:49 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 19 Apr 2026 17:52:53 +0200 (CEST)
Date: Sun, 19 Apr 2026 17:52:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Drewry <wad@chromium.org>
Cc: Eric Paris <eparis@redhat.com>, Kusaram Devineni <kusaram@devineni.in>,
	Max Ver <dudududumaxver@gmail.com>,
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] seccomp: drop syscall exit events for rejected
 syscalls
Message-ID: <aeT6T7ZJ45yAtdZs@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: yj6Hm-wJNalpL6J6pciWOhd36VamJfVN5pLwNRHaWek_1776613974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On top of [tip: core/urgent] entry: Kill ARCH_SYSCALL_WORK_{ENTER,EXIT}
https://git.kernel.org/tip/7b41ff29c8d386257bae62ad557fd6bad8cc6787

Still RFC, please comment...

Of course this is a user-visible behavior change. ptrace and audit
will no longer see the paired exit events for syscalls rejected with
force_sig_seccomp(). I _hope_ this is fine and better than what we
have now. If this is not acceptable, we can return to "seccomp: defer
syscall_rollback() to get_signal()" we discussed before.

2/2 currently ignores !CONFIG_GENERIC_ENTRY architectures. If this
approach is accepted, it will be simple to update them one-by-one
to sync with the CONFIG_GENERIC_ENTRY case.

Oleg.
---

 include/linux/entry-common.h |  9 ++++++++-
 include/linux/thread_info.h  |  2 ++
 kernel/seccomp.c             | 22 ++++++++++++++--------
 3 files changed, 24 insertions(+), 9 deletions(-)

