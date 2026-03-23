Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C173BE15F
	for <audit@vger.kernel.org>; Mon, 23 Mar 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284529; cv=none; b=EJwa1wugEUlNHVGUMshqnyhRIJuN9GGHq8+PFcMjzJnyyw6TBbTwlNkxWOGWBM49Pemxaq1r3NqIlG9ktafPnhXa1lQT8nMvRofnutK7ay8bPNgqqQTE1h7OU8PbHqCxqNq0Se+7nVBI9fRD+z/juWBl1w7t7rYdn6XLchfTHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284529; c=relaxed/simple;
	bh=TaxtX42XSQGVOJXZf24+14n3mpw9Dr424kyoesEk8h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU5zabs7suQjgUWXO2n7PC73q2tUY0YOxkmh43kEQthCnEs3rHrm/ne6jWfZeKgBloTkSdaH0namEREmFly/ksPC/Amp4a8RBUrv1h5Y03ua23RQY+lthsQSOEhXc3cJgqywwXTMF1JkiQhJeZ8Tx0ecqf8CKLdw2HtKwE3anEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCKcv7PV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCKcv7PV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774284526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPcgVMoOeBVwv1SRbTIKJf4/FBPRGnrgXnOjCMqPyQg=;
	b=MCKcv7PVqcZu6qiHaDMAK7dh+x49MhwbY6DKuDqyUv5++ozBH1DD+sAi1qGjA3W6Ghvee8
	oGvGafczuvxKYELvKGFECOWl3ormzxibUj1YnYIfxfIOHoERYJzVvYWfPybDFylwyiouUB
	KLyGWUyrLVwgcl7C53xvmfpaCpKhRTQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-zqFRXhbbMRmlHTkYmxD_-A-1; Mon,
 23 Mar 2026 12:48:45 -0400
X-MC-Unique: zqFRXhbbMRmlHTkYmxD_-A-1
X-Mimecast-MFC-AGG-ID: zqFRXhbbMRmlHTkYmxD_-A_1774284524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A89A195609F;
	Mon, 23 Mar 2026 16:48:44 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.64.60])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35D1319560B7;
	Mon, 23 Mar 2026 16:48:43 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ricardo Robaina <rrobaina@redhat.com>
Cc: paul@paul-moore.com, eparis@redhat.com,
 Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
Date: Mon, 23 Mar 2026 12:48:40 -0400
Message-ID: <22574086.4csPzL39Zc@x2>
Organization: Red Hat
In-Reply-To: <20260323150700.614139-1-rrobaina@redhat.com>
References: <20260323150700.614139-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: yC9QxpZ27gxsraDr4jQVeJKyi4t1JeRjPSxIzX5Yahc_1774284524
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, March 23, 2026 11:07:00=E2=80=AFAM Eastern Daylight Time Ricardo=
 Robaina=20
wrote:
> Currently, determining the optimal `audit_backlog_limit` relies on
> instantaneous polling of the queue size. This misses transient
> micro-bursts, making it difficult for system administrators to know
> if their queue is adequately sized or if they are at risk of
> dropping events.
>=20
> This patch introduces `backlog_max_depth`, a high-water mark metric
> that tracks the maximum number of buffers in the audit queue since
> the system was booted or the metric was last reset. To minimize
> performance overhead in the fast-path, the metric is updated using
> a lockless cmpxchg loop in `__audit_log_end()`.
>=20
> Userspace can read-and-clear this metric by sending an `AUDIT_SET`
> message with the `AUDIT_STATUS_BACKLOG_MAX_DEPTH` mask. To support
> periodic telemetry polling (e.g., statsd, Prometheus), the reset
> operation atomically returns the snapshot of the high-water mark
> right before zeroing it, ensuring no peaks are lost between polls.

From a user space point of view, this looks good. User space support was co=
-
developed alongside of this patch to ensure it works as advertised.

Acked-by: Steve Grubb <sgrubb@redhat.com>

-Steve

> Link: https://github.com/linux-audit/audit-kernel/issues/63
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h      |  3 ++-
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index d79218bf075a..53132b303c20 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -22,7 +22,8 @@
>  =09=09=09  AUDIT_STATUS_BACKLOG_LIMIT | \
>  =09=09=09  AUDIT_STATUS_BACKLOG_WAIT_TIME | \
>  =09=09=09  AUDIT_STATUS_LOST | \
> -=09=09=09  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)
> +=09=09=09  AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL | \
> +=09=09=09  AUDIT_STATUS_BACKLOG_MAX_DEPTH)
>=20
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
>  #define AUDIT_DEV_UNSET ((dev_t)-1)
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e8f5ce677df7..862ca93c0c31 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -355,6 +355,7 @@ enum {
>  #define AUDIT_STATUS_BACKLOG_WAIT_TIME=09=090x0020
>  #define AUDIT_STATUS_LOST=09=09=090x0040
>  #define AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL=090x0080
> +#define AUDIT_STATUS_BACKLOG_MAX_DEPTH=09=090x0100
>=20
>  #define AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT=090x00000001
>  #define AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME=090x00000002
> @@ -486,6 +487,7 @@ struct audit_status {
>  =09__u32           backlog_wait_time_actual;/* time spent waiting while
>  =09=09=09=09=09=09  * message limit exceeded
>  =09=09=09=09=09=09  */
> +=09__u32=09=09backlog_max_depth; /* message queue max depth */
>  };
>=20
>  struct audit_features {
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e1d489bc2dff..256053cb6132 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -163,6 +163,9 @@ static struct sk_buff_head audit_retry_queue;
>  /* queue msgs waiting for new auditd connection */
>  static struct sk_buff_head audit_hold_queue;
>=20
> +/* audit queue high water mark since last startup or reset */
> +static atomic_t audit_backlog_max_depth __read_mostly =3D ATOMIC_INIT(0)=
;
> +
>  /* queue servicing thread */
>  static struct task_struct *kauditd_task;
>  static DECLARE_WAIT_QUEUE_HEAD(kauditd_wait);
> @@ -1286,6 +1289,7 @@ static int audit_receive_msg(struct sk_buff *skb,
> struct nlmsghdr *nlh, s.backlog=09=09   =3D skb_queue_len(&audit_queue);
>  =09=09s.feature_bitmap=09   =3D AUDIT_FEATURE_BITMAP_ALL;
>  =09=09s.backlog_wait_time=09   =3D audit_backlog_wait_time;
> +=09=09s.backlog_max_depth=09   =3D atomic_read(&audit_backlog_max_depth)=
;
>  =09=09s.backlog_wait_time_actual =3D
> atomic_read(&audit_backlog_wait_time_actual); audit_send_reply(skb, seq,
> AUDIT_GET, 0, 0, &s, sizeof(s));
>  =09=09break;
> @@ -1399,6 +1403,12 @@ static int audit_receive_msg(struct sk_buff *skb,
> struct nlmsghdr *nlh, audit_log_config_change("backlog_wait_time_actual",
> 0, actual, 1); return actual;
>  =09=09}
> +=09=09if (s.mask =3D=3D AUDIT_STATUS_BACKLOG_MAX_DEPTH) {
> +=09=09=09u32 old_depth =3D atomic_xchg(&audit_backlog_max_depth, 0);
> +
> +=09=09=09audit_log_config_change("backlog_max_depth", 0, old_depth,=20
1);
> +=09=09=09return old_depth;
> +=09=09}
>  =09=09break;
>  =09}
>  =09case AUDIT_GET_FEATURE:
> @@ -2761,6 +2771,25 @@ int audit_signal_info(int sig, struct task_struct
> *t) return audit_signal_info_syscall(t);
>  }
>=20
> +/*
> + * audit_update_backlog_max_depth - update the audit queue high water ma=
rk
> + *
> + * Safely updates the audit_backlog_max_depth metric using a lockless
> + * cmpxchg loop. This ensures the high-water mark is accurately tracked
> + * even when multiple CPUs are logging audit records concurrently.
> + */
> +static inline void audit_update_backlog_max_depth(void)
> +{
> +=09u32 q_len =3D skb_queue_len(&audit_queue);
> +=09u32 q_max =3D atomic_read(&audit_backlog_max_depth);
> +
> +=09while (unlikely(q_len > q_max)) {
> +=09=09if (likely(atomic_try_cmpxchg(&audit_backlog_max_depth,
> +=09=09=09=09=09      &q_max, q_len)))
> +=09=09=09break;
> +=09}
> +}
> +
>  /**
>   * __audit_log_end - enqueue one audit record
>   * @skb: the buffer to send
> @@ -2777,6 +2806,9 @@ static void __audit_log_end(struct sk_buff *skb)
>=20
>  =09=09/* queue the netlink packet */
>  =09=09skb_queue_tail(&audit_queue, skb);
> +
> +=09=09/* update backlog high water mark */
> +=09=09audit_update_backlog_max_depth();
>  =09} else {
>  =09=09audit_log_lost("rate limit exceeded");
>  =09=09kfree_skb(skb);




