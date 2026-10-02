Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519E4BEE45
	for <audit@vger.kernel.org>; Fri,  2 Oct 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952294; cv=pass; b=AijEfLtalPG2/YJedIPNjlDRcva9lJwobPY+mqvqT4SQykgSMnrtUvRNkVur4/ooKSCNfJAPoZNlAQwshPb+DtQuOP0DTlIQDY9Py9snSmYgfUTxgrZCh70Dr79PQhDk64EDKWyE6Tjw8zKZAzJsJ61hYJNpbO5ADiFmhVMXPzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952294; c=relaxed/simple;
	bh=u8PLXXSTY0IAoYfBBSIw6bMv8+76hBg9C/vfZ4dsutk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvk1rlSAmwnOXGIRBp8ANapoj0PjCG8ARdL+tWzMny3U2Ioag80OBuRqc0VSKf1u9R2cjibSYzdChknrtoJKLkVGJ4g+hBQYy2wN0qwss0E6MXc56YL0hyKHDkTK2k5nhSYsVwhc896A9Qtzb0AyDtAEXXr+ukF8zzLFYql9Arw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YirReEQx; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YirReEQx"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-88b4eaccebcso661103b3a.3
        for <audit@vger.kernel.org>; Fri, 02 Oct 2026 07:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790952280; cv=none;
        d=google.com; s=arc-20260327;
        b=SlYUOt1fPAqTRqe7jbJSCO+Kh278tjgON3eTr/V2LFdFyFMPltpmo7s30fg0soyrcA
         NdA/iiTcoAQP0+4GZXzW8i7WtxLehi8oL3cdWrNsLNSt270xgdeAzghRH8WBZlV8zsDl
         diPc4GDuTybS4nB4MqT2kBRaVAKgMgEFGAZySrjkdeqLnD3edT6I+w7MSABjQigRO8f7
         /Btc884EYpPVN6am12i7tNfAEhC7wQ9Vdw2MB8aQjKg9pqtDofP+QzY22T1DRikwD3F4
         nVQekyxMMtIKPrETIEX1Hc+A8PBPedeRe1seqBB7dUD7TQBiEV08v5xHiJ3u4guzFQXo
         qLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LF2SkzXE6JWvXRVUQA23kKIKoZzi1sawVkhqirTYitw=;
        fh=HA9TW2Nbs1+wUjnWozkvFfouysfnx6t3bmk3U4mrXSc=;
        b=Rgua7mx/40lEEXqt3B78oK+/bHDpO/yZBvWEc0XQH2q/dnMV12SU0gQM+a2W7a9oj4
         vhG0sO24k+7k6fyDycD1e77IC5ntCvJQaEN3F1mpsjfd9OFqZQZETeQEQbxZhZ9dG20w
         VymVoqxuMCU3CYeW/OE4CrqJeU2VUx89KiZvboGJufFlFU7U5FCOOdTdtBmuAUfJgBVp
         vaj81S/egoU3TsvuItuvpBj9Hlwl/AQxBova+GpzXyBVeRp/BGRwD6PIKJg639BiMzHr
         2gN8bxmI4vItRaE95gT9z6uFipJmL6qM9rN0/HMqnwcJFVEcZO4Ff3MttXE5ZG5os7qM
         8POw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790952280; x=1791557080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LF2SkzXE6JWvXRVUQA23kKIKoZzi1sawVkhqirTYitw=;
        b=YirReEQx1ThnPjw0CX+tXJuIWYyItcf7lJD7IqchT69lnVBeErf45noRgqfqXFzrdn
         5eDkzjkI9YVy3JlBSzoqssVovB71mju9X0Z7EY7AcHUF6Zm2nAJX6+YdxvemTtIePYMg
         RaNMkT872HaWrFXgulqOoVIogHC/0hImmf1n1k9iPCuaPxEqjWgqll6+Urcfm7ezqagU
         XCRUQnJFdkjec+l05eg/oqh/CUQxQsS7zZaKyO2K+PLDt2NYL85d+bq1XJKVoxK3OMMv
         5iAhXboFoa5KZzufMTny1/R3jBlizRHs7lZd2mkJbkBwAkDDlb1Qs5KXm0zrcbY7kJqR
         OfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790952280; x=1791557080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LF2SkzXE6JWvXRVUQA23kKIKoZzi1sawVkhqirTYitw=;
        b=1TfrhH3lXoP9rzdMLVjSsu3ec7eyMVmZ+xQ1YOgV/Img1qpdYgEWpv88gcQvl4KCPA
         CM+Zj2t1tCoq5vIKw7UiGGqAqKaB87NANoU+jJjXGLKFHcjMi2uuEy22c4/ddd4lqM0y
         Rnvtk/+ogz1VGGzZSr6avEBjvixahqnFqozsVudSqIlmwFiL9dI4mBM2x+8CJ4XrX4YW
         Trxa9xKyNjhrAkA960Czy5w7CPeBWopBHUI42oq6u8r4ECnomgxZj/5FTXt7tj6NHecj
         RmZidBh+lRSDmhcgG/1ZK6FaAVS7GWx/b7ItWr1bniMXGZ+8dkZSazFo4ezAonHhDAa8
         cCog==
X-Forwarded-Encrypted: i=1; AKwUvByVIPl61xH4lw3T7bryeGwEFFPvpaInTUu+gn8+T70mDxH5JnT1qZvVMDWRBaKlaO2b9r1YNA==@vger.kernel.org
X-Gm-Message-State: AFuF++m+uNYCCtpnBcdOwIvHRLBhoBXVv0XHV19Y5U9d1tVll+vs96CE
	8r7pXB69n5HNiWXKEqQ3h3M7PMkvDp5XiG2JbVJRF+3DXIzm9u7TLpH4vizH+SpAudky03iq7AA
	oUsifjW3pq+pCfE7RGJKR6DQsyi6GT9g/CFkyDIwC
X-Gm-Gg: AYBFou2BbLKlA6+knxwiZurR2M091+H6uVPliW5U/a+9ATvygGUY4UdRGAtTNqIJofL
	IVg9qoN+EFf8j6eq3PofEp6CNn2Nut5HdpGhiJh9eknheON3b/cNF7iOjk0LnsZ/BAAcZ6z7Wt+
	vANrR+ZEaMy0IaoEZzrnmdMbkw2b6ueTYq1hoCCFL4kvEZj6D2euxxWYRVUGjBgIZ+/N4aSltNx
	k0DGf0rA4klJ+7v2eHmPuqpD7kRwzDC3ko5X7qx2R1XAi/ueO2hsndSzSHCqMyKp87uMB/Q1m01
	VSGnaA0Gqd3WHamuvXZedVJoKO4CPlqssAOb9oavBf6oM8HjflVURSbZp+61LmoJaK3qevDshu8
	cOZkPNPGLxsI=
X-Received: by 2002:a05:6a00:1785:b0:882:23ce:f515 with SMTP id
 d2e1a72fcca58-88af8080910mr2973393b3a.33.1790952280636; Fri, 02 Oct 2026
 07:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002011712.7-1-bbnpreetsingh@gmail.com>
In-Reply-To: <20261002011712.7-1-bbnpreetsingh@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Oct 2026 10:44:29 -0400
X-Gm-Features: AclHuK9ayOqkrUXBAC_GcZ2eCbisR0JLLAs-LuRc-nBc_JmcBaIHgMmt3iLarik
Message-ID: <CAHC9VhTgs-ZXwagRC9gscGT1BqkrH63us1wLQCvnvmrALijj4w@mail.gmail.com>
Subject: Re: [PATCH] audit: annotate the lockless read of the audit control
 lock owner
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:17=E2=80=AFPM Babanpreet Singh <bbnpreetsingh@gmai=
l.com> wrote:
>
> audit_ctl_owner_current() reads the lock owner without taking the lock
> and KCSAN complains about it. Only the current task can store itself as
> owner, so the check can't give a wrong answer. Mark the accesses with
> READ_ONCE() and WRITE_ONCE().
>
> Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D39b8fea0641107a1ccee
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
> Paul, you looked at this race in 2022 and asked whether READ_ONCE()
> was worth it and what it would cost:
> https://lore.kernel.org/all/CAHC9VhTXNPWBDRoPcz-Jw=3Df+NNAEhxbh-ySc56CUd-=
ZbuboW5w@mail.gmail.com/
> Compile tested only (gcc and the KCSAN instrumentation diff); I could
> not reproduce the race in QEMU.
>
>  kernel/audit.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks for the patch.

I stand by my previous comments, but given the current state of LLM
assisted reporting and submissions it's probably worth making the
change.  I would like to see one small change, see below ...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 631d6d4a23cfd..f8c43ac6d5b82 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -268,7 +268,12 @@ void audit_ctl_unlock(void)
>   */
>  static bool audit_ctl_owner_current(void)
>  {
> -       return (current =3D=3D audit_cmd_mutex.owner);
> +       /*
> +        * Lockless read: the owner can only equal current if current set
> +        * it, so another task changing the owner concurrently can never
> +        * make this return the wrong answer.
> +        */

This code is fairly easy to understand so I don't believe this comment
is necessary or adds any value, please drop this commment and
resubmit.

> +       return (current =3D=3D READ_ONCE(audit_cmd_mutex.owner));
>  }

--=20
paul-moore.com
