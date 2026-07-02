Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785E47885D
	for <audit@vger.kernel.org>; Thu,  2 Jul 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998885; cv=pass; b=beMml/wtdR8zgE7NMY0RHSHt24zCwnzGU+sIivYt45o2F59GGaqDIuddG0tyugK6CPsRKPkrVTi0ofYv19ceNEO24nE+1rHdS7UuJ3v9xdMPJ3Fpxf5nXZh+MCw1Tcs5zAJqks+PxR/n/TXi/xptY1hV4Uca1sX1GN8mSTk53Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998885; c=relaxed/simple;
	bh=1ebbCZNQOhwtvyIatV3/diTS323Ucr9fIzyIFnkR6LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxTT644q5Nl5rloeSjwF3tfF2MPiJbeLKncP9j9JsGl1/Q8YGGLaBqv8YBXjB7E/TtcTn1Zeulw/4EpVxmVIHo/1PdyXI9rBsB2iT+Gt544SdxCRsJcd6i4/bd68H8TRuNutwonrsgqJbR+CfZrp8FcGOfQvaRfG3e8oL2LjBuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=em0dBGqF; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="em0dBGqF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845e363246aso1607423b3a.1
        for <audit@vger.kernel.org>; Thu, 02 Jul 2026 06:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782998883; cv=none;
        d=google.com; s=arc-20260327;
        b=HV9zYOMFuNCrwUggeEDzteP766MGMxld3/OuYoXYHy1SXPPtw0KfnIE9Mj1fRvH5s4
         mrciyfUsJ8Xs+Adl9C0Do+kFEMuzJDJfKixawQ/4EfCHptJEmjywI+jTPvnXthORt3eM
         skX8U9PKH2//ItmEqeX0MJmv+DYXv+LXM73VmBczLyyJ9wbT7PMnZpWlB5SLc5wbGPjG
         aDjU5oqLO6eisKP/8NzP6SFw3sAbUpTngl+Vt3eW2lDGKSPMW9cbsUG+Xk8pasNulrIb
         2ORD6FWjBmGdDLUYJRpJIgFJKrXVQLUAH/vAbH4JzuItIQubN5nP4clzkHN9jzgXryiz
         EKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        fh=FW495/tsNaS3rZLIZxo78Pp8lwkFWycdMLfUKJpu0+4=;
        b=cFBbwnI+t9lXn4Tsif04Vmq0513yq34namrVGz76hsKcTFIhXra7hHMjPrT0FPbVNY
         Wcl+XKHr+ru7TmkNj886JA+A5uftTRUeVUs4Sytl1HbEVhvoa5X2W3QNTh73+4mma+yE
         SGqGRCvyiozVviQgZBCoSnA2DNIXefkUe6cp/Ug32C7+1FjfBy4YwD1xV1JNHtaFl/19
         6TE1+H7Y0sNJm7ZhZ8ZMuPlt4GzwTPBINqIQLkhd/y8y19ZKN7yPfazrQVt5fxjqnFdU
         EBGrGgJUfNFB/3eXm8NXznc0FbQUKX7hclW5C/ZkH/kS8ZEdJCNDKVxPhNABaRFfwN56
         7Utg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782998883; x=1783603683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        b=em0dBGqFd6hBGfLP7tko52TDyqsGXVmxjqsKm27/6TsLffVxfh3N55qEawJFeGIAjU
         vDvNj9Wc5cJrARIVcO3iM8zD1jknNYP7/vWh3VI+t66F2U9xa3Djr9tdKUydKaOko2vH
         0kMOhvi4bLihFQFkjVSuQMilyUfiXA93hZz+iLXIZNJjdERIFYgXZ9JE2VFYU80d40RK
         uGyPhwO5mCYmykFcjsr28bYWMgcWzkL3Prq0FMzO4YSyTK19J7Q2lmHZkbrQzkjl5DYM
         jx9uJiKQ4aDVX2HEpsLMXvzv9ln9GE2qyh6SUSfcpBpmg9aOBoQR3C8NRvIhiMAFy+Cc
         RYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998883; x=1783603683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNJ2RnvoQeNfDsJ73crtioMLjPdXpQiGlVuyqIgcPxs=;
        b=UTOELWqSiHAVYF64MUPCrOqOeZOG8kK4HOE7iQo9GfysNshcGFpADYkkq9A6hGAIvx
         ASZqxVRGSPrtpPApfqsDuTsdp/l0MBZZ3QQFG9+So+nsJ95SBEbV1W6foW/1y7xS4wu0
         FjEDgbLZoUMlH8cPcfppKnpwHz4A5XpQ3jiK85ZBIHN6UUd50Y5CYQfMCY4JdU55sOCP
         48CTt5WgMUqEyCF5r01syCj88IOQWm9yqUn59dduolsETTo+Rp0DAQtzmZaNoXL7DPRU
         gWsAGcpWRX+SYXqSX1AJmwo22zOI96mvq1K+gJW/GkmEWaJk7hkx3b41re2xpaMc70/4
         Z5Bw==
X-Forwarded-Encrypted: i=1; AHgh+RqWyx/n9EjuNrlOGh6W6Jla6b8N41Qj+lG0XGV9Mx7mxuvCozBekDN3Q0jYtYq/PerN4iPbLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1V45P3yPRme57swGcF+OUNF2H53RtGMpkhHh43MujVAsX8RFS
	2y1luI9cqMcYnPLhZgRcelJNXFjmK1jhgn2afnjQL+H7CueBFWlTZUn9X+h1cdM4Nxsg98LNEaJ
	pO17F54kFe94Aeq9RmcqdGaYO4WRE13XFxr0oZdcW
X-Gm-Gg: AfdE7cnPoCZI79NEvUy4N7oSv9Q67B6t1y5juPeP1lvJwcA3xJcPEjMJ6581qp4z5/b
	4cuhLvsYugyOoatJkw37Yz8TMHiq4CKKzqvf1Z21cw+vsvx/DH0peFZgY/wgj74mcOXS5TFpo5r
	ikpQhgQGhEWC3TwS97icUF6q3KfbEw/ROBFRfzQ82luu5AnItrZMJhdM/X24ZIsG/r+pobGnIz1
	WO8goE5lDSNPhhA6NWlhkXJZNe8WRHddD5DGfnSCmT3LAhENZTEM0yO/BO/z1cydceMiL3m
X-Received: by 2002:aa7:8883:0:b0:846:bc60:5bf7 with SMTP id
 d2e1a72fcca58-847c0675300mr6113283b3a.6.1782998883309; Thu, 02 Jul 2026
 06:28:03 -0700 (PDT)
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
In-Reply-To: <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 09:27:49 -0400
X-Gm-Features: AVVi8Ce7kHZ6K-SM1XnzyYNf6UB60lCb0qSg6t5Q-Zh2t2hWQVqxIh32cuDs3y0
Message-ID: <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, rrobaina@redhat.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Current remaining issue:
>
> 1. amcast_joinpart
> ------------------
> Still fails due to a missing Perl dependency:
>
>      Can't locate Socket/Netlink.pm in @INC
>
> I searched the configured repositories and could not find a package
> providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le system=
.
>
> Latest run summary:
>
> amcast_joinpart/test ................. Can't locate Socket/Netlink.pm in
> @INC (you may need to install the Socket::Netlink module) (@INC entries
> checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
> /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
> /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
> BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
> amcast_joinpart/test ................. Dubious, test returned 2 (wstat
> 512, 0x200)
> Failed 7/7 subtests
> backlog_wait_time_actual_reset/test .. ok
> bpf/test ............................. ok
> exec_execve/test ..................... ok
> exec_name/test ....................... ok
> fanotify/test ........................ ok
> field_compare/test ................... ok
> file_create/test ..................... ok
> file_delete/test ..................... ok
> file_permission/test ................. ok
> file_rename/test ..................... ok
> filter_exclude/test .................. ok
> filter_exit/test ..................... ok
> filter_saddr_fam/test ................ ok
> filter_sessionid/test ................ ok
> io_uring/test ........................ ok
> login_tty/test ....................... ok
> lost_reset/test ...................... ok
> netfilter_pkt/test ................... ok
> signal/test .......................... ok
> syscalls_file/test ................... ok
> syscall_module/test .................. ok
> time_change/test ..................... ok
> user_msg/test ........................ ok
>
> All tests now pass except amcast_joinpart, which is blocked by the
> missing Socket::Netlink Perl module.
>
> Please let me know if there is a recommended package source for
> Socket::Netlink on EL10 ppc64le.

Thanks for following up on this Venkat.

I'm adding your colleague Ricardo from the RH side of the house.
Ricardo is very familiar with audit and should be able to help you
with missing RHEL packages.

--
paul-moore.com
