Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB6517BCD
	for <audit@vger.kernel.org>; Thu, 17 Sep 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663590; cv=none; b=X1IS48ko9i0MaMnugMRCeGXqOFgRzJryz26sdCzHnkromMxH9PijwIbuUHVp50+kVP7H4CcV9VuWViK9wOILw47VlddVsJDHzkdTolHyHPiu8eGYXs4HRBV9zObeyWTyBGksgNjHQo3aWvZ5baezaVa+SUohma+i7WytoGj/RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663590; c=relaxed/simple;
	bh=eYYWM3K0Z9Uro9HwA9hQ8je2naly/JqA+zNhzp9DrpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH6OqKojdnol3KLhaMfXHB2jb0tJ8FopTxumwUYhTZXcR3q7MftObEf3Tyw7uGybJTFw2Od8PS7SCP5Kgy54heL2v4BsSMDVlhViaqEB9jMESJO+yrot5tBAXSEXOAuCnHQYS4tbVTeDE1bAUFiAJrYWeCBoX9TAtlm9y/ab8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9lWqdLX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9lWqdLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=N9lWqdLXj8LH/ThSIM+UCGG3PsWpXKluzUPVGEh1YVob8MZcUOGDATI6IraObPWjlZR83h
	srvFZuPvdhVz2CmogGHXp7Lo2FRCYZDrgkqlNvIQUj2myM4GSVskOqMATfhwtMKZzj7OSV
	bMIT0DTAv/VBthhGlrlwSzj3TjHICCc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-wm3mh0VqM-y0T7fiiJ6vGw-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: wm3mh0VqM-y0T7fiiJ6vGw-1
X-Mimecast-MFC-AGG-ID: wm3mh0VqM-y0T7fiiJ6vGw_1789663586
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c294ae16988so134589466b.0
        for <audit@vger.kernel.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=VYoVpIPOMp0URoGCKG3QJ2ncUK6/LA3wNYwfOutvvRv1TAq3DTC57+yH19uU8ZxNha
         HdWFZY6r60v+3R/PX1BamfOcPoJzbpaIt7y8wbdNp4ASoZ223+VmzKcSENeDEevPUm+n
         G5fRSI1xPXMshOShFKSeRZJyH8Ijfm987/pz4vFd7Obd4U2D+DUqVCyJmaYkq32HCDi3
         5UQTAuU9VKXnMDFQeafpfFORvPBB7P3nWFIhCp8U5zcL2fAGHzrOxX+YCNjwwnxPEoY1
         1qgC4e6+9mKdBUqwectFl/FrhsAdKjVgX5Dnm3eENC18YlSbopk5r8DHqCq/JSvfjUYS
         lglQ==
X-Gm-Message-State: AFuF++ksLV8McdugEULZdmCaZK7I6kJducXr54ISRV1gn0O2XC5RdmLR
	VaJD4BfOfy1zvGqEsfGWxY3rmRBs1gzPTcwV+iLag1DAMC/7XA/FNzl1mMjzUIhEgHMIgY59xOO
	rJ4lv+D6mQzF5AGD/oDoYi2DsdhQTc+0EETofVIBp/Ow+K45mQIW6GIh7C40h9LhmS6fGZZrWZA
	j12I3KBPDIcLod4Ey7XzyIaFZQJCTtSAM=
X-Gm-Gg: AYBFou0hJm4FQDQfDRAK+veH/+KzUtIUG/7vaVANFHjYq860qZiEHkGtVEJb4m/3fC+
	lPrgJhzA5QPfXZpIUsyPXjzmO0ddWL+qc1lBRpO1J1sCAgy32m7KFrRjjtn1S03QT9L7c95G3do
	SXCSbjso8V62EQVkkJ6S+GiRWOPR7k9q18dWtp0fhJybKCfn2qSKWt9kOzQKnZmG1tAW4VdR0WG
	WsxfWJBRNO6GEhcv0/IYxzlUDARmIOhrFs1B6g9YA2mUPX5WLeB+IVaJBkbQSyf+8Z1ijmy9iUi
	qPY=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504525366b.42.1789663585463;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CIQHMlosF1ptqVXDleRVZse8HKEQxq4eYA9kR3qgjtU_1789663586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo

