Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995936DA1C
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910193; cv=none; b=DFVfEtfgKV4dWPDlAJ6wHnc1CStFfVgdZowK08Rvy2y4Bezyc/mD4GYDN8/BKWQO9ME/9ie+PYF2hNlmp7sDM0swQXNho9J6udGf+5nV+eGh7zK8KNlEANMXZvJ9oYctHblrHc7ELCwlwKqVHP3KvpvvSiMjubZch5EUzZR+A/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910193; c=relaxed/simple;
	bh=mI4DM/wWXgFpRBoa1oWbSDDYSxPkY0g0LzVWkMC3hhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1GIs/PmEquV7+bpc2Gm5j43m0fdcmX3BQSSbP5yM8Tp/KGf8ZvklJJodZlCua8Nqvp3+Q4GglVifWJZuJXPCFRRCcouWy1rsUSTPBKaTWSCVghGHqZTXz84CLyX9IgMRfVgX8m+G7EtYuvrAnByoPIh5UUjASdCV220192WEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cy7+5Uog; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy7+5Uog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
	b=Cy7+5UogVC8vBQyAJq6yrxM0bQETij/EY54BCrkKIr1Fgauphd28Fc/oiho03osIp3Wa2j
	vfIiw8qKxZTe0O21YaCizC4qLGy/9I/o+sR+hzzqz79Zc/7SenqyDyNdXBmiSbfenY1MFf
	lR53nl39tAloeenbZBnSpMz6WkdNQik=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-ggAP_0HgN0Wjj8Vrk2oyyA-1; Wed, 27 May 2026 15:29:50 -0400
X-MC-Unique: ggAP_0HgN0Wjj8Vrk2oyyA-1
X-Mimecast-MFC-AGG-ID: ggAP_0HgN0Wjj8Vrk2oyyA_1779910189
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bd52e4acb11so898383866b.3
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910189; x=1780514989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmOixJ8OhAzEjiG1t8Rown3BNCiSEDWt/TKSXpZPIRI=;
        b=dIOS3hT/oDoef0HWnkJ61dhp9Mtzxx0sVjR7TJkEJ4UrV01D5Xm8WiHM5n9/eeKRc2
         AHrqEkg8R12niMAxjNJC8VnZUIekcuCwZ7qlF+Vb9ddn/i4ahEB8p5e4E1l+RXXOczEv
         MuZS2MouAvS979YZhV/8h4AhigX6KRdrd8Vd1e3U/ckgTDdj8xbnYyPyQX4W2JFyVQb/
         dAGkQxIbRAc6Ygiz25P03id3AgRsXIwKTyaB8MwuMzp3DbAPwyJfeaAHoUdByl5TQkwU
         GiIdJPSPXZB607ZMQ7BXFQDDXmNk4g6F5HggCIMNSrBn/HkIjzPDIS7F7vSv+1R9VnXz
         Eaww==
X-Gm-Message-State: AOJu0YzgZZ187bmmFngPKYr5DZOkSkAmBwFwEEEfphqLNb+NjiO+o1Ax
	NLfRqifLA3IVBZd5PD6Q1AkBC9hFNtEIGjLRJJXnGYCPIpFY0k+aSiZMlO41LfLP/2xWNzxKPUp
	8yzyV3B6I7Jqb1sNb14oNeIeLqzS/fjWegx9/1XFvYMEVeSkxVmf+/P/VKuinUvQAnbRmrhOACN
	BwSOAmkt6NIY/K3MhRAmXDvH3LSJ9mmX0=
X-Gm-Gg: Acq92OHjsr1QWV/hiCepDz6nMQQBjSo25Q8WwWjppDPg7Fpi9CjjcrQ+yk4urJbEFVv
	g5oeFHF6D/Zvv/1oGSiFnw+CwLCvJzCJQj4QJjhWHsSQL3tvxQvmj43NZ+T+kf+QhbKgqejXe5e
	Kj0TWOTZXJKdO16HeA0OISWjaY6y8R5B5o6Y+0Z4iIxrkhihqaN0roUh/qQHc+6KeB6M5/e22tL
	Q9i94XNZoiTGlLg3NAhrsbgmC6BaWg25GGv35fI319TnOoYhHaYVRC0s1MeBV4Kiw86a3snyXqf
	I/Fr/8lLee9GX0DkXeSxUjZ9iCrtiP4gYGk=
X-Received: by 2002:a17:907:501f:b0:bdd:f2c9:80cc with SMTP id a640c23a62f3a-bddf2c98604mr929426666b.21.1779910188849;
        Wed, 27 May 2026 12:29:48 -0700 (PDT)
X-Received: by 2002:a17:907:501f:b0:bdd:f2c9:80cc with SMTP id
 a640c23a62f3a-bddf2c98604mr929424966b.21.1779910188396; Wed, 27 May 2026
 12:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
In-Reply-To: <20260518173507.2f2529c9@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:29:37 -0300
X-Gm-Features: AVHnY4Kl_unlcX1KSh4XkjPdquZdWKNsmSzuZiNKp6pIC0wDMd2CoGNSVFOT7sI
Message-ID: <CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Jakub Kicinski <kuba@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GlfKlTQ_b26kixF5kJ8V6HDpIWoixqxdlJM3VQx-gVE_1779910189
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket.
>
> Holding socket lock during slow IO sounds very wrong. One could say -
> that's abuse of the socket lock?
>
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
>
> Please explore fixing this in audit?
> --
> pw-bot: cr
>

Hi Jakub,

Thanks for reviewing this patch as well.

First, regarding the lock: kauditd does not hold the socket lock during
slow I/O. The sleep in netlink_attachskb() uses schedule_timeout() on
nlk->wait (a wait queue). No socket lock or mutex is held during the sleep.

Second, regarding an audit-only fix: the symptom manifests as sk->sk_err =
=3D
ENOBUFS set inside netlink_overrun() (called from netlink_attachskb when
timeo =3D=3D 0). Audit has no mechanism to prevent or clear this socket sta=
te
from the outside. Potential workarounds all fail:

(1) Clearing sk_err after the fact is racy and affects other socket ops
(2) Avoiding timeouts entirely defeats the anti-deadlock mechanism
(3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
kernels where this bug is actively impacting users

I've submitted v3 [1] with NETLINK_UNICAST_TIMED as an explicit opt-in
constant. This is strictly additive and leaves all existing callers
untouched:

- Standard blocking (0): unchanged
- Standard non-blocking (1, MSG_DONTWAIT): unchanged
- Timed blocking (2): new opt-in for audit

Would you mind reviewing the v3 and checking if it would be considered?

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo

