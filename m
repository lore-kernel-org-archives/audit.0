Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169104FC8E6
	for <audit@vger.kernel.org>; Tue, 13 Oct 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895259; cv=none; b=EPSk1otENJKEa8SaLeT7uMXPkiNymbvSEAyhR3uvg9oeXHAM4kLah6mbQmp/gGPrufnWSGSBVjYAomOPYRVjZLWJnGXwtu1+r6qmAt8vkyqP3P4Xel9auR70K1syuIxULDHNwriA8NtOS4e0wY6g21X6WjochsGCYTufR/ms/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895259; c=relaxed/simple;
	bh=+6HbdvXz6pDwyHoZBHfAtbCp8mco+tVTkhaG46/uc+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdppTYEEQB/Zv1wVWDmRXJPe859T8idc3WZMqb0U0jiDeRuFofzfesQFIDnaIHA18HZJQADKq8DU59EkuRVIKYVtfLMlA+ctPAb1qNf3TBpRTBxU3pkhsHwd0x8gyKpIt/ICqplhWWDMixr/DBNNGvU5adIKIVlJG2qv3xSCVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX7cpyuY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX7cpyuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791895257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
	b=eX7cpyuYU+800b53xk5/JJvs4mNy3MZpdkXj6YIC+IAX2xZclxRr52d0zQIWVOB3csDtAq
	jzyYNBKJIWLON9EFsiUuUa9+TIQKFWIjpVWfNI+ziU38uW1jBnXAfcLHegG0yVXcUVQy6t
	Kle4h9EUeLii6ZckMl+9rSabH/pkndA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-PE1yZISiMNuULdNAvqoX1Q-1; Tue, 13 Oct 2026 12:40:55 +0000
X-MC-Unique: PE1yZISiMNuULdNAvqoX1Q-1
X-Mimecast-MFC-AGG-ID: PE1yZISiMNuULdNAvqoX1Q_1791895255
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2942fa0995so305722366b.1
        for <audit@vger.kernel.org>; Tue, 13 Oct 2026 05:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895255; x=1792500055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VPWzp7oBCAkGHJlAcxMxO63noDeryK10tEP324EHX0=;
        b=Jo0NF6/nLALNiKB81cZeWl2CowNLmmXFLabjm8GYmZxm7xzcYvVt9q1wVIwxKx52f0
         wl2g+jElyYz0Cwavgr7iA0oSR2dGhoMKY9YzGfWTu7q6AW18nzpkR9meEJp2DRlsFB4m
         FuyWKvOWjXSONohKGdbkB0niIoj3jVZcV+t+noTJOOOkt5XK/FIkXckE7eT6rKEDhbgR
         SaUehY22kJjKQP2yByluQi5pvPZFoYH1qk+inTIs7G9fgoseTUNoN0t26XNA+u9HqNs2
         O9mJidtY/EdFxAzi3+IK/l6OmRL4u+60EXrh+HyW+2Y/ZRVBf5yYIKYQ7In4qJHJ6gvp
         Mj8w==
X-Forwarded-Encrypted: i=1; AKwUvBy4Aic6n0UyMFaoiuMNQumpZlUxoP12kfu/xz2IYD97HkjhOI6A25yic4i+AWKq1L3rpttdqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+fu0tg+1aQO3R+4dM+H7w2SKjKkmRfLNrgc/NbzMSYM0WkSM9
	32PIQVQ49WWVyIV8ref4ioRzIjhypXu3VIYn/Y8zmLrM7EsUfnwx/y4uv1RKe3UKEaEUwioYIQ1
	PZYA9pnQ25E0Z8JHQ1ebtgRE8FNSyvTi7EJ6tHq6t2DrJzXt4+sKniPORBI8QoNTTDWVuUscZeC
	wIU1jomKStIm/BjO+hROFUuEamYe4MWfA=
X-Gm-Gg: AYBFou1u8OHYpDtCS0USyZWz2B37KoM6WqiNNIkJIeGIOHZBbSH9KLECxLRzGpLXIBf
	dFKPSR+0HqIG7DUyZtDcD6XKpp49UKtdWH4S9yb0ZJevuP4vy7vd8OSgsQOXUdrO3npTQGoWT/Q
	2IwFXCxv/j1fixFnWHKp1yRtnTkQsnbaxpX434LhuxZ8ZX9iURt0I/MnX7L4jYWy6Xu/UAr0BAc
	7m7dgLpmWvFy2U9+yy9ZJlokDSH8SiHZmVHouT5DpZAuUjaL29ZTceYYMNprPhWq0PItBFryRKt
	J3s=
X-Received: by 2002:a17:907:e00e:10b0:c33:923b:ad66 with SMTP id a640c23a62f3a-c33923bd1damr460789966b.43.1791895254788;
        Tue, 13 Oct 2026 05:40:54 -0700 (PDT)
X-Received: by 2002:a17:907:e00e:10b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c33923bd1damr460788666b.43.1791895254469; Tue, 13 Oct 2026
 05:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
 <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:40:42 -0300
X-Gm-Features: AclHuK_BqgHG9szdxsfF_J8_QomlYVv7uojh01Rda0mXNc18M6GONX950OFpYpA
Message-ID: <CAABTaaCj2Bap_w7mESYhPgT1njd1rQh6kB0HFnnSiMW40SCNUQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: viafmvfFTftJyKBA3mwnL0fXG5rkOZXqtJC3qx2blyw_1791895255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 10:18=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Jul 14, 2026 at 3:33=E2=80=AFPM Richard Guy Briggs <rgb@redhat.co=
m> wrote:
> > On 2026-07-03 09:25, Ricardo Robaina wrote:
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > > does not capture the filesystem name string, creating an audit gap fo=
r
> > > filesystem mount operations.
> > >
> > > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > > name string passed to fsopen(2).
> > >
> > >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN=
_CLOEXEC
> > >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> >
> > Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > > ---
> > > Changes in v2:
> > > - Better placement of audit_log_fsopen() call to avoid UAF.
> > >
> > >  fs/fsopen.c                |  3 +++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 13 +++++++++++++
> > >  4 files changed, 27 insertions(+)
>
> My apologies, this patch fell between the cracks, but it looks good to me=
.
>
> As this patch touches both the audit and VFS code, I've merged this
> via a topic branch in the audit tree, topic-7.3-audit_fsopen.  The
> branch will remain static and it will be included in the audit/next
> branch as well as the audit PR for the upcoming merge window.
>
> --
> paul-moore.com
>

Thanks, Paul!

-Ricardo

