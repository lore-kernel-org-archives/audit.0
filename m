Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8438C
	for <audit@vger.kernel.org>; Tue, 24 Sep 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727136725; cv=none; b=LFOpVoJvY8g2tQlI26LFQ6AcSqH32xngPB1YTxhxSis++I9AkAPbbOMyK57HM9Yvpy16loFg41nmBFJdwK5zcFmXl8XqAUJQA2fNvVG6z80FlkZgvk3zG5jOKncSGeQTY2ctwlqMyIoDmmkvnGwkAzHJH+kL9AMAT+ju8WJtITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727136725; c=relaxed/simple;
	bh=MMTdJVt7OdiBUXwWhIsaQqT7wTuE4DUI7MBfspkWxkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKLEblc1pCGVErI7x/y//8NasJRBsItBBMBPQrt3W/5zX4TJuIaQ5w5/NlW/kQxfQLySa8xbkBE44PMjCGJd6EFGvZbFEVn64PvNlfWuxz7MzCXYj30VlS4MhJbUIfPzDtH+Ng5a8rj6+/YcZqOzpWrcPP47a59Fi7VXSKEXmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CugBmlza; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CugBmlza"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1d74e6c8d8so3860406276.1
        for <audit@vger.kernel.org>; Mon, 23 Sep 2024 17:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727136723; x=1727741523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnBrptc4F32hFr/oUJxZIzDWrryOvBsI7s8r/VsZ/Kk=;
        b=CugBmlzaBda2Qbc/7KZBiEMjqxl4juPpwIJVoiTJ0NIfGnS0TmsudgQWfPjFFT9SP6
         24cHk0VEI3wUtOB5GjFTxLxrSaeI4PqSU6RyaW5XBblKNOjn4t1/RpndQQiy7awnW/GG
         0GF6YoXAv5nLHKfm8W36DMQOdyJQs/xTU+qpQesIqrvldReJ738bt61C+aj+OBxL+p57
         On94flkGcStBw40MZ2IwbfrqnaACaroVFq/QtZcdLl9s0iR9/8psvzC9ctt+v88vpIR+
         yTRT3H0ZjKHvDni8foNqJCYCzPuMWTglp7GaZPOxi+CB78ck9C65b+ZkY9+k6rJ0sebZ
         8Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727136723; x=1727741523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnBrptc4F32hFr/oUJxZIzDWrryOvBsI7s8r/VsZ/Kk=;
        b=E/3D3agwG8kWz4CJ3AGgw9UlIY0HsXq0T380t9m5G7X8AlpQFjT72PC+e4bIsHextT
         4qbEOnJZHCco826juOoKz/VKKQE8MdpOmVy6erbxsBH/dxW8kuJfEXzTHKFbepBkBMH2
         0IRByI+7Ia9xHw8cRc2lcSGKQwtJdMBmNifpbejCjTxm44WLuc0kQskOngfKwTYmBtQl
         I9GEWz4sn0USwwOXRVPvYYcL02pjosK9ququn7RmhxqYolhuistV1r1Gxg5pXGlVfBNO
         PfFuA25GgR10mezNqqjbQC02LhNpQtyGzmsVdCf/uztQAZoxrrGBCYCN+mt3W6wVvKKK
         qMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf/ntjFSMuC37EiE66VVYY73VB/0lmaprO6HkNrTsLfDV7ZrqnzdeT/mquwYR/lyVLMHn/jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+BAyJ8HwDds5NhQdER7tx93mw2t8Pd+F6l/4Ao9B7Jh1a31n
	M7S0AaKcWmZ6xbwYVcn+Y/x1Vt82rBgK5nqZoZR+ofkq+m5EHm/H2BIXe4sjB9MOARBbs+E0NNt
	ngy9jxp7VRruphA+lDPSMnIHb1+FucGkTb8v8
X-Google-Smtp-Source: AGHT+IFmtHRVnYke1Kv492/ox+3/dYFAOoztb03BAwbzHsCc7v13o2wfeq/92cSDzrFBmdp36AD0DMDGBSLupElPMMk=
X-Received: by 2002:a05:6902:1b8b:b0:e1d:79b2:ba2b with SMTP id
 3f1490d57ef6-e2250c2e13dmr8812418276.21.1727136722725; Mon, 23 Sep 2024
 17:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV> <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
 <20240923203659.GD3550746@ZenIV>
In-Reply-To: <20240923203659.GD3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 20:11:51 -0400
Message-ID: <CAHC9VhSq=6MK=HKCJ8KCjYNQZ4j_eCSgTpuYyHtk2T-_m2Br3Q@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:37=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Mon, Sep 23, 2024 at 12:14:29PM -0400, Paul Moore wrote:
>
> [ordering and number of PATH items for syscall]
>
> > >From my point of view, stuff like that is largely driven by enterprise
> > distros chasing 3rd party security certifications so they can sell
> > products/services to a certain class of users.  These are the same
> > enterprise distros that haven't really bothered to contribute a lot to
> > the upstream Linux kernel's audit subsystem lately so I'm not going to
> > worry too much about them at this point.
>
> Umm...  IIRC, sgrubb had been involved in the spec-related horrors, but
> that was a long time ago...

Yep, he was.  Last I spoke to Steve a year or so ago, audit was no
longer part of his job description; Steve still maintains his
userspace audit tools, but that is a nights/weekends job as far as I
understand.

The last time I was involved in any audit/CC spec related work was
well over a decade ago now, and all of those CC protection profiles
have long since expired and been replaced.

> > where I would like to take audit ... eventually).  Assuming your ideas
> > for struct filename don't significantly break audit you can consider
> > me supportive so long as we still have a way to take a struct filename
> > reference inside the audit_context; we need to keep that ref until
> > syscall/io_uring-op exit time as we can't be certain if we need to log
> > the PATH until we know the success/fail status of the operation (among
> > other things).
>
> OK...  As for what I would like to do:
>
>         * go through the VFS side of things and make sure we have a consi=
stent
> set of helpers that would take struct filename * - *not* the ad-hoc mix w=
e
> have right now, when that's basically driven by io_uring borging them in
> one by one - or duplicates them without bothering to share helpers.
> E.g. mkdirat(2) does getname() and passes it to do_mkdirat(), which
> consumes the sucker; so does mknodat(2), but do_mknodat() is static.  OTO=
H,
> path_setxattr() does setxattr_copy(), then retry_estale loop with
> user_path_at() + mnt_want_write() + do_setxattr() + mnt_drop_write() + pa=
th_put()
> as a body, while on io_uring side we have retry_estale loop with filename=
_lookup() +
> (io_uring helper that does mnt_want_write() + do_setxattr() + mnt_drop_wr=
ite()) +
> path_put().
>         Sure, that user_path_at() call is getname() + filename_lookup() +=
 putname(),
> so they are equivalent, but keeping that shite in sync is going to be tro=
uble.

I obviously trust you to do the right thing with the VFS bits, and
having a well defined struct filename interface sounds like a good
thing from an audit perspective.  I don't believe it completely solves
the audit/io_uring issue, but it should make things easier and
hopefully will result in less chance of breakage in the future.

>         * get rid of the "repeated getname() on the same address is going=
 to
> give you the same object" - that can't be relied upon without audit, for =
one
> thing and for another... having a syscall that takes two pathnames that g=
ives
> different audit log (if not predicate evaluation) in cases when those are
> identical pointers vs. strings with identical contenst is, IMO, somewhat
> undesirable.  That kills filename->uaddr.

/uaddr/uptr/ if I'm following you correctly, but yeah, that all seems good.

>         * looking at the users of that stuff, I would probably prefer to
> separate getname*() from insertion into audit context.  It's not that
> tricky - __set_nameidata() catches *everything* that uses nd->name (i.e.
> all that audit_inode() calls in fs/namei.c use).

That should be a pretty significant simplification, that sounds good to me.

> ... What remains is
>         do_symlinkat() for symlink body
>         fs_index() on the argument (if we want to bother - it's a part
> of weird Missed'em'V sysfs(2) syscall; I sincerely doubt that there's
> anybody who'd use it)

We probably should bother, folks that really care about audit don't
like blind spots.  Perhaps make it a separate patch if it isn't too
ugly to split it out.

>         fsconfig(2) FSCONFIG_SET_PATH handling.
>         mq_open(2) and mq_unlink(2) - those bypass the normal pathwalk
> logics, so __set_nameidata() won't catch them.
>         _maybe_ alpha osf_mount(2) devname argument; or we could get rid
> of that stupidity and have it use copy_mount_string() like mount(2) does,
> instead of messing with getname().
>         That's all it takes.  With that done, we can kill ->aname;
> just look in the ->names_list for the first entry with given ->name -
> as in, given struct filename * value, no need to look inside.

Seems reasonable to me.  I can't imagine these special cases being any
worse than what we have now in fs/namei.c, and if nothing else having
a single catch point for the bulk of the VFS lookups makes it worth it
as far as I'm concerned.

--=20
paul-moore.com
