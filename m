Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AA3D0A2
	for <audit@vger.kernel.org>; Tue, 19 Dec 2023 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KnpfvCuO"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2707053276.2
        for <audit@vger.kernel.org>; Tue, 19 Dec 2023 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703021276; x=1703626076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSVJTKtt7cUDtmapWu82OADs+r94NHFm98C3dCfQjr0=;
        b=KnpfvCuOEhflTtOC6omJ3L8og5rwAGsb/fpSh+GGuIqc5FDaoHMFndY8Ovst8ifMiW
         OA+IydNSiId0h/qOAs0w3A2xCe2OH3nfdbU7jyepKvX7ynf1Xf7flRwlgcw3EW7fjXaw
         jWi1xatWNN79cFAN86hgxLDtqjzrS3C7+fE9yyWOi5QHbk17RcEQZo80gwwO9w+r/GeC
         lNqJo5HIaK+3B4E/6m7XLylEhLJ5iP0xJc8geD+bpep4ftoHfMWXzwNYGYxEiHqpH6YJ
         AIsfLam2AiYEP1Hk9i/BfSH3g+PIqwAJnifCvXrQwsL0t756kMT/fCLtRUhJUrIVQUBJ
         kjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703021276; x=1703626076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSVJTKtt7cUDtmapWu82OADs+r94NHFm98C3dCfQjr0=;
        b=oD2Wl0gZgylRXcGqabuoq45I2A44w42hMyjL56LlsG7NuQ2at2slL7lsjkBxF/C/Gy
         PrKY8urNZ7/dJ25HSFrXvcqBm42qCHDN+5jtZlOsHRCU5VyPMkj3f5vVPQ97NeP8/NKg
         CKzZ/dI2pgwHJYYCJnD2hrGIn7p0rpPXDIA5NWK8tqcZ6PC89uWUCmFFqDDe4XvGtRQ/
         izhnsGmIJv5ljmHVg9hCBHycbqw5KOTBLxyeAUqXP37zFbfsrCxwgvOjaqJO10VLs8e/
         1QTbsl9V9NwZV7ED6kIRpmWe0aUtt/geWDv3+vnTuFVgzn800Z65C5uC0wPJf4wK9qaG
         AYpQ==
X-Gm-Message-State: AOJu0YwA8e4jL8/tOn7AkZ461eANdRNAaY38La/tEzPjrw9x3AVx472r
	TC+NIUYx5qrdJPUg/MUZvcLjneK9Ky3mBVVXbtR8
X-Google-Smtp-Source: AGHT+IGBj32/lPqds80bP159e1sh/2uAxSG3lj2fGK8h7U+dmfgjzOJjHavGlz7lIGkucGyQoV5rxyk09jxN8MXhJu0=
X-Received: by 2002:a5b:f81:0:b0:db5:4dc9:1ac5 with SMTP id
 q1-20020a5b0f81000000b00db54dc91ac5mr7938987ybh.45.1703021276101; Tue, 19 Dec
 2023 13:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
 <20231212102857.803984-2-haakon.bugge@oracle.com> <CAHC9VhQGFP81T1sbJVYPuLfpfei9Wk6SzgnWYwHcsCmiwSX-yg@mail.gmail.com>
 <738EAB12-E8FF-49E9-BD92-4E3630AFDB17@oracle.com> <CAHC9VhSZ6cZ32f5z_aLkpSbSnpeFe53+NHNXfjyJzpOZ3x7mFw@mail.gmail.com>
 <874jgdkijx.fsf@oracle.com>
In-Reply-To: <874jgdkijx.fsf@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 16:27:45 -0500
Message-ID: <CAHC9VhSsaRbXDo945SOAhCC-f7r=8QOdhXRzLZmhvnCCs8mqOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: Vary struct audit_entry alignment
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Eric Paris <eparis@redhat.com>, 
	"audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:07=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Sat, Dec 16, 2023 at 11:25=E2=80=AFAM Haakon Bugge <haakon.bugge@ora=
cle.com> wrote:
> >> > On 14 Dec 2023, at 00:54, Paul Moore <paul@paul-moore.com> wrote:
> >> >
> >> > Two things:
> >> >
> >> > 1. If we are going to create a kmem_cache pool we shouldn't create i=
t
> >> > here, it should be in its own audit_filter_init() function which is
> >> > called from audit_init().
> >>
> >> Understood. Will fix.
> >>
> >> > 2. I'm not sure it makes a lot of sense to create a kmem_cache pool
> >> > for audit filter entries, especially given the modest performance
> >> > gains.  Is there not some way to request cacheline alignment with
> >> > kmalloc() or similar?
> >>
> >> The problem with today's kzmalloc() is lack of entropy on the lower or=
der address bits, because the audit filter entries are aligned on a 512B bo=
undary. IOW, they are too much aligned. The increased entropy is exactly wh=
at we get from using a kmem_cache which yields more L1D cache sets to be us=
ed.
> >>
> >> Although the performance gain is modest, the reduction in L1D cache mi=
sses is substantial and that will improve performance on most archs that em=
ploy a virtually indexed L1D cache. And, this commit acts as a prerequisite=
 to avoid high variability in performance gain from the second commit in th=
is series.
> >
> > My hesitation of using a kmem_cache object here remains, given the
> > relatively limited and static filter rule configuration I would rather
> > use a k*malloc() based approach.
>
> AFAICT, kmalloc() etc only allows fixed alignment. From
> Documentation/core-api/memory-allocation.rst:
>
>   The address of a chunk allocated with `kmalloc` is aligned to at least
>   ARCH_KMALLOC_MINALIGN bytes.  For sizes which are a power of two, the
>   alignment is also guaranteed to be at least the respective size.
>
> I had sent out a patch a while ago reducing the cost of the same
> alignment issue. For me the most pernicious part was the fact that
> syscall latency was good or poor based on how boot time factors
> affected audit allocations.
>
> So while I do agree with your hesitation on kmem_cache not being quite
> the right interface for what are static allocations, I think it might
> be worth it given the cost.

Once again, I appreciate the time and effort that you have put into
this patchset, but it is not something I want to accept at this point
in time.

--=20
paul-moore.com
