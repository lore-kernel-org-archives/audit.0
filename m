Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0496CDB47E
	for <audit@archiver.kernel.org>; Fri, 13 Oct 2023 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJMQD2 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 13 Oct 2023 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjJMQD2 (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 13 Oct 2023 12:03:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD4BD;
        Fri, 13 Oct 2023 09:03:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE306C433C8;
        Fri, 13 Oct 2023 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697213006;
        bh=mcv6vZBKM2c2x3X7SAMdPBiYtPn9l0sRcjbP8ZSJ5z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrF9MdWF4vAESJ/XDsEGBcBpXrsoKIgrVVO76N7PlbkbgEUGDha7Xm94oXOGXe2Ns
         uWd9TE+aXkxYmIBlXFaafRP2d5mVEkIYhXYAIgygSaUMtXmD1Xkqlr3sILI16n16Ts
         o6j7GxZjNekad8tKLy2idhnP8Yka1MEOWSiLb4vIzwTChKb4fgALRBgTlyN/nsoawS
         t/rEtQPo4av2FBphw+EBSMW/96CvbJ8k87y+kDXM08mIWAX0EtxaF6IHDmIoeFJTUf
         K0Lf5BQz75FTczg6LP2ihMG7AuayOqPgq6qE+cuQv18hDNC0Hn7Y2cu/WOr3sjmEe/
         tRfAX80bPHYbw==
Date:   Fri, 13 Oct 2023 18:03:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Clash <daclash@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
        audit@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Message-ID: <20231013-keilen-erdkruste-7a1154fb0da0@brauner>
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
 <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

> > Picking this up as is. Let me know if this needs another tree.
> 
> Since it's really vfs related, your tree is fine.
> 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> 
> You'll send it in for 6.6, right?

Given that it fixes a bug, yeah. I'll let it sit until Monday so other's
have a moment to speak up though.
