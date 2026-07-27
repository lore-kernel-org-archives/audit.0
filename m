Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454533BED7D
	for <audit@vger.kernel.org>; Mon, 27 Jul 2026 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183976; cv=pass; b=JgR7ZaE4kEKzRHrsotadGab0HEZQSk+enJZSr6MvaHddOE/jwtq7LVMtK4euv4tcJbq+IBehauIKQKYBtU5Fu/AvRUiIO48F4zX0dleXemOPHsNPiSJRboMH4pb6KV25gYyBXq9WjYRSWpMw4dpY5ufCO3z90njbHh0JmcQLxZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183976; c=relaxed/simple;
	bh=bmZ7Splqe428Ed6w2twGf2tqBK07Fcafg3QCPrFFuTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDVQZLjU2COHS9Nvcb4GkMw+xFl7rcQC3U53FFZVeUOTU+wFGcice5II6TrjcCjQ1QiCitNk2mTWyV+LucHEVuI+r83pm9FglVeyBE03t0EI0O9Nf1l1zgdKeUZqbpyd41HUOFNBxAebibDLDL3zCsCFOCISqhb6FiRYmjAUoFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y4WfQr71; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y4WfQr71"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso35095665ad.2
        for <audit@vger.kernel.org>; Mon, 27 Jul 2026 13:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785183974; cv=none;
        d=google.com; s=arc-20260327;
        b=AEFqYOU2bYGlWm7NSjOjoO0+bfDUCSsikvN8yjo3+Pz94tYwXEWFm1j9cxYrf5Jklq
         di4kJ30yFNUzE7R7u6bIEjo16n9ZnT4w13HLoBSbDyuIyqJaNDgPf0UAb200GtssdY1h
         ji6O3reUSFLLdgVXnXvxZ2reJS72eG3F+P6yqUtzV9Xb+/MyonY/XipghLXZXcTQHxIF
         5jFfZrBdCKmRne1+UI4giFOgK/k8bYzgOzVqNRveVsowZ6DDmk0G3z1t8QWz6CNuRGut
         Jyv/P08uqAyWIbkRVvG1uPdJqNwzz1eMBkamWyy9j+/JsNxqE5LPp56nA8IxA12qzZcv
         u87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qwEgeN2xsQqDXnNiJ+UpDiCmPQQdQcHYJ4NIK17g86g=;
        fh=QBUvzydCXueJShwRyJoac18uuPW74t4ds85BWLuyne0=;
        b=Ca63pxMBa3+0fkRr9QzDODp3TQ67WsQxXMDh/EktjAl5E77W82xAh3DVmRrwbn+xEf
         OQQCzgLmwCpsQ04xsuOygGbLxBsXGKTLFsZ1jsIJna7Hw4OxdN6Yb5oZ519Ssf7Is1Sj
         UBshIkQfi85xEs2rUO1v5DlVj07DErvo7gEHfBEpjioH1Cx5ROAq2T8FmQGJIiMPXf6I
         rM9UQYuf0tkmYtE2fQIauk7rruA5shPOTUElN93PvQ/Y2BYFZ85pY9nyfIp6etEg169v
         r2s/qFq7ei+G15lphXy0Kfq5ceXryOqjx6dSaQxkRzMVTChbfbWCOdiYSTIsjeJ9/rEM
         Yrvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785183974; x=1785788774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwEgeN2xsQqDXnNiJ+UpDiCmPQQdQcHYJ4NIK17g86g=;
        b=Y4WfQr71dKhDKtjH3MhJEl1/ACbGgIr6lgxP358229/jDmNiMCj+QWwkjAmXFdLpc9
         NnYYwzjBT12p5v4s+b/aJOA0DccBcCyd+SMGp1wP8aeDhCtpI2ApprdyOdySBhfpAWXC
         QIoIPwrzlRju4H4xQLANufyHIMD5oAzf8r0qaXu00MdqXim75Ny/zZlYn8QWN6pf9zV2
         EOmnt6Fiuhu63ozizi9ArVwm6a5On5G3tXBPyyhjhxfCSeDNZBGl371yePqdWRaihTQI
         hMmMQhdc6HbHjo+HOSYOkS/WeV1V9zezq3N/YOYg1PbiDqkpOBTWMQP3ckYKcDeIi10W
         QNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183974; x=1785788774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwEgeN2xsQqDXnNiJ+UpDiCmPQQdQcHYJ4NIK17g86g=;
        b=KP11zauralHL5hNqc1posk1Je5Pfi1uQG2sF2aX6/u8DtNVm+OKyk0IxJMvsf7Pwgv
         QK77ftelEbmLVMS3cBBy8iCLrcCHQi4G1Mecz6yv8vw1Isl4x3CQwsul4kyzejSf6TKN
         f3n6LhZn4ToN0AWFd+0/srBAOIQY+Dz1ekXcWj3Dq/AdC+T6NSWxc1cpEak7CzJlS0wo
         vZ8ktuAxD5NwLBEQMydHspd/ejJ08/A78DKxBGFHPC0WaOcjP1rjR+UhArNoRwpKvxKe
         Pw+kSr7aWbi7TVu77aR5UYh1szy6hhCF2BBgenpuVY+OwPDmwnQVvWCqkNO2qln13EU+
         IPvQ==
X-Gm-Message-State: AOJu0YzDZvusu6R3RLgMHF4J2qKGysLaeVsKZsI4jX0/MKE3iL4NHHHZ
	8ciPdnTuaJyTlb5tWPxxoh17cZFHHLKPsGWMnrW1Lq8nfrajjH5B+dJdwrum68HCZUr05rjUUEK
	VnYC5/MEhc8reAQLciaTbbUHmcEY+bHmmUwn9wFCozszNND6BdsAxUvr6
X-Gm-Gg: AR+sD134zew8TphFt7D4IUFg8VH9xtHXAdWRHdNDgqyV7o3Jjlj9GcFfKTFlE6v/XRt
	/1JxJXbcHaUvjFuprPwy/UyNXX4LzMHEzdXve6pmgQwk35YVKJ0nCKCN24+YBBQN7FhWifPy1R8
	lAak1qqHpYTUrYY4CEh4ud/eTGDx1WB3aHGAyPfKcJeFPS98IOJh9jhbg/d/MZOXA5P9Qti+AmG
	ZVOiijx0r3rbzcttdsI+FnjbYWht/hdEzOmvlj9fw1DiocERh10KuR4EqHyDA==
X-Received: by 2002:a17:902:e809:b0:2cc:f4d4:29a7 with SMTP id
 d9443c01a7336-2cfde845a38mr97396785ad.24.1785183974509; Mon, 27 Jul 2026
 13:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT5pLSGx=-QzA5P6xiHgEPmgZfy4eURe8SQR40d6Qt7Mw@mail.gmail.com>
 <CAABTaaCTMPLpgp8J9SaY_uXpy0RGqrt54r=cuxr3DpiKYJnKDg@mail.gmail.com>
In-Reply-To: <CAABTaaCTMPLpgp8J9SaY_uXpy0RGqrt54r=cuxr3DpiKYJnKDg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 16:26:02 -0400
X-Gm-Features: AUfX_mxRU52yKTL-uzAVwSolRguU21T-WyRvcYPjwCklQpNe-Yz-w6S-7n8WFOI
Message-ID: <CAHC9VhQY1=iDVRbJOtQgj77BhOyZLPrWkbf1hSBoF15sj0k-sg@mail.gmail.com>
Subject: Re: Enable sashiko.dev for the audit list?
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 7:33=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Jul 23, 2026 at 7:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Hello all,
> >
> > By now, I suspect everyone reading this knows about the Sashiko.  For
> > those who do not know, Sashiko is an LLM review bot for kernel patches
> > that leverages Chris Mason's LLM prompts to automatically review
> > patches posted to enabled mailing lists and optionally provide an
> > email reply with feedback.  You can get an idea of the type of
> > feedback it provides via the web UI at the URL below:
> >
> >  https://sashiko.dev
> >
> > I'd like to enable Sashiko for the audit@vger mailing list and allow
> > it to send feedback to the list (and only to the list, we could expand
> > it to the submitter later), are there any objections?  Alternatively,
> > we could simply enable Sashiko for the audit list but keep the
> > automated email disabled.  While less convenient, the feedback would
> > still be visible on the web UI.
> >
> > Thoughts?
>
> Hi Paul,
>
> I think it's a good idea. Regarding automated emails, either way would
> work for me.

Okay, I just submitted a Sashiko PR to enable the audit mailing list.
We can revisit this after it has been enabled for a few weeks to see
how we like it, we can always make tweaks to the configuration as well
as Chris Mason's prompts.

https://github.com/sashiko-dev/sashiko/pull/376

--=20
paul-moore.com
