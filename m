Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EC531AEB
	for <audit@vger.kernel.org>; Thu,  1 Oct 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888770; cv=pass; b=YRxuR/K2KuYaBrQD5+iVe7Guy0t7C5kJ87+7GYj3tzLm+NlBX5KKA64M3wp7EYEZoK5Xi80Cih8rRjePRg0Y3nISxeSq2mFLU5u2EFp+q/wzJ7xuF9BDqoKza8X8B4KFlEWIr5atf1kjeAH0eacBNh9I11kShpmliqNE7FMrKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888770; c=relaxed/simple;
	bh=xN21QYy0yGgz2sHT1nXnC/21nVEwjhkQB04Hg4E+rW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS1vU7pgRkPlQNV8/g8Hmv+5eixlw8nyt6qDEmTV5ldFfn0yYKOT05YGnCzKE9IzeUMTjuHDMo4yDTMPztYzHtdX/eIl663LxKVW2F9vw+xxtqZEyFZNjBEtMt842/uyeW3n4J9t/yZURdnlfZ0LMj4i8HHq83Za9SQnbaNucW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAwV36pr; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAwV36pr"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so3047620b3a.2
        for <audit@vger.kernel.org>; Thu, 01 Oct 2026 14:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888767; cv=none;
        d=google.com; s=arc-20260327;
        b=GLdFGHy8gJ4r5GeTUAc4OhQfd4YV9NSU41BuF4UsdoIAk/vZnzkNj6PaBOL23gZO+r
         DGXeS2ssEJ+wof/kmedEyAWYvN4hhjZ3XMu58T7oSsLtFwBXEHDOf8F4HLRIQghWL+be
         sYiRZkGK83UxWfyZX4+/v+NYZx6ldzvfmZQaCopRLstWgyYxD695ToZYusl2wsjH6Kdw
         4aIBLAhBU9L0yCDZ7nNrO6OZWiHJpWAwQXg9MSXBznukMTHAyaFVW1wVRLx/FNYVW9IY
         EXveLW1ns0P7tqxSJ+MleUq6nSLcsEXCNOBuU4Dqw/O5RRxuxh3sIOl3oNaY3ovhbCFn
         xnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        fh=b8NH310RuesssRCaAmnBQdPTqvz9avNnbX9wpmAPCkU=;
        b=A4ACRTI18/vY022hnuUzW+VKzkcdjEXiMyPKm798AsDwPyXTgG4w6PCXS3zPUQFq7w
         2zmTd/Vi3EWaKu/md4K8a61PuHZjDOMp1cbqnn6SAShpAp/TDiQZ11ssVWo8BobjyUv0
         ziJAUPzrjSXOP8X/IWElp0UdH429myhLaHHacFLs4jlQNPxkZbQyivKELML5696nBWf0
         H00RvVHMex9k+0CJJsa/sB/3ID9qDp8sqrIRKhP4jeT5WpOC2APiiteQTGPqZBEq8U/0
         1tWLhMqbr/F6TALJWpBJsOKJCcpyjJw477xwUMLH6SY/hgJILQy13jMjpOf7u74LJCG5
         DL9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790888767; x=1791493567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=CAwV36prXHOZw2NRE+aSACbPdDsBf2SHqbBYA6oNTHRxcIGcOyC/CJqkRH7LJRevOZ
         ClcJMU2t93f7XmqqwruK0c5ZXJiXQfI/+n+w9nHyb4EcEh0EZTu11pUBC9xzrVuOqKBT
         YsV75j7RrnJU55Z+JqH44vXWfdCbI4I+NCB8980IdTgu7vzPMxHvgU+uCw/+FxPpgY0h
         63X1M3w+g/hILuWVI8qWSFmlSwv2NKZwGdJ2DwWfYsxtFTA/lG+C3YADiA4myoIGj7HP
         Z1Ev8yhuTUNqN+BrgGDh8F6GLVD0gbmqkkcnf9FOFy5sLyuxAa1XjcNkIrhbHMfk8YG5
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888767; x=1791493567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=eC9/wOJrwCSN83iOmZ/5QDgx9gdgzVyf4Qco6m6DhQmTsqq8BtkipDZDlxXy+jUZs4
         j25RkiGBpyDVdZsSP+90SD2Q0XE/48oMysrCehES2hR5zZvwZP0JUFJbyaV+pMhsOtmZ
         2LgbYRXZORz7qCqJChq9LIPO5UfTxvqeN3knzvB8erX9hroO6kP+9ep/S4WACjN2UJ7L
         uNA6AKQ6tNIURnpIVNZU3asi+JYd5u2egXU8/AvGgQQc72Gk87zPr0So1kdYjwTi7Nma
         srJQjGjgIxsWilrT0/aNTAxsxvjCx7kt3oOCdF8n1Kev3FtWkC7btwbnyfyjtUZXmJOx
         fQag==
X-Gm-Message-State: AFuF++neBe0IAua4Y4dbr4RJcW0W2lWr4UuDv1Px+dUjzCePR6ns+Smt
	r7yvlSd/VJJ6VujaE4WjNaCNrjLv3ZJ4RipwJSUjpGYcomS1HKRI1CU3no1Ihm/dNYRzBjVrqIJ
	W/NJxRYBuetgzLKRLK8Rv/7yoOeepYyrmajx+BoAB
X-Gm-Gg: AYBFou31kKZqorAXVxqLnTIYQbL3uVgh4ycQ3BImvJE7h4qBkRZvsRluoEHF4I81hpn
	azyfJvLGMwQl5/INSk/p/9AHU519ulL4sQCBhIkTEfVEYsKug8GGybd8m1QsA4q/gHNf6vseF3E
	oA7gKtpHD51ClDA0HqGbdHAdUaFH4f7SUwS/ks5idAbWD0hyqlPA9Ufnw+yjoeopp6W7145zPjX
	KIIE6oJwUB4NjabA1wk9RW8tANdrIO6QGD+OvA3Fmj+Jyv0z5HrDoIus5H2/WPhE2tDQFmHmyS9
	6Z1Bc6B+iuy6yUTI+pfHfXC7ZFsJ+rxfeN1pcj3ps6F/92AIt7zYjWELGVTEa9jaqIT5tgJHsRc
	UDbKCj7z4EXmD
X-Received: by 2002:a05:6a00:1254:b0:881:5dcb:400e with SMTP id
 d2e1a72fcca58-88af6d24f34mr727169b3a.56.1790888767004; Thu, 01 Oct 2026
 14:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:05:54 -0400
X-Gm-Features: AclHuK923qNeclwyxHc-N96rTW9f--kU_8IWc_3FVDcJfFTXqnWMr4asd_Mjppw
Message-ID: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
>
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.

Thanks Ricardo, this looks great!

There are a few things in some of the individual patches which I reply
to in a minute, but there are a couple of "global" things that I
wanted to mention:

* As pointed out by Sashiko, when you were converting all of the
arches, it looks like you missed alpha.  I took a quick look and it
appears that it should be a pretty straightforward conversion like
most of the others.

* We need to get ACKs from all the various arch maintainers.  Aside
from the parisc changes all of your arch specific patches are trivial
(and cleaner than the existing code IMO) so I don't expect anyone to
complain, but getting ACKs will likely take some time.  Even the
parisc patches aren't that bad, and arguably they fix a problem for
seccomp so that should make asking for ACKs easier :)

Since I expect chasing down all the various maintainers for ACKs will
take a little while, and I'd like to start getting this patchset some
basic testing, I'm going to merge it into dev-staging now.  While the
dev-staging branch doesn't feed into linux-next (this isn't likely to
land in the next merge window) it is one of the branches that gets
tested automatically and included in my kernel-secnext RPM builds.
This also means you won't need to worry about keeping this patchset
up-to-date with rebasing, as I rebase dev-staging as needed (it
intentionally isn't a stable branch).  Going forward, if there are any
minor changes to this patchset, e.g. a few line change in one of two
patches, please just send a fixup patchset based against
audit/dev-staging and I'll squash it into the relevant patch in the
series.  However, in the unlikely event that a major rewrite is
needed, just send a new patchset ... but I'll be very surprised if
that happens here :)

--=20
paul-moore.com
