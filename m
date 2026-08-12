Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10412D3ED1
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550611; cv=pass; b=eKFkgwGB6PPnx8vZIv7bWZBGGN9r3cKxB6eAOjJ70xz/tT3raxN4kgdAIl0OMaatUUu8o3uWgSJQqjKmavoI7smRFaJXwU67/kPbY/FanXukIA8fEZgR13RrIUzYDbvyg2lx3FxGcZsU2guNPt1/nR+lJs3tW5oSAD4zri02WHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550611; c=relaxed/simple;
	bh=wNpezxtdDBl5EMOT+ytifcvWFeQIqun78MxlgqImMO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thX7Om+qWLpbpvsNW0SE/a325a3Ar7YUKZW42skpp+8C+kn0Yc+QC+y/lAgNLZaDM/hSzvnYzZAqeQwr6q7COzej6TYnkO/4DcFDrVqafLy1nMaEbeHE6EX7XP4UhJR7C0lzc1NQLDmOJqtrnf2v3tIDBFMxBFDSxORCSdA6uFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OYqVV0qQ; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OYqVV0qQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso485585ad.0
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 09:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550609; cv=none;
        d=google.com; s=arc-20260327;
        b=NummRbIV3fYYuGYVWoyBAlPlPCTmYovlwZrFinx6/7l/D3v6UuD1BXRozuf49Gr47a
         gpTYhycDCwsAyc0GDB9/ukkDsdOt+T07yFdyjSXduJadniMHyuAzixdseLcgOjhB0AJu
         E+5idn0efObC5N3bwr7nTEQV8E+vW2IIJfVB5Y7E0xaA8bahUSfwsiA7bQdewT6mcfNY
         s0SQQZIcJvcBb+2eS+DI3OypsvmG71Dxk9zRaYbaURGBNoopf38pCCUB8H/g7VC9UhdS
         kGN6roSc+rOMyuGwbzWGsMMFIRp+3IC12KqOkkv4chHNNybtyQ6RJs80db2ZANJKQJRi
         z8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        fh=jjH9/+6AI5FxNTcvHAVP3MEWUOLgVUeKiYC4YCD4GxM=;
        b=YIfZbRk2g4vyeLVZ0g/jpvc5h7Cjj+YTJ8hcgNvG6BGOJwH3NKArp082s76v4EpWAD
         xTTWoCV0Nzd5QZswmT/EixFLDGvzpmqUY7aiMDnuGbH1CFn+LKf5u/tVPHgEtOZczZOr
         c7SpmOSUpgmQFboXW+/LTWzggr973VYOZIEG151x68queZsgFx1Fe5zLGUneq1muezME
         zmLyjmrhOS3AqeKaKbQCxZlH39nd6/kdg3QEDMlg/fHFgWiGwWij4e9OYYResxqadstN
         mbeyOM1/VvPKYH5fSQJmQa1Q3nGL71EPIdBOomJfbCkWUB9v6atAGWBWSRNPB5iSS0Oe
         wZsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786550609; x=1787155409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        b=OYqVV0qQ1u0RsI1r0WtypvQaogHXDibndO9Ju2W15WB/2Fdo57H1C6hevJRBA0YPF8
         v6hc1nofIk0pv4Doiv+sccvLjtFho0FIqhtZcSKc0FvNpKKULhV+zGYOyFWfS/LMuKSH
         lSlTCyYp+B9R95XGFvm82t4Yh5mZLkE7Bbb63fRi2lpGvDCGyoqXkGHWPiyMEWq9q2Gg
         iYB53dO5LkiNBBztjun4uIAxVcDXnSXfIQloE+xyvAoHMthCP0w6DuMN0NIWhn+OgdpC
         PlHJVD1CewTrTNhSHc7FddYI+U0jhF41Q/qnWO4bw3vfHY66AbUmQc3c7Qc6KZwRmGXc
         uxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550609; x=1787155409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        b=pb6ZwH2hLlKOztbbfBBfwNVs+cksAc2NCoDAebhmPNLCCjLQwqbxWAMCFHo/xc6/r2
         zW6vI1xU+iC+nmu60XU8LKRRx1JFwgGlVEvAjW0KnQvdKAzOXHMTPIPjzdyw8wPvGvOv
         wvUb/UTsRdPczWEUDOwrt5XI9Ae2DwukNrlvVs7tS4TJJh8uC1+UkVte7snBGoBMusaI
         lQfe6elUNXTOuqJUGPruXReD0PfoviMSb7Diml8dqaZeWWvS+XM7sQ4FSqwOK68mLtwM
         QShBR+UDh591RNtmNgFUnXmj+8Xu54DDEEDGC80cR18a/q6wWtV5vQZkwKLjFUHQK4ed
         nWRg==
X-Gm-Message-State: AOJu0YwcQGN06CiqwD+DBbzp/sIfCwoVV/3h4bYRLNgYMy+Oi6Ls7dXy
	iJ2I5xJIaVUwIViLXmSgVOA/m/8EFK6ftloilmwFYwHxieNN2SFGWAiP3Gpz5Tf7ZgBDzKMDbf2
	XPGaRTbBXECu4qJf6epSL3190rrT9RtHXDNuA6ryQ
X-Gm-Gg: AR+sD11Wun+lS5u3CAEHPs6ypLInQtGSz83iWKzgAaGNgMwWUH771v6zViHprjSGOpt
	QMnhVDWHFc8mbKOZe4Qx+105C4G66SDGQyfP7v8m74Ghp3z/JQZ48MT4d1hKxmRkt7xgDo5uilf
	14nrPMzjIm1WDa4Fep7K2sHUWi+G0emCsCm06XaLZVwbDgTPobwslg0opBTTKWzd5ebwDZH84ly
	U3dxbA2HhNBN8mlXL5dxNRql7A+BBaW+2Z3y/NN2CyaZAWKPOYpDIc9JXUd8NFEQMIdLpxJsQSH
	wB280N6GxAO7xOHcwYmLaz59Htdt5C2kh8n7bj66J4+FsA==
X-Received: by 2002:a17:903:1d2:b0:2cf:b9f9:18bb with SMTP id
 d9443c01a7336-2d371d22985mr1478265ad.4.1786550609193; Wed, 12 Aug 2026
 09:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
In-Reply-To: <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 12:03:17 -0400
X-Gm-Features: AUfX_mwiwqszCAmetnigrG5TMa1Btha161pB3d_JtGdcMZO3xyeWXyv7fX211o4
Message-ID: <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:40=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > >
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the move_mount syscall
> > > but does not capture the flags argument, creating an audit gap for
> > > mount relocation operations.
> > >
> > > Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> > > to move_mount(2). Pathnames and file descriptors are captured through
> > > existing PATH records and SYSCALL record arguments.
> > >
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ..=
.
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Df=
c:00 ...
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > >  fs/namespace.c             |  3 +++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 13 +++++++++++++
> > >  4 files changed, 27 insertions(+)
> >
>
> Thanks for reviewing this patch, Paul!
>
> > This is because we only log the first four syscall parameters,
> > correct?  To put this another way, if we logged all six syscall
> > parameters this wouldn't be an issue, yes?
>
> Yes, that's correct.
>
> > I'm aware of the argument for only logging the first four parameters,
> > but I've always thought it was a rather foolish decision.  Perhaps now
> > is the time to spend to investigate adding those two missing
> > parameters to the SYSCALL record so we don't have to worry about hacky
> > workarounds like this (to be clear, I know this hacky workaround isn't
> > your fault, you are just trying to make the best of a kludgy thing
> > <g>).
>
> I completely agree that's the right thing to do, and I'm happy to hear
> that you'd be open to it.
>
> I did a quick check and there are 100+ syscalls (~18% of the total)
> with more than 4 arguments
>  --around 67 of which pass audit-relevant scalars (flags, sizes,
> modes) in the 5th or 6th position
> that are currently lost.
>
> I'll look into it. Please disregard this patch in the meantime.

Thanks Ricardo, I think this would be a great improvement!

I'm particularly curious to see what old/existing userspace tooling
will do if we add the last two syscall arguments immediately after the
first four.  If we have to we can add them to the end, but if it
doesn't break anything it would be preferable to add them inline with
the other parameters.

--=20
paul-moore.com
