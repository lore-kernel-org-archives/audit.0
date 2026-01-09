Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9842737EE;
	Fri,  9 Jan 2026 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961111; cv=none; b=GGZMKqUkGbCWJamBltujVqvILu/1po9ibQKUv5u1B2Egm6Qs7VRs42RlqRjUIbrb4Xa2x5fPJ4l3T08xhxQKwbvt7WiUDmIiY2NkRRFv8QAlaCrJf69DCPerPLZVCja1rL1AJQFzVzn3BZTS2cF3n/5C1b2Z/e07mKFMib4Z9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961111; c=relaxed/simple;
	bh=LWVWX6B+FZI+8JHsZYBuqtGJVzRr8vR1bfRG7RC5KXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MU4Pa0Fa3l3IXrHnd/v3ztR8xMBcAV0SNzeVCWxQkPAMxwfU327l7O96fl1fUyjZ0ZID3N2bQuUNjkHLfS+h3YmekJjUuNb77fUBKrgYlKXolErT3yx6Yl+KGYJCJNhW6rbTa4T9zMxTtr7t+se7gDSqBpuDOSVZ9+KGiJ891YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=IDgAcVws; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="IDgAcVws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=SJfdUlWR95PR2QfqTtsVrn8SETLYjLYxhRiscJLmctQ=; b=IDgAcVws1yxo5C
	u21bb95/MQ1Amu4MBRac/x8rUKNfgRYZGWb2Z464+jhmgtZbn9emk3WwdDys7eRhat9p6Tm2hkFK9
	3zZ1UBObpR06kdZTGE1A11XZky0TouyGG8wa+WYvnVe3CkrlalwYy3O7rEX6pocLIAohD9Nzofvqu
	ybEq2Scx98lVcY8ohsYlCXnc4Kc+9Wm8ex7ylselAY22tNxqWYOC7DUtFUidSRBbaf1tZjkWMELkg
	mhHe0aI/dSwzC2QL/Zt3aKEbJtX2/77Bk4/kCJhrz6rNbIDBNx0jIGLZF+Pdhf27Z0uz938A449xs
	FACnWMQG8V3dYBjlnobQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1veBRa-00BsNJ-TW; Fri, 09 Jan 2026 12:18:18 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1veBRa-00000001bZc-22H7;
	Fri, 09 Jan 2026 12:18:18 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	audit@vger.kernel.org
Cc: eparis@redhat.com,
	paul@paul-moore.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] audit: sort missing compat prototypes
Date: Fri,  9 Jan 2026 12:18:16 +0000
Message-Id: <20260109121816.382751-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The comapt_xxx_class symbols aren't declared in anything that
lib/comapt_audit.c is including (arm64 build) which is causing
the following sparse warnings:

lib/compat_audit.c:7:10: warning: symbol 'compat_dir_class' was not declared. Should it be static?
lib/compat_audit.c:12:10: warning: symbol 'compat_read_class' was not declared. Should it be static?
lib/compat_audit.c:17:10: warning: symbol 'compat_write_class' was not declared. Should it be static?
lib/compat_audit.c:22:10: warning: symbol 'compat_chattr_class' was not declared. Should it be static?
lib/compat_audit.c:27:10: warning: symbol 'compat_signal_class' was not declared. Should it be static?

Trying to fix this by chaning compat_audit.c to inclde <linux/audit.h>
does not work on arm64 due to compile errors with the extra includes
that changing this header makes. The simpler thing would be just to
move the definitons of these symbols out of <linux/audit.h> into
<linux/audit_arch.h> which is included.

Fixes: 4b58841149dca ("audit: Add generic compat syscall support")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 include/linux/audit_arch.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
index 0e34d673ef17..2b8153791e6a 100644
--- a/include/linux/audit_arch.h
+++ b/include/linux/audit_arch.h
@@ -23,4 +23,11 @@ enum auditsc_class_t {
 
 extern int audit_classify_compat_syscall(int abi, unsigned syscall);
 
+/* only for compat system calls */
+extern unsigned compat_write_class[];
+extern unsigned compat_read_class[];
+extern unsigned compat_dir_class[];
+extern unsigned compat_chattr_class[];
+extern unsigned compat_signal_class[];
+
 #endif
-- 
2.37.2.352.g3c44437643

