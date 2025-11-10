Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D31DD87
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792927; cv=none; b=iKMMnNMnFXO6asY3aDLZy1CdXAPhWcRo5KXIbaFwCItwm3te9KNS7D34buo0dSpc39HWcG/kIfP1GBkdYWjb7rdniRNuwHx45U6Fo9uUUp958S2nPojW4sc12S7aVTahNhf9F4zWA0idV+c6nSgKo653zw4JUVS6cogcwL29EWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792927; c=relaxed/simple;
	bh=GKjNPhJUmE3ffBWuGrURvcOJiiT4jJnfaIvMg2ZBr5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPaNj7HFZXf/hGqfaDyVHz8Xe4XOpMfXxKLnkP9BnrjyDoYRjJZNhr7HeqaiRbYTQ/QNxbvC3x06vwYegv1LdCk/Z0+0VKhZNuAm7n3FHqD1rSV1vrZAZaY+TFy7I+WXOs+Y+VKEgvRf5NoVTdba9NK2f/sbm5WXylC7+jcbmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WgdTFqL/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WgdTFqL/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so408019866b.2
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762792924; x=1763397724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEQJCmiS2IMzNjbxI9qhqVkNRGDbuejNOKBcwtqGw/c=;
        b=WgdTFqL/k3vCnW/RoVQmHtX7CxrTIwar0tKeE0O3pGVitNuVYKyiBoOZ0AiU4g3J2U
         OK1mdFNocWGsW07dFKZzUPIqbj/hGUaoAUvfyPv0Ihc1f9JrdGRCC5TQv81jsthE+2wI
         /ZrViZyuX7tk6GWo6/HBF51utnpEUfl3vTOJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792924; x=1763397724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEQJCmiS2IMzNjbxI9qhqVkNRGDbuejNOKBcwtqGw/c=;
        b=lRrz91yw2zykcMr26oG/X9k3JzhCW3YveJCRjfNA9MsR72rPCYF76floSL9ycdZTlQ
         u3hPQP4WfuFaHL0zukuikExhgYEfHuA0WWnMiK6khP40tCNe3u77/uCfoFUtnThpGpLK
         Fq918KFgbEvViCPm6GRkNLQLplmBgoByPOfvGZPR+cEgNEvDxUo2x2o2rWYAft2SYM7v
         18ciIWMJ8ZNGkyAFoUcrE2MqjEBFP7yEwftbhtdoxUHfslDwpf/T2kQ7UbbYte+sEYYq
         Wez+I/IuiKjDvhA7zoBFTeO4n6G/gEmZssiF+4AELGql2HqL2nIoUToRjrq82cpMmSvJ
         tQGg==
X-Forwarded-Encrypted: i=1; AJvYcCWrU7EO6VCkEgmfZUaijzNZuxU1I9lks6wijlLuRqqX0u1Hyj6hvnNwDPiaMl1V0bDbIFUpUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoBL4OnpCm9CEFFaDuZVuvVzrH/dkdRi+F3SNK5GQRlp7ogdv
	BHBNDZ+f0TtfVXWt/PIdwBipWt9BOHcVzerZ3ircP0XZpI8aB4IylItMBYqXky4b4pvtpYCR4Xv
	zxaMq2wk=
X-Gm-Gg: ASbGncsQBcIVv0BwL8dVw5+S4rMVFNlqwh48iwgnWJdAua2cVpH5Pl2BPtMAGAo0WP4
	vVZtwrrK5NVe0h8MBiZ/hHjmlgx3fWjY/xodEWeqZ5H4gUIk4/BHHTwyAoD0PW6w3yRO17kjioR
	1u/WkmzYAAGQfPY1aCYSwlmWwmIgXQo83JKdb9LnyrDDbIWSQT0ek8D9/wJN8VtQVOnBArvi93b
	22gKH6ReuA4CsLsDcA4F6QU7o33fCOrafXLweKjIV+9CMHE9uuaW+SKrWnJKcdSI56Jw2019e0c
	1UX1yvZVLB/IbspwdfKOnlnsSN2/s//6610yWaTU8eKEjVa607qMpPMDjHgDA0QCxHd0iehYDln
	uWzJT+Ml63Jxzr7WLZPtKeSM4YR7uzf2jj2GroRT0O+OuUMsbfD1sREcxF6E57vcFxhQcPStNCZ
	FFLI+X37EuTqBCtJZ+ihisD4f0SaGAOed8iEnwwu3HREEtcnbMqQ==
X-Google-Smtp-Source: AGHT+IFYHzl7MRfCXtQxC6XuScgnoueEVzcCTW8LXct0bLFm+Eb7wJFUo/zvYKljJ+nXd4/Jji26tA==
X-Received: by 2002:a17:907:7f0c:b0:b72:6728:5baa with SMTP id a640c23a62f3a-b72e03407ddmr911720966b.25.1762792923837;
        Mon, 10 Nov 2025 08:42:03 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc95e4sm1156090566b.12.2025.11.10.08.42.03
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:42:03 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324054so473026566b.0
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 08:42:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWwXinftILuxcsYgpwKYsUniXBpTwOt4ZuS5OR6BwMwbeC4jHs57cemZnmfPhGMq1flWksTg==@vger.kernel.org
X-Received: by 2002:a17:907:7ea4:b0:b72:d9ee:db89 with SMTP id
 a640c23a62f3a-b72e056d064mr770836966b.47.1762792922013; Mon, 10 Nov 2025
 08:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com> <20251110051748.GJ2441659@ZenIV>
In-Reply-To: <20251110051748.GJ2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 08:41:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmrAqXZ2m4pzkboWqVgXqNR03LoZBcEW296TEL_nMeJgv27T0QqUNlPZ1A
Message-ID: <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 21:17, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That's more about weird callers of getname(), but...
>
> #ifdef CONFIG_SYSFS_SYSCALL
> static int fs_index(const char __user * __name)
> {
>         struct file_system_type * tmp;
>         struct filename *name;
>         int err, index;
>
>         name = getname(__name);

Yeah, ok, this is certainly a somewhat unusual pattern in that "name"
here is not a pathname, but at the same time I can't fault this code
for using a convenient function for "allocate and copy a string from
user space".

> Yes, really - echo $((`sed -ne "/.\<$1$/=" </proc/filesystems` - 1))
> apparently does deserve a syscall.  Multiplexor, as well (other
> subfunctions are about as hard to implement in userland)...

I think those are all "crazy legacy from back in the dark ages when we
thought iBCS2 was a goal".

I doubt anybody uses that 'sysfs()' system call, and it's behind the
SYSFS_SYSCALL config variable that was finally made "default n" this
year, but has actually had a help-message that called it obsolete
since at least 2014.

The code predates not just git, but the bitkeeper history too - and
we've long since removed all the actual iBCS2 code (see for example
commit 612a95b4e053: "x86: remove iBCS support", which removed some
binfmt left-overs - back in 2008).

> IMO things like "xfs" or "ceph" don't look like pathnames - if
> anything, we ought to use copy_mount_string() for consistency with
> mount(2)...

Oh, absolutely not.

But that code certainly could just do strndup_user(). That's the
normal thing for "get a string from user space" these days, but it
didn't historically exist..

That said, I think that code will  just get removed, so it's not even
worth worrying about. I don't think anybody even *noticed* that we
made it "default n" after all these years.

             Linus
