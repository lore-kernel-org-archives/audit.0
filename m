Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC2201256
	for <audit@vger.kernel.org>; Wed,  5 Mar 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210456; cv=none; b=F0UioQUlwIR9xh3xM5hnlxQtgHTcSDDvXG5o3vXHUICjTEthtM4IihKrVJQIyCn1GK9iaDwmGtMaI1VC/qxjMXBkoxerxBRXTs/pdXPq4BQLlxAvKau4rEgQe78emOotqdOscMbC4JGUE//BEwbhpPwXAmwI+ym2Agk+8bPSSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210456; c=relaxed/simple;
	bh=ep9ww7LolssnGrtk6cTUs2Y9NDSnty65KAVNmKS6Rqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=lFcgODes22X3cI8MoMaJypp2iKoDA8hdtzGP9sNWNUwXhqaxvIHKrRtmg2WPYYqYXfEQsWQ5842thAVNXKaqEBb0ZJHFUBak1V9rhLFJJyrUeqncQpGvp1IUFxIC0pAI/LHqnrc+0skRiH36BZ/7Yvbg2VbMmbzAuwKZUwWqH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgXZncMX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgXZncMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741210453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1M1bYpA0gjyisxYKCSOVGnnYCvJ6RZJmMdkBmiQCKBg=;
	b=RgXZncMXBnFKjKEK2HtWoLjaj6zhVMR3o+PEUtYU8K3LMUbMokx61VeM0rq8Z3G8SEtitc
	Nv3vbr5LnXzUDCZ8fhRZ6LN/P8kzEG9N8YCzw2oeuK2eg++kiCDqRs0STbOyGItNKuZnWf
	AOA4rMQHtonb2F9GX+XQccjSYmiUnYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-VDluHIHzPYaz5WoNUJnVBg-1; Wed,
 05 Mar 2025 16:34:07 -0500
X-MC-Unique: VDluHIHzPYaz5WoNUJnVBg-1
X-Mimecast-MFC-AGG-ID: VDluHIHzPYaz5WoNUJnVBg_1741210446
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BF921800257;
	Wed,  5 Mar 2025 21:34:05 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.76.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F91B1955DCE;
	Wed,  5 Mar 2025 21:34:02 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v1 0/2] override audit silence norule for fs cases
Date: Wed,  5 Mar 2025 16:33:18 -0500
Message-ID: <cover.1741210251.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The audit subsystem normally suppresses output when there are no rules
present to avoid overwhelming the user with unwanted messages.  It could
be argued that another security subsystem would generally want to
override that default.  Allow them through for fsnotify and filesystem
security violations.

Richard Guy Briggs (2):
  audit: record fanotify event regardless of presence of rules
  audit: record AUDIT_ANOM_* events regardless of presence of rules

 include/linux/audit.h | 8 +-------
 kernel/audit.c        | 2 +-
 kernel/auditsc.c      | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.43.5

