Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280522F690F
	for <audit@vger.kernel.org>; Mon,  1 Jun 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331289; cv=pass; b=DxKeOYve76ZgP/qMuFHZtosyMig5FNEmwVQgfRmMRLJ4AuM6vjYuQODNtZrSS20dHgour7EGherqSQ8RGl9SGBJid3OcjdAYqLc2l5FAaMHYFA32TBFHH9o71AWRNuYK6mmvU2hyUuOkH9XR9rykfW55lIdsStN0+MWdPxL8NS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331289; c=relaxed/simple;
	bh=qi0bNA92wLl2nMk/hIYTXnmjk9Bfbm5qhtK/24nDsrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdVGs97q6Y/JBqpG7hmSd3gOIEtf7+fCFUZZWkrwmm/L+7/HSDj9Sr1V2lPCiWRsB0t2oDHHIsASDlARiu/uMGfC76lYoyfDZKBgVYfF+ktFI1bDERThzCYrQnMCdjc763hqKpexv51+A6RFyVuuabpIOkE+hT3IX3mXyRUwL9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUXjSj+g; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUXjSj+g"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso1506150a12.3
        for <audit@vger.kernel.org>; Mon, 01 Jun 2026 09:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780331285; cv=none;
        d=google.com; s=arc-20240605;
        b=MSFYyVFJ5Ohk5FEPkdtQy5JaVpNWBOUCNgBbcoaUQfw90JePfeqUE8nFkFYIsPNDtg
         67mc5xXoY7QTJjWNzQtCuEDHR0UtEQjAC9CDSj6o83QQhbpApoUj7p6nllV2rFyYZdwW
         JrCvKlF8/JrLf/odydPE1gTfIchJwHl1QF6qrahY2Qcu5y+7T9v3nAT54O7QWQyNijEC
         n0T/YF+ZYovDTSLFus4ek+Z43Ej2XUV86zKoHQ7Y6xfEzlxJzCa2L8PTR4VtC9aRQncq
         PYmfJEOmDOKGpNu8xZh/rorU8RK2CFszFhPZN105jPtYBdFWEjqTdAGITxY8K/WcRWeH
         EG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        fh=jMRHOMljl8Dv0Dq4gw61M5H7vHSCSifIv5ulAW/E/LM=;
        b=Wsrl7C4oyZNA1JjNk+HLwD6gYWiwANkpoyzuxymF+HY3bP0PKvIxuUjwYjhLeKs4NE
         ylC4aQuKab6taWtpt/FNxChADvgRJ+8nP+c5Moe9g2e982ybFFYREJOZeLawO31+NMJ0
         t3l3iz//9z9MRpuzsZB4uqYkIHvvUYrdzQKcPH3sCyFlZtOtYT5O4X9Zv0e8LZscI1MU
         T1DDRjSUAWSDRDrcnHFYYDPwVkEwJzgPDFBeLUYGCzUw0Jt9ctXxkeuv39STeBcKWqAO
         oO0HXKP7JpS4EpsLTj1wwRbVJ2SLIEdt3/v0yEVYeVu/MusRfbU32gwTziBGWaMBpupf
         xNIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780331285; x=1780936085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        b=dUXjSj+gZhEJ1wkBA3Hx1JpYmkvAvUSX7ehbjhMY8bdJnMF9RArJQMFYfB+bjrQHAe
         SVbCQGt3bTri37mM1s4mF1Nb5snzD107h3zbt2VlHRlH/FbVX+y/6rJ2EJruX/gK7C1m
         dRu6usG75kxEqOsojY43Ytgymj6zmkO4zL6BrscU6NK6P1bnNgcBLWdSWjLfH/zR3nTH
         H+sy/BYXTdaM4ICVqQFdftmCVTZMWQmIZy3NsKDg89ATRjTXPqkPWyxBPBxkmPFHBFeV
         9E1F7W9l22SX+u4/u9ihYgwATE8vyUc4DV5UOuugSjUCz8HE8M3ePwoSWv/dOd1gfAIP
         A2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331285; x=1780936085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        b=kYvUHaonNX3in4MacFLy3/RAbZlEKGWJXrOy7lpvMBe6LBXrSr73rKMQKJRCyQNhFP
         EYi/XPu31bvO9Sk1cs0Lwy+c7XT1jpa3QwfKBR8WcZJeEFB4sXdjfm9VnniUn/lnyJgf
         8+hZeM+XSl/Ox86FRDko+J7dK4BYvIJs6MSWYA/y3QWctpNlYPnwD3bCbGt9te4tU9ps
         Bz3fUNXxVmaaLmWIrtVR62d/Xm7nNA/ntPLwy25grWaIun6NA3CBxTaPaHTDo5ADP9M/
         R7uCgH3X/5Tbo/KC1dB+WPsebx4OXuhXi6LZMJxqXRt9cS8WoXlelDUbu3DDBBOYbYD6
         QrlA==
X-Forwarded-Encrypted: i=1; AFNElJ8fhNr0Ey669Ng4QSqE5OIMeF/IvOAK9gelZ24ZCA7Hmm9KkvnPJd4a/U8mrYtiDVSJP0BV+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BJZImyttk7iJ1mVdRG5Iteyu3eLRodV+XBXucsknCTd9rNDl
	FWVHNQM8jmLRISiSk+cshb+SUjWRUHC18vJiP++tvZSSyR8EXGQlD2l66oRC/NLbOrtfIR4vdga
	VDg8jnGxpGZ3/M3eLYdiJUE82WR8TF7GT1+1mhidC
X-Gm-Gg: Acq92OHjhcJNtJuRZ1QIzmXCXb3kFjPvWzU6ZeNdVL2c481w74LvcQzEAeQhJ1mjA7C
	dH++t83XHsvHqK6eaEBX2mYIiRQWGX6pi4LnRzufN5/1gsGdSkhfDar/I2tnZFLEVz56x9ePWpU
	wq2WKCcoDXzBdDRmKTdbLk+p2XTS49HaSkJv1Zya3PkNRHZq0/EcNn017y7NWa8zolmJwavcN4e
	6TkzRdExxnkazzy+gm8SuReBC2dqqD7dQwcG+H7YnNDRJh0y2pr1JM9vbu/nkDy7OLuU3FJ95DS
	MVp5P7x1ny8u1xcXiw==
X-Received: by 2002:a05:6a21:8ccc:b0:3b3:2703:11c with SMTP id
 adf61e73a8af0-3b427f517f8mr12921664637.37.1780331285033; Mon, 01 Jun 2026
 09:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531182045.171711-1-jkoolstra@xs4all.nl> <20260531182045.171711-6-jkoolstra@xs4all.nl>
 <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
In-Reply-To: <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 12:27:53 -0400
X-Gm-Features: AVHnY4KEv6aJtI3iBUrB4HglIpuGYPQAhy-iIOr2F3ZJYmOy5UkiR3sfOv1CiDw
Message-ID: <CAHC9VhSN1j36Mo0tCOD2EQi0w5dXg_2sOcBw9vEqb1wRdsPh5g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 5/9] vfs: lookup_open(): move audit_inode_child()
 and i_op->create check to before try_break_deleg()
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Eric Paris <eparis@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 10:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> [Paul and Eric - question for you towards the end)
>
> On Mon, 01 Jun 2026, Jori Koolstra wrote:
> > Calling audit_inode_child() and the i_op->create check in lookup_open()
> > take place after the try_break_deleg() call. This does not match the
> > order when doing a regular file create via mknod(2). There the call
> > order is:
> >
> >       filename_mknodat()
> >       vfs_create()
> >       may_create_dentry()
> >       audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE)
> >       i_op->create check
> >       try_break_deleg()
> >
> > In particular, audit_inode_child() is called regardless of whether
> > try_break_deleg() fails.
> >
> > Move move audit_inode_child() and the i_op->create check to before
> > try_break_deleg() in lookup_open().

Adding the audit mailing list to the CC line.  It's almost always
better to CC the list than ping folks directly as we now have the
exchange in the audit archive which makes it easier for audit folks to
find this in the future.

> I don't think this is sufficient.
> I think (and we should confirm we people who know about auditing) that
> the audit call should come before the permission check so that there is
> an audit record on failed attempts.  In that case the
> audit_inode_child() all needs to be much earlier.

As you likely already know, audit_inode_child() exists simply to
record information about the file/inode access, the audit record is
generated later (and can is dependent on other things/config).  For
that reason, yes, it's generally a good idea to call
audit_inode_child() as soon as we have the file/inode information.
Auditors want to know what the user/system attempted to do, even if
the operation failed; in some cases the log of the failed operations
are more useful than the successful ones.

> Alternately if we don't need an audit record for failed attempts - maybe
> the audit_inode(..., AUDIT_INODE_PARENT) is enough?  - then the
> audit_inde_child(..., AUDIT_TYPE_CHILD_CREATE) in may_create_dentry()
> should be after the permission check.
>
> I think you are trying to make the two paths consistent.  I think that
> is a good thing.  I don't think you have achieved it.
>
> I notice that fsnotify_create() ALSO calls audit_inode_child(...
> AUDIT_TYPE_CHILD_CREATE).  Surely we don't need both?
>
> Paul, Eric: can you comment on whether AUDIT_TYPE_CHILD_CREATE() should
> come before permission checks, after checks but before create, or after
> the create?  Or maybe several of those?
> We seem to do it both before in may_create_dentry(), and after in
> fsnotify_create().
>
>
> Thanks,
> NeilBrown
>
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 16dcf537db87..293592a4d011 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4526,17 +4526,18 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> >
> >       /* Negative dentry, just create the file */
> >       if (!dentry->d_inode && (open_flag & O_CREAT)) {
> > -             /* but break the directory lease first! */
> > -             error =3D try_break_deleg(dir_inode, delegated_inode);
> > -             if (error)
> > -                     goto out_dput;
> > -
> >               audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CRE=
ATE);
> > +
> >               if (!dir_inode->i_op->create) {
> >                       error =3D -EACCES;
> >                       goto out_dput;
> >               }
> >
> > +             /* but break the directory lease first! */
> > +             error =3D try_break_deleg(dir_inode, delegated_inode);
> > +             if (error)
> > +                     goto out_dput;
> > +
> >               error =3D dir_inode->i_op->create(idmap, dir_inode, dentr=
y,
> >                                               mode, open_flag & O_EXCL)=
;
> >               if (error)
> > --
> > 2.54.0

--=20
paul-moore.com
