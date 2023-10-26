Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670853E48A
	for <audit@vger.kernel.org>; Thu, 26 Oct 2023 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RXB7vqUA"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260B1B4
	for <audit@vger.kernel.org>; Thu, 26 Oct 2023 15:12:37 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2ea7cc821so930766b6e.1
        for <audit@vger.kernel.org>; Thu, 26 Oct 2023 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698358357; x=1698963157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyK27xM5kbIwxsUoSw19E95taRzCJvDq3pVbOquRTi4=;
        b=RXB7vqUAQsVEoZtRnFcdwYSMSXtc6c9LbA0lTagpouOf01fdEEmMG0mdf4oUFGWoXn
         wX06Td0qAOWNkEHp3LGRHVBIR85hpq6/bixg9NCs4nNMlukR8hX61IFeAyd9vgruIQpk
         lEpnq5MTR7WIRemsye5aM2xL/+e1CHKBCNGb2bdDxYPmdU6COWsEnMRA+T5FG2tqeN4g
         Zw36RqRt4PbyVAeE/GQ4mkaWZ5qIt9qNx0IN9LDpugEg62bd2mMwMzhJDDTebIdtTH9Y
         L3lcvKsF1h9z/rebYStWYhl+G714T4BTrWjvL2WS40q2BSMBlM7CfDqoaI3mE02tXDGJ
         NAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358357; x=1698963157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyK27xM5kbIwxsUoSw19E95taRzCJvDq3pVbOquRTi4=;
        b=imWQRWtJRIMOgRubMTQDG6gVALHSU45iMdRa7Jg2dYe1HikFZ/Iz766X+fZBFUsLVQ
         yFeeXKe7wy3CJYNngsJ2i6XGEY4sdi+wVOXGET15DqQtW2AVz0FlyYeKFqNc8ORDUa+S
         H+C6VCuh0DFil0FtmRCplBBMwOk2wwrwEe/f0mZsvPxZMYBtqEnutl1byldrBk5eK9YS
         QLYuY2Lq7xIC0eHVrVjEK7xgiM/OSOmKiFVKoYWPXZJ9sK+0qC/VOVTueEcbHeohJyMf
         x6OCmOa6tIkUihzXhFNtlZy1HDZIP5T5XlyAMTweG16lwcfBE2o7BMHCtfRnDYLXq1Wa
         01Yg==
X-Gm-Message-State: AOJu0YyMkFsPTi2XDmJl/rezBvvFloiGWG+3F2zxhiIrgslpo/kzzGoL
	BongwEydZ8Kq/4gOIXIFTL2eYFZlDdoTYvPC4Je+
X-Google-Smtp-Source: AGHT+IH4B/F3jSVT6Nn8xcRQnsJ1uiLuOsG9IZM1z8u2NT76JtjnCTm3iCfolyAhImJmOOQWCLxEEJfWlt1eadUfIHE=
X-Received: by 2002:a05:6808:4d9:b0:3b2:e5f2:5a59 with SMTP id
 a25-20020a05680804d900b003b2e5f25a59mr797519oie.35.1698358356906; Thu, 26 Oct
 2023 15:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696457386-3010-6-git-send-email-wufan@linux.microsoft.com>
 <c53599e9d278fc55be30e3bac9411328.paul@paul-moore.com> <616a6fd7-47b1-4b46-af23-46f9b1a3eedf@linux.microsoft.com>
In-Reply-To: <616a6fd7-47b1-4b46-af23-46f9b1a3eedf@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Oct 2023 18:12:26 -0400
Message-ID: <CAHC9VhScdtqJeUTTUQVk4D70tTLz4TgU_aRTMRnHa0OARyubaw@mail.gmail.com>
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

On Thu, Oct 26, 2023 at 5:33=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On 10/23/2023 8:52 PM, Paul Moore wrote:
> > On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>
> >> IPE is designed to provide system level trust guarantees, this usually
> >> implies that trust starts from bootup with a hardware root of trust,
> >> which validates the bootloader. After this, the bootloader verifies th=
e
> >> kernel and the initramfs.
> >>
> >> As there's no currently supported integrity method for initramfs, and
> >> it's typically already verified by the bootloader, introduce a propert=
y
> >> that causes the first superblock to have an execution to be "pinned",
> >> which is typically initramfs.
> >>
> >> When the "pinned" device is unmounted, it will be "unpinned" and
> >> `boot_verified` property will always evaluate to false afterward.
> >>
> >> We use a pointer with a spin_lock to "pin" the device instead of rcu
> >> because rcu synchronization may sleep, which is not allowed when
> >> unmounting a device.
> >>
> >> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ...
> >> ---
> >>   security/ipe/eval.c          | 72 ++++++++++++++++++++++++++++++++++=
+-
> >>   security/ipe/eval.h          |  2 +
> >>   security/ipe/hooks.c         | 12 ++++++
> >>   security/ipe/hooks.h         |  2 +
> >>   security/ipe/ipe.c           |  1 +
> >>   security/ipe/policy.h        |  2 +
> >>   security/ipe/policy_parser.c | 35 +++++++++++++++++-
> >>   7 files changed, 124 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> >> index 8a8bcc5c7d7f..bdac4abc0ddb 100644
> >> --- a/security/ipe/eval.c
> >> +++ b/security/ipe/eval.c
> >> @@ -9,6 +9,7 @@
> >>   #include <linux/file.h>
> >>   #include <linux/sched.h>
> >>   #include <linux/rcupdate.h>
> >> +#include <linux/spinlock.h>
> >>
> >>   #include "ipe.h"
> >>   #include "eval.h"
> >> @@ -16,6 +17,44 @@
> >>
> >>   struct ipe_policy __rcu *ipe_active_policy;
> >>
> >> +static const struct super_block *pinned_sb;
> >> +static DEFINE_SPINLOCK(pin_lock);
> >> +#define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
> >> +
> >> +/**
> >> + * pin_sb - Pin the underlying superblock of @f, marking it as truste=
d.
> >> + * @sb: Supplies a super_block structure to be pinned.
> >> + */
> >> +static void pin_sb(const struct super_block *sb)
> >> +{
> >> +    if (!sb)
> >> +            return;
> >> +    spin_lock(&pin_lock);
> >> +    if (!pinned_sb)
> >> +            pinned_sb =3D sb;
> >> +    spin_unlock(&pin_lock);
> >> +}
> >> +
> >> +/**
> >> + * from_pinned - Determine whether @sb is the pinned super_block.
> >> + * @sb: Supplies a super_block to check against the pinned super_bloc=
k.
> >> + *
> >> + * Return:
> >> + * * true   - @sb is the pinned super_block
> >> + * * false  - @sb is not the pinned super_block
> >> + */
> >> +static bool from_pinned(const struct super_block *sb)
> >> +{
> >> +    bool rv;
> >> +
> >> +    if (!sb)
> >> +            return false;
> >> +    spin_lock(&pin_lock);
> >> +    rv =3D !IS_ERR_OR_NULL(pinned_sb) && pinned_sb =3D=3D sb;
> >> +    spin_unlock(&pin_lock);
> >
> > It's okay for an initial version, but I still think you need to get
> > away from this spinlock in from_pinned() as quickly as possible.
> > Maybe I'm wrong, but this looks like a major source of lock contention.
> >
> > I understand the issue around RCU and the potential for matching on
> > a reused buffer/address, but if you modified IPE to have its own LSM
> > security blob in super_block::security you could mark the superblock
> > when it was mounted and do a lockless lookup here in from_pinned().
>
> Thank you for the suggestion. After some testing, I discovered that
> switching to RCU to pin the super block and using a security blob to
> mark a pinned super block works. This approach do avoid many spinlock
> operations. I'll incorporate these changes in the next version of the pat=
ch.

I probably wasn't as clear as I should have been, I was thinking of
doing away with the @pinned_sb global variable entirely, as well as
its associated lock problems and simply marking the initramfs/initrd
superblock when it was mounted.  I will admit that I haven't fully
thought about all the implementation details, but I think you could
leverage the security_sb_mount() hook to set a flag in IPE's
superblock metadata when the initramfs was mounted.

--
paul-moore.com
