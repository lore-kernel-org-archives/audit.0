Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C1441621
	for <audit@vger.kernel.org>; Wed, 22 Jul 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725566; cv=none; b=rPlA9gybc4nTRVHrTMJfgL6MjY4ibEbNOhcz/rWfEtASvGOSP2efCGPzT3Mh7q8K2zII8rAy2sUdKZcoiEGqxV7um4XeChYBxfqW3FpHeJfzD6vFAu+OGW+5nzkXBYs5BwaOtYOZeZuHcVA0HrZIp48T1p1GA/UKPQ6f1uY8/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725566; c=relaxed/simple;
	bh=jtONZb8KF9+tmw+wCMSn1h1T1/7RtcaUMdmWmHxTQQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYT/tXFCOhSLgUJiK3oMgSjm+YW+iFF8YHZ2dJO2mDIA4bD14Cq4H3g62KMUWpnRaBuEt4eySHDKDcrJP/N47wJygRB3Qx6QqcxkdrixImnPYYtv4dVZ4XZY5dj45tE4NFLiS8A0aPefUaBz1Wco8jWQ8Xy2Ts4cgLFc2x9C5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLC/Y10w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLC/Y10w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784725563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
	b=NLC/Y10wBI0pICr1FinLiz2/Z0ltQRpWAIyAyR2HLSbLovH/WWBpnLfsdthgi/w3oQcSV+
	YB51wbSL+80IU6pajfU6K38ZX7aGRD8kLgkcoaFG+l43VqQHhCqwlRCfFHAnP/MtHToVFw
	jb3QFaSCihEHCJ05A5ITgRItKBl4mNw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-1IeJBpRuNwC4Sm6pG3W01A-1; Wed, 22 Jul 2026 09:06:00 -0400
X-MC-Unique: 1IeJBpRuNwC4Sm6pG3W01A-1
X-Mimecast-MFC-AGG-ID: 1IeJBpRuNwC4Sm6pG3W01A_1784725559
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c232fa136so269152666b.0
        for <audit@vger.kernel.org>; Wed, 22 Jul 2026 06:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784725559; x=1785330359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
        b=ghp6FvEM9lNOGrkEaeSbUHXviEDzAyjbLunnb8SRzgYTxUe2PisBUGAg2Cu5Q/TAT7
         bhzB5VjmpVIR4xIfBtG5GJBarZT170+Wo1U91wvEDenL2Cwv3/8h+WXuDsbEtLOtriU3
         csakl9mgzG/hsDV22BdJg0MaPStku9igKu5XjXx7lnV4ASkd1bwcOtApthyrhKCj3dl5
         uL9Y41oQBh6prXTYTdsnwIjL/XTOmNV50Xs7uYf8QkYBl0EehCtNzEMgxw7qeWvwgM3N
         Yc2RxYSodyMJniIxwmD8RUXhdZWIfxh8JawPXbqHXWGuklutSpR8w3OcVIQJW0fnZH/0
         sr1Q==
X-Gm-Message-State: AOJu0YxL++9Rs4NzYn5WY9i4gQBQ0Mtey0YcgNRnBVzoehGCiyDSL1js
	JqsNgqKm+uR21LzJ/C1vbkQh7hDAQlB+ce5MI4oKgJ+0ia9WBLcsL139PT4niv7Hc0VsJJgbtFD
	U3UJg4CLkCCD/E4XYiONmELai2Zf6L5bTflXBwuPEV2SnE1vRGhKcCqLCrmrDjfM/7l2OjfBerR
	qplsoyLeEqd1ySsdUpbuLcnZKE+hlJcsw=
X-Gm-Gg: AR+sD11lkZjHgv9epv9lZg4zwscUAD/H3hgnMhWuiELgd37RORZF4/duaQw24lNdFGW
	wpZLiRYxz+eZTBoXHTb0qxPxxc6IC1ogTiq9IyVZtbDX3szz/hPonQA/weg1ik3rH05eLy8nS65
	hMj4sSzc0bOh+qkeYdOtT0FpRvuBAsaFNHzF2ZsnyLBYlzNGqF8OE589zAt+DN8af8ybZaZCOXW
	kqpCzN0Qbu4uOftHFxrQ74k3qLlvyEAH2JD2awkpkYWsLNn/AqglaMsuIRD60Q8lqMK4DWp/5Pa
	CYo=
X-Received: by 2002:a17:907:3e23:b0:c15:ee17:47a with SMTP id a640c23a62f3a-c1c31016077mr156070966b.15.1784725558789;
        Wed, 22 Jul 2026 06:05:58 -0700 (PDT)
X-Received: by 2002:a17:907:3e23:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c1c31016077mr156068966b.15.1784725558240; Wed, 22 Jul 2026
 06:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170013.4073499-1-rrobaina@redhat.com> <al/wQsmHmVMSo+RH@madcap2.tricolour.ca>
In-Reply-To: <al/wQsmHmVMSo+RH@madcap2.tricolour.ca>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 22 Jul 2026 10:05:46 -0300
X-Gm-Features: AUfX_mzQlQH1q_C4gRpCynDHph_irPi10-leduWD5odsmTngWowUNj4SLQAPEGU
Message-ID: <CAABTaaBP3g-np2MhYHebiQpGHFpTe6Z_itqvt2qu9hsymkbHCw@mail.gmail.com>
Subject: Re: [PATCH] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Richard Guy Briggs <rgb@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lnqRkjJlJC7xXI1GwLfp_v2VGHRsZDISrdy3Q9d5rCA_1784725559
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:18=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
>
> On 2026-07-13 14:00, Ricardo Robaina wrote:
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> > does not capture the configuration parameters, creating an audit gap fo=
r
> > critical mount information such as the device being mounted.
> >
> > Add an FSCONFIG auxiliary record that logs the command type, parameter
> > name (key), parameter value, and aux parameter passed to fsconfig(2).
> >
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a1=3DFSCONFIG_SET_STRING ...
>
> This looks like it is missing "a0=3D..."?
>
> >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_aux=
=3D0
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a1=3DFSCONFIG_CMD_CREATE ...
>
> This looks like it is missing "a0=3D..."?
> I'm guessing this isn't actually real test output?
>

Thanks for reviewing this patch, Richard!

That's real test output; I just trimmed the SYSCALL record output to
fit in the commit message. Since this patch does not touch this
record, I don't see a problem. I can
add a0=3D... for consistency if you prefer, though.

> >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_aux=3D=
0
>
> Was there a fs_key output here that didn't make it due to the issue below=
?

Actually, in this case, the test result happened to be right (that's
why I missed it).
FSCONFIG_CMD_CREATE has no key or value, so both are NULL[1].

[1] https://man7.org/linux/man-pages/man2/fsconfig.2.html

>
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a0=3D0x4 a1=3DFSCONFIG_SET_BINARY =
...
> >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" fs_a=
ux=3D4
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  fs/fsopen.c                |  7 +++++++
> >  include/linux/audit.h      | 13 +++++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> >  4 files changed, 48 insertions(+)
> >
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index ae19e5136598..9b3c02f59df4 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> >  #include <uapi/linux/mount.h>
> > +#include <linux/audit.h>
> >  #include "internal.h"
> >  #include "mount.h"
> >
> > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> >       struct fs_context *fc;
> >       int ret;
> >       int lookup_flags =3D 0;
> > +     const char *value_str =3D NULL;
> >
> >       struct fs_parameter param =3D {
> >               .type   =3D fs_value_is_undefined,
> > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> >                       goto out_key;
> >               }
> >               param.size =3D strlen(param.string);
> > +             value_str =3D param.string;
> >               break;
> >       case FSCONFIG_SET_BINARY:
> >               param.type =3D fs_value_is_blob;
> > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> >                       ret =3D PTR_ERR(param.blob);
> >                       goto out_key;
> >               }
> > +             value_str =3D "<binary>";
> >               break;
> >       case FSCONFIG_SET_PATH_EMPTY:
> >               lookup_flags =3D LOOKUP_EMPTY;
> > @@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
> >               }
> >               param.dirfd =3D aux;
> >               param.size =3D strlen(param.name->name);
> > +             value_str =3D param.name->name;
> >               break;
> >       case FSCONFIG_SET_FD:
> >               param.type =3D fs_value_is_file;
> > @@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
> >               break;
> >       }
> >
> > +     audit_log_fsconfig(cmd, param.key, value_str, aux);
> > +
> >       ret =3D mutex_lock_interruptible(&fc->uapi_mutex);
> >       if (ret =3D=3D 0) {
> >               ret =3D vfs_fsconfig_locked(fc, cmd, &param);
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 45abb3722d30..978eb881974c 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -449,6 +449,8 @@ extern void __audit_tk_injoffset(struct timespec64 =
offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int ne=
ntries,
> >                             enum audit_nfcfgop op, gfp_t gfp);
> > +extern void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > +                              const char *value, int aux);
> >
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -598,6 +600,13 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
> >               __audit_log_nfcfg(name, af, nentries, op, gfp);
> >  }
> >
> > +static inline void audit_log_fsconfig(unsigned int cmd, const char *ke=
y,
> > +                                   const char *value, int aux)
> > +{
> > +     if (!audit_dummy_context())
> > +             __audit_log_fsconfig(cmd, key, value, aux);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -730,6 +739,10 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
> >                                  enum audit_nfcfgop op, gfp_t gfp)
> >  { }
> >
> > +static inline void audit_log_fsconfig(unsigned int cmd, const char *ke=
y,
> > +                                   const char *value, int aux)
> > +{ }
> > +
> >  #define audit_n_rules 0
> >  #define audit_signals 0
> >  #endif /* CONFIG_AUDITSYSCALL */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index e8f5ce677df7..5cd0eb602528 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -122,6 +122,7 @@
> >  #define AUDIT_OPENAT2                1337    /* Record showing openat2=
 how args */
> >  #define AUDIT_DM_CTRL                1338    /* Device Mapper target c=
ontrol */
> >  #define AUDIT_DM_EVENT               1339    /* Device Mapper events *=
/
> > +#define AUDIT_FSCONFIG               1341    /* Record showing fsconfi=
g args */
> >
> >  #define AUDIT_AVC            1400    /* SE Linux avc denial or grant *=
/
> >  #define AUDIT_SELINUX_ERR    1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..222bf79ee9bd 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af, =
unsigned int nentries,
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> >
> > +void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > +                       const char *value, int aux)
> > +{
> > +     struct audit_buffer *ab;
> > +
> > +     ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFI=
G);
> > +     if (!ab)
> > +             return;
> > +
> > +     audit_log_format(ab, "fs_cmd=3D%u", cmd);
> > +     audit_log_format(ab, " fs_key=3D");
> > +     if (value)
>
> This looks like it should be "if (key)".

Good catch!

>
> > +             audit_log_untrustedstring(ab, key);
> > +     else
> > +             audit_log_format(ab, "(null)");
> > +
> > +     audit_log_format(ab, " fs_val=3D");
> > +     if (value)
> > +             audit_log_untrustedstring(ab, value);
> > +     else
> > +             audit_log_format(ab, "(null)");
> > +
> > +     audit_log_format(ab, " fs_aux=3D%d", aux);
> > +
> > +     audit_log_end(ab);
> > +}
> > +
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> >       kuid_t auid, uid;
> > --
> > 2.53.0
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> Upstream IRC: SunRaycer
> Voice: +1.613.860 2354 SMS: +1.613.518.6570
>

-Ricardo

