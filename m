Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75673749D
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qk2NAnk+"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B110D4
	for <audit@vger.kernel.org>; Mon, 23 Oct 2023 20:52:27 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7741b18a06aso313386885a.1
        for <audit@vger.kernel.org>; Mon, 23 Oct 2023 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119546; x=1698724346; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GnPZt7wTu5bHl+yZIdMyk9dSEtxPVy94lr+8pKkfEn4=;
        b=Qk2NAnk+d3PS2nhphbsNh4pXDwIkiF/OEugwNqtX8DEU03CEfroRIc3UcQKLCx0RJB
         c/SnoKoKs7NXwkEjbsod/f2u8PP3uqJdYiRs/R2l+++7jXOlKo3J8QMLftlSgdlmrf+S
         WDpNm7dOHUoRzJI8nxhDZADh7OPpxVkCdKQNTLwgNHsnyxbj6+fDjztk56ap664Rh+ph
         GiJ4k5abmtn8z0O2bAg5QoevXeJcBa4b8IMwN9UzkCbNXv5BiYWoCajzAoBQt0a80b5Z
         nchL+39mHH0b1gi98t637zPu3o3WUyn7fI3B9Y99ScaMgRAxoK5C1XdyDLO4ci0w0AAU
         IysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119546; x=1698724346;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnPZt7wTu5bHl+yZIdMyk9dSEtxPVy94lr+8pKkfEn4=;
        b=vRtKzIQeOJ3p/InkLX8CKLnX2s9CdRUhbxRBuZylLiyTmp8sMuPjAD9o4mrvvWwLwQ
         CMfDBgbhy8IG5jm+s22CchEiLoK2xV4pqO86cZmx4qGpwI4DN2W5ewmpoemny+VCOmdv
         ITU2Yo3eY8mz+Gb9LHWin27XEiSO/+i1JdFzRrd0yR0BqFI81jcMNOnoyNZgdzc+HDH4
         4PbbinALxgUuRtD5I2qes8mYuf5GzwVV0YPxZdQdMnMch5ggd0JYqlcIh9X03O5cOuz+
         +ZpdX7Ps9YcY3OTq6D/F6cfs4VnfRznIt+Ofn0jbSpLWbJ12wtLVrexmED4yt3WUL64C
         F7MA==
X-Gm-Message-State: AOJu0Yxjj4wtZ2Gn7jvMg9H6ZLOYdt4ci8ADU1NSJ0b5GOvybMiO390/
	SMBeo/yXfJWBXrp9vkG5MZd3
X-Google-Smtp-Source: AGHT+IFvSV+EXgEeBKXX2Mm2c4Pu+xlgfjLQsVDGRnKVVxJUbzV3yBw9uUXEzF2i2rsqjzOaeFEfJQ==
X-Received: by 2002:a05:620a:4049:b0:778:9232:a564 with SMTP id i9-20020a05620a404900b007789232a564mr13553158qko.47.1698119546060;
        Mon, 23 Oct 2023 20:52:26 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w12-20020ae9e50c000000b0077407e3d68asm3162408qkf.111.2023.10.23.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:25 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:52:25 -0400
Message-ID: <c53599e9d278fc55be30e3bac9411328.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com, audit@vger.kernel.org, roberto.sassu@huawei.com, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 5/19] ipe: introduce 'boot_verified' as a trust  provider
References: <1696457386-3010-6-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-6-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> IPE is designed to provide system level trust guarantees, this usually
> implies that trust starts from bootup with a hardware root of trust,
> which validates the bootloader. After this, the bootloader verifies the
> kernel and the initramfs.
> 
> As there's no currently supported integrity method for initramfs, and
> it's typically already verified by the bootloader, introduce a property
> that causes the first superblock to have an execution to be "pinned",
> which is typically initramfs.
> 
> When the "pinned" device is unmounted, it will be "unpinned" and
> `boot_verified` property will always evaluate to false afterward.
> 
> We use a pointer with a spin_lock to "pin" the device instead of rcu
> because rcu synchronization may sleep, which is not allowed when
> unmounting a device.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   +No Changes
> 
> v3:
>   + Remove useless caching system
>   + Move ipe_load_properties to this match
>   + Minor changes from checkpatch --strict warnings
> 
> v4:
>   + Remove comments from headers that was missed previously.
>   + Grammatical corrections.
> 
> v5:
>   + No significant changes
> 
> v6:
>   + No changes
> 
> v7:
>   + Reword and refactor patch 04/12 to [09/16], based on changes in the underlying system.
>   + Add common audit function for boolean values
>   + Use common audit function as implementation.
> 
> v8:
>   + No changes
> 
> v9:
>   + No changes
> 
> v10:
>   + Replace struct file with struct super_block
> 
> v11:
>   + Fix code style issues
> ---
>  security/ipe/eval.c          | 72 +++++++++++++++++++++++++++++++++++-
>  security/ipe/eval.h          |  2 +
>  security/ipe/hooks.c         | 12 ++++++
>  security/ipe/hooks.h         |  2 +
>  security/ipe/ipe.c           |  1 +
>  security/ipe/policy.h        |  2 +
>  security/ipe/policy_parser.c | 35 +++++++++++++++++-
>  7 files changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 8a8bcc5c7d7f..bdac4abc0ddb 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -9,6 +9,7 @@
>  #include <linux/file.h>
>  #include <linux/sched.h>
>  #include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
>  
>  #include "ipe.h"
>  #include "eval.h"
> @@ -16,6 +17,44 @@
>  
>  struct ipe_policy __rcu *ipe_active_policy;
>  
> +static const struct super_block *pinned_sb;
> +static DEFINE_SPINLOCK(pin_lock);
> +#define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
> +
> +/**
> + * pin_sb - Pin the underlying superblock of @f, marking it as trusted.
> + * @sb: Supplies a super_block structure to be pinned.
> + */
> +static void pin_sb(const struct super_block *sb)
> +{
> +	if (!sb)
> +		return;
> +	spin_lock(&pin_lock);
> +	if (!pinned_sb)
> +		pinned_sb = sb;
> +	spin_unlock(&pin_lock);
> +}
> +
> +/**
> + * from_pinned - Determine whether @sb is the pinned super_block.
> + * @sb: Supplies a super_block to check against the pinned super_block.
> + *
> + * Return:
> + * * true	- @sb is the pinned super_block
> + * * false	- @sb is not the pinned super_block
> + */
> +static bool from_pinned(const struct super_block *sb)
> +{
> +	bool rv;
> +
> +	if (!sb)
> +		return false;
> +	spin_lock(&pin_lock);
> +	rv = !IS_ERR_OR_NULL(pinned_sb) && pinned_sb == sb;
> +	spin_unlock(&pin_lock);

It's okay for an initial version, but I still think you need to get
away from this spinlock in from_pinned() as quickly as possible.
Maybe I'm wrong, but this looks like a major source of lock contention.

I understand the issue around RCU and the potential for matching on
a reused buffer/address, but if you modified IPE to have its own LSM
security blob in super_block::security you could mark the superblock
when it was mounted and do a lockless lookup here in from_pinned().

> +	return rv;
> +}

--
paul-moore.com
