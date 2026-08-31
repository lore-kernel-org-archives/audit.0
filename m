Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A4383339
	for <audit@vger.kernel.org>; Mon, 31 Aug 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199339; cv=pass; b=GU8N36yQ6G5fKgZPl6FSnVDDG29cHmiUgtG2PwtdGZMKDuhAKB18G6PmkIjGBWKx00Ahimb5Cf/skvJTXgEVBrJIIDaf80mPzmTdjd5YKx+v9dhCvNjh9PgkqZxu0ohG0GH9BcH1btxu3H4JleGe8DbkcbMofHlQC/vDDcrTPDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199339; c=relaxed/simple;
	bh=vUxrg70tu0gkCfDG0Y/HJqfjufL/MVav0fcyO6O4mEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUNYJwqlzTze/OE8mjssmt5+onZWeAljeZT0iq7A7+KAY+ys+PsO95GduOkyk1P+GNiRvBcVtQ/xZ6bCAoT7bDYTjtcpB3UT9tCfJ0GOuQJhZC2Y6u6c0kR6nXWj8M428qgbUeexSZ3pj0PjgeWNSvpYZrZlwTWlxsp39tZtvd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RzNNzC/5; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RzNNzC/5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d91ff7d9acso11695085ad.3
        for <audit@vger.kernel.org>; Mon, 31 Aug 2026 11:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199338; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfPs6BVBCOD7sKzcTGIksUu4NuqB+E3/PjYg+PamdP7uj1HTSqbqUz/0CQ4JaBzwin
         cHiIwlc5XYcoLUPDq3qXtVHA307NMZvXGVS3U5kJ60MQ0fYgluQS3y5c9g6eYMTn9mvP
         EmfJGa7yFRZXZBbds4xC0yM/rG5+Nz48LresD+mXqguNkflx56Ln11Tqn3pCZ/UfLZBH
         J2MYqRoTSJ9tS0HuFFFE7S1r9zQQmgjQ+uKpdqPE5Hhbnya6e6ai79nByP3xMrQJrE7r
         +xnTpqAW5WXlSERwOtqvm8x0VojGvOj1Rtqio15pBEMv6F0Hzvqg2PzyRc1ZttFtZYFP
         aDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrW08dhGSa6XRepSE7GPhDrEpeomStQDl4X2ydpzQUo=;
        fh=J/p161vdmAeLP9BptdFuVhK2OSrTAKu5nmN1QAo+cZ8=;
        b=ndCOcynSl+Oqjdq8T2yzeNarQcfuf0lI//S6Spzdf3szHhw9Mc63nLSKNiTfTUvctD
         C93JivXDUjZuQaGOs3JXae/rAltMIUUfIiGl3YadrBUtTGFYkITnKrA+hPTs8mtsGmxz
         Gxy5qAPoaRZ4vGXdqLQNjs3nxS5mFrwCzIGC1WMr91K9HeMEhIHkpZUCjy/n9CQthZoI
         GAP8Y760oozVYv5lPmynTNbpNfczXPnAOcAE5iogq8ESo8VTj+TCnba43GxQMalCHFt8
         lSK5NLLyy7x2QtMyjh28V6JQiquKRC8DAkqb+XYHcWM7O7Uqv8N9ibKzmD7R8bsSbFae
         C1FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788199338; x=1788804138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrW08dhGSa6XRepSE7GPhDrEpeomStQDl4X2ydpzQUo=;
        b=RzNNzC/5r19aCD+cKnDE9LyAIenQXtB9Fed64ng+CaYCwMZ+XFtr3lyosyxoGAlDfP
         vzywD/OD6Nl2EHmIF2qam+uan7fBNYlcJtM9VkATu42kHZwtVlLOJePfA7/1B40XP1sW
         f427g9SdbPfd4sYwAcbiDwTgl/j6tUzTYeasFbMMHfWWyRs6KmYiOf7F00Vm41g3NYup
         VknLI3bDOAaDiJ8e0kZVO6TAU6uDBShjhm9RcNpmTrNH5UEeIWXt4RZQG7MO7hI5piuO
         2eqGlQGJ1D3By1bA7MbElRznLa2TwhSvABl54YqoEKXKEYMLn2/hbGP9ujfOWK77Fgp6
         GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199338; x=1788804138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrW08dhGSa6XRepSE7GPhDrEpeomStQDl4X2ydpzQUo=;
        b=ic8HrK54t0tA8ji6COHidDKJk/zS1zruEzQ5dWZlZii45c/JvoMjVyossF6h73OKDI
         JvA450QYTdOud4Z2NRNgJQjcDbRR4bKaNDj0jrjaihZx1TaFoR593oGPacCXyc3Mkqmb
         A+mnKZxfcAC62gZLY7fBftDJoMXR4LXhjQxMN3ofDsmZA2d1o2b/pEoxkoSXIqCAUW5t
         gLsjMz6zbecfz5BGx2wWfood1o0Hu41rn686XiVVWzeVOkuzrzUoFsE5gtNuD4mmcJp3
         cVSwTrHsledWWo767CHnco0dHmcQ5vxtQXuVy4erh8XRTUQgDQ+Jjax6RZY+H2exvXwH
         f5pA==
X-Forwarded-Encrypted: i=1; AKwUvBw+52w3WUxAmg7ft++rFMT1qtr0gSRVkY2esLLSRGL3Bdpk+RQMHm7l29jB+O3Kg4z8PtofkA==@vger.kernel.org
X-Gm-Message-State: AFuF++mEKrNPDYSuFsJ9iLSepiaISiZxyL9jplqRv4lvQyD/RpQ4DivE
	qxXxsIoThnifB1psP9XGije+brbXMuDjmhAa9tt2Te1vU7MNzaQYnnf2IcGujzYYfN45poxthWF
	R2Ib9/BjVAg8ZLKfxqmV35MkW6c6uLohNprBfGP+v
X-Gm-Gg: AYBFou17VNRHzlGlz5UG67tsFg5xXh0FR74AzE/qz8eukn3AOePntyVpiXT+jCvzMqf
	JvhPPwyYdQ3UFNYxBILp84MGocd+haGN0PF9xJW6IHsYELubdZSjWdAtcBkLFXSbFIx87RLqh5+
	SagR2fAYeJ2ErAt7YO+tLPKd4CUsbCzxxKLgf92v/Oxilq3OW2ivYXV9qf7Iffp/sd0TZVdrbji
	bh5jkcvV0QkUHTcK8NHU1H3D3d9PPuo4EAVrWJGtO5yTFGM4jYRQYDgipYf+iSz6/RdHdoDnCMk
	1Y12cFi9xbGBDxoXxB/Jmyd/3bSkr3f7ISMVz2UgTVF+nEHpWAcdXFk=
X-Received: by 2002:a17:903:354b:b0:2d9:49b3:abac with SMTP id
 d9443c01a7336-2d949b3ac16mr40004415ad.18.1788199337441; Mon, 31 Aug 2026
 11:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807140521.510904-1-rrobaina@redhat.com> <77cb8aa1365ead24eda2ff0800a8ec8c@paul-moore.com>
In-Reply-To: <77cb8aa1365ead24eda2ff0800a8ec8c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 14:02:05 -0400
X-Gm-Features: AcwNN1UdcuneJpmiDkNpAMqFfZZyAkd8QZdDly9SilEWFq-m2qXi3m1Fl70HtsU
Message-ID: <CAHC9VhSaEx6q165P=ifZcRBDwcdCmbAK0zuomjR83Kg4c52QNg@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing unlikely hint to audit_dummy_context() wrappers
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug  7, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The inline wrappers: audit_log_kern_module(), audit_tk_injoffset(),
> > and audit_ntp_log() check audit_dummy_context() without unlikely(),
> > unlike every other wrapper in the file.
> >
> > Add the missing annotations for consistency.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/audit.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks.  Merged into audit/dev-staging due to the merge window, this will
> move to audit/dev next week.

... now in audit/dev, thanks!

--=20
paul-moore.com
