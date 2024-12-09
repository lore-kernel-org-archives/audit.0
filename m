Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF374EA
	for <audit@vger.kernel.org>; Mon,  9 Dec 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737116; cv=none; b=OCfd2xH5waeDcF8z6/rR7AKVkRfn0XAK809Xd1s5vjtoELyovfQT499fPYFcdcsyEn9XwUklBW+sihaVWrNTAaEmQkfIE2uoTrVyRvfVLnRQw+8lcos0uiBRZuInFPms4o0KpbY8gVJBGD/pW/4K5hIaLTS/CYxFSv6u/m7Q6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737116; c=relaxed/simple;
	bh=ZvWQz63WxAcv9PGqFM2YWwOPjhC8i+LdNaZdq78kCS8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=PeFwlc/1j9cLehkeA4AnoM8GEN9iuksXLmjozLrN+nT/BsYZKQGsecDXUzszh13AD4KmPligMSW06WK0mimD4womQdSKDc2WNh/EXirVLhNc3TAWyxAhu/jKWtqtcLfKUBbCNwQonGLq6McP75WZYtiioFSCVSeqYrLKyJVtBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Cx94xN0p; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Cx94xN0p"
From: Molly Miller <mm@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1733737103;
	bh=ZvWQz63WxAcv9PGqFM2YWwOPjhC8i+LdNaZdq78kCS8=;
	h=From:Subject:Date:Cc:To;
	b=Cx94xN0p6/ARy3rfIP0E+riX3J9zjVS9Et89jsnLOKxVbUNVJ8SvJrifW7fk4QOAz
	 MBbrgxvevK6iWPhDInYzqZHb16whrnHc/llZcgFbj9qKYdi8UwTvjDdK9i0QQ02i2a
	 L2Yt1YH8PF6E14203k4ZJzySnTRxTl/oy3pLitq8=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Questions regarding TTY input auditing
Message-Id: <2A30FFFE-973A-4355-87D2-C0F3648E518A@flyingcircus.io>
Date: Mon, 9 Dec 2024 10:38:12 +0100
Cc: audit@vger.kernel.org,
 Christian Theune <ct@flyingcircus.io>
To: paul@paul-moore.com,
 eparis@redhat.com

Hi there,

We're currently taking a look at the TTY input logging functionality of =
the auditing subsystem and evaluating it for use in our environment, =
however there are some parts of this which we don't quite understand, =
and we've had difficulty answering our questions purely from reading the =
kernel sources.

Primarily, it's not clear to us when the kernel decides to flush the =
keystrokes logged from the TTY into an audit log message which can be =
read by a userspace process like auditd. As far as we've established in =
limited testing, the keystrokes read by a given process are only flushed =
when that process exits. =46rom a security perspective this seems =
suboptimal, as this would mean that for cases such as a long-running =
admin shell which runs for several hours the keystrokes would only be =
logged by the auditing subsystem hours after they occurred.

=46rom reading the code we did manage to establish that there's a =
difference in the input handling when the TTY is in canonical mode. In =
this case, the kernel provides limited line editing itself, and the TTY =
input is flushed to the audit logs line by line. In order to do this, =
the kernel has to actively inspect the buffered input keystrokes to find =
where the line feed is. However, most shells implement their own line =
editing and hence don't use canonical mode, which results in the =
behaviour described above. We're not sure why this difference exists -- =
presumably there's a good reason why the kernel doesn't inspect the =
input keystrokes to split the input on line feeds when the TTY is *not* =
in canonical mode.

If you're able to give us some pointers here it would be greatly =
appreciated.

Best wishes,
Molly Miller.

--=20
Molly Miller =C2=B7 mm@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

