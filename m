Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED449F11C
	for <audit@vger.kernel.org>; Mon, 31 Aug 2026 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199304; cv=pass; b=uIARPkrydVpw3CUdbpfHHAEGjsygc4gnXKwjh5405NCJvqkEHn0SRylqeQ6N63M0A8uE8ZwANNxxINzK8T8j/OpINzSOdIq1ZGlNXw/GY+qTQFCi4c2NtRjMI9ZH/Bkbh+7psTmlPnpQIjmbC9OR0ehzdErrF+ujWvzD3nqFuR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199304; c=relaxed/simple;
	bh=DN7ajB5HW+161pKga12XB+ux9+zyLcXTHDVln4XJ3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLqgjaziIeNOajUG1sRJEEju+tklOIZff79qH4rvOYRbPxI5SGfoe1VhBSIulLHWJfLzJnessq8d8zIQIPGg6k4WzQZEVOazBND/TU6NknpgWVnj21SdsjYkqXq+/PgMQUx24R/HO03qInXw7dHJEpaNY274sRTI667Q6/shajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TmgoL+AX; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TmgoL+AX"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-853c07a76adso4002654b3a.0
        for <audit@vger.kernel.org>; Mon, 31 Aug 2026 11:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199302; cv=none;
        d=google.com; s=arc-20260327;
        b=YYx/I7ENqYUafc08+VmrY30n0hVOjH50UXwpk03RSGLbeK+3lwO2XxQEezmj1WOf9m
         URiNQKqj5HK8SK6wDus61XWyfbwvt7jaT16MGWRmFvAlipTzu8aq4YDV6m9tkujrF488
         +wlBQmrAZxA84FtNCoMagih1ZHVi96tGcCiMpa/5Z8ohSe1H9rn+SCa0mGPCPx4creW0
         n3f8WvkkoqUEb7TPaajWSDWUkrapF7Q3PZErbr3D/DljbYFlZYLRDehKm5RMFE1w2xQh
         Vubkt8KCtDCVuTHAXYCQinBtrxzj73qtC2O1q9TU8sisj5HGWmO/qDaKN8I3sBuU0GWb
         fr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        fh=PQrP1gAqN+hY7oF1iZa7QuIuIwbPptJY68jnmQLUxq8=;
        b=T3khmkSX4Hdh5aMV/y6MPPhLp6SsZxRFdsCSKzzinej89Z/agwI174vbHv7K8ZMEz4
         pkBp9Ih9heI1THmGxHX+dH/hSwFQmpvUE0yoYFffFu34nLymYCkQM3d+WqCA9wYEu06C
         C2qzcwkO5iDaJgqQTwZorjQV7QrQuHdcpyWoEQbupP5ciMDxXx9i/XdX7BfOxnkAWt5h
         yWyA969eRu71PEdFxr7EIJWZbc6cbXtxpu3Qf9ODF5pVyfcCHEEUYQ298O0kSSkq+T05
         WaQhyRcniCGQOJ05rr/INbN3UikQmY0JJunDdTFPwEAWL6/Le8sqRtZhl7lv+9Qv2+Hm
         pnWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788199302; x=1788804102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        b=TmgoL+AX+K+1e+0xEF544/bUrWJ3T3a80izkqNfqNAKO898D8dx8I5/igau5wIciZA
         vv5WkZqD5Dy+XtReibK5Ct+B4wsdewKBKTguNt7YWEC3tSvy3LpjsMmN3R6UMFJ9GUNG
         sZawzTAYN7cWNQIAnORI2I6foeE6YDpl9p5NrUv9i/ax+ax/Bi5DIzB2XI4KzlsYc3oN
         VqH1GJB6jHJaMstxshrYgxxFObIJmQgz379rvIFau6q9DbkMblsZrQQ+vH1jjcDYDcKE
         kPspNZqPeAW/1UrrPh0NAxvvWqxEU0Vy2m8QiXn/qphWxO+iARdvnPNB5Ot9aIGIgr4U
         n29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199302; x=1788804102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        b=SyOTrIol4VUWITZvNQrDDaxeYuPQdkm1DWCyAwmfhQ1BECz4vH4bbwNttBcKc/Wbih
         pVmDIKY4W4fGmyhPPPQEJDUsTH4hfirIVY6OBX6SgWs7lwnGVHOB8CBnkfRzujnN1+/c
         WHLTL7gri29MA7H7k4rJx5niic33/kAxDwAybSbXKBx2W8XNxCXkD7gIiNp+UcWOikH4
         11tfNnqScrKJoyAwkeDGGx/aZRUnkqw7ZVze7zdFuSa4NDofOZ0m+1rbMGjH8NI2D/Sy
         yG/UusFaAvU5JYDI6fM5dY8YAvhP8zH0AuIbKsj09GF8icKkOL39QSPS3TCVOEAeBdA1
         BVOw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1QxSGxpS5BEuVujKUfCbqq2kyaOl3k07XJh6cefMsJX8taDE03el7vKnn6WLjRVE4B361EA==@vger.kernel.org
X-Gm-Message-State: AFuF++l8aTAUxCRpox04nrYzG+l0d+UOnwoFVqYlOhRi6zLXBdvXUEX9
	27CrIT/j3YZnp37CJw2EKnX+53I9JkNiwz5vyeq+SAHnz1pZJAHTS0fZp06i1HJdKS9Hge0VWcJ
	KuHXKxbbrq8QCxaTsKfyh7/ysDOaVzPYgdFroDbEC
X-Gm-Gg: AR+sD13lxeHWqnMoquoTkXuNdrQXAeXXt9M1BS/qPUCMZYnjGMFiNa3+AU62aTUE1Dj
	1Duzzjzcgb8Cz7sJVT98IrpL1M1+H6aUSgm6I0EXy1jUqGiRRKBWe4ElZwxeCv/DfRXqRn1+GOT
	E0/y3vAaNZ3ouiwTi3l89MJlGt81+7WyggHksKjTKCyDVSbHV3GfIfd/6cQn/+Bfb8V8MrUj+tA
	oFi/jmtlTobk4QrquqDmVMSJSlSxl6WY+pysl17uNOTGDnsFcDjG+n4dhQlX5wIMnDqifN4Go9w
	PIhdkNy03vgmmr6LebzlnOpi5PVzgVSEss9yMhfqjao3
X-Received: by 2002:a05:6a00:802:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-85629064fcamr42578483b3a.7.1788199302293; Mon, 31 Aug 2026
 11:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
 <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
In-Reply-To: <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 14:01:30 -0400
X-Gm-Features: AcwNN1UjA6EQ0vdTUMZpIzMqbTR5XzQsbvy_jGC-ejOGutXWjivMDB6qbx9VHhc
Message-ID: <CAHC9VhTAe1x5Fzj==SanTP85wxi+XQ5N2-m98fdxWmcAeM105g@mail.gmail.com>
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
To: Richard Guy Briggs <rgb@redhat.com>, 
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, 
	Roman Dolgikh <rmd4work@mail.ru>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 18, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Between the actual process startup (fork systemd) and the executable fi=
le
> > replacement (exec), systemd sets a temporary file name (executable file
> > name in parentheses). If an auditable system call occurs at this point,
> > the audit context will latch the temporary process name into the cache.
> > This name will not change again. The patch clears proctitle into the
> > audit cache when the exec call is made, allowing the new process name t=
o
> > be latched.
> >
> > Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> > Link: https://github.com/user-attachments/files/20751461/fix_audit_proc=
title.txt
>
> I did drop the link above from the commit as it is contained within the
> link below.
>
> > Link: https://github.com/linux-audit/audit-kernel/issues/170
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> > Changelog:
> > v3: use previously assigned context
> > v2: simplified to call single use directly before need in audit_bimprm
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Merged into audit/dev-staging since we're currently in the middle of the
> merge window, this will got to audit/dev once the window closes.

... and now it's in audit/dev, thanks!

--=20
paul-moore.com
