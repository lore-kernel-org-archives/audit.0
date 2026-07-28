Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC93D47AF
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278804; cv=none; b=pP3R2l/ocs42WX0RSvK5NGH6NxgvWTveXb4rkIaZ3t1r1dcArxLBIi9VVtfXRRL4N0CeX7ecFzIUXTsWgznFgEuXZHsgibcgeVm3ECnuqfeJNlSkyZHr1PVOUcOFa2yxTOXw9qipTzqvouSq5y2qoE5+pEoMdRYhb5Kw3fZ6URA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278804; c=relaxed/simple;
	bh=StfNncF7l44Pi/nFXCjFV4Li67JqwYsuC+z7cnlHi+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6K1qMmuycLkMtWCLOoSayPKZyvWu7rZNB+BgpSqVmTMutrl0dTGta7dUakLGxO6ey/Bj06Hxobz6WV8U29K2w5mU261nYGQHX9TIzdtCI3oWwW5yfTwIrcp+Q0NnJE/WelmjzqqWCW/Vwr+EKstH/XUSd2HCmmF6gpkCzVlZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdP8tt2U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdP8tt2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785278801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlEke2Zqj6DMdoaLkrGIGqPHj+QNXslCH1f5cMmE21U=;
	b=QdP8tt2U258eFngM0iaFDaqAZ0EHpM7cFX789bjlhLw8aQuhryfK2oHTY9Xhz6Q/w390RJ
	TAFsttV1iH2tcXwhMtiya7Y8fIMdmRBw+jEm67VyvQc9z4ApavPTBswsXx405BSXu0KaVr
	tYG1N2POEK9qzGdgmHS5kaU2fI9mEJE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-vFGTp-kWPROwZLUFyp6_RQ-1; Tue, 28 Jul 2026 18:46:40 -0400
X-MC-Unique: vFGTp-kWPROwZLUFyp6_RQ-1
X-Mimecast-MFC-AGG-ID: vFGTp-kWPROwZLUFyp6_RQ_1785278799
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e6109f9aso27350066b.2
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 15:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278799; x=1785883599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlEke2Zqj6DMdoaLkrGIGqPHj+QNXslCH1f5cMmE21U=;
        b=kif78PUxeOldacvkxo7wovQm5YeG58YcFWfGLsVVYUOoInitiWsGghdHlwo7iQJ/xs
         m25VxHF/Sy/V5iH+OmJg/99r6uW3FSe+AM+JlxoWxV+ezZrprSjm4uOnySpKPZFZsnx0
         xbMGazncAFvKQWbXUx+gjhhLDTFDMLdUacMCtTf0yjY6CmOQb6t1+Lj3U6BBnLQD6rDV
         n625HnXxUHZR/c0atfXScUWGHac4YlvGLSA6pqO1M47F3OaReY13Y6Io0mtk/zk21KTz
         rDBO2yI7JZ7vP/7zqshOfpIkMGaLGXW92rh6cZjglbbv2gnRyPFs1RjP8FoomUGQmVqE
         6N8g==
X-Gm-Message-State: AOJu0YyCeRVOkfX0ePg63bUnJdkODhNKK/BC8n7UCx0PcDNsyxCCWBDA
	QvrxyEHFJtzE4R9xYzyrpMPKesrTo+A591U0KrQ1Sy0uWU8gb2pGa31JsNb5I3Ik/yt/XiLMfPz
	eIO8RVfwg2roN8mY/qXeOzX+7BFVIBYQTab/HHJwTcw17ay/5QTl2Coxwdieo5TxCguJENloOqK
	VaR2z09VSbL9TiLDTOKZU+YL19LtVnGtc=
X-Gm-Gg: AR+sD11mTs5xpJ85zratkPMXXswIFg++Q6NgMATnRxSThAbP0TZbcMVSMibAMDoBgH0
	L01NTPC/y3wTJp+kdDrOaDrewnxX6nkXEPWozUiD/cMSlycc1KZKlN+lBW5rE//iFsCPqjfc88U
	GgDq3KRWTADdS12Md62oivmqPm12TVHlpgLJh6Kh2nW7vtmnIOgMAwbnrPcLwjTS/ilOJXVsHzR
	l7A83aLJaRi/JGpmAbAW9AkY0gbgbKlRMAgDfbVDEjlxeG7ni5aemLuI25XuHQG/UULlrR0E4Ni
	EFs=
X-Received: by 2002:a17:907:3e18:b0:c15:bed9:f492 with SMTP id a640c23a62f3a-c1f71e874ecmr219748066b.10.1785278799222;
        Tue, 28 Jul 2026 15:46:39 -0700 (PDT)
X-Received: by 2002:a17:907:3e18:b0:c15:bed9:f492 with SMTP id
 a640c23a62f3a-c1f71e874ecmr219746966b.10.1785278798856; Tue, 28 Jul 2026
 15:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32c8fbc6f680e8309f64fd04f580b6a51bec0176.1785246707.git.rrobaina@redhat.com>
 <883ee05917e857f5176178f2f14f3cee@paul-moore.com>
In-Reply-To: <883ee05917e857f5176178f2f14f3cee@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 28 Jul 2026 18:46:28 -0400
X-Gm-Features: AUfX_mxZjuAxfLYaej-QXAM7CbmcrUr1nyVF8dYYyr_HtIwK_ZbmVVk3JEy-r10
Message-ID: <CAABTaaDjMreZmXrmYH9MW2rEmvi=8b_8DL6=RWP7ZFXjKO_4cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: drop BUG_ON() from audit_signal_info_syscall()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MiknEmLyN2_F__E1KkFQzKvbxPrFn3BMQ7ZFHYYmKuo_1785278799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jul 28, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > The BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS) check in
> > audit_signal_info_syscall() will panic the kernel if the signal target
> > pid array overflows, which is too severe for this situation.
> >
> > Replace it with a WARN_ON_ONCE() and return of -EINVAL, instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..2b9ce0b52511 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2712,7 +2712,8 @@ int audit_signal_info_syscall(struct task_struct =
*t)
> >               axp->d.next =3D ctx->aux_pids;
> >               ctx->aux_pids =3D (void *)axp;
> >       }
> > -     BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS);
> > +     if (WARN_ON_ONCE(axp->pid_count >=3D AUDIT_AUX_PIDS))
> > +             return -EINVAL;
>
> Part of me wonders if the WARN_ON_ONCE() should be a pr_err(), possibly
> ratelimited, but given that I don't recall ever seeing this BUG_ON()
> trigger I think this is fine.  We can always change the WARN_ON_ONCE()
> later if needed, getting rid of the BUG_ON() is the big win.
>
> Merged into audit/dev, thanks.

Makes sense. Thanks, Paul!

>
> >       axp->target_pid[axp->pid_count] =3D task_tgid_nr(t);
> >       axp->target_auid[axp->pid_count] =3D audit_get_loginuid(t);
> > --
> > 2.53.0
>
> --
> paul-moore.com
>

