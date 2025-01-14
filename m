Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951911ACE12
	for <audit@vger.kernel.org>; Tue, 14 Jan 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871887; cv=none; b=M1hIfq8cdkb1K1huUm34BxN/iFcCXw2WTT5XMBe8rIJi2udvOJHe5uOQEzf+gvwBZcqeF7CBm8ROdC/UW9NxIGu/CHhvTaqRSc/7Ja2GCiFc3FSuItEeOULUhQWX6CyTSPHkgKauQdXLG75bkQJA+8yWUeoctVB43Ksl/oezJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871887; c=relaxed/simple;
	bh=+UYUfHn88oY0PMXt/Hd3PIPPspKMBU8SqJVbJQ8ze9U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HNk7pYAI0UdpUTDS2DUiAC9aFSMpL69gQg3aOUoXx7s1V4hIcZC85m5KTHZMXN+bHdA3+DSBYCyAFErIakU5FWA3GEU8qonEsTUGoN/Jaa9C1pLy9Uqn/QxaXuVBRLyamXryxfE8qZl0tZ5avh7EQFmsngpxf7XoHaQJcz9A4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=PEKYWa2S; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="PEKYWa2S"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1736871380;
	bh=QxNma4MGpzjIOiLORca+/HMcr+59jTy8FYwRQqmBhlc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=PEKYWa2S2Hhn/VAZHNKPHSgmaOkwfqcxpE1DPDFNRpFMwjrTFlK2hadTWBNBQsJzV
	 Sk9addsetLeqMtvymvvPwM2hKjVHnVP6lUwuh3q1h+yFRNX3xDt92R8zSweHDd6liB
	 DQjDAWVw05aaEJOxNHwnMytCf204OLFbnkhLMbEk=
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: Questions regarding TTY input auditing
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHC9VhSLKNthep_+Vo8t836WfxxuvDkDXu+NjC5RB+ApHM7QwA@mail.gmail.com>
Date: Tue, 14 Jan 2025 17:15:59 +0100
Cc: "Molly Miller (mm@flyingcircus.io)" <mm@flyingcircus.io>,
 eparis@redhat.com,
 audit@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67CAA6D8-9C8F-4F45-A15B-9D5446521339@flyingcircus.io>
References: <2A30FFFE-973A-4355-87D2-C0F3648E518A@flyingcircus.io>
 <CAHC9VhSLKNthep_+Vo8t836WfxxuvDkDXu+NjC5RB+ApHM7QwA@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>

Hi Paul,

> On 10. Dec 2024, at 20:18, Paul Moore <paul@paul-moore.com> wrote:
>=20
> You likely want to look for tty_audit_push() callers, that should help
> identify where/how the kernel decides to flush the TTY data.  Looking
> quickly at an upstream kernel I see the following callers: canonical
> mode (as you mentioned), ioctl(TIOCSTI), and the AUDIT_USER_TTY
> command/message from userspace.

Thanks for those pointers! We sifted through the code but I still have a =
question in my head:
do you know (or maybe have another pointer) whether it was an explicit =
decision to not
support =E2=80=9C\n=E2=80=9D scanning in the non-canonical mode?

My immediate guess: if this was deliberate then maybe because it would =
be too much of a performance hit?

Nevertheless, the current setting of =E2=80=9Cflush on full buffer=E2=80=9D=
 is counter-intuitively laggy and seems to hit a very high ratio of =
login sessions that never manage to fill the buffer. Attackers can =
easily hide their traces within even =E2=80=9Csmall=E2=80=9D buffers =
(we=E2=80=99re guessing it=E2=80=99s a page, so maybe 4k?).

If adding support for scanning for =E2=80=9C\n=E2=80=9D for the audit =
flush has a general chance of being widely interesting then we=E2=80=99d =
be willing to take a stab at it. (We=E2=80=99re not experienced kernel =
developers but are likely dangerous enough to come up with a patch that =
might be brought to ripeness with some shepherding =E2=80=A6)

Hugs,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

