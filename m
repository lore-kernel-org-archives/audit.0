Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4253A48D9
	for <audit@vger.kernel.org>; Thu,  2 Jul 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016367; cv=none; b=X+Ory6SMUK+D+Dtcy3sepGA1tPtgheeaTucZERwCirSMeZXdynHlNg+Pl/O1zpo668VUL2PddrzGWtzamKeA9nsJcBUPJk6M7DochVRmbR73YOtXauJbLTRu/8YLXxgpNysYaU3tZthLqw+942aY7MQ0l/mdps+8yfI1FDpsOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016367; c=relaxed/simple;
	bh=k3zMMG6gWNPcZ795bjevCnLIv26jTEXLOxfaLntXeWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZptDrliFL5FlNOY+2Wb2twWZVwkyaq4jDIYIRZXvR58tpCt2gRu1gn3/mf5pBoGvZxNrGhfoQ0jRht9Rj+zSPS5pYDMMfFzzmjXKV9PaU6QuXtep0nWE8FDMjg9MZ6ncqkNwY4kGV3duyf0QPjac7Ssbsj1DjaUGgZTXcv0y/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7JiZLQ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7JiZLQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783016365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
	b=Y7JiZLQ9m6RjiU4yKQqiOYuZtrNH5Kq57hI10B20srU6YQsZN4PYD7IN31CKqoN6kkeOay
	yCJf/8xgCgcMxUr+tvkYQ7i+SF0FfSq7iaMGsaktVbwbyNCThqo0TlQMlGo12hOwq/R5S4
	LX9EKXPHsFTDJROZZjWavdm+Wr20j28=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-V0C1D7tyOiSzNJAwelHENQ-1; Thu, 02 Jul 2026 14:19:24 -0400
X-MC-Unique: V0C1D7tyOiSzNJAwelHENQ-1
X-Mimecast-MFC-AGG-ID: V0C1D7tyOiSzNJAwelHENQ_1783016363
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c0b7b5536ddso172461066b.1
        for <audit@vger.kernel.org>; Thu, 02 Jul 2026 11:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783016363; x=1783621163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnE5UMGB7bIKe4dMgecSQwaH8m85iUChv9iFEZy7XRE=;
        b=sjOqLFiYe1INtA1a4Y+PmCSfVbTZqHmNFSwOXeBI+RD/zr3fRFmpcCZ0UZbsykbDkG
         u2qSzRphAP9usviETPAySfveLJoGFEN1a6aprjSG4stYJXoTYOYJu71Y7gVNcB1PSGRM
         ia4OWsPpfCuUrHJcWF5qCqLbme13Fxb0HXFy3TutmuJGjeakEY1hKBWVvcBhmiFl6Hxx
         kx9poOQNyovh8PqxO5c1+EkYux3jhXbY68iDEMsZXGRdSO7dT9yl55kA+kIgx7/RyuHw
         CCG/qTT5JJn+BWqde72++jP8VU7AUAdZo0GHSY2L8oUurNceSCAAUEY6KT3v53NiC3pM
         rv7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr2cJd4Ay/cb1/khVnumUHYxb2O5wpPcUSIID+7ScBeBkQNQTnCkXBBaCX1JR08zV+AQ6AS3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzikrFyTxIncz0Ju+fjnVsQOaEbMffDxm/VYpZwNXWbQ13bhJsC
	j/6adw51VvdvPb9B6wZjvxSqK5zpjUbXOrVn0AkoXh+lrnCxLZBOaos7u0MNMzV62IE1pO0zlqU
	wfojrMmIp2yRAseXcKx1S/DKxo40fvQtTqoVo5GdxoZr4MKDwrCLT9By38NiXWl3aDXNMBh6y1h
	ICy3X0duESHfyaJBflHj3GeWA4QbWfncc=
X-Gm-Gg: AfdE7cmhUxPFcZjBpGz4zQ4YVbMVE5tQQagNBm2Ch9VcwDvZYA8R4T0pJqMi/Fqa5Ay
	B+oCV+/N0s1V4uEtH+FLNJ6b15QpbYuoefSg0C8QbQeNCfRCq7rYzlctw8BuNGq5z0syAK9W3ts
	hfjTnL1WjIXISARdUCTxX0EaSNeiass4lrlGSqIg6xqIrCMScSMr+pTX0DGI1z9s21Ivc1oNgF1
	+oBZMtf7RR1AuQvjRgjdPFeJtusodyh/Gx3Nh+cqpWEF75s8Phh1PL1
X-Received: by 2002:a17:906:f8cf:b0:c12:34f0:f7bf with SMTP id a640c23a62f3a-c12ae798209mr222261966b.62.1783016362679;
        Thu, 02 Jul 2026 11:19:22 -0700 (PDT)
X-Received: by 2002:a17:906:f8cf:b0:c12:34f0:f7bf with SMTP id
 a640c23a62f3a-c12ae798209mr222260666b.62.1783016362196; Thu, 02 Jul 2026
 11:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com> <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com> <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org> <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
 <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org> <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
 <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 15:19:10 -0300
X-Gm-Features: AVVi8CfgJQQN8srCQcfoEeiecb8Fd_KUMFMpwzDJYWLdhmkZ5R5UO3-WcegNLlg
Message-ID: <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Paul Moore <paul@paul-moore.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hDpBkJiBD6dnbQrFzNMxoGQIHCpOnjd0HM4WRD0jX6E_1783016363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> > Current remaining issue:
> >
> > 1. amcast_joinpart
> > ------------------
> > Still fails due to a missing Perl dependency:
> >
> >      Can't locate Socket/Netlink.pm in @INC
> >
> > I searched the configured repositories and could not find a package
> > providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le syst=
em.
> >
> > Latest run summary:
> >
> > amcast_joinpart/test ................. Can't locate Socket/Netlink.pm i=
n
> > @INC (you may need to install the Socket::Netlink module) (@INC entries
> > checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> > /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> > /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> > BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> > amcast_joinpart/test ................. Dubious, test returned 2 (wstat
> > 512, 0x200)
> > Failed 7/7 subtests
> > backlog_wait_time_actual_reset/test .. ok
> > bpf/test ............................. ok
> > exec_execve/test ..................... ok
> > exec_name/test ....................... ok
> > fanotify/test ........................ ok
> > field_compare/test ................... ok
> > file_create/test ..................... ok
> > file_delete/test ..................... ok
> > file_permission/test ................. ok
> > file_rename/test ..................... ok
> > filter_exclude/test .................. ok
> > filter_exit/test ..................... ok
> > filter_saddr_fam/test ................ ok
> > filter_sessionid/test ................ ok
> > io_uring/test ........................ ok
> > login_tty/test ....................... ok
> > lost_reset/test ...................... ok
> > netfilter_pkt/test ................... ok
> > signal/test .......................... ok
> > syscalls_file/test ................... ok
> > syscall_module/test .................. ok
> > time_change/test ..................... ok
> > user_msg/test ........................ ok
> >
> > All tests now pass except amcast_joinpart, which is blocked by the
> > missing Socket::Netlink Perl module.
> >
> > Please let me know if there is a recommended package source for
> > Socket::Netlink on EL10 ppc64le.
>
> Thanks for following up on this Venkat.
>
> I'm adding your colleague Ricardo from the RH side of the house.
> Ricardo is very familiar with audit and should be able to help you
> with missing RHEL packages.

Thanks for looping me in,  Paul!

Venkat, unfortunately, perl-Socket-Netlink is not packaged for RHEL-10
ppc64le. An alternative is to use CPAN[1] to install the
Socket::Netlink Perl module.

 # dnf install cpan
 # cpan App::cpanminus
 # cpanm Socket::Netlink

I'll reserve a ppc64le machine and run the tests locally as well. I'll
share the results shortly.

[1] https://www.cpan.org/modules/INSTALL.html


>
> --
> paul-moore.com
>

