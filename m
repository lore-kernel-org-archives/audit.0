Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C623373BE0
	for <audit@vger.kernel.org>; Wed, 22 Apr 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868421; cv=pass; b=M4Uar1a2L5RxYy4Ht9+HqKtrxX6KpuMr/BLrNZ+0R1OsIIKhUiXvRKRUF6maT4BuLGYS2korEE9N/p+aJsykBl/Om5AkIsQod3VrYHAVLcw2fARfa8TQ+rHcYVtRfTIcp2JxMRans71Muu/v5oOJggeLJRzneYcEqpGN9cHGONo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868421; c=relaxed/simple;
	bh=kZaE0D26y0L45OODMViKgePn+cdD4STT+bVvQ4zOYUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4VzvgUmjpzd22voVczXHjqXS8xVse4Tr0rWHMpVS9euYDk2pOUDlTQDgbVI02CrUU3Sk9EmhfG79IuU0YrAmmUxlY+iMIBBooofudmPWK99PmktyWSZFxeDOc8Uaf7RXB2aHqGEoAvjtvUgPi3zOEuQ2MzBMC1FnggOuy6Kofw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e6cDqgJ8; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e6cDqgJ8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaf43014d0so33857555ad.2
        for <audit@vger.kernel.org>; Wed, 22 Apr 2026 07:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776868420; cv=none;
        d=google.com; s=arc-20240605;
        b=OtS3749x3/hsqv4nvEoPd665BCZN8AE+A69IHj7qZx8mam4G9ubsK9Vl3H43f6jnr7
         zkp6+CSvY6N3IOgn0ZYOpq1IZ/MYvuhNNZa2mbwg4MDsPQJcfhuJsSFtXHWhYAjYi1I7
         VafeaXektEX3oAUoYvw8VB0ORVzZzlOh12iT2laYHlAnZi635pE7ZEcMwYCLLQ1LT6S3
         +aOPvuXWIdF7YYcaXIWpZNYZ0lAz2KAsl+I3OmOFNjb8S56HcSPXLwkI3xz+TXs2V+9h
         UfEfzPr2Swgy0liLUCmstI2ieeY44qWWT1wE2tdOK/Pp3WBWaHDlT/Z4PK1ZYdBw/yKd
         8DRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PppXoQQI33/oAY139jaqfJMfBN0Od2EKiFn3+CzkDHI=;
        fh=BiUb4HrCoQg78wuGuzr1+ElWWLsMKcRy7kGvRoF9UJE=;
        b=hta0y2uHLO9gjHZKf1EGFDxza6IYDNfTVj1BPSqOqit00DtY3yLXkNs3zvGrQIb/Ub
         U/WR1ePRQgtRAA3Xum5YTtWlkIBuzIjt4cBKT+RfjYt9EvkL014y1HarJR19YCB+ORWX
         4DN291UsFHuB1rOHq/U6IRxS1ue12U08qAgmDT+viQlVj6Xa+FOmoKjY0CqozallM/pl
         5rhzcMy3ldzZmOPT3ILa61zPMZPkF30ui8cmM/uEcfX/JOzThEIzIY1APQ331h/FSAxi
         HoWlygl1icm41IfNL/prL8j0mPxDbSIRKMc9gI6GQ+2J8LDUkwzy/mQKXPSkakHcRbgq
         STRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776868420; x=1777473220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PppXoQQI33/oAY139jaqfJMfBN0Od2EKiFn3+CzkDHI=;
        b=e6cDqgJ8BFgtXq7xoivxAi9/fbEB1EQUVeu5XfwW2hCn+Y2DGMDNw5c8k1nFLu2zE6
         dYL6+MmUnrjOOE+ICLvJlUHUo1HPbVHk8QYYhx8d82tEauzfsAUaO2i3nowncnHzdT43
         y83qwOQ2OuJqI79EwsD/6dEQS1ebsawLyNzTxIhAdKVTEW1Co9ErpHB3R377bhr1C3pD
         nDL+jDQld1wAOMcikyGX99QzkGLBpfbgx6j8Kre2YqEuug0YXjHc24ozj4s24nk9LNkz
         7M9wzIJA7eV1dobCXN7LQztczRoK8XdDokltoXcvO8TMDOjjJNbqGdJ9cV08/tuAW2nO
         6OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868420; x=1777473220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PppXoQQI33/oAY139jaqfJMfBN0Od2EKiFn3+CzkDHI=;
        b=Mj3WqkA4liaBlu2Q+PUexcPhAqXY+HKT5SB8Oz5sPz0pKRNUEwwyKjPzi63Sg0bV/0
         GbsSNHplAbKlgu98+7XNAAfw+GMok1YP38T40joW3mqv0T9eIkr5WD51RB7ku95KhZM7
         zLgffyTYpAr1aMgNjvGudRx/q8ofbUjpz9u65Tl2QgsU6T0fY6FsWNuy7uLVQ922wvPB
         rnx76Lkr6euCUxg0YF/26BkwaUI4SmWikbNfDYr0ibpMovXr3cLVIeiwWuUboAAuRc4m
         XPNaMRtgeIcxAfd5RDQh1R/cHofUxQ/xIPOqge22Bpy6J8RBd3HIGwpKVGnBzAAGGUPF
         z/Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9vdTpUQUASG+59bdnKG149eP6S/xP0BRmuhg9o4OXQnLm7FzYsTEE+xJAaLdWyuYD/+2NCjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaheOLk0+ea0lAtSzFztyEXDPI4cCLarCJHqNCG1wuYpxlxm9
	S4qPu8LCiWPmh2AH9xfsugjguPCRbV45yb3BbZW/Vub4fBN2L+tQZiOh/PsKZHjyCdaNka1jSCS
	J3l2zgxYI8qmKD2HYhKtUNaZ7/2hXGVcO/uFP0ekY
X-Gm-Gg: AeBDievU/BHpO90H8BkIQaS6k+k2FSYfwrjvcikEhE0iN3Qt+8OMMtdjlOwpesqUv9l
	3XKALVAT0981w9bx6Qnth5qRVraZb3bd6sJHG0j6HkTx9Dg2MrNdZK6fk2yJ1TkqHhejercF8Nv
	iJNlymK9AL3Tgm9bzE8/qIv2NPzMns4sUOWXMj7bvTfF1UsDd7mi7M3qL7GS3L5R6cAhIuJBlIz
	RfQtlo7X3/jY31gZdTG8ABLy2WOWgoJQ5hw1Cv2oeDXY/YAAETwp267FJYDo+xBe6ZIEOSip7wX
	mjOhtpwbu1pzdRf4bA==
X-Received: by 2002:a17:902:ff04:b0:2b4:5d87:a207 with SMTP id
 d9443c01a7336-2b5f9f64174mr195131765ad.30.1776868419545; Wed, 22 Apr 2026
 07:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
 <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
 <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com> <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
In-Reply-To: <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Apr 2026 10:33:27 -0400
X-Gm-Features: AQROBzCETT71ZyEIBu4j4G4yN_m6lu_6HdMoKXLTtULHj5B5zlT8sC-stV3h9FM
Message-ID: <CAHC9VhT0poHt_9P407tr3ihfMGJYH0d9=PKxW0sk7gYF8fD5Lg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 7:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > > It's still Nack.
> > > >
> > > > Based solely on the diffstat and a quick look, this appears to be a=
n
> > > > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs=
,
> > > > but they are LSM/audit kfuncs and not core BPF functionality.
> > > > Regardless, I want to see how the LSS presentation is received befo=
re
> > > > worrying about this too much, but your NACK has been noted.
> > >
> > > Paul,
> > >
> > > told you countless times LSM cannot touch BPF bits without
> > > explicit Ack.
> >
> > Based on a quick glance it doesn't appear that Fred's patches touch
> > BPF bits, they simply supply kfuncs for users to use in their BPF
> > programs.
> >
> > > So, no, you cannot add bpf kfuncs in random places in the kernel
> >
> > I see plenty of places outside of kernel/bpf that define kfuncs.
>
> We discussed this already.
> All those places were explicitly acked by BPF maintainers.

Perhaps.  However, we don't have to look further than your first
response in this thread to notice a prejudice against existing
in-kernel security/auditing mechanisms that large numbers of users
rely on every day.  While I'll continue to try working with you, and
encourage others to do the same, you've forced me into a position
where I need to consider sending patches to Linus that you've NACK'd.
I don't like it, it indicates a cultural breakdown and the formation
of rigid silos/fiefdoms within the kernel community, but I have a
responsibility to the other developers and users to represent and
advocate for their security needs.

> Every time somebody adds a kfunc it breaks safety, because
> people don't read or don't understand Documentation/bpf/kfuncs.rst.
> kfuncs are not export_symbol.
> Object ownership model needs to be thought through.
> Calling context needs to be analyzed and so on.
> Just because something "works for me" it doesn't mean
> that it's safe.

Unfortunately that isn't the review you provided Fred in this thread.
There were no comments about object ownership, calling context,
safety, etc., only a dismissive comment telling Fred to use something
else for logging.  If you want to provide proper feedback, something
along the lines of Kumar's constructive review, I think Fred would
welcome that.

--=20
paul-moore.com
