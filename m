Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E3361DA6
	for <audit@vger.kernel.org>; Wed, 10 Jun 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121222; cv=none; b=gIw+CjFIO8qUenm2ZEJDbnuUGZp47rV4ccrHHZPNGNOLbsr47tlvvWbtPnlq5wFduVpE7yiCQOthg8oQAn/xGtXkb1Lb4r9Eg1ahj5459wN86HJWS8mgLxFJlXYMZ3Qrr/h7LjrYfJ3ZkRyscazQEUfzH4J1w1lsmVsCcC/qkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121222; c=relaxed/simple;
	bh=459PmgaIKTi+jGFsDwJCbEFj0+/x7260xa519JdirmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ef26pRKdMBtxiVJfEDMpOtELabek3Rn/OgAImI+Bn5IPzVEsG8rvRbZ91AgJLtCwlPeynZwq9tmMIAiD3xCSryrv/pEbojliFUKMjZ1j/9tBWs4pwoJKSK2uQ1J6wFQlMqHIJuVjSChLub2b3aplaxGpJS4NDYk1xdhS5JNJu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6UXAEWh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6UXAEWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781121220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
	b=d6UXAEWhA+cDwBGrwe+54e+NLR98xiyt+55lMF3YJHjSsQSFvPa+d17adFtcrwNFSPNX/k
	xsjkslDV1BXjGLJsjklMmKEHUgPlgAE8M/EplnYiYU/yYS0Id1NDHxz7qZlhixDTzqLd+l
	5h82uQ7DKjaTpGe6LDX9hZw99aIvpaA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-xNMUmOcjOemuNMZbGzsi7w-1; Wed, 10 Jun 2026 15:53:38 -0400
X-MC-Unique: xNMUmOcjOemuNMZbGzsi7w-1
X-Mimecast-MFC-AGG-ID: xNMUmOcjOemuNMZbGzsi7w_1781121218
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bebbba3c343so416277966b.0
        for <audit@vger.kernel.org>; Wed, 10 Jun 2026 12:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781121218; x=1781726018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
        b=JHIyGHciOqq8pmJ7sp1tUyvm10BDwdPiDGQaa5PKUTkrWFZxbFjYBQ3pNMRt6ryRQM
         xk1UbSFXU5LTPzBv8vTXg6opyNoz7NNERNT2d588Z4NaD2fndHMqSIp389FCBFP+yGac
         gzqn2XzlEZOg+L8/l28s3lpTKelc8hRpcopo4urSIA2SsF/bYJFyJ7yzsd7LDwSKoX1H
         U1crAvtTedKgP9qBIcMumFbL+VPCraOxnVH6gNZuFprMN/r59iQgdCn2l1wXTCA3l5XZ
         ltFfWmTcwtnjoJ3fAsbjeWxcYsxW+F+exioNyqSLezsJVOG7gnDv/00IJM1v0FD62MtB
         agig==
X-Forwarded-Encrypted: i=1; AFNElJ+rqdxwtIOib684fJU1lYoBFmizuYdq3hEOdqSgDkStITOCAeY3ychY02t0Usy0s4e6lnUkyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVPCuhUNduhWCJgP+C6GtrvPbKgY91c1Wy8NnJd9JP9udX+Ri
	W41Pkg28unFJ6TCW+zMPpESHeBkEltEnNPd2Gex+JJImyDY0nPLXmOveqVDvcdQ862hxatajUfg
	rXLmPL6yjc08Ahf1u/Lo3A/3N7FsdfJELCjIt5/9NJPNH/9OR6y4SPyoLySSFp0qlb0XcR2onIi
	N/tywLU8WpjZnr1KVaIPTXVBe2kvXQcbM=
X-Gm-Gg: Acq92OEqJp63BhkPUsvz3FrG4HYLF/tWtHqiop+yHkExdAFS4l9Ff4qdfmxoiWLRLyY
	8dvNDLGiKPHjNmBSNNmav7aLXU0VH16YQvzlzRwx4325IjeahLFlUtbZx/vt1Yy4gWAjbUHSP9/
	a4HotGBtYm7PIE1qLTXppFKK9Wi4k+uySlzRCnAfiVnmHlWOOyHRwUeyI0VFWeZALR+crREQ3qd
	UWEc7H1d1kreehtBHm7p8OeJAM/tarwUjyJCvxA5g4OSIahWID4qtBPsjqUhbB0JWhhQ9cMbA3E
	F8sk3bZ7bM5V8kljTPL7DWUts7+rvM3ln1c=
X-Received: by 2002:a17:907:d40e:b0:bec:a96b:75b8 with SMTP id a640c23a62f3a-bf372741180mr1368090466b.32.1781121217622;
        Wed, 10 Jun 2026 12:53:37 -0700 (PDT)
X-Received: by 2002:a17:907:d40e:b0:bec:a96b:75b8 with SMTP id
 a640c23a62f3a-bf372741180mr1368089166b.32.1781121217229; Wed, 10 Jun 2026
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
 <2021591.7Z3S40VBb9@x2> <4c885308-7556-49a9-836b-37089ac3bafb@app.fastmail.com>
In-Reply-To: <4c885308-7556-49a9-836b-37089ac3bafb@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 16:53:25 -0300
X-Gm-Features: AVVi8CegNJFmA5pJjXnR6bzdeWqrb7ywcRPoDsKS9Cmo3gkCjJrGU4TIKNqXM6U
Message-ID: <CAABTaaCPpxSxUDXe-YthFOiNqM_SgsvVaVuVv8AxogRTd1nQ5Q@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 201Ksj6gmy_OG1zfn-xWdSCSUy8FsJNB2KD1pBvWWew_1781121218
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 10, 2026, at 20:13, Steve Grubb wrote:
> > On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time Ri=
cardo Robaina
> > wrote:
>
> >> > scripts/syscall.tbl:79  stat64  fstatat64
> >> > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64
> >> >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i38=
6
> >> > oldstat                 sys_stat
> >> > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat
> >> >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i38=
6
> >> > oldlstat                sys_lstat
> >> > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64
> >> >        sys_stat64                      compat_sys_ia32_stat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64
> >> >        sys_lstat64                     compat_sys_ia32_lstat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64
> >> >        sys_fstat64                     compat_sys_ia32_fstat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64
> >> >        sys_fstatat64                   compat_sys_ia32_fstatat64
> >> > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat
> >> >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:2=
25
> >> >    common  osf_lstat                       sys_osf_lstat
> >> > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat
> >> >                sys_osf_fstat
> >> Hi Arnd,
> >>
> >> Thanks for reviewing this patch! You're right, it seems all these stat
> >> variants should be added as well. Steve and Paul, correct me if I'm
> >> wrong here, please.
> >
> > Alpha is unsupported. Those are True64 compatibility syscalls. You can
> > include it and #ifdef will filter it everywhere else.  But, yeah. I gue=
ss the
> > rest are ok. I don't pay much attention to the 32 bit arches.
>
> Ah, indeed. I assumed that these were part of the syscalls that
> originally came from osf1 but are still used on Linux systems,
> but it appears that the stat family was never used like that
> with glibc.
>
> The oldstat family is actually in a similar category, as those
> were only used on libc5 or earlier. stat64 is definitely
> still needed on 32-bit userspace with 32-bit time_t.
>
>      Arnd
>

Thanks for the context, Arnd and Steve. I'll append just stat64,
lstat64, fstat64 and fstatat64 to the v2 I'm about to send, then.

Please let me know if there's anything else to adjust.

-Ricardo

