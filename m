Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20D4FD296
	for <audit@vger.kernel.org>; Mon, 28 Sep 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633453; cv=none; b=qzyTqjXXUuuWkuTz630x/0TiXED9Yg7bg1nkGc46SPHn2QsH87QIF74FbcMkv0lzTV/HTNLkDQReOZ4CL+uqS56KkT1NJLhnnY19SAiP4sdjEMT8spw+h9U6v0eTB/B0jbKJiUQYhhu0ii/g4YTJ6RjuCl66/4Gxo0XClh7stiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633453; c=relaxed/simple;
	bh=QooAY1siAwsN15o9+GREbxzZjlBJ/O4cq663yU3H/5k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UNbJFtizpFyjzmPgIy/sGFClRGBObzGyRa7wFEU2o1Bv4104FdO9kaTEV4Stqt2X8ehYTYyM1zpqx43vzJ8eGZDtdKUJG2X77isgrD7ncBLqhWXuVHfoSX4q8MpWUqJfQCVj+s50xRZPAm2II04b7p2vT4GC/N/tvYt9qiVqWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Czhyit0+; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Czhyit0+"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5ce9914dso248843085a.0
        for <audit@vger.kernel.org>; Mon, 28 Sep 2026 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790633451; x=1791238251; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vQV5QojyPdN6nr2Psqr9eEvXu44kh+eEAXlGSd+RVI=;
        b=Czhyit0+2VNxhrbeyv3eDaR8bqUfCcS9/92bpzT4wGZLX/DsfF2sf44yT2eTSK8wFi
         5GcrM7GuKz+M1WF5nZ6qf5udC4ga3hIiGJoOn9LnAMBPAAqc01ZxDKXjECa6ew3ImgfK
         C2x/OFoGl2/4KisO7Nl/MGLlKm2eJLaYAUyiMXEhsgB5nh4g6mUoxUPvnEK00kaAaGpg
         O37VGRcLw4IwWKFdgWdBH9ycTXFrRg5THaVPSZ3jzo5E5JHA8kGglczuaM1aDitDxGtB
         q5Glrv4LTjEVTA4CCBLY7ySA3nGI7H/KrCO0SrhA4NZWRK5EW3zjmyk5TZD6Sq8Kqz6R
         My0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633451; x=1791238251;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vQV5QojyPdN6nr2Psqr9eEvXu44kh+eEAXlGSd+RVI=;
        b=gSmArt2b6y0ZWMAj1M/3WbcFoIxP0OL7h4HcpUkVR2dAf8c/edgnE2sfN/n3bHzcK4
         ueZtd9y9z23134lqQRPR1awah0Wp0LxA3jx/d4tt8vvF0S3M0kTL7gScgPsjhdkM/t7v
         X7Tso91VDzg8N3k8K+H/NDaJY5kH7AYdj2uy/9ts0iTlgkzoY2VZAKSPD81nH6e2Jmuu
         pPuIliCIvj9yiCpe4KJ/o1BOVoYREfjMlczygZtNMBPkhSZq5/2tcl+z/Dm2bj+opDRR
         mqeQU1Q6tiNgAv1ehbZJncGmdj2mmMX20XbzKl7IS1rF6cVKqOuvzk/UOiFEtUJTdSFX
         gJWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWXh93gcq/K/qBIcDNfz/QSP00kW6/bh+i90lBNtu2jP3G56+Y+2q3Ves7XfYZ8TYY1fReKw==@vger.kernel.org
X-Gm-Message-State: AFuF++m/aOqGVQXoAyR8WJRDvd8CfSqjCyLEzGx1ECDwUixZAOYNh7Ah
	JbPZ8WI2d2AN/IvMGOdE0GN3cUZlK17Qe2R7srYBZfh83tc6hqjvXJPquaucYfC9Aw==
X-Gm-Gg: AYBFou1y70CS92yvln5V3ve59uKIpSSjFqp3eKciA5OCH6mN6oofm7+7Hs41ID26oqq
	r1nn+0pk4jZvKvJx3P8GvLShrfaPxolankxZtq7ZJ9yRnajNPEp1/uobHc0f3umiVlKF2Ujai6u
	lj0lNV9tnCZfGkwfEv12zEMPFu2c5pcUvbmtgDZzFYlhM0I5+domTa6bRm/L0zlqZZkVJUy8Ssl
	2KtqWrgbaAxQpdGfULwzfy5FPlfnymxI0l4+1FnsMyo8hH256EVSgdIEOfApOtWblDj3Zn+TW55
	p1yfPNohaMn/jskNC0XhuZCRN9h07mVlcSzXq1G1BaamOHPF1gYbrAIXfqTAmwKZ1cAFVQptd1y
	Sb/xTECSr4O9jzgXjZk4ZdcCYH+AnCh4z0L4hmuV6uZqGiMUZDtVZFPPzIDDWwrs1u6kQrjzRNJ
	FprsdeGnO1p4/ramk96/aI8nQuTWaqNQaLyMhZ7U6da6DzzMp0dec3C0y4jJvS/rzRYy4WalM3P
	YYf2+Tw72tHr7GGWBMZrOZ09q7T9N5MSlmcfxLkmCICIalnq+uhBBVwKsdCgSoZ/JdOl1fhvgs=
X-Received: by 2002:a05:620a:880a:b0:939:b55a:3c7 with SMTP id af79cd13be357-93c43ca4152mr2227270285a.41.1790633450907;
        Mon, 28 Sep 2026 15:10:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91786d7d759sm3653006d6.42.2026.09.28.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:10:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:10:48 -0400
Message-ID: <8e27baf768abfacaad921326afc85e2d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260928_1559/pstg-lib:20260927_2151/pstg-pwork:20260928_1559
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, audit@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH RFC 1/4] audit: separate file and process capability  storage
References: <20260917143948.106603-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260917143948.106603-1-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> File capabilities need permitted and inheritable sets, an effective flag,
> and a root UID. Process capabilities need four full capability sets but
> neither a file effective flag nor a root UID. Give file capabilities their
> own type instead of storing both representations in audit_cap_data.
> 
> This reduces each preallocated audit_names entry by 16 bytes on the tested
> 64-bit configurations, saving 80 bytes per audit context. The BPRM
> capability auxiliary object also shrinks from 144 to 112 bytes. Retain all
> logged fields, including file root IDs and process ambient capabilities;
> record formats and collection behavior are unchanged.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/audit.h   | 15 +++++++++------
>  kernel/auditsc.c |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)

Nice :)

Merged into audit/dev, thanks!

--
paul-moore.com
