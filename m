Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5996212549
	for <audit@vger.kernel.org>; Wed, 29 Oct 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700175; cv=none; b=ulE2miIV2NFW1eZiqzQmEPWhhj+IkSNU5/l0p8UZ/qhbXcNrCzEPypFAGBUKCTUBCZmoTYT/HHJWQDvvXiJ31r2Ew7nQdFzHls2+VnZilWydwOWojH5wxVABqMhwS62+iB56yjm2ZisG+qGytqt9FzBgNMWM+dhoYxk6phurSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700175; c=relaxed/simple;
	bh=KG6j54Af+fOUx03yW3EYN6fuy7/9pUuXoX8upU5x6JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5kywF0pPDlqeAcsz6LJjexmMo59Jttw9HoFUbSgm3ZdhuF/L8EORh/vLJi03qcyMbw6qXUdO3ethBR3vQcj/XPx/E1RA1eMmu8GT8vsE/aAKBmtzCAdlm06jXp6wTiXqdJuC70386Y6FJbUHQx/qv3CmiH+XstGmaoR3+Dvsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SESV8yLS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SESV8yLS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340299fe579so1860530a91.2
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761700173; x=1762304973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB90dSKX2phgB5A3VJ7k8j5ArCwOgrNo4j2sqeiq7M0=;
        b=SESV8yLS9upvifE92r4f9mo3/61XC+EDSXTaBPm69w/eE5znbT/z8DHH/rNCmuNcEI
         l8m8bRXHLymiITlsdZSbLXgPv1aLiZ1dqlELp/cX5+5e2LJdAmNjT8pTSL3aiMtp/KHz
         xPvWKgcvyusrynN55JJvTemZO3CC9droD58eIWfGX/eNKnsjct4aaMPCD0PpA2BktfvA
         e3bDW/JEdaK0xSKc/yDcIhYo66njR6Ly1bf28BsKkHPCbhB5WgGgNh3SO1XfDf9YFl9Y
         WPupfoloKohDugkYcjEsozh5ieSq9ThHiS+nmyrO6+QDZlHK67nsCbB/2+5sXJ9JL1IQ
         wgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700173; x=1762304973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB90dSKX2phgB5A3VJ7k8j5ArCwOgrNo4j2sqeiq7M0=;
        b=nT82ofhDvRu3kjjvj01TdEo3wFvNRgpRPN6DpB+fHEB1KshfrfbSiqmTag0t/wf81B
         qmeSu03O8V8yQo9iZK+wZKy5q0H7ypUQVEjZtAhh4p41PnCt6InkyTnAbCp1WzcohvLv
         4jmxabMgojgyNMGtHYMfAo67Ej9rr9cR+PdvHnHpzpGQOJo6Ehbe3Ql30z0A7dOz88fA
         ZPsqQx8iJQXCDcG3OolNpVgQUejrKoQSh5L1Ff7Cfdz5L7CgtVxnDRLnpv4294WCYmfQ
         2NH1hYJSeF+rccvXhsNoUg/8wQSm5BsqxhBmGcpyDRKq1Z/0+owZsZ68TGq2azti8FnI
         LlGA==
X-Forwarded-Encrypted: i=1; AJvYcCWuiXGXIoUhLx5qLXeQkr2gDqc8LZoNCrRaMsqpubZuaM8+SGAzyf4WPq75kdzq36K7Vht63g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02tokURdsx2gK86YYhcqkV0x0CMFtdh4M7OY+zIjhmHn45lhJ
	3H7IXQX7c9LWR246oweKaUSGGuod/U5VIquptLHlWgLbU32B0Hcq5hX3Ip/VgmtaCoTHYwgtys0
	W5bBS34qj+D0XhWGVDgkGmJ83QuG6dNZofYeok0TVtBfwgHsFATwJ6Q==
X-Gm-Gg: ASbGncuhQvg2t8GA7SloyXttpVBcAeZlbQDsjfIAyVr0ySiA6c7Hspudr2k7fG/I5jm
	QorKXXNMPrd7Ol+yzie4DKN6JuPNiif9yEI/xBCabdoIDMxOAp2OACeVX/8K9qn4q1hdLvB9e8I
	11ia68O/nazWgjR4dRtfcH7EPM5bfBnlU9OHuM/qKo2Ff1RO+wWEII5i3xZzxUVlQD5kQdyw3sj
	sSs8pi30hL9c2tVSRNRmqAMe+has1AULCQKEZwWKkJ4esNdclGNvR/3xcoR
X-Google-Smtp-Source: AGHT+IG3UH+5oREGcodXi0zy45xRS2naoRS8wH1rpaPJG/KBPEw6R3NX+2bL2DECCTWYToSOfOnz+dVwvq/wY2132Ko=
X-Received: by 2002:a17:90b:5242:b0:33f:ebdd:9961 with SMTP id
 98e67ed59e1d1-3403a2a8d01mr1014438a91.28.1761700172872; Tue, 28 Oct 2025
 18:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com>
In-Reply-To: <20251029005448.495880-1-isaacmanjarres@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 21:09:18 -0400
X-Gm-Features: AWmQ_bm5ZHgEwlmM5TfpwFYrr3DksCKslhijR9-fsp-t8LwLGiQyfpJPr1yXQeA
Message-ID: <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> When logging the path associated with a denial, the path is scanned
> to ensure that it does not contain control characters, unprintable
> characters, double quote marks, or spaces. If it does, the hexadecimal
> representation of the path is emitted.
>
> This can make debugging difficult in scenarios where the file name that
> was given to the file does not contain any of those characters,
> but the hexadecimal representation of the path is still emitted when a
> denial occurs because the file is unlinked.
>
> For example, suppose a memfd is created with the name "MemoryHeapBase".
> Memfds are unlinked, so when a denial related to that memfd is
> encountered, and the the path name for it is obtained via d_path(), the
> name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> space, the audit logic will just print the hexadecimal representation
> instead of the name:
>
> type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=3D0
>
> To improve debuggability of denials related to unlinked files, check
> if the " (deleted)" suffix is detected in a path name and remove it
> if so. This allows the actual filename to be validated and emitted
> if appropriate, making denials easier to read and more actionable:
>
> type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> tclass=3Dmemfd_file permissive=3D0
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  kernel/audit.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

I'd prefer not to add any additional string processing to the audit hot pat=
h.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 26a332ffb1b8..dcfa60e0277d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2184,7 +2184,7 @@ void audit_log_untrustedstring(struct audit_buffer =
*ab, const char *string)
>  void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
>                       const struct path *path)
>  {
> -       char *p, *pathname;
> +       char *p, *pathname, *suffix;
>
>         if (prefix)
>                 audit_log_format(ab, "%s", prefix);
> @@ -2199,8 +2199,20 @@ void audit_log_d_path(struct audit_buffer *ab, con=
st char *prefix,
>         if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
>                 /* FIXME: can we save some information here? */
>                 audit_log_format(ab, "\"<too_long>\"");
> -       } else
> +       } else {
> +               /*
> +                * Terminate the buffer where the " (deleted)" suffix sta=
rts so
> +                * that audit_log_untrustedstring() emits the pathname,
> +                * assuming it doesn't have other control characters or s=
paces.
> +                */
> +               suffix =3D strstr(p, " (deleted)");
> +               /* Ensure the string ends with the " (deleted)" suffix. *=
/
> +               if (suffix &&
> +                   ((p + strlen(p) - strlen(" (deleted)")) =3D=3D suffix=
))
> +                       *suffix =3D '\0';
> +
>                 audit_log_untrustedstring(ab, p);
> +       }
>         kfree(pathname);
>  }
>
> --
> 2.51.1.851.g4ebd6896fd-goog

--=20
paul-moore.com
