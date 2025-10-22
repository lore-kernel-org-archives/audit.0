Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D3280332
	for <audit@vger.kernel.org>; Wed, 22 Oct 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177107; cv=none; b=KYI1MHSDLVaAyMnjZBde86tYNJWU+bF1nT2KkTSz0xWYVHd6ItNFPTyKizJm+nspaYQbKoRrvHJHJeNjMQzh3foflUIBUbPmbhOVjGMpkNPhV10mxpopmdhaLsFzXcBEb9UPKl5onyewB5hdHlrAWF1rnVzp7Q/QlJ2BijwtR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177107; c=relaxed/simple;
	bh=0HnkBz48QvJZzXednXl+94MDFURz3HXUwL6Q/CTRJCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKq/9eKB1OZE2jL/qeCCnQxv48yMz2v4N/Jv4DcZcBAHljx6GAxn4y9LZgEO6AkKBb9BLJXY8Ubul4vKvR9XNcZnG0XEkxzCaK3iQgGHYsp+b+1bQjjNZyfnyeZsYXmEXTkDyaRorcLamDKcQVRdlLDZ3z0I2RZupv7zOuzkjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fX1+yfrr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fX1+yfrr"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso236488a91.0
        for <audit@vger.kernel.org>; Wed, 22 Oct 2025 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761177105; x=1761781905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRk9MlmPKR5HFU5QEYjXFuCzewos+jdNvVe4ZWQ9TcU=;
        b=fX1+yfrrIG19BcExMWdFZCbJLhg1IpzrMhxd5QLLqenfCbyIyyj6eKTvtifobjT4dE
         5HnqUFvfR0OOfbr1nJUcCO5nj/GKXjQVYpHi969xh5TR97yeMZxbHqQWgICLelyKoeuI
         RLeX2bXhsoqXbuekIvP6o6i5Fi0vKbj7Vs/dVHcpWTqOSaLzgBcv0ULaQSpoXx1WIclB
         Li67y08h0ihW+VeG48uJ+D3BHoJu6rIktcK/Ft9faDh88Nu/wwiKtOR1P4RLtJcl2LsF
         +FQ8qK7QRg617vtCww4HhV2/L8nRCULt0gdu439BUNpVE/W6f5JlX8xamRVTLWf5icTh
         Wy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177105; x=1761781905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRk9MlmPKR5HFU5QEYjXFuCzewos+jdNvVe4ZWQ9TcU=;
        b=Rv/z029BHeVeHal54saaaUtKP0nSAxZWUs/50417crHoMksji7/Ye1y1lzKFYaXu4H
         zTWLNoH2LU38C96ks99qPDuWBjVbrYL5U3q00iwS49PUC68iQa6ql3t4XY36KfUsTEo5
         1bVRw7IvsvoPhZTDS5zMIoYqJYf9327XwKCEoY+uePuNVXvuKFsEov7J5MuDSAlaBpUU
         tyaYpaROf++4WYx+R/q8DqSWtB8VJIarid+0c8/Pj5XEg/xQUF9kXO2qAdYZyy7TYDxU
         JBn0ul+fgTUAskhArF4vY/L041IVSr8PoNWcrKdu6nXAnHxyMnVcluzmME2xDhPRkmxA
         Q9uw==
X-Gm-Message-State: AOJu0YzkV8Gsq+S5BqpI3/sDYuAYr8rTK4h4sNH65uLHO//ej8k/GClt
	maiLQCbMtvaOQqqlUan+4d1+1vH13nFePmG6H53vOTwyQPQGa6s00LTmK3OiV3zSB4EAwXHlZw7
	BNmqMFKVbpuE29M16KwbPhxsqbg71DleN4lZJm3/kfeaW4AnffkgRVA==
X-Gm-Gg: ASbGncv1jrBjBVidhKVhAPdQtpc5G38QHUTnL86ilZ4EYTrjyV/mThmkAdeFbDTOyrm
	LGE9v34AepolBX5cvrMo7pqDBS3Qj1ALAT330YfwpXTbYulUG6MH1ZPYFRM5+4Xo/97rSzY2oLY
	juNJ48mcGYVB6TMr6ge/bOuh/J+q71vGoksDVI9KyT5yBaCFs0sHKrppYtBzKpEiayw5qMnToi9
	1kWScteYAQWQMa9N7zduTnHyqvkaRruZCdjiKhUS5HPra1sDPc/HrQdR9CR
X-Google-Smtp-Source: AGHT+IEwlMaQOl9puL9H3j4RVRiWWH8p4tkZvmQ7L6tcM6YoBaILSohUr8q3A9r3E/tgEkjIQ2tQrqckVMxJhDQ8xwo=
X-Received: by 2002:a17:90b:4a81:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-33bcf8f9431mr26817603a91.27.1761177104952; Wed, 22 Oct 2025
 16:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022123644.1560744-1-rrobaina@redhat.com>
In-Reply-To: <20251022123644.1560744-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:51:33 -0400
X-Gm-Features: AS18NWCjjxJDVXK6gy0ArW4uTuZrZUzZEn5H76dSeZUzjVGBghkWg95D0azSWLM
Message-ID: <CAHC9VhR1PJQKZgLX98HMkmswQ9XvDtic6jFuqxSssY9_qcdwaw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
>
>    # uname -r
>    6.17.0-rc3+
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
>
>    # perf record -a insmod loop max_loop=3D1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
>
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
>
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
>
>    # uname -r
>    6.17.0-rc3+-enhanced
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s

I couldn't help but notice that these numbers look *exactly* the same
as the v1 patch numbers ... ;)

Assuming the rest of the patch looks okay (I suspect it will), there
is no need to re-spin the patch, but if there are different numbers
you want me to use I can update the commit description when I merge
the patch.

> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

--=20
paul-moore.com
