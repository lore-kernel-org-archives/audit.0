Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3425C706
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100916; cv=none; b=j1adm1q/66efEsFMYDEuDGG+ztOD0PoTl6Qcafe4bHJkqDlsihfkOcJsCwAjMQX5Gb1sdSBjFTgdCY+Qe7dF72vfqzR5OwFuBB7s41808l7RpT7SCwD8PrlH+5ECDplKcm3nQuwUyfSL8REDigtDdYMoA9pgtk7OwsaydVIWqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100916; c=relaxed/simple;
	bh=T+3y8BiFHtIyRfRfp836FQFjDcVfPiRNAwpfTrxucN8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=psEThvSMwyrQLX09SyCcY6JYARBj17+0y9N0zPQ+rsEAlj25c8mJatAR5ucYQL4XXr+DhSp7lx2uDgExveheHtFcZG1kVNxfHNA2Nx0uU8ksr7rgs5sjvbOCsc8U1ToXiZFy46zvnpOf0Jab0BAlZrmQdEJQeQ75xQy3YFjCA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R4Cf0b7L; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R4Cf0b7L"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e86faa158fso4797385a.1
        for <audit@vger.kernel.org>; Wed, 13 Aug 2025 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755100912; x=1755705712; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw8+oeEJ7c8LZ72iCnSilzwcvbRhY3C+6FOqOUr1dJ0=;
        b=R4Cf0b7LUjcvTmE5TKeqIRGzsdfxw75OVNwJ3N9bLDsQFGK/K6syj3y7QysRrGN7ri
         1vkDMNnTQdo0DqZmnSjV/pe7bK+lN24rOyHfT7S+zoO9tjIpGPah30dg94tUsrjRf401
         3SnpBZaj/qE+R2PVGmQJOekpsZJFkM+Y4FHuJYwUN3ouSE87Q1j1o/r0CCU2PpnUHhv1
         fQlOxuzf1QgQ/cUuCGWX0+ec0lcDqJCC+wtR0y4S3SFukAPkrmumLnEhZRLOM8z0VKYe
         baRDEAHzrA5svAJP5F669mvPmmo/c/bE4RqVyUVxnuRzO+0F2C7sN9/CJOaT7kavzaqK
         Sghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100912; x=1755705712;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dw8+oeEJ7c8LZ72iCnSilzwcvbRhY3C+6FOqOUr1dJ0=;
        b=LlZOb+W3fRxJFCPXXHvpS4ygz9KjXxsk4Rh5YnQyiUY58H6XV1qZ4eARb3g83/Epoe
         8KH+y0uKKvYuK1cPxgqX2qvU7XfthB3Urspt8KhuNtlc+D6xTgZrr/rxIS8lyRjGynIl
         isaUBOoMwiQiQgid52l4s6K4ODa7Q52yMMp7sK5WSasVL3fQzE3zF01ECt5Ny05vccwr
         4zlwPNrA1qWBb15PbrQJVr70YCtuL5JsiNcA2eWzfktKsCS31fHUkT/3VsgyGhWjPETr
         OxsAHVezUOWOOwo79uLUjCZFG+MBTEWR3uPV0YcVdEAMPQVKD8J+reZ2RHaSHVwfhruK
         8Vjg==
X-Gm-Message-State: AOJu0YwPmdADydqcUyutqL/ckQDaUWSXTdbw4fBBtcv4yOPlY3QzCPVQ
	eVyKohGeIoGKI2A2pK2H18BUfX05kz/ojOPSUbZe6HU3s/OWsNRsraEGRIPGbPNy4A==
X-Gm-Gg: ASbGnct3MYYZP25yloghbDYBbPTb3oi/9pbGsBnxGtA99hyTQIrHmHsBLTTa1a5X8Eh
	FAuXOSayBqv4p282xlKO2fdInsQ/AjdqvSwfCGC6mIarp2cpd/hJrcXk5o0F9XSg/mWZNJXmjhu
	o1UgPFaRoCd59EiqJSU+sHoR1hhK43qUhT9ti5Y84QKrj6ncxNNeP18+xI5qExtopc4r5wqy2E7
	8ipZE8Io7/GorbD7p4IojloxyhsRSwWzjnU8fP/3p+A4e6llzNw/risapAlU8LTg18uNALSKZWB
	loDBnIOdMaLu9Fm9jIKScSh/ebXqAqrrf3eF0tJr/rRPUTu2pWcJR4oPX+PTbwAl3ej2zVzJKl5
	I8UvJqaMtp8/1roo4eq94pIAUWpD8uAHJXIdbfQDD+GeWR1sZQ8FJOyU3wnI+w0a6IT0=
X-Google-Smtp-Source: AGHT+IEeiU8GDqNtvKXoIwTdREgaManpc5CD9rIVEoJC++gPCoA0os4E3MbFoDyumspUCFni5tDj0Q==
X-Received: by 2002:a05:620a:d8e:b0:7e6:9753:d959 with SMTP id af79cd13be357-7e86fbeb6a8mr14589185a.4.1755100903431;
        Wed, 13 Aug 2025 09:01:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8068ec9cesm1485491585a.55.2025.08.13.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:01:42 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:01:42 -0400
Message-ID: <b7fae70a87b4fe937607e5e3215397bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250812_1310/pstg-lib:20250812_1218/pstg-pwork:20250812_1310
From: Paul Moore <paul@paul-moore.com>
To: Frederick Lawler <fred@cloudflare.com>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH 1/1] audit: make ADUITSYSCALL optional again
References: <20250808194034.3559323-1-fred@cloudflare.com>
In-Reply-To: <20250808194034.3559323-1-fred@cloudflare.com>

On Aug  8, 2025 Frederick Lawler <fred@cloudflare.com> wrote:
> 
> Since the introduction of commit cb74ed278f80 ("audit: always enable
> syscall auditing when supported and audit is enabled"), eBPF
> technologies are being adopted to track syscalls for auditing purposes.
> Those technologies add an additional overhead ontop of AUDITSYSCALL.
> Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
> offers some advantages over eBPF technologies, such as early-init/boot
> integrity logs with. Therefore, make ADUITSYSCALL optional
> again, but keep it default y.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  init/Kconfig | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
 
Generally speaking the less Kconfig knobs the better; it tends to
complicate things and for those that rely on distro kernels, there is
always at least one group that is going to be upset about the Kconfig
knob being set "wrong".  In my ideal world, CONFIG_AUDITSYSCALL wouldn't
exist at all, but sadly not all arches have the necessary support to
do that at the moment, so CONFIG_AUDITSYSCALL remains a necessary evil.

Thank you for the patch, but IMO this is not the direction we want to
go with audit.

--
paul-moore.com
