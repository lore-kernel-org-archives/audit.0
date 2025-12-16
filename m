Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDF3B7A8
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901555; cv=none; b=irhpbqVIL7kCIjRfgb/0M7xCb+WaaYQQz+YLR/JV/QKE7w0n5VWLpaD+T92rRtgy4Sn92lTPcWzXioqQGh5w7m2UZvTQCHtPY8FKJaoUaC6fq4IETiGB0nUxVrSMPpHVfMp34CTejVAgz/k7CNsraMJ1Tfv6InRLCPtcMr+la4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901555; c=relaxed/simple;
	bh=BHwhdPtnPYkVWeQW/r/6cO9XxIvLTPYNKd7fprgK2eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ADEx4BuaHWdJ9e66786D5oGtm1SlH5oiQ698KeF1nvMgj9Wu7J7p61opewWhqp6rj4ZP/Oin9Nfo1E0OwBjBQQW07gu5as3mPUo1B56Xz4uWJSE0BgIidjsYhnYac1f3OZxsNV/LGY1CVSzLnuZsV3fk8TBkxYJUin7hoy6ojEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bYKTo/b7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bYKTo/b7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so2984753a91.0
        for <audit@vger.kernel.org>; Tue, 16 Dec 2025 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765901552; x=1766506352; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rSoFJYYdHnJ8RtiTGRsfzR4KahPKfP/qkPZtp6ZPxc=;
        b=bYKTo/b7kvcJ11Ugb+KnNCazkdGSbY0DeQ0G+kHsXlRnYembNhdr2xgXRlG1xMJp0h
         sZA1woGvRJSkz5BZt2Dw7Qd6wLwRiVX7x3J6sddCLMSdlPWCgpkxhSs0gYDzT3CFC4se
         SnBzgXz6h/vtkYvs3L3a93o4tJTS7HGYnGlPe2vkV917qX22J6lRxGy+6lPjZ/krdNIT
         Mwa+k4lzVZoaYM9ksdrA33jCBi+Ybu0X3zltfad6PpNZ6YDK9Jbq+B9p0DS5VCUSs8iP
         6fpNpELMZElQRvttaN3FqDlFiNp+LrKoq8ebDWcIJK30hyJKd36CFAFNNOocTpKXf6pF
         wRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765901552; x=1766506352;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rSoFJYYdHnJ8RtiTGRsfzR4KahPKfP/qkPZtp6ZPxc=;
        b=P8kU4il9QMSW2MfsTdA5EDiBRvn9Fa7i3eWJMUBFLkj8suOoYkI1qsQk+7Sn3aauDW
         7uZ21KpL96fcW2tvyoztNg4glkhhfLW4qqwFt5KkqmXB2+Ib5NQlc9VPRuXb/1jEW4RG
         YzYQiJikLU6sAfBkY7d2CV7Rol3q+SWTj8Vneqi167GdEg07I8wGSIAyCCyDpW371PGt
         qvQlDW4UX1S8lsmhdqTTmMiQopzo06laKMAMtoCC45XbxvlK+3fIaXbY8xyw03hiR0Tf
         fyjlGPWEaGm9AN1P/CfMAgBrMaJZNvBWxonaaiz0gQLhgXrfhUAK9uhmx3ox8xZkzw7V
         ynEA==
X-Gm-Message-State: AOJu0Yx6Ow6WK6dbrpIu0WGus9AWA9u6r7LjzQOvCt29PRdt/EU/JEnN
	+XnU5vLu3Wbf1MWN1VJ0yoX+vvmIk6922cuQxppQCQfxN1QIYgdJ6TU7dAT7l4OYW6ofBwP9aYo
	gw2UXmVzTeJO/jDUBNHkIAQJERfwsQnWUz5EpfNDS1wFErAzdo14=
X-Gm-Gg: AY/fxX4w9YpVCtyi+F1n1eV5avGCyg5V3Kvx8KKJam5eEZ00g9zyk2zZgVEEldeCnG9
	v+GYYwIjhvCbk0ycOcEVZ9jORjgJbaP4GSPWh53g1tZbBVDunbOIeQIdECdBy6ewe8dDi+mDzuK
	4sjGGgsAVOnR1P4saifVnvoSo36h2LNdL8ERzilSyMVsh2MsbHCZla5g7Bn8nD+XalhCbpi0wUJ
	tOd/wEed8+QRsaiIMUzgJEUY9Rbsxq9ulqVAL65LhL/+zahkp4abhcxhC/Z8hAK7EkS48M=
X-Google-Smtp-Source: AGHT+IHIkcMyUsTjP7D2TLzBbGQtehSC7lMp1+AEp8jWADq6FrYmy4jDPegZqyqBGgx6EtFiT492yjF/wcFFhg+sSPE=
X-Received: by 2002:a17:90b:2d4e:b0:34c:6e10:fe71 with SMTP id
 98e67ed59e1d1-34c6e10ffadmr7825545a91.25.1765901552220; Tue, 16 Dec 2025
 08:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216160059.58230-1-paul@paul-moore.com>
In-Reply-To: <20251216160059.58230-1-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 11:12:20 -0500
X-Gm-Features: AQt7F2qXamxHVb-Y7nB-vuWQt9aFpNSsxQZaENAkL25q2cxa4Ke_bjSf_6gFOf8
Message-ID: <CAHC9VhT3OW86ALFRBeyJsLPE+ZzTrfG_NGwKhnZ-+hKMZCqC5Q@mail.gmail.com>
Subject: Re: [PATCH] tests/netfilter_pkt: allow for a greater number of
 netfilter fields
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:01=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Current in-development kernels include source and destination port
> fields in the NETFILTER_PKT record, adjust the test so that both
> old and new formats are supported.
>
> Future work could include verification of these additional fields,
> but put this quick fix in place now.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/netfilter_pkt/test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged.

--=20
paul-moore.com
