Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343E34C98C
	for <audit@vger.kernel.org>; Sun, 18 Oct 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=NEkqt8uDjpAs30h4ed2tMQyUpTDpqz897FwLM08FFno7r4b5HsbRRZii/cXNTnSUECRMkB50vNEoNPhUZqoVMDgnk3V0+3uIirNlngVPzpwnkVNRinjTUrwRWiOFxoXfgddbk5Lxg2kd3pdJaQB/oI2m3l5drjBjgY7UoQozNKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so2793661fa.1
        for <audit@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=VtlOEbDYRDQTBWaWmfCgFgx7uzOc7Og+37/ISem74BXaJxqQYulickRc2dkdwYThu2
         zsxrtz5dbh/hZCl/1rHkWkQIYaav1fd19bE7RpvIqWQbGmv+eh7xXoPzQwBP18cNGmSS
         ZUhxK8wh6v2SbFgamXioANIJkfT1j9XW4y643TD+lXM3ZYbuJ68MILv+sojWy4uysTj7
         AdODggayJFHZxfP7t/nKngV/3X6Uh6jgOOw/NLiOGoXk5DlOkeb8k9GlXLUE7vyxfWtn
         VN6n3V6WU6S29sJ0kCQEFmkC3fbkIY2LXabZXsvU6Y+v/jfbQYlVpAOd0y2ACsuT6u0p
         4ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=1SO9jH/a9KoKVYqSwEC9/votoOJQV5DoAVQW7T0211g=;
        b=DYZ0AiqX8+qgCvKKq6QUSEfx7Q0PDZ7PQZnGjBRlTSklpDecafK0AQoENsXe/792VC
         PrvlJLINr3a8qKiou+gj1/4y3fWJHm0dwc4aYmla0tIpGdoMS+5X0REddgqYhYzbuaXs
         AYcGq3Rumy+MwspzFXNU6HZBHABKMOWfLD/F+bUS67xTPpseyfDoG8M1t+60/lhBoXwt
         6e81zCOd9TNXrSP/fThOpU6DP4pu+Gdk65YzDDzGJjgdcJRMdnZHtOc3LzWVzv+iak4w
         gG6qRmio74dR45DH1QVERMrObA5YfFDenUbFMkCX3EXQmLD0qV3CNtc0rB4eR9Fk2cdj
         xyKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=VcA8UxSru2avtJbC+q+rjB7Xpxi3oRs0795udT5Ud8UeLb5hn/4TsFV0crJ2NGz9gJ
         0e3ogoc48IwAO5akP5F9rJY2tfF41pf+roPEC0UIX+LlWHHkQH5C3UuXe9Fgn5Ujb11Y
         mLCOnFOtP+c02HH4k1GBgNnP2k1ymnBAiaFUOlAQAwG7IJUMBEVKTABcL0Zn8uzkFuX3
         HSKd08o3vvoVr2kXK107ju0PFevhS2JJzFcan7dxYjvpoM2Zi4j+YScLKJ/FUkvCXiKD
         Fw2lSnZa4T7DzHYmN8yYt25Rx/IgsEDODu1/JoS3lx99FnHLSVthtXAeOO1PvfRkxkzE
         a2Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwy2GMb8npOMq7V5VXjT9NU8bBPPMSkUYio/KGvUrDEKBw2nhmq+WbzZIDXWVUM52dfrj1PuQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrvvNVCugR0oRxGiN8SUVCzYVSoUINDDZWSy4Ib0CO+qbkXYwO
	QJIK195KdGY5pM1nDPLJ2XPmqK9hlDYg6f0IGP0pK0CWGO2Hd8xmnigM6IleGmlAco0GU6n355Q
	AYLTAYvJc7UNIlCHR8ovKzQixTIcEPHOqVw+WPQQ3
X-Gm-Gg: AYBFou3tu4o+IRYTpTFwEPcACVByXqh8zByIgvSwBl4ZNAiAF2Yl8bpwS9UEw7jgbVX
	lo3QQvHalggoaYVgjKs4d9DahMzdLAmb9TiWPr6LVjEyIBWDUfX/g2w6TZ2/5pat+D41cHGQYvw
	XZ1sA61o2go1atzXvKHtGWJklQ8AWP2zbHpVINARJuKPTtJk+RG2+FX1J/zuKtSpZBGG8x7j+D6
	b5v1ek5z+Ha9u3tJqF2Jazw3dajhEkEayIR4sLcyxz3/DjtTHVTjXeyuWSDx94GSliGAYLsJYOn
	Cxp2nA5/u6gtqDRIDzqwHMe6xKwWx/ogliwrAmTaLNsAbX4DEJem
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
