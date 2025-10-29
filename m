Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A32D839E
	for <audit@vger.kernel.org>; Wed, 29 Oct 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700975; cv=none; b=hYhzAQVQBDf7DZrxfGCIhos6n0EAlbLlqZ+5+qf8YFypqXodYes5Yjolh3sV6pFlSYfFM/p0MncskAxZujuA0zf5q7kIiCkZ17ou9qZHntLCxfsj1ZiK7T53ZkB/SIeZrZSD92M+vYzu912Kly0/OWBKdB7IdG9SlWCX93a0ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700975; c=relaxed/simple;
	bh=rsaJG5G5GdirEwKDjvrHHZERxpQoyUS1q602EMtCKZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huTkQ8mpfmMva+7gZlPXHKenSgwAIkT7cMAro5TGGijBpR0TIDgf1hOovKqdXeCNRniES/sLnyAXJ8yMoezkC1C+dPb/YNteBv8GTPpAvXIAkh2GTXqC5Ka5/HmE0sA93zNt0aDRRBDU55yb7CQLL6/462hdHpXS1nqro0dU1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K40/aHis; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K40/aHis"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ea12242d2eso109151cf.1
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761700973; x=1762305773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJXU/seAFsL4mACUPVLDxeMiP7ShQNJYKccWkDiEgL0=;
        b=K40/aHisIALT/bJrJArF8FyIAQTOSGsuPb+txW08SeAGqTZEe9mJyIblcke43DpwkD
         qGs4DUAx8Oty9NxaHf9b4bBNikVtHXOSAgYCgmCoYPmrVMJVPuuRS6E3g0iBxTzwQ2mm
         LkiC2QAW1jc0VRq94RDHuTGO87uyUlSSAu5ecd+t4ak9jYt2zlvp5Po4FevxEgE6lvo2
         nv3+7xWXyOFlp3bfa3Sonc/qlIPXCtgS5Iq42UxttE1D14zZOBRKnG1fTVPO4EJMcaas
         2DdZ8BWxmquNv+o/anXyu9zLRrNGKJAoN0TS+FDmv2i/CkxhlGxHVL1LCJpQEbPRXh9N
         aaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700973; x=1762305773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJXU/seAFsL4mACUPVLDxeMiP7ShQNJYKccWkDiEgL0=;
        b=VjgoPbB3ehRUF7IaY1x2fjLLTgwTK2w3edDKtYWMjowdxofLADrJ9v4DKsHpAVHMn0
         EIEtLFFAxhZl4EWwmU+UrvON1E7a1tmBzsjkQc8NJmCSDU8YVBcE7G/C6KNCUN3fr6IN
         RZHRP8z0+u+Lwq5hKO3/89Iz+h4N7yirK7tdJNLhxUXUYkcBQpbV5fpVD6H2DEBuFSbb
         /3lOgehpueN4b4v2fdNgNoJ+SAskJpcXNNG982/vHq5vmC0dXkL3AiEtw/T+MkdXepkE
         eCfnIyIoM3fCJ4G9NWnVbxpDJb3RiT+Oab4zjkfZvDZMueslvFE74B5I28KTXzy86H9h
         40ew==
X-Forwarded-Encrypted: i=1; AJvYcCVkCboGB/+WrYIEw9M9ebC24Ug0PsO21lSu7X9fPHtJ15+/X5/lP80emdYkbweoGr/OhMhMYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBOF5SMOYTrmQDEKi2aksO1b+yLAUuza3s1Pbbx4b/dECXGNm
	bEFqLwlWWeI5wLAwTK2XgCWOUIjKscbbfBpbwAiK8vloav5ZYVPLb+LNwDQYwp5vnYqCj2/Zgm2
	pIVEUn2yyDjzKKs/3hLuheP8Ol25Q+FsJ1fxCL7A5
X-Gm-Gg: ASbGncuiMBUspdGT1ukPsvkt9ckaxD9xuLOqdlqnvUjPw5Gqsyt5MH/GFR1cEqvIIEM
	1rGq1kK5UQ12zJQ7ripB86DyIjm8xGJSyXMKIWicqqCVJjzRzFO6m4lVBeaAvoisWvlNdrtJT61
	5trPip5WXtUYwqNqP1Wsi2sW5tErTZ0LV0NISqpM2ngng4XGAb5n6lR12ki5Sff7fNzze5eUJDV
	S92rPgh3ptaMvWybS0cmTezULmoarC6vnXvFLqaWYRPaxS6y3SdF/x/Fbg=
X-Google-Smtp-Source: AGHT+IHK7V7bGcz0b0sGmw21GNrHcXYdY1gAn79xg7vp99JFrGhfcfBXR2vDKXRNfGzHuAPD7elxkQxreFFRRjhl424=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr2292611cf.13.1761700972959; Tue, 28 Oct 2025
 18:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com> <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
From: Isaac Manjarres <isaacmanjarres@google.com>
Date: Tue, 28 Oct 2025 18:22:42 -0700
X-Gm-Features: AWmQ_blUwNjwIC7xRjXcpWEQg6_GFvt3ZzX8vmFZE37J-4-bwe8KZznN-0pMazU
Message-ID: <CABfwK109-4zzBUiQRdNg1re0dQ+dRdau=OXNFhtNsUc6YAEyBA@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
> <isaacmanjarres@google.com> wrote:
> >
> > When logging the path associated with a denial, the path is scanned
> > to ensure that it does not contain control characters, unprintable
> > characters, double quote marks, or spaces. If it does, the hexadecimal
> > representation of the path is emitted.
> >
> > This can make debugging difficult in scenarios where the file name that
> > was given to the file does not contain any of those characters,
> > but the hexadecimal representation of the path is still emitted when a
> > denial occurs because the file is unlinked.
> >
> > For example, suppose a memfd is created with the name "MemoryHeapBase".
> > Memfds are unlinked, so when a denial related to that memfd is
> > encountered, and the the path name for it is obtained via d_path(), the
> > name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> > space, the audit logic will just print the hexadecimal representation
> > instead of the name:
> >
> > type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> > path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> > dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> > tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=
=3D0
> >
> > To improve debuggability of denials related to unlinked files, check
> > if the " (deleted)" suffix is detected in a path name and remove it
> > if so. This allows the actual filename to be validated and emitted
> > if appropriate, making denials easier to read and more actionable:
> >
> > type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> > path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> > scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> > tclass=3Dmemfd_file permissive=3D0
> >
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >  kernel/audit.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
>
> I'd prefer not to add any additional string processing to the audit hot p=
ath.

Hi Paul,

Thank you for taking the time to look through the patch. Would it help
if I could
optimize the logic to scan for the " (deleted)" string from the end of
the string
so that the search is bounded by at most 10 characters? I can also switch t=
o
calling audit_log_n_untrustedstring() instead to avoid another call to strl=
en().

If not, do you have any other suggestions to help make this improvement?

Thanks,
Isaac
