Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gaRmKhar"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691E95
	for <audit@vger.kernel.org>; Wed, 13 Dec 2023 15:55:02 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db3a09e96daso7790715276.3
        for <audit@vger.kernel.org>; Wed, 13 Dec 2023 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702511701; x=1703116501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkBZKS6LAs1F5ONRHXy5kBd/1XvGCXt8RwzfLFFl5pk=;
        b=gaRmKharOPGUJohPkgNiPSARCAT4kqDmWukPOeoUCr2hREtmZR2pxTP2J0mFXq7YPG
         pwFZah2lJEvmAdpklaxcU1cOZNHeINcQ8XibUfhqYZJytXj0Npn6JnagnEnGPiy2/kJn
         A0cO9q8U/rbmafzeC42v0ear8SOPIQSd7bsX5ct8wVr7LTl9fjLEQzQSZTWoUAyqkhgG
         6rpTm8+pv1x2eo+RKOYtfCiScaHy4GohSUYIpGBZpH3FX1GzFxEJAiwE3Oq51/tdsr+Q
         le6gREWnEP7Xb7o1Xsy08+dE4HNkge3fp/HDZWJjSH3L36k3HjOFYIvHSmu8QsQnSI9I
         h/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511701; x=1703116501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkBZKS6LAs1F5ONRHXy5kBd/1XvGCXt8RwzfLFFl5pk=;
        b=WWSmI9ZSf8DVykxCzEVkGrRzjwN0KIdGW40N7MrcpRyXEUeWNglg4bbk+DEjIxJxDB
         Yho3CFKYHzaU6J/DC5G0Ber9sITcjB3Q2/0/rHXSoHrJTkY1cDb43fYoqLI9UIEkOwXB
         s0ZnI6wEk8BCDBuCrLrmalB7J8T6a4sPiwG7Z8Dlk8XjFu/lvq0BjG8fkBm5zv8Ek4T6
         WUcj4gNZOUJ/rbg2AxfpjELakSrZ43QtVY1YfUmCksDFNqBtgrXacvMRjkcZARIxlLCg
         bVhrUWbkLB87yhz5pAgLGiLQeDIP9yEFl+Xwfdnhjy43sZhDZ0oDtGV0vnCCjsAY+ny1
         IBqA==
X-Gm-Message-State: AOJu0Yx7gNXXYeicxZZTaQftOc9i0qo4fjZNA90pNT07dLemFyGEl6xX
	HSsXee0tiF2aBSb9ZyHx0Ez50kUt5AJn9uqzAkQc
X-Google-Smtp-Source: AGHT+IHnswyk6UwpaY99gWWCj9oIQUBFkpLzxTe3fkzBPighlARJ6sSxmjVGtum+Uz48nA3Mcysl0WnzePf3kt3ot0E=
X-Received: by 2002:a25:ab4b:0:b0:dbc:e22c:879 with SMTP id
 u69-20020a25ab4b000000b00dbce22c0879mr351494ybi.77.1702511701464; Wed, 13 Dec
 2023 15:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com> <20231212102857.803984-2-haakon.bugge@oracle.com>
In-Reply-To: <20231212102857.803984-2-haakon.bugge@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Dec 2023 18:54:50 -0500
Message-ID: <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: Vary struct audit_entry alignment
To: =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	Ankur Arora <ankur.a.arora@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:29=E2=80=AFAM H=C3=A5kon Bugge <haakon.bugge@orac=
le.com> wrote:
>
> We allocate struct audit_entry using kzalloc() which aligns the
> structure at its natural boundary and so uses the kmalloc-512
> SLAB.
>
> That means that the lower order 9 bits are equal for these allocations.
> Which on architectures with limited L1D cache-sets width would cause
> conflict misses.
>
> With STIG compliant audit rules, up-to 26 L1D misses per syscall have
> been observed. This, of course, varies from boot to boot.
>
> Fix this by using a kmem_cache aligned at cacheline width, which
> greatly increases the entropy in the lower order VA bits. With this
> fix, we observe a maximum of 0.8 misses per syscall using the same set
> of audit rules.
>
> Testing: run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a
> simple getpid() loop, running 100 million rounds. This test is run 10
> times, with a reboot in between. After each reboot, we wait until
> the last minute load is less than 1.0.
>
> We boot the kernel, v6.6-rc4, with "mitigations=3Doff", in order to
> amplify the changes in the audit system.
>
> Base vs. base + this commit gives:
>
> ns per call:
>   min avg max   pstdev
> - 205 210 227 6.402000
> + 203 203 209 0.954149
>
> L1d misses per syscall:
>     min    avg    max   pstdev
> - 3.147 12.017 26.045 6.568284
> + 0.012  0.103  0.817 0.238352
>
> ipc:
>     min    avg    max   pstdev
> - 2.090  2.259  2.300 0.060075
> + 2.320  2.329  2.330 0.003000
>
> The above metrics are all improved, and the L1D misses per syscall has
> a significant reduction.
>
> Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
>  kernel/auditfilter.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 8317a37dea0bb..b7597a63a3950 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -80,6 +80,7 @@ static void audit_free_lsm_field(struct audit_field *f)
>         }
>  }
>
> +static struct kmem_cache *entry_cache;
>  static inline void audit_free_rule(struct audit_entry *e)
>  {
>         int i;
> @@ -93,7 +94,7 @@ static inline void audit_free_rule(struct audit_entry *=
e)
>                         audit_free_lsm_field(&erule->fields[i]);
>         kfree(erule->fields);
>         kfree(erule->filterkey);
> -       kfree(e);
> +       kmem_cache_free(entry_cache, e);
>  }
>
>  void audit_free_rule_rcu(struct rcu_head *head)
> @@ -108,13 +109,20 @@ static inline struct audit_entry *audit_init_entry(=
u32 field_count)
>         struct audit_entry *entry;
>         struct audit_field *fields;
>
> -       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> +       if (!entry_cache) {
> +               entry_cache =3D kmem_cache_create("audit_entry", sizeof(*=
entry), 0,
> +                                               SLAB_HWCACHE_ALIGN, NULL)=
;
> +               if (!entry_cache)
> +                       return NULL;

Two things:

1. If we are going to create a kmem_cache pool we shouldn't create it
here, it should be in its own audit_filter_init() function which is
called from audit_init().

2. I'm not sure it makes a lot of sense to create a kmem_cache pool
for audit filter entries, especially given the modest performance
gains.  Is there not some way to request cacheline alignment with
kmalloc() or similar?

> +       }
> +
> +       entry =3D kmem_cache_zalloc(entry_cache, GFP_KERNEL);
>         if (unlikely(!entry))
>                 return NULL;
>
>         fields =3D kcalloc(field_count, sizeof(*fields), GFP_KERNEL);
>         if (unlikely(!fields)) {
> -               kfree(entry);
> +               kmem_cache_free(entry_cache, entry);
>                 return NULL;
>         }
>         entry->rule.fields =3D fields;
> --
> 2.39.3

--=20
paul-moore.com
