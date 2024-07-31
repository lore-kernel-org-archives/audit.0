Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED11B581A
	for <audit@vger.kernel.org>; Wed, 31 Jul 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441093; cv=none; b=MnyDAu1e5jBZpXfT2aecQoe84AV1nGKX7HTeSZQp3UVIWwkLV+/N2A9ayRkSBWAavlw531IG4QwIGnMOVuQZuB1LtQuRppXC0ldfQpvHm3I9iiSq3nR0FgZq3UHaw0deN7YVF1pmSVWe72xX5ra/Rz4K/GNaUrCO0J/RYT9i9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441093; c=relaxed/simple;
	bh=qPPJaDa3oltxDrhp3U0v18X4YZrjzYBSJplVnujrCz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO89LrS9VEGJ/SaCXLNozW5cDxM78GqSv6Gmu+2wxRUiaPH1xwQ1FSlL/KDDi8VylBQ49q1MzC1xYXKgY0yqWiZwxCTIqf/EOQzyfkGIrlHbt7ecJRVJDiflMp2oc7Fseo8RSzqvXRDyR1ApNqqtjBoMGi42FRjKett/9ADAxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ryd+0aCl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ryd+0aCl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6510c0c8e29so43767887b3.0
        for <audit@vger.kernel.org>; Wed, 31 Jul 2024 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722441091; x=1723045891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+Y1tBH56NyXCyU3BPl+HWO+PHBBC2ShKFx3B+Ne8TU=;
        b=Ryd+0aClWamE0KM2+5GJ+Yj9xnPL+S8UkaFsjoM6RE6DVkGq17VLNzuMmFtcB9KPxw
         o7zaI0j2BUwznl72VL8x4EWAjf44oK4iR7sI8uE3shcro3yNqJkes18b/0sAVinCUMj9
         PokcwxDDFGV0G4HLY11eQ+bxwvpuyTgwLy3CyIQooVIJ28r6qtdFfzCTqrWds5LThfzK
         9t2ZJnZZDs0Q1Yed2wJlOESzxV8m3b7AFON+DplJeddWgBz5ZUu2HKAJXd4FJDKQ9Yp4
         M4YM0nE/zjgRm1lKVgzkUUMx/xvgfnVjtd2ilPfMyO09081cUZSY+latw0KXYHVO+kJa
         4jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441091; x=1723045891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+Y1tBH56NyXCyU3BPl+HWO+PHBBC2ShKFx3B+Ne8TU=;
        b=TvJe+bYPKDYEFL3VxX4J7zP/7rcnq420mFDiu+FC7WDJDfYrmwhDSutKWlCNDVdqpV
         yIxYGyZh7EBXQk7TqmVyalD03KPKIq5l/ZgrYt5xZd2fwYy+RJ9rGc5cVI9ZccWT0I9r
         T92RfKe3qlQGNxsxsB49l1Tb596c4G+QvzIfUbJY+HQJyWmI7e3pcDZDO6DN9y0UJpQD
         T+PlaGa29GSWY+hQOXVcbfzayTiIvbjfs9ggrYJkV8EuMK90G+oAk6w95704GYfbFc93
         +QsdIcAL4tBob0P28VxYmDVRJrPOMrqeL+pnOZSq4Og7H/EMTMCPd7hHXtVB+ma13TGE
         jM7A==
X-Forwarded-Encrypted: i=1; AJvYcCXB7tMPMWnLPS9bwKP0yKG+iDZGs7oAnKgVf9Hr3ovMcO9/Uj4UWiqgzwJdjXHN1LQGZBDVU8evrNUahgiDXcwJMnDmNZw=
X-Gm-Message-State: AOJu0Yw40BYEQlpCZ4RdtND+yMHpJ1Aa8OK9Vwu1sU/3KEcMkEQFkvE/
	QtHEeUcZJDEPS+8JESUk7xk4EjT8lr8KNkxw1J4b1jy6/ZM0wufzv0VvnXtYCzGrftzs6TTfoiJ
	VOM1HL/iBgIqO3Cn36CfPUOvtraCzungZHUtfJFxl6qOv988=
X-Google-Smtp-Source: AGHT+IHwIZcmqLvjLJdL4nFbCs9ggYLgBXJnYBwKJ74/hRqjfxBmEuMXVpuI03ApuJDsvsemBmMco8Se14aj/qLzVvk=
X-Received: by 2002:a05:6902:100b:b0:e0b:1241:cc17 with SMTP id
 3f1490d57ef6-e0b54468ebemr16610271276.15.1722441090793; Wed, 31 Jul 2024
 08:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731075225.617792-1-ruanjinjie@huawei.com>
In-Reply-To: <20240731075225.617792-1-ruanjinjie@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 11:51:20 -0400
Message-ID: <CAHC9VhR9MC9GhGZi_1ftycfGyeuCQ=BXgAs+v+9D-nXWg+eu=A@mail.gmail.com>
Subject: Re: [PATCH] audit: Use strscpy instead of memcpy when copying comm
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eparis@redhat.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:46=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> There may be random garbage beyond a string's null terminator, memcpy mig=
ht
> use the entire comm array. so avoid that possibility by using strscpy
> instead of memcpy.
>
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/auditsc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

If you look at audit_log_pid_context() you'll see that we don't record
the entire task::comm field, we only record up the NUL byte, so any
garbage present after the end of the string should not make it into
the audit record.  We use memcpy(), as opposed to any of the string
based copy functions, as the task::comm field is relatively short and
having to count the length of the string in addition to copying the
string is likely more expensive than simply copying the full buffer.

--=20
paul-moore.com
