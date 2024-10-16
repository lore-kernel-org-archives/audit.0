Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E421E3C2
	for <audit@vger.kernel.org>; Wed, 16 Oct 2024 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037769; cv=none; b=P2zp8C2NTHtSxTmZFHMiLwD1ZYBbSBvca9QoaG6mlCjzC34K2GY53wSSHG8pT8elqHi6i5KoWiWeAnuJ11cfCk2kgxyzpZTZAfappjv9BgxOUD0p70chwz5QXrgbERANQKjpjL+b1aK4253Ml+AH65n6QQtdbM4qpSE8YInQYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037769; c=relaxed/simple;
	bh=0RR+M6O+iq8XIjRHinrWxf3DoFEOcB1Lx9Es2nZTe7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vmj/tOnWgoAWlbVtAxytuxP6SisSKCLlx2BtXozF+gylbbxE/Mm5r2LKx8y0iXfVdKnBIFMBy/uEr4U7yCTS2aYVp9T9V0fD8zXr5/M2waR7823q5ZupoLv+OqF+5pDnSTs38BvJJYyVKuZdzNqPmquKl/hCX/T3C4fw0y9adDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dGDehaZp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dGDehaZp"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e390d9ad1dso26334927b3.3
        for <audit@vger.kernel.org>; Tue, 15 Oct 2024 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729037767; x=1729642567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwIVXsv+0K/tRmuz74E0Mk7+OGVGSOJtC2LxGockSrQ=;
        b=dGDehaZpDW550MqhEsubuL0aypwzrX+ohNp1JqHP0Hs+rHzC4CpkSSKRsfZRBvPO8a
         ERfYEh4QNBihDwgaASzOEhV5vbi/OiluvS6YRM9iURxg2dEET4bQwOUnXT9N8qIz2HbF
         Nbho2eXwGJBggUJYqhvi+W06qM5lqkOpo5KTGQ31gI1NUgU2dsC1g/orSbwv+Cgaa3Zc
         WW4vwAvsdn+gg1Vaii/eU4In/QbMrCXhEXDouaJhpW+tSmpzwn8CXxbR86q5vg2V2prR
         yS8I3d+5o5pG9m2HdnyLWnF4jQDeEieodCU+/uWQKn/nfBD3zLVvnV7/MrI36nCOIa8f
         /Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729037767; x=1729642567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwIVXsv+0K/tRmuz74E0Mk7+OGVGSOJtC2LxGockSrQ=;
        b=xTininDTaBzK4iLMrVLblpxrQTqyBHdCxZPJ2acRuZ9dvP++eAGFnAJcSpZ7HHdfAK
         Q/9PDh+MoWRyCO5m2WJcqmcXUYhTZxjIPQlxUOhWdT/D6t4rJP0qHdAgu0MIvetpC8iD
         qSnSX6+f/8e48hNKQiyJrpQI3Da7J/ux+q++R4J2cmUW2r39Ff3vEYNBbkmHNmaP1qNQ
         uiIFpCE8c9VO+MKUp+bXD6Gu5sLBmczqu1wlc5+une8wkobrZ+1wH0wN+Tq3/RNSe7DG
         dnRPxQ8GirGttls8KJyIabGpF2761laeHmGImyU5hjWY1QARKWh6NJ06wCm0UoEcriPt
         d7yA==
X-Forwarded-Encrypted: i=1; AJvYcCUEbBnEeGZKIqlmx2hprCHNRNLujNm0JE75lgB6cNGClzco9JpoV95g011ZVT41JXwvDt1QHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpjga+drwsCMRPT4GT80roQ9i4S6Ou41BCyLtrsr1UL/YP9CAs
	xZgznBHWFzT1fOyVRyXgqdo0vTp5yESeuPqoeNJg93KjwCWRlFoa1Wq+qVe6Ai3bs8ar4rL0R4g
	WeQzZ8Q07pmGg/VdMsvrqptbY7xeY1nboNjbN
X-Google-Smtp-Source: AGHT+IESf3Jz8ORecE7b8c1bkUbZCtOoJ2cisSrtY1CixXa6d/r44qsu/muJ6kPqg3NbhmLKJVsXrujBGNQ70iaASHI=
X-Received: by 2002:a05:690c:5719:b0:6e2:50a:f43b with SMTP id
 00721157ae682-6e347b368c0mr95998737b3.35.1729037767509; Tue, 15 Oct 2024
 17:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net> <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net> <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net> <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net> <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <20241014-turmbau-ansah-37d96a5fd780@brauner>
In-Reply-To: <20241014-turmbau-ansah-37d96a5fd780@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Oct 2024 20:15:56 -0400
Message-ID: <CAHC9VhRdkByXa7SA9LqNrRyU6EfhezHENdrToQxYJCakPS-YcA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:45=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Sun, Oct 13, 2024 at 06:17:43AM -0400, Jeff Layton wrote:
> > On Fri, 2024-10-11 at 17:30 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> > > > On Fri, Oct 11, 2024 at 03:52:42PM +0200, Micka=C3=ABl Sala=C3=BCn =
wrote:

...

> > A better solution here would be to make inode->i_ino a u64, and just
> > fix up all of the places that touch it to expect that. Then, just
>
> I would like us to try and see to make this happen. I really dislike
> that struct inode is full of non-explicity types.

Presumably this would include moving all of the filesystems to use
inode->i_ino instead of their own private file ID number, e.g. the NFS
issue pointed out in the original patch?  If not, I think most of us
in the LSM/audit space still have a need for a filesystem agnostic way
to determine the inode number from an inode struct.

--=20
paul-moore.com
