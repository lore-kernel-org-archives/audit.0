Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D603890F1
	for <audit@vger.kernel.org>; Wed, 27 May 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910517; cv=none; b=oKA4sN8ba1F9Fg0Yz+nMyF65umOA3r0km+HocpNUAyN0EtOtT7HpNH7CaFMi2H27VfDGcrZH4wHGzo8x3yRs7Sd5NTg8+qUJ9MmmKGP6BY4/x/N0XoJqRjRQE23aI0mJbQrybjnDpbwhAgBGX6P0mtxyyOiIUrtIMzmCE1o7pTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910517; c=relaxed/simple;
	bh=UioVoqnLSFh+ScDWF0CUCSjlPvyH3Iqmx7+g1G8fJI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b24DtZ7oNi1QNv1Ijj/HClBabgXoKYTT7hT7jgI84feEw8rNzlEl4xKNhjCZGA+Gn5txWtAewQVz3ayAFfRvfm6SOWSNs+hG8Mq3xqLTAdFaO3D6IdiWOaG7QtaIdS3Aj4zrPQhz+owYGLYMyWo/rvJq+W+YMFCbYovvLKeYmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdtJXZ4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdtJXZ4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
	b=fdtJXZ4UmNFjPuyMNO6fIH6DaGm1K3vjyYDk99csgDzsJT1QCOeVqbyMkXxh56fxMgaMUI
	9FabNs+/SBBjVH89UPq/07o1+GPMGNKuTUR737MWzXqyViJvmZUlFtP5R0HZY/81WsKitu
	bfCsmBvi46DXADWUOe9jM3dfj3vEJZM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-0AfF35KAMmK5SSWDKAo-xw-1; Wed, 27 May 2026 15:35:02 -0400
X-MC-Unique: 0AfF35KAMmK5SSWDKAo-xw-1
X-Mimecast-MFC-AGG-ID: 0AfF35KAMmK5SSWDKAo-xw_1779910501
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-688b057233aso4839957a12.3
        for <audit@vger.kernel.org>; Wed, 27 May 2026 12:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910501; x=1780515301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOS9eTOdcJUhMB2b3uxTB3EnkotZkuo43wnh8DbWJcU=;
        b=QKbfj5vUDiyMBqebM7CXY75Gc/j9/mW93z2XqfMf/D8ZiLvWY1Y6fzMatt17clpgYB
         12VxVbr9+SfV7LVPqouCeTC4bbqTHlnu+Vf/aU7cu5b0cM1Usb7Pugnb3QgUc2lvWegj
         HbyHq2mioJqDjqm8A0Jy4UcoEX1XT/rvxZOP/Pv7lIZ1ZDie0dupgI6omVMq8zJOIr40
         HvD1+UsdCSjPeQsgH1h3WMzQeS2GXV5REqyVJ0SUUOVkuKlfISkmBkszt2LAHnMBH4Gm
         bdnVULBxCaq6GULFTTWMo9kiQQjTGJ8QkL1mIb1LTAk7y6obojXWu8YSEx2e0nGsKXHr
         3dRg==
X-Forwarded-Encrypted: i=1; AFNElJ8nYgtmZIFvozhdjtTHLUtxZVpWbAOI9VaHNG+gFpG1Nl2AhnnHEpzJ5oUWBRt25Eis39JNVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRO/Ca5lXOqZ8HJTB/1PkwjDLmUKB/ks/Bsf1xpR4if6eP9BSH
	DlJ5IZetzD8FnGTnMqQjavX9mmN02q0inqUnkTsQNSKKh+boHnmp3Ce1+BKnxISd/6djgjjXY3C
	mgfdp5abm9g9F3OKseo0uxGqVjIZMfiaGbfWilPGIHzKmIN/VL17Bmbm+XwjPtIXpY8cKl2XUst
	LDmZ3zdmcYV3kKcwvAqKBK5uZY7BFvmkk=
X-Gm-Gg: Acq92OG4ePm9Oy6bz0a7E2O6PCbqUs004x8PQgnpcAv1NAnbQOM3LKOSz7WjxYki2Vk
	vvyoelFazUMCA029MYQB5CdaBZlXBnqb/kWXL2UwnnQG8z7NatqwnBQQSqxwNX4/SFu1BvYxGxR
	pDNPX/Vlzu+c5DKiiDEmcKXqOoHnHYIDNxgbs4n04UB/nl7Xo/VwkXkw343/c4Vf47ak2YStiKd
	6eHmZ+A3EMzrOoCnGZ+ITyI1/qonspBQORTf4dtRrPR5gNDWvsNZ1aqeAlXDTbzP0u52mYdhpL2
	WiRdSbR9gCuR/H6y01UCOptjtKPL42bvNkg=
X-Received: by 2002:a17:907:7848:b0:be2:d66:eb4d with SMTP id a640c23a62f3a-be20d66fad5mr604748866b.44.1779910500763;
        Wed, 27 May 2026 12:35:00 -0700 (PDT)
X-Received: by 2002:a17:907:7848:b0:be2:d66:eb4d with SMTP id
 a640c23a62f3a-be20d66fad5mr604747366b.44.1779910500315; Wed, 27 May 2026
 12:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
 <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
In-Reply-To: <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 16:34:48 -0300
X-Gm-Features: AVHnY4Kc83ebKqVSHeiSfUT51upa2HdihkVQbYI9amS-pNOG_aGc7MyxSSH-1ZY
Message-ID: <CAABTaaAO6_OB0EBpttCgo+pDjip8BbpX6CQa1-f+_Ywrgem0-g@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Paul Moore <paul@paul-moore.com>
Cc: Jakub Kicinski <kuba@kernel.org>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, eparis@redhat.com, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, Steve Grubb <sgrubb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iZqv3TP1fjYYDU_5A7ZPe0zy4yjaDatg6hmjaypNhts_1779910501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, May 18, 2026 at 8:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks =
on
> > > the netlink socket.
> >
> > Holding socket lock during slow IO sounds very wrong. One could say -
> > that's abuse of the socket lock?
>
> It's no different than any other kernel subsystem sending netlink
> packets to userspace, although in some configurations the rate at
> which audit sends netlink traffic is likely much higher than the
> majority of netlink users.
>
> Arguably, audit probably never should have used netlink, but that
> decision happened a long time ago and there were other issues
> complicating the decision.
>
> > > If the wait timeout fully expires (timeo =3D=3D 0),
> > > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > > request. It then triggers netlink_overrun that drops the event,
> > > completely bypassing the audit subsystem's internal retry queue, and
> > > falsely returns ENOBUFS to user-space, resulting in the following err=
or:
> > >
> > >  auditd[]: Error receiving audit netlink packet (No buffer space avai=
lable)
> > >
> > > Fix this by detecting when a blocking sender's timeout has expired
> > > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, ins=
tead
> > > of retrying with timeo=3D0 (which would incorrectly trigger netlink_o=
verrun
> > > on the next iteration), safely free the skb and return -EAGAIN, allow=
ing
> > > the audit subsystem to gracefully enqueue the pending event into its
> > > internal backlog.
> >
> > The socket _is_ the queue, normally.
>
> There is a joke in there about audit and "normal", but I'll leave that
> as an exercise for the reader.  I will say that audit has a lot of
> unique requirements regarding queue management and that dictates a lot
> of the wacky stuff audit has to do with it's record queue; the
> standard socket buffer functionality doesn't have everything, and I
> wouldn't want to ask for it to be augmented in a way that satisfies
> audit.
>
> > Please explore fixing this in audit?
>
> Ricardo, I was kinda hoping not to have to do this in audit, but I
> think you can probably get away with just open-coding
> netlink_unicast() in audit and then going from there ... we might want
> to do some other things differently, but let's see what a basic patch
> looks like before we spend a lot time redesigning it.
>
> --
> paul-moore.com
>

Hi Paul,

Thank you for your input here, I appreciate it.

Before pursuing the open-coding approach, I wanted to let you know I have
a v3 patch [1] ready that addresses the concerns raised before.
It introduces NETLINK_UNICAST_TIMED as an explicit
opt-in constant (value 2) rather than the broader heuristic in v2.

Would you be open to reviewing this approach first? If you still prefer
the open-coding route or if v3 gets pushed back, I'm happy to go that direc=
tion.

[1] https://lore.kernel.org/audit/20260527192150.949400-1-rrobaina@redhat.c=
om/T/#u

Best regards,
Ricardo

