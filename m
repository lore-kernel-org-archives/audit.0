Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C1524F
	for <audit@vger.kernel.org>; Fri, 22 Dec 2023 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LhRMzko3"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd73ac40ecso1385749276.1
        for <audit@vger.kernel.org>; Thu, 21 Dec 2023 20:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703219499; x=1703824299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2UajPSpn5owkIR8hABl2zqNtuk0YQqcGj3na/KtgyA=;
        b=LhRMzko3mQ0W1Ksic/0gqCFfWNICzY3pnRuYNvmTPbZx3GZzxxPza25ztBhGy46My5
         j4P68KUFXd2P/gT/cyfDQzPLW95KCc8PT5LnNDaNrXpysOwlpkrzMyNni2rbCkY5jxEQ
         5LKtIxQ4CvgTaneFNnkj5B9h6IHY4TDTz12rr8bUFzKIFkUnrH7xP9mDhL3nk5ncpR2G
         1zzhhJ5LH/U+Au7MCDoZ/YF8TXoj0MOeoi9PD3rdvdU4VNKgxBW7Ds0gb4jUMdMmlsto
         zbKtEyykbgULhrbSaI9b6Y/UVkt5fE39AbadUHn7oVLW3RpaNK8noHgXsyXdM0fLL8dP
         zH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219499; x=1703824299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2UajPSpn5owkIR8hABl2zqNtuk0YQqcGj3na/KtgyA=;
        b=eenD2iLdX27Ed/bF8fSkggtIbcxWuM4DPia7YFIKFn49bLpfqdn4L2DJDQqPoQxG4Q
         7dsG+UBNGivjhEN2Z4p4aHDyX/do9K/jw4fdtf6M09fZ91wVCh890yWnxrKxaElKb27I
         cC8a6m3gPSpgH5lMNd5EFdxwRVMHtFjEOBZeDGsX25osB3lVuPerzcdSX5mSK971ktCx
         Tqvpt7sC85vPUG/RQRwh8O2gWMQ5JvV/B4+eZ84knio47TOlE6hrVELJmPzNSIxm1/07
         Tg4tZ8WrJzE08GQAk+zEwvnkbRNQ3FBHSPaMDtuVdtcV7UoAlI0r0ZZcUDHfQKChuJL/
         4Cng==
X-Gm-Message-State: AOJu0Yy3WYqxOx+Pfu/CtrFz2q77XaWI4PB9kNGD4JQapY3z3gsmbYIq
	Lv5stSb75SwvP2lCml8sfWpUK6mRkrAcCf91JjBKDywIOuLx
X-Google-Smtp-Source: AGHT+IET89OaJczxukZDOgWGzWhVnbrs5DhV/nV7XSWssrpAuWKiwyiom/WF5cTKcHHuCPwTXsSOCUOo4GyC2Sht36A=
X-Received: by 2002:a5b:94a:0:b0:dbd:b6e6:65a4 with SMTP id
 x10-20020a5b094a000000b00dbdb6e665a4mr563932ybq.83.1703219498828; Thu, 21 Dec
 2023 20:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-3-haakon.bugge@oracle.com> <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
 <CEB5B23B-7D1D-4C7B-B8A6-CA07239CB5EF@oracle.com> <CAHC9VhRR+WuY6ZG7G6_qFipZyydtFUkju+ZjXyfpKwo_C7CCPg@mail.gmail.com>
 <D2FCA0C0-72EE-4A6A-BE25-1DEC368C1797@oracle.com>
In-Reply-To: <D2FCA0C0-72EE-4A6A-BE25-1DEC368C1797@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Dec 2023 23:31:28 -0500
Message-ID: <CAHC9VhTzyujPxH+o8gwbCHba-n1Eoef9QzCSjqGRBmS7y5hbug@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: Apply codegen optimizations
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 2:05=E2=80=AFPM Haakon Bugge <haakon.bugge@oracle.c=
om> wrote:
> > On 18 Dec 2023, at 23:09, Paul Moore <paul@paul-moore.com> wrote:
> > On Sat, Dec 16, 2023 at 11:28=E2=80=AFAM Haakon Bugge <haakon.bugge@ora=
cle.com> wrote:
> >>> On 14 Dec 2023, at 00:45, Paul Moore <paul@paul-moore.com> wrote:
> >>> On Tue, Dec 12, 2023 at 5:29=E2=80=AFAM H=C3=A5kon Bugge <haakon.bugg=
e@oracle.com> wrote:
> >>>>
> >>>> For the most time-consuming function, when running a syscall benchma=
rk
> >>>> with STIG compliant audit rules:
> >>>>
> >>>> Overhead  Command       Shared Object      Symbol
> >>>> .........  ............  .................  ........................
> >>>>
> >>>>   27.62%  syscall_lat   [kernel.kallsyms]  [k] __audit_filter_op
> >>>>
> >>>> we apply codegen optimizations, which speeds up the syscall
> >>>> performance by around 17% on an Intel Cascade Lake system.
> >>>>
> >>>> We run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a C
> >>>> application that measures average syscall latency from getpid()
> >>>> running 100 million rounds.
> >>>>
> >>>> Between each perf run, we reboot the system and waits until the last
> >>>> minute load is less than 1.0.
> >>>>
> >>>> We boot the kernel, v6.6-rc4, with "mitigations=3Doff", in order to
> >>>> amplify the changes in the audit system.
> >>>>
> >>>> Let the base kernel be v6.6-rc4 with booted with "audit=3D1" and
> >>>> "mitigations=3Doff" and with the commit "audit: Vary struct audit_en=
try
> >>>> alignment" on an Intel Cascade Lake system. The following three
> >>>> metrics are reported, nanoseconds per syscall, L1D misses per syscal=
l,
> >>>> and finally Intructions Per Cycle, ipc.
> >>>>
> >>>> Base vs. base + this commit gives:
> >>>>
> >>>> ns per call:
> >>>> min avg max   pstdev
> >>>> - 203 203 209 0.954149
> >>>> + 173 173 178 0.884534
> >>>>
> >>>> L1d misses per syscall:
> >>>>    min    avg    max   pstdev
> >>>> -  0.012  0.103  0.817 0.238352
> >>>> +  0.010  0.209  1.235 0.399416
> >>>>
> >>>> ipc:
> >>>>   min    avg    max   pstdev
> >>>> - 2.320  2.329  2.330 0.003000
> >>>> + 2.430  2.436  2.440 0.004899
> >>>>
> >>>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >>>> ---
> >>>> kernel/auditsc.c | 2 ++
> >>>> 1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >>>> index 6f0d6fb6523fa..84d0dfe75a4ac 100644
> >>>> --- a/kernel/auditsc.c
> >>>> +++ b/kernel/auditsc.c
> >>>> @@ -822,6 +822,7 @@ static int audit_in_mask(const struct audit_krul=
e *rule, unsigned long val)
> >>>> * parameter can be NULL, but all others must be specified.
> >>>> * Returns 1/true if the filter finds a match, 0/false if none are fo=
und.
> >>>> */
> >>>> +#pragma GCC optimize("unswitch-loops", "align-loops=3D16", "align-j=
umps=3D16")
> >>>
> >>> The kernel doesn't really make use of #pragma optimization statements
> >>> like this, at least not in any of the core areas, and I'm not
> >>> interested in being the first to do so.  I appreciate the time and
> >>> effort that you have spent profiling the audit subsystem, but this
> >>> isn't a patch I can accept at this point in time, I'm sorry.
> >>
> >> Fair enough. Will a function attribute aka:
> >>
> >> __attribute__((optimize("foo=3Dbar")))
> >>
> >> be acceptable for you?
> >
> > Unless you can show me widespread acceptance of these types of
> > optimizations in core kernel code, my answer is no.  I'm sorry.
>
> Hi Paul,
>
> Well, I guess we both know that I cannot show you any "widespread accepta=
nce" of the sort. Here is what I see:
>
> arch/arm/lib/xor-neon.c:#pragma GCC optimize "tree-vectorize"
> (not what you describe as core kernel)
>
> lib/zstd/common/compiler.h:#    define DONT_VECTORIZE __attribute__((opti=
mize("no-tree-vectorize")))
> (core, but not widespread)
>
> Then of course, there are more examples of specific optimizations or disa=
ble thereof in Makefiles:
>
> kernel/debug/kdb/Makefile:clean-files :=3D gen-kdb_cmds.c
> kernel/kcsan/Makefile:CFLAGS_core.o :=3D $(call cc-option,-fno-conserve-s=
tack) \
> kernel/kcsan/Makefile: -fno-stack-protector -DDISABLE_BRANCH_PROFILING
> kernel/kcsan/Makefile:CFLAGS_kcsan_test.o :=3D $(CFLAGS_KCSAN) -fno-omit-=
frame-pointer
> kernel/Makefile:CFLAGS_kcov.o :=3D $(call cc-option, -fno-conserve-stack)=
 -fno-stack-protector
> kernel/Makefile:clean-files :=3D kheaders_data.tar.xz kheaders.md5
> kernel/sched/Makefile:# According to Alan Modra <alan@linuxcare.com.au>, =
the -fno-omit-frame-pointer is
> kernel/sched/Makefile:CFLAGS_core.o :=3D $(PROFILING) -fno-omit-frame-poi=
nter
> kernel/bpf/Makefile:cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -=
fno-gcse
> kernel/entry/Makefile:CFLAGS_REMOVE_common.o =3D -fstack-protector -fstac=
k-protector-strong
> kernel/entry/Makefile:CFLAGS_common.o +=3D -fno-stack-protector
> kernel/rcu/Makefile:KBUILD_CFLAGS +=3D -g -fno-omit-frame-pointer
>
> My view is:
>
> The coding of time critical functions, that access structs, that are allo=
cated by k{m,z}alloc and family, in a short proximity in time, is, with all=
 respect, not a good programming practice, as depicted by the example in th=
is patch series.
>
> I have to accept, that you will not accept this patch series or a v2 ther=
eof.
>
> But, this leaves (210 - 173) =3D 37 nanosecond unnecessary overhead of a =
syscall on the floor.
>
> It should be unnecessary to quote the number of Cascade Lake systems bein=
g deployed, how many of them that run with audit enabled and STIG component=
 rules, to point of the significance of those nanoseconds.
>
> I would be very appreciative if you could come up with a better and more =
acceptable solution, in order to shave off these nanoseconds.

I appreciate and understand your frustration, but sometimes the
subjective quality and maintainability of the code needs to take
precedence, and in my mind the tradeoff for a 37ns win is not
desirable.  Thank you again for your time and effort.

--=20
paul-moore.com
