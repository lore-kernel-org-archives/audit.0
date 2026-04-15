Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A12D9EC4
	for <audit@vger.kernel.org>; Wed, 15 Apr 2026 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224760; cv=none; b=fu9WSIIlePbg9AnUy2KPuRXmvm8dXKuUid4ajSKBidikH+LBt20/O2O/NoZkBLiSRbwwxwTC6wqPCuD0II24m7VHH5dbfxYB8+TtVBgZJAE8B+niRQ4XuCA137fGQoVmsFId7mbC/xNW80/xfpxzZ10CguUCjpKz2M5jYB27yzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224760; c=relaxed/simple;
	bh=ypdPPfKJi2CA7sFfmnqKHyO72uDg0C//PSEaEYbwuf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVS0lXzvH+FXobXcSTo6FJuT1gt9Y/9aWnYLEFl7tAjQYRSlbmwpJIpJhAFidjnbBOhSsF2HHP5ANj3/iK+8zlQXeJtYTw0/DoQwPUiGLTCi+zo70PW8Ntaz/5hfQWI8h8GVrTU3uKzZKV7PvE1pH6DXsvWvosWDQwy8tPAgV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7S5ngKM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7S5ngKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776224750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ8NcmRVKd+JdtCD83D4dXVY9GR+B4fWDIBLO3uY94w=;
	b=b7S5ngKMuyXPlb6heqwVymF4gYH109q9vQaQwTDSi4zkxMCSIX0X9M6t3ysXE8LLJqIWbG
	ooGhvc2iccjq//NIIfl7+3iPJYem6SlmHjk70v6vpnh01ZDbteiMMhOutbvREaeCFlWEgr
	QeB/yFFJ1hWjeXNe94A4dU7Ez5LkSj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-v43AjH_lPsOHAovF3l18qA-1; Tue,
 14 Apr 2026 23:45:47 -0400
X-MC-Unique: v43AjH_lPsOHAovF3l18qA-1
X-Mimecast-MFC-AGG-ID: v43AjH_lPsOHAovF3l18qA_1776224746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 090C4195609E;
	Wed, 15 Apr 2026 03:45:46 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.80.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DD6419560B1;
	Wed, 15 Apr 2026 03:45:44 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Subject: Re: [PATCH] audit: add backlog high water mark metric
Date: Tue, 14 Apr 2026 23:45:00 -0400
Message-ID: <2213475.9o76ZdvQCi@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhQTGfuOYev_UNzwSqUoYX-y+RYyMZgWWG2eGzM62eVm9A@mail.gmail.com>
References: <20260323150700.614139-1-rrobaina@redhat.com>
 <CAHC9VhQTGfuOYev_UNzwSqUoYX-y+RYyMZgWWG2eGzM62eVm9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 80KdQLrxJa2XG-WKR7QMXTYAcQgInQJo6PL2PNGA38U_1776224746
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hello Paul,

On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Time Paul Moo=
re wrote:
> On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina <rrobaina@redhat=
.com>=20
wrote:
> > Currently, determining the optimal `audit_backlog_limit` relies on
> > instantaneous polling of the queue size. This misses transient
> > micro-bursts, making it difficult for system administrators to know
> > if their queue is adequately sized or if they are at risk of
> > dropping events.
> >=20
> > This patch introduces `backlog_max_depth`, a high-water mark metric
> > that tracks the maximum number of buffers in the audit queue since
> > the system was booted or the metric was last reset. To minimize
> > performance overhead in the fast-path, the metric is updated using
> > a lockless cmpxchg loop in `__audit_log_end()`.
> >=20
> > Userspace can read-and-clear this metric by sending an `AUDIT_SET`
> > message with the `AUDIT_STATUS_BACKLOG_MAX_DEPTH` mask. To support
> > periodic telemetry polling (e.g., statsd, Prometheus), the reset
> > operation atomically returns the snapshot of the high-water mark
> > right before zeroing it, ensuring no peaks are lost between polls.
> >=20
> > Link: https://github.com/linux-audit/audit-kernel/issues/63
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >=20
> >  include/linux/audit.h      |  3 ++-
> >  include/uapi/linux/audit.h |  2 ++
> >  kernel/audit.c             | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 36 insertions(+), 1 deletion(-)
>=20
> I sat on this for a bit because I wanted to think on it for a while.
> While I agree audit could benefit from better statistics around
> queue/backlog status, I'm not sure a single "max" value alone is worth
> a bit in the audit_status bitmask.  My concern is that the max queue
> length only provides a single snapshot of what the queue looked like,
> it doesn't give any indication of the average queue length over a span
> of time.  Some audit users are willing to live with occasional drops,
> and the max size doesn't help them arrive at a good balance.
>=20
> As for the users who can't tolerate any audit record drops?  They
> shouldn't be running with a backlog limit anyway so the maximum queue
> value will be of limit use.

The existing audit_lost counter tells administrators they have already=20
failed; the proposed backlog_max_depth tells them they are at risk of=20
failing. These are different signals serving different operational needs. T=
he=20
dominant real-world deployment =E2=80=94 compliance-driven systems that mus=
t use a=20
finite backlog limit for memory safety but cannot tolerate dropped events =
=E2=80=94=20
has no existing mechanism to verify their limit is correctly sized between=
=20
polling intervals. Instantaneous backlog polling is blind to sub-second=20
bursts. Only a high-water mark, atomically reset at each poll, closes this=
=20
gap. The average queue length would not answer the question 'did I ever com=
e=20
close to the limit?' =E2=80=94 only the maximum can.

On the bitmask concern: the last addition was=20
AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL, six years ago.

If you don't think this closes the gap on what people need, the patch could=
=20
be amended to include  backlog_lost_since_reset (drops since last poll)=20
alongside the max so that you get two metrics for the price of one bit. But=
=20
this is absolutely needed because people are flying blind without it.

-Steve


