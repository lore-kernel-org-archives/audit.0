Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8CC0015E
	for <audit@archiver.kernel.org>; Tue, 15 Aug 2023 22:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjHOWO6 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbjHOWOi (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 15 Aug 2023 18:14:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731FF1FEE
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:14:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5844bb9923eso65629377b3.0
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137676; x=1692742476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWhssGhn2cSXZMJR+zaKUad1XnnAKwzBQkgfn7VvUN8=;
        b=I9ZzB+A6XT7r8pSBQ5GQ1r3twGl3VsuYoUirwdMDXOUSsrctQunTkEck5tI+v2XGNh
         gvk1PrIdNaPUO86K1bYaoyJemS9lHxvwAf4a8Nls7FEi0y0ghlsh7YDM/vplJkM580wJ
         bUIIhnc+5w8vuA8p8S3oeI2od3HuOiSjCQ3X1V6MgPT/Y5LtYV5e9oNVS3+4FetGVwIA
         b86SpcoaQC2csRS5rTlqsAGzVzWLBM+sJVZk0dBTVPIdacBb9Da1l8aAEDmZvUbcf08t
         KLRrrLh5Nbr0AXOO5WHqz//brz91U/SFPHjoebqTbIjRJhvdt8DwQJYi8cLqPHv5Uw61
         rrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137676; x=1692742476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWhssGhn2cSXZMJR+zaKUad1XnnAKwzBQkgfn7VvUN8=;
        b=aTezAuOMBEok2vWZEPzFwTpksS+wzizMRtPUYGf7jB/zyPHqlL6lwS4wgWaLaysfHi
         EK9cDGvoWAnYq9sYon+H2UjcNtRnKOpRQ6OA5mwC/x4r6CVzbqMXqWxwIJ0bNt6V7DHR
         Ict68rtrMKEv0y8IGA3D69M1XVSbvGnvIW3T4BNFi24z9xBoEJhai7aQN6P0Obs3QsZb
         /QfD/Mg2ssqi0TSHepcHqagstRexuMbOVSaatvbDruuInKxNIlUXLbItHkepROltfWJo
         wyG2JRFdjBlkv6KWy8xiqokymE0dgRf8eyy0MXRQDPh7ud6YhXtIPyCNeSxFxWB9eEav
         2g/A==
X-Gm-Message-State: AOJu0YwZXktmN1cWtghi8c6VH/d1clwGObzwhnLK8mkG5K2dMJmR1k/B
        5zYG+qsGDFVjke1BWz1NVOQVMuDKW7GrvOVKcDFg
X-Google-Smtp-Source: AGHT+IFOVQHf2CmsZWQr99eCE4yVLvmwB+wEyktAtLNY0vVerWb17bjc8CmS5aAemQ3HQ+s5ggNphgS/arRNUMeVsn0=
X-Received: by 2002:a81:89c6:0:b0:57a:3dd8:1038 with SMTP id
 z189-20020a8189c6000000b0057a3dd81038mr18049772ywf.12.1692137676685; Tue, 15
 Aug 2023 15:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230815204644.52358-1-atulpant.linux@gmail.com> <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
In-Reply-To: <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Aug 2023 18:14:25 -0400
Message-ID: <CAHC9VhSQ9FsxF2rg57B-V5f23OKAA-uCHb1iOkCiTuNeTXHMbg@mail.gmail.com>
Subject: Re: [PATCH v1] kernel: auditsc: Removes use of assignment in if
 condition and moves open brace following function definitions to the next line.
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, Aug 15, 2023 at 6:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> >
> > The patch fixes following checkpatch.pl issue:
> > ERROR: open brace '{' following function definitions go on the next lin=
e
> > ERROR: do not use assignment in if condition
> >
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  kernel/auditsc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Merged into audit/next, thanks.

I also wanted to say that I changed the subject line to "audit:
cleanup function braces and assignment-in-if-condition", what you had
written was far too long for a subject line.  A subject line should be
brief and does not need to be a full sentence, in fact it probably
should *not* be a full sentence.

--=20
paul-moore.com
