Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019595;
	b=r9tAiVJSWIUz+M3BS39/Zv/5SAbr6jpWZWypdIXdAio2LUlsog9wapC+pQIKdJGqrkxp
	 Cf0GUsNiHdkIrk71LZPXrzM7gkBxtTC/K6VL1tTOEtmBJeYkUpaTilydxNOcQ2+oJR8Hi
	 Iik7AWZ3VBeExoykeQPlquvU5yM7kBs/UCN73VuAGDcxp7jMpN1PuA16xU7lpMtQWzB/P
	 wfyHS/oBM7710JEjeJl6UDovd6V+tdj++bSM/BNiE0tm61VqJsiMRFBC7899lXvMgDhIg
	 u14U+lKn2UO5wiiphR2K5FGu/INIIe4h5V7expB4zbGiWp+Vr1PFtOtqNif6MGjNl2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019595;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=GUvkIMyrKY8gi6gwt0x0y57vbSmJHe3gNr8Xn9n2TdY=;
	b=c7yPHo32BmEYXvca/HQe8BUod7U49dpKXWAroOwZPE0+gTJOkrr8Bugu6ruUZXrPmNQZ
	 0jY79DqfTZMhxOtaPOCH5x/a8oxa4b77nd1ZMwedLWdU66S7hM2jONUtbmX3zPg+MSJVP
	 3vJMz0aPSLQ8OGCMQP+iEahBllvxmeklNJIN+Mazo3nidh05CNsUN2jkBQemqU7KvlNy6
	 VwyfGcEDwT1CzlYZOhJ1Z6YYgU1wlWmZ+t6MJyINqHMTrgqcTnCOEXcR+WlBT/UKQ6uOZ
	 qHyW08GtBjRhdmgW2WJVo5kqbgF6Nv8E5DXZj4zOKJPb4aq3Vu1W1Yg3XtmlxkiIPKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=ZJBw78gD;
	arc=none smtp.remote-ip=185.125.25.8
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E01606A336
	for <audit@vger.kernel.org>; Wed, 18 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E01606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=ZJBw78gD
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV6bP05j3zZMJ;
	Wed, 18 Nov 2026 17:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795019584;
	bh=GUvkIMyrKY8gi6gwt0x0y57vbSmJHe3gNr8Xn9n2TdY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJBw78gDl5RWce75YL5/mmYtzdl98QATVTf1EbLPSO87WYQozbaa00QJX9xreERP/
	 LIqlSGQf2/5vQfrQDevWCb+8cAa8CRaDSlNEg7Cru9Tj7GgEdWM5riEZODH6ija9BX
	 zY7W6q+dWaxMsn8rD6n13hQWF7kFXzt9E/foIP7E=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jV6bM2xK5zbWl;
	Wed, 18 Nov 2026 17:33:03 +0100 (CET)
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
Subject: [PATCH v2 0/4] Landlock: Fix namespace and capability denials
Date: Wed, 18 Nov 2026 17:32:48 +0100
Message-ID: <20261118163254.2554413-1-mic@digikod.net>
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

Hi,

Landlock namespace denial records identify the namespace type and ID but
do not say whether the hook denied creation or entry.  The ID is object
context rather than an operation discriminator: after allocating IDs
before the namespace_init hook, construction carries an ID for a new
namespace that never becomes reachable, whereas entry carries the
existing target ID.

Capability denial tracepoints have the complementary problem.  They
report the capability number but omit the exact credentials and target
user namespace used by commoncap's capability check.  Either argument
can differ from current state, so reconstructing them from the tracing
task can misidentify the security relationship being checked.

Fix both denial interfaces without changing Landlock policy or UAPI.
Namespace denials gain distinct internal CREATE and ENTER request tags
and print namespace_op=create or namespace_op=enter after the common
blockers field and before the namespace type and ID.  Both operations
remain context for the same namespace.use blocker and describe semantic
hooks rather than exact syscall provenance.

Capability denial tracepoints gain the authoritative checked cred and
target user_ns as synchronous BTF-only arguments.  They are not copied
into the raw ring buffer, printed, audited, retained, or used for the
Landlock verdict.  Capability options remain omitted: CAP_OPT_NOAUDIT
suppresses the denial record, while the remaining bits do not explain a
Landlock decision.

Paul and Eric, please review the audit record addition and field
ordering.  The new namespace_op field is Landlock-local because Landlock
is currently the only LSM_AUDIT_DATA_NS emitter; it can move to the
generic formatter if another LSM later needs the same contract.

The base includes Christian's namespace-ID allocation fix.  Patch 1
distinguishes namespace creation and entry in audit and trace output.
Patch 2 supplies the checked capability objects to typed trace
consumers.  Patch 3 completes quiet ENTER coverage in the Landlock
selftests.  Patch 4 documents the namespace operation field.

Changes since v1:
https://patch.msgid.link/20261117102110.2524197-1-mic@digikod.net
- Rebase on the commoncap-check fixes, forward their exact user
  namespace context, and document why global checks target the initial
  user namespace.
- List the new standard BTF objects, correct capable-hook-only wording,
  and trim duplicate commit-message narration.

This series depends on the commoncap-check fixes:
https://patch.msgid.link/20261118145217.2551053-1-mic@digikod.net

Regards,

Mickaël Salaün (4):
  landlock: Distinguish namespace creation and entry denials
  landlock: Add capability objects to denial tracing
  selftests/landlock: Test namespace denial operations
  landlock: Document namespace denial operations

 Documentation/admin-guide/LSM/landlock.rst | 21 +++++-----
 Documentation/trace/events-landlock.rst    | 26 ++++++++-----
 include/trace/events/landlock.h            | 36 +++++++++++------
 security/landlock/audit.c                  | 10 ++++-
 security/landlock/cap.c                    | 45 +++++++++++++++-------
 security/landlock/log.c                    |  6 ++-
 security/landlock/log.h                    | 12 +++++-
 security/landlock/ns.c                     | 10 +++--
 security/landlock/trace.c                  | 12 +++++-
 tools/testing/selftests/landlock/ns_test.c | 25 +++++++++---
 tools/testing/selftests/landlock/trace.h   |  1 +
 11 files changed, 145 insertions(+), 59 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: ddc6687ae87f8f782ed8ad5b005834f242aec2fb
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: 03ec09be2416d4cc932b07dfb0e7450f15c22804
prerequisite-patch-id: 383fa2ce8a4ed44e4b5c828c99c5be5ee75048af
-- 
2.56.0

