Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36081991DF;
	Mon, 30 Sep 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695319; cv=none; b=UCHiuAWwCR/rmALUNYNmOMmrLN21NjdTA740M2xGdEy4x2EF1RPUkqoP0mKr2KBji09y/l72ySTkijD25hNiQGBOwjZQQTW/eerZ9i80ckgE3NEFaoxK3WOYoKEc7BdT4zziPtILS1ZDBhdeey07t06qC18ABxDFY4D27hM9E7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695319; c=relaxed/simple;
	bh=32q/o2EUFA3kk2dbZ1cTMlvN1W8FoiLvPGRQaAXwDoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=it0ZGAxNec0izycy/9XL2E60ccOn4o3nMREBd19hRmikkHFV26wBiEsVxwKPkFmqokc4nS+LLyzc6wn6OBt6+Jqp10ZxfTGFSIRT3ghzvu1agZmXidCA9halouJnrhXJNAoGvYrI+gQWfbFX6NUcXLMBBU+/6Z+nLk+lCVd2QA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=j5APBtir; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="j5APBtir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwY73jovIycI8YIH5O4i/nKlVbHmx1WK6SnTLQ4cHEc=;
  b=j5APBtirCEuBhXc4HfSqNIlPNTQzfPFntH4kXuDUPkGCBHDfVPGP2VX0
   Sz9/y4ltd+41bAMwQ7QnQvyvJOZNxEIN6CVSshfuROGoCwPEU3C1OmjAP
   GdE1G00ACnJtwbHDQpmXA8bBC0EMOqrG+Z9BT/6xkTu80Jc9n1pkbT1jW
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956912"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Paul Moore <paul@paul-moore.com>
Cc: kernel-janitors@vger.kernel.org,
	Eric Paris <eparis@redhat.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/35] audit: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:16 +0200
Message-Id: <20240930112121.95324-31-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/audit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 1edaa4846a47..53e3bddcc327 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2102,8 +2102,8 @@ bool audit_string_contains_control(const char *string, size_t len)
 /**
  * audit_log_n_untrustedstring - log a string that may contain random characters
  * @ab: audit_buffer
- * @len: length of string (not including trailing null)
  * @string: string to be logged
+ * @len: length of string (not including trailing null)
  *
  * This code will escape a string that is passed to it if the string
  * contains a control character, unprintable character, double quote mark,

