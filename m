Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977447;
	b=FyIIkZMVTzbUBWaApWVl0eVEnF9vGd1aUYQj0oApxqohMF0Be6pKpO9j5m/fmUDxkoix
	 FGFi8msom6zkLHs59X3Ky6oWr4ZqimQMszCOpK2oBn2rFLVfrSqUWwLJVW+4KKDC4u2zi
	 Pc2hndUbZx0EPqy/nNRfYRxkV30bZ+x6GLqERPCspd+36T64Y0ADK5pU2pXDq2ZHhPlF6
	 cpmNfNDRivoHtWg2BrquK9R1f5Dd9l/ENFitNzUI4Fom0up37zUYpq1HsAYFXb7wd6ykw
	 OWZVsO5BJNH+E97ngTTgcunqYoRKSX/RLP6qYuAilDACcyUrsooRw4h8rVYjkw8leTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977447;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1tTKTwRGeRjexoJc2YdTu6b3DVwuY28BJcq/ooAnLLA=;
	b=BpZ6wLFnRfGXpFZM4IBuwoCc3n/Zi3euVZ17XNhtyYdGU3+S3cYPVQh0NKjJDyNKSG2Y
	 HQo7fmWAlrGYad1i3BEBGTgObmbCRKd5Jri++30/Bks8/98f4srfnp0rp5ie6mHPMxnbA
	 +baE1ehMf/7ScijjhojFCbwBwWnjzesTZusQ4qO5cupAXfua5O7kt6II4sxLZeF3K3aBl
	 CWA+PfMv52saJMYwWydR5/7Fae59XRaq4yJuPXgfRVAKzImKayu5hY4NBzAqtVwy7ZnhJ
	 eoxPs87qj3lyBpUDVxubK/7XaeMRQuX5GPSvyQC8rL7ZOlsQ5duIpKeOKSqqUQ+39Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=AxLWfcPp;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D8606A32D
	for <audit@vger.kernel.org>; Fri,  6 Nov 2026 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5D8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=AxLWfcPp
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793977444;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTKTwRGeRjexoJc2YdTu6b3DVwuY28BJcq/ooAnLLA=;
	b=AxLWfcPpdUNc39wOovDC3qCc14AVl/dIFS+3eJSL5GA1W7E9pbAGYJ5Ybxwmszl0y/enoW
	nKkBU7SIRe0fzaE25lLMqzKeWaAWVWQbVQjXGKhNwjJKI2uWLQGi0Ot/VQXg6oofAIAnqk
	NiEb+faONVpQSxTvoev0Se2z5MN/CNmQ930j4BWuV8zmV7MWObEAWCB4v2UE3hUuGhFnzE
	yMcIqMQpu3vZv1NqO+sDDBjA8K/1efmXV3kMlxcujzzRygb7hp9dBaZLUAZY8umoLstiYe
	MHOsBbdrZBZLbY9OnRG80bHndFPK/exDefYS/qSrDwziDhXgteMNpC0XwavABQ==
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/3] audit: retain file paths for descriptor PATH records
Date: Fri,  6 Nov 2026 16:03:42 +0100
Message-ID: <20261106150342.670199-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261106150342.670199-1-cgoettsche@seltendoof.de>
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
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

fchown() and the other audit_file() callers collect inode metadata but
emit name=(null), even though file->f_path is available.

Retain the path with balanced dentry and mount references, and use the
existing audit_log_d_path() formatter when no filename was collected.
Release the references on context cleanup. Descriptor entries carry no
filename, so they can only be reused by a later lookup that matches the
same inode; keep the retained path then instead of falling back to
name=(null). Filesystem exclusions continue to skip entry creation.

The name reflects d_path() at event emission: concurrent renames and
unlinks can affect it. Original lookup names retain precedence.

This adds sizeof(struct path) to each audit_names. With the preceding
capability and layout changes, audit_context grows from 880 to 960 bytes
on the tested x86_64 SELinux configuration and remains in the 1 KiB
kmalloc class. Other LSM configurations can have different object sizes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
- reset fd_path after path_put() in audit_free_names()
- keep fd_path when a later lookup reuses the entry for the same inode,
  instead of dropping it in audit_copy_inode()
- place fd_path ahead of name
- use the entry returned by __audit_inode()
---
 kernel/audit.h   |  1 +
 kernel/auditsc.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 614afa1cfa14..476821dbed64 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -75,6 +75,7 @@ struct audit_cap_data {
 struct audit_names {
 	struct list_head	list;		/* audit_context->names_list */
 
+	struct path		fd_path;	/* owned audit_file() fallback */
 	struct filename		*name;
 	int			name_len;	/* number of chars to log */
 	dev_t			dev;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b740e056cd80..31c45f681b13 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -936,6 +936,8 @@ static inline void audit_free_names(struct audit_context *context)
 		list_del(&n->list);
 		if (n->name)
 			putname(n->name);
+		path_put(&n->fd_path);
+		n->fd_path = (struct path) { };
 		if (n->should_free)
 			kfree(n);
 	}
@@ -1531,7 +1533,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 			audit_log_n_untrustedstring(ab, n->name->name,
 						    n->name_len);
 		}
-	} else
+	} else if (n->fd_path.dentry)
+		audit_log_d_path(ab, " name=", &n->fd_path);
+	else
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
@@ -2347,7 +2351,15 @@ struct audit_names *__audit_inode(struct filename *name,
 
 void __audit_file(const struct file *file)
 {
-	__audit_inode(NULL, file->f_path.dentry, 0);
+	struct audit_names *n;
+
+	n = __audit_inode(NULL, file->f_path.dentry, 0);
+	if (!n)
+		return;
+
+	/* Resolve at event emission, so renames and unlinks can affect the name. */
+	n->fd_path = file->f_path;
+	path_get(&n->fd_path);
 }
 
 /**
-- 
2.55.0

