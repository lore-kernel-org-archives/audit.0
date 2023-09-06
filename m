Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE0EE14C3
	for <audit@archiver.kernel.org>; Wed,  6 Sep 2023 19:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbjIFT46 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 6 Sep 2023 15:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbjIFT44 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 6 Sep 2023 15:56:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC39198B
        for <audit@vger.kernel.org>; Wed,  6 Sep 2023 12:56:53 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5924093a9b2so2483267b3.2
        for <audit@vger.kernel.org>; Wed, 06 Sep 2023 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694030212; x=1694635012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slr1TR6j9qqq0A8NC8i7MNzWH4qVMUYfWV70ySsnkt8=;
        b=SvhOpCNl9oWiGh3YKjkzcWRqiW3LsZ61948z1dM70Rb/q6B33Ta8TQqnYDzV8nJEKI
         APD9NmD1dWrw21InEP01PV2gd8bZ4/mkogYbYzOrTwKAzzdJVLBp3KBh3Zk8oyx/Abhr
         WMZDD38OT5D5MndoQey/PEvfvxEQYi/cctj1MRYee1YCp0J4GzKDd5tS2RGubE9yq7yY
         NZ+OXzto7zsAE8PHNsHuwg1eMfFTelcH0ZVc7PHahCAf0Pg7nyqOkF+QhphnvqDMI1o2
         AWAH+TN/chC5dI2b9BBVuclL8UMAIWD7jsxwWi3kvC1UYcxstTEdElRh4gkL0uqj91To
         NB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030212; x=1694635012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slr1TR6j9qqq0A8NC8i7MNzWH4qVMUYfWV70ySsnkt8=;
        b=D7CIGBbvpwRkuxfq0GB7hae3UuAXTi7/S67TrML8uc0vjzpttFu86B/JhVxBlm2W/A
         w1hudAL62DHaa33E6f+SBZn5NwrihgkbqoDLYuW2wZmoXM3GuGoGU1qVkYCz8Fncf6Gg
         UTykMPcvtumZJy4B4ON0Jj/Lev58odTPkKblRqFjWr55ofv1Q6Mx9e5jJt23o9GOu4rW
         vWsGKKdWtbqsO0q5AO5OMdXumtuhmU/fu9s+6xLrKB+shD92qPPsIg/k0wkedR1aFDHH
         0u/+lfzugDnJciDuLfYXVyOPpSPMubS7mWCMdyMGYHkC8As8Y+K4lFSvR2lBngnpIjEV
         JO8w==
X-Gm-Message-State: AOJu0YznMQQhZBwgkFdyQqN8JUcUDSf5jdMCjvwauBvjNKGjGMhx3qvy
        dj8E9YFUF8TozRYOIh8kTYnWg9I7yVfzMyElI7iE
X-Google-Smtp-Source: AGHT+IENsc2cP1CEELaKlEdzVh8TU2JwZ5Fr62On2WW48CQi21tGAu2vNykWdRaKNMazfI2xRd1s5Ae7OyO8F3+0z3M=
X-Received: by 2002:a0d:fcc7:0:b0:561:206a:ee52 with SMTP id
 m190-20020a0dfcc7000000b00561206aee52mr18671176ywf.24.1694030212208; Wed, 06
 Sep 2023 12:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230906094202.1712-1-pablo@netfilter.org> <ZPhjYkRpUvfqPB9F@orbyte.nwl.cc>
 <ZPhm1mf0GaeQUr0e@calendula> <ZPiyGC+TfRgyOabJ@orbyte.nwl.cc> <ZPjJAicFFam5AFIq@calendula>
In-Reply-To: <ZPjJAicFFam5AFIq@calendula>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Sep 2023 15:56:41 -0400
Message-ID: <CAHC9VhQ0n8Ezef8wYC7uV-MHccqHobYxoB3VYoC9TaGiFm9noQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_tables: Unbreak audit log reset
To:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Sep 6, 2023 at 2:46=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
> On Wed, Sep 06, 2023 at 07:08:40PM +0200, Phil Sutter wrote:
> [...]
> > The last six come from the 'reset rules table t1' command. While on one
> > hand it looks like nftables fits only three rules into a single skb,
> > your fix seems to have a problem in that it doesn't subtract s_idx from
> > *idx.
>
> Please, feel free to follow up to refine, thanks.

Forgive me if I'm wrong, but it sounds as though Phil was pointing out
a bug and not an area of refinement, is that correct Phil?

If it is a bug, please submit a fix for this as soon as possible Pablo.

--=20
paul-moore.com
