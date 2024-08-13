Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1B189901
	for <audit@vger.kernel.org>; Tue, 13 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588302; cv=none; b=hgRQ9e8g9MMSa4OSWukduTfs7/UD4PMGzRunBLrkSnUjzA838Ce7OIzo2EZPikDqhRGZxO6J/u9ZBGLBGj2qyXrqLgBDZfxoBvhNbfi7RHDDy01FGKhldr5KbTI9I+EMIk8eOYjUggTSKLL2HK+3B8exqgxKV4aNkUr4wlv4G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588302; c=relaxed/simple;
	bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOcmODELtwhxCk6EcYUerPiAGrsbEWV7VzVFV3Cu05cTNU9WCVlDfC+T8LT5jgXz4B7il6/DA04Mk2hjH6invd+im2x6cpSAZFMvKtxHAjxNZE3g8p6dtY+aJ02jyGxaV/XMeJaHEwLPmiKKHsPi+4j350DMZnadDcEn+4357lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+j9ex3p; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+j9ex3p"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-492a09d4c42so2113601137.0
        for <audit@vger.kernel.org>; Tue, 13 Aug 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588298; x=1724193098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=D+j9ex3pJWeRWjq0NBYRAHJ12rIjeopGts0r0GTgjexMWWliauckLTij+u2/DtqaWn
         IPQXwFUz1MUSigu0oPStUaFqzldIUc6ZItrjzNZ/XMk8CJsMoIBgaw6AdgZAnuJ74Mif
         HxjrmmUY7YEzRN4Age1V1a/oYDZTMq+Ml6HWBArv3qWfb6CB9PbAegBWfG+qzwhxG1RQ
         8SxkWeeBd79wsXNDRQvBmgxkybLm6z0e9rqqFzohuML5RHyHVhs4s4sDyHpNo2DNY+wi
         +Uz/c6UKDHSB47b66QDOI2Pe1KXWo0XtrMjFe0TmfKB0ldc351LTEsWBPcRG8r1WJ/Bt
         079Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588298; x=1724193098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=MstblEoDMr0GjgWogZNYS0hnzYxb98Hi3kQjcMB6FwPwKL8ktzXVElr++abYOoa+7m
         oIp8lVScR5OG+lRVRzlrzuf5ZZb5sDdHHLp0jtCLF+n9jlyw1CrKP1BSkQPNHcD9wNM3
         oqX3zQrm6tPs1JaHqVerB6lnJyELUFJL3vn4RTJR2nMUVYUWGQTZwnYa/kkQk86IFwiq
         D2BaFHUBa7UbRKclePfvffWpRGwSV0skcm0BB5ffMK0ffhkmXVSYA73udyEP9WDAu7uV
         g0wHbLRIPr26vVsElLGoXgbEUSNwMJOrfP9DiLI4qtCfz60CTR9qeqU36n1vT8GMfOC6
         8Bpg==
X-Forwarded-Encrypted: i=1; AJvYcCWK1u5MTIC/JU2EwOHB0E/KlaLnhggq/ToOJtgf8bl2/BHYLSTv87FmmGCzgeAci54E1q0WWhZFOQjOU/w6FF/Hci3UyoI=
X-Gm-Message-State: AOJu0YxykCNd70yEhHy5KfQLgmBUJz8FGJjaVOnpQpnlPg90Nzpw+UuB
	FARNp9aRxNhqi2QgcmlJQiA/4kS03OU7DXxuzz2/NYPNoYB5c+vyDhu9mUzOjQHGdgcksORaQX9
	DEUlDR6mDkGphWDkgsazls/edlj54iJC2BRnHRqOURSd/VROUT3mAIMM=
X-Google-Smtp-Source: AGHT+IH/QraxU2fjWjOPkx0WDZKuaY29L3Zen/pzf+3bC1KTX13QSkaN1GEjq4vqJeNmusG+MLJVL3jxUBZoAMXwy+8=
X-Received: by 2002:a05:6102:c04:b0:493:b4b5:4850 with SMTP id
 ada2fe7eead31-497599e9a02mr915097137.31.1723588298200; Tue, 13 Aug 2024
 15:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-8-laoar.shao@gmail.com>
 <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
In-Reply-To: <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Aug 2024 15:31:26 -0700
Message-ID: <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> > Using strscpy() to read the task comm ensures that the name is
> > always NUL-terminated, regardless of the source string. This approach a=
lso
> > facilitates future extensions to the task comm.
>
> Thanks for sending patches replacing str{n}cpy's!
>
> I believe there's at least two more instances of strncpy in trace.c as
> well as in trace_events_hist.c (for a grand total of 6 instances in the
> files you've touched in this specific patch).
>
> It'd be great if you could replace those instances in this patch as well =
:>)
>
> This would help greatly with [1].
>

I just saw that Jinjie Ruan sent replacements for these strncpy's too
and tracked down and replaced an instance of strscpy() that was
present in trace.c but was moved to trace_sched_switch.c during a
refactor.

They even used the new 2-argument strscpy which is pretty neat.

See their patch here:
https://lore.kernel.org/all/20240731075058.617588-1-ruanjinjie@huawei.com/

> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu99=
v7+b6AyHMmaDFA@mail.gmail.com/ [2]
>
> Thanks
> Justin
