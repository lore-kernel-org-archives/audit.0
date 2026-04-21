Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320636AB57
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812914; cv=pass; b=np4h7nxi17dnVJb00gyavEfnDxI9zmNdkqhzQT3qia6XcfwC4GQoICAOfMLqcyQLjJSEF6FZPiKIQ/C5V5sFZ4pQlLfpdf9wOCG9x3jQQq+5LPlAqGH5ll8XjowTZCAzq/nb/ArrggvJ1ikouRV4yrX0KBO+NIZ3drRuL6NaMFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812914; c=relaxed/simple;
	bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9gaGZMZUowD9ckpjfCG8TSfrR1R4KzAJqF+Fa2Lbrb2uOC5YWeuZy3OYc4LBWzyZTzD6kJ55SdMZ7IOaJY0Y+PtRl3pQG0U5MDkpkFvRAPIu9wDl2u5Zq+tnGaxrxf7X29zk/7dVLhvpc83I8YgBOibAyApVUFpxMgoKLPFFcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ISN6my; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ISN6my"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so30208195e9.1
        for <audit@vger.kernel.org>; Tue, 21 Apr 2026 16:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812911; cv=none;
        d=google.com; s=arc-20240605;
        b=Zy64NB86DTxxPzzo/yHtRsqioOBHseZ7AXePcSz4AjVQ4gKgiMdo1yF1nVGZ4qp1eG
         rPitJUl2C+OymczC6YtvLihHt2qJeLXJaBeij0PMmRskhJJr3XnZQ2QnsPbpURLAegUB
         6QXVHbngoiDeH1M1hte1Nz2MTM2pkQstPS1m8unz4kghLvzwIPI26GVa5yDG2jfLpL3P
         9qJZKmXXxYQJGz4AgVUV/oNGn9KwhliPKu7t0xadkr/S/sJWXM6DdF7gYScEYYgbeeWP
         35rl9pPz3aOAzfnd/QZx8KAyjLmDH2XvlhogyHIic8bOVdlxcz5MYv4TUlafo0zRDMUh
         6IAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        fh=9sHbX+IoJTqzuyKye/WfYdc3asyPhNJf96qdhOQWU04=;
        b=PR5pRQvVTNto1NEPAIHyB6mYKUJh10m4bisOofrCffeoeEtMuRWAkNNQkH09fRK4LN
         6UV4BP+/b2xRh6tCzK79a/pHtKcx+wFZ4u6Wke7h8xPef+9NiQaSpEfIkBwKo49XmB/A
         pXIH8K57oPmUT+va9QBHO5tqDDA+Rk1Rg9g0eEvMrb6isJXvJhVa1X2BH39yZtm4rbQp
         hgJOlUuRcREEtqMTQZJoi/C5iOjpUlqqLdbNtKWgs0JiXHrmh5bVltS2hXVLQMsj+WQI
         pwmY60A9DuIUwrWSn8E0m0Lr3cWCDJA9ZfEfcCWals4si6lGzPKZ+CDIrpzCu4c5OJbX
         34RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812911; x=1777417711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=f8ISN6myN0HouaGClnTTEmtYdTHVXREC81ZsCdvw8OzsjdvhMDCIl/pHWuaWRc6yj7
         s8+QDhNUEOIRUrGGJPo4iXX+fXbI8ejZuYp6PAdrgZ8SCp/e8VyTkRt3kOChA0T7Ri3n
         JaJ4ay+KYNopVNKSHQxonn+n1eNDEjkSMxuvfy1eaDoWgO0tOwIegQO5Hs+UTIznTXMZ
         28iTByKLIpXNg/sfsHODU1wmZbBgJUfNVtH2u3+nU9aFevpzW1MEO6M+O1pJCAv7BqUh
         gkn4OBsbu30PqRPufkTbVSc5qXpWAkm6E3cZU6Gc3LcpcNS2EwMJHtnllscyw9Uwe4GL
         kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812911; x=1777417711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TR8FfcO11p7vVa6RPRWvJwht4gBSEvxOdxbVlJmTMFY=;
        b=FzdfPFXeexP6yykoJQRCNnkAYWs6v04ihh6N4jJ9Ia9xjS7Y00N2b6FTGv1mZocH+9
         2SuJ8imsEu6Y6TuKBf7S/7DVFcUo/WvGNes690sz6n0FYyFV/rg0nHPUhBtUcGK9VNRz
         um/wBu3bYNp0qxga/10xuG8NhjNrWJAfLqz2puV4KPoDQQzbAYprGV2rh4ZFQZePfE8e
         cPKNmIch6w4eRskKwxgC1i3pBreSiqP7W2b3m3CjlIyGUIBnJcoW/2s/R48B1c4GkZC6
         UdRwIFuytmspJ03f8WfzkAt0Le9T9zTc1XClV94Rjsant5RqJ2ameIwlpKo/qauMN48t
         fw2g==
X-Forwarded-Encrypted: i=1; AFNElJ9MzkNk5vOmX4UMqKzdR2wGKfk4K6CTiLxvQFOH89LWMW/fwrbpCGDLyutAfbowpWZotdWLLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybPdLUJj7ovL9kzahUPA5A7ti4jhFZg2qV+Wvksj0w8OgyIfm3
	Ohhh3ZqXy2S0wRJA1fd31MhDm8a9dhHR6kEJ1PfWqRAnI8cV1ShOLM7+WXQKCKaqvZXXVen+4Qf
	KDsnfUrBUXVmPTxdw4KreepEu5V+REws=
X-Gm-Gg: AeBDieuhLAXaeU57cDGMR0xAkVNW7+Lq21o0bnOhcyg/S5q/Q2JI6it+OeS280giWMu
	eaE7J+xax/UNXKJ+vnuc2Z+GdE8P7M2NP/IUbnxZkToZRm89siweKFCLO2863wFDbKsans3nWVH
	Wo2daY6IOmx/S1P4piluxBBkOI3K4W3EvrU3UiA1Cxm75UGhL7Rtrh+bWVLs9qqSDoqFizw0Nlu
	ouCvNXrQZ5a2wrZEwWJS5GzLxLRyfsXtLMmc2VZjP8bkXKiHO6vmjzhsW0aYnOegGTmeHOb5HWY
	gHp94mGsJuEu0FngojZwpYUiAC7jBYgKHZmye+vQWAZdYd53Q2+ogDJS9kGGLMYQoNmFql4DjRa
	GpfBC4vX4V1YvIuLMNY2jbudSZ/wvkN078ipS
X-Received: by 2002:a05:600c:a314:b0:48a:58aa:523 with SMTP id
 5b1f17b1804b1-48a58aa059emr27059935e9.31.1776812911066; Tue, 21 Apr 2026
 16:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
 <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com> <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 16:08:19 -0700
X-Gm-Features: AQROBzCAY_2lHhQ1prWwPyLIfmaKNZadZdFGYpecw-J2REDrg4GAqC8BWUzx63I
Message-ID: <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > > It's still Nack.
> > >
> > > Based solely on the diffstat and a quick look, this appears to be an
> > > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > > but they are LSM/audit kfuncs and not core BPF functionality.
> > > Regardless, I want to see how the LSS presentation is received before
> > > worrying about this too much, but your NACK has been noted.
> >
> > Paul,
> >
> > told you countless times LSM cannot touch BPF bits without
> > explicit Ack.
>
> Based on a quick glance it doesn't appear that Fred's patches touch
> BPF bits, they simply supply kfuncs for users to use in their BPF
> programs.
>
> > So, no, you cannot add bpf kfuncs in random places in the kernel
>
> I see plenty of places outside of kernel/bpf that define kfuncs.

We discussed this already.
All those places were explicitly acked by BPF maintainers.

Every time somebody adds a kfunc it breaks safety, because
people don't read or don't understand Documentation/bpf/kfuncs.rst.
kfuncs are not export_symbol.
Object ownership model needs to be thought through.
Calling context needs to be analyzed and so on.
Just because something "works for me" it doesn't mean
that it's safe.
