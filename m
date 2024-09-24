Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422D18661B
	for <audit@vger.kernel.org>; Tue, 24 Sep 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219835; cv=none; b=I1+N+W/xkt0SgKKURjwffaQDfK9QBZaWK9kS9yUWm45oJg+scbhDrCNwzwn+y7H47PebRhk08pMFILSb37kgGKVKLBLZPI6NrGZS+vPtO8q0kRO+w57YcWnskAB+F/63YupgnyKXbCn30csLk6oY+4gMU/V7bGjj3ppUPhrKWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219835; c=relaxed/simple;
	bh=dCTuIyEupdKJi62lAkCUN6rhJtTPQEIz8/uT/xtgEXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KivCalS1itgjx8mhC75KhkOH+uef834I/gu6E1ztKnnig7Vyxw7fHLfvYnZUVyiQX2y/y+oN7kp+4q2hbJSvhHI3tVgW4GKDFnqxoa2SP1cNHQl87teItWlqEueFdyOz27NhIIBWsHKs4oxg37OceYd57kV7UWvrLhGJQK84OzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DIbpnzDg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DIbpnzDg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dde476d3dfso49941997b3.3
        for <audit@vger.kernel.org>; Tue, 24 Sep 2024 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727219832; x=1727824632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQbz1KV9DawuCKGwIlA9WAqzoJlKO0SVrBIhzZt0liU=;
        b=DIbpnzDgpp0Uorn5AOWcjIM6oOn1xEaIDIhvLNH57OfCxu6SkY6jg8sGRiAzlDuqws
         ePUhSpjJo5T07Rmo2bvKnav88xwYukqBHVqykKX+naU1HYtfrlmt1kMrbi0lqize12CY
         LuLTE7GUqoZCTUZAaSMyqpuixjedfHUFPLVoPnKfkBmMCTHFrX6g/wehQ3+eWtjnFukh
         o7RPcmfY15xaMlsXMQXS/lpm3fWaTEKhZnyoSzxgzHvSLOCm7v1xcF7OSjKmEC/E+/U3
         CSFcTtZpapTHqba66kRIwEtYYib6BhYLq9YT/yICBCCRsyvNuRuztMXSzLVkSl5Nzg9X
         LLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219832; x=1727824632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQbz1KV9DawuCKGwIlA9WAqzoJlKO0SVrBIhzZt0liU=;
        b=tBqKESCM5X4BDI7dRlwWrKFkpkvSIfLd3bmmC7glVyh7vRNtTN7+gM48PCfb6hRDmV
         qhd3j7qKzB7rCwoAOA1GbckwOJ05y+1/a7rPvcmilb9FApLxxHnZGo9n6rFiswBtNxgc
         bxOXDqb4ljjB56bKkcAfK2fuBc5pjdAFZWJPzV83eCJrRQTn27KotlaOUtcLsc6iAa7z
         PgTxnkmcYsM5XFA9i80SV1WCNguCbrKd9OJxtPN+6vTaT2CjR+Nq6QW1OZnHcmMyflbT
         5O8qY/WbNZ06r8c/bg+UDGXIbYq6rwmTnNljo7/6dQPZR105ALWYYiqP5EJGs3F1oQK6
         mzEg==
X-Forwarded-Encrypted: i=1; AJvYcCXokreyeYuKOFdDSO0aghO4GnvHaLy0s48+y7UzrzjK0DTmEzzFFpTjEp3Svx3Cl+4KW/hW6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yweod22bh//78ij4aCKbpTgNBNzL7z1uGoKyFZdiQWQpzddBiIt
	YD3jwrHPqCqXaKN03WhcGuElSO/6V1jD0PlSCwTi6i8tIvfeibWChfBF++gWdWaXVqToy24n5KU
	hl4X7RStB0ub82sU+bwAVocfSvgEpy6AaBhX7Y1BIVKkWERI=
X-Google-Smtp-Source: AGHT+IH4aRIyQqyU98Rdh10Z3hWLXz8ZHU3ntO6rXPkkvkLAunfU3PHMTjgosB+ymac/L0JJ7lv61EsN2BQzXxMakZI=
X-Received: by 2002:a05:690c:4584:b0:6af:eaaf:2527 with SMTP id
 00721157ae682-6e21d8a2b89mr8920407b3.18.1727219832337; Tue, 24 Sep 2024
 16:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV> <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
 <20240923203659.GD3550746@ZenIV> <CAHC9VhSq=6MK=HKCJ8KCjYNQZ4j_eCSgTpuYyHtk2T-_m2Br3Q@mail.gmail.com>
 <20240924070137.GE3550746@ZenIV>
In-Reply-To: <20240924070137.GE3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Sep 2024 19:17:01 -0400
Message-ID: <CAHC9VhR-c8T=KykMHKsovwzRKmpfSbQwYMjRQbEp-ojraCxm-g@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:01=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Mon, Sep 23, 2024 at 08:11:51PM -0400, Paul Moore wrote:
> > > Umm...  IIRC, sgrubb had been involved in the spec-related horrors, b=
ut
> > > that was a long time ago...
> >
> > Yep, he was.  Last I spoke to Steve a year or so ago, audit was no
> > longer part of his job description; Steve still maintains his
> > userspace audit tools, but that is a nights/weekends job as far as I
> > understand.
> >
> > The last time I was involved in any audit/CC spec related work was
> > well over a decade ago now, and all of those CC protection profiles
> > have long since expired and been replaced.
>
> Interesting...  I guess eparis would be the next victim^Wpossible source
> of information.

Eric was the one who dumped the audit subsystem in my lap ~10 years
ago so he could run off and play with containers.  Fortunately for
Eric I was much more trusting back then and didn't read all the fine
print before agreeing to look after audit.

> > >         * looking at the users of that stuff, I would probably prefer=
 to
> > > separate getname*() from insertion into audit context.  It's not that
> > > tricky - __set_nameidata() catches *everything* that uses nd->name (i=
.e.
> > > all that audit_inode() calls in fs/namei.c use).
> >
> > That should be a pretty significant simplification, that sounds good to=
 me.
> >
> > > ... What remains is
> > >         do_symlinkat() for symlink body
> > >         fs_index() on the argument (if we want to bother - it's a par=
t
> > > of weird Missed'em'V sysfs(2) syscall; I sincerely doubt that there's
> > > anybody who'd use it)
> >
> > We probably should bother, folks that really care about audit don't
> > like blind spots.  Perhaps make it a separate patch if it isn't too
> > ugly to split it out.
>
> Heh...  I suggest you to look at the manpage of that thing.

Ooof.  That's something isn't it?  Yeah, that's ugly, and since it
doesn't really return any user or sensitive system information I think
it's safe to skip - my mistake.

> > >         That's all it takes.  With that done, we can kill ->aname;
> > > just look in the ->names_list for the first entry with given ->name -
> > > as in, given struct filename * value, no need to look inside.
> >
> > Seems reasonable to me.  I can't imagine these special cases being any
> > worse than what we have now in fs/namei.c, and if nothing else having
> > a single catch point for the bulk of the VFS lookups makes it worth it
> > as far as I'm concerned.
>
> Huh?  Right now we allocate audit_names at getname_flags()/getname_kernel=
()
> time; grep for audit_getname() - that's as centralized as it gets.
> What I want to do is somewhat _de_centralize it; that way they would not
> go anywhere other than audit_context of the thread actually doing the
> work.
>
> There is a lot of calls of audit_inode(), but I'm not planning to touch
> any of those.

Sorry.  I'm a bit foggy from traveling, and trying to play catch-up
back at home.  I'm sure it will make more sense once I see the
patches.

--=20
paul-moore.com
