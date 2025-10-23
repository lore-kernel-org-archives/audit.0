Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A12D3EC0
	for <audit@vger.kernel.org>; Thu, 23 Oct 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228857; cv=none; b=J2TVilIalCYWTlHYXslx6fm4EXX6Loh10RheEvzyi/UA0bM2HG3B7mqDZSroZ6YlEWYCAmWcUqkmxNqIXWMZz+TqOpafS4C92zChUJh5R6i1/coFTSO1VhjnpNqan5i0Q1kqon9QSuVgExmH0fYOKiZQJomsUHXvhhdK5vuGYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228857; c=relaxed/simple;
	bh=gifXI2rT/rnYjYtKHyESHdweFEFLjSdFxr3iVDuDlfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3ePJmE4xc5m38bYNhS0Kg+wwSPfH9n+PwqbWIadh6bmQgGFpnOC+f+qKqPMBarbEwubLoVoS1wB6p2t5yUwtx/10fVtcIuwuILAu4NhJOm7taxPx+qvFonUARz4Xu/gyA7qd9DtX4p1s7H22jfIRsVWVLmMAw5zjn5b4qnOLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTr+HYVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTr+HYVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJHPHM5jfbL/1z9GPVbMjrbsugaBR4HNX7+7hZSJ+8=;
	b=NTr+HYVmWJ+JwMzk0eVyk9DCh7tfa0XES9FSF11HKEEk+3glMUj87OGAZK2OhSV3nf3s1s
	pXa0Je9mZj+ILNjFdsyod8BryDWUGYsFXLHHBSu4mJNVhf+Sk2QJrv5zfKjjBZivamXBuy
	5i222FWeop/KRNM4FNEA7PUBnaDvEg8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-xwSefMfQNL6z68DqA2UdMQ-1; Thu, 23 Oct 2025 10:14:12 -0400
X-MC-Unique: xwSefMfQNL6z68DqA2UdMQ-1
X-Mimecast-MFC-AGG-ID: xwSefMfQNL6z68DqA2UdMQ_1761228851
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b5a8827e692so74412166b.2
        for <audit@vger.kernel.org>; Thu, 23 Oct 2025 07:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228851; x=1761833651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YJHPHM5jfbL/1z9GPVbMjrbsugaBR4HNX7+7hZSJ+8=;
        b=wOcnzeJ/3gk9fqXEpZRoNGuMTOTibE5tfm8rCMCcQE9oTZklQs2JBE7gnY4U4rS6bT
         amT1Xkcb9erV1uyL9Lb2dVeCaQtc+hOEvxprg9AnD5AHsj1IzW6WxaAhg8oANP0zqrTw
         ZcnmYAQp++8UHsm+uOd9vTfvAh3EEuI5yp4A2FFSlmE51q73k1sLVwskWLI+ps6gRPxW
         jYhQHaFwxaabnPcLexcQi+uxKpHU1EYLjYP6lVjRGawBzepCx1omJupUR/Xk5ercyIoZ
         4VsRFOgtnuVdUgSMB6A40i46a26oxXa5knWqfiDAbe50eCs/bvqG6fVy1ERciKSJFaX6
         mNpg==
X-Gm-Message-State: AOJu0YzvGj6eRmdZ92nL3PfcHLqnpJ2P8h4uvZHaLlenqxTaz2BC/K14
	832x1PlB7/4Z8+vg+iF1232O63UNExBGYqY2ghngtUfkgEntHOwhJt2zIeGc0KoL8hkdYj19IqO
	UX7ucTqg6NgQ7zk5YEkXLC4vxdwSxUBII0ZhHhyydyZBF1KRu0l/5dsHQAM1ky2W2LoswUWc+sv
	/8zODY7IMYSklF/wqj94Q4eNhM4Vl/SFHMZ+Ys4Mhf6g==
X-Gm-Gg: ASbGncsppsYm2ckRgKkYkZTB/3LyTdEeMhP1wh7gY4NXQio/Ym+Uy7j1uvLcd3/vcNO
	WbM5DMNFFqS/13oM97H5okIy7PdqvedPZTPi8MGvNwdbEC3+chJKpYl/jviowLo8C5cFST+zPDa
	L9F7pM2OB6Mg4NIaV7orQaVSBucqEK7UYLvWysOr/dabPGHN8Oega4TJs=
X-Received: by 2002:a17:906:eecc:b0:b57:8477:8754 with SMTP id a640c23a62f3a-b6471f3b8ffmr3223087166b.21.1761228850629;
        Thu, 23 Oct 2025 07:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAgXDpjM+z/dloQnxSyt9wlX8JMMphJKMwq9BHO8yRoKsZdEW827OGpExtsfxuxxC7V/SxRDVu5m3/WVKLcaY=
X-Received: by 2002:a17:906:eecc:b0:b57:8477:8754 with SMTP id
 a640c23a62f3a-b6471f3b8ffmr3223083166b.21.1761228850126; Thu, 23 Oct 2025
 07:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022123644.1560744-1-rrobaina@redhat.com> <CAHC9VhR1PJQKZgLX98HMkmswQ9XvDtic6jFuqxSssY9_qcdwaw@mail.gmail.com>
In-Reply-To: <CAHC9VhR1PJQKZgLX98HMkmswQ9XvDtic6jFuqxSssY9_qcdwaw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 23 Oct 2025 11:13:58 -0300
X-Gm-Features: AS18NWBl3ECm6hvBf5YDEud-X2umqyDc-OwwLPbhTQh1XvlOllsjGmkvr2oh8_Y
Message-ID: <CAABTaaDquPM1pj_dGWULV2yiFiQfsbL43TDT0bmboCZ+=pFeMw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BNYQpXlOi0r4rBtTNGUQDbsFjCk4msSD2msoHMyUooA_1761228851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Oct 22, 2025 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Whenever there's audit context, __audit_inode_child() gets called
> > numerous times, which can lead to high latency in scenarios that
> > create too many sysfs/debugfs entries at once, for instance, upon
> > device_add_disk() invocation.
> >
> >    # uname -r
> >    6.17.0-rc3+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m42.753s
> >    user 0m0.000s
> >    sys  0m42.494s
> >
> >    # perf record -a insmod loop max_loop=3D1000
> >    # perf report --stdio |grep __audit_inode_child
> >    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> >
> > __audit_inode_child() searches for both the parent and the child
> > in two different loops that iterate over the same list. This
> > process can be optimized by merging these into a single loop,
> > without changing the function behavior or affecting the code's
> > readability.
> >
> > This patch merges the two loops that walk through the list
> > context->names_list into a single loop. This optimization resulted
> > in around 54% performance enhancement for the benchmark.
> >
> >    # uname -r
> >    6.17.0-rc3+-enhanced
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m19.388s
> >    user 0m0.000s
> >    sys  0m19.149s
>
> I couldn't help but notice that these numbers look *exactly* the same
> as the v1 patch numbers ... ;)
>
> Assuming the rest of the patch looks okay (I suspect it will), there
> is no need to re-spin the patch, but if there are different numbers
> you want me to use I can update the commit description when I merge
> the patch.
>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 39 +++++++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
>
> --
> paul-moore.com
>

Hi Paul,

I did test and collected fresh data on kernel-6.18 before posting the
v2. However, I completely forgot updating the commit message, I'm
sorry for that.
Please update it as follows:

Whenever there's audit context, __audit_inode_child() gets called
numerous times, which can lead to high latency in scenarios that
create too many sysfs/debugfs entries at once, for instance, upon
device_add_disk() invocation.

   # uname -r
   6.18.0-rc2+

   # auditctl -a always,exit -F path=3D/tmp -k foo
   # time insmod loop max_loop=3D1000
   real     0m46.676s
   user     0m0.000s
   sys    0m46.405s

   # perf record -a insmod loop max_loop=3D1000
   # perf report --stdio |grep __audit_inode_child
   32.73%  insmod           [kernel.kallsyms]                  [k]
__audit_inode_child

__audit_inode_child() searches for both the parent and the child
in two different loops that iterate over the same list. This
process can be optimized by merging these into a single loop,
without changing the function behavior or affecting the code's
readability.

This patch merges the two loops that walk through the list
context->names_list into a single loop. This optimization resulted
in around 51% performance enhancement for the benchmark.

   # uname -r
   6.18.0-rc2-enhanced

   # auditctl -a always,exit -F path=3D/tmp -k foo
   # time insmod loop max_loop=3D1000
   real    0m22.991s
   user    0m0.000s
   sys 0m22.737s

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>


Data:

root@fedora:/home/rrobaina# uname -r
6.18.0-rc2+

root@fedora:/home/rrobaina# rmmod loop
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real    0m45.264s
user    0m0.001s
sys    0m44.990s


root@fedora:/home/rrobaina# rmmod loop
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real    0m47.383s
user    0m0.000s
sys    0m47.113s

root@fedora:/home/rrobaina# auditctl -a always,exit -F path=3D/tmp -k foo
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real    0m46.984s
user    0m0.001s
sys    0m46.679s


Average:
real     0m46.676s
user     0m0.000s
sys    0m46.405s

root@fedora:/home/rrobaina# perf record -a insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000
root@fedora:/home/rrobaina# perf report --stdio |grep __audit_inode_child
    32.73%  insmod           [kernel.kallsyms]                  [k]
__audit_inode_child
     0.00%  (udev-worker)    [kernel.kallsyms]                  [k]
__audit_inode_child

--

root@fedora:/home/rrobaina# uname -r
6.18.0-rc2-enhanced

root@fedora:/home/rrobaina# auditctl -a always,exit -F path=3D/tmp -k foo
root@fedora:/home/rrobaina# rmmod loop
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real     0m22.793s
user     0m0.000s
sys    0m22.517s

root@fedora:/home/rrobaina# rmmod loop
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real     0m22.763s
user     0m0.001s
sys    0m22.524s

root@fedora:/home/rrobaina# rmmod loop
root@fedora:/home/rrobaina# time insmod /lib/modules/$(uname
-r)/kernel/drivers/block/loop.ko* max_loop=3D1000

real     0m23.419s
user     0m0.001s
sys    0m23.172s


Average:
real 0m22.991s
user 0m0.000s
sys    0m22.737s


Performance improvement: 51%
(46.405 - 22.737) / 46.405 =3D 0.510


Sorry for the extra trouble!
Best regards,
-Ricardo

