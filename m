Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977447;
	b=5PvBD+MLGNZiUiTS1VtbAADqRuN5kmtmqbgZqeGGwcFuVfgX9uU96DoS6SZyB5FTmMRj
	 LoTPyAj/2g3eRYILFQao55JysAS90kLIiTWMrjSgGCT0bA9lH94mU61CgoA/hXOyEjYVk
	 3d5YkP58NcCR5J4Y2bMnhT/jRzJ9J1BU0SWNEtVug1TOkbs3vAyAv0Zdl4X7l0BQgKwG6
	 7P6nrYwaoO2BXq4f+R0iWTB3Fye0rf1/MBDSMxNJJRlvWclCl41l0bZJoQvnNstMsQxjV
	 60Jbhrrz1oB/DYAokN1NjZcW7+dVAd1ihQuvdKtQM5yMnkcaMNBFyzzin7mbvlGoGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977447;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OFFqQmZJZbdaHYXS8KsGvp3Nr5z3a6FCHdTPdWLIjKY=;
	b=yQDx2EPfA0xRywdI8oY1RFM08uaaxxvPRicCXxKp8qRwHBKSbhTlMa6/YghA6++rxrqa
	 gNEwv+7nr6N4XxgRq85JdXN/LzISNAApmGw8oC/PSWGVOVPC5Sg5yFt+8nS33pR3PcQam
	 UW2NnNB8T5b2Dxce9guie4nmNNb9oiYIEwMLWeJWAjLqE+hXitg2jEnIZ5vR6iRoo4R4K
	 z5gAJ9dTx5hL+F++PUSZ0U1hfYBGZ2CguS0MW/c/pfcVyGTh5nrxZHhPemYxv6LGbDDu4
	 gcNXzEpwBi1rmAcC2c/pJYLbP4pDtnx+DrWx/VA9OG1o38mpVRA6wgQ6ErIWlrGkzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=B0DvwgLU;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226D606A32C
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5226D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=B0DvwgLU
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793977444;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OFFqQmZJZbdaHYXS8KsGvp3Nr5z3a6FCHdTPdWLIjKY=;
	b=B0DvwgLUaP9KB9/f/Fnb8j3+dDDy1+LEMP0HDUFP1QRGeEPfe+q/pYNJ4A0cW2Z3DL7MTe
	LKB0zZ+oEzlSiOXjwh2dtzoom3G4p1f6OCpuWtgKbb/wZpue1nsaRzYytef+ZTJ+e9C3im
	vxyBGlpp7lTHRnfOol68lUchIfyRrfYXci4kakjVACgUIxSajNxQNAFZ5BrD8ItppLKmRv
	QQPVCsI5/6aSULqrUDoGmTzdCaDuDwCV4gOdBylSYrpm1BbUVqUoF2Gx9ieRV1Si01BYjv
	KT6T41tt20O5FjcdkRPLhw4ENch1CNV85BJkHSIpNVH2lZgj7yfoIUKfQXIbrQ==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/3] audit: compact name entries and context fields
Date: Fri,  6 Nov 2026 16:03:40 +0100
Message-ID: <20261106150342.670199-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Group the inode metadata and the small scalar fields of audit_names to
remove padding, while keeping the pathname next to its length and the
file capability revision next to the file capabilities. Store the
per-name file capability revision in s16: it must represent both the
eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Keep
the existing formatter and its unknown-capability output unchanged.

Move name_count ahead of the embedded name slots to remove two alignment
holes, and place personality before the task credential scalars.
Preserve the first int dummy member required by audit_dummy_context(),
all five embedded name slots, and the existing allocation and reference
lifetimes.

On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
leaving room for descriptor paths while staying below 1 KiB. On the tested
arm64 configuration without property-bearing LSMs it falls to 872 bytes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
- keep name next to name_len and fcap_ver next to fcap
- move name_count below the names_list comment
---
 kernel/audit.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 7640d2c0fba4..614afa1cfa14 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -77,17 +77,14 @@ struct audit_names {
 
 	struct filename		*name;
 	int			name_len;	/* number of chars to log */
-	bool			hidden;		/* don't log this record */
-
-	u64			ino;
 	dev_t			dev;
-	umode_t			mode;
+	u64			ino;
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
 	struct lsm_prop		oprop;
-	struct audit_file_caps	fcap;
-	unsigned int		fcap_ver;
+	umode_t			mode;
+	bool			hidden;		/* don't log this record */
 	unsigned char		type;		/* record type */
 	/*
 	 * This was an allocated audit_names and not from the array of
@@ -95,6 +92,8 @@ struct audit_names {
 	 * should be freed on syscall exit.
 	 */
 	bool			should_free;
+	s16			fcap_ver;	/* 8-bit revision, or -1 for NOEVAL */
+	struct audit_file_caps	fcap;
 };
 
 struct audit_proctitle {
@@ -132,8 +131,8 @@ struct audit_context {
 	 * through the preallocated_names array and should only be found/used
 	 * by running the names_list.
 	 */
-	struct audit_names  preallocated_names[AUDIT_NAMES];
 	int		    name_count; /* total records in names_list */
+	struct audit_names  preallocated_names[AUDIT_NAMES];
 	struct list_head    names_list;	/* struct audit_names->list anchor */
 	char		    *filterkey;	/* key for rule that triggered record */
 	struct path	    pwd;
@@ -142,10 +141,10 @@ struct audit_context {
 	struct sockaddr_storage *sockaddr;
 	size_t sockaddr_len;
 	/* Save things to print about task_struct */
+	unsigned long	    personality;
 	pid_t		    ppid;
 	kuid_t		    uid, euid, suid, fsuid;
 	kgid_t		    gid, egid, sgid, fsgid;
-	unsigned long	    personality;
 	int		    arch;
 
 	pid_t		    target_pid;
-- 
2.55.0

