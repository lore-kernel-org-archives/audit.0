Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65B3783C5
	for <audit@vger.kernel.org>; Mon,  6 Jul 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346771; cv=pass; b=slfY8sC56u/dwiijYHgHSm4OAGq3sxXdrR6VJeXpliXvAmVmNS5Z6vfk9cqXvwj6jOGQTKaR22f3OPz+qAAKcaopOavGmzQQm1yZ89KrHqVqgwP75IZ3slOFVnSOXYp6hyACEM/c6A6KkeLuXzfVgS2Tk/0H8cmr4LWp/+7Rr10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346771; c=relaxed/simple;
	bh=WCG610DAWMCDmAUEIOfzj9aw680keOunQIFlEVux3yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nehegeEATqpEKKW0ouhnrSMbYHU9bK9ZKFgR2+V+FfkRNUEoGMCFAzKb5sRApp9huzOIZaKhrnbMHn5kYcsyefu3lvL7UHODcILpYIeKzYqHtenwJARF8Vbw8ItjtoMzEa1GGf/ncyzKm+wYt8y4oXwzNPFoJ3dY32JHqgR2Dxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JSPlAN8r; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JSPlAN8r"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso25082785ad.0
        for <audit@vger.kernel.org>; Mon, 06 Jul 2026 07:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783346769; cv=none;
        d=google.com; s=arc-20260327;
        b=kWDizcz7d+VHjhnzueToNKZr73+acv82YhI2EFxioeOis/Xx2/qFHGkiNMMcRRxWxV
         SGs4Q5LgS7x4sf9EAxQLtpuhK6BKLtoVJrLaAXoY3/QFxe1uZOMkD78iORlMyPd7wABl
         lWYh6VvQKmfXwrSFL8Ogip3Po1UbEWRH4y4ZdyBbQ+NgMXpUeiWsclS/HOKNDRN4QYf5
         ho18MzNaJHP8VClCHYFJgjxVe+HYiO5bjB6LhuBxY+SYIg9pg6UYa29H2QYvaSWfbXEl
         hmjYtUZijxPa1PEVIaQ807YvLwqzXkYpXqAnx8a6l3V62f+lzdGzdAFlIyePTWTr19FN
         6B3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        fh=iKstcAVx7zvZJGo0RGtnsjN6/YqwmTDPReEzJTa02H4=;
        b=eBvGMycjIlQkvOF6B/Gi3FOJ7tuasClNFie3Qkf446YzoL/Y7abo3noYIRa9HcGmAE
         uM/WrrAMb9vgo8bIJJiEOpF1OfBsXJQIgzmkf9TQSjGOPlfcks/agOsNo/rFzL5sNgro
         oYBzyrzWScL1NYcZPAjbOkxmrdjMDbAEO+JWlak+BtY8Y2CMfBcfhdlZJMws+r8MATpw
         82D1CPayPMNHLtPSq/sglxIGNrv29LkUFaqJmMJmjU+JV7ca86NGnAYDpFM9M5t2V2Kt
         4q5Mu5ywJETI3gttS5RjytRg9Nr2lfd/3H9T+8wA7E2RJU/XHXmrpERODXMamXDdmpuo
         4N1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783346769; x=1783951569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        b=JSPlAN8rVnpFi3rJB6zobusGT2Df1ZgL1y738aA+DAJevAotjM/ri+d7HTmpr0OQ7c
         2vWqLuM9Eo71DazvuYmCsmcAtdizXOTFj5g3xIBXUs374SVNWxjGgKLGoRqZJ4RpyW8C
         kZSDF+muAZvqM/GcjwoPYZxazC/2XMMHy7ziyiik5j11Nib8JJasqt42J3fG4NFjR2f3
         OivE11nAbgAObDqy2yCmOxVBqt2E0TQu+2Nz9c7WrqDXf/yiloV5hMQSbKZ1mCcTFnEO
         DxIncy+Y15YQ31JG9DIosvPtpo4I8qoGyuS5CUtAyca85W6JhwesvYy4JJZT2iBS3O/L
         bFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346769; x=1783951569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwznM8wJhC3tYJr+9DBy6ZAChqMb/6fSD6dK6crswv4=;
        b=LnR8FUR4SrvXn0g0oJtxgomt6ldFmjagqLQ4MEN3Igy3xVhJ23WjBIAYz5tSvy9xNS
         A08/Mw+cw0c9GJjF7aXkEz8R80nKe+xgF+6OGOZhSZ16DTf0ShzGJw4Xnx3e5X0kpB5Y
         d9LjlEjHGbng7pIRsmBgxkUYmjOaiMREl8ecY/vqy7/5VRbPnVl4VXA5hVbzH9BIlF9Q
         9P0QfeC2BFD8QhCP3ghqtf+dk3ZWZ8FymobrGWXbFotTImAmQMaEFNeYJClQen24zQtv
         2zCNKKa/dS6JNjCScAW8UkhR5DU9QEAust1QbpUKCfVGd3p70D1/c6gujYQDNJZN4B1p
         IqVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtpagY5XW+10mQVS6dZPq+GOPRzY1kC6WjyT4qQQt2I7AALhO5zn8Bw6jTr8QALRRUZlvHrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAZbd9LL9UQR2EpN8zt2bYm35K/nPO2lxmxB9V+E7WCqF8Ia6
	WNEjN0f7mdZVTQ8AMiawlkHpnZMwLSETrgRZaoe8fbpqyWKGIiUkrRIRNAdMIzKxWEjIX1qN8B7
	EEj/KP4yxNWzfXdk47FfH63SpHcHD4XXnnt7iW7Zl
X-Gm-Gg: AfdE7ckLrZ/gnGv9SvWGE1X+wW/pC5VloZOTUIkZu/M00gKEgVltVRV6RR/GtX8hr0s
	QHce+RkccbR+/r7fnw4gxF+LTYQ7/pWoKAdt5JIfqUipS+iUNn6a1O/vhrlZNRFatipdGr+7sVA
	YULcmsmTMSL6yA5iY1fUoQ2SAUp8gDxP3297VizxIGVXFkwyy4mj9DHvFsTnPETxzkE/eBR2Xer
	tNBD5LqcAR2Un572OHWJaFdmZlZjd1a+q77dqJw2tFnCTuHDY4FaI3LNXwgb7kqLLVOjAty
X-Received: by 2002:a17:903:1a26:b0:2c9:97a7:3283 with SMTP id
 d9443c01a7336-2ccbd814425mr8460355ad.23.1783346768737; Mon, 06 Jul 2026
 07:06:08 -0700 (PDT)
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
 <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
 <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com> <8a568842-0a62-41d1-8e7b-cf2bcce6a71e@linux.ibm.com>
In-Reply-To: <8a568842-0a62-41d1-8e7b-cf2bcce6a71e@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 10:05:56 -0400
X-Gm-Features: AVVi8Ccaf9TSI6FAvWCNR8aEHftBAWQ-1JzBHLz6yYEAqkujo32UH3vUkDXPGLk
Message-ID: <CAHC9VhQAfOcZ=viJ-XmU4=NUowC-sZabukK5c+6HahUUBFw3jw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	audit@vger.kernel.org, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:29=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
> On 03/07/26 4:19 am, Ricardo Robaina wrote:
> > On Thu, Jul 2, 2026 at 3:19=E2=80=AFPM Ricardo Robaina <rrobaina@redhat=
.com> wrote:
> >> On Thu, Jul 2, 2026 at 10:28=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Thu, Jul 2, 2026 at 8:50=E2=80=AFAM Venkat Rao Bagalkote
> >>> <venkat88@linux.ibm.com> wrote:

...

> Thanks for the RPM's Ricardo.
>
> I installed the missing dependencies (netcat, iptables, ip6tables) and
> rebuilt the kernel with arp_tables available as a module. I also
> installed Socket::Netlink using:
>
>      cpanm --mirror https://cpan.metacpan.org --mirror-only Socket::Netli=
nk
>
> After these changes, I reran audit-testsuite and all tests are now passin=
g:
>
>      Files=3D24, Tests=3D279
>
>      Result: PASS
>
> amcast_joinpart/test ................. ok
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
>
> Paul/Christophe/Maddy,
>
> Hope we are good now. Please let me know, if anything else needs to be do=
ne.

That's great, thank you for verifying all of it works as expected!

--=20
paul-moore.com
