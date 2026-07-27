Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F322126D
	for <audit@vger.kernel.org>; Mon, 27 Jul 2026 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182891; cv=none; b=lDIn3WGyzzf3GgKJpMk/IQXFIIORClquHBL0eVdwUmSxtp/qfopzf+XujtjzgewfoOqrSltVkx6MSKXZOjuq1aQ+BUXh5VIzI96Pk2GoB61cuS/mOpKeb1Z5nfjfa+pp1oc4V1bkBsZJWMTEOV27XMyPWzgM/mhtKgi6K7w9k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182891; c=relaxed/simple;
	bh=IEeItfSVZnjLDouC7mquubtiGJSyH79nUKm8P9Oit/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG4TS2vfWYuBelcbY7ij8P0tQfsxIi/Q/8+NICq0EK5/cHmw28+e+mlka0BodE9ywjaNvOY+cAaUjrn61ZHIlcLezBWqx7SBtc8p6zRmbVfo7rCjvm45ICj/7KyMva7JYNZYupSl6cinCZczKtNCdHjEqclcrXBt5Esx+FwizeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtZ3Y+8d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtZ3Y+8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785182888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OA8h4pw8+ej+UC0CVTk2+9UXdfyz7/4FaQLoauFtcbw=;
	b=LtZ3Y+8d+L+6uw1UqE/tmahabrRuEgw1mJFmydx5Fo9xEX8BO+WfqsAyxpdyA82zKTVmZq
	rhALGQZ0o6T2vKfpOtum3ULbtJc6RnVa+y2elLQrWT4HQuAxLhFmnhGLhL4IQ6vaR/vZ6s
	X0NHds1f+IbgHbRuWnyjR1NkXfmOqQk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-7BddwQVCMJydjmvO7oqhpw-1; Mon, 27 Jul 2026 16:08:07 -0400
X-MC-Unique: 7BddwQVCMJydjmvO7oqhpw-1
X-Mimecast-MFC-AGG-ID: 7BddwQVCMJydjmvO7oqhpw_1785182886
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1686e23b9cso262246166b.0
        for <audit@vger.kernel.org>; Mon, 27 Jul 2026 13:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182886; x=1785787686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OA8h4pw8+ej+UC0CVTk2+9UXdfyz7/4FaQLoauFtcbw=;
        b=Juvo+P4+zjQ33b8Izxcd90NOkgPdp9/rz4rF2UnlsI+y6q5T6eX3RxZPQSDO/tbT3z
         fLSnTPLH00FDMonEJ/bea3RZV537rCpWwbgVIoc8D2kLy5WWVLdFJ+RCC+OsMPBRV7GX
         DyesUOHPRGCmC2/X+g2V3YCEtpBmUAxVuqhIF4w2fVNpv3Gxl3RYYhMe6zzcEJfOZcEw
         wfqS0MGxvVRI4lzcbsk9MVXHXb+l8dJeX+PMvEFUgkd1RYNvyZLBPAcuWJg5HBYWRies
         PjrDVHn7CEjjgmVMji4twOoZb5S1Q7NhPPWxEio+tWoXIkZdWh/BmSFb7zVgl1J6m4Qu
         0UWg==
X-Gm-Message-State: AOJu0YxQqeGNEY9PUHDudjBj8hyaPGmYi3BBzC55OFxHlZj0jAtT8uEY
	DHoTaTzeMQnRbyM+zfc46xzEG6zmwOxgwUWNMM3EmpokFdQ3p+glCIDuPzfqSwpuAd/cZg5W1eJ
	Y34RP+cCXChm4668JP6JEajZSKOl8az9rmydJD8vxuB0uHtJhXGWv8TsBx5R19JGBvzspyTQvJM
	I05XQVss1CKvLte7fzniE5IR7xIJmngIs=
X-Gm-Gg: AR+sD13bDepeDUEVXF0xDLdv4icMAc7p391Us2dB07wqyVhccJIjb273nmcjqlmsSSb
	DdkI0cGnzJTiPoJ05nlYwEwkB1ooyaFjYaaCvB8oWpj1pOxKAW5vBntgfZ9QJxPw/UfHJa30Ztn
	3ptQK7pnlLLr5GMEsYmfnDCsMQoLUfzMBlKzG8ID/bX7tAROSaBZsbGQNwzrNaVObmR+xunhyTo
	oUjW47EhvdYvPY0av01O5aWTgtyaLWaCnaAj+PwozMsUi0MP7usWzVfYUI0sba9FhJLWM03NBoW
	K70=
X-Received: by 2002:a17:907:d303:b0:c0c:3ae4:a7a9 with SMTP id a640c23a62f3a-c1f6905cbcamr22533766b.24.1785182886224;
        Mon, 27 Jul 2026 13:08:06 -0700 (PDT)
X-Received: by 2002:a17:907:d303:b0:c0c:3ae4:a7a9 with SMTP id
 a640c23a62f3a-c1f6905cbcamr22532466b.24.1785182885756; Mon, 27 Jul 2026
 13:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630195242.367870-2-paul@paul-moore.com> <CAABTaaCG9xrLXsYoAx9QD85t8xkpveMXi_sBndz-7mbCmpZgBw@mail.gmail.com>
 <CAHC9VhQJicGZY_xAAQgD7jOC5qFAgqAYiw5q906ZHzTY4v+SKA@mail.gmail.com>
In-Reply-To: <CAHC9VhQJicGZY_xAAQgD7jOC5qFAgqAYiw5q906ZHzTY4v+SKA@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 27 Jul 2026 17:07:54 -0300
X-Gm-Features: AUfX_mw9_ouxxUc2DjjcvdsEffyhpKgE2VR35OQOhnSMZ-yew7s-GC3kXHtgLV4
Message-ID: <CAABTaaAMtUn5yxSGVa1LsCx1Hf=7ei7b3s0cPscN=G7gRoAhDw@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: drop BUG_ON() from audit_log_XXX()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WF7dVpvf-Zr9DJ4eHRN282EHoFFO4xKY6WcR2Sj06XI_1785182886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 1, 2026 at 9:20=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> > On Tue, Jun 30, 2026 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > We can easily drop the BUG_ON()s from the audit_log_XXX() helpers and
> > > simply return to the caller as we do if we are passed a NULL
> > > audit_buffer.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  kernel/audit.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
>
> ...
>
> > Hi Paul,
> >
> > It looks good to me. I agree that it was not worth panicking the
> > kernel in these cases.
> > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
>
> Thanks for taking a look.  As an FYI, I'm dropping this patch as I'm
> folding it into a larger patchset that I'll post as soon as I have a
> chance to test it.  While looking at the overflow checks in the
> logging functions I was "inspired" to fix a number of related problems
> this afternoon and this BUG_ON fix fit well with the new patchset.
>
> > I was taking a look at other BUG_ON instances and noticed a couple
> > that might benefit from similar treatment:
> >
> >   1. In audit_add_to_parent() at kernel/audit_watch.c:375:
> >      BUG_ON(!mutex_is_locked(&audit_filter_mutex));
> >
> >      Couldn't we use lockdep_assert_held() instead?
>
> I believe so.  Nice catch :)
>
> >   2. In __audit_log_bprm_fcaps() at kernel/auditsc.c:2715:
> >      BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS);
> >
> >      This could gracefully return an error instead of panicking.
>
> I'm assuming you meant audit_signal_info_syscall()?  If so, yes, this
> would be another good improvement.

You're right, I meant audit_signal_info_syscall(). I'll prepare a
patch series addressing both cases, then. Thanks, Paul.

>
> > I can send patches for these if you think they're worthwhile.
>
> That would be great, thanks!
>
> --
> paul-moore.com
>

-Ricardo

