Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DD1D61B7
	for <audit@vger.kernel.org>; Mon, 11 Aug 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950888; cv=none; b=jflptEsbjCZMilhNSU7ky4HL+B7oYQtUkGiMHhwtAOr84O6GmnVDMfMy7wkkOWCsh1zPXLrmnK4+5xTVgQ+Ru4Iszz8l/DTEjllge3rdiLPSUIDUaAHxN4d3WeFBhkQvQNfbCNFiLQExrXBGKErndlp8AQJobO1qJC7ohutW1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950888; c=relaxed/simple;
	bh=qXhanpL+DK2WbdhWgqSJLD1CMqNGLtc5qG4llyV7dp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfMttqc2Nxd7HB5TXd1s5QX3i2isKFtz00e9vF0ULHdehZGDiMQmaI9KUQUILeCHOUtdW8ccQ+qRwewIwAjDdpA9GcB7YTRA5/yjl16Okp1EUh+fxsSj7DzlLTRWzFMYTfsx48ygLuaMAjyAaMK52abL8A8TCtd0ulrN5BcNvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=btRRtqFp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="btRRtqFp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so4471010a91.2
        for <audit@vger.kernel.org>; Mon, 11 Aug 2025 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950887; x=1755555687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=btRRtqFp9k1+3KHuadN8gK06YGLKpjW0+GWFyE9XG1iqlTQ16dWPQsFMmp51ph97Gj
         dLwIiXpomEM44yjpyqMmDrEv4P3wjNHXIYW6cGkpDaJt/NKkVf8AqZoieUypJT2i/UIh
         FriZsMf4aVn6qbLqdrEhohLz1rCS8ggHux2ODerie5ayBFWaS50j/EAqaLZj1aOLqcad
         XeYbY6PtgZpCRy8xnD0CFzH0MaFNaYaCzvcvkzFmDqQauEGA0Uu7fEj4huf6/5yCOzLA
         KlJb3aoG3F3DEp7WxAQxAi299lp1OJW51AUAGcvGJ+MdIoVSgb1gIWOzIOge6W2IRrdG
         xKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950887; x=1755555687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=h4z+AyJkWElsx1b/KasO7rNqLG61Qyl+pAELTT3zY3uCxlWYOmWUWsi0mTRusmAC8x
         TouoZjdbwaOZh1phfIjYkXlstIpdTkgD2s/Z1jUZLU7NNI2Fts1ldq6YScAPy+wExFr6
         ImBSWM4FJ/dbBUI5bT8QDhJkUgCTGqgzH3lIS0Y7Yv2R1EpkzsiPwrRQw5kw6DDPi7zq
         9rz1dK3mhtI1WYY9hLFFJ+L5oehUzQ01jnxikMX1QgsCft+/CVQuC+HnYO00IRRDUFUT
         2ktHq+THR1buoZjuE7LfmBv9zwySdoKyZcBPmUUMB5INI/y3h7YjC41gdWMs0aBd8bJu
         KC5g==
X-Forwarded-Encrypted: i=1; AJvYcCXoBPc+X0cwur56iJg9TQYm/T0tfnq2pYw09614n0x4tIWpNXpOkyOqfunYW4NJ4E7NNBBYcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxWkiI2d5Wx6CwrE6p357prrCgQ9fHRpsjmALeHgbi54tQssB
	7/iXqw00K20yQv7xDvwbYy/SsURq5Htuym8JjgEECsR1fAf/dJXSQ5Gexs3+Uc6WKl0ky9mnZYS
	0+BZ6jU9I4vW9V/cwkBg16OWiISkaxXvsLwqkiYH1
X-Gm-Gg: ASbGncvaXbWGg706o3uYjheobS2mCWgx5VQPInkTv1pBoLR71/FoJl2OrC+SohZKIHz
	rToBtc/j+7JT7DkwPDKQwYuRduAiaYKwJTLLGCAkBrXKRk/W3XId0n3/GaxSc5cE+6DBuzL0PAB
	CoQ1Y6il81p68AxD8RjSall5ljvJVfPRTQMgdsdk8XtmmCbyMbj1OHORvV66zkw+xZmqlgMPrvc
	+Gr/csalc+YiApJdA==
X-Google-Smtp-Source: AGHT+IEss2X+BEVYoSZIRFPMdBMIECB9EsuPm1/5BEpb7wMtfKbuhIPqkxFcGxZboN3KJZ7oj0OWy4xB2RyQ2dN40eo=
X-Received: by 2002:a17:90a:dfc4:b0:321:6ac:532b with SMTP id
 98e67ed59e1d1-321c0b3493dmr1670945a91.35.1754950886988; Mon, 11 Aug 2025
 15:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716212731.31628-5-casey@schaufler-ca.com>
 <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com> <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
In-Reply-To: <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:21:14 -0400
X-Gm-Features: Ac12FXyMjcnxuMYwY6jL1gdJPw-g9F2DzMGA2F70iCe8j7vzY4irDpbe-2aJOKM
Message-ID: <CAHC9VhR-Jd8JGhEETSBLDQA843FtsyN+ocM1XjfA_A6g+tJeng@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 8/5/2025 12:39 PM, Paul Moore wrote:
> > On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Fix two indentation errors in audit_log_exit().
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  kernel/auditsc.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> > As this is indepdendent of all the other changes in this patchset, I'm
> > going to merge this into audit/dev-staging now and audit/dev later when
> > the merge window is closed.
>
> Spiffy. Thank You.

... and now it's in audit/dev, thanks!

--=20
paul-moore.com
