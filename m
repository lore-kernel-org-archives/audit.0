Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B13B71D1
	for <audit@vger.kernel.org>; Mon, 31 Aug 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211389; cv=pass; b=mYS+3kfFGxXUVc+DxaFwDWIJj5JdPPZqpEG0rAqKP1aTJ86DhcDDK8Bi4Ig8sxSMfSXYKtkG6PlND2qLynB1ofpN7jHm6asUO+bxQxaEnnMcVLD8ELt3gIPxme7gxCYdymOh1v1denkanE9osVWE4h4ZR//6GzoKOsR3WztmV2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211389; c=relaxed/simple;
	bh=+1ctpOnlda54PidlZ6bNmCPQ+W0TpdPhm/i6KN/wKa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwe24iFzvT8AeeuO/2N4pOLRnoWnv2e7OCykNU3WTPetsIKAVCdxk0bd7enFf1eLPFLXpLMumoHo1GSLjtLsbHDkflckFqumvyPmXYMLDWi25jTbdiq1HFlTh2bYnt0Pz3ghfvKRL5J2l11gclZk9vY6NIDRzQQLF9WzOSdLAgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hg4iWkiR; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hg4iWkiR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d91ded8174so1054455ad.1
        for <audit@vger.kernel.org>; Mon, 31 Aug 2026 14:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211387; cv=none;
        d=google.com; s=arc-20260327;
        b=mNOkqE4d1kqPI5LM1Igb6haLwXvNbY+jFcR6PuQcwFVRSDXTg08ZDpWLtEm555r9QW
         l1Os00EVO9JwSVvUbjQ/5KRi4muIzMM9aMwoexgMfGe3p8abm1mVJgc5FHICrB59fE0V
         RmJcsJlEq5hdDKe+JjyeP6CpkRQR5zote3uB919s053v8OVO15D4dqJOJZVOzTWEha2M
         IKW9Fge+gMq/nrHUwCawv3qjyUkKHOgG0+xvxD4Gak6ZsHpgjm+aqoEYhP4UZDI0tsRO
         TrsJKyMKmaUD/4AZQbUAptrxUTYfqOXZED0zFyHPm2I4GCHJwHa2lqcGh9iQSzCM7FJb
         Vz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        fh=oQ4AjAod97R0+hPzOau+De5Cl9+2dkDAL6DEJLh/F/0=;
        b=aELSs/+nG7stc2ia6R3Ul+p9e9OrIVNX1lS2l3Ro3VY6e7I2DJQRo6jgQQiue6WN3z
         iRgDTwbapnxwR7oVP4Dc9L8D0fAWR/KMYvfXPcE0Qgq1YvkVXYQeWlm6S3jxdrMlVUVn
         cBLAYMITsqwTFBnBZKPG5/PG531m/epWARMTvhAqtT070JRDF6M+0E367EZNrf/lkyKH
         iaCvxHWlnayuHNO1kFw/cTbbBqtYGVkiRgDxeUOAiSMMh5BZJSfk+ApVG273cGuxJsh8
         VvsWwxKOYjaByYgTPw1Pu4ZOLKJc4ztq0ka1E+flHzx3KEFa+nOuCSMlEpZzNB5ueRBM
         4uJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211387; x=1788816187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        b=Hg4iWkiRhdIY0QnmPFpdDDHe7bhXyeMl98uRZihvaS06q1MXAaZFnAoaIgkx2NY8Zk
         MnLJneA+ImYjqm19LJuThUmwetBxKkPOSmTlT0pykqhl+YfAeB+5RjETqQLEdj6DZ1CV
         g+C7sS2dIfuBeeS8SVco2iPeOro23T6aNAuuCEA3BHxUxgLloJn2jDsdPB0kXpFgRN8L
         tjiUh5OlWjaBGMoJc0NadY4Qyw7D8r99FpgjO7kMUcG5/nD6xFE3JhmWzGlC9DdbZR1M
         PQzrDgaPLTZ45MGummuL6ffnkuGJEV4zjUGRCS5nnHn2JKGmLDQBEVQxxznWIk2v4/WE
         Pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211387; x=1788816187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        b=VH5uOaGK+mmgvk6bcHOMVtyqFqrskSvG71c81KH0ehNo1p0+051SWxe10R0FuesJe7
         mYcFf/HzIfUOt9w3wTE/TVU2sV6w9LMEjHT+6pqiCXbYMni9tWI2S5pLNujUWHpfYo6P
         JAfGSGO44oB925boQlakSy5cKBwCDEVBzJ7DieaiJDCagkLTPrfTKdXUCFAhBa6BkWQo
         SlHcfr3vwM91FbCSD4njzc9uDc9F5GylNeA7iefqM5NX6II1Uu8KpE/5Zat6qki2IMzl
         DwLk1b+t2mnzn5y5UhgzWESlCIi5VjUhl0hwDPIEXdDl4sHN9oz1YtmWu80n12imbYpa
         AKfA==
X-Forwarded-Encrypted: i=1; AKwUvBzr90XDE6hpkjEnbK4Gz+gbRRBG6XKBoXIYz9Qz2wZdZVKTZs/WatjScAW9umfjGznCwuzKAg==@vger.kernel.org
X-Gm-Message-State: AFuF++kpEcWM+4R8mgggTSga8cuGe4snDSUN7GifRAzyJGtrQRJkjq4Z
	LfyZp3Cf6kZRSXxwfWM4uD/37x67VRxBkvqwbkdD83yV32m4FLnlJ0xm0a8ZgduR/nr/5f48Eyo
	gCZmX7/DyXYInoJgQnczZwKi9aZBOoX1lDWEamVro
X-Gm-Gg: AYBFou0S/tk8TEkho98VbTBl61/hRIfwyFNBGF5+qSqp/JvFfthbW3OHSs1ceJ553/i
	exmzA9P7hGBU68tfWDJcYBix3XfsWuXQwOcX173JIKYVdKqMdwrHrozCUwOrGfGRoq1O7EmjUWi
	CE1RfiC06oK4SWHFlJ8rNpoY6aKRzaYhi0+MPfNvvFvWqXFoHk3V4YYX8a11fKrEdpjSGiwhCmq
	v2mKfc+3e9w/c8xWhd5WpuiwFY1DE1hDgh2UdvOZ9NtBfJqXc9I0MuOlHKMuwccPkUUlHcQynWE
	QuZFGsgvWF/HVTUxy3eoejaP95ySecu6ipqO561n+0Lh
X-Received: by 2002:a17:902:ebcb:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d74cfcdb1emr492271905ad.0.1788211387554; Mon, 31 Aug 2026
 14:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com> <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
In-Reply-To: <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:22:56 -0400
X-Gm-Features: AcwNN1UgSvn7xJ2VonI3rUNXxETiZFahKrkwjH9zjPk8v2KgPZyHugOYt0cGY20
Message-ID: <CAHC9VhTYYbmKVXzMrCv=sLi1c+6Wdvum+TmpGNPZysaNHDyTHQ@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
To: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> >
> > The `cred` field in task_struct is currently marked as __rcu, but that'=
s
> > not true: It can point to credentials from access_override_creds(), whi=
ch
> > do not get freed with RCU delay.
> >
> > What actually protects task_struct::cred is that accessing it is only
> > permitted for the current task (except for setting up a child during fo=
rk()
> > or tearing down a dead process).
> > (There is currently code in Smack that violates this rule, but that's a=
 bug
> > and causes UAF, I have sent a separate fix for that.)
> >
> > Clarify this, remove the __rcu marker, and remove RCU helpers from all
> > accesses to this field.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > For context:
> > There have been at least two UAFs of struct cred that I'm aware of, bot=
h
> > caused by wrong use of task_struct::cred:
> >
> >  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db=
7
> >  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26=
@google.com/
> > ---
> >  include/linux/cred.h  | 17 +++++++++++------
> >  include/linux/sched.h |  8 ++++++--
> >  kernel/auditsc.c      |  5 +++--
> >  kernel/cred.c         |  2 +-
> >  security/lsm_init.c   |  2 +-
> >  5 files changed, 22 insertions(+), 12 deletions(-)
>
> This looks good to me, with one small nit below, but as we are at -rc7
> I think this is best kept until after the upcoming merge window so it
> has more than a few days in linux-next.  I'm going to merge this into
> lsm/dev-staging with the expectation of merging it into lsm/dev after
> the upcoming merge window closes.  If anyone wishes to object to this
> patch or add their own review/ACK/test tag before then, please do.

This is now in lsm/dev, thanks!

--=20
paul-moore.com
