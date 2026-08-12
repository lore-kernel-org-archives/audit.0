Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9914749D8
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549480; cv=pass; b=Dg4sjleEKRogYiFTFGPm+l0eZP2Mbibs9WSJNH150g96IJNKpsYYKSdlyOow9eOcBx4Cr+eE+tPY44pMKpvArReAVOexHXDi9Z1fR/sqfjgLB2VW7OwzdxIHKP/94YsAmL9SQ5GEVG9hDNrGtxYEm/x4xFkzagqXUo/hPt9t4NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549480; c=relaxed/simple;
	bh=/IeII68tNcQyIIr8PeEhC3EiDZx+rpE15xSusoJdc5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvwcNNr66Wn2R0E+nmMH1uDger0w56QfK2hq/2GCs2gPInUnbsa2ECxiFHY0QZ3fuIsTdgeIbK29LuPsanAydHINfiqY5/c9pMkm/PPVYmK9+22YMdQLAvCsCHNKLak4ktbJfuHxcZR9Ttrl57JxPDDMjxARX7wvtiEY2uf6ctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQ3Wx++p; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQ3Wx++p"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc73e322dbso14952965ad.1
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 08:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549478; cv=none;
        d=google.com; s=arc-20260327;
        b=O3+a6TJ4/+eD/mxelfQer07DaO+XMX702sUdvbu69em5J6ptBoCK1JoJavOZazY62x
         opNXvG4myblQLZMV0IvcAwsvBVx/aOEUJdSijKB9OLDyI8vCSjD0kTXL72v5zEkOrGhv
         TCfqilhuYDlSqnvyV4SbGFB5pff0rRqeyd5MQ6GfZPKRIk4LBWPg+kXiNukZKtwjPMIS
         xFTuY+fVb0HfmHMO5xYqn5PflGFiDz/wqeVHZ+ESrfsHifDAVE7iIEINizOUhw+ut8L3
         JbHfrRL25h/zkHiR7qMUcQdwrt13iAXNX5DswP7A34fqc6rIB32Qij8wdIevM3sD6qf7
         2CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        fh=6TU7MYdA3Q5TMg0ZnyJJA4DOMuWefc+hMXpsbHhQHWc=;
        b=O5whkC0mh5l7aji+f9V0S15n/pdjrd8HXzbNUFAErobPv/AVD2GWO89B8c13YhL4aT
         QxfLeN6EkCvda+S6w+w0jQLFtCdFR8MLGKfwOe5769HABh0q7ylJ4+CKrCRjF6oKyN6b
         DDbk1rQbcp/ExUcCn49bQSzUzkaaRvXsfwMTGslvJaJjS8gKegv8kcDQOOzJK0CCSmHV
         97D+hWJ2OQeTs6ZpBw++wJ1ecfQsi/qUW5i3fP2Zc1VMofnLzJ1gPA+gkmauAWjoXyE3
         mtcyOjOzgnZpeZhnpbj+9+nn/y+DEf5cChPlHT5INyKOCuKDeb2U+nDRpJKiWCmDpQ+A
         ybcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786549478; x=1787154278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        b=fQ3Wx++pKT3wCst4Hb0bcoiH3pYGN9sbXz5tjnke6dH3EVT19Ewls3USSY1jTjNr8E
         pGP4umrfgQhAKsMJQXsCtzXaZE30JkxavfyYd4+Rj3c2OboHhwEcdtIBc7GZuNI/lTys
         heaS2J+odmMIY4h8lsHUlb1Z4U4/Tuvlg0gXtFxlEd+Ejfof0ih5Tq3y7apM0ez/9ixF
         jDcCd9UyG4jhqpU3w+IIk4Ry/FWlkY8EEiosg5F3SWD8jbRAIqIDw2a7enAU2S61fNNE
         QJ/vWkZn6PI4YjlzxbGXtFguixw6neTgUItoO8HPmW4psh2qUW3p6QLeOciowQ8Rs0SY
         xDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549478; x=1787154278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1IWDnG3AF52MXJuclYMYHc+IQmTD43ohn2LvgapWrc=;
        b=JKXuTjMEKZSJw2AARHrHXd7MQgxWMATA+RC4LUq3hvM2bvbeAk6ekf8syQBZCgdJad
         89YpjDq2/b4ZQSymLfKgx2sdPrmbqsryBezs+1P9hvIPq7gA35+aw76N75KGELh+wHFt
         R0j8mfvy0q2PfQ/smLuHeVrdANsJJntq2Qz+M4DS9deDoEf3bBgwSwJX+QIIF6CLYkRo
         VeiAzHBg0urs5ADqSoU3yPeGfujIG72LA8GXUG6vTT6LiSIpbGw2dgW/p77ZNu8YA2ao
         kctv0b9aW6uj3LqNlWzWG1ZGp7G6VgL7NmHmZF9lM+u/DD3LOEd5nAgpXSVfzMiT88CT
         P1Wg==
X-Forwarded-Encrypted: i=1; AHgh+RpLPIy3WktfTMTL2h+bXjLYW03hAkNcSSeQ3j0ewsGWyJGmGRH7pPLMTZ5MTVW3HwIOPK4RLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJqTL8uCveI5/MZcyz2hkwYWM45zzhdQtSBrtEfCVODVHy4/x
	M/sQTQ+rAem6W2OOrqlUCWA2dBRB8KHT0Pq1ed4AJw8eHDhl244nxYhekYijlNrGMndaVwHZdC+
	DcmYqXsSXtBOsTwiEkMogSk962fb8YtjtutyFCFHq
X-Gm-Gg: AR+sD11sR7IXb5MHVvn2anmEjR9R0Nm+Zfl0Qcuv0Y9eFzIoseenDhBU0Q9nzrnXyMd
	RZIfHmrD7A0BnfsATdaXeFLIYgUekYr6bDRgyAjcFQFoEUeKzQBFFL02BIx9QV7NwNcKJcKTt5y
	rquDd47FNohV+wpsBOc8+Y957NduGyHF5LPVRdHKJOlrq+4uvm42CYosRRCtN0bf9/pSMNEWFF7
	vwVtvEgTCmxNVkYC1QDX94ZdnxUv5E5vhRazYX5gJtzvdciglV6EKmW1AWINgkd4vkeDIg7XnPG
	zR7Vztiyv2IUxDeLCHuoWzUmwFWEd0RWMA5pyAZlXyOk
X-Received: by 2002:a17:903:230b:b0:2ca:d975:5bbd with SMTP id
 d9443c01a7336-2d3455ffabcmr66794735ad.20.1786549477549; Wed, 12 Aug 2026
 08:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
 <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com> <anyKVxRCiWy/g0Cn@mail.hallyn.com>
In-Reply-To: <anyKVxRCiWy/g0Cn@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 11:44:25 -0400
X-Gm-Features: AUfX_mz1CYC-wzRPK5n3KTtv131zQRSOinsU2x1ZkDohfDgiuhfc7o6Q6fO3Nrw
Message-ID: <CAHC9VhSv-+BgaOzfw7=86cWgnPkD_KD88NKk=j-fY=K_85wTxQ@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:59=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Mon, Aug 10, 2026 at 03:41:54PM -0400, Paul Moore wrote:
> > On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> > >
> > > The `cred` field in task_struct is currently marked as __rcu, but tha=
t's
> > > not true: It can point to credentials from access_override_creds(), w=
hich
> > > do not get freed with RCU delay.
> > >
> > > What actually protects task_struct::cred is that accessing it is only
> > > permitted for the current task (except for setting up a child during =
fork()
> > > or tearing down a dead process).
> > > (There is currently code in Smack that violates this rule, but that's=
 a bug
> > > and causes UAF, I have sent a separate fix for that.)
> > >
> > > Clarify this, remove the __rcu marker, and remove RCU helpers from al=
l
> > > accesses to this field.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > For context:
> > > There have been at least two UAFs of struct cred that I'm aware of, b=
oth
> > > caused by wrong use of task_struct::cred:
> > >
> > >  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3=
db7
> > >  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a=
26@google.com/
> > > ---
> > >  include/linux/cred.h  | 17 +++++++++++------
> > >  include/linux/sched.h |  8 ++++++--
> > >  kernel/auditsc.c      |  5 +++--
> > >  kernel/cred.c         |  2 +-
> > >  security/lsm_init.c   |  2 +-
> > >  5 files changed, 22 insertions(+), 12 deletions(-)
> >
> > This looks good to me, with one small nit below, but as we are at -rc7
> > I think this is best kept until after the upcoming merge window so it
> > has more than a few days in linux-next.  I'm going to merge this into
> > lsm/dev-staging with the expectation of merging it into lsm/dev after
> > the upcoming merge window closes.  If anyone wishes to object to this
> > patch or add their own review/ACK/test tag before then, please do.
> >
> > Thanks Jann.
> >
>
> Thanks.  FWIW I did also look at this closely.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Updated, thanks.

--=20
paul-moore.com
