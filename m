Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DC41B8FF
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273747; cv=pass; b=AeZq+RMwS2dxhdpUK9XcK7ts8chsCUDNaM9M+zFvzpHGYrugCvP8YKhfef//xKSHpCv9Hu7x5m5iyH6xstvKacQ9Z/dzzB9y1W1p8SdvsAp8EWLkqXCVncjnsbto7m0BO8iTp+z3TAr7IaPaajueMeXAFd4QASQM8NIgwuNBHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273747; c=relaxed/simple;
	bh=5fTXdN1mX7adeOd7FMDDm4McY+PRzjyh6UglHUKVqMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibmovtn1JM1yuE9CS6MhrzrAWxLdRvRiibVayhUUnunlTeMYnDrYfXwNN53Q8ah0goT2JmrzvUg1rcdkdMQY/9GQ6/E1G8tffEpj4ig9mmosZJgyxUb/bhnVCkEw/AJUoG4Zok6/2u7pLQxtzsNtCzN5qr72vsk9JfI+bRePSug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LsEi22MN; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LsEi22MN"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so41195366b.2
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 14:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785273744; cv=none;
        d=google.com; s=arc-20260327;
        b=aOuSTIHxFRukMi42lFW9UgmylyuvUzQHdgp95UTDpL3N6vXEbauJglndPp6gdVaDb8
         ebYo0KysKixPmh1mCJg+egb5xJTgcWawVvsbRKkJT7lwmc+pRuH45dv/mkrnhFXEBbxH
         CmdA2Pm1vFVLLY9HBrd7WuJckrT/oV1LqfnOogW5wr2mMQtMk8e/YogpPrLNlS99neHO
         YkqE95VLazrsEVkTyNCElZqyOsQBEuDxG4k4zzeLrn8liwreKrewsi78KdZDu6kiK96w
         BbQ+gLLraYuIVvblq94TypbrqYlf6N700pfM1FxOT2hYNtstYBoJu5VAeQdDkY07e2V3
         2y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        fh=jjH9/+6AI5FxNTcvHAVP3MEWUOLgVUeKiYC4YCD4GxM=;
        b=o1AhmwHqiMP+Bc0qzojFhfh7JIf7SCkDuPBcQ3LAoTrgeduK0KrqGBUwAaJKBLpbEh
         WxNcQvl5UUa/ofZGz+niKstUK2iuGi6EQGjcSYAQiMlIEHDgcHzIvnlC42+fPzMR14N9
         1Swemms4nP2KgiCXCKtL58Q9Cn3srqdVXKmA4MDPId2hDC8rUP4Xb8udYcZVcHek7bAr
         tG8QJvQOpKjUXUpb8kYQ16nqj+ptFjIUTYWeq9soUdye9yeLLGpDgtuBn32fDOGuheGB
         fc/rXlXHi0X+G+OWm1ZKO8ullE8aBYVDRI8nTqoNKA9y+USzC13jzhAIE+nOxyerLJ8A
         vPLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785273744; x=1785878544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        b=LsEi22MNfzA9HetuujZYAO9T8AzOtppPIWkHuhkIoiKioDDouc1b8lpWZtJaCj4WsK
         RGnO0aCxyxPot78MfabQJ/FbEt2zsdM877EWm1SGfHjXXdAlECGJEqZUN3SQtptE2W2E
         Xe8OvWVn64qjGjqxgVz123NovV0wFh8UjPXGxTiuq2I+1z8NmcbsD+5rokFbkthCSFNM
         SgOQEcUkCkBkCrYJ8ssxE4JShJlFC6GdDNYghl7z2n6xa/WT4hpScckiBzt5qAPuNbGs
         HuPawQnNav43yxFCmyEkFARe/ckeWt/UkLOIXolmbbiKqqTTR57V4O333f2YaxSOOQJN
         ihFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273744; x=1785878544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        b=GrCcnxL7ydhELAYSqhUu2mN/2OmUGlxnNjvS2FhFcUqqvW0LQWI8hab/2oRQQ3BWGm
         AJNNrdUCKSmvCZUFPJVv2GUuEzUkiGZu/zn+gQgOdSGxHXgdS5OXMyJ2eJE9cm0TQE7J
         6jhPPYs8ClfZ4m85xNSM19M3Pxj5kzF7Bw+rNN17RqhlpP+RVV2UVnDnjFY+hMqeh6Vq
         B9E/8OPSK/p0xR8JOxy6hwbncuqbfozM8+Stg9ixcdprhVlFvcuNwA/TddtPCUD8/G+5
         NuvXeNg+TFFf/sHJ/Uaf4lv/+yynDKvS9H8KhFXkL9yV09OLzqg26fCJfFQSJ9pThcFS
         372w==
X-Gm-Message-State: AOJu0Yxm8mwKomMNfcCEetrvpbuExw4l8ja42kxMgUbfpCv/XgZsTSfN
	/VYgIOq8DpR0N6jU6+MTscAHD4S/0uCp2WWW8zFTbHPvCOiKTFfKkCYXwGDzH+1nmdOTarlsZjj
	ptFcelffcZZGvL5/yE2HoFgpeVDA5g0ec4UxUN9UD
X-Gm-Gg: AR+sD10tjU0/2kS9Mqr1uOLZY4U2l4vwenx5nJK8QyRYThHGUdVOfqyvP11I/SSCGR8
	2gfsexXEAKgUpzfRAoJF0pmfGKa2X81ThJx/r/YVm7Wmo1+NrGjTeRdO0k3/OonURnrT5jjh+FS
	FExkEyh2Bf1VRE3EiJcc48Kb5h1cd+arpn7gFJbRFCa3jHTrry5hqk560Yi/A72mzs4gZuG5kMF
	xnU+z82R79uc/osvoiaeKa1HvuLan+G3Rb7coQiPu/nDsoNPFwHx1U1LP5fdy6TteQUDXBnHcTw
	JZ6boMMl30VuJuAYMIxPTu70XE4TC1P1BeINGr1xRA9p
X-Received: by 2002:a17:907:c714:b0:c1f:18b0:9fc7 with SMTP id
 a640c23a62f3a-c1f7251b18dmr228237466b.33.1785273744157; Tue, 28 Jul 2026
 14:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com>
In-Reply-To: <20260713170035.4073532-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jul 2026 17:22:09 -0400
X-Gm-Features: AUfX_mz3953sZBGG9YDBsY6XXIERNvU__-3G_ikQi-r51njdNtLFekvwb37zwOU
Message-ID: <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the move_mount syscall
> but does not capture the flags argument, creating an audit gap for
> mount relocation operations.
>
> Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> to move_mount(2). Pathnames and file descriptors are captured through
> existing PATH records and SYSCALL record arguments.
>
>  ----
>  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ...
>  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
>  type=3DMOVE_MOUNT : fs_flags=3D0x4
>  ----
>  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Dfc:00=
 ...
>  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
>  type=3DMOVE_MOUNT : fs_flags=3D0x4
>
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  fs/namespace.c             |  3 +++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 13 +++++++++++++
>  4 files changed, 27 insertions(+)

This is because we only log the first four syscall parameters,
correct?  To put this another way, if we logged all six syscall
parameters this wouldn't be an issue, yes?

I'm aware of the argument for only logging the first four parameters,
but I've always thought it was a rather foolish decision.  Perhaps now
is the time to spend to investigate adding those two missing
parameters to the SYSCALL record so we don't have to worry about hacky
workarounds like this (to be clear, I know this hacky workaround isn't
your fault, you are just trying to make the best of a kludgy thing
<g>).

--=20
paul-moore.com
