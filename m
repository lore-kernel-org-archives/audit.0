Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A023ED63
	for <audit@vger.kernel.org>; Tue, 10 Dec 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858325; cv=none; b=N41jSAxIMNCo6IjHZvfPeS40iAhjVu2ncMBVgtNc4G3m3DQZtg498vL/cSakEsoT4OqYYxQ0rmWPmK0Yzl5DkxSXouOwoEgQG4onFSadQ/06ktlquYs3Sm76cGYuHeDN4yGbLr9zshFNOmgdPuRYahptvW0NrsINdE/yRiFWzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858325; c=relaxed/simple;
	bh=CJFSUicCSEftUaEPCWoKl2JIiTfC9AFeIdCoKbGqNks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqVxTGmwawznNAre6S8hX4gBOzwjtBesE8tVgmuZoahVc/WF1upr5usx4XhwwPipxUYNAaWEuM1HT0pFCIG/BwvUrS2EM4xfaMrqBKJqVdDnPnNln30WfnyDv2NCPrKsc+JIozKsxMpLY+KN2g+gX3j+KtaJunSTR0n6RlIL0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KUzRdJux; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KUzRdJux"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3997835700so4728250276.2
        for <audit@vger.kernel.org>; Tue, 10 Dec 2024 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733858322; x=1734463122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ0dvOqyORHQjfISQJYoMpjke92iFiidvjB87tbcxDc=;
        b=KUzRdJuxSD2p1wPWNlPSpR7dHbnz3ottIXdIYbvfK8NYcz+ED5JM8cLW6NJdXawfhi
         aPFocARVlp5hEDbBN3aUW0D8pzB9Q5v74rbtFYdplKrzIjrzerMa9qd3XYuLRl3xBL0u
         4NabB0jZ9jMvj8tx4OWyV1azHAOMyaI8njTJmlXMiSpsuAJ6S4nnmvbZiPf7TWK2dAHA
         HriK9gmYmsL16+EpdyWBpTilCAVmYT8jXL12TmvBtYjpKPj/1KHukqKruQIz1G0oImKF
         e+4vaUTRYwaJYlrwHLBW3kmbgNsd8Nbooo1aoKoyC51qgM61iT83FF5mshqr17qv81Qm
         LfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858322; x=1734463122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ0dvOqyORHQjfISQJYoMpjke92iFiidvjB87tbcxDc=;
        b=st3/4D1U4psyL79uT08A+C5u7pWzHW8JOQOwE/GO4eMbcYrxqpzJ7fMbolKI7Hw1/r
         V3qvzgFdzIQkt1Ol2/BoF79jYCNH8YFohYM3wOTFVY6Z1VpL2yya7MQ+gQIcGc7doEVU
         qX7vTACdRZ/b9XWX5nipAwL2bvLvsFpYXX93FH6JqhW4xnZPSzhsFw+I/dQG/76/JJUJ
         TrOEWItgdtZURmh/6e3tXGtAtMBRcdlejKPHHDyAurN48fQkhj1AvGjlsEXb36pOetY3
         vLz+zTAbjpCE3i81njzZthe4yueYfokBLOU/SQNcqmf7KiDWxodoe1rueJokFBe2ftGl
         qWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSnHJeoZ/VpRJ/a40TJE8mPupybid/nPXfS7m0hak7oOL5CdBr/kyzV/Vk5jOu7eLpigygVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79Z92ZG+lsf8DrQJ45IBigMael3q/W3fbM7dQpK/AcIcS59/G
	MxT4koxDFXN6S4CaU/+RUPjiRhztgFe0gynzzYa7SRsaNlO33uRu9HbzCBRMk3XEvaJvychWOV9
	Mu8HqF3prUm9wvf6dn6zj2qrauvIpmrGKxazD
X-Gm-Gg: ASbGncthxPlrdtWdZBn/k/SNRTdSUeO1clMzyr9XtSHRyx5L8l88uZuwnWS8mwWevjH
	NGZR3dj5JjN1dIrtUZjY1yaY/JQgK7gQvkA==
X-Google-Smtp-Source: AGHT+IHeifD5JmXkV44yBoBHBDMPFMW8bIr/4bdzGu6KutxSK8Mj9uJ3Jqeb8LMZfBS10mWZbzez3Vbmq3el3ENEZb8=
X-Received: by 2002:a05:6902:310f:b0:e30:cd52:b247 with SMTP id
 3f1490d57ef6-e3c8e615116mr360989276.29.1733858322032; Tue, 10 Dec 2024
 11:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2A30FFFE-973A-4355-87D2-C0F3648E518A@flyingcircus.io>
In-Reply-To: <2A30FFFE-973A-4355-87D2-C0F3648E518A@flyingcircus.io>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Dec 2024 14:18:31 -0500
Message-ID: <CAHC9VhSLKNthep_+Vo8t836WfxxuvDkDXu+NjC5RB+ApHM7QwA@mail.gmail.com>
Subject: Re: Questions regarding TTY input auditing
To: Molly Miller <mm@flyingcircus.io>
Cc: eparis@redhat.com, audit@vger.kernel.org, 
	Christian Theune <ct@flyingcircus.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:38=E2=80=AFAM Molly Miller <mm@flyingcircus.io> wr=
ote:
>
> Hi there,
>
> We're currently taking a look at the TTY input logging functionality of t=
he auditing subsystem and evaluating it for use in our environment, however=
 there are some parts of this which we don't quite understand, and we've ha=
d difficulty answering our questions purely from reading the kernel sources=
.
>
> Primarily, it's not clear to us when the kernel decides to flush the keys=
trokes logged from the TTY into an audit log message which can be read by a=
 userspace process like auditd.

Hi Molly,

You likely want to look for tty_audit_push() callers, that should help
identify where/how the kernel decides to flush the TTY data.  Looking
quickly at an upstream kernel I see the following callers: canonical
mode (as you mentioned), ioctl(TIOCSTI), and the AUDIT_USER_TTY
command/message from userspace.

--
paul-moore.com
