Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE69C77B7A
	for <audit@archiver.kernel.org>; Fri,  2 Jun 2023 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjFBPPT (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjFBPPQ (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 2 Jun 2023 11:15:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47918D
        for <audit@vger.kernel.org>; Fri,  2 Jun 2023 08:15:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5289ce6be53so2575594a12.0
        for <audit@vger.kernel.org>; Fri, 02 Jun 2023 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1685718915; x=1688310915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLlNdqI6axFbvYJKMCYGXuL8XXPH0s44RaNvUf/xb6U=;
        b=A62jmKOB1yFlTiUosWU7VYThESPApQWicsGL82YBY5HyRrCmBHSGxhtTsUd7cmxvFP
         FHVeE2Eg5YibxFL0i+3hqOEr0zDDsphcTMgN8Rn6pvDhWsUGMl5plNzEr9zsL6SpjRjJ
         RcyWzBtM0z8ZSV2dTIZYNnKCJ4EzHcTC29MBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718915; x=1688310915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLlNdqI6axFbvYJKMCYGXuL8XXPH0s44RaNvUf/xb6U=;
        b=IWtQ/5jWBib0tKGOsayQG0Heo2TVO/nO9Qlz4Qlvx5h+hGlYSSPte20loXzSRE0M41
         2pzjADV7MoeoHCxJMvO6N1Yt2QkzleYbJKWmP06aHiAM5hbOO4u6lhmQZ7LAk+RsUQzR
         QIchkAwjMfMB7ou01FR4yQhVZChmpoX0U9YDEIxyoURQARpWuBO6omkMGPXK9V4XEd4W
         v8goZS9CXCtJ+wIA1g5g2VDB9OElazx3bSKgyrvpyB2tsz/4rziyJWNiXyr1R+x0RtGv
         x31dUoaMlIjolWOU4cgd7Ovh9/OTBdWVrnxP21kw+S2md/TJ/JoPxJDvUY7iHJf8vHJ3
         yb6g==
X-Gm-Message-State: AC+VfDzX2hGy3l2fkQbA0uQ3h6kx3TbDzWJ5LTHp4nQ2NR1lA1f6msyC
        WHDpZfuu/FUgGD16U7Bp+PifHhcv/852thuqSu8yYQ==
X-Google-Smtp-Source: ACHHUZ6qwVeiaUsGgqIiu+lEAgHS5+tjGdgegjL/iZBujmGeXFWFIdEf/ajIH1GWOoFyADttfsNBiOOHfP+VvXz7XZY=
X-Received: by 2002:a17:903:2449:b0:1ad:ea13:1914 with SMTP id
 l9-20020a170903244900b001adea131914mr61219pls.30.1685718914621; Fri, 02 Jun
 2023 08:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
 <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
 <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
 <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com>
 <CALrw=nFdnSOyfd9X9qzpbTT8R_-m3uBM==FFkNSQ2XZsxUz0Fg@mail.gmail.com> <CAHC9VhR4mnoj=uEEO8ceFvtHAy=ziUROnVHgoNAnH1Gr2+tH5g@mail.gmail.com>
In-Reply-To: <CAHC9VhR4mnoj=uEEO8ceFvtHAy=ziUROnVHgoNAnH1Gr2+tH5g@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 2 Jun 2023 16:15:03 +0100
Message-ID: <CALrw=nHJWv+igGK3R23DQXB3UE_b14ES=sFAQqL0GG9Tw=hrMw@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Jun 2, 2023 at 3:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jun 2, 2023 at 7:08=E2=80=AFAM Ignat Korchagin <ignat@cloudflare.=
com> wrote:
> > On Thu, May 25, 2023 at 3:15=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, May 24, 2023 at 2:05=E2=80=AFPM Ivan Babrou <ivan@cloudflare.=
com> wrote:
> > > > On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > > Could you elaborate on what exactly you would like to see added=
? It's
> > > > > > not clear to me what is missing.
> > > > >
> > > > > I should have been more clear, let me try again ...
> > > > >
> > > > > From my perspective, this patch adds code and complexity to deal =
with
> > > > > the performance impact of auditing.  In some cases that is the ri=
ght
> > > > > thing to do, but I would much rather see a more in-depth analysis=
 of
> > > > > where the audit hot spots are in this benchmark, and some thought=
s on
> > > > > how we might improve that.  In other words, don't just add additi=
onal
> > > > > processing to bypass (slower, more involved) processing; look at =
the
> > > > > processing that is currently being done and see if you can find a=
 way
> > > > > to make it faster.  It will likely take longer, but the results w=
ill
> > > > > be much more useful.
> > > >
> > > > The fastest way to do something is to not do it to begin with.
> > >
> > > While you are not wrong, I believe you and I are focusing on differen=
t
> > > things.  From my perspective, you appear primarily concerned with
> > > improving performance by reducing the overhead of auditing.  I too am
> > > interested in reducing the audit overhead, but I also place a very
> > > high value on maintainable code, perhaps more than performance simply
> > > because the current audit code quality is so very poor.
> > > Unfortunately, the patch you posted appears to me as yet another
> > > bolt-on performance tweak that doesn't make an attempt at analyzing
> > > the current hot spots of syscall auditing, and ideally offering
> > > solutions.  Perhaps ultimately this approach is the only sane thing
> > > that can be done, but I'd like to see some analysis first of the
> > > syscall auditing path.
> >
> > Ivan is out of office, but I would like to keep the discussion going.
> > We do understand your position and we're actually doing a project
> > right now to investigate audit performance better ...
>
> That's great, thank you!
>
> > But the way I see it - the audit subsystem performance and the way how
> > that subsystem plugs into the rest of the kernel code are two somewhat
> > independent things with the patch proposed here addressing the latter
> > (with full understanding that the former might be improved as well) ...
>
> You've done a good job explaining the reasoning and motivations behind
> the patch submitted, that is good, but I'm not seeing any recognition
> or understanding about the perspective I shared with you earlier.  The
> performance of audit in general does need to be improved, I don't
> think anyone disagrees with that, but my argument is that we need to
> focus on changes which not only reduce the processing overhead, but
> *also* reduce the complexity of the code as well.

Ah, sorry. You're right - I paid too much attention to performance and
didn't quite read your concern about code complexity. But still, I
think that code complexity improvements fall onto the implementation
of the audit subsystem itself vs what we try to accomplish here is to
improve the way how that subsystem plugs into the rest of the kernel.

Ignat
