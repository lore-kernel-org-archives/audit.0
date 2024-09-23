Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59019E991
	for <audit@vger.kernel.org>; Mon, 23 Sep 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108084; cv=none; b=sry0wk1wQoT5no7kR50CbT1QFs8p7Ow1GsT4sQXOwvCg7xFki3fkOC9Fq3Etl0YhLpyv+IjFg4leZ3z7B3YZeiBLid0NrF6DANe4HEgmuUcUdUwF1qCjkKc96jK669NIDL8Bq8yrXrWtV4b7LehCHeUzXJnVcq/0wriD4curxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108084; c=relaxed/simple;
	bh=ipP2sfXR0vIc+1LQTZJOYMzoKbeTAHOQP1umoQw/lLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5RjjuNYNGAvERoee2qHwviYLca9YLVvbDmANn+ZbCy7/R1Exvm7E5G+THf7/0F6n4tORiM1qBARkp60iIbQmPzJA7pQvwPCgqrrqg9k9Ed5JPLqwZiICRHiRkGVe9h2a1h6kdur8fQGTukYtrCvK3IVH12iZYElPJ9VTKDVN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DfFH+JfI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DfFH+JfI"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso4081678276.2
        for <audit@vger.kernel.org>; Mon, 23 Sep 2024 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727108082; x=1727712882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsCrHU9w8sCi3sT7V4UA5/oaMkCAT+JmuhOd7667Tas=;
        b=DfFH+JfI1ZSfEp3XD/uvig8ogphsXz9rRHsgDusuE/E4FGyn0lrvEKN0+5L84Ed7zk
         4YYDL74RCc/sq8Fmb8j9upPbZNDoyteiF/S7aMm/MK/Ehes8TlTm3wagR9U7/Bc3tIbb
         jrBFJKn99bQPshmqvQ0ghmM7N2XtXNB/Db/atbrCaQ7XXxF2WVDaePAdcsjKT9KIYC8e
         JL7oMGRhEfpBZoPZgBE9O1Ei/Yn1ANzU7jv2F5yGuBxYmpEUW72X3duxs1db1CjifdWI
         Dh8cqBa4xLi2Xw6bHEKDJR2ntHEOsYwUFhCh3HF+JNvqDFrDCTs93y6/T8lZZT7khEK2
         Udzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108082; x=1727712882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsCrHU9w8sCi3sT7V4UA5/oaMkCAT+JmuhOd7667Tas=;
        b=v0H0JZn1KTC9MtxeTJfc+2r0+5h9v6E1iXVY4O9LF0nWeftOAMbmZ8M5A37DwMyUyK
         1QxsXwyoq8Rsc1GI8xQFWaZSsrs2AbNX+UlpfDvZMLBJGBdhP66sMZQboc3Gy+HaZC+n
         Fg3Hl6lINiXFB0KVq3tZAEAWg1qJFwhq7dP7JeuQcR69sDcFuhAQ0EiZnnN/QeRUZkUt
         +/0t30QhvI2ohXbDWbeS5lambWnMMiEk1zFdPwdOxljTgO0eHvbPUXA50bXS+zr2if4T
         pgXxGASQZhpzbX8CvvACW/fvTdY1VjEF0RG9fWPzHXjjfIuI8xt0Oc5GqfevzUKMipKm
         yKBw==
X-Forwarded-Encrypted: i=1; AJvYcCVWrFb5OTCOZ7ZhcVW6JoEvQ4b2fjW9kfxdAulKxkBiiQVfxXiQMpxXuPbZ6cQqGkQDFD2JgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhgSn+BFTVCMxDA4onFJT91NKJXITxLsrM2najbmjOtS1lGuf
	235DXFOQOW1WteZJ0yqmJEvs6Z3IOOaZjOxuqGWeC2VrtfYlVKGXS3k4LxOwvw/+Rc3u2fz/M41
	yFdYplr0laZ2E6FviBM18+hKsWlJEXsjHKxdN
X-Google-Smtp-Source: AGHT+IGNqipb9OYrGu3S15kHzPKvSSV1+65Pw0RfDX7Jhg5enLJD1yoATV7eOmgAWDW+1h4V8UXW6VGItQ29jZDnvhg=
X-Received: by 2002:a05:6902:1884:b0:e24:8eb6:d70e with SMTP id
 3f1490d57ef6-e248eb6d7e7mr2280124276.49.1727108081637; Mon, 23 Sep 2024
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV>
In-Reply-To: <20240923144841.GA3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 12:14:29 -0400
Message-ID: <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:48=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Mon, Sep 23, 2024 at 08:54:03AM -0400, Paul Moore wrote:
> > [Sorry for the delay, between flying back home, and just not wanting
> > to think about the kernel for a day, I took the weekend "off".]
> >
> > Jens and I have talked about similar issues in the past, and I think
> > the only real solution to ensure the correctness of the audit records
> > and provide some consistency between the io_uring approach and
> > traditional syscalls, is to introduce a mechanism where we
> > create/clone an audit_context in the io_uring prep stage to capture
> > things like PATH records, stash that audit_context in the io_kiocb
> > struct, and then restore it later when io_uring does/finishes the
> > operation.  I'm reasonably confident that we don't need to do it for
> > all of the io_uring ops, just the !audit_skip case.
> >
> > I'm always open to ideas, but everything else I can think of is either
> > far too op-specific to be maintainable long term, a performance
> > nightmare, or just plain wrong with respect to the audit records.
> >
> > I keep hoping to have some time to code it up properly, but so far
> > this year has been an exercise in "I'll just put this fire over here
> > with the other fire".  Believe it or not, this is at the top of my
> > TODO list, perhaps this week I can dedicate some time to this.
>
> What are the requirements regarding the order of audit_names in
> the ->names_list?

Uncertain.  As things currently stand there isn't really an explicit
ordering between the PATH records and the syscall, there is the
implicit order in which the PATH records appear in the event, but I
don't know that I would read too much into that.

From my point of view, stuff like that is largely driven by enterprise
distros chasing 3rd party security certifications so they can sell
products/services to a certain class of users.  These are the same
enterprise distros that haven't really bothered to contribute a lot to
the upstream Linux kernel's audit subsystem lately so I'm not going to
worry too much about them at this point.

> I really don't like the idea of having struct filename
> tied to audit_context - io_uring is not the only context where it might
> make sense to treat struct filename as first-class citizens.

From an audit perspective this is larger than just path walks, if I
recall previous conversations correctly, there was also an issue with
sockaddrs (slightly different problem, same solution).

I'm not opposed to seeing better support for struct filename, I think
in a lot of cases that would make things easier for audit (especially
where I would like to take audit ... eventually).  Assuming your ideas
for struct filename don't significantly break audit you can consider
me supportive so long as we still have a way to take a struct filename
reference inside the audit_context; we need to keep that ref until
syscall/io_uring-op exit time as we can't be certain if we need to log
the PATH until we know the success/fail status of the operation (among
other things).

> And having everything that passed through getname()/getname_kernel()
> shoved into ->names_list leads to very odd behaviour, especially with
> audit_names conversions in audit_inode()/audit_inode_child().
>
> Look at the handling of AUDIT_DEV{MAJOR,MINOR} or AUDIT_OBJ_{UID,GID}
> or AUDIT_COMPARE_..._TO_OBJ; should they really apply to audit_names
> resulting from copying the symlink body into the kernel?  And if they
> should be applied to audit_names instance that had never been associated
> with any inode, should that depend upon the string in those being
> equal to another argument of the same syscall?
>
> I'm going through the kernel/auditsc.c right now, but it's more of
> a "document what it does" - I don't have the specs and I certainly
> don't remember such details.

My approach to audit is "do what makes sense for a normal person", if
somebody needs silly behavior to satisfy some security cert then they
can get involved in upstream development and send me patches that
don't suck.

--=20
paul-moore.com
