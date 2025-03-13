Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59660262D22;
	Thu, 13 Mar 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855856; cv=none; b=oBpyxGVjbN8xTGY1R63kt9fHLmCm/qoHwWEAAq62q3b06dhjs8tab7natU6YQMq+IYBa4JLUtxa13aimkTWioEdCQ7NPe58lFQ3Lk1gWaRxX9Se5Wno9rfDo2dVx5rCDZettleb9kRmJ4SoMXLcRilykd+WKwT2l+C+nVKaDFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855856; c=relaxed/simple;
	bh=3bZY8dzTemq47JF2feV0u6lsWsSXG/UGcVjGTgCxZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOntyA41DAQMNuKL9oU+RdNEe2D8bSjbLrLgJ12k9OEmvHsZaYyui/9bvdRdP99F92TPK5UywZcnKoE4/7FmrNmdRqmaR3u02LJ3ipPDvH9HkBmjq2ITinyfMnQv/42SS8nODkNTOrKT07QsKJUWn1V8iFtRwCpp1PJ/iNQwqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZdvj38U; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZdvj38U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741855855; x=1773391855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3bZY8dzTemq47JF2feV0u6lsWsSXG/UGcVjGTgCxZxw=;
  b=fZdvj38UiBL/fezTYnNra9tmL7nAX7654FDk5gYQqNCQ/Y16gMUTqh5Q
   saeIoNSGNJSR21plL+lgCQAxtHvvJcIjRDBYp3XbRWGIK9bzHYLADG688
   zWiGC2IX+9q6hpr4U0ybBcZVIR/2h3V4zZNNiR8G5M0TUAzXDdnORxp3w
   ESmE+Dhn6Ln2KQQznSaRyMLn0pvoCzaPpqeMN5Q/7HpG3KDkCGrxdotEI
   Yy4BptR9OpVED6Cu6+S5hQ7aqtbtTY47SaPvpeltugdD6vRoMjTap1+HY
   tI5jNAF/sRvcdL2z5pZTYTN+lSOa1c0rN81BC9mV1hOr3atFpZF/pweZY
   g==;
X-CSE-ConnectionGUID: xQMi+n/RRsmbV/cQ+GZi1g==
X-CSE-MsgGUID: OYgIMuGWTh+MpQ8Ps29CFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42213914"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42213914"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:50:54 -0700
X-CSE-ConnectionGUID: haSQ1Kz9QSSRm0ia77PnGg==
X-CSE-MsgGUID: cU62JTwkScmr13W/KeB/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121590465"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:50:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseHB-000000027bn-3yAw;
	Thu, 13 Mar 2025 10:50:49 +0200
Date: Thu, 13 Mar 2025 10:50:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v1 1/1] audit: Mark audit_log_vformat() with __printf()
 attribute
Message-ID: <Z9KcaWFLe3n4xCmA@smile.fi.intel.com>
References: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
 <CAHC9VhRHZL+QTsfK2Sg5+rw7RSxUoaF=YTwGW9Oia5xnvqAL1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRHZL+QTsfK2Sg5+rw7RSxUoaF=YTwGW9Oia5xnvqAL1w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 04:16:36PM -0400, Paul Moore wrote:
> On Wed, Mar 12, 2025 at 4:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > audit_log_vformat() is using printf() type of format, and compiler
> > is not happy about this:
> >
> > kernel/audit.c:1978:9: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > kernel/audit.c:1987:17: error: function ‘audit_log_vformat’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >
> > Fix the compilation errors by adding __printf() attribute.

> It would be good to list the compiler version/flags that triggers this
> error in the patch description

CONFIG_WERROR=y (this is default), gcc (Debian 14.2.0-17) 14.2.0, `make W=1`.

> as I've compiled the audit code quite a bit and haven't seen these errors :)

Good for you, I have 100% reproducibility of this :-)

I'll do a v2 today.

-- 
With Best Regards,
Andy Shevchenko


