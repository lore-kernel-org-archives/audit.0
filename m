Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF749EE14A9
	for <audit@archiver.kernel.org>; Wed,  6 Sep 2023 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbjIFXZg (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbjIFXZe (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 6 Sep 2023 19:25:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC91739
        for <audit@vger.kernel.org>; Wed,  6 Sep 2023 16:25:31 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58d41109351so20717267b3.1
        for <audit@vger.kernel.org>; Wed, 06 Sep 2023 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694042730; x=1694647530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2kBOi6TalS0ex+1SxjRU4auFtqoVkK5v83q8840CGQ=;
        b=HtisTxbg0/jXajMbSUaZGVb2Ex03a07U0XO8yugtpQ3KkpCRALHle3SRN97vmwyKKo
         D08w0DjWdj1N76/b1PW9reLFp5P4iw3Vg+u1bzo07ilxFvrS1eQmqGrw/kUJ8CMSf4os
         jU2w8B9F+1DMjyoSFgTAjKDyz45zsA7+rMrHfOtSEGapA78OdA918lfLqc9180/J3mFu
         o1g9dRAdQ9v6l59xd7e/uVKyw/Z5LpCWt+Uzk08+zP2rZDGhZj45MPkzucnCvrSUc5F7
         dx7TWZm4Ktx+dgV7V+JoSP0Feyq5HcSglpTWrdNn4H9QSUVLaQjhadijOxuJXqWp4VuE
         fN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042730; x=1694647530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2kBOi6TalS0ex+1SxjRU4auFtqoVkK5v83q8840CGQ=;
        b=J/RDD8h1pC6hSBw3q/d1K7vHAHVYMvZ4KdB9Iq8f+6ZMwhqZaYHuqeBTwKLD7hdlKw
         eHqOruo4AlNbmM8DXHRzKiU/nva83n44XDw6PgLz7oxKK038hayJ1IZBoJn/XbztTy6M
         5Aphsl93uiRvhYZtj5c5aL1s8tsOvwgEyMkDBYgDZGycWCIiW4+iVKnUBjFLh2ntrd8H
         BdELjz4aCZ1vbn4Qe72j4kdUncLPxI31ek+PUZJJWddTtC9wwJUJ004U/ipOa2zj8X15
         thnfPxJWwQUuZqCzO6nJ0w3kwTI86Gn4wJ+3DxOO7TJr1aJ0siThnFT604IAyVn0JAAc
         W0BQ==
X-Gm-Message-State: AOJu0YzsXQtx6C3cyYjaaJIH3xDTio7rj1Ee9Mcz7VegrFl779gcBGpM
        vu7YzfpAWVYbzR6uAQG9u3CSoY0i/W70rGE3UbSF
X-Google-Smtp-Source: AGHT+IGirEgrnhB2m61RbZ3m1ra5wEtE6paUBVAAeaCtiB5DDurzRuSARCNaPckFTCq44U4w9iqSZTXu1BGwNnra/Fw=
X-Received: by 2002:a0d:e249:0:b0:583:821b:603a with SMTP id
 l70-20020a0de249000000b00583821b603amr1175263ywe.20.1694042730594; Wed, 06
 Sep 2023 16:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230906094202.1712-1-pablo@netfilter.org> <ZPhjYkRpUvfqPB9F@orbyte.nwl.cc>
 <ZPhm1mf0GaeQUr0e@calendula> <ZPiyGC+TfRgyOabJ@orbyte.nwl.cc>
 <ZPjJAicFFam5AFIq@calendula> <CAHC9VhQ0n8Ezef8wYC7uV-MHccqHobYxoB3VYoC9TaGiFm9noQ@mail.gmail.com>
 <ZPjxnSg3/gDy25r0@orbyte.nwl.cc> <ZPj7cbtvF5SdaWrx@calendula>
 <CAHC9VhR5Mq76TQj-zKn4Y2=ehrsmoXUvq=zaM=zY7E9S-tu3Ug@mail.gmail.com> <ZPkE1VyCX1BNc76q@calendula>
In-Reply-To: <ZPkE1VyCX1BNc76q@calendula>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Sep 2023 19:25:19 -0400
Message-ID: <CAHC9VhTGhTdaRpQj8sQZLeibWAA=2_SyUkSwPQvp2BLSBy3JGg@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_tables: Unbreak audit log reset
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Sep 6, 2023 at 7:01=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
> On Wed, Sep 06, 2023 at 06:41:13PM -0400, Paul Moore wrote:
> > On Wed, Sep 6, 2023 at 6:21=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilt=
er.org> wrote:
> > > On Wed, Sep 06, 2023 at 11:39:41PM +0200, Phil Sutter wrote:
> > > > On Wed, Sep 06, 2023 at 03:56:41PM -0400, Paul Moore wrote:
> > > [...]
> > > > > If it is a bug, please submit a fix for this as soon as possible =
Pablo.
> > > >
> > > > Thanks for your support, but I can take over, too. The number of
> > > > notifications emitted even for a small ruleset is not ideal, also. =
It's
> > > > just a bit sad that I ACKed the patch already and so it went out th=
e
> > > > door. Florian, can we still put a veto there?
> > >
> > > Phil, kernel was crashing after your patch, this was resulting in a
> > > kernel panic when running tests here. I had to revert your patches
> > > locally to keep running tests.
> > >
> > > Please, just send an incremental fix to adjust the idx, revert will
> > > leave things in worse state.
> >
> > If we can get a fix out soon then I'm fine with that, if we can't get
> > a fix out soon then a revert may be wise.
>
> I believe it should be possible to fix this in the next -rc, which
> should be quick. If Phil is busy I will jump on this and I will keep
> you on Cc so you and Richard can review.

Great, thank you.

> I apologize for forgetting to Cc you in first place.

No worries :)

> > > Audit does not show chains either, which is not very useful to locate
> > > what where exactly the rules have been reset, but that can probably
> > > discussed in net-next. Richard provided a way to extend this if audit
> > > maintainer find it useful too.
> >
> > Richard was correct in saying that new fields must be added to the end
> > of the record.  The only correction I would make to Richard's comments
> > is that we tend to prefer that if a field is present in a record, it
> > is always present in a record; if there is no useful information to
> > log in that field, a "?" can be substituted for the value (e.g.
> > "nftfield=3D?").
>
> Thanks for clarification, hopefully this will help to explore
> extensions to include chain information in the logs. I think that
> might help users to understand better the kind of updated that
> happened in the Netfilter subsystem.

Great, I'll look forward to the patches.

--=20
paul-moore.com
