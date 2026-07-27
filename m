Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB24435524
	for <audit@vger.kernel.org>; Mon, 27 Jul 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176982; cv=pass; b=EKkVKvPyjAlbMjOSlEKBYkMozynXvZA/SoZB/5gTf0UEl2AI5HEYLcqAlGLlLWiZ+eqRTYZQ3UDv4RFKLHZxLcIkpxp9fF/Xb5oKyLQGIb2TnKbm2cFFpYHI5pQ/0wiN78w+DY8LoIdj8ynxxj1A7FZWZcHkzpI5SbyrXHe+nxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176982; c=relaxed/simple;
	bh=Tx41jezFlVQ2edmuydPMUrz8PIWKwzURLBw1Krmbr6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgnl5HSMTXahr3VA9tMxb9Ily+VokiaxadUpAhfOahM94Trv/6sYrXOboP7FG+nJyJb9btyta7rWocf5LomT1zizZNUHWWuQJ0kVTWEqzS1MxBcwLOHW3OguJQRpSeJuAFdPvC/evWQ1UB+Kngacpr4NDJ5yIkiTxcATfbY4VD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EpkUc5PJ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EpkUc5PJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf27856f9cso39733345ad.2
        for <audit@vger.kernel.org>; Mon, 27 Jul 2026 11:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785176979; cv=none;
        d=google.com; s=arc-20260327;
        b=hAwP06jsFvjNOfTsh1iypsQ8oKH8lv+izeaRSmUo3O3NMOO84LpmEawM19TZaZqAzy
         dmC5GVPOpUcWycGoggWIOMnU7EKXfu/JBu0SitpzVHM0673lzft6AivQNwsbno65Jxrh
         4MC27MpCn3g2mAjMeSs0yHik58ZxcB9Zkntl9LFqSz2vLmstjzKGT9I1/C6AQEIbsoNg
         GDG+P1TtoMgZ1f1s+rvllD5wzTiFYH+AN70BAw0dKV6UPLw0sSn2Z/5b78sj+vBSpnrU
         2QQlZ8MNNsr2scWxfZ2GL/PFBwaAv7lrGA1BI3CaeMmmQYytYtsbAO5rBhubDIvFyv9x
         cWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fZel15YqYzbK7SnWSAv6eHtTRr/wvzUrf26/b1NjG0=;
        fh=QBUvzydCXueJShwRyJoac18uuPW74t4ds85BWLuyne0=;
        b=O9pj32gfWJW1x7XJnbReIyYuU2rwqzQNIx8ZEQV7nZrrUCNRirbX1l9A/NsxHsmsW+
         E2b68YKKZMIlgnufPTNVvK+pB5+Gh3MyY7KEgy6oUYYgKUFd9kSF/bwGelgovqzB5RJn
         6KlMb7bilKqpJRdKCQ+EnCtO2RstHW0WPKBp7RtnPlHepqasccT6g0vtV/mB/rzPlrsw
         WVV6KGQw0yOlPf0EXPFBTGGnjF/gN0OFQmuviCNi6D+51dG7acF/9F2rJ+i0AiJhwdA/
         Ox444qEViK3K3oC7WmEjXy+kLgR7wP05Pk3rT/ukDtam+RzE0zIv7cCsC0VIeQCZMiLp
         hVsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785176979; x=1785781779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fZel15YqYzbK7SnWSAv6eHtTRr/wvzUrf26/b1NjG0=;
        b=EpkUc5PJzPEzP+6Fw7Ko9fwkvEi3HLnsmBq3be9pxwn3xI7Xibwjah02NEeIwB+eh/
         35q+dZB6u834FDeSV8V0TcTFqGVsa1alzgdhN2bWfzvwIumdCCfpWfnIx8+GfFRXcBoO
         UZ+x1B4XHfUGj/KcXmW99vEEyDwWM+cfJoS0x9aOdnZRJ4+g3EdHNcfPSBViXUkeEMOy
         bYcllPobcSZ7NKeDXO3VonIXGGxGmhlS3Ot8yZK0647Xy44dqM9AovWteWBu57yJYdWt
         y5oaOtfTthQZgRucoYcd90EBPkHzslpIuan7Frz3CPSydz7/yw9EHDIeTwGx2MlTbnYz
         VpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176979; x=1785781779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fZel15YqYzbK7SnWSAv6eHtTRr/wvzUrf26/b1NjG0=;
        b=hVFnrd7yzHouzmVeYvdq3LZgw6b8GbVqWWYSPVlyRhECZFE4YWOJTiiGElmDusJcTv
         5WJFiH8pN9Ptken8eDLe68KZtFkY+SVY0JOCJcs+qHD0Zmfw0M5AGUvUxl1KQJncEpln
         Bh+0q9RhbCrsbx3x7W/pfdshYbGwiZpYqRStxgc/aaFA/o9B2aibIqq16rzgW4s/66Sc
         UTDNCwQAduTHvvoXO2ZfA1c7v1+g9xcC4VnBObUw0I+KsSnkcYQ8ytp9M775mBH4h1Hb
         4pZSOOn41Gk/+ysS+KDsJgwAjxMuzS46TjBWqhnYTDPU2fuDMeJhQJtd/wI77GIZiWbE
         6EOA==
X-Gm-Message-State: AOJu0YwDSuREs48JRM3ojGFMdSYGfbpkYcYeRwqmrbmUDHiH7k1dz7qF
	MMORFpT4Jcmj6No2PgVg0OV+UiMeUg1ibLcGao74lk0R2p6TLSaFIo//BsfhJWrnz+2GxpN+qTa
	pHDmXsf9/TXMbLmrJjYFDNsgi5HS2TA1GXdj2PPvFEabA0uztQZhZNA==
X-Gm-Gg: AR+sD127keIDMTcTDmQjub2wkLcA+CnnS1Z+H8tsV0bWCMP/R9W5RmdxiwnfuCfxlp8
	v5fMG1BPtiSCuApb5IPpcJ8HzQeHoz+g1BNyOiJuCOxD7mSGuAlg659Z9pxaucFuNIhvXlKzWvJ
	f/DqEFIEc8e76z7IRhp3l228IoLpO7WotAk735S0dvX6oB7NcCNwYgOZyewJpDE2k1RbSbT9v8z
	d2ST3YX+Dpk/MMB6dcoUTMP5wn3vP6NmI6nA8p8sP/a5LDXCKug4vGPSyHFsQ==
X-Received: by 2002:a17:902:f710:b0:2cf:b68a:8b5 with SMTP id
 d9443c01a7336-2d00f295c06mr3963915ad.14.1785176979552; Mon, 27 Jul 2026
 11:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724195626.327253-7-paul@paul-moore.com> <20260724195626.327253-11-paul@paul-moore.com>
 <CAABTaaCuNORqv49_ZDcbq8x3LAjb7beuQHEmUjVzGU8AL+y0mw@mail.gmail.com>
In-Reply-To: <CAABTaaCuNORqv49_ZDcbq8x3LAjb7beuQHEmUjVzGU8AL+y0mw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 14:29:25 -0400
X-Gm-Features: AUfX_mzfYGKjmUIuN1OiMY1UZPKgG844Bbz6NZcPzHUy42F6hK98-0cPcA-h8O4
Message-ID: <CAHC9VhR7OhC393jQPeVT7t-D-7DHgQRyW7x5KWFqQDhoVZUPyg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] audit: add a missing function definition when !CONFIG_AUDIT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 2:02=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Fri, Jul 24, 2026 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The audit_string_contains_control() function does not have a dummy
> > function definition in the !CONFIG_AUDIT case.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/audit.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index d327113c913d..ac8f5f77d442 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -237,6 +237,10 @@ void audit_log_format(struct audit_buffer *ab, con=
st char *fmt, ...)
> >  { }
> >  static inline void audit_log_end(struct audit_buffer *ab)
> >  { }
> > +static inline bool audit_string_contains_control(const char *string, i=
nt len);
> > +{
> > +       return false;
> > +}
>
> Hi Paul,
>
> I noticed a stray semicolon here. Otherwise, it looks good.
>
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

Good catch, thanks!

--=20
paul-moore.com
