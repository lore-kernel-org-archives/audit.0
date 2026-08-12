Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6639466B75
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545611; cv=none; b=TQNbEHdAvaJf0vGUCMJYxVhM0mCH2yAAHGyy4Ng82j2OGGZrTqDDG4Yxaxcw+NmXB6vkGXYQAUSGVu9m5VMNyhqim6Sl42bm5Nrc/Oc+v/7iyugJ9TtR6M7g3OB8q+zr3rZge5J1Ier7JRgRgDW3tQ+nd0g1NRWpv7JeVRmiXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545611; c=relaxed/simple;
	bh=8CdK4aAIC7mcIHPIYzvtW/2HqSiJbn5alOoec8aFw74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSGIYblB5P6oiHa2U9IlUe8ZjVo5l5KaRRaLVm20LcN1t5/kv63lGpIktl4jhh0rt7QixxoUjqKpgT/x7re1DbXmOcFriRueZA74t0pC/KMtizeRHOoKnEanY2/kojV3nDJw8OwVcsWetzHIliYXKNKOGwIgkBLfoOmmejzWLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBYHQp0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBYHQp0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786545606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
	b=CBYHQp0NL36OpMxsWv3TPRSwLqDtX/nX/y9bSec8slG1Xqfn4NXkNhnRPbwlduMtFl07h4
	aRDKpj+MqWgPaMUbJ0ZteVPIa4B7ecLXSuYhVs5qZrlsB2dhjReZVvHngIoK0Ei7Ybg0yw
	//2KBCNON19CgAdcSt1YajePhsCK6x8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-2_qCjRd5N4iiae1YIjf6aw-1; Wed, 12 Aug 2026 10:40:04 -0400
X-MC-Unique: 2_qCjRd5N4iiae1YIjf6aw-1
X-Mimecast-MFC-AGG-ID: 2_qCjRd5N4iiae1YIjf6aw_1786545604
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15e555a164so112024866b.1
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 07:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786545603; x=1787150403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
        b=lBoO5k+vAI8Uf43hIN7dc6ccAxrg9s651+YFcZSWP7WopVGqkdDBMV662OfQCjkcJS
         HolWJnhMGdyHyesbBRERj8N7vk5IIQk37gXWe8V/3Zj/H/IsBxklvb/SyW0Vru+ydfsL
         l4AOYCprgAObRedbbqO03JON34SVlQwlNCajclpqVqZAk4G2mWoKL5brSH2oHbsMaBSx
         zVcWDgbJ+E+PW1qCJrL62Wbno0/KJ/+E1iRPT30aGwWbBaqU8alrPNqsnvGLNgdfZH+W
         mALtGxBrDq/aUNHT9SzH15ODN6VcYgscg7KHb3SznIivzt0Kl92rjPkm0jOVQ6/u++z3
         otSw==
X-Gm-Message-State: AOJu0YxZ95+STfNCx/WSvekoAMwzLb4z+2bf+rqvDhnmILKyu11dhUVb
	yK0eiX27mJG8dh14C3Hl8ATfTRQ3zBN3r7yBiv7trrvBaSwB3n8y8Jnsy1aNci3BnY1DLAJcxcy
	aQPBBGYNhDLy9f/nvMu3d56rMEHD2lKcHvfgV3vLw8QOart9Ojc0OwufKXD9IP9NzQebqinnSng
	hoIWOfe/5aaeztkB3gYH+pURWgV+0cC/Q=
X-Gm-Gg: AR+sD13qwbG4PygteIUx9DmAPovnyOwmwO6KjWaqqFNmhj7Q1iEqbAlPIFX9rF8g+Yp
	KwsT72lYMZC+aXT273xnkX4IKAAiVnYS0XRM4Kp1IrohMoV10VclANnS54UKieJjKFqiXmA0E4g
	abYnb+1ZonU94rcYwLn+SJ3gAGpRmazLJ/UBDDlkQJ/HUjoF/rXn2KmBIDjHi36Na5YWJic9ZFb
	BdWJYWs3auEQ6FSfOj8ZvPn3opOSySrP/ky6+trLwnk3ulYc7swibEnYZCoQLORaS/bgvtSCJ5e
	V8Y=
X-Received: by 2002:a17:907:d307:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c20f4ea80fcmr88400466b.0.1786545603493;
        Wed, 12 Aug 2026 07:40:03 -0700 (PDT)
X-Received: by 2002:a17:907:d307:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c20f4ea80fcmr88398566b.0.1786545603149; Wed, 12 Aug 2026
 07:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
In-Reply-To: <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 12 Aug 2026 11:39:52 -0300
X-Gm-Features: AUfX_mwnybZDq79vyvt9hciCVBXIFAsKZAAqavu-6vxhVBt7hiB0e3ibAcyYOVw
Message-ID: <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wpcdT1g9b2iJJCoubBgEguC-SFnfyOr28HVTrSLykNo_1786545604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the move_mount syscall
> > but does not capture the flags argument, creating an audit gap for
> > mount relocation operations.
> >
> > Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> > to move_mount(2). Pathnames and file descriptors are captured through
> > existing PATH records and SYSCALL record arguments.
> >
> >  ----
> >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ...
> >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> >  ----
> >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Dfc:=
00 ...
> >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  fs/namespace.c             |  3 +++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 13 +++++++++++++
> >  4 files changed, 27 insertions(+)
>

Thanks for reviewing this patch, Paul!

> This is because we only log the first four syscall parameters,
> correct?  To put this another way, if we logged all six syscall
> parameters this wouldn't be an issue, yes?

Yes, that's correct.

>
> I'm aware of the argument for only logging the first four parameters,
> but I've always thought it was a rather foolish decision.  Perhaps now
> is the time to spend to investigate adding those two missing
> parameters to the SYSCALL record so we don't have to worry about hacky
> workarounds like this (to be clear, I know this hacky workaround isn't
> your fault, you are just trying to make the best of a kludgy thing
> <g>).

I completely agree that's the right thing to do, and I'm happy to hear
that you'd be open to it.

I did a quick check and there are 100+ syscalls (~18% of the total)
with more than 4 arguments
 --around 67 of which pass audit-relevant scalars (flags, sizes,
modes) in the 5th or 6th position
that are currently lost.

I'll look into it. Please disregard this patch in the meantime.

>
> --
> paul-moore.com
>

-Ricardo

