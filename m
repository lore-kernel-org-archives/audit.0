Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD11C84DE
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726729; cv=none; b=e68kW1g5AuHZM7GIiY+dpNjPT8dcm+egagYhtH6mkRW9WrvRvJjS9/sU617KO6GWvRLKbszNtoXNQZL1kyOnXh0RQB41AWbmXogEbf5SKG5nSFi+f8cdkMXQChG14w1JAl6JYwBKdeY4NJqVYMfabyH7fx5rUH2YjLzxQENznDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726729; c=relaxed/simple;
	bh=slULiQ1LSn8YdkuFl/xC8oqHmgXF0LLOx5h8vaRWxRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3P6GyUW/6kmTYCzz/hvu8Fpt78Mm8WYyApoqyxE/6OIp6wbT2tCihs8FPgmHf2HFeMO5KDog9lPJfyGevaZPis6toSFghMJvv3UJGlGPEhIfVUZlE+sQT66x+QirIilAHQLAp25USb7ALDmCit5RXEWkO9057q+4NNhsyeK9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZTc4/BD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZTc4/BD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b72cbc24637so441271966b.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762726726; x=1763331526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9yqoMpO/6oIYxh6F8d/nAhX/lmSSgeTXQGQsqpmEKQ=;
        b=CZTc4/BDF4EvwReUH8D2bdsv7NGLWE+fDuxrCZO5PqmF3NW0qe5eelDUkptzi0hohc
         lb3FsenPhLD3TyhZkXO0RVtBidEn/lBft3Kp2bFiQykRp4geYi/Us4mEutRrF6Wxdbqr
         qkvFccNFonPYvlZ2srQuNXG3wdGfNk4nyfpb0/mwuKlp9shaieJ3S+5XiSNAo8hcs/yP
         jmHQvpGD8i78AFAUlQ26ct64TkG0frpKDNYkX+Gyk9sqalF/0lbu81CHdVyFc+KMCXh9
         HPJhAm6R2xUiPq+K32r0kKSM3gz/k7X3fiL8PIk9qm4v7EMY/0f00MrA5q8/AmOG4rn2
         DO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726726; x=1763331526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9yqoMpO/6oIYxh6F8d/nAhX/lmSSgeTXQGQsqpmEKQ=;
        b=cBQ+VrWnFcIVwY9Wz76JOuMTDpFJc2ZuFnQ/LyxJOJ1E/vKgUNeGpkpI11P+C0CrqW
         4LK6dV5pJY9eSr1xytuIL5tggWG0f6k2nqEy8/C8Zd8ti6DclGTHu+OFkl1WCQwp2uLk
         CImBkX21A6Zr1SHfeT4pm12repv/qCaK/z2LkzAceuu7kW+HPt3GPZy+YMfcMoZFovMr
         Id1vtvQw/RNIE3cv4GxiBbUsN7iuZ451XNoZUz4u/5sHb1lOF1Pnk5q3U86lGYWeLhOe
         bG7x/4Vs5nM5djotLeYdZaC7xApVylq3l0xKHcIu/WZJJru8h8HgFV7KjjO6oeaGHekz
         59xw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+C6M7r+aEovVQ0FegEV7SAFXoGitEryI3wrXLM7mdNctQZl1rYgGgd8zGsdLHf6Un5E7Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuO1KEqL1pYy5A+qltIoexP7m0RIPrEvB5ZshVxKaQ0V8R3pGB
	6lT6GGUQUJTTP33z0qhw2MY3u8PKUwcADM0oSgLZ1CZzv1DijC5QaePb380osatt1F5Xh97t7Hi
	U94s/GUFvB7G//OLradmmUlfc2/d565k=
X-Gm-Gg: ASbGncsUVetctAqOiRDkqisqaVdqCme1xHHmGVUFnfIS4NCk8ZYac5xGZoUzBfTwcwS
	EUNkYi61KWXvs3QGNhMFEozwi4nr06aTIJYvfpybStrrhgu7qCq+4WCAoJv5MSQ7VD8HqO+8M7K
	eYVjsR/KecBf2Zzi/zoYRkAjrIp1ZKEGDuwBucMMtxWrR5egaH1wwAFa5luHI2kuGzEzxl1F7fW
	MMd5zQIHBsMjAg5khTbCu/gGx765BcPV9eEhUMqEb/Za+p3IPhFklOaA1j/MLIgVJZ7m/Djd8Xl
	4ugsGmNZgtC5VNk=
X-Google-Smtp-Source: AGHT+IFf1ZtqJyrB5MOuTg4/YWN68+L2rXBSEutsf5O57w31PlNv4KIPNyR1/rt/eMA363AAdWzsVunYcgFyWawwQQ8=
X-Received: by 2002:a17:907:3f9b:b0:b72:62b2:26a1 with SMTP id
 a640c23a62f3a-b72e0337345mr479536666b.19.1762726725731; Sun, 09 Nov 2025
 14:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com> <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
In-Reply-To: <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 23:18:33 +0100
X-Gm-Features: AWmQ_bldKLq5SKxMLtJgZsZW6GApk3TIsKpzw-Bqk5FLnfMtaX5q0jqoDirdRGQ
Message-ID: <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 9:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 9 Nov 2025 at 11:55, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I looked into this in the past, 64 definitely does not cut it.
>
> We could easily make it be 128 bytes, I just picked 64 at random.
>

I see I neglected to mention, the lengths I had seen were untenable
for a stack-based allocation. Going with a smaller on-stack buf means
having to retry with an extra SMAP trip which probably makes it a
no-go.

While I can't easily redo the survey on Linux, here is a taste from 10
minutes of package building on FreeBSD. A histogram of lengths with a
step of 8, rounded down.

You would need 256 bytes to cover almost all of this. Maybe 192-ish is
a bare minimum where the idea is likely a win? But even then the
people who want 8K stacks probably wont be able to use the feature to
begin with.

dtrace -n 'vfs:namei:lookup:entry { @ =3D
lquantize(strlen(stringof(arg1)), 0, 384, 8); }'

 value  ------------- Distribution ------------- count
             < 0 |                                         0
               0 |@@@@@@@@                                 18105105
               8 |@@@@@@@                                  16360012
              16 |@@@@@@@@@                                21313430
              24 |@@@@@@                                   15000426
              32 |@@@                                      6450202
              40 |@@                                       4209166
              48 |@                                        2533298
              56 |@                                        1611506
              64 |@                                        1203825
              72 |                                         1068207
              80 |                                         877158
              88 |                                         592192
              96 |                                         489958
             104 |                                         709757
             112 |                                         925775
             120 |                                         1041627
             128 |@                                        1315123
             136 |                                         664687
             144 |                                         276673
             152 |                                         150870
             160 |                                         82661
             168 |                                         40630
             176 |                                         26693
             184 |                                         15112
             192 |                                         7276
             200 |                                         5773
             208 |                                         2462
             216 |                                         1679
             224 |                                         1150
             232 |                                         1301
             240 |                                         1652
             248 |                                         659
             256 |                                         464
             264 |                                         0


> > Anyhow, given that the intent is to damage-control allocation cost, I
> > have to point out there is a patchset to replace the current kmem
> > alloc/free code with sheaves for everyone which promises better
> > performance:
>
> Oh, I'm sure sheaves will improve on the allocation path, but it's not
> going to be even remotely near what a simple stack allocation will be.
> Not just from an allocation cost standpoint, but just from D$ density.
>

I completely agree, but per the above the sizes look unwieldy for the
stack. This is something I tried to do years back and backed off due
to that reason.

> That said, I partly like my patch just because the current code in
> getname_flags() is simply disgusting for all those historical reasons.
> So even if we kept the allocation big - and didn't put it on the stack
> - I think actually using a proper 'struct filename' allocation would
> be a good change.
>

I don't know of anyone is fond of the current code. ;)
