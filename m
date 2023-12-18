Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51871470
	for <audit@vger.kernel.org>; Mon, 18 Dec 2023 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gPWrj1NV"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b9f8c9307dso3594288b6e.0
        for <audit@vger.kernel.org>; Mon, 18 Dec 2023 14:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702937356; x=1703542156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4cb/ceLetDgVuIaguAYjCffbGi7zeOxXqi5aerhDs=;
        b=gPWrj1NVkw8ilNxtEe+S9zkaOtAxEnf1Nofm3rN4CjULQkJtmN+/8qV84VWhadtGq5
         gLu6Zul/yA412PsgRGmzyiQkx7atupk3T0Q31eC8Jqx+j+Fm38AusFrefd7o4SfDFgsm
         Cr4JWSdqoqPQ8iQ0jpKdVLHAgIZVewcc8uBa0PWI5nPih2REKVfRVYbVthJV+7VccXHn
         3Gky9i1OJ3Z68AQLgjjsozl2F0VVk2y1l7isWzmNO+gQI1oHUUHaQIq0h6OHSklbW/Mp
         I0KADalIKIuIFXepo0nqI5MzNtlRcjZWXEgzraPW1La6GwHya8ClACOmSfoe+UctAFNm
         k8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937356; x=1703542156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh4cb/ceLetDgVuIaguAYjCffbGi7zeOxXqi5aerhDs=;
        b=ZNeW40IStTjN5/+/Q6Pt+fc63TM9oWoz3p4U2fwL2lZi+DVt0y8A6wOu3QRkuRSE8w
         YqURp3Imzmu18+G0gFCFsJJV1xCl5tqvfAE9xyNuZrUITekMWbyhFLvEs9zaLQ6mcvvS
         hKvKeq389RY+YHIrulJnFiU5webgEU7pNnaLP/tBgQz0+jXWiQjVqOvyP/x7FYXGE6D/
         pHt2deE00YdAMkPBRNpsVnSNeYWSCxRznMqlQrV6/kVSm7ud8nUyRzzkTf13u+ZrQ2GF
         QTVIzhEXpW2KwsR+DFFXHOhCQxsI9B6UprqvNWe77DnhjN0QDVjAlTJy3OXm3gd1Tmku
         Hbbw==
X-Gm-Message-State: AOJu0YzB+dtx659hKaUPRqMKDSKXjMNC2dgnYhCaGR3aMRj0YG17p58/
	0ty65f0iPT+ssxMJqb3ts7AltLL/AYLUwLS1fP8E
X-Google-Smtp-Source: AGHT+IF2bOcczTMmDKZdYaIoC6RQaIbcEInhXIbg/9NfRAktyQIj6Fe6K7cedZM0dYyBmcmIWiNsh8g60p1LvwmjMr4=
X-Received: by 2002:a05:6808:1442:b0:3b8:b063:adf6 with SMTP id
 x2-20020a056808144200b003b8b063adf6mr22051986oiv.83.1702937355773; Mon, 18
 Dec 2023 14:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-3-haakon.bugge@oracle.com> <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
 <CEB5B23B-7D1D-4C7B-B8A6-CA07239CB5EF@oracle.com>
In-Reply-To: <CEB5B23B-7D1D-4C7B-B8A6-CA07239CB5EF@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 17:09:04 -0500
Message-ID: <CAHC9VhRR+WuY6ZG7G6_qFipZyydtFUkju+ZjXyfpKwo_C7CCPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: Apply codegen optimizations
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:28=E2=80=AFAM Haakon Bugge <haakon.bugge@oracle.=
com> wrote:
> > On 14 Dec 2023, at 00:45, Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Dec 12, 2023 at 5:29=E2=80=AFAM H=C3=A5kon Bugge <haakon.bugge@=
oracle.com> wrote:
> >>
> >> For the most time-consuming function, when running a syscall benchmark
> >> with STIG compliant audit rules:
> >>
> >>  Overhead  Command       Shared Object      Symbol
> >> .........  ............  .................  ........................
> >>
> >>    27.62%  syscall_lat   [kernel.kallsyms]  [k] __audit_filter_op
> >>
> >> we apply codegen optimizations, which speeds up the syscall
> >> performance by around 17% on an Intel Cascade Lake system.
> >>
> >> We run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a C
> >> application that measures average syscall latency from getpid()
> >> running 100 million rounds.
> >>
> >> Between each perf run, we reboot the system and waits until the last
> >> minute load is less than 1.0.
> >>
> >> We boot the kernel, v6.6-rc4, with "mitigations=3Doff", in order to
> >> amplify the changes in the audit system.
> >>
> >> Let the base kernel be v6.6-rc4 with booted with "audit=3D1" and
> >> "mitigations=3Doff" and with the commit "audit: Vary struct audit_entr=
y
> >> alignment" on an Intel Cascade Lake system. The following three
> >> metrics are reported, nanoseconds per syscall, L1D misses per syscall,
> >> and finally Intructions Per Cycle, ipc.
> >>
> >> Base vs. base + this commit gives:
> >>
> >> ns per call:
> >>  min avg max   pstdev
> >> - 203 203 209 0.954149
> >> + 173 173 178 0.884534
> >>
> >> L1d misses per syscall:
> >>     min    avg    max   pstdev
> >> -  0.012  0.103  0.817 0.238352
> >> +  0.010  0.209  1.235 0.399416
> >>
> >> ipc:
> >>    min    avg    max   pstdev
> >> - 2.320  2.329  2.330 0.003000
> >> + 2.430  2.436  2.440 0.004899
> >>
> >> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >> ---
> >> kernel/auditsc.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >> index 6f0d6fb6523fa..84d0dfe75a4ac 100644
> >> --- a/kernel/auditsc.c
> >> +++ b/kernel/auditsc.c
> >> @@ -822,6 +822,7 @@ static int audit_in_mask(const struct audit_krule =
*rule, unsigned long val)
> >>  * parameter can be NULL, but all others must be specified.
> >>  * Returns 1/true if the filter finds a match, 0/false if none are fou=
nd.
> >>  */
> >> +#pragma GCC optimize("unswitch-loops", "align-loops=3D16", "align-jum=
ps=3D16")
> >
> > The kernel doesn't really make use of #pragma optimization statements
> > like this, at least not in any of the core areas, and I'm not
> > interested in being the first to do so.  I appreciate the time and
> > effort that you have spent profiling the audit subsystem, but this
> > isn't a patch I can accept at this point in time, I'm sorry.
>
> Fair enough. Will a function attribute aka:
>
> __attribute__((optimize("foo=3Dbar")))
>
> be acceptable for you?

Unless you can show me widespread acceptance of these types of
optimizations in core kernel code, my answer is no.  I'm sorry.

--=20
paul-moore.com
