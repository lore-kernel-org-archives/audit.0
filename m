Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD73264DE
	for <audit@vger.kernel.org>; Wed, 27 May 2026 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908115; cv=none; b=g2VSTCHjPGlwn4oHvBHIm6etX1iNzPQdOgvLCLRNmrkmhuYs4NjANrgyStvKmqciILYj5uXkb3s+Fn4BJeeJ+PWWc2JVMCA3H7mRD+jBp4c5MADdN1wG66s+NVqeJnvYaDi6fc9Hy5o6tOHouOK+1vLDhC2xbaIwmoZnIVrm1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908115; c=relaxed/simple;
	bh=IEvaCbrp90Uf04KX7dpNjuPekj4S8vjDGVIGWaoyKRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGNED1Yc0WFjhEFmEJ/LjGOEAg1d5UaqSGxtziaEXd/PLpUwLfbH9llkcFw0lU592lrziAfXUBJ04zRiyzx4fuoWLliRP5VqrLhdzFY+6yKO2caxWJq8XTQL8Meiurb8u2bwYSV+CFWVguZk5quU8LtJGzFLZDXz7/Ybk/crDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V86Q/cmQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V86Q/cmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779908113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
	b=V86Q/cmQwAGCfPuXsST2KjmwwttZly5rm671Nd/+B1f7iZFWdmbHwSjd/W3PE3erS1Y50V
	uHKHypyv52lZkLgi1QM9UBUYswMlATgNf90mD6VagERxVd+cnP5YX+sq3o5qS+L+LTFRSe
	Ruu4xcuts/e4j6ddWl/Zu4axUK3jlTk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-5NXmUA7uMIWJj50YsQRWAg-1; Wed, 27 May 2026 14:55:09 -0400
X-MC-Unique: 5NXmUA7uMIWJj50YsQRWAg-1
X-Mimecast-MFC-AGG-ID: 5NXmUA7uMIWJj50YsQRWAg_1779908108
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bde08e20ce9so30977466b.0
        for <audit@vger.kernel.org>; Wed, 27 May 2026 11:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908108; x=1780512908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
        b=G/LDj6OGbVlExVrzkoCtc28q61T1d71fb37v4KLDr/BD3nWTRn02Rhx+2YoEbMoIKh
         fsp/n6biEAadjcWDzM5ZMSY1tPOFXwYvYzQjmNEwMznF8eJYlRE8R0aiZ7owKIyNjxLb
         JDUaPMM0FL6Xvla2j/hatlBvZnxSBX98YZWYv19VwsIAF031qH1s3HrxzTd+POLPeoNI
         4CaCDyVFIV2KxOR0+FetXDWSJd/EOCO6e9fvdSk6h5zMk1WhzqPwLWoA5oHoUiA/oM3O
         hkIgL3oHARl8GsBHYHDU7oI9Qhr2iqHNt4ytIR5PQNovxZW3czaMBp93bEXIKEPy2+9s
         jgNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/e2HXT9SgPJVZevXGiQK8QUxeymVjTXKob3cwWBTumkKuZEOnL7lOee8nY8oKOZvoZMEKVDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKjhcU80xeOShphoeBx0HwWAqEtfkfJwmHEd3VKtKUUVTu3La
	Og85CWAnOQNMgSAfCHQH2eKSr62455+4965Mr0zV64T16xk4W+tVLq49GR109/PJK4ODaQu1f7u
	9zctg18vPyaSBjWroc8xCTlPLDlJDwm1gqjk4hWQjsovQmuSgh/3nCzBLPdGDzd7yb5Y23cOiQQ
	B8XTFIVRdZSz1cAjIpqo9r4ggbaMRrE4c=
X-Gm-Gg: Acq92OHcjBYAnVwKJmtUD73pRIhL1R51GpdI3gJan9aPz+JoFJjNniz6sBGvYq2KIAs
	csfjRJdvAnLeXmzAW7+kJeKIv+C9rl+RNS9oIi0X/Wc2/A8vtblHGegPZkD0L1InbkHCb+i0onN
	osuxZsFHj0YS2rsTSkBe9lMY6wUmB9Y3MZCsoar+19d0bbmgezhqslDTvHbxHfAR6s4mnwHRCrB
	vY7Upke4Udi8w1jUTzcwLXDVu4Me93kfCMdm9wh4FlqkQQrNDYFnC7cgobwqs9sP8tHD7V3/RdM
	F9biOJ5pgELigCtEYGV2IsMDFvl843o1390=
X-Received: by 2002:a17:907:8691:b0:bd4:8286:466d with SMTP id a640c23a62f3a-bdbffc5fe5cmr1482315466b.12.1779908108329;
        Wed, 27 May 2026 11:55:08 -0700 (PDT)
X-Received: by 2002:a17:907:8691:b0:bd4:8286:466d with SMTP id
 a640c23a62f3a-bdbffc5fe5cmr1482314066b.12.1779908107896; Wed, 27 May 2026
 11:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
In-Reply-To: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 15:54:56 -0300
X-Gm-Features: AVHnY4IicZ2HhE2_4kzqvnb7fp4tMV1lwHhRqpfVbTWpEPC95OYW7fSY74-mqTE
Message-ID: <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	Waiman Long <longman@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fgb37uL8bYpTG6HqbPUMfVZvDRcC9C6GQDQp5gsTWc0_1779908108
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> audit_dupe_exe() but did not update the macro stubs used when
> CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for this
> configuration:
>
>   kernel/auditfilter.c: In function 'audit_data_to_entry':
>   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4 a=
rguments, but takes just 3
>     592 |                         audit_mark =3D audit_alloc_mark(&entry-=
>rule, str, f_val, NULL);
>         |                                                                =
                     ^
>   In file included from kernel/auditfilter.c:23:
>   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
>     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
>         |         ^~~~~~~~~~~~~~~~
>   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (firs=
t use in this function)
>     592 |                         audit_mark =3D audit_alloc_mark(&entry-=
>rule, str, f_val, NULL);
>         |                                      ^~~~~~~~~~~~~~~~
>   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function-lik=
e macro and might be used incorrectly
>   kernel/auditfilter.c:592:38: note: each undeclared identifier is report=
ed only once for each function it appears in
>   kernel/auditfilter.c: In function 'audit_dupe_rule':
>   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 arg=
uments, but takes just 2
>     879 |                         err =3D audit_dupe_exe(new, old, ctx);
>         |                                                           ^
>   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
>     333 | #define audit_dupe_exe(n, o) (-EINVAL)
>         |         ^~~~~~~~~~~~~~
>   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (first =
use in this function)
>     879 |                         err =3D audit_dupe_exe(new, old, ctx);
>         |                               ^~~~~~~~~~~~~~
>   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-like =
macro and might be used incorrectly
>
> Update the macros with the correct number of parameters to resolve the
> build error.
>
> Cc: stable@vger.kernel.org
> Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_dupe=
_exe()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  kernel/audit.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/audit.h b/kernel/audit.h
> index f1a77aef4533..92d5e723d570 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(void);
>  #define audit_watch_path(w) ""
>  #define audit_watch_compare(w, i, d) 0
>
> -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
>  #define audit_mark_path(m) ""
>  #define audit_remove_mark(m) do { } while (0)
>  #define audit_remove_mark_rule(k) do { } while (0)
>  #define audit_mark_compare(m, i, d) 0
>  #define audit_exe_compare(t, m) (-EINVAL)
> -#define audit_dupe_exe(n, o) (-EINVAL)
> +#define audit_dupe_exe(n, o, c) (-EINVAL)
>
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
>
> ---
> base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
>
> Best regards,
> --
> Cheers,
> Nathan
>

Hi Nathan,

Good catch, I did miss that! Looks good to me, thanks for fixing it.

Acked-by: Ricardo Robaina <rrobaina@redhat.com>

-Ricardo

