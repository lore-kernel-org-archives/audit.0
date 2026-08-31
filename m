Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC33859D7
	for <audit@vger.kernel.org>; Mon, 31 Aug 2026 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199380; cv=pass; b=QeZGxwC2bdB4vnNvs6H4HMaWI3VxBiC+uLkygGCLUUeboC5o2rxEv7JfO0V6l6asJKRU02YswtDoowkhmaGXVrNfX2+C34SyPw+JJkfx0mEuknmmH1IvwyKGMyzpeAkFS2u/xMlTtEuNBhhu9DWs6xmxrS/fX/9e7yV0zmydDus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199380; c=relaxed/simple;
	bh=7qxKJrt3+u81eJLDsYKd2Jhek52o57IUpvJh/RceBD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF+Ykba+hu+dmXF+5nSMvEXAdJsZht991OIxtSx04xspLfMKdSdaJax1ImsOCn6Gw0KJcuWk96Cdqtl8tw/Vxd3JzlSUi5fYSkcDyU0rJ5Z08QO411baDuX96YJjG1rjIfM6A6CXc4dGtai+Iod5NybrE3hHeLwv/8Gvp3p1KoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZjPIK2m; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZjPIK2m"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4086456b3a.2
        for <audit@vger.kernel.org>; Mon, 31 Aug 2026 11:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199378; cv=none;
        d=google.com; s=arc-20260327;
        b=sQis3C+8tNwS5FkRNxZdCivLl3prkD0aKxPixNL2gecby4L/a7PkUIzrcsbTtyEGKg
         FJ1y6U7sTnibX65Y/huoE8osVvhUTLlxzPqmr7kQ3mo86jSrfrBGJpSH0HgZH5jqYuNa
         wwHIUTfGlIC5GmeviqJAo0nZ74h1T4kccd0+O3XlWZBi3UQkJ45S+PqnLOyly03KgH1B
         5CPue2KrO39tOyzuqoedxJ+6ed+KeN4gtTHozIyaGY+RDIbu7E4DUdAeS1AE0oIotW5f
         vSdVBF5Jzg0OUrpcv801p9zCClrMMLaQ3vnFK4rG5h5KK7J5wUB9LbQjzRxSJK8IXtPT
         LeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rX1e2hNyl0dgt8WD8Xkfkh1yvoPo9dQbQc3KQyM7kU4=;
        fh=k7QXet+sx2XosveU7/m846XE5ch6fEj9hOQ8hAqDY1A=;
        b=f2NUwkQXIQWTtv9+EmYJ0kQultoNCCUjHF6gSHyC0QeFxOhFi4bx4aBF3tzzfM4fvG
         IQt5IMitalZZOTcpzLzfgAT8GZLsEISZ8w4PRg/D7f8p4Xni3Eg2XDSq2VzsjwaD9i/E
         S5DkZSRUs45ff3zF7wAGbmryMrnNy6nrIOBfgEx4d1rYK0DypbmTHX2rCTmeWzcFVw44
         CEjS9imgs1hYV/QpT5+nkMDg0g2+LY641V7iWknTE08XfCJinVjSWBq9Hk/zqx4KjZhh
         HQGrWeMsUKxDqajEdBhrXZgZPQ6dYJ6zOTLKchV0RjZcT0X8l1lVhGx6dMx6bYE5dqFU
         bQPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788199378; x=1788804178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rX1e2hNyl0dgt8WD8Xkfkh1yvoPo9dQbQc3KQyM7kU4=;
        b=SZjPIK2ml6eiCjqBd63NMFqruoJ32mQ9T2//2WvfEl+wiqog7d4GhZMiLUd/JdfuFC
         ED+pWO4R+c0n8DHWs/1so/ZZ5sNkpraiQqPgdt6dWOfmRuEGYib0poX/XbKfRDWQMdKr
         iFEsJPNZ0RcVIyiR0Sw07cUSlvhqspSjgokGVpZBLFWPhUfEu5o8zF1AnNJebf3s688L
         TJyUH6y8vcPGBt11Z9QhQIAsvbKWXISaua97/UVdy5kmgmDTVGakebCOMNTxOiwZ45Wu
         jjpAqntCiUokGYTBpXWqiJwm4apTQn7keEyO/PyvXClGl6t7j6ise9Hn5o5yQ4GeNxkQ
         ExXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199378; x=1788804178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rX1e2hNyl0dgt8WD8Xkfkh1yvoPo9dQbQc3KQyM7kU4=;
        b=O28k9PTvIi8YI/7h51jN5W3s2OSr0EdOHy8otnhy/Zxs3ikMc6ttpt0JzESY4OK89e
         zq6HxKtK46WQAsf06tTQl/iw4FHTkQiRDrhPip+mp7HTkmsr03zH+FdLIAINiqHVHlWG
         IANbBhga5miqOSCsPfemssbWSAUGDQz2YMCmD3KAMRjh6wvqD1PXY2/FOWL0+MYIwEY0
         BBRE7Bc0tXEmxvvadN50qGHMhueTvY20y7AeWYu7lFEUPXGx8dKJvfIqCMNUyAleV81y
         AD0v0edthmv8bzXawauEFMxXonBM/pGoMjo8YBSd8yI2vReOeU1DVfDTpB+vhCCRmok/
         wdkA==
X-Forwarded-Encrypted: i=1; AHgh+RojDck83z9pcctF9TuZ96cAvyc+Ku84fkHNG7rAZxQf8BP5OFOVEcz1oNEFn0aE/fSPriHByw==@vger.kernel.org
X-Gm-Message-State: AFuF++kLDRx6H+86xyykydUTjrFJUpPlX0Fdinqm98wwDqVJV1bxON+u
	vExcginJ+Zecpb+NcJW5JC9XemQvSuEycAxFMnkTLNo8MZbh7br7ViAOk2316K92ZLjqSUv4gwk
	tzotHqNLVlIxCMIslXE9Y2xSOVkuS7a5n1Gd5CyGP
X-Gm-Gg: AR+sD101CJml+ktn98aXBf00335Z5xPFr+B+nP29bCVItnm8COHGuq/5JT3D2/XKp2Z
	0Il1CQ6xix7iw+01V4EpPxLC47oRQO8qsZqB+UMpE3uxblKz5Azlk148NXSVKkrIY1Q4VNUgVtu
	Njkv8WniKYdSZIL/kjk479QR6C0z7zXNFqnwpxZgEOH55y+aunv+HtWSdZN8DhGCPa0S6MEJFCO
	HPchPtwDrWzVSSJzPIoz1X1da74lMCzBEZATLFgMiO5ETm/jRhozc5eDtsVAH1Fx7XDIV7YDnpC
	VZaBEX24/EPHFXcXah3OktQvdEoJ+HiZgiiX9tY7aahl
X-Received: by 2002:a05:6a00:7702:b0:857:726d:270e with SMTP id
 d2e1a72fcca58-857726d2e72mr28350340b3a.26.1788199377609; Mon, 31 Aug 2026
 11:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810125726.775689-2-rrobaina@redhat.com> <7b9f43325dc569ddb689b02893bde8cc@paul-moore.com>
In-Reply-To: <7b9f43325dc569ddb689b02893bde8cc@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 14:02:43 -0400
X-Gm-Features: AcwNN1X4YwvVJtikAlc68Qp33s2cNHUlgKJNL_7Fz4NLYQY6IuY6zSqRqqsuN2I
Message-ID: <CAHC9VhS60qFhHfzEshKyJ4AnNCG8eaNBxndAZcU5dnhOwWsOtA@mail.gmail.com>
Subject: Re: [PATCH] audit: use copied skb length in kauditd_send_multicast_skb()
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 10, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The netlink header's nlmsg_len was being set using the original skb
> > instead of the local copy passed to nlmsg_multicast().
> >
> > While skb->len and copy->len are identical at this point following
> > skb_copy(), it is conceptually cleaner and safer to use the length
> > of the skb being actively modified and sent. Thus, this is a minor
> > cleanup only, no functional change expected.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Looks reasonable.  Merged into audit/dev-staging, will be moved to
> audit/dev next week.

... now in audit/dev, thanks!

--=20
paul-moore.com
