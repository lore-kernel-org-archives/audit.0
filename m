Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A03359F8A;
	Fri,  9 Jan 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965985; cv=none; b=ZG34jGMOiaufzP+ksG1GFPnlyEooFLWYy4SSfXwNBxjGVbb17EgA8Dn5nYEf8rH2tYuwdyAuJri7VIztWFbiU5mp4xO9qroj4qYsuUoaDGmnEnummbp18qkBONgn9+e04aN+0cUCq2nyrwqhFXVT2MinLFsIvxSI/TszEiZBe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965985; c=relaxed/simple;
	bh=i/8LBUsXejRwwV98FgPdSgzsH0IB/QdyN5nBXS/JKFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LM0MiIHkUqSselCuyYkjI6lfcQLAxWbjgckZGc9P0TCFDbZuQWTxkqQ3sfNiqSX+K8T/h/pJecCV9Vc/aUXoVXHggNr7MyBZ0Cz3gXiDiv1BKcaQZ8KA6finZ1gXP0rjjwxVIo4PgzKUpt8GCDzpEfITrKumjSG/9oeuG0qkp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=As2013WW; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="As2013WW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=3KDI4caDbWyTSLLFc6guXyRikkqB8IU5d51kXf7krkQ=; b=As2013WWwqtt9t
	mJ/6GcULu14H+LiA19ImXxfg7qxMww1lOF4WOeFkfSYgSlPcEXh5Ti8LPD5HggTUafeos88Pem+AV
	S1mNyt3IBTP8jBBk/5A+xwEhZ2AjWjke53vSeja5nDIYBYH3U7C4H+8XLcyBz8ofmG41RQoEORxkZ
	OlPzZ1FYRI7pr2E3Ldj68YAPpkWUAYn+t4Ct5sJMKNEofmo3JdgkXtXycCJWI1S6KtiYYE2/7dmEe
	ug1zcQJWjlKJ1NN59Wv+7ZgT0n3pJoguUkOsC3EGViue4TSp2FKm/z4aiz+nULlWB2FiC/fmjrhXV
	KxTVX7ZfvE6+L3NZSuDQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1veCiJ-00BxWC-MK; Fri, 09 Jan 2026 13:39:39 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1veCiJ-00000001hIP-1gTs;
	Fri, 09 Jan 2026 13:39:39 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	audit@vger.kernel.org
Cc: eparis@redhat.com,
	paul@paul-moore.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] audit: sort missing compat prototypes
Date: Fri,  9 Jan 2026 13:39:38 +0000
Message-Id: <20260109133938.404748-1-ben.dooks@codethink.co.uk>
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
v2: fixed missed commit of include/linux/audit.h
---
 include/linux/audit.h      | 6 ------
 include/linux/audit_arch.h | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 536f8ee8da81..b8d8029c6c48 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -128,12 +128,6 @@ enum audit_nfcfgop {
 extern int __init audit_register_class(int class, unsigned *list);
 extern int audit_classify_syscall(int abi, unsigned syscall);
 extern int audit_classify_arch(int arch);
-/* only for compat system calls */
-extern unsigned compat_write_class[];
-extern unsigned compat_read_class[];
-extern unsigned compat_dir_class[];
-extern unsigned compat_chattr_class[];
-extern unsigned compat_signal_class[];
 
 /* audit_names->type values */
 #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
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

