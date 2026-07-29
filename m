Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7673CAE73
	for <audit@vger.kernel.org>; Wed, 29 Jul 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357122; cv=pass; b=AhnTa7ShqzoGSURgzZnZax/9lLiIUupiydtqzbKJOIOkaaqhvbu9wa55y0bHtfn62QAAJSMU5MR6NLyxHuPjAQcfG2dE8V5FvSyZj/JK3+RUO9RvSFdeoQrKA5F6q+jJWFgy2gw3PxwkbNjJ4yR5dKjguegh/6vyJrwE/B7ssBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357122; c=relaxed/simple;
	bh=3tFmuXCy+f/WWbhe+tbgJ6Y+oj/UNSok/CJPEzq3pAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP1up1rdc7w7CsgGhY6smxScXpQelb0ZJ2MmGiYXPqMJVCxY6Wbc9hmBH+m7UR272R32B6kvuy7nBYTMoGBG0nmzoMAX79YLboNlsUNy/80BeAUMwTO2y//aBLh2WfeeWyfQZa3wzeRPlCqKr4tGgYCTJxAnuMrYZn1EYO+6XoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YUDocgbs; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YUDocgbs"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1618284a12.1
        for <audit@vger.kernel.org>; Wed, 29 Jul 2026 13:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785357119; cv=none;
        d=google.com; s=arc-20260327;
        b=kPILsGBwE1p4/X1nqB87LfP+1EfrobNPFi5Bajf6PizEKVOv+cB5qyBYNHJ2gbXK5z
         8V90kXjsx4fg9z0pGEX8YrPdTTmAnn8nYkJnzxpNkFxw/2xll+TKJ76Rop9zWuS8sW6k
         Hdb+0zAMCfFUZMDcc++y8id13VXJEoKu+u9dK6M7S+PPF8PvxW6SWDygoJL8ERDA11EP
         aLfThvE+ibE8GIjd81qIFUodbR8NA/FOKXx7fCrPIZOHECLuq7VweIA/ngcpP/+pbDAR
         a7BUfnw64UWZSJXFZhNRX9Q6J9SGoRV2POXD2VN/wMylhWWmqw4ctc84H/73p6dfyF24
         DC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MSYWD1Xt8Tq9MNB9gHh4KNUxv0x6yETJ8gKQdGljQg=;
        fh=6sz4VrJaUPZWiEpqwTN4BeLy3289HjLdv/NdtQS87+E=;
        b=aFX43YwVO5YMm8/KFRqkWLolWNcV4RctVlnCuCRPogrt+h/cH4aGR8qW2hjNQHLXyg
         d+kKJn2LrCXZ6iJ2PsKhbWtTOnuqPiCwYUdpy8CnwwwuhlUTzh/mJd3q6iQw+PLun+p+
         lVOgb8KtSs0ggXqNjx1Z7hFplAxFBYZxwJNquc1P7zoCi14FSmjt6bi/7MFXw026LINp
         TfyP+JXjaiU8JdjvLDD1+KUDcTa7gHFMwjLmZE+/7AeNBl0jAHntr9QY/vsuSLQYgDMo
         Ico1103ON2l23PMZuK3AFGfNL96s+k8nhBUOTnvqDnqyu9j+43wmBvcV4eTP34XRwm7Z
         N3Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785357119; x=1785961919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MSYWD1Xt8Tq9MNB9gHh4KNUxv0x6yETJ8gKQdGljQg=;
        b=YUDocgbs+akHnTm/O/+D0PJM63sX+6LeRDc9bxTKQ8jBpcgPUtARIhMNvDwu3QXSGs
         GhAbKGRph5ZyGT9LJ+kYsrU3UpiQ/9MCNepuiU01ESyd6hfXikCKCpO5YeUQFWuOy1GQ
         MFkezxdqzibzLUV1WH9qxSpS1y6MXgfpKjSHKTUrGjv4KdBDmrTNpIRx+ho6VMwiUXBh
         MsMshFPxHPbG2MK4np2UitsfWKpZfS4psVccpINZ9jKvobUILHToLsXmoPG5zzevS9Nx
         4uCJY1U/cP37NpBFllj2yojVMCNA3zNST2akW/9scB+dg2m7I+PCQYfs3cSfl4IvqCTf
         RwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357119; x=1785961919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MSYWD1Xt8Tq9MNB9gHh4KNUxv0x6yETJ8gKQdGljQg=;
        b=Ybc2Ug0qxpWnLL3+CCVtu16KUp0Sp+ckXJW7JbVeKO5AI/RLcKEgVF1WRxks6Bj64b
         r4BvTqny3C7JVYFsUIeMXt++FHljk3Ms5oTRWzX1BDCf9/SInj82bKdFMM8ZD1somMIp
         dBpw5cMlC/viAfPaHyf/onyO2RYoAUOxcKE8W4nnfTsUnpwHHSSjxlsePsTkTJH8mQkg
         Q66HCvXdIE+kOqcOn507bCGSWto2SPtdLZGJ7Vfv2N9UY9LsDf6U/QFhSdLrLNEebTJn
         QTCSA54hXFlYoSLjAY+wv8+MfYH5HML86lesjy4Er+3OauifMDHr8PCOhkhIOyRMAOzY
         F0QQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQmb8XilA+6giIUlNI5CuhTtoLe1ljYdsIYrOqb8b/jHpVTdC/xzp7vNj2Zd078pPpH+bbfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXTaGJJVpoTBVtXPSZF3mnHvkpylPjRhCfe/D0W1qPR+mN94y
	Bad2/iQ24Xu4By4Zv9vbIFoRcG7IUQaXQJKBLg2cF0X8LCePm9zgaWSC35iQDMPXtctbsUr52e0
	JXTzAIrySIDDXLoRbXNba/WcJnK6WUQepsYxr2skV
X-Gm-Gg: AR+sD12nkwpSnDQOImwhAFSWyZa/xWiIC+p4jgTKbtMCVzRl8bAIBvPl4s9IZOOXoSS
	Hk7pNVXxgzejp5/uXl7HqWkG4ZiG+leTBXbhfnkg1hjscbjGezxUhjEECltSs6pBl0xQFaQ24qa
	JCOSyo8Q/qMDWFVWefwLp7sj4mI1nAYpmcXFv36ikJl+65JqYawXAozAcXWqtiaJudWXaCGJExA
	UVN780HrlKxnrYMfyZtYeYdtQdPoYKOuYTWooknfnWDTPN+N9XZhoqVir2zylLd87KxlpwzEUrZ
	rozn45YvIlgunkGMo/YW8HRTx24YCiyIel7l/Zs8sXIR
X-Received: by 2002:a05:6a21:60c8:b0:3b4:8bc6:138 with SMTP id
 adf61e73a8af0-3c8acbcdd34mr9870725637.23.1785357118723; Wed, 29 Jul 2026
 13:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ffdeea400054f4d42e394d09003cb4dd5ffe862c.1784611349.git.rakukuip@gmail.com>
 <623bf8c0c7725ae7d93d7c0847821212@paul-moore.com> <CANZytUwnnaq0U3UU3R9ZhyyW=E0mF2+8uHFDtjodk8QMCcDK3Q@mail.gmail.com>
In-Reply-To: <CANZytUwnnaq0U3UU3R9ZhyyW=E0mF2+8uHFDtjodk8QMCcDK3Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Jul 2026 16:31:46 -0400
X-Gm-Features: AUfX_mzznm8-7YWHHwdmaaOoEgvxXD8UAJ_G8H7QoR8ECv37yXHY1yv2z0ROfQM
Message-ID: <CAHC9VhRGM5Cpup5=Vz1J1WNh+KkPpGUacayz4mt=ov_d=a8_xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audit: fix potential use-after-free in audit_del_rule()
To: Lain Anc <rakukuip@gmail.com>
Cc: Ren Wei <enjou1224z@gmail.com>, audit@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:11=E2=80=AFPM Lain Anc <rakukuip@gmail.com> wrot=
e:
> Paul Moore <paul@paul-moore.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 05:57=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Jul 21, 2026 Ren Wei <enjou1224z@gmail.com> wrote:
> > >
> > > `audit_del_rule()` destroys `e->rule.exe` via `audit_remove_mark_rule=
()`
> > > before unlinking the rule from RCU-visible filter lists and waiting f=
or a
> > > grace period. Concurrent readers in `audit_filter()` and
> > > `audit_filter_rules()` still dereference `e->rule.exe`, while the fsn=
otify
> > > mark can be freed on an independent lifetime path. This creates a use=
-after-free
> > > window during rule deletion.
> > >
> > > Fix this by unlinking the rule from the RCU-visible lists and invokin=
g
> > > `synchronize_rcu()` before calling `audit_remove_mark_rule()` (and ot=
her
> > > rule removal helpers). This ensures that all existing RCU readers hav=
e exited
> > > the critical section before any underlying resources are destroyed.
> > >
> > > Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: Codex:gpt-5.4
> > > Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> > > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > > ---
> > >  kernel/auditfilter.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Thanks for identifying this and providing a patch, some initial thought=
s
> > below ...
> >
> > > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > > index 4401119b5275..7f791afe5791 100644
> > > --- a/kernel/auditfilter.c
> > > +++ b/kernel/auditfilter.c
> > > @@ -1045,6 +1045,10 @@ int audit_del_rule(struct audit_entry *entry)
> > >               goto out;
> > >       }
> > >
> > > +     list_del_rcu(&e->list);
> > > +     list_del(&e->rule.list);
> > > +     synchronize_rcu();
> >
> > I generally prefer to use call_rcu() instead of synchronize_rcu() when
> > possible.  Did you consider creating a audit_del_rule_rcu() (or similar=
)
> > function which would perform the other cleanups/releases below this poi=
nt
> > including the call to audit_free_rule_rcu() which could then be called
> > by call_rcu()?
> >
> > It's worth mentioning that I didn't verify all of the code involved to
> > know if this would work, be safe, etc., I just wanted to check to see i=
f
> > you already had and decided synchronize_rcu() was the only option.
> >
>
> Thanks for reviewing the patch and for the suggestion! I did look
> into using call_rcu() for the cleanup, but we cannot do so due to
> sleeping constraints in RCU callbacks.

Merged into audit/stable-7.2, thanks.

--=20
paul-moore.com
