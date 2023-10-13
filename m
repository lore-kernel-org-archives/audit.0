Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E5C41513
	for <audit@archiver.kernel.org>; Fri, 13 Oct 2023 15:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJMP4Y (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 13 Oct 2023 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjJMP4W (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 13 Oct 2023 11:56:22 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B138CF
        for <audit@vger.kernel.org>; Fri, 13 Oct 2023 08:56:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a398f411fso2487141276.3
        for <audit@vger.kernel.org>; Fri, 13 Oct 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697212579; x=1697817379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0yw+CFuDh10RyhhefXLHYNHA/qI4qOiPx4CaxHxNOw=;
        b=bCW8Xu5b9anD+BecsfonFnyGcIPK+TDprNkAF/sYFCcBPa5t5rwkoidqc5CLpyyL4t
         FjvLztggmk+g/nt8Ah7Nc4esJd8pNKI8uQPgAq9vvdhEsaSoJMjVoOauKaiScf0dQtmm
         Ymz2doe7qvThAG/S7QSAA8MZpinXXf/Fxc4xO8ci2r2fbHLLBKi/L1oZ3/6rto+htoDj
         6CCAm+YjH63xpJ2Ggivi0MYP13mwKelDFPKZ61u23YI73muhOZjOSd//Bbohng2sDlM3
         i6pRCjG2sZMhBENrxmALYMZVbRFFamHA9yp6/Uo01Njzayi3mX0Tlbvsl+1z1JEmW7JJ
         Fbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212579; x=1697817379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0yw+CFuDh10RyhhefXLHYNHA/qI4qOiPx4CaxHxNOw=;
        b=TB7WZLtrtdCoJk3ygQX5C4iWsmnfjRlgKtANIt2Ft2xOfZTk//2Ml+s9OQQ8U4zgt7
         um2XnHjNpVZKKI2UJWrKJloU/0okbllzNtoBbkUFvj7ncpgo6PNAxh5QQdUFu0pyLxVB
         LE3ugp/KRn7lf9h1z7Hmpv1PhAc0F3WG2j7x0D9vbLZmoHbGJj98Yq24URo2Z1EQJeAl
         JokML9MO8jnUQx0wzn3MCWsj8uWuxjvmyIpqaZmaZfybhPvohrqmCtqC7WXKhsQm3Y/x
         2ALUykR6CCEkDvjL2l7Ee3ggvda617xTIFFj98r6eELeKW5u82CDaNrrEs30zMn2TB7a
         C3BA==
X-Gm-Message-State: AOJu0Yzd44leIg07384XMWdA3qjfiLrlx1pU/CA7G3zHNSpbSUVBEWxH
        MZOsJOhkHmDMrJBSlTE71R6bdh3mSv7RTRgaIujU
X-Google-Smtp-Source: AGHT+IFrNlMLzAt1s52eQvCEPNKD+SMcTGna2DftYwO7Oiu/NC0wnl91fpg6X6PKDmzr9pI4YudyatXR0d/DSe617vo=
X-Received: by 2002:a25:cad3:0:b0:d9a:e224:1822 with SMTP id
 a202-20020a25cad3000000b00d9ae2241822mr4125826ybg.11.1697212579284; Fri, 13
 Oct 2023 08:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
In-Reply-To: <20231013-karierte-mehrzahl-6a938035609e@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Oct 2023 11:56:08 -0400
Message-ID: <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dan Clash <daclash@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
        audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Oct 13, 2023 at 11:44=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
> > An io_uring openat operation can update an audit reference count
> > from multiple threads resulting in the call trace below.
> >
> > A call to io_uring_submit() with a single openat op with a flag of
> > IOSQE_ASYNC results in the following reference count updates.
> >
> > These first part of the system call performs two increments that do not=
 race.
> >
> > [...]
>
> Picking this up as is. Let me know if this needs another tree.

Whoa.  A couple of things:

* Please don't merge patches into an upstream tree if all of the
affected subsystems haven't ACK'd the patch.  I know you've got your
boilerplate below about ACKs *after* the merge, which is fine, but I
find it breaks decorum a bit to merge patches without an explicit ACK
or even just a "looks good to me" from all of the relevant subsystems.
Of course there are exceptions for important patches that are rotting
on the mailing lists, but I don't believe that to be the case here.

* You didn't mention if you've marked this for stable or if you're
going to send this up to Linus now or wait for the merge window.  At a
minimum this should be marked for stable, and I believe it should also
be sent up to Linus prior to the v6.6 release; I'm guessing that is
what you're planning to do, but you didn't mention it here.

Regardless, as I mentioned in my last email (I think our last emails
raced a bit), I'm okay with this change, please add my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] audit,io_uring: io_uring openat triggers audit reference count unde=
rflow
>       https://git.kernel.org/vfs/vfs/c/c6f4350ced79

--=20
paul-moore.com
