Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946224A049
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728009; cv=none; b=KZT+63mdNyyeYA4cd8/iGGPoQyKoaQ+uMFFrP+HPobmIIHXDBP/YgT4iauixjKVt2flINDRcDJ0uthWhAmlAPHgEj8X3ZukKAgEt+6RhFpTT3ECslCMELDhVehWlfzj8obyiwoAMkg0uevxmMpoSaBrqTIXyAVHAngXGczX/IJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728009; c=relaxed/simple;
	bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhwD0DtDWWRkq9++coicXHj7qbWJ7mY10kURkfCdhiv4DN6xk1PrKUzPJt75l4oS3gj2xnc2yCxNagPWk+ZYBJ12jOY0nEDci8hnqSa3RxmW4rp/hcrXhpJRbQKL7yjGlcm13AJHPl5lpl8GB0039znHhYe+1s0gDEy9pb7uZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm/ZXnqL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm/ZXnqL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso1677403a12.0
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762728005; x=1763332805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
        b=hm/ZXnqLeWIkLRXqpmqqqjAVkNtWvpAoYc4xya6uI0mJrk2a7gM9QAerILpH6Mu6Li
         dOxlReETQNYnRRfRwXVpcVvRq1hi8WfKyi4ny4mrkxpqwLcX3qEZQbdkTj6RSASb5lao
         fCc/aDC8H0owkjusWW4nDlpBl2nyvw2IQBvC1+5mZ4b+0ifon9Nx6CPpxJ3JtHK79Tsq
         jHjWzP2ppXQC6g1b2kUDW55NuOu5fHsTcnrsnJ7yjC4rsioE8r7Wye+GXj7ChtrpFbO9
         7inDbkRVthpXWyZqk3ySGO9dDL3F0/j/MTmpFLsQwoWWv29LCg9znLefrV88a2kaTcCr
         jEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728005; x=1763332805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
        b=UUk+8g79uZzIHMmbitb2ZBt0RBv3JyvUyS0z8cbAISFC/qmWX+tFeV3HVQxm+aKtuu
         RnD0wYk5ht4PxwMCFwCEbiYIaSBwEeoOF/mpl7hC53NP9jUN/QDiKgpe/8jlQI5OkMDz
         +QNnTnS37RCamACrox2ijFkgtMEjB9RfL/OYjBAAXCNiHP5CfDgXexCspLrrCbCungok
         M+KDwaBrolFuY01gBhb/kZKz5PcPOTL2dj8YrrjuDPD4IKBmr6OBo+yrv8gB4NY8Plmv
         QCNyIz4tZVamF9d4gFlHYEJSkJ7t5YZ9Fz0PpcxLGdhJdpxM3kR4a1c7VXYM7OhB8Upv
         qiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf1RWrFrO0hcwU6quzKRVGwCq7W0mtjMGvLBKhbQNLiWrTo7KWVvGg4SvpDfQooa91ZowozA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKbfvZq8f5izUsPHBlLWoa9d1GcCeTUfWe4XyJHaqDU+wYn24
	RiZl9bG3x4NiVGQiede5+6LBrkybO1xninb1seAmxukqN9Stv33OLIUo1wA49HpIPocNSMIyOKy
	QH8ABLByiJRQeaiflHA6S9Gs2Y3rnRcc=
X-Gm-Gg: ASbGncs8JI6k3aL0Vm2770lI9rz25n3lqots6c1p1vUfNRC0p8zne5PvR0LCqX6oHpZ
	uopvS/LdC7/odDUfUBFGe/MzyQ9J2CDHi8gXNHMOyb2sa6GHrsU/S/H4Mcn8BRBWqcrTdfDhZOf
	m33lVFr0YCCf6KYUMALtt5vUO6Tjz8jwRozkcDvdCjCCeiioktoDglWdXwX8sbm2dz71RG6eWho
	1DLMj/pOa285MKZc22I7IBRWvMPVxEB1UZIqAayKwvQlNQWi3XD3zP/6RBq8tc34Obhj/KaDM8t
	idKIPMbdJFTjYXY=
X-Google-Smtp-Source: AGHT+IEf2G3FM0i2bVmOUG7+vPY37y6f5todMu8F9N/qNHio4HbRPNWL68hqLfVk+zbwZK2GIQZm3Q4XqlDpU7RXT50=
X-Received: by 2002:a17:907:60d6:b0:b6d:545e:44f6 with SMTP id
 a640c23a62f3a-b72d0954176mr884727066b.12.1762728005401; Sun, 09 Nov 2025
 14:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com> <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
In-Reply-To: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 23:39:53 +0100
X-Gm-Features: AWmQ_bm4fdxC6v1rOIJ15dLgNbIpqHp2QfAR172JK6y5Y6KlspYKYyOefkgBoCA
Message-ID: <CAGudoHHMgY0NnN0FX_OQnV578Wu1e03VjO8+3tUA8XDxwy_Smg@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:33=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Sun, Nov 9, 2025 at 11:29=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > You would need 256 bytes to cover almost all of this.
> >
> > Why would you care to cover all of that?
> >
> > Your very numbers show that 128 bytes covers 97+% of all cases (and
> > 160 bytes is at 99.8%)
> >
> > The other cases need to be *correct*, of course, but not necessarily
> > optimized for.
> >
> > If we can do 97% of all filenames with a simple on-stack allocation,
> > that would be a huge win.
> >
> > (In fact, 64 bytes covers 90% of the cases according to your numbers).
> >
>
> The programs which pass in these "too long" names just keep doing it,
> meaning with a stack-based scheme which forces an extra SMAP trip
> means they are permanently shafted. It's not that only a small % of
> their lookups is penalized.
>
> However, now that I wrote, I figured one could create a trivial
> heuristic: if a given process had too many long names in a row, switch
> to go directly to kmem going forward? Reset the flag on exec.

Geez, that was rather poorly stated. Let me try again:

1. The programs which pass long names just keep doing for majority of
their lookups, meaning the extra overhead from failing to fit on the
stack will be there for most of their syscalls.

2. I noted a heuristic could be added to detect these wankers and go
straight to kmem in their case. One trivial idea is to bump a counter
task_struct for every long name and dec for every short name, keep it
bounded. If it goes past a threshold for long names, skip stack
allocs. Then indeed a smaller on-stack buffer would be a great win
overall.
