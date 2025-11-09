Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2F2253FC
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727599; cv=none; b=ArJhp0SaMrrYHA1pCw9+kDrZqPm7xjw/qFhwsMsBkAo5ywpVWj1cE9ewZYcr4l2ODqun+PbcZMDz9ZWcv5R4FxAMBB2+/rpAI+66LiDzfTRVKvAH9AzgOcFrTR8WLZV39jZVXbBPIkdrvRqDOhkVXLOxiM2hSwS0tUqG9IlmPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727599; c=relaxed/simple;
	bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esSDm7vXPbz+Sut2/lSte5vA4SUWIWV1DIeqPejoZaykyxGRsIu5jjO5CE9320p+qjuTTvjjrs7mgV8SaUstqGe+rbhGB4PG7AhlguSf5fTujV6A72DBcSobUP5DQ/FOje6BjSvKPF7uCTahhjfHqdG4USxDc6ZFIvxIQfjYFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/hnEK4y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/hnEK4y"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72dad1b713so258017966b.2
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762727596; x=1763332396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
        b=P/hnEK4yAKLnD+L+jif4sTXmW9R7jYg6C4PmC53R5UN2DGLB36Hyr+c0eEeiru3BWb
         MsTNYFyGdaWQuaus6zUkB+bWVWgDkvwmc5RCmAfjjfvNrBimGhFZjEm8Ag4X7TIH4VnB
         fnL00boLQp5BENHNKobIUQTuHkjK6RTfxR5ZdYVlOe81ZYt3U7NyXPzIJK976SvbrTYt
         zdkMG82OspQUM/k+vdkFnp3UpviRMm9hkiIz8dUI5jDZbpR/mj2PihcTLUySNWIeBK8R
         +cSMKPGR1LX2GjTvGDAw2/AQsC0sxyogKLSBxhkIC38LrBdNmMNnWWLuPQ9akgP2Cr90
         CxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762727596; x=1763332396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ik91Thopon6Tumoas6ezzkTtn2KBhQovg72ft8rqYCA=;
        b=GWMGwg6rDY4DD8P542Ijd3OmKCTzbN+5O+oXZF0dGgvgzx/3mm7H56iPd/hHD19R/i
         MBb8KOQAMlLy2Yk6KaGwQhFXtpdwOih9Kqqqae8SKxZS+LQKuvjiRKltFFuz3bKlw3fr
         mTrZoV6Tfbrqf0WlZK0TOxjIKxdAWopCjNuocKjac+iIa9r9MnUQAg5lI4KKIrQUyFw6
         2fhLlGEgaVea14kn9g+Jbzm+xkYEp+XFWHMNJd3A9dZYKJkx1nQg+noPrL/yw9zt/tvS
         bzKc6OV94IDeHL+juLTYjSGTCWtsjVIidiZLT2IgSwqo/N8MzUNUQ251xfSoj3AjAMfw
         K5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVwKaceMYbmZwKhEtGpxJPgBZxd4mhxWqq3UU+HU0Vhu+QCRPFQlm619u7J90X09jrp3ZrBQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYV3UWi2rWpGgbxT5cDPkGspOksxNMg/fw6DsVFe0aOq4QGqp
	8CXeb7q+k2qZwnIUZd5GSVzvZXEV61kEJUco3bF1CQ1JVppKTVWPvpC/3ndqS8El6lz3AX+ETCB
	QgD4pQo2thcRU+1wT00K0tJeVfGYAfGk=
X-Gm-Gg: ASbGncvNR9Vv7SADKLrb+zzHbawVH8AEf+lJheH5vYahB48YrSlbwp5u9km2Jv5gwRd
	Otvq1O9kfsnZYxBfd83EL5jIelUbAcfd02Pjk1LBHHsQd+5kxJAipxnFVbe+P+UpeB1cbQHIQxd
	CAGHxwSBsN6ukrOWLmap/k1wIyo4QXEgtHFnc2H9LVMoxA6kRtRMv4GsihNzx05T7stvIO2BX95
	5VEsmAjdaZrB64hPel0BV45C1LOMyu/lBMyhemf1T3b7Vs4ARKLsJIaYDpoutugrdMTJt2Pd/I6
	6AZab+5BwZG6reFGiD9HADRiqQ==
X-Google-Smtp-Source: AGHT+IGAXuUzCiCr2UlFE5rt4GncenzIFzkwMl5gDlCHYQXhQKZkEvl0yPEuoBu5/WrR+tQ9pqCJjRMiI5J3mz/pJMo=
X-Received: by 2002:a17:907:96ab:b0:b72:588:2976 with SMTP id
 a640c23a62f3a-b72e0623e83mr653813366b.60.1762727595687; Sun, 09 Nov 2025
 14:33:15 -0800 (PST)
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
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com> <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
In-Reply-To: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 23:33:03 +0100
X-Gm-Features: AWmQ_blV-P87rGNnE3ChZYuu4mgdUPexUIHqMqYiR-bIQn__LoTAXByyivBDYrw
Message-ID: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > You would need 256 bytes to cover almost all of this.
>
> Why would you care to cover all of that?
>
> Your very numbers show that 128 bytes covers 97+% of all cases (and
> 160 bytes is at 99.8%)
>
> The other cases need to be *correct*, of course, but not necessarily
> optimized for.
>
> If we can do 97% of all filenames with a simple on-stack allocation,
> that would be a huge win.
>
> (In fact, 64 bytes covers 90% of the cases according to your numbers).
>

The programs which pass in these "too long" names just keep doing it,
meaning with a stack-based scheme which forces an extra SMAP trip
means they are permanently shafted. It's not that only a small % of
their lookups is penalized.

However, now that I wrote, I figured one could create a trivial
heuristic: if a given process had too many long names in a row, switch
to go directly to kmem going forward? Reset the flag on exec.
