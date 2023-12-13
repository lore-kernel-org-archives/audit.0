Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BhrPvPgf"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E7C9
	for <audit@vger.kernel.org>; Wed, 13 Dec 2023 15:45:33 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so7817237276.0
        for <audit@vger.kernel.org>; Wed, 13 Dec 2023 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702511133; x=1703115933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQRPl11FIdqPB7HGtV874kSsRJNwd7G0C7Frj/e1C6I=;
        b=BhrPvPgf5bwq/P6pqHto3aQt881BwYwi7CGg20y+mTEMxj/IpPK+H18bHCeJPVHcDI
         zxmqWq+mvZ6UvUdfer7nE6bmIllZ3kr/J/FRJPGmdXC15t6All2C8c/tD0jZ18eZUEca
         L8Gc2Vz1lecP/0CCEygltLDdP4XecFBYkGru8zGY0Bbd4ODgfEiXiOYAAB3jVRjUEEKB
         u+ZsK96AEvxA/WGgHtgfhay+fmBF6056aeXdeY6E3K9CTQ3qT4zgB2AFFiiCRJkhoEYa
         MekQwO8ovA1RMir8SorEgTklH//HL1zivMZWMFcxPUzU8hjbId7i9gwHF1L3dGz5I9AT
         +udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511133; x=1703115933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQRPl11FIdqPB7HGtV874kSsRJNwd7G0C7Frj/e1C6I=;
        b=Ljdg/Y/xAaDQ5nM4lOWOzeTa60xHbZe7twLEZ18EM5ljDJraGyMWQIymBgZugMifVi
         FA+gIFYdZjVYLdzd8jJl4sBbEJT6VvbSYF8UE0mtxx8w73suEzdB8QqMwd87heQMzLJc
         BcHcDzZdgjCHnTx13Lofvy8fZWqZbONWAqi8nm4b9k30MMR3ad9Ne2iuFt9B+4ZZO+H1
         GOfdGO6M/L9hc7EShfRQTiwvMgyDj3xbOGLY0NExgGLkqavdRpBf56hb3WWJoj0uWMxl
         8q6i5cH9RcGCKz2S7H7P9q/YMpdpHNbhTpweN+xJvCxxdaSgUQua5r1ze1TTtLmfA5iE
         YuUg==
X-Gm-Message-State: AOJu0YzzCabJoFKU9IhiNjMZFQkklzOEYawFwb6Y/3eesFebaiaTuS8e
	bHAi8FWjp7LwcePiDtoZLXXGy/O64WFMBJgAl73D
X-Google-Smtp-Source: AGHT+IGmuYhYyR47v/crSBUSPFB8HjdPO4EXPMTnUPSqgg7VVOL5xccTsgCXKVExpL3yjkQ4YfJeofj9+NRfSv6OQGM=
X-Received: by 2002:a5b:683:0:b0:dbc:c0bf:3484 with SMTP id
 j3-20020a5b0683000000b00dbcc0bf3484mr2271724ybq.96.1702511132793; Wed, 13 Dec
 2023 15:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com> <20231212102857.803984-3-haakon.bugge@oracle.com>
In-Reply-To: <20231212102857.803984-3-haakon.bugge@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Dec 2023 18:45:22 -0500
Message-ID: <CAHC9VhTs7nfz7jEU0Oqv8nq_hTb404KyjHKM5G7T3WA3X3LcDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: Apply codegen optimizations
To: =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	Ankur Arora <ankur.a.arora@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:29=E2=80=AFAM H=C3=A5kon Bugge <haakon.bugge@orac=
le.com> wrote:
>
> For the most time-consuming function, when running a syscall benchmark
> with STIG compliant audit rules:
>
>   Overhead  Command       Shared Object      Symbol
>  .........  ............  .................  ........................
>
>     27.62%  syscall_lat   [kernel.kallsyms]  [k] __audit_filter_op
>
> we apply codegen optimizations, which speeds up the syscall
> performance by around 17% on an Intel Cascade Lake system.
>
> We run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a C
> application that measures average syscall latency from getpid()
> running 100 million rounds.
>
> Between each perf run, we reboot the system and waits until the last
> minute load is less than 1.0.
>
> We boot the kernel, v6.6-rc4, with "mitigations=3Doff", in order to
> amplify the changes in the audit system.
>
> Let the base kernel be v6.6-rc4 with booted with "audit=3D1" and
> "mitigations=3Doff" and with the commit "audit: Vary struct audit_entry
> alignment" on an Intel Cascade Lake system. The following three
> metrics are reported, nanoseconds per syscall, L1D misses per syscall,
> and finally Intructions Per Cycle, ipc.
>
> Base vs. base + this commit gives:
>
> ns per call:
>   min avg max   pstdev
> - 203 203 209 0.954149
> + 173 173 178 0.884534
>
> L1d misses per syscall:
>      min    avg    max   pstdev
> -  0.012  0.103  0.817 0.238352
> +  0.010  0.209  1.235 0.399416
>
> ipc:
>     min    avg    max   pstdev
> - 2.320  2.329  2.330 0.003000
> + 2.430  2.436  2.440 0.004899
>
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523fa..84d0dfe75a4ac 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -822,6 +822,7 @@ static int audit_in_mask(const struct audit_krule *ru=
le, unsigned long val)
>   * parameter can be NULL, but all others must be specified.
>   * Returns 1/true if the filter finds a match, 0/false if none are found=
.
>   */
> +#pragma GCC optimize("unswitch-loops", "align-loops=3D16", "align-jumps=
=3D16")

The kernel doesn't really make use of #pragma optimization statements
like this, at least not in any of the core areas, and I'm not
interested in being the first to do so.  I appreciate the time and
effort that you have spent profiling the audit subsystem, but this
isn't a patch I can accept at this point in time, I'm sorry.

>  static int __audit_filter_op(struct task_struct *tsk,
>                            struct audit_context *ctx,
>                            struct list_head *list,
> @@ -841,6 +842,7 @@ static int __audit_filter_op(struct task_struct *tsk,
>         }
>         return 0;
>  }
> +#pragma GCC reset_options
>
>  /**
>   * audit_filter_uring - apply filters to an io_uring operation
> --
> 2.39.3

--=20
paul-moore.com
