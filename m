Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49814C592
	for <audit@vger.kernel.org>; Wed, 25 Sep 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297930; cv=none; b=ql6dcnP2MoyGLB0orzkjymJBsPAEW0IGPUHIfVq34uAODawexU2naSHMLsOEpxNH3IIrnzC2dBw5h3GHABaRRlw4nepZQ6MnXofcSrca624AhoaTk0Obl9j0Pt+tiAK6cR4bpxH35/b/aos7Pkp5Cp76HV57drr0W7y9TjeYwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297930; c=relaxed/simple;
	bh=1pyK3d1jv/wGRieZiiSOW8Aq2+2vd1lQtCF+g6NwPlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNc03zvefFlD7c+GBpNMmzGmP78aka3byM+c6J3ofkW1YFvS4pND+ZPtKq95xtkoDT3Q9+V0B8w+uPly2UCZ/HDfFG3GzAsKldYC3s26lH7O6fS+17nbMJVPuJyLz+NDrvUY7WUcjsjNscfqt55jznf7Z0k3o9YiNCpg7kWCFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IcA8+EUr; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IcA8+EUr"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25ccdffcc5so96748276.1
        for <audit@vger.kernel.org>; Wed, 25 Sep 2024 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727297928; x=1727902728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/RTp60C/vGTcLnuHNp0lMYJzWwQ9rzux6ho8p7w4Cs=;
        b=IcA8+EUrckqrsBM1iD0Gx0bwTk/09IeYft27EOyGZCYqE+aSO11JpTncl8oXHaBshi
         +ov5dNgHY6lg/Y8vj3VGkOImm7IRyxO6ls0qcY/KtKenfd9s/QtpED5IPkZ8JCNwK1BS
         sz1+5GShGfKl9G52AXbLPrMDlSxrVAnqV9VZiDkZm0J2VekgEbuOpAZA5za+3i/UEjQb
         jcdNAm/8VPxiwuV5PANIfCnYQW7INgwF3C61HEcq1Djv5G7dEGIIzDAH+rpPw4RN8gLy
         3XrjiPxJBW7OzZKbPfd3UkPJ4vKU7WExPn2qVvt89pOZQv/SYHpWMPwxYFk+9mjsrR9A
         j6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727297928; x=1727902728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/RTp60C/vGTcLnuHNp0lMYJzWwQ9rzux6ho8p7w4Cs=;
        b=pweT0ZA60FYXXSbIRiF1qk029/ziMVL6ibHybzxEP6OecseT/9dvqbjtcJUwI4l1HA
         h4Bbj6Mdw6HcSRo1lCP2IGX+spo/p8mGRI84i+vopSjdeU0xkxckk6gxy6Iu4yN/lymX
         y4BFIz1UYjPxm8JaC9uNmHD7PTIhg2g/0QmHeCXQbYd1LibaZQAWxyqab4d/5YAutJPL
         4X2B3wuiGhkB6lzxSB3TqyaQteyqBbneYJIraLJJyPK9dnApzToF6zAeFpyyzFR7Ixq3
         AMJ00vjUf8AlV8hYTDLCNNmeUlllfJ12WWdc2enLov/GRawNLLhfhLo7Zn7Ltlllime/
         8TjA==
X-Forwarded-Encrypted: i=1; AJvYcCWiMkvKEHmwxawWvJy2xHSd9rojBhFKwqslzw0amxDtK1roSjwu1291zwrgVkq+A4yt7dZLHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMqrbiUL7VFuP1l9eUUrKfzM7XTDjVWdHV6sfRdIm8b+Pdj2P
	A0Prz7dp12bD71zLOusrJc0gllqubxwNIbm5IPU3IMb4vocbHGElA3pwIuqu6kj6j44gmV68+MO
	y2SCgo8NN4ZOoZ0BWwW/FznD1zlxzjKsPRfQ0
X-Google-Smtp-Source: AGHT+IFO0ZO2Rbg+fW2i9lO0lub8NWPyyYcjOcT4luyxVqXK/pN8SzNM+fsLwE0tdW8dGluIjuGnaRVOmnSJqMfbb+E=
X-Received: by 2002:a05:6902:118f:b0:e20:2e45:19bc with SMTP id
 3f1490d57ef6-e24d7446bcdmr3423326276.4.1727297927957; Wed, 25 Sep 2024
 13:58:47 -0700 (PDT)
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
 <20240925204423.GK3550746@ZenIV>
In-Reply-To: <20240925204423.GK3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Sep 2024 16:58:37 -0400
Message-ID: <CAHC9VhThDyJgAtfWLw_rrF=LaZh6myCmAkqDq+=W5qMCgaCmTg@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Mon, Sep 23, 2024 at 08:11:51PM -0400, Paul Moore wrote:
>
> > >         * get rid of the "repeated getname() on the same address is g=
oing to
> > > give you the same object" - that can't be relied upon without audit, =
for one
> > > thing and for another... having a syscall that takes two pathnames th=
at gives
> > > different audit log (if not predicate evaluation) in cases when those=
 are
> > > identical pointers vs. strings with identical contenst is, IMO, somew=
hat
> > > undesirable.  That kills filename->uaddr.
> >
> > /uaddr/uptr/ if I'm following you correctly, but yeah, that all seems g=
ood.
>
> BTW, what should we do when e.g. mkdir(2) manages to get to the parent, c=
alls
> audit_inode() to memorize that one and then gets -ESTALE from nfs_mkdir()=
?
> We repeat the pathwalk, this time with LOOKUP_REVAL (i.e. make sure to as=
k
> the server about each NFS directory we are visiting, even if it had been =
seen
> recently) and arrive to a different directory, which is not stale and whe=
re
> subdirectory creation succeeds.

Ah, that's fun.  I'm guessing we could run into similar issues with
other network filesystems, or is this specific to NFS?

> The thing is, we call audit_inode(...., AUDIT_INODE_PARENT) twice.  With =
the
> same name, but with different inodes.  Should we log both, or should the
> latter call cannibalize the audit_names instance from the earlier?

I think the proper behavior is to have the second call cannibalize the
state from the first.  The intent of logging is to capture the state
when/where the new directory is created, since we never created a
directory off the -ESTALE path I don't see why we would need to log
it.

--=20
paul-moore.com
