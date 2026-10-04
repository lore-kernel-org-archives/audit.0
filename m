Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830A2253FC
	for <audit@vger.kernel.org>; Sun,  4 Oct 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119887; cv=pass; b=hXhyutgn/MrjJ0Swvu8+2n2WJv5dtgm1lhU0V7DNGrBvHvzitZn9DqMaOf8YHyiu8HW7R6Y8mu3gDoTcHtRQ+YtQpUQgdvdEctEpShlh+FsL1cYrp6M2OGMDCyr4f5q0aoum8oqELZBhqOdAFgKWo+NY3uXl61cI79JryTm+i3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119887; c=relaxed/simple;
	bh=kYFPIdi5qIwk5fFvla5ev9INmB4S2FDhesXe326Sjh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgpibkWEagizWCqjOscGMlCnST/Hh5kkqMG3iZvdMtQxbVwAGyQ2haHIVVntSiOqb6mSnquiXcxZcopnBP69py08vjD6iosyHbWYt/KN+qL6zqH99zSLG73dwyQ4F9LuKGGT9s39hhjfx6OwLsIu3YxIScghVB8f6fyjUFtYw2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ewifg35h; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ewifg35h"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-885cd98d226so92273b3a.1
        for <audit@vger.kernel.org>; Sun, 04 Oct 2026 06:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791119885; cv=none;
        d=google.com; s=arc-20260327;
        b=SQ96Dhr4ADsA7sfO/8VbVXDzphi2YpJTomsnzhfrnuXLQprPA643BH+Z2vcyrHYAqA
         Zxb/TwUGGxuBfHUsQKdP5wH1F042+GSlzNE+AApOO0wsn7m7j31Yza3+7SbOcRmoM02R
         FD2xC47PZkQxReu27c2jYHOT/Vx+cvg5yjp4f5LysLTY0oQvPvukQzRB6NI/MDVsb7aW
         6GuwyhGSNAEM/rGA0hm/QyzdADMwDohUsy2V508ROUFaBCEETrAjI+Kwid/xKHiXeAyy
         iPBRulmSlh9lOXIUVYx2NML+S2wVxt/m0+Mz+8Yc6+yXMchMoDEuV/9346gQQB6sGq/x
         YjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        fh=Dxot/vllrm/vedAdIrszyrememcchXIWGKV9R0KL9dk=;
        b=edPU2zGTK2xbyj/wyOsINNQ4im8718FepM+qCtqNw4B7bodZ4NQHCOwIAAKED+4yTP
         Osvlz0ySzHmcCCoZqUlEPx8sB3G97m0Dxf5p8BJcki90I2+OCAxvoJTQUUhu4HzdHZoX
         WHExyPc4oYzYscWUzisPhRXjpfcYSTQBYqZNrqPqzKavRaP2PC7v/U7FpsjLpVblbTv7
         Ulb4S1X4lqI+y/vwEKcW1XJl8hPpb3Emh+w7pNaeXEwnCimRcFHtYwXGLsbWR9XNRj4L
         pqTYwEhDzPUdLJzO1BALGtEWZI28Pe3HPC77TYclWJgDi2mZZSuqmP49XXudJMweLRT/
         YN8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791119885; x=1791724685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        b=ewifg35hKNmJo7++/l6XBeGLxab3+vtVPZngOj+k5KRUjKjiq8Z8+GJs9qmVkSTsrc
         ifyXUqwSftzmJzFTgA/W/VlRQEM5ncCLeRv0/8yV/GlzfjLKnXsXVwp2vwIyfnoa44y6
         oYHnPfGHs9PpROzwgyHINRGGZJKHky4TxXmeEKNRbdq2mU37cfKRpz2Q+CBfW1BDUzo3
         wy+gIbvlRDWJQ35xharx0Qwwk0j51+dZbFvmljKQXDDToBUWxGbpJum5imAtoRAwlbeY
         MF+0nXQNJocCXY9CFKvl9CEx50parfa35sbNYugCRSvU1M2uFw5waw4/Hv1/tP1ykCN/
         2kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791119885; x=1791724685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        b=rtggJsBoOKt9/acfuCxY7RT7ZYgrQRq8+Wh74BCp3gPt4RuLpRaT46dh6j0uTLX7MM
         8OQrg+n933/3EJPH5he7cttsNIGvDUvAsODpn6MjuvQ7sXRMFCR29I6iHLfFUb4sNflw
         xIaC+hmlVNZyBQmxdjUOrQ07oX+ChNU4836iz66P5WE5gFoGYcrJjklpngiKSahTIHDs
         IKtRpfPNvubxVTA7LelvjC1dA4kSQtZfyw5cFEjfoez/RAgzD9K1uhzqjtHIzzaJxLEq
         zNdM0MytoUSYuli9PnhtwlVmJ2vSpDsKd4WDMwIESlOxp2gFY1+G7puPewh3E6kYMfg2
         hu+A==
X-Forwarded-Encrypted: i=1; AKwUvBw5Ii5hfPH6wjUujNL2p8wWG89MvYEUtgZFFs6aSgKa4rtZQN4CAVMM95p1YD7u49Z0a+YcLA==@vger.kernel.org
X-Gm-Message-State: AFuF++ndxKq8NxCbcQOm6rUytryRQCGfOk3lWbdRuJAS+sSuCRXNaIf3
	8m/qY7qW206XYEACpzwTz2DjvckvGQoBNysMLUeuektBhWIXfga2lFWDc2MTmi/88Ch6rvj4a7X
	vI/ZqTMNLM6y6OZeg+P1Khnr3L+r3QzB9aHXuBsmL
X-Gm-Gg: AYBFou02YBR7Wo5R54t43S2NlTA5wXRpTpXgGbwa1m4Ft2yHrD3vE75gN+k1ehLWVDO
	DG3qcZcDlwTvKPmVywhklBTwWN9Nub7yaQR//Z0nhCNY9P8cGAcksc7BXNIkVwGHG8VYgbBl1gb
	f8Dq25c1ib543SfZq4Qdh/n5q3lmGKG6aFcwx7e8doKd8Il0gGRwlLPKtdtwzQo8pgxHiGpmdMn
	sKI8PodqO+J+Z4uyVjekFtSfd2reeAl7IoBgR2wfM67l3AtpwqdarhciK8Iivfn+/xgM1jgZ/MR
	KG8CLV1EcG14R+TPJXdag81GR+GUPgCj+Wr30RhD8FTgt38ZeMirFSSCJVeTTYnXK+aEgGI5IJB
	PTaXMJ12CEGw=
X-Received: by 2002:a05:6a00:a0f:b0:880:7f48:5f07 with SMTP id
 d2e1a72fcca58-887fb5cadf3mr7829367b3a.6.1791119885275; Sun, 04 Oct 2026
 06:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
In-Reply-To: <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 Oct 2026 09:17:53 -0400
X-Gm-Features: AclHuK93CXILhWqVoyyCiJV7kNi7hXkohGtKrcJ5HI3-Ast7QrPAddVZAM79UGo
Message-ID: <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 3:33=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
> On 2026-07-03 09:25, Ricardo Robaina wrote:
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > does not capture the filesystem name string, creating an audit gap for
> > filesystem mount operations.
> >
> > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > name string passed to fsopen(2).
> >
> >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN_C=
LOEXEC
> >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
>
> > ---
> > Changes in v2:
> > - Better placement of audit_log_fsopen() call to avoid UAF.
> >
> >  fs/fsopen.c                |  3 +++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 13 +++++++++++++
> >  4 files changed, 27 insertions(+)

My apologies, this patch fell between the cracks, but it looks good to me.

As this patch touches both the audit and VFS code, I've merged this
via a topic branch in the audit tree, topic-7.3-audit_fsopen.  The
branch will remain static and it will be included in the audit/next
branch as well as the audit PR for the upcoming merge window.

--=20
paul-moore.com
