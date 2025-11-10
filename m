Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A00314D1B
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776689; cv=none; b=gyJfzVbx/njLZAvtbDRe2MCJzwH39jtap2G37AlB7fT2H6lJhSDs1B79rMAF+Fn95Ysyz0o/KXREs9122BfQXodjJ7wf68exRE4G3gLUhwcV4r9YqBLY4+cTIeA8oorb5UMuF3kpJ0B6h1As2NMYs00N4IYK/tNJ+p0u3H7xwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776689; c=relaxed/simple;
	bh=/tSpx15UsSyaiP+LSGuC/N/Kf99NYcuCuOorK8fkvcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS8Fc9bh2MYpXNmAeEBswoBtAeij/6VoSVlSqvGdHN+43C7daNo+CJhixeYkQGpKU/WiMGg80XhdqgaqqteWsh19+jnRt5YrFNSA/lLhcvUgrN+So6IvbJ1UNg0taWqTU5Knz2w5bO6jeFZuOBP4dviaxqzkLeUD24k6zpl/2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3IIs3is; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3IIs3is"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762776686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTBjYBydZ0P2EgaHuZsKfPgw1EdAQeW/BWVTSClYnYs=;
	b=D3IIs3isrQTg1Ri6ApV3PBz0sVGiKmdf70krNhI8CY3jjrufR/AkYb6rLYu6aJ5UlwUcX+
	LVE3RuAi/qiJSHITBtFekUcVzhCWLg/OCY0co13srfJUNQoqJglvRZN1Ys7qnOHe6IiNYw
	98aRbPL/mUbuyJh/+8jHfo6qS/qt+Y4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-kiOchSsgOcqH6L350kP1sQ-1; Mon, 10 Nov 2025 07:11:25 -0500
X-MC-Unique: kiOchSsgOcqH6L350kP1sQ-1
X-Mimecast-MFC-AGG-ID: kiOchSsgOcqH6L350kP1sQ_1762776684
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b70bca184ccso323220866b.2
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 04:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776683; x=1763381483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTBjYBydZ0P2EgaHuZsKfPgw1EdAQeW/BWVTSClYnYs=;
        b=gJiE48dc5HQyin68MPlPcwlsyMD0oK7x4exLSkMPAhm/the/Id2klv4OzlQIkS1Iil
         Vfz4iHs3Hs/4SyqBil7xA3K7593JxFQvunAceiZkkG07Yhr8wNY/sI7/yt3yAT/N7f9K
         FUfeWHkUnon0vTi3QQVMYVfWtkMtok4O6MV/BIbs2rAbinyMBjZpMsbBXfrJlMD21Jfm
         K2RjbHm1JtkyZSYtRRb4nddsAzCgFyiXmtuGMviPzN+OmS/Sy1zqXmi+1WqLumuXl2/1
         q7rck5pcWAGlflAkFZEzXJRRIhDmAMeUmzOvj2Zug+dTap+CiUGBr942377LJrBUcczP
         Rcdw==
X-Gm-Message-State: AOJu0Yw31xRglvkiAm+LXDgMcXZPpM4pDxi6TyIHFDoNBi8XmdFOctJ2
	i7Ol8wY71o0NmnQHOFDWq2v+zFKlCKkYCAqEfIsZ/EE1IUZnkrQzZiXHm+9lEgeibv9ch2ZEOV0
	+8H0Y+xfNG7UY7yHjE9KnwRO2NGNmdmCGo1m7xe4Tdp3bwHaYA9HpLQNaUL79k+x3aNQkSuOeuc
	VicHE7twfA5f4WfkRzw78WHPNYWFrAoXPD+T+scR4=
X-Gm-Gg: ASbGnctJGRYxPbh3Ohp2Y+y09ZSovedhsmMDRWv8KChL4cjGZv5v4o4QYztPt+3gIKc
	ZdJ1Hl1nWHZasADiR8oy3y+W8RKdandp/ogWnvVrIRJNH2Ayxbzg3aeZJFtLqk/J7ygpVAaZO5I
	KaLqLkQupToeJtop1qdgJvTfbWdteIAWa5nW9PHj15S8IAXDq5Nyp5a+7f1bLCtNbn/O7HTEJf7
	Yf07tBq6x8KdmbF
X-Received: by 2002:a17:907:849:b0:b72:7eb6:c5c with SMTP id a640c23a62f3a-b72e033386amr694393966b.19.1762776683489;
        Mon, 10 Nov 2025 04:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENfZNQDOO48M2cfsnX0tl3fK+b/EphUyt313f3RyAn0vffBWZLIhi6bnnSjKc2DN5qCQgc2CT4OdZ/hH8ioyg=
X-Received: by 2002:a17:907:849:b0:b72:7eb6:c5c with SMTP id
 a640c23a62f3a-b72e033386amr694391466b.19.1762776683147; Mon, 10 Nov 2025
 04:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031123328.1758743-1-rrobaina@redhat.com> <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
In-Reply-To: <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Nov 2025 09:11:11 -0300
X-Gm-Features: AWmQ_bnbNfdhYfS3cRBtkLmIap5Ox1jnANfIeomSLr8LzEVBWB8HsX9Se5Vg5co
Message-ID: <CAABTaaA9qy8P-LLuT8mfv5a8Sc_g2MJcjRDcFMET0dwGwRoj1g@mail.gmail.com>
Subject: Re: [PATCH v3] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Uof_rkm13tH074XNrb9LIDZcNT7q1ckDyFkXKdhDBA_1762776684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Fri, Nov 7, 2025 at 6:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Oct 31, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Whenever there's audit context, __audit_inode_child() gets called
> > numerous times, which can lead to high latency in scenarios that
> > create too many sysfs/debugfs entries at once, for instance, upon
> > device_add_disk() invocation.
> >
> >    # uname -r
> >    6.18.0-rc2+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m46.676s
> >    user 0m0.000s
> >    sys 0m46.405s
> >
> >    # perf record -a insmod loop max_loop=3D1000
> >    # perf report --stdio |grep __audit_inode_child
> >    32.73%  insmod [kernel.kallsyms] [k] __audit_inode_child
> >
> > __audit_inode_child() searches for both the parent and the child
> > in two different loops that iterate over the same list. This
> > process can be optimized by merging these into a single loop,
> > without changing the function behavior or affecting the code's
> > readability.
> >
> > This patch merges the two loops that walk through the list
> > context->names_list into a single loop. This optimization resulted
> > in around 51% performance enhancement for the benchmark.
> >
> >    # uname -r
> >    6.18.0-rc2-enhancedv3+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m22.899s
> >    user 0m0.001s
> >    sys 0m22.652s
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 43 +++++++++++++++++++------------------------
> >  1 file changed, 19 insertions(+), 24 deletions(-)
>
> Looks good to me, merged into audit/dev, thanks!
>
> --
> paul-moore.com
>

