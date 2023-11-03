Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C224215
	for <audit@vger.kernel.org>; Fri,  3 Nov 2023 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OSnCDqWe"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F02D5A
	for <audit@vger.kernel.org>; Fri,  3 Nov 2023 15:15:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d81d09d883dso2636353276.0
        for <audit@vger.kernel.org>; Fri, 03 Nov 2023 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699049754; x=1699654554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccOCsVenhg7pWMdO3laccrRAXnIeEc+431O9cttQg7I=;
        b=OSnCDqWeIzqFkJFw0JIMR4iLA9VyIF68FFXdAw+eGAIls0bJjIfQUjFgl7Mu5OND0n
         ze9cemaWQR9ZxDT/Fl+OdqLmAu5G9O5j84Om6Lw5LN0ZMofsh/nMhQIiHfthEsT6ibYz
         DIURQuH4QCQvWsZV7xlUsJZuuPGMiGvFhj8/ij0GLSTfAhQPMb7RVsp+TjHhfVsxyQOO
         tssqLGNYXQuAWaAM+llRNLXnhL3bJhrG6LHgL38yjLzDR8h9/MJP5SNXyqBn+UtMTmz/
         wui6bugClKmc7ovx0bOofRHLio3pU0bCip+7ODGAJQfvbhIkPXNnI2ZjPrznR12mCV/W
         ZJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049754; x=1699654554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccOCsVenhg7pWMdO3laccrRAXnIeEc+431O9cttQg7I=;
        b=HDXaTeP0LRkqX+p9SHwaQALMVVVp8kIC/SY5+wWtW5a8YiqLKU5Eh3N4IKBN/Y2aZR
         Ju7mG+wuzOlhAIjDrW13t/uwiL3qF9v4K1usCzf1IxE7meeYobNs83kzDIf1aJACzBdL
         XxOx/eUtn3j8SkWshjFUroHxPL7a7oyXvQ1Hl1QWDXBiqHkZKILHFur4xY0OZZgLF4dI
         p8RrTNItyyI5BJnhIqzy/qrLJR1jeJrga2OXIZFc4rxuxpBtWCmCbUEFnku+irEFWxnv
         uraHD+i6H95zAHOWKoSB4beC5wn1CwJAZh/DPh9zoxS3XIVi9L2gMgnI5oUeww77Wjb6
         ebrA==
X-Gm-Message-State: AOJu0YzvkrDGevfy+rrBqt6tx8wNXwgwJgdv6zno1FvZsLPNSMrndDNm
	7+bAf+OBqdsMpfeVt2m4jZN1EHWqg1bBIAZAC96D
X-Google-Smtp-Source: AGHT+IFXMOMQ73ZCAvSg6LD6VZpXmYTcSO6q5zw8IRAbMI+vp7J9LIJ0t0H+f7n6Vr/G+r+30PRzXEL4q0W7UTYfaRI=
X-Received: by 2002:a25:7652:0:b0:d9c:c79:ca1c with SMTP id
 r79-20020a257652000000b00d9c0c79ca1cmr23470882ybc.55.1699049754011; Fri, 03
 Nov 2023 15:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696457386-3010-6-git-send-email-wufan@linux.microsoft.com>
 <c53599e9d278fc55be30e3bac9411328.paul@paul-moore.com> <616a6fd7-47b1-4b46-af23-46f9b1a3eedf@linux.microsoft.com>
 <CAHC9VhScdtqJeUTTUQVk4D70tTLz4TgU_aRTMRnHa0OARyubaw@mail.gmail.com> <c40cd6a6-5c32-4e72-8831-f87ee0a09324@linux.microsoft.com>
In-Reply-To: <c40cd6a6-5c32-4e72-8831-f87ee0a09324@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Nov 2023 18:15:42 -0400
Message-ID: <CAHC9VhR9scT7V7dvN5zhAYdExORB9arWaR7Gbix1AUtAMDPHcg@mail.gmail.com>
Subject: Re: [PATCH RFC v11 5/19] ipe: introduce 'boot_verified' as a trust provider
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, audit@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 6:46=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 10/26/2023 3:12 PM, Paul Moore wrote:
> > On Thu, Oct 26, 2023 at 5:33=E2=80=AFPM Fan Wu <wufan@linux.microsoft.c=
om> wrote:
> >> On 10/23/2023 8:52 PM, Paul Moore wrote:
> >>> On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>>>
> >>>> IPE is designed to provide system level trust guarantees, this usual=
ly
> >>>> implies that trust starts from bootup with a hardware root of trust,
> >>>> which validates the bootloader. After this, the bootloader verifies =
the
> >>>> kernel and the initramfs.
> >>>>
> >>>> As there's no currently supported integrity method for initramfs, an=
d
> >>>> it's typically already verified by the bootloader, introduce a prope=
rty
> >>>> that causes the first superblock to have an execution to be "pinned"=
,
> >>>> which is typically initramfs.
> >>>>
> >>>> When the "pinned" device is unmounted, it will be "unpinned" and
> >>>> `boot_verified` property will always evaluate to false afterward.
> >>>>
> >>>> We use a pointer with a spin_lock to "pin" the device instead of rcu
> >>>> because rcu synchronization may sleep, which is not allowed when
> >>>> unmounting a device.
> >>>>
> >>>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >> ...
> >>>> ---
> >>>>    security/ipe/eval.c          | 72 +++++++++++++++++++++++++++++++=
++++-
> >>>>    security/ipe/eval.h          |  2 +
> >>>>    security/ipe/hooks.c         | 12 ++++++
> >>>>    security/ipe/hooks.h         |  2 +
> >>>>    security/ipe/ipe.c           |  1 +
> >>>>    security/ipe/policy.h        |  2 +
> >>>>    security/ipe/policy_parser.c | 35 +++++++++++++++++-
> >>>>    7 files changed, 124 insertions(+), 2 deletions(-)

...

> >>>> +/**
> >>>> + * from_pinned - Determine whether @sb is the pinned super_block.
> >>>> + * @sb: Supplies a super_block to check against the pinned super_bl=
ock.
> >>>> + *
> >>>> + * Return:
> >>>> + * * true   - @sb is the pinned super_block
> >>>> + * * false  - @sb is not the pinned super_block
> >>>> + */
> >>>> +static bool from_pinned(const struct super_block *sb)
> >>>> +{
> >>>> +    bool rv;
> >>>> +
> >>>> +    if (!sb)
> >>>> +            return false;
> >>>> +    spin_lock(&pin_lock);
> >>>> +    rv =3D !IS_ERR_OR_NULL(pinned_sb) && pinned_sb =3D=3D sb;
> >>>> +    spin_unlock(&pin_lock);
> >>>
> >>> It's okay for an initial version, but I still think you need to get
> >>> away from this spinlock in from_pinned() as quickly as possible.
> >>> Maybe I'm wrong, but this looks like a major source of lock contentio=
n.
> >>>
> >>> I understand the issue around RCU and the potential for matching on
> >>> a reused buffer/address, but if you modified IPE to have its own LSM
> >>> security blob in super_block::security you could mark the superblock
> >>> when it was mounted and do a lockless lookup here in from_pinned().
> >>
> >> Thank you for the suggestion. After some testing, I discovered that
> >> switching to RCU to pin the super block and using a security blob to
> >> mark a pinned super block works. This approach do avoid many spinlock
> >> operations. I'll incorporate these changes in the next version of the =
patch.
> >
> > I probably wasn't as clear as I should have been, I was thinking of
> > doing away with the @pinned_sb global variable entirely, as well as
> > its associated lock problems and simply marking the initramfs/initrd
> > superblock when it was mounted.  I will admit that I haven't fully
> > thought about all the implementation details, but I think you could
> > leverage the security_sb_mount() hook to set a flag in IPE's
> > superblock metadata when the initramfs was mounted.
>
> I wasn't able to find a way to let LSM pin initramfs/initrd during mount
> time ...

I haven't had to look at the kernel init code in a while, and I don't
recall ever looking at the initramfs code, but I spent some time
digging through the code and I wonder if it would be possible to mark
the initramfs superblock in wait_for_initramfs() via a new LSM hook
using @current->fs->root.mnt->mnt_sb?  Although I'm not completely
sure that it's populated.  Have you already looked at an approach like
this?

> But I think we could replace the global variable with a flag
> variable ipe_sb_state so we could use atomic operation to only mark one
> drive as pinned without any lock. The code will be like:
>
> static void pin_sb(const struct super_block *sb)
> {
>         if (!sb)
>                 return;
>
>         if (!test_and_set_bit_lock(IPE_SB_PINNED, &ipe_sb_state)) {
>                 ipe_sb(sb)->pinned =3D true;
>         }
> }
>
> Would this sound better?
>
> -Fan

--=20
paul-moore.com
