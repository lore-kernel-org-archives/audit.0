Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700CCA64
	for <audit@vger.kernel.org>; Wed, 15 Jan 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903217; cv=none; b=fnxOQm9HpV8RKq49EEro60UxcTIYi1ikkHlQ/a/cEgVdfqo35E4GPiZ19WflScPr80p0Hga3U8gjzb2jAf4YZj0UNzrApThaZ3OXnGOA+oVpzqvtWmW3MklaRhWbjukLhXW5olcKvE6h5UVN0iV//f0codd+g7eDRj6k00imq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903217; c=relaxed/simple;
	bh=9j4k5sJ0hIjbU76srPx9ofSroEp7lEzVi+AxKhpaT98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLRf4liu6KDP6vaSsNUbYQ4cK1174zmYO/cGWvzil1ByFjsELm+b2Gh/seUJAsq5AECX45lhaq0qSeG3KokhsawSPjNEU5RwDe1mAAChLSMCTgzZx2AGD+8EMKPsWRgbDzzp4GhTegOH/g62QDAMVPDiVYCV7XUqosFiMSx8hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XkuOuJen; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XkuOuJen"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e573136107bso7754016276.3
        for <audit@vger.kernel.org>; Tue, 14 Jan 2025 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736903214; x=1737508014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ClZ2iN446JwYVGOojANfV5KazntmHYQmtlXKhtMGv0=;
        b=XkuOuJencZdgYPOMdTHwmfA/3q/+mGgwuURoE09cZPBSNkBvY5ClDDd+eaPRoDgHje
         4UU/P34QjsLAUIlPtWEQSRaduLS18Glyggq2Tbx/W12AxHig0igljiX5QA0NBDVGPN/i
         QUwETAcHxthArAhnnSfyj+8RuYloLU1eca6BTqnfcEPVg4nXj75NgcB1zR2tsU7la/EQ
         YP5XYY6IxeK6nXvYxCMW1OuWFvk3cVnNP2EIdvAqCenMjQzPW1wjWw2MdWg+gTsUx+Uk
         J46YZJOg6dwzbpTC+lfP3SR08yKRBR/k9K5mCeqiumQcIp3E/t+wzWS8533jWoVBhM1S
         zmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736903214; x=1737508014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ClZ2iN446JwYVGOojANfV5KazntmHYQmtlXKhtMGv0=;
        b=nWyYsEx40AQrIcyvnz/NXZAdcSM/qJ4zZ5uSBhq36S9ew3A1b/j4SA6EI6vHs5W9eG
         wcGfnJo2Ot9gJmknHCrE20CDU9FX4O9+ZjjwlncWvqPuzmbaHjEd/WBaKkBk6AkB91H5
         4If7z9dnqyil++Cyhq8xsVgTd1WH4Q5JAkKHFkm0DAzqmHD3CfHeE12G/D0I4BbJi+SL
         bP7LVYmnmP8fW+oJBGXMp49+I3LpD8Yv6mu7mKJzcWPf9/7l8fCGz6KcyUHqDfXpPWfJ
         jZXnF0sMSes1T6VxpgSMZL4zXtkZAJw106Jlqc8jL+i7W0kD9A5X9hbEDBw4rCOq4pXa
         jv3A==
X-Forwarded-Encrypted: i=1; AJvYcCXyqOPxB20RsvpKQduB4TJhAyOhWi8hMpvsuF7HJqVVS0DYYpinqJUNxGY9qcc7UUe7dT2M+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0phl6Cj5yVvKkpTzTMfu07bmVNsIM+rnitRvaVpShxPZtSZ8c
	MDYW8Motg42L9eNcMN1l8YVHx1PhHu7efyaT02Ssg2t77QTCMuDlcPscXbLiqQLz+h6lasCFPpr
	upDpoin4gTPvr4Mcm0DGY89srmjfwazzUEesh
X-Gm-Gg: ASbGncvzOSNOUCXGztvtYkBVQXa9qKaZgNpwAC7XPZ5ei6bAQg8zvbObkgQN/x0D81v
	IzpBzOx62ZHwDa2sa4ozOKqqeMoeQbRJltPOo
X-Google-Smtp-Source: AGHT+IFIBU2fl4vT7M3OeM7QqyaCV0tVz9e3rDkB5RqAZJBay3KqrALibV2EnFImg6Urc5XwxsLXtSVFVF1JIFc1rIQ=
X-Received: by 2002:a05:6902:e10:b0:e57:4b14:6fdb with SMTP id
 3f1490d57ef6-e574b14720fmr9646301276.34.1736903214194; Tue, 14 Jan 2025
 17:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2A30FFFE-973A-4355-87D2-C0F3648E518A@flyingcircus.io>
 <CAHC9VhSLKNthep_+Vo8t836WfxxuvDkDXu+NjC5RB+ApHM7QwA@mail.gmail.com> <67CAA6D8-9C8F-4F45-A15B-9D5446521339@flyingcircus.io>
In-Reply-To: <67CAA6D8-9C8F-4F45-A15B-9D5446521339@flyingcircus.io>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jan 2025 20:06:43 -0500
X-Gm-Features: AbW1kvZo6BTLlBbZx5YLtr9UCNotic5A4t-YRPEU1t2lN8j5x03Ghy6WuTK-RQ8
Message-ID: <CAHC9VhT7nNX-n-PHpyJqH=0pEX=sm=LK2MTNtO6uyw6H=x+pCQ@mail.gmail.com>
Subject: Re: Questions regarding TTY input auditing
To: Christian Theune <ct@flyingcircus.io>
Cc: "Molly Miller (mm@flyingcircus.io)" <mm@flyingcircus.io>, eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:16=E2=80=AFAM Christian Theune <ct@flyingcircus.=
io> wrote:
>
> Hi Paul,
>
> > On 10. Dec 2024, at 20:18, Paul Moore <paul@paul-moore.com> wrote:
> >
> > You likely want to look for tty_audit_push() callers, that should help
> > identify where/how the kernel decides to flush the TTY data.  Looking
> > quickly at an upstream kernel I see the following callers: canonical
> > mode (as you mentioned), ioctl(TIOCSTI), and the AUDIT_USER_TTY
> > command/message from userspace.
>
> Thanks for those pointers! We sifted through the code but I still have a =
question in my head:
> do you know (or maybe have another pointer) whether it was an explicit de=
cision to not
> support =E2=80=9C\n=E2=80=9D scanning in the non-canonical mode?
>
> My immediate guess: if this was deliberate then maybe because it would be=
 too much of a performance hit?

I'm sorry, but I don't have a good answer for you, or at least none
beyond speculation. I'm much more of a tty user rather than a seasoned
tty developer :)

While performance *may* be a reason, I suspect modern systems would
have no problem handling even the fastest tty data rates while
scanning for newlines.  I suspect the answer is some combination of
wanting to avoid having to parse user input in the kernel as much as
possible, and the existence of canonical mode, which does appear to be
fairly similar, if not more complex, to what you are describing
(assuming I'm understanding your proposal correctly).

I also worry about what the audit records would look like if a user
were to add a number of escaped newlines to their input stream.
Teaching the kernel about various shell escape sequences, and doing
all of the associated parsing would be far too ugly to support.

> Nevertheless, the current setting of =E2=80=9Cflush on full buffer=E2=80=
=9D is counter-intuitively laggy and seems to hit a very high ratio of logi=
n sessions that never manage to fill the buffer. Attackers can easily hide =
their traces within even =E2=80=9Csmall=E2=80=9D buffers (we=E2=80=99re gue=
ssing it=E2=80=99s a page, so maybe 4k?).

Yes, the tty audit buffer is 4k by default and changing it requires
modifying the kernel source.  I also wonder what odd failures one
might see if the buffer size was to change?

I would expect that an installation that has strict user auditing
requirements would also have other audit filter rules configured to
watch for "interesting" events.  I would also expect some sort of LSM
to be enabled on the system with its own audit events to help identify
potentially malicious behavior.

> If adding support for scanning for =E2=80=9C\n=E2=80=9D for the audit flu=
sh has a general chance of being widely interesting then we=E2=80=99d be wi=
lling to take a stab at it. (We=E2=80=99re not experienced kernel developer=
s but are likely dangerous enough to come up with a patch that might be bro=
ught to ripeness with some shepherding =E2=80=A6)

First off, I want to commend you for offering to work on a patch,
that's excellent!  Unfortunately, for some of the reasons mentioned
above, I suspect we won't have much luck getting a patch like this
accepted upstream.  You are welcome to try (although I do worry about
the escaped newline issue), and I will be happy to help review and
advise as appropriate, but I worry that ultimately it will be
rejected.  Sorry :/

Perhaps an alternate solution would be to either piggyback on an
existing, related commonly used tty ioctl and force an audit tty flush
when that ioctl is triggered.  If a reasonable candidate can't be
found, we could potentially create a new ioctl to force a flush of the
audit tty buffer, but that would require userspace modification to
fully leverage.

--=20
paul-moore.com
