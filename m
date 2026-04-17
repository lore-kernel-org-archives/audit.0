Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DD72622
	for <audit@vger.kernel.org>; Fri, 17 Apr 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430968; cv=none; b=QZZcdzJyBlt+XZNbnD2gMO+Vy4mOcJa8dCaQMzB6TXmY5zYJCcsSG0MfZ1twkWCJVFAZSmc5y6mojX9uw816MNmaIJEX6HKXfwxIGoj8klxofHcd8Y/uXN87RU/dE0MjjYYe7ASwK7r+1cpo2k2Mk1IctxCip8HYNfuAeMNaMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430968; c=relaxed/simple;
	bh=b3/lhbmCXLTZ8DEhr69iVmYz8kDxPZN8a4cFOKj4Q84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3v/LjHQAVw7UnLytwCLte5lnePGY7omgfAAzzApu1xzK0u9ivIJJ96yaizDrn3QBvV/NpsvBxu1RbrfZOllbalURhiOs4k2owK80I5bL4/b4VEeeRTjwHaGHkDPJFhTv7mMDKHoqCPfvQZ/IVDR+lp4A6yLdNomCf3BezUAEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKE7mJuf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKE7mJuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776430965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQN5kUUbOytW0opBylTYXspxVd2J7h7QgtKibjkDwVU=;
	b=QKE7mJufggVpHJrJUWhdvmEs5zDFLgT94t+WWj6NEmXvtClItsBiJQ9gkjZuoT47Yf7KYM
	sIYqmALi17sC9cMhk5In+26bpF80tMneTFXZERgzSI4zGcNLq+z+Q1GRH/DRN9YEBPLEhI
	aNx2+8WOIsL/sWcI0ERzja66hQbDyeI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-UT1pBDrTPJyCq8zOgHdW9w-1; Fri, 17 Apr 2026 09:02:44 -0400
X-MC-Unique: UT1pBDrTPJyCq8zOgHdW9w-1
X-Mimecast-MFC-AGG-ID: UT1pBDrTPJyCq8zOgHdW9w_1776430963
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9c0bdea9faso68127466b.2
        for <audit@vger.kernel.org>; Fri, 17 Apr 2026 06:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430963; x=1777035763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQN5kUUbOytW0opBylTYXspxVd2J7h7QgtKibjkDwVU=;
        b=BcbnLODiCg1ltmY04bK6Nxaqyiwg1nmShOGk2b5tZEPZqgZO0iKgnTQp7TysY1+CR/
         a+eqfY1h5/ozy1o4ZA6lRsj4Q+qWn48CCAlf2+/6JmpuR3dW6+e4nlyJhuGFgGKq6GEM
         w32iCvg+O+i5FV53vtCJZdfpDr0CTfkUojSCDwFOaqWV05bapjarF9k59gD2lbg11rgo
         SnuUbSQpKKsN0/IQU/5PwSMx/J4mMKydYy3QVQtNRy6UC/VeY7xmjCxv2VbULSJYZiX3
         IHbiHmNEEAQO3pZDOmFsSosgrJmsmca5I6D6KV+QBZ1gwysIZEqd34Xd7ZPG/tQkBCSe
         dK4w==
X-Forwarded-Encrypted: i=1; AFNElJ9mk3/xmhTpasJy/WJti9lSMSI5B/rnZmdxRsKsFLC7T/nyIeDKwmaT2kNjZbbSSiZmqBk3cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Pv0Y0lp9HLzWFxUukAHEemO11ogvXaD7lnebzOD2z/oFu0QK
	W8hr7NvK8RQWcXZc0UrccQIt5M9KV+A4u0Xa/k6gvR5maUn7J55kbElFlY0Fd9zkmFDRorZTPGC
	1oKPXRvmrGnr1REnnVW3KWlR9RqfMTA+lOZrLf2hX/31YFwQvlc6WOM4l1qZng3GmWgxtGmeaWj
	xGOMebb0E3BonO7FTv/Vw52wn/0j6d04Q=
X-Gm-Gg: AeBDietdWkV8ornkqVGVYzCniqxuLomgI45Gz6SQNxBa9USil3+C88CqpKAfXojON92
	RVmHpWLqlM7RvLxjL1OISv4WZBFHWARkCvVv71IUVyJ89qKUI5vMCHX3INKcOayzj9fLKmZ8nrB
	shZc1hTW8tExnG0eVQoclyA6+Lx/bctbtBuAXtEhC9E85u7puhzOgRDFMFYO4YUa7IZodihtvOV
	TdvIhzAuJ497gn3Mpf2k143Nk7FJzqvnbWPEuGTWo4vVPtNpquO03LUp2NteOCxV82VBbdn5Es2
	foJPH5v+XG6UiMxUpHeVbeSkpam74ALYW/c=
X-Received: by 2002:a17:907:3f22:b0:ba4:8883:7f33 with SMTP id a640c23a62f3a-ba488838064mr109639866b.10.1776430951643;
        Fri, 17 Apr 2026 06:02:31 -0700 (PDT)
X-Received: by 2002:a17:907:3f22:b0:ba4:8883:7f33 with SMTP id
 a640c23a62f3a-ba488838064mr109547566b.10.1776430941535; Fri, 17 Apr 2026
 06:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
 <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
 <2620823.XAFRqVoOGU@x2> <CAHC9VhSK9wsK1kDwfGGVNzRqGb6RW-_eJkcoe0uHY839OnF7Mw@mail.gmail.com>
 <CAHC9VhTPPJmq9ezyi=KB+E+UfoTZA69QMfk79xGjG66pZx73XA@mail.gmail.com>
In-Reply-To: <CAHC9VhTPPJmq9ezyi=KB+E+UfoTZA69QMfk79xGjG66pZx73XA@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 17 Apr 2026 10:02:06 -0300
X-Gm-Features: AQROBzA1MSJUe864-XSAtEcwo7h_rN4560Vp_kPV4Hc08NxiiG8bQ96wMrdmyJM
Message-ID: <CAABTaaBGn+WCFqE87MKjM5Ngg9igL+PMNQKy=hUH7pQ=2mCwOA@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kl21Fbz1sanOVheYO_Z-71tvXVCyF4Apwq1BLh-FpRQ_1776430963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 5:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Apr 16, 2026 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Apr 16, 2026 at 4:33=E2=80=AFPM Steve Grubb <sgrubb@redhat.com>=
 wrote:
> > > On Wednesday, April 15, 2026 11:21:52=E2=80=AFAM Eastern Daylight Tim=
e Paul Moore
> > > wrote:
> > > > On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redh=
at.com> wrote:
> > > > > > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight T=
ime Paul Moore
> > > wrote:
> > > > > > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina
> > > > > > > <rrobaina@redhat.com>
> > > > > >
> > > > > > wrote:
> > > > > ...
> > > > >
> > > > > > ... compliance-driven systems that must use a finite backlog li=
mit for
> > > > > > memory safety but cannot tolerate dropped events ...>
> > > > > You must pick one of those two requirements, or at the very least
> > > > > prioritize them; it is simply impossible to both limit the backlo=
g
> > > > > queue and require zero dropped events.
> > > >
> > > > To be perfectly honest, it's also impossible to require zero droppe=
d
> > > > events.  Even in the most extreme configurations where the admin
> > > > decides to panic the system, that only happens once the system reac=
hes
> > > > the point where it is dropping events.  We try *really* hard to not
> > > > drop events, but it is always going to be a possibility.
> > >
> > > You're helping make the point.  Those administrators have decided rel=
iable
> > > auditing is more important than system availability.
> >
> > Users prioritizing reliable auditing over system availability should
> > not run with a backlog limit.  It's that simple.
>
> To clarify this further, even on systems without a backlog limit and a
> panic-on-loss configuration, there is still a possibility that the
> system could lose an event when it hits the edge before it panics.  A
> maximum backlog stat won't help here.  Even if you had a way to
> capture the backlog size before the system took itself out, the size
> is flirting with the maximum resource limits of the system, it would
> be silly to use that as a configured backlog limit, you would still
> want to leave the limit at 0/disabled.
>
> > Regardless, I'm still not convinced this maximum backlog stat alone
> > will solve any meaningful problems.  If your audit log is predictable
> > enough that this metric has value, it should be possible to either
> > capture the backlog size during periods of high audit load or simply
> > run the system through that load and verify it doesn't crash and go to
> > hell.  If your audit log isn't predictable, capturing a maximum
> > backlog size doesn't really mean anything since it is still a snapshot
> > of one instance of the system and there is always the possibility of
> > the system exceeding it.
>
> --
> paul-moore.com
>

Hi Paul,

Thanks for reviewing the patch and giving your perspective on it.

I understand your point that if a system truly prioritizes auditing
over everything else, it shouldn't run with a limit. However, in
practice, there is a middle ground where compliance frameworks or
internal infrastructure policies require a finite backlog limit to
ensure memory safety, while still demanding reliable auditing.

Currently, audit users are looking for a way to tune the system based
on an optimal setting for their workload that satisfies memory
constraints while practically minimizing dropped events to near-zero.
I strongly believe such users would make good use of backlog_max_depth
because it lets them know what the worst-case scenarios look like and
how big the spikes can be. This allows them to base their tuning
decisions on real data rather than guesswork, as is usually done
nowadays. Other than that, exposing such metrics would allow users to
leverage services like tuned to dynamically adjust limits based on
workload.

That being said, I hear your concern about whether a single "max"
value alone is worth consuming a bit in the audit_status bitmask. So,
I'd like to ask what specific metric or combination of metrics you
would be willing to consider? You mentioned average queue length
earlier, and Steve suggested combining the max depth with a
backlog_lost_since_reset counter. I'm happy to work on a v2 that
addresses your concerns while still delivering the metrics audit users
currently lack.

-Ricardo

