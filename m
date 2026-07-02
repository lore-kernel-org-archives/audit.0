Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981233F37A
	for <audit@vger.kernel.org>; Thu,  2 Jul 2026 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032588; cv=none; b=hWqaKbE2lA5w6csOg4d35ZNd1SNXDFs7usHT0nZmYMDDZUGhRNmQ4f4bvuhSxtzYO9rNAJsTL83fKtkSnesjeo23YHjz95idcw5ZjgcXbxxOctvWg/K04D7g8/PYXHQOaWzsD/EWTrEWxN17X08sPmKEyou13Ei5eNjwbWx55TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032588; c=relaxed/simple;
	bh=sAsjX1yf2x3NOfvmUwODaHPLlEZLRw4IomwzC3UHbC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoY2MbXmDBv4+z5JBJcR4RnWJnrL2uGL5QD+2vdD6IJzmh/QHLGsJziwFuGRcBFLc3BAqx84wYp7dv1cOgGOsBiUEl/5ieVKZcpBTE/PW1lJ6vn3Cpk3COhAk9WK11BC1CPJTuaFtMhPq5xaf5btH0tiUUhlqUWEOgH+7DlSlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCn7wiI6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCn7wiI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783032585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
	b=bCn7wiI6X2aSuEPxlMyH1u3nkwCMcBMrTvwZdYQ5KjIFDRCbAC0D9blWET2TjNrZbxTcd1
	d3HgoWOuJ2ygoHIIQrgCO6OrYDbKgmJPuz5b3t1ZCHhEsZ4YsZNNE2HbnfQASr3Hq9uVy7
	dpJ+4WkW87OtPJxjAJYnKzLBK79ho68=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-9MK1iQpaPmelrCDzxb3OFQ-1; Thu, 02 Jul 2026 18:49:44 -0400
X-MC-Unique: 9MK1iQpaPmelrCDzxb3OFQ-1
X-Mimecast-MFC-AGG-ID: 9MK1iQpaPmelrCDzxb3OFQ_1783032583
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1260766980so240784766b.2
        for <audit@vger.kernel.org>; Thu, 02 Jul 2026 15:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032583; x=1783637383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/2hym407OvJVwtz5j16/UTy0OY66ylRy9CZIkkSmIE=;
        b=p7k4whf6jFm9SVGQLAEJN6s6A+0raRtUFGSn14xpxan6jXOFf9OZOVqmp5boUvoTFK
         XZukHFYB+xGxZ7t/U5FG2TpjNjl+BkzTSWg2oPKUKSBXOAnJjvUBsC6jwv8sccjSUwU6
         OAgzv+MR4Zi0DayECc67x/45hIBLox0lF+WLx2Be3GXhk8lg4OpZsmQea998Nswc/S+B
         kNZlfqXTvXJgsEDwoECmA33sW/c6hGWMTisIZinodS3DHf/8aWTGAtvb/A7yKTxlTS6p
         KQi0ABvHVwJ3EwUZDqmujVOZ37/cbLOXDCwV4ydV/cy+52vciOkQjwHlLV0OCfb/okbF
         Lrug==
X-Forwarded-Encrypted: i=1; AHgh+RrEs9rd/QlvXK7V81yQdeX2bZibgunS2jOmBDxxkf2n4YxCoy8CY2Lrt8XOdcYm8TZRTybUbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySJIQnAxTysq6rgZjEpupCckf0MqVwkChcPqsAfD+KySp7YYz8
	vhCmXi5Ub0ChLS4QqZk9NyXsw/WoU+9YN6cwUJ7M0k4j+L+bmZ9iSX7HyGTQ/4f6F2BNVln7xLT
	fEHVSk5BkxOmg7umFDaWdLbW0l7B6T4QmaKtr3xTWSuoV8x9o1Mcf3j2eOM3cxyu/RpvGGvaEz4
	V0XISKAu5pxwkzSxyeO9ReZHz2hSHzSfA=
X-Gm-Gg: AfdE7cmN3EvqaQQyefrIn50P+QtWy33HOgjPyJ9GMu6qwt2keQq9i+ppwr/7dAVGGNV
	yEoayXknfvJBQIk4AFJY0vCkPmLPO3GigBdcH4QIvGEAIWjg/qu5Y0bhXQopSkP/sd90UFgTteC
	DkYpJpGkn+RGt+X1vhGQN04C9vEvDZe6zHx++FFeq9V7ZyUcMh2okpVzr71LZOoWOpv42puDhhq
	zqG0YJtTuasR0rf7JoPsL9l3nYufhLaEn0DOyHujWxfyhvKd5JinELa
X-Received: by 2002:a17:906:46cc:b0:c12:93ed:47dc with SMTP id a640c23a62f3a-c12ae7bb5efmr256938866b.40.1783032583008;
        Thu, 02 Jul 2026 15:49:43 -0700 (PDT)
X-Received: by 2002:a17:906:46cc:b0:c12:93ed:47dc with SMTP id
 a640c23a62f3a-c12ae7bb5efmr256937566b.40.1783032582582; Thu, 02 Jul 2026
 15:49:42 -0700 (PDT)
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
 <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com> <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
In-Reply-To: <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 19:49:31 -0300
X-Gm-Features: AVVi8CeRFl__1Bqk-jk5FxN5LO-w5tjorS49FId6RokuADqCYNXoGJwL1nk7uKc
Message-ID: <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 0p2OtugFbghqjjC1Vf2t0At2IfLF5UZyZCeAI5P1D_Y_1783032583
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 3:19=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> > >
> > > Current remaining issue:
> > >
> > > 1. amcast_joinpart
> > > ------------------
> > > Still fails due to a missing Perl dependency:
> > >
> > >      Can't locate Socket/Netlink.pm in @INC
> > >
> > > I searched the configured repositories and could not find a package
> > > providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le sy=
stem.
> > >
> > > Latest run summary:
> > >
> > > amcast_joinpart/test ................. Can't locate Socket/Netlink.pm=
 in
> > > @INC (you may need to install the Socket::Netlink module) (@INC entri=
es
> > > checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> > > /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> > > /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> > > BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> > > amcast_joinpart/test ................. Dubious, test returned 2 (wsta=
t
> > > 512, 0x200)
> > > Failed 7/7 subtests
> > > backlog_wait_time_actual_reset/test .. ok
> > > bpf/test ............................. ok
> > > exec_execve/test ..................... ok
> > > exec_name/test ....................... ok
> > > fanotify/test ........................ ok
> > > field_compare/test ................... ok
> > > file_create/test ..................... ok
> > > file_delete/test ..................... ok
> > > file_permission/test ................. ok
> > > file_rename/test ..................... ok
> > > filter_exclude/test .................. ok
> > > filter_exit/test ..................... ok
> > > filter_saddr_fam/test ................ ok
> > > filter_sessionid/test ................ ok
> > > io_uring/test ........................ ok
> > > login_tty/test ....................... ok
> > > lost_reset/test ...................... ok
> > > netfilter_pkt/test ................... ok
> > > signal/test .......................... ok
> > > syscalls_file/test ................... ok
> > > syscall_module/test .................. ok
> > > time_change/test ..................... ok
> > > user_msg/test ........................ ok
> > >
> > > All tests now pass except amcast_joinpart, which is blocked by the
> > > missing Socket::Netlink Perl module.
> > >
> > > Please let me know if there is a recommended package source for
> > > Socket::Netlink on EL10 ppc64le.
> >
> > Thanks for following up on this Venkat.
> >
> > I'm adding your colleague Ricardo from the RH side of the house.
> > Ricardo is very familiar with audit and should be able to help you
> > with missing RHEL packages.
>
> Thanks for looping me in,  Paul!
>
> Venkat, unfortunately, perl-Socket-Netlink is not packaged for RHEL-10
> ppc64le. An alternative is to use CPAN[1] to install the
> Socket::Netlink Perl module.
>
>  # dnf install cpan
>  # cpan App::cpanminus
>  # cpanm Socket::Netlink
>
> I'll reserve a ppc64le machine and run the tests locally as well. I'll
> share the results shortly.
>
> [1] https://www.cpan.org/modules/INSTALL.html
>
>
> >
> > --
> > paul-moore.com
> >

Hello everyone,

I built an RHEL-10 kernel with the patch applied and verified that
audit-testsuite passes successfully on a ppc64le machine. Please find
the logs below:

Tested-by: Ricardo Robaina <rrobaina@redhat.com>

---
# uname -m
ppc64le

# uname -r
6.12.0-245.test.el10.ppc64le

# make test
...
chmod +x */test
Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  RHEL10

amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
coredump/test ........................ ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_device/test ................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_inode/test .................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
time_change/test ..................... ok
user_msg/test ........................ ok
All tests successful.
Files=3D27, Tests=3D300, 252 wallclock secs ( 0.12 usr  0.01 sys + 54.34
cusr  1.38 csys =3D 55.85 CPU)
Result: PASS
make[1]: Leaving directory '/root/rrobaina/audit-testsuite/tests'
---

I hope it helps!
-Ricardo

