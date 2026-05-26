Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A936897F
	for <audit@vger.kernel.org>; Tue, 26 May 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828851; cv=pass; b=Oxob06TxWooaitkWrVCA2+3zgTuTb5UKnXFC4rPizc81o7RgrMMcttr91TK1QAntkQQckeTQRdhllaUmwnUbbYSdgoRu1N/sbhWlFtE8hQZw0bqUtCHiPpwSao/mT009LWcTvUqh2f//aEqeCNP87M7UZdfZ8V8qvwKcLLwZKAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828851; c=relaxed/simple;
	bh=g3tAHZlmjqVB8F58Yb4ZWVoVwqFrZlKYWsPBDFTsCxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlmCpdq5hm+XeDO6xSipWiocSDOwNgKf9AErEMhrVx/43hLdLYcWwljyrG0fSUIibk8rKwdCjXpHnp3fiHAZpEKw3T85+/oNy0V5hzKzRMkiGasey3s8Qry/FsHeOMjKFmTf4/1pJ3L8CyiQgYCWmSDk58O9Kzl7NzudiXsaGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BiQ+/ToJ; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BiQ+/ToJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366375c4076so4774794a91.3
        for <audit@vger.kernel.org>; Tue, 26 May 2026 13:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779828849; cv=none;
        d=google.com; s=arc-20240605;
        b=eBOXoCeEEmAjriZwMekEBjcIbjZEj7uUmToS4BimC7X9ZxNk/frAc2XfwYXXPSgVHG
         9fmJJ8/fV+N0K9PzCaEYoXRzpiMXEYUfP/F+Q/uTDBAKIroVktcwMqaOBswq0pBnn0x2
         8U9KJ9ogcOSZ/PF2KmVCz/HuTPNj0Aog41WE37cPnQoNdtXlRQcUSiLT/3ql+VI3CoLK
         +BHkdpxJiFwkTkdPhlbEAhcayZ1xsgnRyEdBbzEOMzKE6SJ75swuiordv6gAAxXF+sUA
         PrAjfG6x7hdV3PJxIAtAy1VG6OMqtxKjeRe+hDasXbSeeeOiYgc1/Jz9ogywLs53Py3u
         1b8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        fh=ib96Zlqtd+wmjgRKvenb4Kuxa9s0g05USukCKjx/Lwo=;
        b=HUFI3lnz2E9pXGxtDaruFwK5UNfRu0qmvfW9oiJraN2uQXYFcVdZgPJ1xeLBmfMo6Q
         RrTsCyJSK29LyhYKCJeX8bUF9VCcdPWPBBPVeZeI+Gm9d/ot9ZdBv2xMOjn3fVvodsQi
         j+kBxVp6LRk5DLwfZgJwnvEOlVn0qXCHPlDQciVqd/kPtMXSkapSMChkNir6aOMz1AJS
         vkWX17quIkzhbmflAgpRUOJIheEbMIDSySwYjbJhk1OXKSE5GC+uPoATDvw5RjYS+Dil
         oUCFc/j7FLNGey9TRslpKhsQxh66rX4Un1EDzkKghtYUL0e7uMxBparHuFkIBSrGO3B4
         FXPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779828849; x=1780433649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        b=BiQ+/ToJHIOJ55puvWhOri2tKGmpGGparX1e0GFnXBYuKD7cD7HLhJL3/RT6x0k0Mc
         +044LWaf0Eqo7dHy7ZyYq8VqldtRi9TbiHejuNUccz6K2v+LCrm/Fy/2BjqrM4S7lnmI
         aBUslhqQCdLC3FN0OkvXqPRTIy1AB72PAg9Y7nzZ1jnptayjWJWj/dCtzl8pp43eOkIM
         eAfvfpHuIGiYtfps3WrHxfMEeMr3BA4Cl1plNDuCpUWZpU2KAUHOgGFo+ToiShNlSxUk
         GZNsyD/L5id63VoJWhlOBlA8X7qS24HRclASh0sXi64rcqwQCW8z1X+RDaprUwwd8WA4
         8Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828849; x=1780433649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        b=j7t/ZzL+6oO6pd8sCoiDZR7vGZw3E2wVKjXK7MB7BGbo8CaaYp9uto/qwD9LEHE/yR
         hpaiNAa5nSbJ+Ysp1gxwiH+3urhTUsURK6xb4CzplITKmSXD1rBIiSdAGm2ex1+roZY6
         CkB9Kd6rR5+6J6aFLsWVGk82i7EgYo4UD2pTlrDOpTCkgY3SshCXz98nJ5duttoIEt+B
         ETsATs4E0W4NHoOA4EfaHJ+6p7BheeXayksHdurGSRvpLv95cYPzSduGDnwiPhYcfs1q
         wEhKJ+loytBHxY1bXUkfxguaFfzjyhhSSwQaN/oJSfJD1rYpfE/Yt0tVkIvEUAEne6Em
         Sk/A==
X-Forwarded-Encrypted: i=1; AFNElJ8RHcT70XQDy80uIrkgP5uOXiwat3eiZXzMDksVGH6r7oo4AxCD4ENag+wpwfJ/OU6l0wWEtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGFtXOw/luqSa2vcoRQrjtR1vm5xT7WQh08SbvUCgKo+OOwuW
	gVIT3lKn/k8sWs3AOVWtN7Kzq7iYa6a5q87kHnoZCI42PS0jijgRYMyc7sAa5pzmgYamVFHLhDh
	5AqW0pEGJHYOnwRxkTpW/Nh8kTAeOrSeYeF6f3VOQ
X-Gm-Gg: Acq92OGlj/4O1W2EE3/iT00VYdFFok21yGC/KMC+jVnxgKPxZwhn8UuxG4kp0qHkHsG
	cf/tJJFGq07tmqQ3dC3cWRunQHGgM8/t7PaG5v9vp8RWRVgI29ujoljYRp+gTDszDkHqPU1Jfmg
	0GV2DbUQbvH7StSXSBN/Mks4PLCkarNsy/ec50a004Yfm+sgT+0qvV3R7ndLY062Gi9+RmJ6t2n
	CcXvjPXbskU2qpuyNdc4Z9apDptuXEk0p+P3YoD0U1SGDUglbmjZgbrb6Ni9WY2imyZyzTKFztK
	f+Kn8pU=
X-Received: by 2002:a17:90b:1a8e:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36a674f81fbmr20198798a91.12.1779828849269; Tue, 26 May 2026
 13:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
In-Reply-To: <20260518173507.2f2529c9@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 May 2026 16:53:57 -0400
X-Gm-Features: AVHnY4JL0a8xLE4fxERdMP_DngilckfsvKCCxAGn7xyy829c-DKtroKv7TSAUyk
Message-ID: <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, eparis@redhat.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket.
>
> Holding socket lock during slow IO sounds very wrong. One could say -
> that's abuse of the socket lock?

It's no different than any other kernel subsystem sending netlink
packets to userspace, although in some configurations the rate at
which audit sends netlink traffic is likely much higher than the
majority of netlink users.

Arguably, audit probably never should have used netlink, but that
decision happened a long time ago and there were other issues
complicating the decision.

> > If the wait timeout fully expires (timeo =3D=3D 0),
> > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > request. It then triggers netlink_overrun that drops the event,
> > completely bypassing the audit subsystem's internal retry queue, and
> > falsely returns ENOBUFS to user-space, resulting in the following error=
:
> >
> >  auditd[]: Error receiving audit netlink packet (No buffer space availa=
ble)
> >
> > Fix this by detecting when a blocking sender's timeout has expired
> > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, inste=
ad
> > of retrying with timeo=3D0 (which would incorrectly trigger netlink_ove=
rrun
> > on the next iteration), safely free the skb and return -EAGAIN, allowin=
g
> > the audit subsystem to gracefully enqueue the pending event into its
> > internal backlog.
>
> The socket _is_ the queue, normally.

There is a joke in there about audit and "normal", but I'll leave that
as an exercise for the reader.  I will say that audit has a lot of
unique requirements regarding queue management and that dictates a lot
of the wacky stuff audit has to do with it's record queue; the
standard socket buffer functionality doesn't have everything, and I
wouldn't want to ask for it to be augmented in a way that satisfies
audit.

> Please explore fixing this in audit?

Ricardo, I was kinda hoping not to have to do this in audit, but I
think you can probably get away with just open-coding
netlink_unicast() in audit and then going from there ... we might want
to do some other things differently, but let's see what a basic patch
looks like before we spend a lot time redesigning it.

--=20
paul-moore.com
