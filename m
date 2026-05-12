Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7F3C415D
	for <audit@vger.kernel.org>; Tue, 12 May 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601295; cv=pass; b=tz9sWh5bO5arQKxWzwB2rPq/3rWLISw8gxf9IS05rVt5b6WL03DBJyhvYkLuu1g8QeHGxo1lF53GbS16IwK2j9z9/pNAo4ahlqXzqjtSj+3dGNIubLsHEyRi6QC/JpApSmV1+X2kvSX0qX60xffg/ao/dle6cOCG17smOGfDf4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601295; c=relaxed/simple;
	bh=yfen6gT4F5pLN3+8Lj1fUm2aqwWUU99GEMnZlWI99n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwvIeWGykEirCkPxefpgsFiDS5dSyBOR8W7vnKikou3Mg7rvReng1LtqG+eUn00b1AVovNuxUi4/YSu6fgmDS6PIOX6HDamP9c+BpDNRAL2myqTug8ybbAF0Ia/8+TqETpFA6bQFEcfwDy5X4roLugQ6fx84D27SAdB3jL8aIR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XVN3rDUR; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XVN3rDUR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365d8e43759so2879092a91.0
        for <audit@vger.kernel.org>; Tue, 12 May 2026 08:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778601293; cv=none;
        d=google.com; s=arc-20240605;
        b=eyhzUpan2mvkgGE/OrtWu25HMKhLlX/pWbpMDcnVZsGPBhkzPytIBTLPozlWgzbrAX
         WpLXq53KeFtCPBtA8m2Jr4UeweAg6Dc4SGA7LLutLAN8mGJYs4tSPWVCUVBv+BMY4liW
         VI+Wld5HhnCANnNTNIX0cZrUnlhzNZlSpwZEKeA70W52iynVoizhVw44FQBbo8BTuhy2
         RjCs5duWcxooPliWhKYCcsoK6ZLVI4t/qoasHgFc3hMyB5TFpgaTDfNhEYW+GypvdU5I
         wx4/XeNcHNeATIJNSeaVF8g57tDGS8HYVpj6iNYqesi5BdSyFIE8g7o0+uMrRMA/xuML
         FXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ajsWyryo4FJSJOg1yms62kUq7i2OClZRNDqx/6olwBE=;
        fh=kb+mVFeR7q2qaUSHCalI9j+dIuciy3FZCsgvpwt/Ku8=;
        b=IDM7wVcMMs0pRcjmmq5L79GnaDIDyCBI52qsePrPH7s3QD86T8lsHTpXkKNXq6oFky
         gWGkMmBbvIGTRgNvpQ8qKSwSKBiW21NCgRg+EZAsOq5rJMU5KXC7/vy0ZHAp4COnkVQR
         vkZOKFsU4LHwu+esB4Ewx1GuuE5rA3LE4dxVEsefnkPssIH7PPQEI0805e1Fku1V7BD9
         56QI9WBnHP8hLDjRooo2vE/KL47VoMVfbJm0P1mDRYyDP8YTImRfpRKZf4Z3s2iaxpWF
         mPcXycSa7gwUS584H6ihuesnjJjtZuL/h+fysXKUS0YrRkPlnD/Gm8VzaYta0ZZoHYm6
         O67Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778601293; x=1779206093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajsWyryo4FJSJOg1yms62kUq7i2OClZRNDqx/6olwBE=;
        b=XVN3rDUR2MAlB1UWx+IRU464MqSYBzJe8AZbRpCeATxuO9+ue6AZOk8X9OPe7sqgnU
         l/dqkBmpnwVDcI8UiOIQGApoHowh+2wl/BDfuf5/koB9O96hztmh3nWi8PvdKCnwwj+v
         JkHHQGQuIud2GpwkUL7gEWiB2seFvx/S3pm4hoICgKkK7P3/UGkw3dhXUmMHerDrIdeV
         vLGo3ZiQh5UybbifC+pxsB1x9MFmNEV38X/CZVVNvLdP9/Urd+0MsxgnSevqBzGHt7L+
         PiABLo4X0WVrrUsreWJ8bP/wPRMj0FxlNj9qLx3a2yp6FXiFvwPE2y+e5TBq2QOWyciR
         gvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601293; x=1779206093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajsWyryo4FJSJOg1yms62kUq7i2OClZRNDqx/6olwBE=;
        b=g7abYZL0m1HTWWiSdT9qlXH+qCipZhp4c0pEQmhRsBPEOWhmk0PTLgyMkkVBVWSE3g
         SU7p7sPdJ81vq8JYOk1c5rV/mp6ON/8OA4rWG7uIM0PQrYx1kp1B8yXFpB6/5C7hjX0V
         /J1NE9KlTeNCWyBeW5L+HXK7m/Z+eIqd7rFswiSbJKfs0TB3OZzQM+68FIJLmuispzhz
         OivUeDWQDy1VIJcYnIdiT56Dwd7El/vfi0lIYJ4TyLKhDiMUorobC7fS5Bl2EezLmxTC
         6C7bd/Pgl4560sO4IeB1gB+oRT9+Uy/40Mcpmppfnvia5p15UTTZWQT/3BL/8gTe615n
         cEWA==
X-Forwarded-Encrypted: i=1; AFNElJ/K6XfPpbeX6peug5r8aymitofKlD6/ZbO3GCRglxBecsIPDogBja60hA52dKRkFusBuPlADA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWaTF31o7fVYbv5aKmnPwIZuondvMqxmEa2m1PgU0aL01jalb
	72HOgG/le4InmuQWBIu+u50K5V+4/UB1WuyC9+bZRHrDpz58b9dzxeHVUIBpeZyXb08i++DtgCB
	g8517NKIEHAZqm6FrjaZuWLoIJ/GOYqYssZbxL+T2
X-Gm-Gg: Acq92OEe5WaVmhLn8fXMqrrkOH1efOypTlrMMgIdEk3Ezch3PRZUoEk8eNVyY/F/G81
	Iy+g+MZMqJitgYWzWop+uxKw4UeZnsU0GLEKHtnjsCqtWi6s5JHbzfI5eSginRqbGCW5VsJTx3k
	kO3ar8A5OhgTMi4FJDNzvSsmRT/ContI5qmLZGbsHjx0kkntFurJUUaBF7LDc+ZKICA4sgFphG7
	o7I0UFkc9TCewhWAzB+dQ0n42Mugxz0dJ1MAiuENl81TBQDgPueY3NZ3EbyU0iFySGTVkAy7+iw
	tvWDe+Y=
X-Received: by 2002:a17:90b:48cc:b0:35c:195e:112f with SMTP id
 98e67ed59e1d1-368abc9fdfemr4227058a91.18.1778601292758; Tue, 12 May 2026
 08:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
 <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
 <2620823.XAFRqVoOGU@x2> <CAHC9VhSK9wsK1kDwfGGVNzRqGb6RW-_eJkcoe0uHY839OnF7Mw@mail.gmail.com>
 <CAHC9VhTPPJmq9ezyi=KB+E+UfoTZA69QMfk79xGjG66pZx73XA@mail.gmail.com> <CAABTaaBGn+WCFqE87MKjM5Ngg9igL+PMNQKy=hUH7pQ=2mCwOA@mail.gmail.com>
In-Reply-To: <CAABTaaBGn+WCFqE87MKjM5Ngg9igL+PMNQKy=hUH7pQ=2mCwOA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 11:54:41 -0400
X-Gm-Features: AVHnY4Kqdz3EyIt2mWbXgwQk7Uz58oc8qVFi4IWvfg_QMlz4QJ6Mo8-joKaDR2w
Message-ID: <CAHC9VhTLKmwjZ8i0U2Atk4RgsKBof_XmDh8owe+5w0fQNUgyUg@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 9:02=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Apr 16, 2026 at 5:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Apr 16, 2026 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Apr 16, 2026 at 4:33=E2=80=AFPM Steve Grubb <sgrubb@redhat.co=
m> wrote:
> > > > On Wednesday, April 15, 2026 11:21:52=E2=80=AFAM Eastern Daylight T=
ime Paul Moore
> > > > wrote:
> > > > > On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@re=
dhat.com> wrote:
> > > > > > > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight=
 Time Paul Moore
> > > > wrote:
> > > > > > > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina
> > > > > > > > <rrobaina@redhat.com>
> > > > > > >
> > > > > > > wrote:
> > > > > > ...
> > > > > >
> > > > > > > ... compliance-driven systems that must use a finite backlog =
limit for
> > > > > > > memory safety but cannot tolerate dropped events ...>
> > > > > > You must pick one of those two requirements, or at the very lea=
st
> > > > > > prioritize them; it is simply impossible to both limit the back=
log
> > > > > > queue and require zero dropped events.
> > > > >
> > > > > To be perfectly honest, it's also impossible to require zero drop=
ped
> > > > > events.  Even in the most extreme configurations where the admin
> > > > > decides to panic the system, that only happens once the system re=
aches
> > > > > the point where it is dropping events.  We try *really* hard to n=
ot
> > > > > drop events, but it is always going to be a possibility.
> > > >
> > > > You're helping make the point.  Those administrators have decided r=
eliable
> > > > auditing is more important than system availability.
> > >
> > > Users prioritizing reliable auditing over system availability should
> > > not run with a backlog limit.  It's that simple.
> >
> > To clarify this further, even on systems without a backlog limit and a
> > panic-on-loss configuration, there is still a possibility that the
> > system could lose an event when it hits the edge before it panics.  A
> > maximum backlog stat won't help here.  Even if you had a way to
> > capture the backlog size before the system took itself out, the size
> > is flirting with the maximum resource limits of the system, it would
> > be silly to use that as a configured backlog limit, you would still
> > want to leave the limit at 0/disabled.
> >
> > > Regardless, I'm still not convinced this maximum backlog stat alone
> > > will solve any meaningful problems.  If your audit log is predictable
> > > enough that this metric has value, it should be possible to either
> > > capture the backlog size during periods of high audit load or simply
> > > run the system through that load and verify it doesn't crash and go t=
o
> > > hell.  If your audit log isn't predictable, capturing a maximum
> > > backlog size doesn't really mean anything since it is still a snapsho=
t
> > > of one instance of the system and there is always the possibility of
> > > the system exceeding it.
> >
> > --
> > paul-moore.com
> >
>
> Hi Paul,
>
> Thanks for reviewing the patch and giving your perspective on it.
>
> I understand your point that if a system truly prioritizes auditing
> over everything else, it shouldn't run with a limit. However, in
> practice, there is a middle ground where compliance frameworks or
> internal infrastructure policies require a finite backlog limit to
> ensure memory safety, while still demanding reliable auditing.

It is important that those users understand they are believing a lie
if they think one can demand reliable auditing with a finite backlog
limit.

> I'd like to ask what specific metric or combination of metrics you
> would be willing to consider? You mentioned average queue length
> earlier, and Steve suggested combining the max depth with a
> backlog_lost_since_reset counter. I'm happy to work on a v2 that
> addresses your concerns while still delivering the metrics audit users
> currently lack.

My suggestion would be to put forth a proposal explaining the problems
you want to solve and what metrics you believe are important towards
solving those problems.  I agree that the current list of audit
metrics are rather sparse, but as we've seen here, I don't think we
yet have agreement on what metrics would be useful.  My hope is that
having a discussion on the metrics first could avoid false starts as
we've seen here.

--=20
paul-moore.com
