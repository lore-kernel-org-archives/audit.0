Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCCB3ED120
	for <audit@vger.kernel.org>; Tue, 14 Apr 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186946; cv=pass; b=cIWQLMWhdjCXyHrcMvCNwmizjgqXcils4XmILqWQXObQ2NClBZzllUIW0HuhluDwkgsBKDm60+Nlc3zpLTKnD09oF1ZHoe7VEKX6o5LgqiysJIv0SGKhv7wyboP2WH4gnagothaf1XqNUumHh3g9LdhoBJf6qgE+KCPwGNgOfqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186946; c=relaxed/simple;
	bh=mavoCBNUKI2BOYWaTgu1EtwkVSg6G8NURh0XQrKA/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngmaDcAurWCOViFIQlEk08G8HErJxcNsSmcHwdczjNOIuIgjNmhFDs1VODV06QR1rZg3IP+6AKLnlUSdI0UPTUi707Jt0Kk20GQ6rR1UNZRd49rm/K9NA//5dAvK+vWJgewX3qgFlRIwE5ueQS+kbGC2bMjiaFhnnBKpd5+IAes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M9IgjFi4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M9IgjFi4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b461310af5so10050975ad.1
        for <audit@vger.kernel.org>; Tue, 14 Apr 2026 10:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776186945; cv=none;
        d=google.com; s=arc-20240605;
        b=ZX+TAEckwZvFVUN2JLPosMLdWkcmQBmiFsL0ozLDD/t7yGd3O+TCtBJ+4tYC1FzJpL
         2U63O4yqxj5lUo/Dhvtc0yfS2fRpivgNOqjuwF9xL4/L3dOZveJp0W/kExMA5Rq1iSWY
         7JAK2QVirgBvS2KoacjhYYvj6VNjhC99sRlhYZjuoUq/95ip93putAdXwvatst6eit5K
         v1X7piT413M2QZ06F9QgHFvpAXPKqMvBM01D4o/Y1uCOVvaFprydLUN4dwRzBt0OSF/w
         zDgjSZyBX41itXXdV8nJAaOv23ZPUAVS6i2ANqr5YlrxngX1uJ5rlaZFGwG+nlK9AIPF
         rPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2uijLJDHkqC/NLdDw84oxgXaoFklUHo91TW6hFRKdU=;
        fh=dVnvZ6mnFa5CZjRlL6VpOeKebmNTU4D15cPlBuvPW+0=;
        b=I6Oe5B2/BTuw5hpU/u+gGImbAbBri0NU6HMvE2vX6oICnLdmOcmiXYZ/vjbdsk1kOg
         rKfxZM/ZJ1Kg6EQ86H2mHobVypqFv+Wt/zZIi7X+MrEzp0+qJQOVkQDmxe7Seh5/mcdC
         D0N8A9OvlsjeHT1/B4v29Wy8Ez+FxMkCQuIQ3ID+8iCVUxtJCFMsLsRGYe88wtY4f3Kv
         sv/hq3cWnRg/zvVT/IOoNwTRSOG4GERETH4nBMAqKTRUXZsRtX8wVSkr/2afkGtWxvRX
         qqYXFphUY2UI1DEJkMKBsx80dNJKIMtaFom36rLdqLpGpEEE8miJqgsY6gBu79atH3hL
         OWAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776186945; x=1776791745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2uijLJDHkqC/NLdDw84oxgXaoFklUHo91TW6hFRKdU=;
        b=M9IgjFi4c4GLQI9Tx5Od6bwXJ/jwS7DCpfI3SOimx+FaX+Rmqci9XFmnTg8qpaqmDg
         Zm4eUm0JZfKYrMCRwcAXoCp7q4IJHDPUFVDO1guF7aJ1fEbrPJQAKgUaRD1cAGzbz3Fv
         dq80kT7kz5azFoHiUK90s/KbZtRzjSO4u78D9dMGXQgEs6DDSosWTQhIR3rzN8ebAj3f
         8HIDWl4DP2gVCCrWxW6Cc3D3JhudL2CSqhwUQOa7TKWsyWjxuqwBA04lZYempbcSu0iW
         ixE1EPoq+MxdvPQV/EjoHaSpy4hTqfE+nSe6y1NgnqTLiANV1QROjNOAnn40BTt5EUda
         VlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186945; x=1776791745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2uijLJDHkqC/NLdDw84oxgXaoFklUHo91TW6hFRKdU=;
        b=O4W2ujcZVBPQvVWQIIPqzMCp3J30c1pTgYikjePCVZF2O2haxBFFG+sFxCVL+SUur2
         Zyqg/DqiXAFNlbg4FHzslh5dU+jeCgMANOASN5k7hgFl4P0vKTZ8KIQIovGgIfS38Zcx
         TnjFoZuBn3qxMZn5HzJlNQxHngUqnrIdSxlljqsnYk/zQNrer8oachwscpV6IB7Dp70w
         zIH2nxn0TZ7f+x5nm0vu0L2UIksbMRsYM/lpNsIdd0RaXq6NWCFbEy+f0c/Ny/AATiWL
         xhjKLDik4dwZY9GQtJqVxfLOnUB2bG6I7ISDDPtvqcWlnQDpiwKjs7xGKAzel8ftKoWL
         gqCA==
X-Gm-Message-State: AOJu0YwgNbWssWtT8YQuqnu8DfBTK1ruc6YxzNJEuz9ykWwe+x5IB6g5
	47eqsgUiLZ/diBQf96DIfM6QeM2NCktokrhRvv4PAlVg1CvaagIL4s7++/sK4fzrkPVNniuxZUY
	DIEiexF57blvla8AOrf5Uspy18E0Yo+2/718zsbbr
X-Gm-Gg: AeBDievZ0VwRSkq/zOUX5T7brnrxTQFYyjUStNQDjpOkbDQzoPVrC6t7JrhOd++Jm8E
	+gJBMVzMZ5N8Lo/5ibq4bj3WF0KgMdqrsy2ZB6PFzeSGyy4rd1XKSb0CmWMAgXQPCU6EZHAXLwD
	kn15hlhstAEMhETH4xpPuz9qAQ7P7i/CyUyDViBCkl0Vmh1P4SB5rXr8w14QWQLrk97iALRfoqo
	N97nnyHETzvSSeq/PHgf0DguoGWELTLOAiwlZ2rgHJpolhMrum6SL2nFRWRwbfuDf4CAn9FfruU
	lYtSjr0=
X-Received: by 2002:a17:903:1b67:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2b2d5c55845mr160811755ad.4.1776186944620; Tue, 14 Apr 2026
 10:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com> <CAHk-=wjCBBHUL=9K1iMrXFDPmfT5Wsu2oXDaADLG7j160OikhA@mail.gmail.com>
In-Reply-To: <CAHk-=wjCBBHUL=9K1iMrXFDPmfT5Wsu2oXDaADLG7j160OikhA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 13:15:32 -0400
X-Gm-Features: AQROBzC3gQWxiRDy7LQgA5TbtqqH_tw_GbP_AwV0qU2rWAhYu9nQ7g9_plFEtLM
Message-ID: <CAHC9VhTJD7Wb4t6XdNgSFMC3UcjeyX=6bmAjVdp7LeUZGW6qbQ@mail.gmail.com>
Subject: Re: [GIT PULL] audit/audit-pr-20260410
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 6:13=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 10 Apr 2026 at 16:26, Paul Moore <paul@paul-moore.com> wrote:
> >
> > We've only got a few audit patches for the v7.1 merge window, the
> > highlights are below:
>
> Pulled. However, can I ask you to take a look at my reply to one of
> the vfs pulls, which was actually triggered by audit overhead?
>
> It's entirely unrelated to this particular audit pull, but maybe you
> have comments? See
>
>     https://lore.kernel.org/all/CAHk-=3DwiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r=
-w3WPQN+Zm5w@mail.gmail.com/
>
> and it's really all about that current "get_fs_pwd()" in
> audit_alloc_name(), and the cache contention it causes when lots of
> processes share the same pwd and you get everybody just updating the
> path refcounts.
>
> Would it be reasonable to do something along the lines I suggest,
> where instead of getting that fairly "global" path refcount, instead
> get a reference (with some way to do a copy-on-write break on it) to
> 'struct fs_struct' instead? No, we don't have that infrastructure (but
> it doesn't seem _hugely_ complicated - famous last words), and yes, in
> a heavily threaded app you'd still have potentially lots of threads
> sharing a 'struct fs_struct', but at least that thing is local to the
> process, so it's not shared beyond that.
>
> And no, I don't expect that you'd actually start being interested in
> the current root in auditing, but from a bigger VFS perspective, root
> and pwd really are just two instances of the exact same thing and I
> despise that spull that makes them different at a VFS level.

It seems reasonable. Perhaps some gotchas will pop up as someone
writes the code, but it's worth a shot as far as I'm concerned.

I say this a lot, and frankly, it should be evident to anyone who has
looked at the code: the audit stuff is pretty garbage.  It mostly
works and solves real user problems, so there is that, but the design
is awful and the implementation is worse.  I have been off-and-on
working on a replacement for some time, but most of the time I only
get a day or so to work on it before another fire demands attention;
progress is glacially slow.  That said, if someone wants to send me a
patch to convert audit to work off of fs_struct I'd happily take a
closer look and merge it if all is well.

--=20
paul-moore.com
