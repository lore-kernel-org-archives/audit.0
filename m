Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0B15A85F
	for <audit@vger.kernel.org>; Sun, 11 Aug 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723413160; cv=none; b=bBBlAmn/vzpdCzG7+zqlSRmkpNHwkOLI3yg0nJHqchajk0zkS+kBr7J1Xcv9ooxiUFepFLnJDZWV9NTxhUob/w7laIv9QKtoq5WtGpFL9jH4x9JPMTEqPnjDNbr1dIOesRaw+1Xx3xXrNxjhR9EwS1DJyVJgOmP+Lz83W9an5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723413160; c=relaxed/simple;
	bh=lkN+3TiNLpwallZ3vrHXPkv+UXdMUyM6EzKmhH6umec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnJIrPLTUG4qa8pUYx2CUumPTv89hZs2vAmBESQwpUe0NKobKUwkD35qeb6igEDsAYP+B0z/31DIYcf485QY+XjjMwc/EzgIZAEv4oFuBYdh8biYbFzASrjsWMeJ/1ezubEHV2LnwVkgKDbNQe2KwgKftnW7uNV1FPmZBqZG+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KH3Q3Nyr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KH3Q3Nyr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6659e81bc68so38722817b3.0
        for <audit@vger.kernel.org>; Sun, 11 Aug 2024 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723413157; x=1724017957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcvCzrHT6sCG5JT/BAYJjycnIV3Ulp99ay2/Oh7WNDU=;
        b=KH3Q3Nyr5CDK8pSNh0B/KlYcwNxlxEtIszJU/d54P2CbJ60DGletUn6vQUkjXulYAf
         st8sB6nwFA3qOiSlZCMn/ueqt8nBwhynOnghnQMknc5KWY8YiZz31d0b1T5nW4BMQgcU
         orgV7BvpUFCBvr9AZukr0PElLGi3xnktftqh88Pvs8f12ycxB3qfD7Xv0+4+Alp5sfR8
         DLuxiVjNaoglQvFDERvOtceqsehJboZ2212oUY3EEmoz/wjTY5eb6UNlX75fkFJj7sLV
         E0M4zdJy00KAp6tH+4xZG7Er5Zw7zCtMGHzuPKHw58RKKu/rzd58Wy5vKPiDXX29UMbz
         g/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723413157; x=1724017957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcvCzrHT6sCG5JT/BAYJjycnIV3Ulp99ay2/Oh7WNDU=;
        b=gHiXhuITo6ppIPHCt8SNFuUxjbobpUrzdRzynhhIcjND9HC1J+dDJTS5JtpsJgAnwm
         T9vpVLLIEKRmLJL5YWAcsy6vcRhFurVZ+7nfoR97o4x153RWQYTsz0b7ab2WP1kc5wny
         T4RLCXbFuXTO3dqVYr03OiAYol9K1DBw/HG/6yN4Vf3kCg5zJSZOwYmx90oNUi0eSwLE
         6LtpytaVTOGTp65P0cZJLVKbQqMaWW4UOW89DCYVmiofGRmIOQ99rMpgu1WP+iSgQ+Qh
         XwTXWvET5SukZYtg+vM1CNG5wk55/8t1Ee3Jm6itICQQkJk7AO3QI3qbT6B0pYA+Z08r
         mi4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/SNmbGcZNuuzwiH5ZPmnLrDtJLQJfKfuuYsbfBCEkBlOJIgVh7UUDaj8a/Vk/lIs59bsqjr+p8qOYpePZNo5psfuxRQ=
X-Gm-Message-State: AOJu0YyCzjfH+iMpEPwzkxn5pHQwzX9zF27VwDQL3CDjJd/PDMgTVKX8
	Lx33WrAOA/G5N5x3lK1aSTN6McHnprDVbD11QrL/FpNstcHIhz97+mvF5IWWEOFq3wI5/wgZ8v0
	HMXcA+gMLTR5+rtwIGgMxOlhKWl13aZ4TtUTy
X-Google-Smtp-Source: AGHT+IEFAnQowhRq6J95RW92DmycBod9Jt4jIh1EBEgxnj0aFfyybdIHgYhavVKVVj8MFqkpwlaTJmB1wWmj97QKYR0=
X-Received: by 2002:a05:690c:ec8:b0:632:e098:a9e0 with SMTP id
 00721157ae682-69ec49239fbmr92358147b3.9.1723413157487; Sun, 11 Aug 2024
 14:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner> <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner> <20240808171130.5alxaa5qz3br6cde@quack3>
 <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
 <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
 <CAHC9VhREbEAYQUoVrJ3=YHUh2tuL5waUMaXQGG_yzFsMNomRVg@mail.gmail.com>
 <a8e24c94fa5500ee3c99a3dabba452e381512808.camel@kernel.org>
 <CAHC9VhSEuj_70ohbrgHrFv7Y8-MvwH7EwkD_L0=0KhVW-bX=Nw@mail.gmail.com> <cd7133462f3018114f16366bae14ef6504d75b68.camel@kernel.org>
In-Reply-To: <cd7133462f3018114f16366bae14ef6504d75b68.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 11 Aug 2024 17:52:26 -0400
Message-ID: <CAHC9VhQBN1H9b2aTa-OHzowXeR4Y3DzRnF=do5Q5SWDTsbu4cw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:21=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Thu, 2024-08-08 at 21:22 -0400, Paul Moore wrote:
> > On Thu, Aug 8, 2024 at 8:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> > wrote:

...

> > > The question here is about the case where O_CREAT is set, but the
> > > file
> > > already exists. Nothing is being created in that case, so do we
> > > need to
> > > emit an audit record for the parent?
> >
> > As long as the full path information is present in the existing
> > file's
> > audit record it should be okay.
>
> O_CREAT is ignored when the dentry already exists, so doing the same
> thing that we do when O_CREAT isn't set seems reasonable.
>
> We do call this in do_open, which would apply in this case:
>
>         if (!(file->f_mode & FMODE_CREATED))
>                 audit_inode(nd->name, nd->path.dentry, 0);
>
> That should have the necessary path info. If that's the case, then I
> think Christian's cleanup series on top of mine should be OK. I think
> that the only thing that would be missing is the AUDIT_INODE_PARENT
> record for the directory in the case where the dentry already exists,
> which should be superfluous.
>
> ISTR that Red Hat has a pretty extensive testsuite for audit. We might
> want to get them to run their tests on Christian's changes to be sure
> there are no surprises, if they are amenable.

I believe you are thinking of the audit-test project, which started as
a community effort to develop a test suite suitable for the popular
Common Criteria protection profiles of the time (of which auditing was
an important requirement).  Unfortunately, after a couple rounds of
certifications I couldn't get the various companies involved to
continue to maintain the public test suite anymore, so everyone went
their own way with private forks.  I have no idea if the community
project still works, but someone at IBM/RH should have a recent~ish
version that either runs on a modern system or is close to it.  FWIW,
the dead/dormant community project can be found at the link below
(yes, that is a sf.net link):

https://sourceforge.net/projects/audit-test

It's been a while since I've been at RH, so I'm not sure if my test/QA
contacts are still there, but if you don't have a contact at IBM/RH
Jeff let me know and I can try to reach out.

--=20
paul-moore.com
