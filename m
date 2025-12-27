Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91F1F03D2;
	Sat, 27 Dec 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766825659; cv=none; b=bSxnob8VKIbWFd2wc87VHvEx3PrPJ1xEtQae7GOWnEN7hj6pzb+nFajH/blNmdMLBHPSRKTDb5oVn60yd/dCqrqKKOyVGDICkb52db4nNso8lC/HUNm8aD1Q4Ji581w6aS24x7AG2KjPl1KigcquRwwObU8nMFqkvYXD5BzVUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766825659; c=relaxed/simple;
	bh=+9mTbzxuuqHXr9/0roe1mte5dAfC211wO4T81D4RxhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhY9vidEPxv4IzBmPnm3jNG2xoyMGsy7TmlazlTbppNlmtrZBJEpn59CxVwHnUJAjRjz7tk6EPNNkHX0bIS2wIsNfO9aCrLOyZBlY8CqfZtLW7EBxyukjdZFd4vwbueXveYOlDh63pGAdGhs5BK0wytYlFKJMHQK4i8nAfJsPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=oTn1HtyJ; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="oTn1HtyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1766825380; bh=+9mTbzxuuqHXr9/0roe1mte5dAfC211wO4T81D4RxhU=;
	h=From:To:Cc:Subject:Date:From;
	b=oTn1HtyJ0zinyYQoeVhPju5zWsyLgkOpTPa+kntnWnRdoqcXkYi3SR2ysOiG8o535
	 zP3BW6IabIoaINY7S49ySS9HLNTse5wZaqetXSveYdmtgTevnsZjTxwQ83+s8wZgqv
	 FBW1TzFBr2//q9MLmk7b2jGA3r5D/cuiun3dbPWU=
Received: from localhost (88-178-48-87.subs.proxad.net [88.178.48.87])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 1F3484022B;
	Sat, 27 Dec 2025 09:49:40 +0100 (CET)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: audit@vger.kernel.org,
	paul@paul-moore.com,
	eparis@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] audit: add missing syscalls to read class
Date: Sat, 27 Dec 2025 09:39:24 +0100
Message-ID: <20251227083924.6549-1-jeff@bencteux.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at" variant of getxattr() and listxattr() are missing from the
audit read class. Calling getxattrat() or listxattrat() on a file to
read its extended attributes will bypass audit rules such as:

-w /tmp/test -p rwa -k test_rwa

The current patch adds missing syscalls to the audit read class.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 include/asm-generic/audit_read.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/asm-generic/audit_read.h b/include/asm-generic/audit_read.h
index 7bb7b5a83ae2..fb9991f53fb6 100644
--- a/include/asm-generic/audit_read.h
+++ b/include/asm-generic/audit_read.h
@@ -4,9 +4,15 @@ __NR_readlink,
 #endif
 __NR_quotactl,
 __NR_listxattr,
+#ifdef __NR_listxattrat
+__NR_listxattrat,
+#endif
 __NR_llistxattr,
 __NR_flistxattr,
 __NR_getxattr,
+#ifdef __NR_getxattrat
+__NR_getxattrat,
+#endif
 __NR_lgetxattr,
 __NR_fgetxattr,
 #ifdef __NR_readlinkat

base-commit: 15b0c43aa621fb77b32c46eb642eaf25557e9fdb
-- 
2.52.0

