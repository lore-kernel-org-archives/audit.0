Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD51E47A5;
	Thu, 20 Mar 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483954; cv=none; b=RAa9rHlStrb6wexfPiH1U+4xmA6a2DRgbIg7mL0z0NqHTXi6BBoU8t2DA9TjBWWcyVToqZ1dUdnyBnaqGf49qJKPclmBU9qm5UWq16QSqzPJLZ0psxBSN3PPJ24ig4sF+ZK07c8RGFvPS6lBZknKzCDrptl35UT7KDbr4XtHBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483954; c=relaxed/simple;
	bh=hZXFgGRtdjy9qRCbIgqxQapdBt46RdzmCE3ncomov24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJRmf3/vIXIAwS1wzxidlPQsKehhkHH6VWLGRMezy2m4CxaBU/euBRepoy31fzCYq68driJ1lVcgB51uyn5LaP54Fm41k3KylUfHxoR3aTwvY0PLjLp9FXtw8golD3cWgFtty25exN3UGnhJPv3km8ZExDw8pN2ZkgUEtB8Wx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+vKybcA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+vKybcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742483953; x=1774019953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hZXFgGRtdjy9qRCbIgqxQapdBt46RdzmCE3ncomov24=;
  b=S+vKybcAjt65q/ZMzfk6qKHDTC+ifI+ejlip9NE/3xozrpm3lylzmGOw
   gQDa40AlXamagmTyoC2PGwbfuj6GhnXLCnXVzwapRa6UfGSRH60CNyVR6
   IbjcdSNXIAGR+/4ok1VW0GYA/taHL1CYvp63PjsTPpsXWyDkVK8PPkAMW
   QLChaJMq55ek7sG/ztqXWWFrLctk6835PDgBws6ySW3UHjTPMDuamPqHf
   AX82NtWOATciKTdscWUdA9bt9ef+7vN2kpGboC3h4yQpYt/bdhRkMQvhz
   Af3G6Bg7RliTVxzMvm771nAAe3Ym8/kPkhaF90ugAr8qkKBChdns8GBom
   Q==;
X-CSE-ConnectionGUID: 0vOE8R2OQqWth0dx/GIknQ==
X-CSE-MsgGUID: 0At9pjUgQZ6XNwhyFI6IIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43911981"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43911981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:19:12 -0700
X-CSE-ConnectionGUID: GzhO3JqXQyOh/wDlLxPQ/A==
X-CSE-MsgGUID: kPFnzCM1R56UsNfuEBPiQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123132133"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:19:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvHfo-00000004Fz8-0EtK;
	Thu, 20 Mar 2025 17:19:08 +0200
Date: Thu, 20 Mar 2025 17:19:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v2 1/1] audit: Mark audit_log_vformat() with __printf()
 attribute
Message-ID: <Z9wx60LEpqN4BF5W@smile.fi.intel.com>
References: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313085343.241623-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 10:52:39AM +0200, Andy Shevchenko wrote:
> audit_log_vformat() is using printf() type of format, and GCC compiler
> (Debian 14.2.0-17) is not happy about this:
> 
> kernel/audit.c:1978:9: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> kernel/audit.c:1987:17: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
> by adding __printf() attribute.

Any comments on this? Can it be applied?

-- 
With Best Regards,
Andy Shevchenko


