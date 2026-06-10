Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52462314D1A
	for <audit@vger.kernel.org>; Wed, 10 Jun 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108797; cv=none; b=Cpn9mJDrK09mqBpTuZHQ3gU0wGixtco7OJ3XYaySVOjNpzR1resIxV0R06/hdHKf5flMjuCq4FFcr3r/1AAmvzHzuUm/AJF8aUf8z/HokNdFdV4EHM2lOARR3vykhrZSrKoleWyyKNbQr+118HWUkcePUtc8n3uOQ7YLvhZjMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108797; c=relaxed/simple;
	bh=R94o9kKWxZnxQHJWjjbLI9Frl6B1js/BjkM4peHdIDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq7xFiefRvD5ye08AmYMU0zgCQcyA2/oCMtLVtf1QgqK8eUOz3klFVCkd/822MbmwGGoo7444/DYvAHV43cTtdIaxmRPPeDSNurWyy7xQ8d+igg4wcJIzBepzkcsiyQFUpvfUZ+r95LM6SeADLjdWdDVe7hKOkN4fI5JlTXLx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcdyY4k1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcdyY4k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781108795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R94o9kKWxZnxQHJWjjbLI9Frl6B1js/BjkM4peHdIDM=;
	b=HcdyY4k1mMcQ3LXsjKSeJHDdIoniEsq2Jwjp6kMShjdMy/MV9durpo0w3Xbn/5o8Fxx9ov
	63DBRnL6Yzb7i8RKFptxfjOkkQvPfz4D8q4CsJlssgk0EjcGR2EGJV/G4oEOzONfWk55UP
	AYbyJMObGdTWzSONHizQyCgqJd7OCNc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-pU5PK4CsN46QF5EWjhMXpw-1; Wed,
 10 Jun 2026 12:26:32 -0400
X-MC-Unique: pU5PK4CsN46QF5EWjhMXpw-1
X-Mimecast-MFC-AGG-ID: pU5PK4CsN46QF5EWjhMXpw_1781108790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86E91945CB5;
	Wed, 10 Jun 2026 16:26:30 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.89.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 284571800591;
	Wed, 10 Jun 2026 16:26:29 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink,
 audit: prevent false ENOBUFS on timeout expiry
Date: Wed, 10 Jun 2026 12:26:27 -0400
Message-ID: <3707933.dWV9SEqChM@x2>
Organization: Red Hat
In-Reply-To: <20260609143558.49d96656@kernel.org>
References: <20260513172443.1128496-1-rrobaina@redhat.com> <2756655.vYhyI6sBWr@x2>
 <20260609143558.49d96656@kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: OEhTRJAkmsx8EqX7pN2RNge223d5pC6v_zBajY469oA_1781108790
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hello,

On Tuesday, June 9, 2026 5:35:58=E2=80=AFPM Eastern Daylight Time Jakub Kic=
inski=20
wrote:
> On Tue, 09 Jun 2026 13:40:23 -0400 Steve Grubb wrote:
> > > > You're right, it is. I see how this flag would fix the pathological
> > > > behavior that was reported. But as I have looked at this suggestion=
,
> > > > there seems to be one wrinkle. User space should not need to know
> > > > that
> > > > the audit code in the kernel has this retry mechanism.
> > >=20
> > > It's not about the retry mechanism, at least in my mind - I read
> > > your reply as "user space should not know that there was congestion".
> > > Why?
> >=20
> > In the audit case, it is not useful. I know there can be an endless
> > supply and there's not much that can be done except dequeueing what's
> > next.
> >=20
> > > It's not very useful, I get that, but user space can just clear
> > > the congestion signal and keep going.
> >=20
> > How? The recvfrom man page doesn't even discuss ENOBUFS. Which is one o=
f
> > the strongest arguments for a kernel side patch. The fact that there is
> > exists a socket option to declare that you do not want ENOBUFS on
> > netlink sockets is esoteric knowledge. The netlink(7) man page does
> > cover the flag. But even where it discusses ENOBUFS, it does not mentio=
n
> > that this is preventable by setting a socket option. I do appreciate
> > this being pointed out. But getting from the recvfrom man page to a
> > solution is not obvious.
>=20
> socket errors are generally "consumed" when they are returned.
> The user space should see one ENOBUF=20

It does. The man page is unhelpful.

> and then once the rcvbuf is drained completely the CONGESTION bit should
> also get auto cleared. This is my mental model how Netlink works, LMK if
> you're seeing different behavior, my memory is faulty...

Well, yes that is normal for other netlink subsystems. And it looks like=20
we're not missing any magic cure. However, that congestion bit is what real=
ly=20
causes a major headache for the audit system because it has it's own retry=
=20
scaffolding. Auditd ack's each message so that the kernel side advances. In=
=20
any event, I patched auditd to set NETLINK_NO_ENOBUFS. It's not the solutio=
n=20
I hoped for, but if I understand what this does, it should solve our proble=
m=20
for auditd.

Thanks,
-Steve
=20
> > > > It seems like the audit subsystem should set the flag on auditd's
> > > > socket at registration time in auditd_set(). The kernel is the righ=
t
> > > > place for this because it's the kernel that manages the retry/ hold
> > > > queues and sets the sk_sndtimeo that triggers the overrun path -
> > > > auditd has no knowledge of these internals.
> > >=20
> > > We have to carry this code somewhere, either in user space or in
> > > the kernel. I'd prefer not to carry it in the kernel.
> >=20
> > I can put this in the audit daemon. But whoever else writes a similar a=
pp
> > will have to independently discover the same solution when faced with t=
he
> > pathologically bad behavior. A kernel side fix would have made it easie=
r
> > for future app developers to be successful.




