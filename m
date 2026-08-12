Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279336D4FC
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550762; cv=pass; b=GpkMRptPF3V4EuKd7y6FpXP55D7k+WqaQIgjSrHWCi+P7SIvHd5Vj0DhM3A9Om4lTM9fZs7koTqpQaeH3GihV3P9ekgnQ9QMVvNJsawDYMt61arglCk+AwrWzRXvKvWNl2XSPtF9c2zrlWPgFpCEvJxdwjQHiwdNNqPDD5xSXxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550762; c=relaxed/simple;
	bh=pDkaf92aGIzW2nURaj6jT8tYViv87t0+zoEW+ew11LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oah7lP5dWiaBemjurvCfbJGGAhwQRiJ4Fgid+Obm+HIdTZa1BCXcIfNTaeN3MRNPJPzm1m6neSqWs9vEWmCRkdx1VkW2wgyLWT9mv03d2p+y7ZUTY/sHXkbdFuZS+E0gdJe0SmpNlI8q7zL6SK45gbeqLU+4k4f7M6oFDL+ddNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LSNlgRR+; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LSNlgRR+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so944313a12.1
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 09:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550758; cv=none;
        d=google.com; s=arc-20260327;
        b=EDk2tIcQdS7HjFCUvcw63JIPG6xiVGL5UEwSAMGyL9hH7brSCp4d0xnFvRMRmE0n2a
         EgKnXWSxyzOszDwXCSGKnyK80BGYykfZc8Rvyflu0VhgiB31ihXxLftt5N0g5GHyhSdA
         OsKvHGM/jgAYunio8Y9s2FYZ67qeooJpKYX61FKT0kb+Lo8+CVuwhQ12lfjyeYnys+L3
         3kNrcbGPxb9vSK3w7xnY15JI5nkexnuESCC5u3vR7JHLL2Q+babzzXvNtxIKAw7KwK0v
         LNQeTbMADvsut7IEfB+l1INchL86d+Ep2i/Sfoqhr0bTL26I3aFoIE64ZGXvtUDsWQVV
         Ve5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        fh=9pUABXgHunuX9GLTru/cvvqMLUyUyFEIINspPGgCMl0=;
        b=YIGdKRPVxX5Uj+lxhPwK00N1AOeKU+H8tbSwrozU506mPOOD/NCuyYAwzPpoS4O2uP
         6O7jVxjSxNztHclrzczjOWqeeKKRn+GEn2OOZPj5cqDRHW1I+iBL4GtClbC6uFeRzkU9
         FmsXIOYMTefiOZ7i2hKevFZDfcUa0fz2ZFtRvGUlfdbvhjLioxhoKTQlnHgyEkZa/MC4
         Wf/KteUyuljlIh4C0C9b35nu+a4riLbq+eCDmumO2iJajv2NsfM7fU+qquVINTv9Vjuy
         q8okIo1zFjt5dYhH7I2aAd57KcG7D8rmMpU8BwsF3/ol1T1xEGvA6HnkvEdlqTFoTnEm
         7dVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786550758; x=1787155558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        b=LSNlgRR+eELM3xwyi2MCH1ZQ3d+PiHt8iTM9jZgs8Y/oQPqKy7QREcovkLQGQobfmf
         UIZqVTvQU+nfUdcqxoUoe0RP/Ah08pqNvZwevohX3KIn+lf3OrO1xfsvLtsnxfn5yM6K
         GOV3+y41+zjujdNOEQFj/ad9A+//KkAeSTIeLJ8hCoZhHt3Pk2tLAGJdXF8EFIAeXPhR
         sgpqk6/jf+SfHP3BiS9aNULlIOpnToI7F9gz5WIOSJChrUKmU0zfliwpeE96XrgtOoNv
         hiYgACLjgN7u2OK6scw3PV5ZIFOpMqUz/CQdC7WnwHYUtagVp/umFHohfDZivt4dPQw8
         wAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550758; x=1787155558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        b=qdA0QK9sOjDrTDAutICBu36A8wWJwX8stvSKo/Zckz+CpfnXgRD3884H6M8Jdjj1VD
         bffwXcIJnQ7dhwFmzj1evjPT5+MPT6hN+SepZ2q4OqFRyF067wWKO8XdPO19Itifum8N
         UmL8Ty2zC1inuvLgGGbhenO0RsLJA4K9ns1XQKbsus/n1N8UPGxr5qxFf6XD/f9MuBPQ
         Gxis9hbUL7/V4VxJghHyqhLrUg2fNwV8xKpdLabSntm8ye3vL82FPE4t/71ZgKtZ0HFn
         eJ3F3E8PEDGl1oQzhh1ORdllx7f1Fzx7MugE4nO3HTeYb42S3505/ONrfsEmU4mOCBFz
         pZ2w==
X-Forwarded-Encrypted: i=1; AHgh+RqYjLGlUOQEbVKJjTsXVQkb5y+ENsRhr7pSAAcyEo756sC2PTCs8k6YY+ZUw/iEZYec/dZ71g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2J88U/PE6LFMXKdmEBLEHQ9FsxH2UNo/7lmlQ+u6GlRtCJhBH
	vaEsyTQKYEUO2i+Jm2dHulVjT5VI72ooPiou31fPco8uRjvFcxESKMG1ku4fq46URNpmO0n3hk3
	lGtT+t7m4ZlaVVRh/5huNxQDki8S13rpyv79zgQeZ
X-Gm-Gg: AR+sD12wv/M0xgUCVAWbGejm3ukDej94GoMjoruAeUK59Crn/fWUScGMLbm8m9PlMT6
	+Tg+eeZIqgZe5WDYXsWLACUhd47IUjfquFqhJK0MEDpBXjgjoUn8SRN9c26tdSjD83hwMWFuEnz
	8QgHP5PUiiJPOUt594F/flQmcpHSzkyRZR/gX4a/7AP1VqV//iOXQcl8fykuQJIrv0A/0gkpX+A
	98lA7N+gPac5i5HrpZJkzHGHf/oIoS7gfhLIvi2cVlS0oY3H2V/YT2C7ZvmDv+ukFSSaVg/pDud
	sZHPt4oVX0NK1PdnBbaKCj+fXWIX04ZtTDWItWsN9JAExidaS7OUXRvm
X-Received: by 2002:a05:6a20:3ca7:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3cc3f5e505cmr7352750637.11.1786550758430; Wed, 12 Aug 2026
 09:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com> <P3A-8ZIRRiqomtqZCupr6w@redhat.com>
In-Reply-To: <P3A-8ZIRRiqomtqZCupr6w@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 12:05:44 -0400
X-Gm-Features: AUfX_mwgqsR9fwt6Rz0lG5XrNmGm9lUL84hkqCi-TwUMbW5pAP1usk0PPwndJY8
Message-ID: <CAHC9VhTDsVZPfu9ZNDge+fbRLr1c4EFPKi_E8R7+N9wfvL9n5g@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 12:01=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Wednesday, August 12, 2026 10:39:52=E2=80=AFAM Eastern Daylight Time R=
icardo
> Robaina wrote:
> > On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com>
> wrote:
> > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount=
(2)
> > > > syscall. The generic SYSCALL audit record logs the move_mount sysca=
ll
> > > > but does not capture the flags argument, creating an audit gap for
> > > > mount relocation operations.
> > > >
> > > > Add a MOVE_MOUNT auxiliary record that logs the flags argument pass=
ed
> > > > to move_mount(2). Pathnames and file descriptors are captured throu=
gh
> > > > existing PATH records and SYSCALL record arguments.
> > > >
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 =
...
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=
=3Dfc:00 ...
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > ---
> > > >
> > > >  fs/namespace.c             |  3 +++
> > > >  include/linux/audit.h      | 10 ++++++++++
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/auditsc.c           | 13 +++++++++++++
> > > >  4 files changed, 27 insertions(+)
> >
> > Thanks for reviewing this patch, Paul!
> >
> > > This is because we only log the first four syscall parameters,
> > > correct?  To put this another way, if we logged all six syscall
> > > parameters this wouldn't be an issue, yes?
> >
> > Yes, that's correct.
>
> I've been aiming to reply to this and lost the original...in the case of
> mmap, yes. If we had just 5 of the passed values, we would not need a
> supplemental record just to record the fd.
>
> However, in many other syscalls, we only have pointers. Sometimes syscall=
s
> are designed to pass a structure with config items where some are securit=
y
> relevant. In those cases having all the args doesn't help and we still ne=
ed
> the supplemental record.

True, but that is independent of logging all of the syscall
parameters.  In my opinion only logging the first four was a terrible
mistake (I know you disagree Steve) and I'd just assume we correct
that before we add an auxiliary record.

--=20
paul-moore.com
