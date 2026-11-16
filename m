Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794858269;
	b=Lh4q0rf35KCQIDH+BPIlMte7W/FUmOtAytjnEEvxW7I+LVj0fJzh+9UJ0F7V1qP1tfjj
	 cLIghvcEdU53pOxreNLo6hxI/zq8ik/Y/49tUOFEx8nSdpm7SgD0mG/ktMG2yqFcvzVye
	 OWnw4IDhwp8z3X9NYR77oOPhGo8CW2u5ZDwnjNwaybltC1qG9FfeiamuK94IR0c8xICvq
	 9qpj+TNu5VbbUszsdR2mmGGuYGtBSVB7D0kZGdu35++phmEPK4fP7ArkgkhjTbQSpLDuZ
	 M0lb6P86VcQBrOG06u6y9YwasX5joqwhQluZ6nlH8V193EWMwZAql4qMG5HKa3YS43Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
	b=ujDz91/fz8aGp3HGyUHRwphh0dLMzvLuebmuXJXwcS+22hVbAtuSYeXNWBvwyblS1Z/F
	 xswKaPWJEhYkHbiSMDSmkIIQRK0VxVWQlLU7qgvoxUqnIn9FZBKaTwcJNnDwrc1wxQ/en
	 R1gF97vCHUH4vViyvftH24UZvXvtv8JD+FdoDg/rUp3oakOKmK0CXFa8KId6PlpV2VyNJ
	 4Cp8d7g1vXSiwS+oShPVWk47i+WecCiN8fybYuJ8iLwWJMhf1hpFEdZYqYCbu7AbExZt2
	 bvUrC0F3WTdKQ7bNX5zVJ1wIYWywdE0gfp1kQcrEmSV7eKzdd62QyDI+X1efabgNcLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BB273hOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88904606A31C
	for <audit@vger.kernel.org>; Mon, 16 Nov 2026 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88904606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BB273hOl
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1920062b3a.3
        for <audit@vger.kernel.org>; Mon, 16 Nov 2026 11:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858268; cv=none;
        d=google.com; s=arc-20260327;
        b=HMy6MAqLqQBftPsXe0gXHpHGWCOYdgadGhDxAgOGpenS/XcOI0TsIw3w9/KFiZ+q6q
         80KvCF9jZZRJGXYl53UOY4IOsQhbgTr0yb78x6tIWrUsRS11i5w2Qhqj2YHXigq4ORTK
         /5hF0kT9opti6V1NxdshEYLYw0fElQGgIILwSRkJvfdK+5iBxzRTV4TJX/7BIvRaHxzQ
         QcAznhx+1hrzxPe8tFU3IvXX+HZTv5eZth4aIMpzb/g6CQBX1IbQRwipKempyLJpbKI7
         /oH4dA7cE7b1KWVcZ/5uuermiNMGaMyxHheIU/gAvpO0SCi2oQKIDJZJz5wHHkYj47tR
         ATNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        fh=e+VaDo8tboQkQBO6WXmb0g46/5t4AC7IQN67zgIwMBI=;
        b=nhgQXrozsEq4em77QJpe6ldsiGneKQGkEivCglaHlzazvJaDFcewki0Gs8aPvar9Ee
         jQNuiNk7dn3cVCAZAEkvqrimakg1uGZ2dyBGdbzY16a444udhcKB6qCp4/57e2sUNKIX
         Sp8LLSrRUcgJ4YuEhUxpZBPyM8/PSEMYcfcaTjicz+N84mLjYVc3cBE1Z0CxrCJcOk/U
         wZZ2i/3NRUUWNpkEhSwo+GIK96cwFUjYhWJh1ybpANMLL64JoEK6WAUi4O9467oUV1k3
         8V/ZuCiEap8WcAMIMPjkPP6PhTUDal8lugm6HzhO8Z3Yicagj/1AyidOWspHgZB4pEfx
         xdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794858268; x=1795463068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        b=BB273hOlp1RHicNqOSt1vyZZx7QGtqLiqUQwym4iCeGlGbQ5Sucmn3aYqnXXfAAaCr
         pZvtAbeGyk6DSrDkYP8/v/Cxb7IAtTfhWbJ/nG8+19tmQLa/QUYN0ms2XUzO9EOwR06p
         3jjf5Whzo9aT1swlNxQJx2BG6riCNowTM2BDcS0OO6PzQCyP8+uQcyUz1kBpXmxYbCOT
         xxF9uJ5+bd75IHiD1qou/Tw9FSDQfCyhT19/r7mJmbXBROb4dTmn+tAkmpLEJG/U9CYv
         Ky2sx9gEwcEhlCROugPhttKTwKUj4xI8DIyjit1a30pVEgN+O6HhBEtzu+O4tq3t0F4Y
         ZXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858268; x=1795463068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        b=tEDz6y3YwLhE5/wT1lX5S+Hjfarse0mpLpxHShqFhYQBExagzHrt0Qr0d2YAt9A/K5
         UE7fxRRVj3JK2ZmYP+dQgukg9DHaII68xfOeEMM7RPSxPuquWEF5PVg74JwufwU0MH6P
         2ZEOsb5atFUnfQEqzfZmRcSgz667cRRpdMUTRVopsi2rONsMimE/VrqJZRGTETmmkCAr
         GbTO+GBbN5Kd2WKkH5isIPLGo1ZRi9Q5hoGGxKrZtxrnc7FZvgyhfrsjyGxnTGK9QSiZ
         +Vauk/JTIrkROlgCLT92az8flFviKP+IMrmeruxvX7+/BGMJ3DfJ7DnnauOlCS78RI3z
         UHtA==
X-Forwarded-Encrypted: i=1; AL+hErGzNoXNad326YQum8NOzl3PnpDdL7Idz10ucZl+/CqM0xxz5RHnqpw136ON7F7Yfw0sWnU1HA==@vger.kernel.org
X-Gm-Message-State: APuU4Z94e3kak6SauBPnUdQVTL0XS1uwEhecWWhSON6qLRCmG4lWDgk3
	RiWdXQV7NNErVYtzYUQqR0sOe4HoYqU3j1kTZtYjyQjMKfVJFCGBdnFO9K+bqbGPEbnbY4WK/J+
	8HDMEeXEUio3wGfwnTb78Ed8i0+PUDgA0Zxxqy3V2
X-Gm-Gg: AZFdTZeNhEvJZeT/WmJ9OZ7aG+byJUHWTS+LEhxOqjUhiC8FDWZDII4jqgOwvBbHR+l
	80eEOvdFi2GmCqmMsQvubCQ4eAXtLsKmA8wwo+Qw3PMHBJOn/Ji6uHubFIyFn8iRPyKOtVo4A/a
	j+G1TpxOfwDD5zUkjn+HEw9WGPUh9apepLmqmsbRkiM8CjoO0Q21XbX7vvYAUDwjaWG2Y0m1nzm
	uli4gpjXNtUCnnAqHdSy8hm4x2om2vDgu2DeCYrzYt8rKfireGoiE+3qxuu+y5Jw+zGHO2/kWrW
	R/RJM3QlwFFfZ+x7NM8COEwiEBof2MJDCgERB5CHlPgxDgLmKP1qJFQcrCO+QfqDInEZMQfQV2E
	wwPXDuflle7Q2XIcfghfmZuMzkUwJsRydcsDC02VUxeT8/tjgEWK4mK/NqLLE3Yx4yqJd
X-Received: by 2002:a17:90b:28cf:b0:3ac:8dfe:8ec9 with SMTP id
 98e67ed59e1d1-3b1b0b47416mr9502656a91.47.1794858267644; Mon, 16 Nov 2026
 11:44:27 -0800 (PST)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com> <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
In-Reply-To: <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Nov 2026 14:44:15 -0500
X-Gm-Features: AclHuK9Yi3vY1OnQknBBHtyXXbTvT6zYozVYLT34YTLRhSFwwbQtKY8uTdDr2v0
Message-ID: <CAHC9VhQECaSwpjUgSoCgZAgEphEk2jKnZFESn4ivM6JAjrC7HQ@mail.gmail.com>
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Bradley Morgan <brads@mainlining.org>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:44=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
> On 2026-11-04 21:36, Paul Moore wrote:
> > On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
> >>
> >> kauditd_send_queue() grabs an extra reference to the skb header before
> >> netlink_unicast() since it may need to retry a failed send. If unicast
> >> delivery reuses that same header, the receive path stores the
> >> destination socket in skb->sk without taking a socket reference.
> >> Consequently, after the receiver consumes the skb and closes the
> >> socket, the extra reference taken on the skb header makes kauditd
> >> release a header whose skb->sk points to freed socket storage.
> >>
> >> KASAN reports a UAF as:
> >>
> >>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
> >>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
> >>
> >> Clone the header before netlink_unicast(), then use the clone for
> >> delivery and keep the original skb only for retries. If cloning fails,
> >> handle it as -EAGAIN so the send can be retried.
> >>
> >> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages
> >> in case auditd comes back")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> >> ---
> >>  kernel/audit.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/audit.c b/kernel/audit.c
> >> index 9412af9144bc..5e739fa606be 100644
> >> --- a/kernel/audit.c
> >> +++ b/kernel/audit.c
> >> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32
> >> portid,
> >>  {
> >>      int rc =3D 0;
> >>      struct sk_buff *skb =3D NULL;
> >> +    struct sk_buff *skb_to_send;
> >>      struct sk_buff *skb_tail;
> >>      unsigned int failed =3D 0;
> >>
> >> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk,
> >> u32 portid,
> >>              }
> >>
> >>  retry:
> >> -            /* grab an extra skb reference in case of error */
> >> -            skb_get(skb);
> >> -            rc =3D netlink_unicast(sk, skb, portid, 0);
> >> +            /* Keep the original header unowned for retries. */
> >> +            skb_to_send =3D skb_clone(skb, GFP_KERNEL);
> >
> > As Bradley pointed out, this appears a little confusing as the existing
> > approach of skb_get()+netlink_unicast() should end up doing something
> > very similar to what you are proposing due to netlink_unicast() calling
> > into netlink_trim() which in this case should always end up doing a
> > skb_clone().  I'm sure I'm missing something, can you help me
> > understand
> > why this proposed patch is different and solves the problem?
> >
> > Also, do you have a reproducer for this?
>
> Dear Bradley and Paul,
>
> Thanks for the comments. The fix is closely related to the current
> code but the main difference is that netlink_trim() does not always
> reach its skb_shared() clone path. Moving the clone earlier in the
> execution avoids the UAF.

Thanks for the detail.  With that in mind, I think doing our own
clone() is okay, but the ternary operator for error handling is a
little uglier than I would like in this case.  Removing that, tweaking
some variable names and comments, how about something like this:

  /* clone the skb for retries in case of error */
  skb_clone =3D skb_clone(...);
  if (skb_clone)
    rc =3D netlink_unicast(...);
  else
    rc =3D -EAGAIN;
  if (rc < 0) {
    ...
  } else {
    /* consume the clone and continue */
    consume_skb(skb_clone);
    failed =3D 0;
  }

--=20
paul-moore.com
