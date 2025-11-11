Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7686199FB2
	for <audit@vger.kernel.org>; Tue, 11 Nov 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820606; cv=none; b=HwWiR43OGI9dXuq7jIruCpTmNYP77wFioSTD6GW/UwwxA1qCLeSD5+N6MFBpQdRgNMd9S3TR4qWpska4jBcNmnClUUh+t5ZzHtfytGbY2jO/PX9IwOHZpEfjtnpoLHjHKsyeHPeSZyZoF6UV3cT6mAy5sbKQlI58xMCMgk74BMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820606; c=relaxed/simple;
	bh=SY/HFJpytkf+nFpwanwJw1fx9K5HCqkmPfW8bqd6qg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKmShmdlD+4Qmy6niFKf5kcq6bRZcE+a94gDlBsMxSXVDHbwGkAaVkQYecQrb9Pb/v+S5ODRgDYw0VNx3A0vxJT7SObxatTmYQYvDXz7q/sILNfL2NfSo203rZz2Su603QU8NEzxDPRfiy3p6xdcsVD/fEFwv9fhGYXLmlw+FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=POT8RZoV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="POT8RZoV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7af73974a4bso214264b3a.0
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 16:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762820603; x=1763425403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3+9M+5M55tGV3eZYdGtHuJ5xbHqc1TJ5Xfs5N1S3t8=;
        b=POT8RZoVu860iAuf0MhS4qkWDubeYbY2qGXKU0WJ27bIuAT/7zNXiexSend+G/vp4L
         YzVjrs6wLuQBs+DHIHIBnu/5N4gZEcZSEIZoHkMNePzdtftd6OYfp1nUW3FyJhpfBO8q
         TertUfnmUrm9lW1RK91RVdk245zEykfathgrvKYbHNgVB6LHnCtSd8jaimRAQsaAponl
         Rl6S/HHzTrlPfPd/oYYW1QRdhjUVgU4jEGuLi3nt0RPmjPVdJX/UoyvNHAuqy2YwqWaH
         SoZYp/Ffd60TEfuUxK4++NCnndBXJ2u5WCzt03iVAu67a6jBLgXzS8ZZ2x8c5TuwtP17
         nD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820603; x=1763425403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3+9M+5M55tGV3eZYdGtHuJ5xbHqc1TJ5Xfs5N1S3t8=;
        b=Uls56LUzJ5xapW7a094dslieeqbn4omHOG76omIPXfMr4cxOXlVQAzzHfL4UJFWgka
         9oR3iQq4HBYlTabqI9JK6ehZbkc/cmBrxXkk1+OzNLP6KA1nkQW7Nl2x8uXNAjLYIXt7
         UySDq73AQ+qKh6cT50jGEsLWaO0Cd8FJa7CrIsvO2zduoTY/86wye3wCENlE1hr+VUcR
         Sl5wA6/jdRh51UMZ9yMqCD8CKCgEpoNBkfs0DeLjKDoWO1Mt9HYxTCT1S3D7UFEP3qcZ
         +5GckwFqASG8XrJ4zXq8C2uhgGDMRR7dS+Cknkwkg0uAZLLXK9O8440xGw50iVlAOvzd
         oCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtUP+UJGwgVcqb9hXxJGrGkKiO2CkDliDW3ZW0VdmRorCf3a/tnHZ2Zyxf3+GpytaLdFeiwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMqKHfuRDWGfKe1i0mVbFqw7hus2AtwkQAA7w/OndN49n6qFR
	xpXhevtjor+7RiO8C5dDdVM7qJfSUnNUnWCr1q/aBb8kmHc6PqgJyJNd3ay140CsiIJu/BSy73/
	bLRROCx31mXiAMejrFSsrWiuqaSWCl+IX1EZQvN4m
X-Gm-Gg: ASbGncvrrzY4GkG25++BYmEqoMvuulHU/FZkDNUpkpE1/JLnCwgTi1vXTeJGyWLkURL
	tjPKIfZxZzay1AykQDUWJ7pMq0m5nBGaYVhkomg3KtB7hBAD/BHeJQEfjZKahHrTVLAMu2P7Fc4
	2Ppd7t0voSLBcCe/2jNaODR6uk83qtF1VQa6z/5JPahP5znuKjcbCdq6Wx/IhRZORLsRp4/3YNA
	IFffT3uQV+8dZUPfobQ1TtLART71Uvv+NsVLTJsfQmtuRz30Nmdb3tApADE
X-Google-Smtp-Source: AGHT+IGKKFXvoGiwpuj7250U6R+lXP80Kgo4s5yoGQEaNtVEqrSDNucZT1Bw9ABkyZhxSNT9x1CFxaxjgHbtulHgNlg=
X-Received: by 2002:a17:90b:5201:b0:343:7410:5b66 with SMTP id
 98e67ed59e1d1-343bf23e94cmr1515386a91.11.1762820603008; Mon, 10 Nov 2025
 16:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHC9VhQjzt0nJnbwXuwT7UPBwtHjEOPZu6z=c=G=+-Wdkuj5Vw@mail.gmail.com>
In-Reply-To: <CAHC9VhQjzt0nJnbwXuwT7UPBwtHjEOPZu6z=c=G=+-Wdkuj5Vw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 19:23:10 -0500
X-Gm-Features: AWmQ_bmO_J1uWwhkfIMjYLf5xJIaX93Sr0Zwq3mSA3wxHuho5Pw0As_fNioTvOo
Message-ID: <CAHC9VhROakxXe-ZJNFtpNLeV+P8g5W4VZOdQtuY9NbaOHwEYuQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 6:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Sun, Nov 9, 2025 at 1:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> >
> > Originally we tried to avoid multiple insertions into audit names array
> > during retry loop by a cute hack - memorize the userland pointer and
> > if there already is a match, just grab an extra reference to it.
> >
> > Cute as it had been, it had problems - two identical pointers had
> > audit aux entries merged, two identical strings did not.  Having
> > different behaviour for syscalls that differ only by addresses of
> > otherwise identical string arguments is obviously wrong - if nothing
> > else, compiler can decide to merge identical string literals.
> >
> > Besides, this hack does nothing for non-audited processes - they get
> > a fresh copy for retry.  It's not time-critical, but having behaviour
> > subtly differ that way is bogus.
> >
> > These days we have very few places that import filename more than once
> > (9 functions total) and it's easy to massage them so we get rid of all
> > re-imports.  With that done, we don't need audit_reusename() anymore.
> > There's no need to memorize userland pointer either.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/namei.c            | 11 +++--------
> >  include/linux/audit.h | 11 -----------
> >  include/linux/fs.h    |  1 -
> >  kernel/auditsc.c      | 23 -----------------------
> >  4 files changed, 3 insertions(+), 43 deletions(-)
>
> Looks reasonable to me.  Not sure if you've run it through the
> audit-testsuite yet, but I'm building a test kernel as I write this,
> I'll let you know how it goes.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

FWIW, it passes the audit-testsuite.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
