Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55D36D4E6
	for <audit@vger.kernel.org>; Sat, 29 Nov 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437619; cv=none; b=FR2BEeIYkowPmzpfMGf4YzT5z1p4ZwCEHi07F3bPof3iRrm5fM+HpfglwBS2RHLqhgiLlrTAjh4mrO3PR/fo+LL5SatkLnQbaiAqV/q9bk2Bv3ZGBO4UZEdWe1uj0zj592cLZSGrZ2aRVHIBhEyi39gZdHvYTjUzUZS4W4FBOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437619; c=relaxed/simple;
	bh=+lgN8J0IowAdNicv/d1NP7IzfMlJS8XCtDt0GRjHDXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd/YXNj2EdRybznU6vg+RBniAxXVwBnwI8eCHUXhjlUB8RfeVOVnG2uPtVOI1MXb8kyHDJtNF5v7RDKevGT+cLByDrb3+ipIrOajN1jzkGnGqyjB1wbU7ZJ6oyilz77XV/m2qhXO9DvS4SK8dKdtmQl7d2p/2k2Xtd4TzLfxoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBIQh5S2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBIQh5S2"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7697e8b01aso567845566b.2
        for <audit@vger.kernel.org>; Sat, 29 Nov 2025 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764437615; x=1765042415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqBHGbcsAsVVRiASRLwDbcSq7PIrgcMaytoi2qLw8ec=;
        b=cBIQh5S22M8W7nQha18KSIsIWPzTRaCbRI5sSO/+y2bwDuwhWZtyqruSKCsYmjmRLJ
         xfQKDzZZrOrZ6UsfwXxs29D5TS7Ob49q50+gUcBMVCuxirPP7vtZhSbOPjr8PdPchbAz
         zQaSH2gLKwAlYhO3VjKuZMCRydvPQlSKEOx+L+bQd9+8ZlYe02yuSvbBxcorQKHuh3ly
         HNHocYoXhoFSxsSSu8DsyggFt3SOTDCSkW5xsvzfiyu0GxIYIcBTKbu5o8gaVOvYUGFB
         cEfv7vGw2Yh2imYaTWPqLTBQiaOHXhPo0k7be8eRTExYYiMQgX3GcQUG//3gsJ8hGKtC
         3rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764437615; x=1765042415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqBHGbcsAsVVRiASRLwDbcSq7PIrgcMaytoi2qLw8ec=;
        b=MBfUqPLtNTTlGEgt40ij8HrGwIL6EY8OXBHv7xQv9uNRuf/kLtItgcui608i+Bg216
         owN0lPw43ACKK6vtH08b70FbEwvZKYNoYR+8qh406AEfkmuUnPPQEv+VG7ffO2Y7gkQW
         6suZGArxQPIPxzgTOdL1jx9IExlkNwAVpjErXoDx3Mr2X1AhHqt3BcT1FhdGysKAd+ae
         5WBdHm2Bukw+uUxL34gJXlm9X+W4Md/y+tatzgzHlI6+zdSOzOFd00Y+VZdGhVWJpFMW
         tFhKkSC1gMW7pZnVDdFOY01SMfXloQOvYgMdlbjywoHamvbVTwr6vgVkIr5zk9Z8LWhZ
         UEyA==
X-Forwarded-Encrypted: i=1; AJvYcCUPIl3cbatLmfoJGcM2fCaB8pQy7wIEFkPza7eAECK6X+XXZPJljRcZUfrpN/pv4d67zdAtDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyg0YyPOBDD8ioCHEd89cwMoyJVKc8HSiG63bryy1kVBZ0jdma
	X3rZ3X7/oEVy+evyk6hB8mgvRXtBm2T6u/zHVtzJTatyinvh7sYhD/uXLAXReilHXVjtIeU1vwQ
	X8fkUwnHzlECvzGc5cf0p+yCDJeGItyc=
X-Gm-Gg: ASbGncu1I7QhWfGXkKHfoGZ+/2Od+rnc8gffQ19fLIsTHdC6t+zv3xLZmUJWsFzSsVz
	cKgfQzmQTd0qMOD0tmbxHtZONch4Cek1rf4af1/wvnxnDeniY7EOWJpIkrE85UTHcf9Dv5muIyg
	ndCPF5rSkRTG3YVLkvlMeHFPmM8uUI54L7zX0CezHlN22yRFun+gmVnP8F5/NuPH8miGuNUMij0
	sHToypOFQFCzPYpRq0nQf9jKOU5WDw+YdqX3k3KrBFKluCYNik0xwfDNYYtHdzwD24RjfdEyyaS
	LJsGX1xY8HjBCNL5t14TWakMVg==
X-Google-Smtp-Source: AGHT+IGCyw0hgpfwbdp3a3E31TdyZ9pXIJL/jdDuy8vbFKa1VPNcT6NEqn4DspaZQIjyW4rDdWr2eMhKOKbCgdYDBbM=
X-Received: by 2002:a17:906:c14b:b0:b73:398c:c595 with SMTP id
 a640c23a62f3a-b767156556amr3928338466b.19.1764437614344; Sat, 29 Nov 2025
 09:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-16-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-16-viro@zeniv.linux.org.uk>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 29 Nov 2025 18:33:22 +0100
X-Gm-Features: AWmQ_blvi087-G2CtHlEiHh6F6ijMslc1kpUveo4D1zCzMmn1FqYhm25LkTHXDE
Message-ID: <CAGudoHFjycOW1ROqsm1_8j47AGawjXC3kVctvWURFvSDvhq2jg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/18] struct filename: saner handling of long names
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 6:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>  void __init filename_init(void)
>  {
> -       names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;
> +       names_cachep =3D kmem_cache_create_usercopy("names_cache", sizeof=
(struct filename), 0,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct fi=
lename, iname),
> +                                               EMBEDDED_NAME_MAX, NULL);
>  }
>
[snip]
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 59c5c67985ab..0b01adcfa425 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2833,11 +2833,13 @@ extern struct kobject *fs_kobj;
>
>  /* fs/open.c */
>  struct audit_names;
> +
> +#define EMBEDDED_NAME_MAX      128
>  struct filename {
>         const char              *name;  /* pointer to actual string */
>         atomic_t                refcnt;
>         struct audit_names      *aname;
> -       const char              iname[];
> +       const char              iname[EMBEDDED_NAME_MAX];
>  };
>  static_assert(offsetof(struct filename, iname) % sizeof(long) =3D=3D 0);
>

This makes sizeof struct filename 152 bytes. At the same time because
of the SLAB_HWCACHE_ALIGN flag, the obj is going to take 192 bytes.

I don't know what would be the nice way to handle this in Linux, but
as is this is just failing to take advantage of memory which is going
to get allocated anyway.

Perhaps the macro could be bumped to 168 and the size checked with a
static assert on 64 bit platforms? Or some magic based on reported
cache line size.
