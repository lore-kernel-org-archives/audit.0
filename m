Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019593;
	b=fQfUMA6V3sEZhZP0ewMaOEx9BfsQJNoh9uRgvF9KwEIXwrthuMx+8SQckaKBB019L/i8
	 nKH46VsHbP4ynaVZ6HIJPjlpXJklapUDuA5Mnq1hF6699vRA+ZjiX6qr5aSKJOvQQ1eA7
	 XJ4M7VRdOfuxnHkxxjJNvgc2iIH8agndQKAEUq6CmRCRNY6XJFCtrmFLs00xZNGonGX8i
	 sDLvyu1jrADoG/X4InShJdihWz1BSFRWLkMmpObVKtwMzfbprhCDaqiV8hWsBQ+o9a67K
	 KuD75xE/iRb5801YpA91JEj+t26hLfJVlYzm5ZBsOqnqkOJmugGF00eNz206YGfQdhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	b=ZIERrKXrxYaWG9d/Ts7m63NS6H8cVmvPDpsy1df6CjY/cXMQZl/l4Udx9skjXsaaBrED
	 o37pwGGo1QqKO7WyHTaUZ58qs2u0GgqRlMaZUe0goBC8Zqz/E51na+JraNxzrl2N/HUCV
	 LtAv2/WS2u/oLgsYhaawpr10E/o4M1ymS//4q6xE+6kDt4AYPj99l3K8atjFoMrYoUNAk
	 bbIyKOO8hOORIDFsmnwowFVnEyBvEqtiUROiyIR8C5ttGTVQAsgzt/paeogtxPUBm2dlX
	 6N6Sw8kfRERUF/WVOlpqXJNUZnIiTV4cnm0Ianqe4QR92/M5uKXqZq6TE9duWUOhL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=kICNzX1k;
	arc=none smtp.remote-ip=84.16.66.173
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7B606A33F
	for <audit@vger.kernel.org>; Wed, 18 Nov 2026 16:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C7B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=kICNzX1k
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV6bT4t9czHjL;
	Wed, 18 Nov 2026 17:33:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795019589;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kICNzX1kK7IiAgHTL36Xgr6DvPKszhtRb03xo0J+LaYNC42ZNEHnT6M2/LRRHFGqf
	 5EkEW5PQJAFAxCaoDNV7SSQb0TBkVoA84IMm07D0dbMD6zkcV7oeiGZmig8VGDAESN
	 SUec52Rfq0w/Hugffd7WyJpUmMGIiUTCJU0VSj6o=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV6bS1WfXzmJH;
	Wed, 18 Nov 2026 17:33:08 +0100 (CET)
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
Subject: [PATCH v2 3/4] selftests/landlock: Test namespace denial operations
Date: Wed, 18 Nov 2026 17:32:51 +0100
Message-ID: <20261118163254.2554413-4-mic@digikod.net>
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

The namespace trace tests cover creation and entry denials, but only
creation exercises the quiet path.  This leaves the new ENTER request
tag untested through quiet selection and trace dispatch when audit
logging is suppressed.

Add the missing quiet setns(2) case.  Together with the existing cases,
this exercises all four combinations of CREATE and ENTER with logged and
quieted denials, including each exact namespace_op value.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/ns_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index d4a85cbebeae..52206ad94eca 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -2575,6 +2575,13 @@ TEST_F(ns_trace, deny_setns)
 	test_ns_trace_denial(_metadata, true, false);
 }
 
+TEST_F(ns_trace, deny_setns_quiet)
+{
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+	test_ns_trace_denial(_metadata, true, true);
+}
+
 /* clang-format off */
 FIXTURE(ns_proc_open) {
 	/* clang-format on */
-- 
2.56.0

