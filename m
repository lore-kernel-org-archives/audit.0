Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0024169D
	for <audit@vger.kernel.org>; Sat, 29 Nov 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437670; cv=none; b=TFNqN0cPApp/1WWX6ePsMf5yYRbSRe5s41AxJXrMg4BH/DSnoxQ8gGcalySG9H66zqfdAe67TTQxgeXs5H0gn01Zln5xGtOTjeRE8mO5OjawUghSI/xe0OhIpcsxQko47dJJsUqvsBoomhoA/hNtsAwdzfduxng+Kt9S1Xc1Q/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437670; c=relaxed/simple;
	bh=FuHIwQlAP2udp8Fj5L14YtvfrFs0p8IftgEhMCUlArQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovuaksTfukhitvjwFKBPeEPAe7NTiRCSt5Ck961Nv0IOmMOfJIEv2HbgeHaM1pR+ZkHrYkCUZN+PLC4ojgZmusFFFxxdJksj/nBD/vX41npQFVOF8EMCRHLQlxy4IJhgoc6OBr3mxYEPVv26HYCN8P7MY1uU5GFk7xtXyBdoc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7GWnThM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7GWnThM"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so283342066b.3
        for <audit@vger.kernel.org>; Sat, 29 Nov 2025 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764437667; x=1765042467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maDmEz6leEp8x7U+/M22lqhF5pJqnpo6KdJXDX8pL/c=;
        b=f7GWnThMerd/210BpPKT/PTJz1Uk07X5X4RB3uqT6Ef+Ni40xKVDXIaVxvUyILd52K
         h/WCWZuGQDWwWq4oJcrQX+6atPBJiu9k4RkqJbYpl4GWyMvqYbEqN6vsTLPo71pGUBRn
         kZDY29UmpGagMC4e1bzyc3RWuFv39znzA/XcKzKnXcpt3aB8rhNQ5r9YszFDqVVi4nDE
         qIgIRiM5W7kY64cZIjeN3GPkZRAXxR8T+2HLsllLiZAOPVsgfitfXFpxpdMTxxvAn8Z7
         ERcVcxmiUQJAh2xLfzibkZHIsZuYIIrCBun44ON1/Fx7e2irVAR3BhVZKwykrRonw6R3
         9XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764437667; x=1765042467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maDmEz6leEp8x7U+/M22lqhF5pJqnpo6KdJXDX8pL/c=;
        b=s3TD9K00MWVcTZ3vG7cON/UCjSJ+DRyOi4Te6rOiZugELoYB4W9LeZWUN7t9TnpDwf
         9MJuQaanzIcy9fU78n/0oX+1FsZn6GT/cFj1SJ3MBXMxVCS8s2gH5ESgvmi96zqSe1mQ
         namVnngKEH6T8JoMDLgCZrWIPtaTEyFZD/CnrxdBzLLrgMyTQOY207Yhn6mSTmSFGD/S
         QvFKLNkJ3FoGb2tDWqurQD9r8lrQEkQcWKOY3kFfSSftkPrFR+DauMMMYrgHgKUCmbfu
         jueNIXn3GD+Hwi8NJ7jrKDmWzMX4qFZfV00ED+KaBacZVxHDkTue98YE+MOFwj+vzb27
         Kpdg==
X-Forwarded-Encrypted: i=1; AJvYcCUeQvjrnkXnTILC9UH6+eh1PVZsnvIK3/9Ye9uEvcGF33sVmQ81odIVrgJ66V9H1ecj7bcj9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZDYZElQvlAf7JF1bu94kCY162cSR6XeDWAgtPl7BXoKP5fU1
	eeQr02A0+oiGGk/3/F6EEjcn4X0+U2CRxL71TuYtdv/iRRXUSPTKx47rmigGxOxrfFu1bZFY5tX
	sDij4U5BOrqskwx+XomrOluQ7OgsI+mYCzH46
X-Gm-Gg: ASbGncudE/JGTClHMzcU3K/IMvYEW1OwkAzT4b/bSGOfkiXz9QYmP2k3e9Hmppzh/o1
	jceNMQLajfp3mF+1V4km4qmzGqDDr2XqSI7ek2gCbD4h254YtxZMklAwD4HbFLb8VDP0DNIVeKy
	mL4Uetki/I4AJ5AOcoCTV9J4Okyl6eqVdItKQRO0L7RDRW6yuq87DrM0N6Ggu07hCFQf8FTXeix
	U4vyB4VlQ/rv9FVrzEsuG9LnYarlCv/J8l4oQbDLWGO8bqJKb+k89C80PJ++vDq9vxYs3SwoKmI
	tyEuWaiySM+zxUw9UoY1QNk7XNoKHSPjprDc
X-Google-Smtp-Source: AGHT+IEH5c/pRAcr4BaNTwk+9mX9y+JuA5kpYcYrpik7c+/rjbm2lZ4NulyqOyXcGRACGwaRbgIWFZkTSqKxtbn7HYE=
X-Received: by 2002:a17:907:97c7:b0:b73:4e86:88ac with SMTP id
 a640c23a62f3a-b767153ee6amr3765863766b.12.1764437666585; Sat, 29 Nov 2025
 09:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-18-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-18-viro@zeniv.linux.org.uk>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 29 Nov 2025 18:34:14 +0100
X-Gm-Features: AWmQ_bkYhg8ZsPoSvIKVjWFzG0z_YCpKLtzShxZuCW-4-gHoAXRd9J8KuVL5peY
Message-ID: <CAGudoHENCNV87W_wngFsfC99xYohQUiXOjeB24VcYTTOQPv5VQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/18] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this was already included by Christian, although with both predicts. I
don't know if the other one fell off by accident.

regardless, this patch needs to get dropped

On Sat, Nov 29, 2025 at 6:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> From: Mateusz Guzik <mjguzik@gmail.com>
>
> 1. we already expect the refcount is 1.
> 2. path creation predicts name =3D=3D iname
>
> I verified this straightens out the asm, no functional changes.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Link: https://patch.msgid.link/20251029134952.658450-1-mjguzik@gmail.com
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 37b13339f046..8530d75fb270 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -285,7 +285,7 @@ void putname(struct filename *name)
>                 return;
>
>         refcnt =3D atomic_read(&name->refcnt);
> -       if (refcnt !=3D 1) {
> +       if (unlikely(refcnt !=3D 1)) {
>                 if (WARN_ON_ONCE(!refcnt))
>                         return;
>
> --
> 2.47.3
>
