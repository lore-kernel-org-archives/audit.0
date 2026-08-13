Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53E499F24
	for <audit@vger.kernel.org>; Thu, 13 Aug 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640808; cv=none; b=Wz2fLqdfeAAf4Djqc+bTmfyncvuJ0Aw/mrutlQD3Q1gpRJ41TdZ4VXVegN/B4q6JZsKIejf/4OYTA8mCm1txGb5gZZWlOjEfTOX89bURQiBdcjgXT+rkjr2iqw8LuiC0jtVadVz11xL6XAbhNlIc6RHdUB9vqoKB18aZkpkviMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640808; c=relaxed/simple;
	bh=lR8qSzQmvWmaB4RQMK4RGGNQKS1QaeJDt2mblFTguaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OoalK0YU4Dcn9Xqre0r+2IgTFqvkK3fpS8oFtSKwufsx7Puo/g67ijuR2+qIwsuT1tRqNFZw5tSrmKOtUz0oCCZU+MXQmAXbYbWGDf3nyYNqSYj8fC1zaWxCbNNXM3uHgo8j9ibrh4GetgIzHuGsfmbboaQrnihFC6N2sOWdTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gj4snvI6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj4snvI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TxFFtT5q6hhEXv1kvzuRF0i2wkqVQa93JW+RoA9mS8=;
	b=Gj4snvI6s3x4uCnOdDSeHGNCtW7aYOk4LdstgveO0/ht5ypMaytk8yfbSCWB71bsFbyuAb
	IjtG+HaP6Jf3Mx4BrbXRkEjmxshw3HR1NIdISjPh04a23S4SutQSkqTQO/ajj4peR5szYv
	Qy5hdaiiMXfHYKp4VScYfretmtax2wE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-kZvjQ2dNO5aDefn4CIGjPA-1; Thu,
 13 Aug 2026 13:06:37 -0400
X-MC-Unique: kZvjQ2dNO5aDefn4CIGjPA-1
X-Mimecast-MFC-AGG-ID: kZvjQ2dNO5aDefn4CIGjPA_1786640791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0777C18002C4;
	Thu, 13 Aug 2026 17:06:31 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3411D195608A;
	Thu, 13 Aug 2026 17:06:18 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 13/13] xtensa: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:03:03 -0300
Message-ID: <0c7aa94c05b08d959d885b3b0434646a6b2fcfd0.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: H60KAUoV0efQDVRFyF8OTe2eOLqSy3MwPJKREw7Fnkw_1786640791
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (areg[8], areg[9]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/xtensa/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index b80d54b2ea34..122a6ffc0757 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -564,7 +564,8 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 
 	audit_syscall_entry(regs->syscall, regs->areg[6],
 			    regs->areg[3], regs->areg[4],
-			    regs->areg[5]);
+			    regs->areg[5], regs->areg[8],
+			    regs->areg[9]);
 	return 1;
 }
 
-- 
2.55.0

