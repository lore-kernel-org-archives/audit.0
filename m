Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7D397942
	for <audit@vger.kernel.org>; Fri, 21 Aug 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315553; cv=none; b=lKvDLe2lMKb4dVI/CR23svzuWEWq9sFZY6wC3JAct+EbIwNrr51Sx9mQVtl71hlV/Ji9RF8cX+ZwemapW10AUdRCEmktayWdxe2tK4yWEcadnLSHwL3JRMk9CFE6a2UhA4oZL0/j9cj7N/gwbwzHkEJwUopZXVyOcgQx6hdllR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315553; c=relaxed/simple;
	bh=buB9Ig8UGQ4yTr9/kwBEK00cFnmq3yF9NNlLBnrmGUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTvbv5dCIl3Vhn6h2xG1sF4lLgGEeXB/HSOeeghkYNBZgXV5ggtkV8cDtdZBqMGLU690a1H5YzA3uV5QL8nbrMCBEvyJ7ANlbA7SCptx4GZt6sYmS533jkUTWgTeRWzHVOD8t8RdFqt2W+bJQuEPIG9mgQO05n4J+MfovhQzjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJNkl2es; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJNkl2es"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787315550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nQiAnmFR1CPZ/lHsTXoGg00TJNHaMaAN/SMaiIN0sQ=;
	b=jJNkl2esA7Wk0L3ATU5A1+vsR2Y5RFBSiiiWKe/CcV4AX3JhCvEHDu7loqZvX68gZtMskR
	KtMvXfp6qNZCrz/3/8k62UPJiSuFqgTnMjZLVdYkREXy3qYoV3KEc0fuhaDioaihCwQXON
	Dl3qgRiKkdy2Acp44Ajcnw/VgP/4P/M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-9Wuc7IYQNMaEklem13DqBA-1; Fri, 21 Aug 2026 08:32:29 -0400
X-MC-Unique: 9Wuc7IYQNMaEklem13DqBA-1
X-Mimecast-MFC-AGG-ID: 9Wuc7IYQNMaEklem13DqBA_1787315548
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39f1aa2b439so5356771fa.1
        for <audit@vger.kernel.org>; Fri, 21 Aug 2026 05:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315547; x=1787920347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nQiAnmFR1CPZ/lHsTXoGg00TJNHaMaAN/SMaiIN0sQ=;
        b=buW78Y4L6uaMDstaKrWp/lEv43wZZkzZwEdR50+a/XiApmsZ5NN7U+r19uJ10KEQ8C
         /zW27eDLCca7RsvivpMzbUFztOmjOdFdOx93yHnp9uq0Y2gPo47SNnKOYFVeGWonqx7b
         57yas357S0MAPjcfJ/tzcD/C1628nFzD39Q2+ZnK5G6/+nJJKVpuHH1bhoD/aBsrcft4
         sU0Z89M58ERGiRZdUQtake3nb1cbYvmORYKf0AAkJhR2HpB1HgCJ4PB8hWCTgLAuERHx
         6hlbHb8mARPwOuACGJh3gM1tTinj1543NBOnVy3/yK/pR4lbQ8vejDWp4aBY67taWyEt
         LYwA==
X-Gm-Message-State: AFuF++lMdXEDK8/Fg237fpamd62lcNDfaSBswgYXcsFLO/gQHvvgHbde
	ltZPgy3T3L7V7ASxn1it1CotondL/Y10rI0/nEHLAaoyskP11C1ylNehrz318NFCC6hlfLKh5Lx
	/Bi/qiQ2e1mmonMS/jna1y0305GthBfJ9Oct4TztHsfkHu0SuX2kIpyzhW2Gwl57yt9PVHBXuU9
	VUHSpbNTnU8y4y08Pd4gO7pv+AClLBdGr+IQQF1fCIPf/u
X-Gm-Gg: AR+sD115he2WDEvHL2FpApMfEjD7eLlVcIBDHg0AeHe0Q6uhlqWDmMcJOYbnu/m6sdZ
	Ct+d3TjHIBOiUi4RtUHtbtdvDDiAZ/n3+nZYz2h8rRCkuRPx9E+i50pLK0NuQ+dRL/+FYa5AB4w
	fuuvyPqMcojaZcWaxGykN53gdk/jcJkly6T1lJ1Fkk0w7OJJKdZlf8OHf48OqLBphjgxrkJz0wE
	0UmX9A4Cn23Ehe83A7AvP2nplZGRhx4+EdvEgym0517pGmoJR0BlwblJC3bHCVupwaM8rtuubYP
X-Received: by 2002:a2e:bc28:0:b0:3a1:11d3:173e with SMTP id 38308e7fff4ca-3a1aee83d62mr14946801fa.14.1787315547552;
        Fri, 21 Aug 2026 05:32:27 -0700 (PDT)
X-Received: by 2002:a17:907:3d56:b0:c1f:e9d6:2a6f with SMTP id
 a640c23a62f3a-c2469f9991dmr630333466b.0.1787315197822; Fri, 21 Aug 2026
 05:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724150258.560396-2-rrobaina@redhat.com> <CAHC9VhSzhyw--ycYMG_RaT5wpRQWDPBSuaNixsVrWrRXKc9hzw@mail.gmail.com>
In-Reply-To: <CAHC9VhSzhyw--ycYMG_RaT5wpRQWDPBSuaNixsVrWrRXKc9hzw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 21 Aug 2026 09:26:26 -0300
X-Gm-Features: AcwNN1WD71ac4WEQSUnfKMe1gRwRLyFnSk3rCPAS384W6Bqs5OsdV3sfC6_UdO4
Message-ID: <CAABTaaA=FupPfFhOdMPi7nPy5wSh7znEdnBquYbTXCN=YbtKiA@mail.gmail.com>
Subject: Re: [PATCH] audit: add CLONE3 auxiliary record to log process cloning
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, sgrubb@redhat.com, kees@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, david@kernel.org, brauner@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rc4MA5q68JN91hPPNuN8Uquw7NdUReMntjgxhC5jPeA_1787315548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 24, 2026 at 11:03=E2=80=AFAM Ricardo Robaina <rrobaina@redhat=
.com> wrote:
> >
> > The clone3(2) syscall moves most parameters to struct clone_args.
> > For this reason, the generic SYSCALL audit record does not capture
> > the structured arguments.
> >
> > Add a CLONE3 auxiliary record that logs: flags, exit_signal, cgroup,
> > and pidfd fields from struct clone_args. When CLONE_PIDFD is set and
> > the syscall succeeds, the resolved pidfd is logged; otherwise
> > pidfd=3D(null).
> >
> >  ----
> >  type=3DSYSCALL : syscall=3Dclone3 a0=3D0x7ffe7f1ec640 a1=3D0x58 a2=3D0=
x0 ...
> >  type=3DCLONE3 : cl3_flags=3D0x1000 exit_signal=3D17 cgroup=3D0 pidfd=
=3D3
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/151
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 20 ++++++++++++++++++++
> >  kernel/fork.c              |  4 +++-
> >  4 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 45abb3722d30..833f349bf415 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 =
offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int ne=
ntries,
> >                               enum audit_nfcfgop op, gfp_t gfp);
> > +extern void __audit_log_clone3(struct kernel_clone_args *kargs, int re=
t);
> >
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
> >                 __audit_log_nfcfg(name, af, nentries, op, gfp);
> >  }
> >
> > +static inline void audit_log_clone3(struct kernel_clone_args *kargs, i=
nt ret)
> > +{
> > +       if (!audit_dummy_context())
> > +               __audit_log_clone3(kargs, ret);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name=
, u8 af,
> >                                    enum audit_nfcfgop op, gfp_t gfp)
> >  { }
> >
> > +static inline void audit_log_clone3(struct kernel_clone_args *kargs, i=
nt ret)
> > +{ }
> > +
> >  #define audit_n_rules 0
> >  #define audit_signals 0
> >  #endif /* CONFIG_AUDITSYSCALL */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index e8f5ce677df7..37357e17adbf 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -122,6 +122,7 @@
> >  #define AUDIT_OPENAT2          1337    /* Record showing openat2 how a=
rgs */
> >  #define AUDIT_DM_CTRL          1338    /* Device Mapper target control=
 */
> >  #define AUDIT_DM_EVENT         1339    /* Device Mapper events */
> > +#define AUDIT_CLONE3           1343    /* Record showing clone3 args *=
/
> >
> >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant=
 */
> >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..c0106bb71c19 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2882,6 +2882,26 @@ void __audit_log_nfcfg(const char *name, u8 af, =
unsigned int nentries,
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> >
> > +void __audit_log_clone3(struct kernel_clone_args *kargs, int ret)
> > +{
> > +       struct audit_buffer *ab;
> > +       int pidfd;
> > +
> > +       ab =3D audit_log_start(audit_context(), GFP_KERNEL,
> > +                            AUDIT_CLONE3);
> > +       if (!ab)
> > +               return;
> > +
> > +       audit_log_format(ab, "cl3_flags=3D0x%llx exit_signal=3D%d cgrou=
p=3D%d",
> > +                        kargs->flags, kargs->exit_signal, kargs->cgrou=
p);
> > +       if ((kargs->flags & CLONE_PIDFD) && ret >=3D 0 &&
> > +           !get_user(pidfd, kargs->pidfd))
> > +               audit_log_format(ab, " pidfd=3D%d", pidfd);
>
> Do we care about distinguishing between the combination of CLONE_PIDFD
> and CLONE_THREAD vs CLONE_PIDFD alone?  In other words, do we care if
> the "pidfd" field sometimes represents a pidfd of the child process vs
> a thread in the current process?
>

Hi Paul,

Thanks for reviewing this patch.

The flags field can be use to check if CLONE_THREAD is set, so it's
possible to determine whether the pidfd refers to a child process or a
thread by inspecting the flags. Do you think we should include a
dedicated field for that?

> > +       else
> > +               audit_log_format(ab, " pidfd=3D(null)");
> > +       audit_log_end(ab);
> > +}
> > +
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> >         kuid_t auid, uid;
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index f0e2e131a9a5..0f52e8c0e900 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -3047,7 +3047,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user =
*, uargs, size_t, size)
> >         if (!clone3_args_valid(&kargs))
> >                 return -EINVAL;
> >
> > -       return kernel_clone(&kargs);
> > +       err =3D kernel_clone(&kargs);
> > +       audit_log_clone3(&kargs, err);
> > +       return err;
> >  }
> >
> >  void walk_process_tree(struct task_struct *top, proc_visitor visitor, =
void *data)
> > --
> > 2.53.0
>
> --
> paul-moore.com
>

-Ricardo

