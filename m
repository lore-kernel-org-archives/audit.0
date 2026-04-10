Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BC1990C7
	for <audit@vger.kernel.org>; Fri, 10 Apr 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824732; cv=pass; b=eZyxwdNdwPnCDCxKSASUT+9Vwtxh11GZoeP6M8oAnPfSUZb6eEsnsFwBJG90/yQ8JB41VScmoYYuQRAZRLSO7nJdhayHySBZGN3GCkSN0DPSSPMoYmQVd0nwhrVu7yB/sKgb1ZNORxyPlx/Nd5xRGLoHmw4KgF5GeAfT0SqUxio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824732; c=relaxed/simple;
	bh=Ma/sRkYMCQuPVcijTxIdrQjwIXAGmQpv2IWcMkfcFDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R84ExE5uiBN12DIWTNqwuEZcRgUS/m4KvOmovnZPN3lKfSU/sPrKoP2HogpCEKCLUxlWx1FVBG8P9cTnfC7HTa/S03S/TJFB7qjKCPsyEe7YnpGMn2S8PdP0wEPUSozvKPsSIJmwRlKOOhVMMgpMm432cXskIoUxnF/EzL3eMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NJElyQOs; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NJElyQOs"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38ddc25ce01so17533441fa.0
        for <audit@vger.kernel.org>; Fri, 10 Apr 2026 05:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775824728; cv=none;
        d=google.com; s=arc-20240605;
        b=TlCitMsWmMzT145O0BpXoAf/mx7rLZgjDFdHzYCErB94p3hE0BxaqDw6awrT0AaIT5
         EY6qxrqjqVYY53NlzN9+EPbGHoJheA3sIaVTQrwCetIS9AVOJxM9Hno+/TLqoSrJnOEh
         8mK/XLz+DJER3HH2Nb9akbvJvD5s/k0/fSzozy5mWKWGdPfZB2b/6i3jqyd8e2uRUxHU
         Yr9QoQwZ7aSZuEpWnBj5iFXyHgN47A1OpHbCkSELaHWE4EDaKb9yG7ns2jgxqwsp8C0K
         ELr9/MQPPp6LnuG/oYE0Dj3jaqVq58ZXyq3nweoSN0jRE8/5tKKc/ogH5r711NQ5RmKn
         JKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        fh=FdoJ1iYmudBbchwN1pRTQ+1a4KLzMNtELujRreZDWh4=;
        b=IWO21yinUWkTweRSFoeOwNLiHg/TWfkAlPq3vw+ugOdlG4eg3lKcjHS/TX2EYIPJCA
         uBOKregXuJqtugr2soPwCgDO5UGL4qoO5BBiTBYfry/mnxnadXLW0sGNR/DDzoX3gGC+
         XgEWGTgSZsGiAzevXchTkWFhkQ1MPit8ZXT5Nb+A9oB7/SzQSLtNyXHZno0b3OEOr2g+
         Zw0ga24yiqxv57DKNXeNvBkhb2G5oWyMHywSy+ly3eS3SP5bEv7R3qJIBHGKh9qfO+jP
         JgPcKPQnWfLN+VELViG+iW04OXWUUk7T7Awh3qouwoa+bip1VThwOBrV7npjCe0RZNb5
         hMxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775824728; x=1776429528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        b=NJElyQOsaI/JI3diZf5R2iDvzpHO5Rno/6PrURRFC2ciuTRhm9bOZcJNGBBpAw0k9M
         d0eAumjYDMwleKrFL5sdxcKgXso+cjNXLUSwynZgThWpXyzZPv++49Fm5czUYXeEyDc9
         LvMNr7zF0R7zzNzyGUJai9KFHcd9a8Bt5UsIX/J8VjT9MY1+dFq0G6SAuujGfs262rva
         YRixW4hEowNOvOtduXI8J5ir94hV5OtsEWvdtl3J9Adn5eFhqzSf3/FP4hQCi78572gz
         j5s4CJS0tvrS5Rqj1uyzbE8obUTA2+GzmrvjV3gWlgdhgGbXOyxdD01sBpvqOl89TguQ
         cuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824728; x=1776429528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp6ir6SF08r4VbOW09sDO2S2CoJm0n8b8BiisX6ozuk=;
        b=MZxmwBsxiLrPiWm2G8lqrD7ACse0f0alpvvkaeeIidyi0jL0Eadm7cQ1Bf1+4lvE4b
         Mu15DlBd4DrKvDXCf6xocO9Wa8VxkOzFjBJMQOClqturqKvBAwfL0PCly6JthMFSbe6T
         qRWH5Fs3hqLNRtYcKjiEBgj997GrhFchSmSwutTwFEsc/Y+Ho0Ee1PUMf8XRAV9Fhigz
         qqABB6n/Ws49UCLVz+5EZtHk7GGcxhbSCoouqK3i7MK5mEMaywqw1jS49sK2eLs3xyFm
         5wfkCIONtJsadyX+VD7MwwQQZhRdfksdo5vD4++a3vxbJ1JlXgH5AvQORj6699ExBiew
         17QA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+9qBtPIRbroLJENJhvvClf7PoOl7NInoNg8f3GVNPuzpiiBKMIkesTF/jih4Kcqik+UHkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LME0G0LUSRq7wX4wqS9NbRsT/Fs9z/KtMMCNZw0KUPDJIjK7
	H2ElRYAo1pxkXhH6bCs/CCYYMrDjXzOQ95EFyynCj7yPHFpdWLHpzceLjncqvf3kHS0sgBLf9Km
	918towu4lOIssSbmBnn5NJ9mWgHi+RAx/WczMQrmJPQ==
X-Gm-Gg: AeBDieseW/nG0M8BMuVisTyTQVi7GlR1ON4RCuWawWiXs+dcmOFkPDlMz/TjEBB420E
	CwbJ1vzostNynPszs64C8ccuc5aAoeU4Hhvhe2we+oIYTO0Q6AZlVMsw1/DtxLz+g1QwfHn3FKD
	gBRcxuc0CiBmLrZY8oyDOiloDdGj7xDUZ8fIJbc8u80T3pgjhex40JI5oaUpTJeG3aXyYVC2SGG
	cFHlaBBUiaeUCyNf7HHUePwW4ZpeCNYWYhsYMz8I69Y/oMfwBdFPBFZ2Qq0wHsu14OH2WDtLn8/
	MUcg3MZtSHE5IUKN63Hqdsci+/ob0bx26q4Shw==
X-Received: by 2002:a05:6512:3a90:b0:5a2:beb2:d440 with SMTP id
 2adb3069b0e04-5a3efb2c661mr1403576e87.22.1775824727838; Fri, 10 Apr 2026
 05:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com> <87cy175zrg.fsf@mid.deneb.enyo.de>
In-Reply-To: <87cy175zrg.fsf@mid.deneb.enyo.de>
From: Thorsten Kukuk <kukuk@suse.com>
Date: Fri, 10 Apr 2026 14:38:36 +0200
X-Gm-Features: AQROBzChuygi8NVuGrVHydrC2DeBgFvNeTy5s_fZlvJYC1uL0-6j2KTxJFfKvYw
Message-ID: <CABMvmLuyB1t2WJrDsFS8Jo0Mx19b3zZ-BA0Xe8JaCdJhouZ63w@mail.gmail.com>
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Roman Bakshansky <bakshansky.lists@gmail.com>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org, 
	libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:51=E2=80=AFPM Florian Weimer <fw@deneb.enyo.de> w=
rote:
>
> * Roman Bakshansky:
>
> > The full RFC, including preliminary database schemas and API drafts,
> > is available in the discussion repository:
> >
> >      https://github.com/bakshansky/linux-auth-logs
>
> I don't understand how SQLite (without a daemon) addresses the locking
> issue.  WAL mode still uses fcntl locking.

It doesn't, that's why wtmpdb is using a daemon for this.
With pam_lastlog2, the messages aren't important or reliable enough to
justify the overhead. But if you want, you would need to introduce a
daemon, too.

Regards,
Thorsten

--=20
Thorsten Kukuk, Distinguished Engineer, Future Technologies
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461
Nuernberg, Germany
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich, =
(HRB
36809, AG N=C3=BCrnberg)
