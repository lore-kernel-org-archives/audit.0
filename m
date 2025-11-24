Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0D2147FB;
	Mon, 24 Nov 2025 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014584; cv=none; b=nkAFVGIhNVcVKKFRYddOXSbnPqXahHH6geEQ/zGLKXZWy06WzwieYuI+tl70YCqVGJ/j9ouQ7L1kFes2JViAR6Efh8ouVYyRGmRpeoWaJXfWRwRW0zB8CAHcb9nikYwGx8w0cC3IorIPC3lUOPpmmDL+6MXCinctUcIok3U2BR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014584; c=relaxed/simple;
	bh=oilSQorDJ2YLiex3kfij5+AakgCpFNdWBbn9OHcANjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esPW4+hqrXHIPQ6X983GTxN20fSiAAvIRi8qQNYqRJ7p01Zrn4BkYCT+xKt+wjI1fFXK/R/32Wz57uidGwkU7N7d+p9DB1tzrB7O56iHjncP6N+gW6xt/gMfOO4nezVQV9B4Hma1zD00XrV9/1XvS1KU73dFWSnG/XYWpq3ozeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=K8B53eYS; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="K8B53eYS"
Received: from localhost (88-178-48-87.subs.proxad.net [88.178.48.87])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 6ED2A40208;
	Mon, 24 Nov 2025 21:00:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1764014403; bh=oilSQorDJ2YLiex3kfij5+AakgCpFNdWBbn9OHcANjw=;
	h=From:To:Cc:Subject:Date:From;
	b=K8B53eYSdje3zwSqT2q2JwwkPzRFNBBcmmzX3w0zGQ1oLqoAHPkhkhI1BbXLY5pyp
	 y7J3B+CClP0jAxgNZy5ScD4rk5u4RoeP4dMYcSwsqK2ZiLlORl9TtYL2IlVHHNsZII
	 D9R9WnillDY3C1bhdvaM01HMq/LPeC3C9tIel2tI=
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: audit@vger.kernel.org,
	paul@paul-moore.com,
	eparis@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] audit: add fchmodat2() to change attributes class
Date: Mon, 24 Nov 2025 20:49:30 +0100
Message-ID: <20251124194930.8576-1-jeff@bencteux.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fchmodat2(), introduced in version 6.6 is currently not in the change
attribute class of audit. Calling fchmodat2() to change a file
attribute in the same fashion than chmod() or fchmodat() will bypass
audit rules such as:

-w /tmp/test -p rwa -k test_rwa

The current patch adds fchmodat2() to the change attributes class.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 include/asm-generic/audit_change_attr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index cc840537885f..ddd90bbe40df 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -26,6 +26,9 @@ __NR_fremovexattr,
 __NR_fchownat,
 __NR_fchmodat,
 #endif
+#ifdef __NR_fchmodat2
+__NR_fchmodat2,
+#endif
 #ifdef __NR_chown32
 __NR_chown32,
 __NR_fchown32,

base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.49.0

