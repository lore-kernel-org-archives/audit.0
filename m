Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E1155757
	for <audit@vger.kernel.org>; Wed, 23 Oct 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718491; cv=none; b=MdPQw7F5eOCN/JcEVFV0HYpb1JDeV9w1oIUqHqT3aQixL+VlWQnjR6/T2jVhYF1AMhuDWesdnlaauCEgtMQXrAdw1zBQvjnCXC5SGParTVh6tH2cYmu4Wu6azcWOFNs1KeSQVx9SB5Itbquq64UWodSyl88Wjco4gPtjPU1pVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718491; c=relaxed/simple;
	bh=JRcAZKD+I8w8/3Fv7UE0rYpbqBIZNz+DntRIdFr9Uug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGzd/a0YK2ub/tjMWsTX7AGasH4gJelBzp8YLZuIyi7UhSTTC64EeGmx6CfdSKFLPtHglTrdgbQxqp3W6ED7myaSrLrWfXyGhM0zH7vHqksmHoSfQwrKDC9MTxM8oRG9Xfx1rYPxEbv5PnKWULqBqfCDh3HedbjBykx5D4IBWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Az9ZJHMD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Az9ZJHMD"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so274027276.3
        for <audit@vger.kernel.org>; Wed, 23 Oct 2024 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729718488; x=1730323288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72UVV+2r/h+iMp+5rXpOpE6KXuW+xAaVxADIUv6H0bw=;
        b=Az9ZJHMDjx52BwG8wFgOp/yyL4lASo8V9rnNDxIJVq15kJqQPTkJljszNn6C/iv4C0
         PGIyNmESB7ck99dQ9UC5/BTHCJIMO1MwqFZ+YaNPGFXdjROSp079kSEp95r9N6bNrHzL
         dQjgVFPXSJLzuU+EasB57DwkccOkvhDCPCUrLq1iw3RNK1IDC5cp2rnHlJkPYAIMvQ/B
         YpVjhNinRok7OiHTszM+6KTjRlYm5UsYNVR0w8CxkYkaGqgCXHtZuTaB+CIf7U4EhIzc
         yjiau7UMt65P+Lor8w00HGraorygK9m63TgbvruT/h3h/GRi/d4LfU8B1TKmpM5uDTxB
         0lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718488; x=1730323288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72UVV+2r/h+iMp+5rXpOpE6KXuW+xAaVxADIUv6H0bw=;
        b=Fahss5SvTRuIMDtvXpTUJYTrwKwJ0IyE/ktB3TUSXoZ0h7cmxolSL0D13L9y7BjKF7
         mzM2WkZnkCWwmcMIsT4w0IGgScmuDyub25tcAKgERcBipoFhezPiWkYje93n65xZEGSm
         Y1laGp5We+L4S0G6rib8C/1+HLWsPwM82L+HmZcQCis7wO7UJ0AmDwlmJq1UU+lCaUsC
         KUf09kJPmsNYV1iGJLEarAUpFosPHAi0W2yQA5YSPGXkuArQGKFCv3d9GgRlfj+Bgxpv
         86xdiyaeghmXAb0mbEf/CmVWFMdKPeCZ+rdfhLzaq0/1PcN2eXAqk4BKEFwGZ+9uNV0Q
         ooAg==
X-Forwarded-Encrypted: i=1; AJvYcCWdcgbFtoaQYAV0zqU/M3MG3t2n318hrTTGvv1UHL+J0/tKGjCBUuXTtkfyHE4t3HFFQMacYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8CVsogP+FTMM+K2V5k8GO6slwHuk41LmT5AE7nMOTdJx2KMZ
	NI1Edx3DlVr3ny/AmphtAl5qgtEIhOdxpiu99L1QiNLaIJVx/q79KY9IKmq/TMrgeTpkvyPAgr6
	m7nnlJhxi1ckLuSgDhSjFIQgGbz+qv4f5L09R
X-Google-Smtp-Source: AGHT+IFBbjED2EqikbdKhShjtfVb5PRKFRyT8EjmGDbN4ros8SSqreVtmvDbJs34rwQZ69DrleLNnaVEWKWJEe87q7c=
X-Received: by 2002:a05:6902:98f:b0:e20:2245:6f9c with SMTP id
 3f1490d57ef6-e2e3a65ebc3mr4443602276.26.1729718488086; Wed, 23 Oct 2024
 14:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-2-mic@digikod.net>
 <7751320f-cad0-477a-bed0-923dadfcf1cd@roeck-us.net>
In-Reply-To: <7751320f-cad0-477a-bed0-923dadfcf1cd@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Oct 2024 17:21:16 -0400
Message-ID: <CAHC9VhTH5FNnkZwOSZzRfE5jJTo=tHqvrcb11MwmJzQvquV8JQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT
 is set
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Oct 22, 2024 at 06:09:56PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and th=
e
> > dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> > are found by the linker.  dump_common_audit_data() should then failed t=
o
> > build when CONFIG_NET is not set. However, because the compiler is
> > smart, it knows that audit_log_start() always return NULL when
> > !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> > a side effect, dump_common_audit_data() is not built and the linker
> > doesn't error out because of missing symbols.
> >
> > Let's only build lsm_audit.o when CONFIG_AUDIT is set.
>
> CONFIG_AUDIT and CONFIG_SECURITY are independent of each other.
> With CONFIG_SECURITY=3Dn and CONFIG_AUDIT=3Dy, we now get:

Yes, unfortunately the error was seen during linux-next testing too.
I'm removing patch 1/14 from lsm/dev now.

> Error log:
> arm-linux-gnueabi-ld: security/lsm_audit.o: in function `audit_log_lsm_da=
ta':
> security/lsm_audit.c:417:(.text+0x5e4): undefined reference to `lockdown_=
reasons'
> arm-linux-gnueabi-ld: security/lsm_audit.c:417:(.text+0x5e8): undefined r=
eference to `lockdown_reasons'
> make[3]: *** [scripts/Makefile.vmlinux:78: vmlinux] Error 1
> make[2]: *** [Makefile:1178: vmlinux] Error 2
> make[1]: *** [Makefile:224: __sub-make] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

--=20
paul-moore.com
