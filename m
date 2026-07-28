Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE463F9F39
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272498; cv=none; b=XakhUL2mj/jAsklCeJPDtg0x7yhHtKFA5etxDXlkTMgxpBJcmjyGSQIIkp32HDEKmB9w7TC9RlGLRypk19iXPT4O3m2J1Rc0K22jd3ujjLH/aDID01YQFlrD+uuGL2Y610sqAUNTj5+Tig/2W/RIQF7S5bD4Ok1TYNisr+sug3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272498; c=relaxed/simple;
	bh=rbEFRuENYr1UbxtV5moWkcQCrWpypYB9wqHiH8nS4Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIhKTJnmScKXAm2FMmp1FqPp03QcBaQGI6VNGAfOOCyGXeIYHi/UBCBLPIVKMAIbtDEXGq70FkTSkXLMij1eIB4VS2F5l75s4pexFHShyi4J0Af8Shk1rUyQnVvszi2L8oMBX9klfn+3r3i5hYlK1NSBy/ThRvrFo8O8/WZKu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Toz22b/H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Toz22b/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785272495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6ljGpY8syJ4kMz5EMeiC1JLhIm06ethqnnefWbD4tk=;
	b=Toz22b/HVWy1WG9FbYwuCQ4k+DztCURBoCQFOxIxAEd+IoAWI5paEWRKOYrbvglMzq58ao
	+p3N3i6qXg6KvRE6AbNBXwhvVjP4YmdeBsxJ3tsKO/5ZDejN12jjgiRFttriW7RMwRZSLX
	O2aPZlzbOjL47VuAQpdRC6B+bVdzjuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-9Nvn47XYOxiAzH--_WQp1g-1; Tue,
 28 Jul 2026 17:01:30 -0400
X-MC-Unique: 9Nvn47XYOxiAzH--_WQp1g-1
X-Mimecast-MFC-AGG-ID: 9Nvn47XYOxiAzH--_WQp1g_1785272488
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 235E0195608F;
	Tue, 28 Jul 2026 21:01:28 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.65.142])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28BAC414;
	Tue, 28 Jul 2026 21:01:24 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Cc: audit@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, eparis@redhat.com, kees@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, david@kernel.org, brauner@kernel.org
Subject: Re: [PATCH] audit: add CLONE3 auxiliary record to log process cloning
Date: Tue, 28 Jul 2026 17:01:21 -0400
Message-ID: <uK83gGq4RkGQKh1xACKbLw@redhat.com>
Organization: Red Hat
In-Reply-To: <amjZRgbKg7svHU7r@madcap2.tricolour.ca>
References: <20260724150258.560396-2-rrobaina@redhat.com>
 <amjZRgbKg7svHU7r@madcap2.tricolour.ca>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: ZlFbcOlCWPE9UWeUjQ_q4EUNkxqAJ9t9pHxFxBGowmg_1785272488
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, July 28, 2026 12:31:02=E2=80=AFPM Eastern Daylight Time Richard=
 Guy=20
Briggs wrote:
> On 2026-07-24 12:02, Ricardo Robaina wrote:
> > The clone3(2) syscall moves most parameters to struct clone_args.
> > For this reason, the generic SYSCALL audit record does not capture
> > the structured arguments.
> >=20
> > Add a CLONE3 auxiliary record that logs: flags, exit_signal, cgroup,
> > and pidfd fields from struct clone_args. When CLONE_PIDFD is set and
> > the syscall succeeds, the resolved pidfd is logged; otherwise
> > pidfd=3D(null).
> >=20
> >  ----
> >  type=3DSYSCALL : syscall=3Dclone3 a0=3D0x7ffe7f1ec640 a1=3D0x58 a2=3D0=
x0 ...
> >  type=3DCLONE3 : cl3_flags=3D0x1000 exit_signal=3D17 cgroup=3D0 pidfd=
=3D3
> >=20
> > Link: https://github.com/linux-audit/audit-kernel/issues/151
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >=20
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 20 ++++++++++++++++++++
> >  kernel/fork.c              |  4 +++-
> >  4 files changed, 34 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 45abb3722d30..833f349bf415 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64
> > offset);>=20
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int
> >  nentries,> =20
> >  =09=09=09      enum audit_nfcfgop op, gfp_t gfp);
> >=20
> > +extern void __audit_log_clone3(struct kernel_clone_args *kargs, int
> > ret);
> >=20
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> >=20
> > @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *nam=
e,
> > u8 af,>=20
> >  =09=09__audit_log_nfcfg(name, af, nentries, op, gfp);
> > =20
> >  }
> >=20
> > +static inline void audit_log_clone3(struct kernel_clone_args *kargs, i=
nt
> > ret) +{
> > +=09if (!audit_dummy_context())
> > +=09=09__audit_log_clone3(kargs, ret);
> > +}
> > +
> >=20
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> >=20
> > @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name=
,
> > u8 af,>=20
> >  =09=09=09=09   enum audit_nfcfgop op, gfp_t gfp)
> > =20
> >  { }
> >=20
> > +static inline void audit_log_clone3(struct kernel_clone_args *kargs, i=
nt
> > ret) +{ }
> > +
> >=20
> >  #define audit_n_rules 0
> >  #define audit_signals 0
> >  #endif /* CONFIG_AUDITSYSCALL */
> >=20
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index e8f5ce677df7..37357e17adbf 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -122,6 +122,7 @@
> >=20
> >  #define AUDIT_OPENAT2=09=091337=09/* Record showing openat2 how args=
=20
*/
> >  #define AUDIT_DM_CTRL=09=091338=09/* Device Mapper target control */
> >  #define AUDIT_DM_EVENT=09=091339=09/* Device Mapper events */
> >=20
> > +#define AUDIT_CLONE3=09=091343=09/* Record showing clone3 args */
> >=20
> >  #define AUDIT_AVC=09=091400=09/* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR=091401=09/* Internal SE Linux Errors */
> >=20
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..c0106bb71c19 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2882,6 +2882,26 @@ void __audit_log_nfcfg(const char *name, u8 af,
> > unsigned int nentries,>=20
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> >=20
> > +void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> > +{
> > +=09struct audit_buffer *ab;
> > +=09int pidfd;
> > +
> > +=09ab =3D audit_log_start(audit_context(), GFP_KERNEL,
> > +=09=09=09     AUDIT_CLONE3);
> > +=09if (!ab)
> > +=09=09return;
> > +
> > +=09audit_log_format(ab, "cl3_flags=3D0x%llx exit_signal=3D%d cgroup=3D=
%d",
> > +=09=09=09 kargs->flags, kargs->exit_signal, kargs->cgroup);
>=20
> Would there be any confusion if this were simply "flags=3D..." since it i=
s
> already a record type AUDIT_CLONE3?

flags is already used in mmap records and will require workarounds to have=
=20
the same field name here. Separating them by name is better.

> > +=09if ((kargs->flags & CLONE_PIDFD) && ret >=3D 0 &&
> > +=09    !get_user(pidfd, kargs->pidfd))
> > +=09=09audit_log_format(ab, " pidfd=3D%d", pidfd);
> > +=09else
> > +=09=09audit_log_format(ab, " pidfd=3D(null)");
>=20
> Is there any interest in:
> =09child_tid (was captured by generic audit syscall arg 4)
> =09parent_tid (was captured by generic audit syscall arg 3 or 4)
> =09tls (was captured by generic audit syscall arg 4)
> =09set_tid

Nope. Those are more resource related and not security focused. Even if you=
=20
wanted it, these are pointers to the answer and not the answer. The patch h=
as=20
everything needed from a security PoV.

Ack.

> Is there a situation where a valid pid is returned without CLONE_PIDFD se=
t?

No idea. The man page makes it sound like it is only valid when CLONE_PIDFD=
.=20
Besides, its a pointer to an int from what the man page said.

-Steve

> Otherwise, looks reasonable to me.
>=20
> > +=09audit_log_end(ab);
> > +}
> > +
> >=20
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> > =20
> >  =09kuid_t auid, uid;
> >=20
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index f0e2e131a9a5..0f52e8c0e900 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -3047,7 +3047,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user =
*,
> > uargs, size_t, size)>=20
> >  =09if (!clone3_args_valid(&kargs))
> >  =09
> >  =09=09return -EINVAL;
> >=20
> > -=09return kernel_clone(&kargs);
> > +=09err =3D kernel_clone(&kargs);
> > +=09audit_log_clone3(&kargs, err);
> > +=09return err;
> >=20
> >  }
> > =20
> >  void walk_process_tree(struct task_struct *top, proc_visitor visitor,
> >  void *data)
> - RGB
>=20
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> Upstream IRC: SunRaycer
> Voice: +1.613.860 2354 SMS: +1.613.518.6570




