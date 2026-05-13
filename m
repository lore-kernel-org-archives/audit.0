Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736023955C1
	for <audit@vger.kernel.org>; Wed, 13 May 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706275; cv=none; b=EJUNTnd2z0QAhTdFjweTp5UGFZcrZpHDKHFGWCleO7QCubiekiy9Z27/odvAgwWguryTFejoIaUDO0zttWX2QAzdR2Kam1kxUmi/SDmD8xzEqdyEjJirugG0QF7bOGPc3lS71CfvJsmJwHdvKUsJxVtEJWBoHuzqGNexckeVL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706275; c=relaxed/simple;
	bh=617RuO07VdzvSQQpN/0WXWf/V1vuvphEhvAnqRasT1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYULzj4Lz2E+ZPE2UzMiOFiI77qOMiydVlkAzPz6DQJpVboWo2nAiT5CHmrivvjg7Z0AbkBJ0Na9M3BDrm+O3WK4EuDQBfEk8F74EeBRMbLPSuvspIjGUkgbSjNdjYpI/aFREFZioWetc7ezqfqgqFerAvDr1etfDBiZ6gN4y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNC8xLzt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNC8xLzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778706272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7wobZI0JXbPxrXaIvvN68PGmWFXEohkMGtnfjg2+B0=;
	b=JNC8xLztM9nmJcGrN4cDSqAzBlP/nQUVOKQBYE1kQ2ZXhTWrZBez2gLoovczIDEzwib0KY
	faY0ULpNUFp3gMimLI8RM0m2alGPL2JFgUY3pvh6FQk32zDK5eqeZ8FhDrN8Dc8Fz/IVk2
	wO0MWnIAHlfLfu9/VvBFVVJDPI/lg9g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-zKtIVHASMB-uU_n8VBHYgg-1; Wed, 13 May 2026 17:04:30 -0400
X-MC-Unique: zKtIVHASMB-uU_n8VBHYgg-1
X-Mimecast-MFC-AGG-ID: zKtIVHASMB-uU_n8VBHYgg_1778706269
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-67fd8b662ecso4293694a12.2
        for <audit@vger.kernel.org>; Wed, 13 May 2026 14:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706269; x=1779311069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7wobZI0JXbPxrXaIvvN68PGmWFXEohkMGtnfjg2+B0=;
        b=WK5KzEXIxEUmzFWsJlc3+J94OwUcOOLw2I4BjgEsDTwtTURZwga5bmdqdaXV80UpAQ
         dAHhcYO8CPxYWzCZHAtuh6AIDsK8ZnZ3nqK3YWQw9tDTXarUpb3z6E+1TNHnzRZhtUeX
         JaC6gxRkTpEHlS0UZXP/5JCBAg/fJpFJC2D0ahcQ0gs1gjiuLzuAe5QXNpbljJ+DI7+9
         tCKXQcJJ31lnAQAMzckCPDxfvFSLickdKWUutQ028O6ZyVafoWiLZ1hVo1HBZkdam9Xp
         60o+ZgpQYszrkxwZG+szcba7TKecu39G8/bFyk8t9nSHABgHMhfVjWl6MnlOZo272KpM
         HIUw==
X-Gm-Message-State: AOJu0YxWhu+RrlNIH5c48mU/Qoaivi3wb5OnxayNgZvZDO7+64fKrW7n
	HogM3/5gNIuLSdfapNI/f/xfpwHkiGCyi7jGKxbYx8g5MCYj5JoSIaDwJ8/1J5o4lk0l3UtHOAK
	FEtM1INm27yv01m7npfyT1AZGcMTNSnJCfLpAUt9VFZ2Y4Is746IoRjDeFRF2GXy6444GZmcQlk
	49csmsd5Ff8q/TDq3UnLyGtuhRD56imOE=
X-Gm-Gg: Acq92OEeadsaZ1yueLYvCmtn1n/DkCYG4DCUJZKjWKs6LxT18zkYxAjzmJfrMCci9QG
	vlAYBIOJKUhm7aOBShmq78cd+jRVYj5zA9lapoj0DBMdbQtsmNmKBL3MTyE5qvMqrDCNcKLs+kX
	5pV1Z/AmmRjEkT/IXqnduwAonNcM+FUVfrMsIC53LHyxcFfG8CEC2/fxtqZ5mJ1AV97Sa4flqk1
	6CvIql04/k6u7lMFmBZSOeMOTpu1yiJCuNpo/HaLKYMgwny1EAGW69Wf0TTh4ebKIRoJQhlZ7mW
	0acnKhOVZWQ0fJW5savOqJ0=
X-Received: by 2002:a17:907:6b8c:b0:bd2:2852:683b with SMTP id a640c23a62f3a-bd3bfb8225dmr366368466b.16.1778706269153;
        Wed, 13 May 2026 14:04:29 -0700 (PDT)
X-Received: by 2002:a17:907:6b8c:b0:bd2:2852:683b with SMTP id
 a640c23a62f3a-bd3bfb8225dmr366367366b.16.1778706268842; Wed, 13 May 2026
 14:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5fd6163fd285fca25460ce821f95b15383f920a.1776176104.git.rrobaina@redhat.com>
 <402f11211fcab76b6410f3f57372c58f@paul-moore.com>
In-Reply-To: <402f11211fcab76b6410f3f57372c58f@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 13 May 2026 18:04:16 -0300
X-Gm-Features: AVHnY4Ix60XYo_dhhntA8m7f1LyaoMwnDrqccW4F8b0vY0QASsmD-EP2oD23kHQ
Message-ID: <CAABTaaB--dc2Xx-u91JG-3sgY8GE5wRkZabfyCg7GxSd9eQaoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: fix removal of dangling executable rules
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mNXlOuIH7FzkNVMX0YxnZIa9nbx1y_sSj8CtSBLsJtI_1778706269
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Apr 14, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > When an audited executable is deleted from the disk, its dentry
> > becomes negative. Any later attempt to delete the associated audit
> > rule will lead to audit_alloc_mark() encountering this negative
> > dentry and immediately aborting, returning -ENOENT.
> >
> > This early abort prevents the subsystem from allocating the temporary
> > fsnotify mark needed to construct the search key, meaning the kernel
> > cannot find the existing rule in its own lists to delete it. This
> > leaves a dangling rule in memory, resulting in the following error
> > while attempting to delete the rule:
> >
> >  # ./audit-dupe-exe-deadlock.sh
> >  No rules
> >  Error deleting rule (No such file or directory)
> >  There was an error while processing parameters
> >
> >  # auditctl -l
> >  -a always,exit -S all -F exe=3D/tmp/file -F path=3D/tmp/file -F key=3D=
dr
> >
> >  # auditctl -D
> >  Error deleting rule (No such file or directory)
> >  There was an error while processing parameters
> >
> > This patch fixes this issue by removing the d_really_is_negative()
> > check. By doing so, a dummy mark can be successfully generated for
> > the deleted path, which allows the audit subsystem to properly match
> > and flush the dangling rule.
> >
> > Fixes: 76a53de6f7ff ("VFS/audit: introduce kern_path_parent() for audit=
")
> > Acked-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Acked-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit_fsnotify.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> Good catch.  I might reorder the patchset so this patch comes first
> in the patchset, but this isn't a big deal either way.
>
> --
> paul-moore.com
>

I'm sending the v2 reordered. Thanks for reviewing it as well!

