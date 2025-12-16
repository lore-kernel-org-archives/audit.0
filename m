Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AF2DA757
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851511; cv=none; b=qehSx1npFxnHILQBSs+IZScvCy7luUdm6s3N/SMRdJVDojiyp4OQALWGpQYkbrj3WqFyIbgS97Jfbo9iKoNRVsRrpypsz4lzEH49HgzkpgaaMfR82UCE+DtT4wc3F9H8bfavXhCZVXaCqYCNySoxteCg18cf+u/j3LbECKlCDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851511; c=relaxed/simple;
	bh=87IUC5B+EmxqpWOYohTUfn4MeP9hxTM96c9slLvqD+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo0FlfGkEkuJT+BJQk6qePG9DDDIwDUNZXR6mrD70+R6Iba97AIut/90oxWIPtZD8PQLHckcXSWU5+ooFJrEJUjaA0i6tLrUM7NJ7fHPlB85TMDI7/FyZ2Iub6rfXk7qDA8bqfCK1zdounuzry+TBJTOJagBGRLZsmv+tdKU57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bRDzwOHK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bRDzwOHK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c09bb78cso13748255ad.0
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765851508; x=1766456308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRjpFIpOzRZ2BiN5IiVV5goUIm9mEGJRGqt04cQHEgw=;
        b=bRDzwOHKf+ddNhsIaSzQ+GVimdKudyYrZ6qE9F6bTCB6zCFsplK7eGPK8aPLqbGsBm
         qyBUCyBYT7CNuVtCISJbBZoJECVSkk9VcJ3FMicEfoG3NYs2ZgWoXgSR9KE3sF0+uoAn
         91+qMg0e1z/llL18hp634ePTGGivr/aT3drbwVJOKAxXE0+RBbQZxanYJf44YtBJRMaX
         1Gk55GB71x/bDfIkT7ZN+wWRPDEUmy04x2jovo99d1j9YNRYxqewExSj9xo/TRRn8jyM
         TicxeTNWsh5u5sTWZDC9w1BB8MaVJmUP6qKhVxXQlsykmiVJTJx3nZPvRpJbz34L8o3c
         YPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851508; x=1766456308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRjpFIpOzRZ2BiN5IiVV5goUIm9mEGJRGqt04cQHEgw=;
        b=LnSlwmJr4Fi8xpqXuY8WXXqqVaBKq7pWktAFUEwqlFVFcTs83iObJs8W3wpkwbmmle
         qnJJztl1u8/ueplpU+kHC2nV8cnKArhZYh7bx9SQxt5ylHGSSkSyMSkkDqK8Z+/z/cD2
         7HkjHafl57p1/aZIGlwNNf/TF0V9MueMR0GFSod7p2mMZ0TnglIzANdfJaxrGcQbelUG
         FPRDT7ymJPtWQ6bZad+xNd3i3sWrkxUdLTDLkFFwhMH2wGJIqNmcPhkXw8UGtUKM5lAv
         /ajCAm2V2kjUpxY2Ka6bb6AUbd9CN9KE2EEmXhSy1QhJM+/qkPZNpAeHLEKogDZJqM4T
         uMbg==
X-Forwarded-Encrypted: i=1; AJvYcCUJkK12zglUDut8XVU4s/M2AqwL+rzqEG5s5e8DeAXSuhW/0N26d3dGm9Y54crdyTJapkHoUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz254ycX8+GiByEzuGyEACm/IAEGYvFgkTlL3/bNA0fRE8zaKUx
	3+3MJf3F7xrjuC6RjkoqNiaq5hLFweqMpcMH9EAlR9g+paufi+A8C/+7306CnBTBoSYmTcxHLGe
	ImQls7ImzJCx0y2/OULd6cfTqnBI0Y0g/5oUk1FOO
X-Gm-Gg: AY/fxX5IBBfiGuqGpoAhSqV2aEAQgIk/j9haGNZ91YXf5XhbeL8orUGyQPPV2f4TBsI
	9FDboafy62N8M2dKGo0pFxF/6ljFrcjzKvrJkwsNO0h1QvvENRw6BcLIJ2oh/JH+5oucbwMAw08
	u+7Q20BY9QEzg9eOAZuOfn6efbyGlLgsD8MzCl4SNdnoyDJ+9j67Zym0QmpFegf3EmvNOPNCXSU
	Rc5iZXoiklv8oSac5iPg4EPwblSqtsXz4+xrcW23BHvcKZyeS1JckEa9XACAYU+LNoVQR4=
X-Google-Smtp-Source: AGHT+IFN0n0Z1ONhFG1K1mRun3mzBO+ovfpXWV0d4D3ZLmKRc7ZoVjis/NHaXg57M0CIY4CVmn7rWzSq94ROZvDyD9s=
X-Received: by 2002:a17:902:f786:b0:295:55f:8ebb with SMTP id
 d9443c01a7336-29f24e9fb9dmr117523255ad.21.1765851508255; Mon, 15 Dec 2025
 18:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-19-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-19-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Dec 2025 21:18:16 -0500
X-Gm-Features: AQt7F2qp5TJTQsl_u69giqHIzesppxwKZN0S7rImDG0A9kbJZcYWwHrgoa-C3BU
Message-ID: <CAHC9VhQ4Mh=UYYFw83RYEG6VfcNpx9QSXdQbBgY0WG0Rb7a_9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/18] struct filename ->refcnt doesn't need to be atomic
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> ... or visible outside of audit, really.  Note that references
> held in delayed_filename always have refcount 1, and from the
> moment of complete_getname() or equivalent point in getname...()
> there won't be any references to struct filename instance left
> in places visible to other threads.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c         | 10 +++++-----
>  include/linux/fs.h |  8 +-------
>  kernel/auditsc.c   |  6 ++++++
>  3 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
