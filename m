Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1E26E70E
	for <audit@vger.kernel.org>; Thu, 28 May 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981572; cv=pass; b=tBeeKqElFQMO9eqQyIwN/c5m5GM9jYMFFmCTW5k9kcDauuEvxBC1YFdsn3f33HSwkGOk6WlSET/fOtTk4bGvfvdpKsfbZuiwNj8d3bWZdGYdUf+IuQZF59fxs57ttOPS25aZKOhlhnWdi5SQUxvZbX0W/ksMJt1G3P/5jAXuW3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981572; c=relaxed/simple;
	bh=6S9TkIeh9d7MOG/y/RYKoCP7qm0FvkE2uz6UMNW6Wl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE/H3zLpwhEnZHNiq3lsmd7/CPyiogMj6eRuGoxdWp1hv0jB4jaKgQZU9qpWpbfIrqMYT/RFZ78yHck9Ar9IoGjLPT012VlKocLp9pftoY2qJ1a+88N3WaZDE6vqZKyMgApAWUnEAiqwTv6CJRZuOOuKAX9YcTGGyp1V0SHubqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G1aVkmM9; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G1aVkmM9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc78af7371so10880767b3.1
        for <audit@vger.kernel.org>; Thu, 28 May 2026 08:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779981571; cv=none;
        d=google.com; s=arc-20240605;
        b=O9Mp2ShAYH+nx/hPPUZpvRUOuRTkKPPDLV9nxLwY8nHfeW4GWupMKotJ2QPETJzCxZ
         JqZpUWd5P8fBZIt3t1nOyi48UOHypyJooJTPnomCcjulbBjn+t5K7AnD8NK23dHXyEhd
         +ax7tAN4VWdogMzmY2JiFS0aqpzoHpzxgmwJGTU40Jw0RQq/LBaOHQImRtIaTAXn6qa7
         2qDc0Log/WCO7uCbk1oVGCSp91YbS68iyZgGMLlootDBVMd+BpIdpTxKnCIsxPpvxQcT
         m0bcBvL8QEKnPC+ZGCE+B0Gwz1WVRf7wexDlktk7/obFy2FnR8HQDXytNk4UcGlUJzYX
         er3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNBevCqfk00J2rt3EB2DabDjtH6s2ImxOWmElvURxdM=;
        fh=kgXISa93y0AL5GO00UpurB/T4lUeJLn5mudh/KSOAms=;
        b=Hg8Zb3HxSeKCwH+TdEbtlmdESnZRxf/f48wawklxaDACd0ggmGC/Ph6uNX43wkGdOE
         71lwE4YGFwoiylwWYpqbhI7BDukHrWIhwtyqy4OIaTfUMUhE81citi85F6Tr9LpULQUe
         6P3iRAFNuIVY0oFdgVxxFmWBtnNkWZqRmD34c/Bx2s73ASZskl/3uae4zE/W04xYrv+4
         Gkudiz/1VB9F+c2veG3tUEZ0mPJWkV/LxRH2PJg7wll+xqnI63urFfPlTgmXx0LAUvne
         QVbKKacrXGroTJr5DCZ+Mrndd8LBT7A1XY+nWEXFl1aFbWU2avafrUQ20Mse8JWftvrM
         s64A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779981571; x=1780586371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNBevCqfk00J2rt3EB2DabDjtH6s2ImxOWmElvURxdM=;
        b=G1aVkmM9Kp5T52Pdbhqnz/OGNML0X8APdc4gzhLPwIkHEthCd+9ah2RyM1jmLIWRLz
         T+F1LTkfu+SVdOu3EwqLE7l9cbBzKBBPpIYqOsoU3e9yXH9qx/VdInN/0sYYUXsTPW2/
         uL1oRJ6Aj3GGaagLJWvBwLvD1wvsk2xxB61eQi1bkswtb107VIX35OS0gSbnH2/XvFBY
         10WOvkH9gvJWOhOpUP0/JBtImHVOcSJvgX/5qKP+262LjO9VjQaDT/RKAC0sy2ETOZkw
         PzOUBx7ErndnUF8ULZrebXHISWfJcUyXoQMlobzjWilC/0te8xY/mCtoUvIenhP3xctL
         nmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981571; x=1780586371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNBevCqfk00J2rt3EB2DabDjtH6s2ImxOWmElvURxdM=;
        b=HDa3rdWmbFBdzPdEVRwAZ5oTTz119LKeKeZ7jY7xDz7GoKGgXk74thxvMDMYy/t5Ir
         OWl8CdL0WvFCbicoxiSnHMsjbGMduJi3GOsYbteZfU9Q0EIydqT8/8zuoXiDZbfmifuc
         YK+/8GAIIH/mmf5GDFETS34f6KRz3GNHAoBvczunDmQ2BIsmM2n7W7nUjMVVfHmfEXnO
         27TA9saX3IF1VnrUZNbrAtrsUEGkXwngVUs2qqM+7iOSWFExxs1PE7K1EGN+E5hJqErY
         TcV5SSlFPTfSQro4R+2OiUH1nhpBj5K3r5Sn2itAtIVyMLd5hp6ugv1BP/18z/wR9SrA
         xh2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8H/uhVYQg1IFZMGOwh6/rHgTyWXorkYGaReWUQR30+frhzO6k8/fRCalLVSo4CeO0fZdZUJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsVnKYfcXGP7RP8kCcR5t02gWkzDvQVm81jCScxu8lRFIRgcJ
	L0L6ZiMfRIi5KOouqa/EEUzvByfDPFxdzSV7K9Of4gd6TUT+e3BgFiyJDp2FirdCXTKFxQ4gdg2
	eOVnfDboW1NEj6qxsrMRjeBzb4YpQOQxt4TfjLxgJcRXsvpSoRAFpzQ==
X-Gm-Gg: Acq92OFam0dcm5WLf3JZtr1p3e+AscoPavHxCh/GyYhACg5jNAtyfWIHeJKjjhBf2b+
	VPuqas8FKZzHwnKUqRtyc8f5edZuuubMkd7F6AZf7jYS7wQ97jd7isEvPBjpPRsbONQJXxEqglZ
	6XfXX/Cgc52pLpXlJ4+Am3613aAnl6vBQ4MQ1RD4OwYwHQ/DAwXtkNwNSWKeGI+ID2pWE/W48xP
	Hmspc9AlmELxuUSGGlJTxzUQDzl4Jy8QcZn2YUUC+8pjFgfcCygGpUJ7g/WLSaIsQxDWAZj4fg9
	ukr3ab++YTxaKr5B8g==
X-Received: by 2002:a17:903:2bcc:b0:2b2:5099:2f3e with SMTP id
 d9443c01a7336-2beb06ea859mr302897195ad.4.1779981158837; Thu, 28 May 2026
 08:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202605281316.GwqEa9Tn-lkp@intel.com>
In-Reply-To: <202605281316.GwqEa9Tn-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 May 2026 11:12:26 -0400
X-Gm-Features: AVHnY4KGkw7s8GFEZnhSp-WLxdURT-RSXphDvHJcUZTiyxeBb39-HOM0H2amaTc
Message-ID: <CAHC9VhQkE9cNxakvHSn8wgguDTehYHUpF7ujc+tzUbT1fqgmzQ@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION e7d700e14934e68f86338c5610cf2ae76798b663
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, audit@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git master
> branch HEAD: e7d700e14934e68f86338c5610cf2ae76798b663  Add linux-next spe=
cific files for 20260527
>
> Error/Warning (recently discovered and may have been fixed):
>
>     https://lore.kernel.org/oe-kbuild-all/202605280441.YSawqHBc-lkp@intel=
.com
>     https://lore.kernel.org/oe-kbuild-all/202605280456.3Hhpgxl0-lkp@intel=
.com
>
>     kernel/auditfilter.c:592:15: error: incompatible pointer types assign=
ing to 'struct audit_fsnotify_mark *' from 'int (struct task_struct *)' [-W=
incompatible-pointer-types]
>     kernel/auditfilter.c:592:17: error: use of undeclared identifier 'aud=
it_alloc_mark'; did you mean 'audit_alloc'?
>     kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (fi=
rst use in this function); did you mean 'audit_alloc'?
>     kernel/auditfilter.c:592:60: error: too many arguments provided to fu=
nction-like macro invocation
>     kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4=
 arguments, but takes just 3
>     kernel/auditfilter.c:879:10: error: use of undeclared identifier 'aud=
it_dupe_exe'; did you mean 'audit_dupe_rule'?
>     kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (firs=
t use in this function); did you mean 'audit_dupe_rule'?
>     kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 a=
rguments, but takes just 2
>     kernel/auditfilter.c:879:8: error: incompatible pointer to integer co=
nversion assigning to 'int' from 'struct audit_entry *(struct audit_krule *=
, struct audit_watch_ctx *)' [-Wint-conversion]

Thanks.  This should already be fixed in the audit tree, if you
continue to see errors please let me know.

--=20
paul-moore.com
