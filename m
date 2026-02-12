Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D842A96
	for <audit@vger.kernel.org>; Thu, 12 Feb 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914192; cv=none; b=PQ5CyBEItg58F2a7wO3dm9nsKqjrv/Hetx6iBIYfuZDHj1DQgGuQCCudxg529eqA+AQJxvP9uOySaLsnsDeYRcu54pL6d9M31uTYiXrnYn+oOQPjE1Gbq8TKoFl3STDue4rKHiXsD3Tu7kLz9uAcvnQv09h+avY4BXSJ/KLTj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914192; c=relaxed/simple;
	bh=X1XJ350cN/5cE2JiXevEKGlOliFSOSNSOkBkFmtLdOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmWVce1XT+0ndVCOQHmaoBsYtsECmyHisPAIL6DkRm2MYQNAmDS4lh1XbZMfoAVzoDSQf62p4gK6dTt9GoJy9tdHSKn64lFksVtCLkfavpmI3wtChbNSTtVU8hfHDcPeHTg+biPBCQ7SwR4okuq92wVx/kZ+KT9yFx3J0IGCVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSLZdFM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSLZdFM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0EDnMrGgmChFGfiji1cVpbPCJuj1GnVvGLW+wYkcA4=;
	b=aSLZdFM+aR1LUh5jfOefLtZJTE/iijCQ1r0SnfDdh4uaotLbtIsABmHm04qj4bwpZBVRc5
	RqGG2zpAmFaibK7MODEpUW3i914nH8gmV1QQ3cKggoSHUXwInxH0Tg/GZus0NgbnQKws59
	TliMq/pJ1BQIWw4t0xzUi035DKSK36c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-a9qke4PKNCyQqGONm0y77A-1; Thu, 12 Feb 2026 11:36:28 -0500
X-MC-Unique: a9qke4PKNCyQqGONm0y77A-1
X-Mimecast-MFC-AGG-ID: a9qke4PKNCyQqGONm0y77A_1770914187
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b88632ba0b5so922621066b.2
        for <audit@vger.kernel.org>; Thu, 12 Feb 2026 08:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914187; x=1771518987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0EDnMrGgmChFGfiji1cVpbPCJuj1GnVvGLW+wYkcA4=;
        b=dN8JkxfrykVCwPLXNEezbIUOI4WfYEH0ewG412bztRutqgMcI4SPffPXzbxWBzgsPQ
         M5l9VW8tZ/yU0YboIADBkgkppqREbH+ftuIutM2FlY8LxeTItaloVPmtbXjUvCH4w011
         CVuJwYMVWy2U2SkloUV11RrQXhnl35oZnrCGwMEr8NkIM38GzKaaRS7W7jljNkGWlITU
         2aCBQubbKlZDMAH3g5A4N48/XerO7xHWXamVz7FsvjXqNAKXB7kMmvM3yAY07un3ApsP
         dpMl3jLCqjxz1YEzDi9Fi3JGcboeCHq3WPrG8wxjtp2lGhyh4Au7hBSpV2U2AJcqPXkO
         c8zg==
X-Forwarded-Encrypted: i=1; AJvYcCVXglz+sPNT4ob6deuDOLzMxxpGj+sq5Vn+KBJ3RkyaXdCXQ1r5L3X6O28JAfrRqcwVfB0d7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZrtYzTNlF+Q68B3+7qyJpPECerMtsXxcEzbdiYVTQEhjQ0nD
	n2bL5PHoapFhcB3w8IOPDIPpETCHPeKHFZx/btNzAOuQLqBtHENlcxszAjeTlF93VbnkOJTUOyF
	9O5ZXD2i+/++7zdI0hbpP5xiyP/Sb9J0xSVvfVpqn4lzFuWmdvco3YiQnwxu98rURkwj2DOqcZi
	rQXT2S32W0Ziwhx+aWghHyDIgoaxOxeGc=
X-Gm-Gg: AZuq6aIxCWf3ydppPHkpCwh73+fZmMUGCVPBxis4HOhgP+ItrdVxk0jFmUoI4s+LuO3
	opfvWglVZ07KMTW/rMgBO6Lt76qlJ0JdbdWr8sVJdUtDjn6II70B2eUmAEd69r0nvyhIaKPvK3G
	1HNtuDZbQgQ5tDQ1VLKfKl730Gx4DGKabSx2sGx8YBnThmc/MH65f+CVZxWb3LmG0AJYEyKsmGl
	W1AfXQ9Ei8c8+GvuIGKUhYoowATZs9zd7nojtzzsIOFJVB0qjAEHBoqvpFyO1KpekU=
X-Received: by 2002:a17:907:3e0f:b0:b76:f090:777b with SMTP id a640c23a62f3a-b8f8f561a98mr232757266b.22.1770914187400;
        Thu, 12 Feb 2026 08:36:27 -0800 (PST)
X-Received: by 2002:a17:907:3e0f:b0:b76:f090:777b with SMTP id
 a640c23a62f3a-b8f8f561a98mr232754966b.22.1770914186866; Thu, 12 Feb 2026
 08:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206201918.1988344-1-longman@redhat.com>
In-Reply-To: <20260206201918.1988344-1-longman@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 12 Feb 2026 13:36:16 -0300
X-Gm-Features: AZwV_Qh_xEHQP09M5KdOPI4Pkceqc5eJUO3-YIQaZS2lBZJFwO1XtlTJxVP4N_8
Message-ID: <CAABTaaCpArh=umd5t2dhMjAqZo3m7+fa2fHQ-Rf6bNo+bBcS=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs, audit: Avoid excessive dput/dget in
 audit_context setup and reset paths
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5x5QtZfro2vtknhCy6x4XwRuNe7javu7xHIABrCZ_K4_1770914187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 5:19=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
>  v3:
>   - Add a new counter in fs_struct to track # of additional references
>     to pwd and add a new get_fs_pwd_pool() and put_fs_pwd_pool helpers
>     to use the new counter.
>   - Make audit use the new helpers instead of storing pwd reference
>     internally.
>
>  v2: https://lore.kernel.org/lkml/20260203194433.1738162-1-longman@redhat=
.com/
>
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
>
> This patch series aim to avoid this type of performance regression caused
> by audit by adding a new set of fs_struct helpers to reduce unncessary
> path_get() and path_put() calls and the audit code is modified to use
> these new helpers.
>
> Waiman Long (2):
>   fs: Add a pool of extra fs->pwd references to fs_struct
>   audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd
>     references
>
>  fs/fs_struct.c            | 26 +++++++++++++++++++++-----
>  fs/namespace.c            |  8 ++++++++
>  include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
>  kernel/auditsc.c          |  7 +++++--
>  4 files changed, 63 insertions(+), 8 deletions(-)
>
> --
> 2.52.0
>

Looks good to me. I ran a local kernel build against the
audit-testsuite and verified there are no noticeable audit functional
regressions.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Tested-by: Ricardo Robaina <rrobaina@redhat.com>

# uname -r
6.19.0+

# make test
Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
syscall_socketcall/test .............. ok
time_change/test ..................... ok
user_msg/test ........................ ok
All tests successful.
Files=3D25, Tests=3D282, 70 wallclock secs ( 0.09 usr  0.01 sys + 18.61
cusr  1.47 csys =3D 20.18 CPU)
Result: PASS

