Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E115B109
	for <audit@vger.kernel.org>; Thu,  8 Aug 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151539; cv=none; b=lWnKv5VfMPkRKkrMCsQ7CNO/4FhtbCT05qC9zaIeIpgxNUqqIlOssjPTuQ6ie5moWyd0xVwvjvY9S1DF0saqD9U/y83J/IM6zgQgkF5wMdcY41st0xQSs0YEH8tKAIFl72PCU6l4yudoABPUWOyQO0YOYQcoFQQ1dhnB4PpTfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151539; c=relaxed/simple;
	bh=O+UVqcoHQqk/v26aJQY7cg5NLBWtOU+yxnENsZBLbBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=athKg8GwlMvyZ/m0aylbrnZVhk/tIdyNahEvH2kUqMFQJB3OXKlPM5XeRIvM7xKt0GyLL7egLDJZL9m74rjiMR5Xm424AUspm21BvUHoIA9w3MdhbNTP7waUZkUfPwXTIz0prc2odwKoHlWTJQcM51DbdqdMqhgcYx3M2BXXNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f18Au8cH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f18Au8cH"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-68d30057ae9so13205267b3.1
        for <audit@vger.kernel.org>; Thu, 08 Aug 2024 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723151537; x=1723756337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TVmurDZ09S8wToJn0zhvU/nJNzMoT0MyGdFWp7IEvY=;
        b=f18Au8cHK8vkuvyT4vO3CU3J4H0e6dbg0zv4QxSfl17uRKXJNyXteoWTRjgetkpXTK
         a8e9Y68XOE86ar2hY+MUEKCKibSUbMXHsA8sYcy7U7dIdIr2PhhqbGr2TjyhJ1vgCcec
         SwOdO1Lhkq49LrMANzJcYaQj1f/sm3svBi8YXKw94wGq8Z331hxSsJLLzw+o1NWpbTtb
         bmNhOi2Ct/E31GEB5CFJ4dXbqAjUuDGQutDYFoqXZ4O1i4GZXh0pFU5ONq7ku9rS0ly1
         Qd+1/F6H5Gk1JkCHbpow25PBymD/Cg7Cq1YLySMM/YAyQChL8e7tQJlGShMxsR1kQ1Ez
         U46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151537; x=1723756337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TVmurDZ09S8wToJn0zhvU/nJNzMoT0MyGdFWp7IEvY=;
        b=vL+dybMh4PtxZZDvg5yuRipdg+mwICgYewbYRqPwRw60WT84gxUAqtDkV8q7Ig015M
         UGUwj0VvD1/ezfXAibfoYPqBO6LXFEBnvsQR05+g7PGtajvmr8sLldwP+V1SgPYbAICC
         aP2RPuBhbOQJO/TB6ZGBXXnTzkdjn5IXV0jXQee37p6xyhFP8WPjri3+aVqleKEWafs1
         83YRXGf5/u06vXJYt/s4AMDMXoNzambKIDkcqj/a+oHozAZR5GHBTfI3FIVJgxNi/UUd
         ptZ9z0XIR6PJ/+2/73Xig9qYekItNjenAYww7Ta0eYHi7GudXcJ3RmGUt+Za8jMkHFPl
         98NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAHLOzvHMoWozIhl+Vngl2gwYzz0xEVkc/icilfxFlT8hstUF7nZ8FY99wZebqusNo1rsMm7p+3RWzgMrBklDHqvHuoAU=
X-Gm-Message-State: AOJu0Yz/XAmAx2xJy48HZngaVLtLA/jSVYKuOjTE3wJWZg19aKoNXyzm
	+PF1Wku/Hnc43aiyD5pY0ihZkVm7HbTaMsSakDk1xiVk2VHZLmGMWJYZXN3oad7MA9j4nSfg2sp
	/8rgiYsu+D78hBBWLTu6XmOKnljorg+VfKzjX
X-Google-Smtp-Source: AGHT+IFTPM6nWSmvE7FKoGAYxO2XaBlQV5+bjiWpCo8wSNYJn5sGxam/KrmJza+vfkACVNFh7nxdYhVFruYr16TUWgs=
X-Received: by 2002:a05:690c:668e:b0:65c:2536:bea2 with SMTP id
 00721157ae682-69bf81dda1amr37402877b3.19.1723151536654; Thu, 08 Aug 2024
 14:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner> <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner> <20240808171130.5alxaa5qz3br6cde@quack3>
In-Reply-To: <20240808171130.5alxaa5qz3br6cde@quack3>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 17:12:05 -0400
Message-ID: <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> > On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> > > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > > > +static struct dentry *lookup_fast_for_open(struct nameidata *nd,=
 int open_flag)
> > > > > +{
> > > > > +       struct dentry *dentry;
> > > > > +
> > > > > +       if (open_flag & O_CREAT) {
> > > > > +               /* Don't bother on an O_EXCL create */
> > > > > +               if (open_flag & O_EXCL)
> > > > > +                       return NULL;
> > > > > +
> > > > > +               /*
> > > > > +                * FIXME: If auditing is enabled, then we'll have=
 to unlazy to
> > > > > +                * use the dentry. For now, don't do this, since =
it shifts
> > > > > +                * contention from parent's i_rwsem to its d_lock=
ref spinlock.
> > > > > +                * Reconsider this once dentry refcounting handle=
s heavy
> > > > > +                * contention better.
> > > > > +                */
> > > > > +               if ((nd->flags & LOOKUP_RCU) && !audit_dummy_cont=
ext())
> > > > > +                       return NULL;
> > > >
> > > > Hm, the audit_inode() on the parent is done independent of whether =
the
> > > > file was actually created or not. But the audit_inode() on the file
> > > > itself is only done when it was actually created. Imho, there's no =
need
> > > > to do audit_inode() on the parent when we immediately find that fil=
e
> > > > already existed. If we accept that then this makes the change a lot
> > > > simpler.
> > > >
> > > > The inconsistency would partially remain though. When the file does=
n't
> > > > exist audit_inode() on the parent is called but by the time we've
> > > > grabbed the inode lock someone else might already have created the =
file
> > > > and then again we wouldn't audit_inode() on the file but we would h=
ave
> > > > on the parent.
> > > >
> > > > I think that's fine. But if that's bothersome the more aggressive t=
hing
> > > > to do would be to pull that audit_inode() on the parent further dow=
n
> > > > after we created the file. Imho, that should be fine?...
> > > >
> > > > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref_t=
ype=3Dheads
> > > > for a completely untested draft of what I mean.
> > >
> > > Yeah, that's a lot simpler. That said, my experience when I've worked
> > > with audit in the past is that people who are using it are _very_
> > > sensitive to changes of when records get emitted or not. I don't like
> > > this, because I think the rules here are ad-hoc and somewhat arbitrar=
y,
> > > but keeping everything working exactly the same has been my MO whenev=
er
> > > I have to work in there.
> > >
> > > If a certain access pattern suddenly generates a different set of
> > > records (or some are missing, as would be in this case), we might get
> > > bug reports about this. I'm ok with simplifying this code in the way
> > > you suggest, but we may want to do it in a patch on top of mine, to
> > > make it simple to revert later if that becomes necessary.
> >
> > Fwiw, even with the rearranged checks in v3 of the patch audit records
> > will be dropped because we may find a positive dentry but the path may
> > have trailing slashes. At that point we just return without audit
> > whereas before we always would've done that audit.
> >
> > Honestly, we should move that audit event as right now it's just really
> > weird and see if that works. Otherwise the change is somewhat horrible
> > complicating the already convoluted logic even more.
> >
> > So I'm appending the patches that I have on top of your patch in
> > vfs.misc. Can you (other as well ofc) take a look and tell me whether
> > that's not breaking anything completely other than later audit events?
>
> The changes look good as far as I'm concerned but let me CC audit guys if
> they have some thoughts regarding the change in generating audit event fo=
r
> the parent. Paul, does it matter if open(O_CREAT) doesn't generate audit
> event for the parent when we are failing open due to trailing slashes in
> the pathname? Essentially we are speaking about moving:
>
>         audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
>
> from open_last_lookups() into lookup_open().

Thanks for adding the audit mailing list to the CC, Jan.  I would ask
for others to do the same when discussing changes that could impact
audit (similar requests for the LSM framework, SELinux, etc.).

The inode/path logging in audit is ... something.  I have a
longstanding todo item to go revisit the audit inode logging, both to
fix some known bugs, and see what we can improve (I'm guessing quite a
bit).  Unfortunately, there is always something else which is burning
a little bit hotter and I haven't been able to get to it yet.

The general idea with audit is that you want to record the information
both on success and failure.  It's easy to understand the success
case, as it is a record of what actually happened on the system, but
you also want to record the failure case as it can provide some
insight on what a process/user is attempting to do, and that can be
very important for certain classes of users.  I haven't dug into the
patches in Christian's tree, but in general I think Jeff's guidance
about not changing what is recorded in the audit log is probably good
advice (there will surely be exceptions to that, but it's still good
guidance).

--=20
paul-moore.com
