Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F9EAF1
	for <audit@vger.kernel.org>; Fri, 11 Oct 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610737; cv=none; b=r7lHSOT//OdPC6nBqKlFM3Vsx6u49FPtZKd6TUXin+w4tB4e02BB06CCncZlY+uU662ohlb6NZ17rLk4Yw/A53EUklBK+pc9/Oy9azjmcTpCRVrzKcXi+KdvZqVPH77rJLWHKxVCWfZcPPhuX58PZgogzne7knPVCJKHlJSDows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610737; c=relaxed/simple;
	bh=9tJXSsQ9fSvcpkQGEvBg2L68OGr0KwcdVp0VeMEtExA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl0gyUKt8bcLpSOk5lye/S3WxQWjUx4LeI0r6ThQH/zzTBQiqwMHL39bziFlsMtyVbVVKX2XR+fwUrxrmZ4d/mP5wU+rujd/NkdcJGlfDk5XXCfWaoDdiIpIAYJY9X0tq9w69s4L5EtL01MgV1Yrd+uan9gRJFq327EhQrSJIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JSCg7dbs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JSCg7dbs"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2772f7df9so14594267b3.2
        for <audit@vger.kernel.org>; Thu, 10 Oct 2024 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728610735; x=1729215535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=JSCg7dbsLrzz2Z4F7/4WhtnEh8Ni8l0mm6RCMLDgsI2tctqgNbvd5Gl4acrgKk7mtw
         82HqGBD8uC8gf+svvHOMvucERy7YIRytPO1b14sAaDoCjXK4kgUqOi28GftMSHmvQEVx
         HeflE8bxjuuADOiB8wnDYcwZy3JAC0fwyPj819EBeZBpnFFg3Jmc27yIeaikX7o5o4nD
         3bQLiR7XNRBJSMQXJCaqlt0qCkf/B2R1DcErvCqPFedM2i2JoJf+AWSMNcceyPovU3uZ
         kRLskDTU2vvEdO/MVMdQewQNhlpBXqy7PxkUey+1M9gf1as0jxayQ0CeUPG0U1ypTbA/
         VTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728610735; x=1729215535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=rIgQHBoG1O3zv5kN9kxkEKuvgAZwhHMqS2nICXMUyNV3y3NHiNDWTfMKpm1aBuwASi
         o61KRT5Edg8PGqgCS2A/erNYkZP8HNURRKs/ly/2i1Pu1AK6UWnzuqUSn88j8PLXjNMa
         GBzZX53axJGlogG/DYC5eAJyJCowzjEBnuoKy93ZHN1e9dOnBPbnD7+z91EpaPP7GBP/
         b6CTr1GxsLDl7pyUP6UM8qb8z1qnndf/eovXWVDaZK2aQmN4TLfYxb0rppzbGWoRIdWK
         9+HrlpjcoI00YAkSQolFm/fZ0laMBbB0MkKERV0gg4yOkuPD0oMgJxQS+NJNwY7JKPrz
         GEJg==
X-Forwarded-Encrypted: i=1; AJvYcCX6EQlyzw97VRElst6qVHJ9VQgVAXNyxNAtbW+REWUJi43sN6vX6lQcxyp4w6dXHN21eRmnTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0+hRcVxC7V6uLPN7sWKr52hpE/7oEgIjEnbQu3uHcPs4eYp5
	VPhFbVS/dzipTZbgKTVDfm7B+0UnxmP0lxP95kXxUC3PGk8Sm4pOnY1vt/R7Up6Mv+PqNwbOZFK
	kZzTNleYSwqSk5c51dU+5gsc2tcoXd2qwRNHY
X-Google-Smtp-Source: AGHT+IFvoAiqQTsFIOJfK+l/01uP1b8r2mlIlEpP49rC76iACwSSk+CMcgg9Ira3XeXkyuN2zyckIivG5f2h/gWZomE=
X-Received: by 2002:a05:6902:124f:b0:e29:6b8:af3 with SMTP id
 3f1490d57ef6-e2919df898fmr992944276.44.1728610735214; Thu, 10 Oct 2024
 18:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-2-mic@digikod.net> <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
In-Reply-To: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 21:38:44 -0400
Message-ID: <CAHC9VhSJOWD93H0nPTCdKpbM2dDnq65+JVF1khPmEbX_KhHxsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

It looks like patch 1/7 still needs some revisions, and an ACK from
the NFS/VFS folks, but once that's sorted I can send the patchset up
to Linus marked for stable.

--=20
paul-moore.com
