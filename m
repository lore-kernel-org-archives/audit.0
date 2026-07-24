Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E035675B
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862664; cv=pass; b=tJrYzRw0y+VYVHDNW+kCnPXDgr/mheXqLfY9PT0e3OIkEw+QY+xP9f3K8tes9Nuzzovs9RyivPeLW0hqlpY09uljS14JPGJMc/oo6bitKwfAsgMSTgiS+lrmqKgcyvf+0mmIaz99sK8YbaQQUtfhvxsr4Mp5HXt65+QSo9UM2FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862664; c=relaxed/simple;
	bh=+I4dtaJ768N0kF5UiJ+x93KaSlpAG8xp8Au9LLgOcEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKyM9cJikIxrtIsNHLB5GSnAZikqWPpooJ1v3nRU+PFQa9KjBJ2CvbaQQoo1s3LHaTqStgqY/mbn16cko6OxpITgWDTB0lQCV+IpuWKdxnT5XkyEzS4wiTHTBtIvFWKA6crgPwATcDa2lr/E4bNY70kY9ZX5pnAEJUXFpNJy1ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZjKdls1; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZjKdls1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-caf707e3a70so755263a12.1
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 20:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784862663; cv=none;
        d=google.com; s=arc-20260327;
        b=Npeg5hQnQzlENG/h/E6rinuURaRtm6PyQElR8pmONaRUfQefZuwIEbSu77eZYcyLoe
         D44OPRVEGMBFM/zJwUmw+2J9Cmf5ruqco2gLgwHL6gN7TpJbAVgume38q+eJN7849cVZ
         f3rzAW9O4k+bSFYW8RBsdKp1nVvExU1hK9irweniuKcpAd3yrhofw5eFdt9BV8OK8Hf3
         yr5JaDeUtQ+czHeQTgUwyV7KZNdeuOGcwJ4m9KvCo7KC8/lNhjbCIJOgXzUNJLY33Q5g
         jZHJRxyVLy0g6ZRUUiz+vv9XnZTqbFewxGrFP/7xKfDlUDYH7R0rv0SflxW1rp1VejxG
         RWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oini/OI/QBm2a4uYSCQ2NOBdRIM2Sdi03pY0L4LOAuQ=;
        fh=IjHzTGflghb3EOQZqDR+pAYrQBO99u78sphTxl3hfZI=;
        b=LOccG8G6mAsyNX0gsA7HQiLkP9T/iBg6ATiJEaA2I/2QGpq+fyf7CHMnNBC/jFLKE/
         1YQ+UQTvV5UswLxdKLD/Vx6ScSnXj6+MQ25fqRTaVtnPJ2vhtSZ2Qg2WhjXNT8kqYndR
         HKwUJV0gpdOiDGP/JN96KcR9zrJzH5ros1fB8S7ZR4jYPPSz3ppTgd3LUCBanabHPKLq
         WLuHTf1Vc/2GsDOu61t/+9mBMdWE4NfllBlkSmBgCZR4nsU907+AE/PWNhdHKdS0I4Z7
         boDC+JKiWidTpgk35Mld5dNDycEKcwqY9CiybPHNS6kqombIF1Ais6H2W5omHPK/RPqs
         U9eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784862663; x=1785467463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oini/OI/QBm2a4uYSCQ2NOBdRIM2Sdi03pY0L4LOAuQ=;
        b=lZjKdls1Tz4pr6RtK1/N+ZtnX/IPZKRMaK9zyOux5DV6sly3C+CHSXm+rUKBrFiieB
         bm/l1YD3eUOOzrG+8uzEAkGWtkKuCXoSI5JcT3LZSO9cHuD6niQCdpV1iTooMMAYcgVY
         3Ri++Siyc8FDXfpk84+PftnvNHGxq5GE5R2vfnPX3JnQqSLj7qpDMjXDnIROUXCDJgs0
         EriOnH/YE7+mTZOp6SiMD/WWDxZXx7JFsOr0P3CkjMU+buoGo2Mb7MRHucEW9pnU6VUg
         ZZIW9tms1UgdsZux+gJwHi54jhWmEokcyzNhib9nF4O/nANVvpng0hKkkvzBVwV7BUyA
         14gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862663; x=1785467463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oini/OI/QBm2a4uYSCQ2NOBdRIM2Sdi03pY0L4LOAuQ=;
        b=ahmJrYLkAWBt6OFUO6LwvR1LbC3MoYgyXDbRQGQAIzZCIxsPWMztAwN/TqVUELr/VN
         d9GGA0tsV4SIXVmdrgFpnvsUJyhurAMO59ITqqYefRHYfPo6KJaik3Ke6Fol8BBlxT95
         zoAxBGR6XCYtiSHVb89Q8njFVhdkNp2Hff3g6dRrsb+NcisUFUbLVlHvYvx2Cx8S1sBE
         7eCs/MQ4AEvqZCe+PsGJvGgj3TR1Q7HwfV8ZVcjqEPoSIIBiNqvPhIgYP7r7iyncNLT6
         3tdLRyn3I9CCOfxIIO7qBVB83erXDnyHnFYwVjSnU2feA5dDDD+ya0ciFX8yiS1O8VF9
         /rEA==
X-Forwarded-Encrypted: i=1; AHgh+RqZD9cI00J/1lfmmBtqvHF2+wmCzEKkmFIjK5NX1BhkTtTsZn2W79PONBg6lCQAYIe6DzgI6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OKvRdrDHuNkZJHjCsSp7RpvaUudv9p/Z2LBKWi1dB0BGVvfY
	pusLizABD9zkQmxmrmWSfzVG+hwLPJWJE4sW/hNZLoY4maFgsjPCfo0TZUhLLecsUd0MPc4F/jI
	gkzbKb6yT71e0SFOEJLUCeCZjUIG0m5o=
X-Gm-Gg: AR+sD11NK2JV/bI/p6u4QTQ7d1HmTD9MLbG6hGpI6ROuSWQQVOBOBYWZJzOA3QvtH5A
	WS+5J0dIujQcKaq/8sb0xba4W4oWEq6592hsQXRAO8zYYyZpaUF5NksUUnO9o6zoolbYpCK9SL5
	nhKmLrvP2IRjXaWiCAloShzyO10w6DTrgXgNeOZO9P+Q9Aj0nRAXTpe6x45hrygWfr2cfEM/aa2
	l82qPEGI4amBxRMv4fkaZmeIYUoLRZPZ5w/+SOshz2XVijtZ/j1BAKUcaWj
X-Received: by 2002:a05:6a20:734b:b0:3b5:530d:d96d with SMTP id
 adf61e73a8af0-3c44c99eee0mr6046766637.12.1784862662828; Thu, 23 Jul 2026
 20:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ffdeea400054f4d42e394d09003cb4dd5ffe862c.1784611349.git.rakukuip@gmail.com>
 <623bf8c0c7725ae7d93d7c0847821212@paul-moore.com>
In-Reply-To: <623bf8c0c7725ae7d93d7c0847821212@paul-moore.com>
From: Lain Anc <rakukuip@gmail.com>
Date: Fri, 24 Jul 2026 11:10:51 +0800
X-Gm-Features: AUfX_mytB54xIzRc-Ce3wO0Sgq6-gIO7LK5hGHfQi-Z6baZZ0gEJsCIdCYdsVFQ
Message-ID: <CANZytUwnnaq0U3UU3R9ZhyyW=E0mF2+8uHFDtjodk8QMCcDK3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] audit: fix potential use-after-free in audit_del_rule()
To: Paul Moore <paul@paul-moore.com>
Cc: Ren Wei <enjou1224z@gmail.com>, audit@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 05:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Jul 21, 2026 Ren Wei <enjou1224z@gmail.com> wrote:
> >
> > `audit_del_rule()` destroys `e->rule.exe` via `audit_remove_mark_rule()=
`
> > before unlinking the rule from RCU-visible filter lists and waiting for=
 a
> > grace period. Concurrent readers in `audit_filter()` and
> > `audit_filter_rules()` still dereference `e->rule.exe`, while the fsnot=
ify
> > mark can be freed on an independent lifetime path. This creates a use-a=
fter-free
> > window during rule deletion.
> >
> > Fix this by unlinking the rule from the RCU-visible lists and invoking
> > `synchronize_rcu()` before calling `audit_remove_mark_rule()` (and othe=
r
> > rule removal helpers). This ensures that all existing RCU readers have =
exited
> > the critical section before any underlying resources are destroyed.
> >
> > Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > ---
> >  kernel/auditfilter.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Thanks for identifying this and providing a patch, some initial thoughts
> below ...
>
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 4401119b5275..7f791afe5791 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1045,6 +1045,10 @@ int audit_del_rule(struct audit_entry *entry)
> >               goto out;
> >       }
> >
> > +     list_del_rcu(&e->list);
> > +     list_del(&e->rule.list);
> > +     synchronize_rcu();
>
> I generally prefer to use call_rcu() instead of synchronize_rcu() when
> possible.  Did you consider creating a audit_del_rule_rcu() (or similar)
> function which would perform the other cleanups/releases below this point
> including the call to audit_free_rule_rcu() which could then be called
> by call_rcu()?
>
> It's worth mentioning that I didn't verify all of the code involved to
> know if this would work, be safe, etc., I just wanted to check to see if
> you already had and decided synchronize_rcu() was the only option.
>

Thanks for reviewing the patch and for the suggestion! I did look
into using call_rcu() for the cleanup, but we cannot do so due to
sleeping constraints in RCU callbacks.

Specifically, the cleanup helpers called during rule deletion (such as
audit_remove_mark_rule(), audit_remove_watch_rule(), and
audit_remove_tree_rule()) can sleep. For instance, removing a mark via
audit_remove_mark_rule() eventually calls fsnotify_destroy_mark(),
which acquires mutexes (e.g., group->mark_mutex) and can block.

Since call_rcu() callbacks run in softirq (atomic) context, invoking
these sleeping functions there would trigger a "scheduling while atomic"
bug.

audit_del_rule() runs in process context, which allows it to safely
sleep during synchronize_rcu() and the subsequent rule/mark removals.
Therefore, synchronize_rcu() appears to be the necessary choice here.


> >       if (e->rule.watch)
> >               audit_remove_watch_rule(&e->rule);
> >
> > @@ -1062,8 +1066,6 @@ int audit_del_rule(struct audit_entry *entry)
> >               audit_signals--;
> >  #endif
> >
> > -     list_del_rcu(&e->list);
> > -     list_del(&e->rule.list);
> >       call_rcu(&e->rcu, audit_free_rule_rcu);
> >
> >  out:
> > --
> > 2.43.0
>
> --
> paul-moore.com
