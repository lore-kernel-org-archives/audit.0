Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019594;
	b=gWFXSIwfaR6CRC7ReyBPsryO/+oyAZkVkXPbGZo1SmoKONOWtT5R74UQbRZXFaEmrbG/
	 hriph/u09rWTvOo6qsOEN2jG+h0CrnHSRJJiioJjWhQA0SWH+Uki4Zn8FZJSU8jVqTzR5
	 NuHi9tPBu+LdFQIXRH83E8DRmMnF942UE0zYIk2JU0JslALJL0JEM7ZtH6jYpMf9ww1Gg
	 kr1ufN760wYOrAQcs0Z3FV0Niwq4cTNekNLnjKT5c1ouyg8ZpeaYMJth/8UjNggu1nwOx
	 au9jz0Teaou1zm4luBF5iTVUnKmFGRYm7bz0Kf0PC8eSIxphwH2zo6bQZNEAg5iz5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=/L6esCntDZwrPSgaQruvpjOsw85rTPdbho2Ekzz4Iew=;
	b=zJe1e3c5T9132ntDkMfjSsvwb28NY5ToDW6Gz8XploowkxWY4jHLppFDD4rfWZ7ZO9tG
	 6xFC3AAiHqrq3Wg0EuEQFAvXsi70GGzJx4t1S9vlYRC6Fx87HpK+5x0nrFup6gcSeq5fu
	 mQHmq6Gw6zzugQO7I1qB6gsnbbzJTQdkMuu1I6P3a6bX0KeD+377HrE6zRS7LZGDH3Jrz
	 1OrASzXouMURWBYwtrryTKVfnCAPOuw3O+mEfs9Z7MY47hcMbFSfIbFuUk75w3LWXpn3H
	 O+22xsj6h7/q3paQXSMRdXJK96ybrdWYgHj/Wl0kNcJIxioMVfMdE/jcIhrp/4dTBDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=sIIVQgwW;
	arc=none smtp.remote-ip=185.125.25.12
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E482606A7E4
	for <audit@vger.kernel.org>; Wed, 18 Nov 2026 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E482606A7E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=sIIVQgwW
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV6bW5wZHzZD8;
	Wed, 18 Nov 2026 17:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795019591;
	bh=/L6esCntDZwrPSgaQruvpjOsw85rTPdbho2Ekzz4Iew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIIVQgwW1BVlnWW6gZI+vKT6+xxEPINa7GA0+nYr49BdVQy5xdxzispAHE0LTTmUF
	 pqapPhcWlOlXnuIOkc7kPqDffsWhdaN78Mt9ZcM94mtMe2rul64NF1yIZTFiWyBOvV
	 GV6UdNkgcCxeakVu21+Oj5yMBs32Cbk6tVGq0ID0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV6bT6vSgzcyD;
	Wed, 18 Nov 2026 17:33:09 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] landlock: Document namespace denial operations
Date: Wed, 18 Nov 2026 17:32:52 +0100
Message-ID: <20261118163254.2554413-5-mic@digikod.net>
In-Reply-To: <20261118163254.2554413-1-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
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
X-Infomaniak-Routing: alpha

Namespace denial records now distinguish creation from entry.  Document
the namespace_op field in the audit and trace references, and clarify
that it describes the semantic namespace hook rather than exact syscall
provenance.

Creation reports the ID allocated for a namespace that never becomes
reachable, whereas entry reports the existing target ID.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/admin-guide/LSM/landlock.rst | 21 ++++++++++++---------
 Documentation/trace/events-landlock.rst    | 20 +++++++++++++-------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 946f3bf89650..a79912e8a684 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -7,7 +7,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: October 2026
+:Date: November 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -72,10 +72,13 @@ AUDIT_LANDLOCK_ACCESS
           :manpage:`unshare(2)`, :manpage:`clone(2)`, :manpage:`clone3(2)`,
           :manpage:`open_tree(2)`, or :manpage:`fsmount(2)`, or joining via
           :manpage:`setns(2)`);
-          ``namespace_type`` indicates the type (hex ``CLONE_NEW*`` bitmask),
-          and ``namespace_id`` identifies the target namespace (for a denied
-          creation, the namespace never becomes reachable so its ID is not
-          directly visible from user space)
+          ``namespace_op`` is ``create`` for construction or ``enter`` for
+          :manpage:`setns(2)`.  These values describe semantic namespace hooks,
+          not exact system calls.  ``namespace_type`` indicates the type (hex
+          ``CLONE_NEW*`` bitmask), and ``namespace_id`` identifies the namespace
+          object.  For a denied creation, the new namespace never becomes
+          reachable, so its ID is not directly visible from user space.  For a
+          denied entry, this is the exact existing target ID.
 
     **capability.*** - Capability restrictions (ABI 12+):
         - capability.use - Capability use was denied;
@@ -86,10 +89,10 @@ AUDIT_LANDLOCK_ACCESS
     in a directory that lacks both ``make_reg`` and ``refer`` rights would show
     ``blockers=fs.make_reg,fs.refer``.
 
-    The object identification fields depend on the type of access being blocked:
-    ``path``, ``dev``, ``ino`` for filesystem; ``opid``, ``ocomm`` for signals;
-    ``namespace_type`` and ``namespace_id`` for namespace operations;
-    ``capability`` for capability use.
+    The operation and object context fields depend on the type of access being
+    blocked: ``path``, ``dev``, ``ino`` for filesystem; ``opid``, ``ocomm`` for
+    signals; ``namespace_op``, ``namespace_type``, and ``namespace_id`` for
+    namespace operations; ``capability`` for capability use.
 
 
 AUDIT_LANDLOCK_DOMAIN
diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index 1ddc123df59e..0647a87677a1 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -6,7 +6,7 @@ Landlock Trace Events
 =====================
 
 :Author: Mickaël Salaün
-:Date: October 2026
+:Date: November 2026
 
 Landlock emits trace events for sandbox lifecycle operations and access
 denials.  These events can be consumed by ftrace (for human-readable
@@ -186,13 +186,19 @@ known allowed and quiet member masks.  Capability masks and the raw
 therefore appears as zero while still advancing the ruleset version, and adding
 a member already present still emits an event.
 
-``landlock_deny_permission_namespace`` reports the denied raw
-``CLONE_NEW*`` value.  ``namespace_id`` is the exact target namespace ID.  For
-a denied namespace creation, the namespace never becomes reachable so its ID
-is not directly visible from user space.
+``landlock_deny_permission_namespace`` reports ``namespace_op`` as ``create``
+for namespace construction, for example through :manpage:`clone(2)`,
+:manpage:`clone3(2)`, :manpage:`unshare(2)`, :manpage:`open_tree(2)`, or
+:manpage:`fsmount(2)`, and ``enter`` for :manpage:`setns(2)`.  These values
+describe the semantic namespace hook, not the exact system call.
+``namespace_type`` is the denied raw ``CLONE_NEW*`` value.  For a denied
+creation, ``namespace_id`` is allocated for the new namespace, which never
+becomes reachable, so its ID is not directly visible from user space.  For a
+denied entry, ``namespace_id`` is the exact existing target ID.
+
 ``landlock_deny_permission_capability`` reports the denied ``CAP_*`` number.
-Like every denial event, both include the denying domain, ``same_exec``, and
-``logged``.
+Like every denial event, the namespace and capability events include the
+denying domain, ``same_exec``, and ``logged``.
 
 Per-member quiet masks suppress audit submission but never these trace events,
 which report ``logged=0``.
-- 
2.56.0

