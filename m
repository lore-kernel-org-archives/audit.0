Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EF26137F;
	Thu, 13 Mar 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856030; cv=none; b=H0nSl28WRu8YDk6u0+/LLcJ/MIexTWnEROLL/HfFqx+dsouB/uwT5Z6j7wZqpuFyKNyAg8MFiJMpO2TpRpQbXar1ZufK3mcAt16BJRAB2von881Mp0USEd6cON01n0a97UdVjkQ0qVdztmP4j9JMhORtoBxPlkYa6ix8LgTjN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856030; c=relaxed/simple;
	bh=DGDOMC0GYV/bil6LMIxE+mGIXtVxjPcXlE2MjWiHu90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMy5s9s3RmQYliyOtJhFw1j2uVSsJiFi2zATuB1fsPw300+azYOYeEkYV9Cp+37DONGesSTWHXg7g8OHenGE/nikptsrjP9fWXHVMAsklMAyFvZHY3uQpNF9bQ2NTSJH89kGYSCEbmUy+zL+YAjk4XV54LJ2GhiZRC1BVWWl17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIgV65KG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIgV65KG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856029; x=1773392029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DGDOMC0GYV/bil6LMIxE+mGIXtVxjPcXlE2MjWiHu90=;
  b=kIgV65KGQTflCCByfcbCJ/dfmtXfnizMG7yf58LyXpOYiIB1nF1e/pT/
   nlCoDwxwUbqRopyB6hNBDJiOcJtBhNrCBLn+LlyntaE1L7ci2sjal/y8I
   kWTAZpLkD9NDtycU6WbVjbG/C+tEHDgYcbZ+pD2CQxYWlQJ1ycaeIm3qN
   lta6MhPv2jBAFBUvFtuuyuRIV2TXzAxMVPvdXsE36P4F/eVos+ZVco2X/
   ZNiY9Sfp1yak8eDxH+d7/YGInJpVVNsAjpzVnKjt3z4BYLic1uvkXi71M
   W0J+UqM3JnitqeicY8kqHZVSvQjFh1u2ezGL8Ql26tNbz0Rbsq+X78TlC
   Q==;
X-CSE-ConnectionGUID: 0B2Pt4jqR8ifzwAi9FeWRw==
X-CSE-MsgGUID: xLZG71HhQWKRcj8ejMGC1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42214077"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42214077"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:53:48 -0700
X-CSE-ConnectionGUID: VDe/2QC7Ssi6NJarAyXqZQ==
X-CSE-MsgGUID: BCOFWHxJSveIQzI8eeT0Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121389107"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 13 Mar 2025 01:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7218A1FC; Thu, 13 Mar 2025 10:53:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] audit: Mark audit_log_vformat() with __printf() attribute
Date: Thu, 13 Mar 2025 10:52:39 +0200
Message-ID: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

audit_log_vformat() is using printf() type of format, and GCC compiler
(Debian 14.2.0-17) is not happy about this:

kernel/audit.c:1978:9: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/audit.c:1987:17: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: added necessary technical information to the commit message (Paul)

 kernel/audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5f5bf85bcc90..f365e1bbeac6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1956,8 +1956,8 @@ static inline int audit_expand(struct audit_buffer *ab, int extra)
  * will be called a second time.  Currently, we assume that a printk
  * can't format message larger than 1024 bytes, so we don't either.
  */
-static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
-			      va_list args)
+static __printf(2, 0)
+void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 {
 	int len, avail;
 	struct sk_buff *skb;
-- 
2.47.2

