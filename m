Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D398C6FD1D
	for <audit@archiver.kernel.org>; Fri, 17 Mar 2023 21:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQVaP (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 17 Mar 2023 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQVaO (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:14 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73B21977
        for <audit@vger.kernel.org>; Fri, 17 Mar 2023 14:29:26 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id i24so7166478qtm.6
        for <audit@vger.kernel.org>; Fri, 17 Mar 2023 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74hpKbybG/zGoZI9G2CYpMbOVE4AuEECFGt5DlMCgIs=;
        b=aKK4aGHWGxMkim/WoEtlwcllX72PearY9DBfsbXaqfDVjOy0F08sGRy2qxZCPaeGLk
         v0LG0F8DwzCn9CHnoukgVd9MS3o3mCIjtxsbIcnyv1zNejzlkpezxddMoxJkk4mFcZPc
         qdt+2lvq77mert1zFeEtOweHrjOFQ8J1c8czkaPtiJv0rS3Kwc5EDzoUqcJLMTll6zP7
         CipAbPOo9rebs7+mz04vp0F2bXvYirVUV2NHeF5D46earWSHYvXQmZNtN0Va8kiSCy6d
         IGIyv80SGntRwD2yH8vpnw+fKqE78whezsR0Pf4yTLRhEpcbSHE589kC6W1mz83z4qQs
         FrNg==
X-Gm-Message-State: AO0yUKVqvNouTvLgk989F4jnPbeQZB1JoIHKcEnuzVw1DBX6NopysaCQ
        9EuM9lFBB1v+9xt9msvibUEG
X-Google-Smtp-Source: AK7set9ZLKSM6EiLDPWzjcge7jruT1aFdqM8FlQ+ab7okXXatbx/IBhdTJ9xFEiPkivpMASpdzXRwA==
X-Received: by 2002:ac8:5e51:0:b0:3d6:88a0:7a5 with SMTP id i17-20020ac85e51000000b003d688a007a5mr15348985qtx.37.1679088565343;
        Fri, 17 Mar 2023 14:29:25 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a72-20020ae9e84b000000b00745a3b63569sm2377074qkg.107.2023.03.17.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:29:24 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:29:23 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        gyroidos@aisec.fraunhofer.de, Alasdair Kergon <agk@redhat.com>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AUDIT SUBSYSTEM" <audit@vger.kernel.org>
Subject: Re: dm verity: log audit events for dm-verity target
Message-ID: <ZBTbsx69kGXiKMIw@redhat.com>
References: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
 <CAHC9VhQ_zvTqck4A7HvqH2rcwxuato_9nVWMk_Yf=ip3q9omgA@mail.gmail.com>
 <1f58acef-1e93-ed7a-3ad8-dd0927dacddc@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f58acef-1e93-ed7a-3ad8-dd0927dacddc@aisec.fraunhofer.de>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Mar 17 2023 at  4:00P -0400,
Michael Weiß <michael.weiss@aisec.fraunhofer.de> wrote:

> On 02.03.23 03:25, Paul Moore wrote:
> > On Wed, Mar 1, 2023 at 6:34 AM Michael Weiß
> > <michael.weiss@aisec.fraunhofer.de> wrote:
> >>
> >> dm-verity signals integrity violations by returning I/O errors
> >> to user space. To identify integrity violations by a controlling
> >> instance, the kernel audit subsystem can be used to emit audit
> >> events to user space. Analogous to dm-integrity, we also use the
> >> dm-audit submodule allowing to emit audit events on verification
> >> failures of metadata and data blocks as well as if max corrupted
> >> errors are reached.
> >>
> >> The construction and destruction of verity device mappings are
> >> also relevant for auditing a system. Thus, those events are also
> >> logged as audit events.
> >>
> >> We tested this by starting a container with the container manager
> >> (cmld) of GyroidOS which uses a dm-verity protected rootfs image
> >> root.img mapped to /dev/mapper/<uuid>-root. We than manipulated
> >> one block in the underlying image file and reading it from the
> >> protected mapper device again and again until we reach the max
> >> corrupted errors like this:
> >>
> >>   dd if=/dev/urandom of=root.img bs=512 count=1 seek=1000
> >>   for i in range {1..101}; do \
> >>     dd if=/dev/mapper/<uuid>-root of=/dev/null bs=4096 \
> >>        count=1 skip=1000 \
> >>   done
> >>
> >> The resulting audit log looks as follows:
> >>
> >>   type=DM_CTRL msg=audit(1677618791.876:962):
> >>     module=verity op=ctr ppid=4876 pid=29102 auid=0 uid=0 gid=0
> >>     euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=44
> >>     comm="cmld" exe="/usr/sbin/cml/cmld" subj=unconfined
> >>     dev=254:3 error_msg='success' res=1
> >>
> >>   type=DM_EVENT msg=audit(1677619463.786:1074): module=verity
> >>     op=verify-data dev=7:0 sector=1000 res=0
> >>   ...
> >>   type=DM_EVENT msg=audit(1677619596.727:1162): module=verity
> >>     op=verify-data dev=7:0 sector=1000 res=0
> >>
> >>   type=DM_EVENT msg=audit(1677619596.731:1163): module=verity
> >>     op=max-corrupted-errors dev=254:3 sector=? res=0
> >>
> >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> >> ---
> >>  drivers/md/dm-verity-target.c | 20 ++++++++++++++++++--
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > This looks reasonable to me from an audit perspective.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Hi Mike, since Paul already gave his ack from audit perspective,
> do you pick this up? Or is there anything which I can improve from device
> mapper side?

Looks fine, but I haven't started a 6.4 branch yet. I'll pick this up
from dm-devel's patchwork when I do.

Mike
