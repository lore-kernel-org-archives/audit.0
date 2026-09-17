Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E395208A3
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663665; cv=none; b=jHKj70CFvV1/pvamslhKC5aClM+b5Rmhs0c//zuhArrd0LZ5/8dKOWUnCR8wqN9BqssHmUDJYCZPjr/Sp11N4RCxa8i9yhW5SvoRg2MHk9XqFOhG558LAaj+IPmjoGAKi+PAr0ai+ZgtIhpC/zRQCuuM3qXrYP+1L7irF6P91os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663665; c=relaxed/simple;
	bh=OXoyJpegabl0ocESy43SWOAVnutZsDrl9ix8aJurgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fdx97TGkWEHCIVjWMpCdTw3BZugisSe6Z6xVLqd5/AfZFSpO/Uyc9fKfKzSdw8/ioyH9KU47C2NMrFQ8zLb4oEwv2q9k8PAZ+fcTNYdiR2O4TvQRCKqybkdn8gmNchNrYGMbmHsdJXdQTyQvVPKTebI4djaHBtsQ6WqIDfO3/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eATgGJvg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eATgGJvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
	b=eATgGJvglDB/e/XNDRrzgW5WKOMEpiB7LymnGtDf3t8cuHmDceHF6yh3kS+B4K+hNcO7ms
	+q7mwqmlMk4xTiF2LCi9CdNZxB2HVauHdvJoBImez5qV++TOb0SpSxrRysTv9oeZ9rPF7n
	RqubMsnYYyb9IE5olgw4ULYsdRg071o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-O8c7EUYSPq20dvRgF1rv-g-1; Thu, 17 Sep 2026 12:47:39 -0400
X-MC-Unique: O8c7EUYSPq20dvRgF1rv-g-1
X-Mimecast-MFC-AGG-ID: O8c7EUYSPq20dvRgF1rv-g_1789663658
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c295b027ee0so120927566b.0
        for <audit@vger.kernel.org>; Thu, 17 Sep 2026 09:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663658; x=1790268458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=d2o62VX+0qNNi7OyVVD3yiQyRNW2qFr9jrdGXj//NvXm5ffs967buiWIg9X6SFcjBP
         gi6RSXU/pOafmywYr3DUBvZK0sZyFNlU+eLlQAZHHZ9eFffieVBa+A0FLoMmE9yrqWSY
         mLPzImDyFN15Bqoof1aR+ZwAtKAgQAlfGWadqJyL9hghwN7l/gkgKflehtCaiqrRehoq
         C5MtPZ4zI1r9mUisFd29gpOqCq3ZRSwMeyltwbE+PsGi+mqaJLxhXwsvK7ByrtzK1VJA
         V0H9X0Vx2IUTEBDvegrLEWByuJO6lRqgtGp3oFXERTbAWtLfXH/W3IdkP5CXyyTBoM1M
         wXAg==
X-Gm-Message-State: AFuF++nypEBUgL3HQaPkQTpDxT1vtJnOcxQD9vpomGskALdQwtnGmAfI
	gUURV/j72n9bZWiTaWmVB35wr8c7JaEFUKM0jF/7tFr3FMZcszLwvAvEVWwHRlaIcp89KauMqxN
	rzUTyv8fZaOJkMPVnaaGyUWxFu92/BGXi1mRis7afLGUk+kjmJd15G8o0M7I/vek56evmyp96I7
	qTe9qFCEhaJDxjceDbTo+1jqOpsrSUFKw=
X-Gm-Gg: AYBFou1etPhgSBQtqbBlaAkodO2oN8XA/6pWtqlIgEVex4CayTASbx3q2r5jF+p/KiI
	qY1txJShec8jcA+EVw8x5SAfy6TaAv40lsTpeC9JVX0FDC7bUtzjh1NFO9OGN9k8Ysh9us6/eF6
	ZSB9DA7ZMFNYXSIvrUDcERZa4uFQDHKk86DT5vDkH7paO8hNdb4D4RFlOomN70hg8KrZHFVjmZ8
	0cStcw1oTbgyQdx1ejW77Wf6z+QzZA5oGyd542fkWhY+hM86myiCPPY/qa0EcBCseE/jrAzdk3X
	RzQ=
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr627702366b.10.1789663657738;
        Thu, 17 Sep 2026 09:47:37 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c29e5244c19mr627698766b.10.1789663657315; Thu, 17 Sep 2026
 09:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
 <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
In-Reply-To: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:47:26 -0300
X-Gm-Features: AcwNN1UQ-9H3EW5aAPKYI2mYiHxV9kMvBFdM8jP3WAhZbefwH7qcxYHE69PGYDs
Message-ID: <CAABTaaAUBzp1uaLve2piMhEB1R5po5n5+Sy+U0mbbe70Ak-SUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6uGXCjUI0Au41QQEJk0vXEcV51aK5RkLYwj3up8P8xg_1789663658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:21=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Ricardo,
>
> On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/alpha/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> > index fc8f6cedbb28..8a39c0473297 100644
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
> >         }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       audit_syscall_entry(syscall_get_nr(current, regs),
> > -               regs->r16, regs->r17, regs->r18, regs->r19);
> > +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
> >  #endif
> >         return syscall_get_nr(current, regs);
> >  }
> > --
> > 2.55.0
> >
> This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series
>
> https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail=
.com/T/#t
>
> That series moves alpha's syscall entry onto the generic entry
> framework and removes syscall_trace_enter() and its direct
> audit_syscall_entry() call entirely - verified with git am against
> GENERIC_ENTRY applied, it fails at exactly this hunk.
> You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
> lands, alpha's syscall entry goes through
> syscall_enter_from_user_mode_randomize_stack(), which already calls
> syscall_enter_audit() as part of the shared entry helpers
> (include/linux/entry-common.h). I applied patch 1/13 alone on top of
> GENERIC_ENTRY and confirmed alpha's entry path already routes through
> the updated __audit_syscall_entry() - no alpha-specific code needed.
> So for alpha, you can drop this patch in the next revision rather
> than rebase it.
>
> Regards
> Magnus
>

Hi Magnus,

Thanks for reviewing this patch! Ok, I'll drop this patch from the series.

Thanks!
-Ricardo

