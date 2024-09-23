Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43742907
	for <audit@vger.kernel.org>; Mon, 23 Sep 2024 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135368; cv=none; b=k/rTPUGgVf8xTlUJY+vKXuhrrA8tZPXEjfCnI9PdnNC78JNuPo1Bmlm0xK4Jg0YBfXFWCYeeBqFeF67mICHmVeN0euG6Kz13YCKdqU1FUSiLp1i7l+XCQ2ECvS2YOWv4bjN7vKSH5NSuxp2IQNFbdAXV5Xz3/+W4DkvOm6lxOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135368; c=relaxed/simple;
	bh=HU43nzvVNk9+05verNfvUGl1WsBlPAb0vAlHXWXhn18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIJ5DTz9dWz9Z6n5Ou/CTTxB5D3fuSDMB/rEOsCg5dz0N7nvwi1tT5iK2MNQxyizFT5Oo+4mu4GFFg49ozfr3PGDyY3xSwExW9ETPfzZSlAOzMKXUqVaXjjQHFYS38KlbqdqgZK1bI2adi6lT+Rjm5hMbtxQqbF7oXqFAJBGLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VYud4bmU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VYud4bmU"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so4586552276.0
        for <audit@vger.kernel.org>; Mon, 23 Sep 2024 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727135365; x=1727740165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cLjKvwxneJcBR6J40T7jZrecVgD/PcilkfSszPFN14=;
        b=VYud4bmUy11hl6eocVPRUBzHEeWNF2jCk+CLIxDwRJusg4y6VjIRwOBe3RZQMkHrTX
         KwZTp1dObixddpjjNJe3APe4gdffd5UuzzrrTGJbMX6kCCh2QZiJPcxdN6c0GF0ll0Xe
         OZRynlUJci3AiUv5VYXo9nuH8bISs0Ibge/emNM6KekRYk3qZ0d99rUhpyP/fZqayrE0
         zwrRpGWzXSYJsHwE1TtPyt69/0vUwKsHEOuULdIqumbgsD+JhFdarFtOzjQau0HHl3pd
         gXFiImLHaTYhKHQoAe8xbyTuxyv1KEmCf9zHv4BmKgRRrXCU5j2lok2350Qh8y3pkFDY
         jsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727135365; x=1727740165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cLjKvwxneJcBR6J40T7jZrecVgD/PcilkfSszPFN14=;
        b=C5gyxxoHwTFRtO0qYLdTWfy5cwGOuJ0qO3xOqBNIqXogpd/x6jGFPBtGB0G+hb2RdS
         llgF77178dkCJ28Zi/vmHrdy69whc+pfHxJ3OmC0RDoeRQZJtp8qP+1LfJGKL2es//6i
         owwe0rPzU9CdcbqON5bKFo8P430hOP3+nNux7adPLBnT6Ol5+BWbmQ+0vGqsMbo+nBFE
         1EbUoLRgL+VWDunNAfaU8X9rJlPu3uvoO2TMGfIZTPdqDYCi1ACgpMl72f2ogYrAK7p3
         M1E0rcOSfkJ7wtyeU0Bu34/rHv2+1cAsPm6B4IQ01G/nMPekVryhmO21jWTHjPDwOJs4
         cg+g==
X-Forwarded-Encrypted: i=1; AJvYcCWcj4Nj43vhWsljOZfrTtnaLxkIklS4WBq/4YOn7VfJFpgc0QApwm7hXtiWZdZcFUT0FkkD9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZt59RYqJrSZNp1mH70YemD2b9xU9F5EufBoPeMsgmjwHcr0RQ
	B3KvGYnSPVJ2rY9vDq9wf172jbmgT+nQOrIjB2SyWO99KBJVuYucMIz1ztMrf/RYsnSylaEPRQE
	KZofBnQxnXLJZp0PwBIIqZ7ra+UACsLVdNOUn
X-Google-Smtp-Source: AGHT+IFw7+U6BIUQhoB56ZTnhfxp4VWC9o3g7D5THvWYs9Gj/WYzoDtYtT/PRTbyV9s5j2eII9uhk4RoLsH6JASzdhw=
X-Received: by 2002:a5b:b89:0:b0:e1d:9f6d:2eab with SMTP id
 3f1490d57ef6-e2497901e8dmr981637276.26.1727135364823; Mon, 23 Sep 2024
 16:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV> <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
 <20240923181708.GC3550746@ZenIV>
In-Reply-To: <20240923181708.GC3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 19:49:13 -0400
Message-ID: <CAHC9VhRBLxOCwU1aBY6yu2H0YwmvQdJBDy9OJ8cG36JCc7GkJw@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:17=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Mon, Sep 23, 2024 at 12:14:29PM -0400, Paul Moore wrote:
>
> > > And having everything that passed through getname()/getname_kernel()
> > > shoved into ->names_list leads to very odd behaviour, especially with
> > > audit_names conversions in audit_inode()/audit_inode_child().
> > >
> > > Look at the handling of AUDIT_DEV{MAJOR,MINOR} or AUDIT_OBJ_{UID,GID}
> > > or AUDIT_COMPARE_..._TO_OBJ; should they really apply to audit_names
> > > resulting from copying the symlink body into the kernel?  And if they
> > > should be applied to audit_names instance that had never been associa=
ted
> > > with any inode, should that depend upon the string in those being
> > > equal to another argument of the same syscall?
> > >
> > > I'm going through the kernel/auditsc.c right now, but it's more of
> > > a "document what it does" - I don't have the specs and I certainly
> > > don't remember such details.
> >
> > My approach to audit is "do what makes sense for a normal person", if
> > somebody needs silly behavior to satisfy some security cert then they
> > can get involved in upstream development and send me patches that
> > don't suck.
>
> root@kvm1:/tmp# auditctl -l
> -a always,exit -S all -F dir=3D/tmp/blah -F perm=3Drwxa -F obj_uid=3D0
> root@kvm1:/tmp# su - al
> al@kvm1:~$ cd /tmp/blah
> al@kvm1:/tmp/blah$ ln -s a a
> al@kvm1:/tmp/blah$ ln -s c b
> al@kvm1:/tmp/blah$ ls -l
> total 0
> lrwxrwxrwx 1 al al 1 Sep 23 13:44 a -> a
> lrwxrwxrwx 1 al al 1 Sep 23 13:44 b -> c
> al@kvm1:/tmp/blah$ ls -ld
> drwxr-xr-x 2 al al 4096 Sep 23 13:44 .

...

> Note that
>         * none of the filesystem objects involved have UID 0
>         * of two calls of symlinkat(), only the second one triggers the r=
ule
> ... and removing the -F obj_uid=3D0 from the rule catches both (as expect=
ed),
> with the first one getting *two* items instead of 3 - there's PARENT (ide=
ntical
> to the second call), there's CREATE (for "a" instead of "b", obviously) a=
nd
> there's no UNKNOWN with the symlink body.
>
> Does the behaviour above make sense for a normal person, by your definiti=
on?

I never said that there aren't plenty of bugs in the current
implementation.  Really.  Audit is a train wreck for so many reasons,
most of my time spent with audit is spent making sure it doesn't
panic, or some other subsystem hasn't wrecked it even further.

If you're looking for someone to justify audit's behavior here, you'll
need to keep looking.  Personally I've got plans to burn the whole
thing down if I ever get enough time to work on it, but in the
meantime I want to try and make it as usable as possible.  Patches are
always welcome.


--=20
paul-moore.com
