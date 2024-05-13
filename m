Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0A4C62
	for <audit@vger.kernel.org>; Mon, 13 May 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612385; cv=none; b=p1QC20dj/GRmb97wDzI5CLPDIP02APoQOVnPqPHZ4iJZRb74+14rBgOMoYpuDNvJRbfg/4EjGvIA8KAvPMbI502b4qy9aX48bSLbc9uR+otBrKqt/uFtmbcl0fzQXVi2ciLCRmZBmtV74S82DueXXPSRnW54Sj7gQ//a9Pf2Ae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612385; c=relaxed/simple;
	bh=NAFNAGZXDH28lYLqiCjV6acOfA/J8mZARBGgABvAM9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deWNWyn1Bc6kJt0FojvH0SnLurc97Ibm7yi5leu9HyWw4O3X5VyofAUueSMp863w5xQ/EJe7QkaZAMW0jWMpl8WFo2xjennCDcPOAX58r08FRfxm4aM5FXwP8CDA/cbLdWlGY0ETbj6dbGDWRN2hPJiMKRjW9nI0nk63ZEDOCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HVLqMfAU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HVLqMfAU"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de60d05adafso4213619276.2
        for <audit@vger.kernel.org>; Mon, 13 May 2024 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715612383; x=1716217183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmYZk0kFF6OOGj9czkV32wEYdGGtifIB7+d5SgpETuU=;
        b=HVLqMfAUvFNYcP4pMfnvTJq/1R1Wr5QlEfLvtN/pVkPkHllu5mJDCR0HYKgR47AdYb
         CVLkMJ03uXnKHFnrQx5ugimdxwoCVav4Xm8TLHvkd4NUxHDjaZl5SLDuWntgkhGCo2YL
         VjkdeDB9tBSSxpq7jE+bi/wWCFV9b4Bnck93Rxvp3mfAV7O/4HCOCShEevUvS5CakNg3
         gAnKKcRBPt+ukuSTllH7YdzdZC8ahzNdVlvhyywVBGF2TpQvT2BlcDywzA96IcbAP6S/
         60bwQW5qt1fJo0PpKxbyVX60aSECkEyEGW8QuoqpNRazHcartUYFTxUQl5QVd2PagCdq
         N58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612383; x=1716217183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmYZk0kFF6OOGj9czkV32wEYdGGtifIB7+d5SgpETuU=;
        b=eqM5AEqGyyO4v5Yai9nxPrCNp7TGINlQwTC6TaIjmk1LOdyoB9t6U6ojacV6BQKOWh
         CPsGw8cgwnv8MZamiKI7bc0DKgNbQd8ObhbOLN/TWME0yILpecLHwZpTZNQZWA+IgOYl
         7zqcn/MhU7tT8YlRNGqn/mIuFwtVOi1jQbMHPR+01LcM0G7i8cUQA0fxy66j1mtJB3Ix
         7QRakEtFw0t850YbRBPWF7UcLEqfvxghT7nZwfwCZuM/k21eldAFHFUIBQfWDgiOA5V5
         K7kBhA+0CqMNgS/HvowSi2qZPypVkTMZjLjpLhIaYClkkhwQo6g7tzUyycdIrFppm2b+
         wtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSIYWkPaXiEnTVzvdXr6i96rj3nreMhJw2yPXNhfqjf/uLNGaG3XTgnsGGc4R9bVNiM4CnU9yh3+izkq92fqm/IxQABfs=
X-Gm-Message-State: AOJu0Yz0HXWgrQ3zYbe7s2rn4PprIVEtU97CI73qyeQlpJ69eXi8a5uk
	AyVH1566HoYrwcClH+EjBno4y6MJ8drHaN2yzofFUKVvvea7KBiTOBqCnJPQPrPCkAUTawKv9k+
	RuJNOuzM2v8isu0GIwHOaFa4DJxdKn7CuVS9y
X-Google-Smtp-Source: AGHT+IFIGLplDoMFraH1zkLAVywXcB6c6GYboq/6d5rFURkDTnzUpiqkAe+TQql/tQILTDNyMfl0quYdML71woeC2Eg=
X-Received: by 2002:a5b:b0d:0:b0:deb:9e90:2f5b with SMTP id
 3f1490d57ef6-dee4f34b10dmr9160333276.29.1715612383406; Mon, 13 May 2024
 07:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f5f83206180101e7@google.com> <CAHC9VhSinu25_9evZZmLaiJL=R-LNOmB+Yz-3NtdMi5b+vQiRg@mail.gmail.com>
 <CANp29Y74qSm4_VTVT-j5n5kwpJaPk1zTMXPRO_xxWViXADUNeg@mail.gmail.com>
In-Reply-To: <CANp29Y74qSm4_VTVT-j5n5kwpJaPk1zTMXPRO_xxWViXADUNeg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 10:59:32 -0400
Message-ID: <CAHC9VhTY47hMxCYbU08aj0VGoPLQviL_6rGfTPyMDe8K36wPkQ@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel NULL pointer
 dereference in kauditd_hold_skb
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:01=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com=
> wrote:
> On Fri, May 10, 2024 at 1:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, May 9, 2024 at 4:14=E2=80=AFAM syzbot
> > <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git=
.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c901b89=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D758bb5b8f=
724c7ba
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8ffdaad8822=
cadf6ff4e
> > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU =
ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ed19b=
8980000
> >
> > Is syzbot no longer providing reproducers in C?  I see the syzbot
> > reproducer but no vanilla C code ...
>
> Syzbot still provides them, but in this particular case when syzbot
> tried to translate the .syz repro to C, it was unable to reproduce the
> problem anymore. So it didn't report it. It usually doesn't stay too
> long like this, in some time it will find a working C reproducer.

Thanks for the explanation.  This failure looks odd enough that I'll
wait for the C reproducer to spend any more time on it.

--=20
paul-moore.com
