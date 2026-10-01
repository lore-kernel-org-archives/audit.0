Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC463537CD
	for <audit@vger.kernel.org>; Thu,  1 Oct 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891277; cv=pass; b=hnvRKPziKidXEbfdqh0xKMf9bZYfn7zBEWOOaytgmtPi3r0xJb+1PE7bH8mi25Lqpbdvs+1UeexpbhVB/IEkZol9TTu2BuS1IssOvblhxGx+452iaMSbwFCqMU5PkXPm9zpHpYUUp+tr8jXPP3+T1P27GMekDRGkCuVzt6vsa78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891277; c=relaxed/simple;
	bh=d81F2c81bYjapD3k7WPL8vQXWEIZxtjRqd5WKOeB6G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh28qC/oa8u4vMYjlSlz7AUwPD2wMlp25axhgSjJHJLzmI3REaNfKS27OR1y+UesTFAAkpTiuTJxyOcpjktNqNQlQ3XuyriRssir6Cdd9sc2AtDvQ+2ngKJ5OwqvjywxpaLNsgYtyKYUpQ5DSy87J22hNAxtpyylwYZ/GELF8fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YfKHNuZC; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YfKHNuZC"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4c6bfce73so1693834a91.1
        for <audit@vger.kernel.org>; Thu, 01 Oct 2026 14:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891275; cv=none;
        d=google.com; s=arc-20260327;
        b=Ncb8rArUQw0TvglFS59ZWxA1oh2tBTnvjUddNOspPJuL+RjojSQ6kUM6HnpFKH3O1H
         wHMudjWQfTDWwPLk8MN4ckuyWpqQGInLor0TbaW6EtQtoM0v67atGqoz39zI6vC0YJFw
         huGyt6jV3mqOyx1JUZcYJn13NvrvCAVp6g2exd2Fv9F5O6brwAKIoZpdkPgBRiatNJiK
         q6A+QEeY5xoETSxuF+d+C3G5mu/aDDmfF2YXSedUBkmkNTZ8XqhSU0uPZc2KpezHyL0x
         I0naB3TtG7Or+Xvp5Kqu2RYXBjq2OkOgZeNLTWuzIIowIloKpU5VlUDr/LfgrJUBaYJ+
         z1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KauvhA+qJPgpodeex7vmZyoN1DAskKF7lJ/Kn7XSSQM=;
        fh=QBUvzydCXueJShwRyJoac18uuPW74t4ds85BWLuyne0=;
        b=G4/L5CMuuIwYNCDm5mIZY6CeJK02abcor0qsyaaw51JKVmapahkEQ/iStLRBl8Ahft
         es002gwNIthlfZfzro/23tRZX5BkaHTU4g+L4G29pzC3Ok41SGUBQPkKX+H/I6+b8C2C
         1Z72LIwbakCDBezNpt54iqjVLEPB9X0C1PMbtSSC/cZG6uZE9IQhHaLm+dh/toqtlEGK
         ZjygFS5ugMzXYK7AxScIAJNC05FeJcbz1uzLsPgpc+DrfjJaoAIPNGf9H6mNIax6a9wY
         DXihlo8Ntfm57MYW9YdV239zMDyaa8GjVkMO31kqQdZtVqSG6LSKVQGaaiWMf2is5/ne
         fjVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790891275; x=1791496075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KauvhA+qJPgpodeex7vmZyoN1DAskKF7lJ/Kn7XSSQM=;
        b=YfKHNuZC6znxJ8GyWnWe8JgDizgQPUkVRoDUOzw3lldWtu5kwqMw0vOmCU6aaiyesT
         q1BMzkxTVC44JgPuoD5J1RhAXqP0GPNtrsHHwIjMLcfzG6/7QeMzyF7Aiheero+qAbnv
         DBBR7Z2RMMjb4IXU/f+3mALUB02lj/AO0pO7XoA5p0CP00LvTOS3CJQenpV3/0QBjSna
         iJuiS3x24akWyilsGi6sWJNe8dP4MYk1WAtBnoajjQPf4U87lh+JDfYBtBnVWdWStHI5
         4o/yOfB+BryLlmVdU7Eit0c+txe37hF/iVQqp1AfdhYPbiGQA0oGHKVHpiEaqTGnIlJT
         fEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790891275; x=1791496075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KauvhA+qJPgpodeex7vmZyoN1DAskKF7lJ/Kn7XSSQM=;
        b=DawQ5jsprxre7em2B6ekd5eSzzSDlsj7xpf9VmduUDnUSNynEOsx3LnRqH4vnT71ot
         lrgAAOTgtuF8KHfBu+ErjdJHF0+Y/M3wg/e6WbXsni466CJ6jMC8TGXTObuRiX6bmXTM
         W5IpdpGu6ksJnrO1eTdxRjHo6KW40jlWvTVC+U9abH0o7B+l2AE/XKZJVikEMLJkzWq9
         8skWKvKPoE2SSk13gxeekvK1cwz7VoSmhPy08Zm5ETz6MEg0XuIdWytUkIG33DMnfDV7
         dypOw6tZl4YFW7ltSLmfO5sR7tKsZvUh18AdlJTxgdQFrKUH2XTybU7qI9oeEEf30w9I
         xyJA==
X-Gm-Message-State: AFq9FYIa1G8gCe1CKB97aTjd06YOQCnKbhskFX65y5v7vcnk0oJ+t215
	5QIVW8XfnSUhBc8o/81miTI11Hywj3bstrpUBRXgfBsp1l7OlpR0/ChhYkDHPxRHJhTahwGdFLh
	ZlIPSjwrOgCKSHNzelgF7l829oPNSNHPhU8T5IrtKBIJ6ThydpK5z4g==
X-Gm-Gg: AYBFou3GyfDKITFF6FSF4mGit+jYunWNNiyE9kpaiB5Z+DXKnZw3Wld4A9gZv9L1fMv
	99C657DDHrxmMHqFdw4PKLmO+nMwXhPzFsBxpja1v2W7umRxEakfNlhleNyJVY9BkZlH1AacQX7
	TnsaGqsR8JkDCGu89eemDB58Ze8wUC7/9tjEc69Jc++qgSN79SAJCesfUw8whMLNkj97YtMnnTQ
	Dkn4ZLdRSsRHu0vV5l2qXHWdROz8dumEd4X7iO3r6zk3kvCcB39tpNUPMYMGtvgAbM+ZDspoFSj
	Hh+kpOBdagNlAwP2edOn3F/uyR3fgl3b91ruVJldgxHASQ5ZltVMfNYSsGKZZM8cjrdTx3f+X8t
	MkHZ/pXU9NLw=
X-Received: by 2002:a17:90b:564e:b0:39e:6c69:9b8e with SMTP id
 98e67ed59e1d1-3a6cec99dc2mr726236a91.51.1790891274847; Thu, 01 Oct 2026
 14:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <619ddff49b82e8e494c96dc749c8c5114d6df07f.1790088067.git.rrobaina@redhat.com>
 <20260922193914.8B2931F00893@smtp.kernel.org>
In-Reply-To: <20260922193914.8B2931F00893@smtp.kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:47:43 -0400
X-Gm-Features: AclHuK_mIN0Kw-dk5gBcCPt6ok1Ynnrre-1UVDMSPHKzp364dhOZkLi8WzPdmFc
Message-ID: <CAHC9VhRn7BKVnOm5yOpNRxb+zkuz1GaOMUb9NXXd6Bg1kDzAhA@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm: pass pt_regs to audit_syscall_entry()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:39=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] arm/audit: audit bypass via ptrace syscall argument spoofing
> --
>
> commit 28f5bb87ea29cfbc21629b2a96c32dff55652268
> Author: Ricardo Robaina <rrobaina@redhat.com>
>
> arm: pass pt_regs to audit_syscall_entry()
>
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>
> > diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> > index ed7a2a87a6707..3c5d7fd733ec1 100644
> > --- a/arch/arm/kernel/ptrace.c
> > +++ b/arch/arm/kernel/ptrace.c
> > @@ -868,8 +868,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *=
regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, scno);
> >
> > -     audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r=
2,
> > -                         regs->ARM_r3);
> > +     audit_syscall_entry_regs(scno, regs);
>
> [Severity: High]
> Does this change introduce an audit bypass via ptrace syscall argument sp=
oofing?
>
> By switching to audit_syscall_entry_regs(), argument extraction is now
> delegated to syscall_get_arguments(), which reads the first syscall argum=
ent
> from regs->ARM_ORIG_r0:
>
> arch/arm/include/asm/syscall.h:syscall_get_arguments() {
>     ...
>     args[0] =3D regs->ARM_ORIG_r0;
>     ...
> }
>
> If a tracer intercepts execution using PTRACE_SYSCALL_ENTER and modifies
> the first syscall argument via PTRACE_POKEUSER on ARM_r0, regs->ARM_r0 ge=
ts
> updated but regs->ARM_ORIG_r0 remains unchanged.
>
> Because of this change, audit will now log the original argument from
> ARM_ORIG_r0. However, when execution resumes, the system call will execut=
e
> using the modified argument from ARM_r0.
>
> Could this allow a tracer to execute a modified payload while the audit
> subsystem logs a different, benign one?

From an audit perspective I guess one could make arguments for both
cases being correct.  In one case you are logging what the user
actually intended; in the other you are logging what is actually being
executed.  However, barring a deep dive into some requirement list, I
think the best thing to do is to match the current behavior.

--=20
paul-moore.com
