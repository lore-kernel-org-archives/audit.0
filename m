Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD51CF9A
	for <audit@vger.kernel.org>; Thu,  2 Nov 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FwVFPmZz"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04808FB
	for <audit@vger.kernel.org>; Thu,  2 Nov 2023 08:42:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so1064173276.3
        for <audit@vger.kernel.org>; Thu, 02 Nov 2023 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698939776; x=1699544576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E7T8CIrv9yDfqcRHQMpSQFmtSen7a5lIlITj50C6kM=;
        b=FwVFPmZz7zSXsJ8nbF0A5jHNJdkALvqbMp2iM4U27tU4rqT4m5t/8rZbsegEf4Q7RF
         rFr7RRFUhgv3QM/FcpPFL2Cu2P1/5LCuI4vmA+6niUyQuO0IoaYOOU/qxCBmXU9eW2B9
         MmOToRsTv7v7+KzQ69Fw4x5nPW5B8i0CnwBLjWZPTBbeIGQvmEtL/ehC48VVciBHz4mB
         vKKIOHwK399qk6i4A1DXsO05wVIQhwQTigs2BAroIOl51tLnD6m/7GerkdHtYuPnuZoM
         bCWTvljXkUlO8HG3TgR5AaSTGtdzb+AQw176IsuDGjwi7nYr3S+h7bgsV4ixwqc8dLfV
         DNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939776; x=1699544576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E7T8CIrv9yDfqcRHQMpSQFmtSen7a5lIlITj50C6kM=;
        b=jBvAm9Id8WT52dOwb4LlrHLdZzI/1XszRfXO263mHtOCB1oUcrHCjW1Cd6uA8z4kRb
         wXRcznDRyItAZh20q75AofFyDnV2UlNUQAr/VOBMWwt1cloqVYWUwM1oSlUsm/qiAYoz
         0LkAP88EKSpiD17TD04cshBj3igAGMB3ZlajNsxHY8FIwM0y7oN1X5XaJ8Uo3YuVC78E
         NXSDtgwWDj6TiwGHUTB+6sWrw+9iu7N/+uzI+QfR40cVq/AZkHC8MQMo3pibaiJ7Sf53
         dGSQ3LcKv1TpKNjOQb0kwtgFaeg1QfGwKlXWFAIrye7mE6O8YBvpsH4EBDmXimvodlEO
         8ucg==
X-Gm-Message-State: AOJu0Yz5MOMmI9fUuJBBF2LloIbNdskaAWM1PIZyDGd3mNtVQlx6d9ZZ
	WPhqqQ8IUAbJa1KF7IpzLaCn/pz8hxtlD6fvaPlx
X-Google-Smtp-Source: AGHT+IGo4vUVozAmcYzOfainqhqq+QqMlwzYt3mI6XpLnwd1GLe5ROZVDsoAJ+frlmFHCfNhzkAQrllLK9jpUOCxhgY=
X-Received: by 2002:a5b:1ca:0:b0:c4b:ada8:8b86 with SMTP id
 f10-20020a5b01ca000000b00c4bada88b86mr17908798ybp.64.1698939776140; Thu, 02
 Nov 2023 08:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696457386-3010-16-git-send-email-wufan@linux.microsoft.com>
 <6efb7a80ba0eb3e02b3ae7a5c0a210f3.paul@paul-moore.com> <CAHC9VhQJkcb-k+o+NvVn7crrMMZqpBcZpnEbKBT+eZg4Ocjqhw@mail.gmail.com>
 <20231102025355.GA1498@sol.localdomain>
In-Reply-To: <20231102025355.GA1498@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Nov 2023 11:42:45 -0400
Message-ID: <CAHC9VhScaajDOVpBoGPo80ceUggGyrP24pCoMy6d6uQ4r-WZjw@mail.gmail.com>
Subject: Re: [PATCH RFC v11 15/19] fsverity: consume builtin signature via LSM hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-block@vger.kernel.org, dm-devel@redhat.com, audit@vger.kernel.org, 
	roberto.sassu@huawei.com, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 10:54=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> On Wed, Nov 01, 2023 at 08:40:06PM -0400, Paul Moore wrote:
> > On Mon, Oct 23, 2023 at 11:52=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> > > >
> > > > fsverity represents a mechanism to support both integrity and
> > > > authenticity protection of a file, supporting both signed and unsig=
ned
> > > > digests.
> > > >
> > > > An LSM which controls access to a resource based on authenticity an=
d
> > > > integrity of said resource, can then use this data to make an infor=
med
> > > > decision on the authorization (provided by the LSM's policy) of sai=
d
> > > > claim.
> > > >
> > > > This effectively allows the extension of a policy enforcement layer=
 in
> > > > LSM for fsverity, allowing for more granular control of how a
> > > > particular authenticity claim can be used. For example, "all (built=
-in)
> > > > signed fsverity files should be allowed to execute, but only these
> > > > hashes are allowed to be loaded as kernel modules".
> > > >
> > > > This enforcement must be done in kernel space, as a userspace only
> > > > solution would fail a simple litmus test: Download a self-contained
> > > > malicious binary that never touches the userspace stack. This
> > > > binary would still be able to execute.
> > > >
> > > > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > > > ---
> > > > v1-v6:
> > > >   + Not present
> > > >
> > > > v7:
> > > >   Introduced
> > > >
> > > > v8:
> > > >   + Split fs/verity/ changes and security/ changes into separate pa=
tches
> > > >   + Change signature of fsverity_create_info to accept non-const in=
ode
> > > >   + Change signature of fsverity_verify_signature to accept non-con=
st inode
> > > >   + Don't cast-away const from inode.
> > > >   + Digest functionality dropped in favor of:
> > > >     ("fs-verity: define a function to return the integrity protecte=
d
> > > >       file digest")
> > > >   + Reworded commit description and title to match changes.
> > > >   + Fix a bug wherein no LSM implements the particular fsverity @na=
me
> > > >     (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.
> > > >
> > > > v9:
> > > >   + No changes
> > > >
> > > > v10:
> > > >   + Rename the signature blob key
> > > >   + Cleanup redundant code
> > > >   + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATUR=
ES
> > > >
> > > > v11:
> > > >   + No changes
> > > > ---
> > > >  fs/verity/fsverity_private.h |  2 +-
> > > >  fs/verity/open.c             | 26 +++++++++++++++++++++++++-
> > > >  include/linux/fsverity.h     |  2 ++
> > > >  3 files changed, 28 insertions(+), 2 deletions(-)
> > >
> > > We need an ACK from some VFS folks on this.
> >
> > Eric and/or Ted, can we get either an ACK or some feedback on this patc=
h?
> >
> > For reference, the full patchset can be found on lore at the link below=
:
> >
> > https://lore.kernel.org/linux-security-module/1696457386-3010-1-git-sen=
d-email-wufan@linux.microsoft.com/
>
> Well, technically I already gave some (minor) feedback on this exact patc=
h, and
> it's not yet been addressed:
> https://lore.kernel.org/linux-security-module/20231005022707.GA1688@quark=
.localdomain/

Hopefully Fan can comment on that, unless I'm forgetting some
implementation details it seems like a reasonable request.

> Of course, it would also be nice if the commit message mentioned what the=
 patch
> actually does.

While I think the commit description does provide a reasonable summary
of IPE as it relates to fsverify, I agree that the specifics of the
changes presented in the patch are lacking.  Fan, could you update the
commit description to add a paragraph explaining what IPE would do in
the security_inode_setsecurity() hook called from within
fsverity_inode_setsecurity()?

> At a higher level, I've said before, I'm not super happy about the use of
> fsverity builtin signatures growing.  (For some of the reasons why, see t=
he
> guidance in the fsverity documentation at
> https://docs.kernel.org/filesystems/fsverity.html#built-in-signature-veri=
fication)
> That being said, if the people who are doing the broader review of IPE be=
lieve
> this is how its fsverity integration should work, I can live with that ..=
.

Fan can surely elaborate on this more, but my understanding is that
IPE can help provide the missing authorization piece.

> ... I don't
> intend to block the IPE patchset if enough people want it to be merged.  =
I've
> really been hoping to see engagement with the people involved in IMA, as =
IPE
> basically duplicates/replaces IMA.  But I haven't seen that, so maybe thi=
ngs
> need to move on without them.

We are getting a bit beyond the integration of IPE and fsverity so I
don't want to spend a lot of time here, but IPE and IMA work quite a
bit differently as they serve different purposes.  IPE provides a file
authorization mechanism that grants access based on the specified
policy and the file's underlying backing store; IPE does not measure
files like IMA to provide additional integrity checking, it relies on
the storage medium's integrity mechanisms.

I have no doubt Fan could provide a much better summary if needed, and
of course there are the documentation patches in the patchset too.

--=20
paul-moore.com
