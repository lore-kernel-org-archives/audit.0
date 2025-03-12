Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDEA31;
	Wed, 12 Mar 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809742; cv=none; b=awMXepvBK4E7JZic1YacRfJMcjOhGthm5b2GtZzdHWcgHZG/HLisj7P6+mf5gW8kL6RN+8I7cbKfDkvp3Q/TyQHPwMn3nk7/tE3kvioMxo+Iq4NFbCIS8Drc9snQPw9O21jiL5+cyGFBH4c+UKaE6UXQaV7TOaWf8sEi0D2w/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809742; c=relaxed/simple;
	bh=ItDqOk77PLUXv7BhsELB+snkm/+TLYev97kd8GODnxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOTt6cenoYkQvz/qmz8lUCNBddmM3YL2vwAXa7+jGiU/PJSHf1RpRK7/33ffyFAx6BQ8vPRYlVQZxTEhxFcPQZuP4Qk+uUOWSz/8UhjR8Lw045b+TtHX3OrOIOWpq+wx4i0FcExBMxY0DAjuq8NhUsgdNkpyono1sdyzRbl2Zuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtWVupIO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtWVupIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741809741; x=1773345741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ItDqOk77PLUXv7BhsELB+snkm/+TLYev97kd8GODnxQ=;
  b=QtWVupIO3gZxJl1CiW3eZnYQox92CfcdNasdGFDfUald/8/XjP++hYio
   tSOtt2Rftgh5bZ9GIaJuIiCWuH7RnHc535kGE51/HVNWJeUXN8jck6UNV
   j6k5qK+AwaolBux/3lAzwqb4qaRvaEuk5/IX3+JQj7IPSctqXPFpQzskN
   i7olZeZaMzb3QP8ob5I6zVytosZ9OegDxMplq5B/z3cngboqFMrLphgP2
   D6rEIyZShl9Yao39Gz5imTNToq6C8MA3IEy7gL1EuQAVJIkBPSgwCtVU4
   XGrl2M+DTtAibu7EZjgU4hupxy1UnmH2DL/edpAk5sjTC005fMeINMXVU
   w==;
X-CSE-ConnectionGUID: 9dmb2YJXSqmWyUTUfCcw8w==
X-CSE-MsgGUID: 9MD3ihOfQlGJfArPrYu0qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43089980"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43089980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:02:20 -0700
X-CSE-ConnectionGUID: 1l8MbU5fRdeh1Jb0s6A4uw==
X-CSE-MsgGUID: VgvdJ77ITHSXUF1KB8SBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125808766"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 13:02:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7C10A1F2; Wed, 12 Mar 2025 22:02:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] audit: Mark audit_log_vformat() with __printf() attribute
Date: Wed, 12 Mar 2025 22:02:16 +0200
Message-ID: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

audit_log_vformat() is using printf() type of format, and compiler
is not happy about this:

kernel/audit.c:1978:9: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/audit.c:1987:17: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

