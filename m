Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E422E03F5
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851303; cv=none; b=QBM84VT0MA9g4kbKy2igvabOFKSl3nQKY+GWLImHX8FzM/6UtY1BTRdX4tZ0q1z9PDoGg8fzW7BsymLtZXKdJWlYsaSE+XuYoBE08dR5fyj5BDXmWdaviPcR/aBXlOyR01jwnn3wokffmXvdetzVGWD9zMbU7O4joczD2iUTGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851303; c=relaxed/simple;
	bh=mHIQ3K7sP7Qo6HURq375MN+fcdkJK/fECc7bztH5Gg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdkQVpHkdM8Zdux9eeSZE+FfQLOZxes9Af79pap9/1dU0yiFet+97vebMzXpoWau3PaGT/VsQRczQ9ytor8AZLyttTmI14SNOl8aNY+UxZ/bMqmfL85W6ZEIknRLQmHBNwsUzgChF4yec+h0aKIXn4qQFOmUK8mHDUuWS95ChIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WwNKOCS3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WwNKOCS3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c718c5481so1691903a91.3
        for <audit@vger.kernel.org>; Mon, 15 Dec 2025 18:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765851301; x=1766456101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38ml30ZTmrZzOgNljrSkMybnSbK+YMYdltkMc1v5iPQ=;
        b=WwNKOCS3xFOgRYBgCEGy2byHp2QnL/DF1z9W4q6GUGQZxPzo17NJtF29hwBaqrQKDh
         FG6I2PZzl6hnNZ6H6zSkdUGYROMEUWyrnzmdN35n7BW6BmZBtIkzK+T6CfOHUAlYV1J3
         wWPmW44lxv6PqmCsbjzvauKfQjidLzNVwWd09ihKLjkHLMNi7qoQnNZQ/PrvOJC4vewV
         Bx885w7fZoCdBR/3hsY6zVihW2UToL35CxpOhV3jOJ1O/BwAlK6iAvLJ+zTb2DxJ0Fhu
         wgLcXhOkO2DR22Iy7z3uZMoSyeRFXVhIfKjtUT1uQzeKruGjhWwVQ+4YoltXmbyZPqrQ
         pNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851301; x=1766456101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38ml30ZTmrZzOgNljrSkMybnSbK+YMYdltkMc1v5iPQ=;
        b=AYJArQgv22ygW9FaqCkNeNYtu1PSuZfzExRD26O+LM62V8CUB6gQVOAkzzROdtRoz8
         Zvaj5cCDOBIw+FCYabw4nN3LqFNYdXTfM83XUbj7EOkSZVOGNpUCmwRxunga/+3A3roa
         sC3YlmT7yKuIHAB+jREge1TRSIJVN+eH18PGsXU/UdTAg4tQDODodmUgu1WRLCl5xkd0
         ouefafU2737YjimrIQECIYRiW1Hee1j9fjO5X8bDiFfD8TyTHY0JSuHlsi88TZXhCrjm
         AYDL7kJhPo86d0DyxgDWpjGhAYuh/7d+AVLaYMqqrGWUgif7i/u5+ANQUyvzBtl1zfcz
         3e0g==
X-Forwarded-Encrypted: i=1; AJvYcCV7jMtVx+WLdOWYWkIO/giOwtBE+sNuc6CaUXvvlSzxzuHtLmV5whyCssyp4K6Z/e+xOoYrCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSukRU8KOvJjRwIpcpJjv3c2PivrtwzjHc+hWoC+hYavhRt+H9
	I5EptcSA8UDsOmRyOPLdSdYaTOJSgGi4MTwIEa4In49tYNSPZrPoZFvBmT4mz+Bp+yLaGAfo9+R
	EDRMNRuoJ5FdczgQZ2rhiKqDX+BKnzO22mX09jvuE
X-Gm-Gg: AY/fxX4sRLeiRPL0yT5mh3m3HEIOICGwnoPxJgp2LiFKrW26XsDuPTHiDfBgzVMDdYT
	1R2tRHjfYOT8Cv+DHKTIMS+TtB3zNmrKGrGbdmcAMvdeEy0ItNR548Gp0HtKBebDPlk8pn5SPOG
	VksorOs+r4pYxfpTUQ9jMlgGVdjOTvN1QranDCR2n0VdV4BOo7yzyP03WIIrTmaUosgOu6bCcx3
	6J88o2fBGHw935TM/YHt8qD4+X+8+Iij/SDEhI1TRu52pP2CVSl9PQIjwdQ0z0QpSmMRuw=
X-Google-Smtp-Source: AGHT+IEzILe8qN9GD+El6RTbu57JAPcibcqUHe3pox4dYTObNHDk/4LK8IIO6QY7li/HRvvvM7+FagcZijrn+duBKEY=
X-Received: by 2002:a17:90b:3910:b0:349:2154:eede with SMTP id
 98e67ed59e1d1-34abd6dd274mr12326997a91.14.1765851301257; Mon, 15 Dec 2025
 18:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Dec 2025 21:14:49 -0500
X-Gm-Features: AQt7F2otW5TQ5LB6ayzoga_HfwJjV0bPobz73V93964UI8HoCd4VmH9OihuPZCs
Message-ID: <CAHC9VhTaQU6311zSx7P+oyv+rbrehfdQ7n7QJAEeqnSnMmL1Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/18] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> Originally we tried to avoid multiple insertions into audit names array
> during retry loop by a cute hack - memorize the userland pointer and
> if there already is a match, just grab an extra reference to it.
>
> Cute as it had been, it had problems - two identical pointers had
> audit aux entries merged, two identical strings did not.  Having
> different behaviour for syscalls that differ only by addresses of
> otherwise identical string arguments is obviously wrong - if nothing
> else, compiler can decide to merge identical string literals.
>
> Besides, this hack does nothing for non-audited processes - they get
> a fresh copy for retry.  It's not time-critical, but having behaviour
> subtly differ that way is bogus.
>
> These days we have very few places that import filename more than once
> (9 functions total) and it's easy to massage them so we get rid of all
> re-imports.  With that done, we don't need audit_reusename() anymore.
> There's no need to memorize userland pointer either.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c            | 11 +++--------
>  include/linux/audit.h | 11 -----------
>  include/linux/fs.h    |  1 -
>  kernel/auditsc.c      | 23 -----------------------
>  4 files changed, 3 insertions(+), 43 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
