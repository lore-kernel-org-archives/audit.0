Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E8181D19
	for <audit@vger.kernel.org>; Thu, 30 May 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102492; cv=none; b=mlP017+nwBfSTi4PInNQwOLskhv2pQKERiIfyIrZWRMVdkRNH0jt2P1g8Igs81+urgGifH0VolXvQ1oZ7QgDaEqsdoPPPjNKLXnbTS3JhZzmX9x1IKtoI/yLMnFz3+6WuFFZY4cyLni8Pa5RGmhiO0ZMW9pzwrGNiyXWRc4rlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102492; c=relaxed/simple;
	bh=eg+MIkwiEVxSkImTnP9/42HiBWABCU3sNxsgUn+kexk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex0EKIMrDvT3GNVDIp6VNjRdAvJlRH8HiimYC9KvXzrzCzPZ37G4r8wScyDRnL6rgjkU7WcATrtDJ3pfcPikAunplKoMUAsQW3QmmPJguM1xytAAmT2URAhGowB+N64Hf8Cvb+9VIyiHuGnuRbGh5KDutGlDclzLcmJdD3EfqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BrzIFDm5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BrzIFDm5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a2424ed01so14145917b3.1
        for <audit@vger.kernel.org>; Thu, 30 May 2024 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717102489; x=1717707289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHhnEY8EBCWzfeI4r7ZxHSk1OcUfnIeP4X4PVOCwAbA=;
        b=BrzIFDm5u1OGrheVMzkYq0tj0rbabzbKf0pTE8oxaIY+RyN0ZEytQzCrnnJreDPOIg
         7TQl9X+VZ0fTaRlX8iqumOhB09WMOpzndyPEMdEykX7NyENEaOKkQZfnijFXjWEozH3z
         8Jpd+FQxLvzyhMT7cBq724wOfUQslHfL7cnw/ncQNudTDP+XWoyKxjHiBawIxliDwHlv
         6Ck785H97sLYf86QFP/eOO/nxuZAAO/OzLO/ClrGsCTjSBbC4T16jgjO+ijjmzjwY+8e
         nRz9WgFbGVZalnPuTw229RHuigu3tO8iUWyIqbb3VCvm0OPGAkN25fTRlj7b9Rfjy5qD
         QNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717102489; x=1717707289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHhnEY8EBCWzfeI4r7ZxHSk1OcUfnIeP4X4PVOCwAbA=;
        b=EokIa5BvU8sXIwgmNj8EAJG+Kk/SRqD5WZGZCwXDUZ9Ld9kFat6VPXXIjqEVp12WNk
         aS4iFfXtK6U9fMm8eEwpEccXOOytmVR59+fIzkhKRdAJQ1K5RmeiJWSN0lxrwvcX6XAY
         d5XoPghszJHVW+lkLe0l83pHuNR9ygCwQ6cS02KSgrW5RUtgCtUbjc1v62e5Bs7f+gUm
         pT9fNqrhOAjegsY7KrD7xXwJxJxSUZOvi7EiMUMCy0XTS8MM/hTfHyVunrEfDfsXinij
         p/LUTAXHX1uHzmTgiHOueK5FeGrOcm0ESb1M2IcmkVGIib7KDMPbx73pN3EvkEHKKtFW
         rLmg==
X-Forwarded-Encrypted: i=1; AJvYcCVTJMI+6Hy52cgh8SfqeeL37uaJg8glKXQU797kTMHiPiDXHZD8LRA1FlrLHHxdUA+dmE0kh1wQM2e6IhgB7+owV7O7Aok=
X-Gm-Message-State: AOJu0Yxg75UldaDFgtlPD9SRRK3DkOCovMBO9r/oXyRrDMShuoWi7nhN
	Yf5+pMPa13gQlnAfNQbicGUp6rip0JI12dQoZ9CFVMGD0UUqLFtJSEhWjiz2X1gU6rl7KtKmi3B
	XlLUi/SDTGqSDgTDEz0aBk87xhfbbYnJxbxjI
X-Google-Smtp-Source: AGHT+IFGAao34yd3dClXG2DXw+Iy5chVgrvzZN/oG9tpxQvuE1hMom7wnNuLEmL3KD2ppvrBp7AAzHWyXJlgtWi13+A=
X-Received: by 2002:a0d:dc83:0:b0:61b:33fc:ad0e with SMTP id
 00721157ae682-62c6bc3120bmr35459887b3.17.1717102489115; Thu, 30 May 2024
 13:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com> <20240530030605.GA29189@sol.localdomain>
In-Reply-To: <20240530030605.GA29189@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 May 2024 16:54:37 -0400
Message-ID: <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:06=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > On Fri, May 24, 2024 at 4:46=E2=80=AFPM Fan Wu <wufan@linux.microsoft.c=
om> wrote:
> > >
> > > This patch enhances fsverity's capabilities to support both integrity=
 and
> > > authenticity protection by introducing the exposure of built-in
> > > signatures through a new LSM hook. This functionality allows LSMs,
> > > e.g. IPE, to enforce policies based on the authenticity and integrity=
 of
> > > files, specifically focusing on built-in fsverity signatures. It enab=
les
> > > a policy enforcement layer within LSMs for fsverity, offering granula=
r
> > > control over the usage of authenticity claims. For instance, a policy
> > > could be established to permit the execution of all files with verifi=
ed
> > > built-in fsverity signatures while restricting kernel module loading
> > > from specified fsverity files via fsverity digests.

...

> > Eric, can you give this patch in particular a look to make sure you
> > are okay with everything?  I believe Fan has addressed all of your
> > previous comments and it would be nice to have your Ack/Review tag if
> > you are okay with the current revision.
>
> Sorry, I've just gotten a bit tired of finding so many basic issues in th=
is
> patchset even after years of revisions.
>
> This patch in particular is finally looking better.  There are a couple i=
ssues
> that I still see.  (BTW, you're welcome to review it too to help find the=
se
> things, given that you seem to have an interest in getting this landed...=
):

I too have been reviewing this patchset across multiple years and have
worked with Fan to fix locking issues, parsing issues, the initramfs
approach, etc.  My interest in getting this landed is simply a
combination of fulfilling my role as LSM maintainer as well as being
Fan's coworker.  While I realize you don't work with Fan, you are
listed as the fs-verity maintainer and as such I've been looking to
you to help review and authorize the fs-verity related code.  If you
are too busy, frustrated, or <fill in the blank> to continue reviewing
this patchset it would be helpful if you could identify an authorized
fs-verity reviewer.  I don't see any besides you and Ted listed in the
MAINTAINERS file, but perhaps the fs-verity entry is dated.

Regardless, I appreciate your time and feedback thus far and I'm sure
Fan does as well.

--=20
paul-moore.com
