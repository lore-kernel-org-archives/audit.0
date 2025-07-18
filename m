Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB921D3F4
	for <audit@vger.kernel.org>; Fri, 18 Jul 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875585; cv=none; b=dcrUbiU8HQcuXw97IIoSp6iFuUEDOioh91ZvZ13MFUzkYupK8EMajxsD9fdt4akY72QED6F8YVCSwbOm/sHWkycuJyrK5xtD9nN/PS42YWpAy3ebkhItSelIkUpFhkm9txa1w5M6Pr6I2qq4Fmk2OWa2jBjVnlNMrU/FXutnkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875585; c=relaxed/simple;
	bh=m/GVkH7kFga5E6DvDF13ZQV8++8dXVqa9LQzwKfgKw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWemEWZ4MaVnXbS8Rgms2+/Hw2OwFMn9p+hckqAhhD696bunYYxF95J9DpgE8J5VydqxF7q2rQyMZKY0bJx1ikcYr0GSvaJ0q7M9dPnE1WGVIlhO/L+qYpp6dJk8V6o4ZkTBcFpisAp8EERQvZ4ljZ7nXdZ8KXJtufBO1Z/pZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q5B6q4uu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q5B6q4uu"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so2208484276.3
        for <audit@vger.kernel.org>; Fri, 18 Jul 2025 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752875582; x=1753480382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=Q5B6q4uudbJ1JW9aniixTUzBJSecTybb7pbWTUnzgrt9vcKXpzTtXu7aAOvYvcaVC2
         5m8jY65KSVjtF7tBQckcFl1qQ9SmPMw73eY4rUN0yOqUQj1DQbX3+LipS3VpN/pwmRxH
         yfVT43TP79sWpavdCtosj9F4Ij6Q5nlZbhpk+H19mKPnyRShjkd1fXn521eKh5iuoyD0
         skxSibpuLhWGEIUccMiwS8XJAf8YCsWOz1hpVcqml6xZjNo5jHjDiUgLDtdbkJYxMCz9
         ZftlZOwFqGA8qfadd6QYXrPgcVF6mslscgHlG5sJNPsoV0f20A0ewpogj9ATkF3bZG/s
         F3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875582; x=1753480382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=mOzyblaTPFEcsfMFsW/dabvR0leN6951oBEIh2CEB3w7OcPnt9pc4qr1irTauu/VIt
         sayTMPE/WITJmTID3clFQ2KXjt4FB94iYv9JPAAwJNjCHl2R0NYV6phPgnZ0fzc68xcz
         ksnIDtoDag3bErtggnL+kqoa9I/F5nRmRxqC3CjUL2MUlq0Mb4okCUFHac7TDNRA8zlp
         Xu1+Bj+ed4qPwQoqEalYRgRLQPOvQtVro9mzCK61dcMSNJuGs6WLJcTLySEEvSpHlWrd
         BELaL+Jv1t4xHMDHL1xs+nrbh1b4UkORpmKw2Dko4HTGIRsrYRGTiImCxZI64X+xPYKW
         481A==
X-Forwarded-Encrypted: i=1; AJvYcCU+V0kwQjr/169Os65sw67kUZqZQnFNc6gBDzh/z3LP8tcpYdmgxO3mdsehBJjAldazdnucPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT24YG5tlWCp3mMAzol24XRZieF7LdRR5kLV0cfZIjmx2h2KZn
	H/v87lITrlag4HTSUI9cTkGEDG0QVLJmNqG/9TuijiVOgOELATwds6wjL15cvhBv9XrfderaDNG
	k6K5Qd4Se5dgMsRYloFJD3el2cWlcqT5yoyRza5AD
X-Gm-Gg: ASbGnctRvYcrJ91RbwhQietlPpnv1RdUdoPZju4pjFyEVQqn5X/mxq3YJE7Xhg7l1hC
	oZtZv3yYAnfBdtKsN15UbgKojPuvg0sgK9tRoeTRo+xDoEh+vDI8rLwkNwSpfl148GOHwk3u01J
	rIDI3I4sZ5VZInJQsLo8uVb41JUmOmP6m7D++O+0Mizqb2URG2NABKPm+96ExhN+S3Wrf/wNLIN
	GVW5P0=
X-Google-Smtp-Source: AGHT+IFf5bnxZbREvMvlsbfizsYWDzhgcbPnRrN1Pv/fcSWvOqeCSaHZjLEK4HTUY1AY4fj8c+1pm2RjoePlp3shqXo=
X-Received: by 2002:a05:6902:e08:b0:e8c:93d4:b0ae with SMTP id
 3f1490d57ef6-e8c93d4b42amr10116844276.21.1752875581835; Fri, 18 Jul 2025
 14:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718203734.347091-2-thorsten.blum@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 18 Jul 2025 17:52:50 -0400
X-Gm-Features: Ac12FXzCPEr9FkZrYDFFpVvOY_IL3QCEVZrKQZHLJkmmAUMqwWFbcM7dIijU3Ck
Message-ID: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/audit_tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks fine to me, but as we are at -rc6 I'm going to hold off on
merging this until after the upcoming merge window.

--=20
paul-moore.com
