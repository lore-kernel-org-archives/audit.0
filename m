Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2C3164D4
	for <audit@vger.kernel.org>; Thu,  4 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998795; cv=none; b=JLh0m84JpyOIf0M0n25sBGiRdmXmjvnw5CN3Tr096cv+Tdd2zIdcWhR2ymFSkxnUB2nqkuLV+C/3iOjsPfiQoVUKFs0N3N4CESaeQM4VImXao9amzOUQm18yLPWBpykZaJjyatGmuqRiUsngvlygxkWFGgGqBS/JUYdE1r1mflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998795; c=relaxed/simple;
	bh=hQTesLUjwHoE69NvEeQegylR6nw/aEJIYz4xhLEq3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEDvKpI2s1iV8lsdE12mpwVw8iPr6n/K/jTvU7h5cV3qG6Q2uqFWHA21JhR8JkOnYuVZ85IBwKExU7f5McZdqcjFPedTVnCw8GsFxqx53n9eL07aUqwdZ/0aTOterC95QuDAwqo8xZ24hrNtjHMVeXZqOLAwULGYLv8UPY8bRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UP2GPhlu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UP2GPhlu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267b98a4so1001508a91.1
        for <audit@vger.kernel.org>; Thu, 04 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998792; x=1757603592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=UP2GPhlufJlo2H9mMansZCVVWhp68Pga8Sejr7LmgodmZ9OubjzRQpP88lmM9LZlgw
         e8AHDTQ59N5nOMiY463I6pC9wYaD7xuC0gpB2H76rOVBTlnkxluh3eTI+gI1vKyvclrq
         aYE4R5RJqTR81u9Kb/3JvVM3cwNddTcllGP2O6pNyo6jHkLYSoRu+MYpCxGm9M5XrT92
         3Yj+LS0K2MdxsPlPWct3ub5YB+lSLdCPrSnDpgKfHtVm1JiOWKi+wXPFiJcgDY8N2g6V
         cBD5Y5bOO1vSzArNfMdXLDSoeBjxXm8/hdzif34lCqXfD2Up+bp7vKZLlhTiAWwBIxCY
         SEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998792; x=1757603592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=MscCJV3cSwUA1ykG0YUJ/+BzCqt/1tK/nGduJ6p1VN8fJlF7rsDlQ9UZ4HdDwNsBHA
         e8IYFbT/z8mnQkdltgmO5JRNfEZvMP6SkW4Ja2gFyXdQmC4OaR07dMSpXpw10udTg91u
         7kzn0jIwPQHxJzPQiDO/SFeyDujp8hiW5AgA88KowPtJ3Cus1C9YJQe6ka3tb/YOEV7m
         2OAA9phQlipe/4Fwmbam1CT68EhcDj8g3ask4xmTljy8XBxxyA/EyudM4e1jRBXplh6a
         JDy9pivYsKFOiwCZPeXGGLIqc+YEVGY2iqkFzbOOsz4FWZVz3CEnfrCHz5tPCp3dq/BS
         gjCg==
X-Forwarded-Encrypted: i=1; AJvYcCUdu1m5rUs9jrx7eYaqr906vgC4h2R2C117nOobCM9UlFn3CaIljeWJopmFW09vWGeL+pdi4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9150spuoPg9b5UglRQT1QrQJ4V4u/kIn4dQZLykGEw9uT1s4
	fWDyQ5hUIqCelFev5M6DJ0B9VEyk4WXQ5pQ2Ib1a9Jzwk7/tA1gxOlGRDYOeDDVKwxIUthEnTz6
	K67CRJWT2edzFtAPnpBHhIsHdypY4EHlMRLoHGAXG
X-Gm-Gg: ASbGncuFIHTkA2G4x2thwoXG/lOPkFP4IikLujk+EWsIrRPcdNAP52YuXW1XqnWdlLO
	mfqiXAWHk8SkAY7xOsUpS36ajqgqllTQKyV/ke1148sANjSSmPN84HnNL77nSOHjY3yWX35mGgE
	5W766AbmS0Xp7uIw9rSxwpSMnG8sZdQvIiwcn3AXV4hTnR6qfUzOotqH4MX8VUFhTroZq1x5IY4
	CY+Mww+XZeW7q80Eg==
X-Google-Smtp-Source: AGHT+IGqcMqHHAT75zSTTPlBqCVyFcn6AnTIKyagfTnT5D4zUa/iS7NyI7Sait1maUMEoXcJ2nw24OBTrZDWN8ZihOE=
X-Received: by 2002:a17:90b:2ec7:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-32815436083mr27618387a91.10.1756998792394; Thu, 04 Sep 2025
 08:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com> <68b9ab18.050a0220.192772.0008.GAE@google.com>
In-Reply-To: <68b9ab18.050a0220.192772.0008.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:12:59 -0400
X-Gm-Features: Ac12FXzmdDvybcxdLMeRBs2OONbitrTJM6yCl57blUt8t099sFu8t2Ati4PBkBs
Message-ID: <CAHC9VhR6+cHx+FvonHtAvuNZ-Ls77HjGnU5k5VR7qy1BUSaxdA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
To: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
Cc: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	peterz@infradead.org, selinux@vger.kernel.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:07=E2=80=AFAM syzbot
<syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Sat Aug 16 17:28:58 2025 +0000
>
>     audit: add record for multiple task security contexts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1199fe6258=
0000
> start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1399fe6258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1599fe6258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d2429dff5531=
d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbb185b018a51f8d=
91fd2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b9a312580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16819e6258000=
0
>
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Fixes: eb59d494eebd ("audit: add record for multiple task security contex=
ts")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

The timing on this is amusing, I got the sysbot report just as I
merged a fix for this provided by Eric Dumazet :)

https://lore.kernel.org/audit/20250904072537.2278210-1-edumazet@google.com

The commit has the appropriate syzbot tags so this should close out
automatically.

--=20
paul-moore.com
