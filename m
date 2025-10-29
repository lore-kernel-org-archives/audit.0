Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23E78F59
	for <audit@vger.kernel.org>; Wed, 29 Oct 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704163; cv=none; b=O+2xNqEnzTtZAFCz/GGqemgJ41eZmZyGFTWQrzr4eA7m5Z/ZZnyVSHRTMuwfj4vaR7vw7Zrn9nHclgEUXQaVmRyGnewaTn78aZT4tua6rIfB47eD2loSRdt5pcHv4ehw42SgPf6IsSeilasEeezutrG8w/KjtP7V4zSIVsMJuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704163; c=relaxed/simple;
	bh=ARyRKLgC7kM5VyifivsbzBjR6gWaQK88f59a3fGCDUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk9aG2iI9/8qwRgfACltQbAQWjnBcSdBtutTAJ2OVTYU64pWHTvr9Gxedst5nS8wCGxllNQGCd/atlBIo4yhwKTzD0Pc6lRGsl0YyT8NQ63W6b+PH35pL0ZQ0d++lDE8sry6+Bn3VGbL7waWiAUzlyUIb+ZgIK+VCPaYbyuU+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gFZ45Y6v; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gFZ45Y6v"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5862435a91.0
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761704161; x=1762308961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z4i/cJ7TwXS62lu0Ks328mnczTfLqwKUI5pI9nPizQ=;
        b=gFZ45Y6v/mRgNboJAhrG9nlibg80iyBZI5Vux9ggMKTBadMMNNMOLfyXhy2BJ0SYdJ
         nzq8ula7aM0QUfHgiqgeBDJTFSU8Njf8HbvjbQ2FHBCRYaFFvzHnT++umdEoxCG4t1Ta
         gBSYxl88SoYH8PF6sFnV2lNseNSw3txnpHc/QjwT7xNntStjMdKrr4qSoKw4CC60QhzY
         I4EeyCSKOMqEhRVb5soPBcwm2mDKc3Rhhw34+TGMVB28mHL7QMSk5/xXPIkcisT3JrjC
         APVP23ptF6pAF5laa53MUse2WAC8MPX96zgcGDmkx8IRlAOZE3a3GbuNJ8cwhBbxWQso
         KWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704161; x=1762308961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z4i/cJ7TwXS62lu0Ks328mnczTfLqwKUI5pI9nPizQ=;
        b=uVc80VOuClrJvaNpCfZ7i0/FdMJCoHQF2dPWEo5/Sy5n0i8UtbkFCwR/RGcMvmCAHY
         0cqcDtX38VIMb8gVg9gykR1lWl2iwgZ3aLzYenDDX+Bwr7PYdDfjxP53jL7wDJxFFnV4
         whBwBLgrEPVqSKQ7qsK1UivxEl0EK2+jWnwIkOqmHcFObtUVke2PQVi43g7MNhZ24GoM
         7E7atJNE5CETUezCNxzrU5BR19PuCYLE0WFJ7aV/AZWvlKbvND7kLnBOGEgg/JpWM9TK
         19brGNXqkdrUvFmyk9z5/ZhUg38XWcUNVsycz3bqwKNg97ORQfU4T24UpQ/fjLW2e4TF
         4zMg==
X-Forwarded-Encrypted: i=1; AJvYcCUIdWn5NJdVYoZg3Fo6RuwwpSW3KTrc1CxnqB/IToShyLkq0kx2UwudYmkG9pZLj/Aq9IVF7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMcriSxGrt6KRJS72luhICUEJ/pFw28Cy+0q7D2spnhuL6HGm
	4eVijZNVjZlcecgeP5r45EF2+6nM08OjFJYBtKq5YT1dOjQ7xFhnuAodhTel1YhpkjCY0AqWEs5
	r1R+nU2yV0a9QvI84+YYt1kU7iMt9ZEqMq53XSjYS
X-Gm-Gg: ASbGncv9WJddFZr2FF+c4s1meZ6Ta2iudZDhmMRsB44G5SgMdu/+lTtabkCqXvFWJYh
	A7Pu5zXczLC8owDuYU0G1RPJvqInE/z9fvkaE7simL8wRAnXNGsFXD7JEYRBHqoGBY81cZ2riku
	fU3oRCTREMFCxclBGn9eAdkgsvrC2/LQkgclxtm3Gv1/XRCt2F2tIbPTODP8+WxDY9QyI0c/v0A
	UTLPjW9Ce0cseSb1BFmAPtVpkLHcuULTFZBkmxB/2UU5iz+pJHapKRk8jTs
X-Google-Smtp-Source: AGHT+IFabcSQt9M5y3fDoD8jUgMf2MuJyHJOnxcYAyMVXS602xVGJ3Z8xp1XeyY5yCpZHLL7Cj9naoT5kL+P9mGfQFk=
X-Received: by 2002:a17:90b:3ec4:b0:33b:b020:5968 with SMTP id
 98e67ed59e1d1-3403a2a2304mr1604393a91.21.1761704160714; Tue, 28 Oct 2025
 19:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com>
 <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com> <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
In-Reply-To: <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 22:15:49 -0400
X-Gm-Features: AWmQ_bn2NEgqJH0AOdinubhn7W0GHQ1zBXnZ6Q4GwY2tvpXHzRyHYLGZOuaAuRw
Message-ID: <CAHC9VhTF646GKPVQjS+bvdws2c8DjdR3jRX4Hc-vUjiF-b0mLA@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:22=E2=80=AFPM Isaac Manjarres
<isaacmanjarres@google.com> wrote:
> On Tue, Oct 28, 2025 at 6:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
> > <isaacmanjarres@google.com> wrote:
> > >
> > > When logging the path associated with a denial, the path is scanned
> > > to ensure that it does not contain control characters, unprintable
> > > characters, double quote marks, or spaces. If it does, the hexadecima=
l
> > > representation of the path is emitted.
> > >
> > > This can make debugging difficult in scenarios where the file name th=
at
> > > was given to the file does not contain any of those characters,
> > > but the hexadecimal representation of the path is still emitted when =
a
> > > denial occurs because the file is unlinked.
> > >
> > > For example, suppose a memfd is created with the name "MemoryHeapBase=
".
> > > Memfds are unlinked, so when a denial related to that memfd is
> > > encountered, and the the path name for it is obtained via d_path(), t=
he
> > > name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> > > space, the audit logic will just print the hexadecimal representation
> > > instead of the name:
> > >
> > > type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> > > path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> > > dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> > > tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=
=3D0
> > >
> > > To improve debuggability of denials related to unlinked files, check
> > > if the " (deleted)" suffix is detected in a path name and remove it
> > > if so. This allows the actual filename to be validated and emitted
> > > if appropriate, making denials easier to read and more actionable:
> > >
> > > type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> > > path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> > > scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> > > tclass=3Dmemfd_file permissive=3D0
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > ---
> > >  kernel/audit.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > I'd prefer not to add any additional string processing to the audit hot=
 path.
>
> Hi Paul,
>
> Thank you for taking the time to look through the patch. Would it help
> if I could
> optimize the logic to scan for the " (deleted)" string from the end of
> the string
> so that the search is bounded by at most 10 characters? I can also switch=
 to
> calling audit_log_n_untrustedstring() instead to avoid another call to st=
rlen().
>
> If not, do you have any other suggestions to help make this improvement?

Since we don't know the length of the path string, I'm not sure
starting the search from the end would be a significant improvement as
you would still need to traverse the string to find the end, and then
do the search.  It is possible that searching from the end may be
slower than searching from the front, although as you point out, some
of this work could be reused through the use of
audit_log_n_untrustedstring().

However, we're still doing string processing/searching in a critical
path.  Audit is already suffering from far too much string processing
and I'm *extremely* hesitant to add any more unless there simply is no
other way.  As this is a "nice to have" sort of thing, and not a
critical bug fix, I'd strongly prefer not to do the extra work here.

As far as other suggestions are concerned, nothing comes immediately
to mind, I'm sorry.

--
paul-moore.com
