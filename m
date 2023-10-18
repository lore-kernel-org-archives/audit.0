Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17BCCDB482
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 22:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJRWXd (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWXd (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 18:23:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D25113
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:23:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so169276276.1
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697667811; x=1698272611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ajnftp73O59rJQP7PyQI1ag+kBRLHglVcmFRcE57mQ=;
        b=DUivJqZV5FlUuHhnCjXOXYUbLYzG75sd90g3gkvq2G+fxLJ1NdOh6FdexVGEED/nDI
         V8JgpkhOETANIDd3aGCuFPGIDbz1Gp4+wqVr69EiyqLnlgt0ZatyzEP0CVe3bk4miY97
         qijfnTngd7THMKIIDQpcWDj4+P/igFttDDNqeE38YfMyBrAGKezeOrtrLukQMgi18l2l
         R2F+8CEPibh30tGj+17qsDNueT5IneOmNYhMJpYrth9TxLy41DL0VC5NlPovYHZH7N3O
         YCyzZANFjH2FxW21RTnpYyIwcFx3AbGWHr8R9z4yEaj8BppXYFoYxshbB4vetCYT4omq
         1QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667811; x=1698272611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ajnftp73O59rJQP7PyQI1ag+kBRLHglVcmFRcE57mQ=;
        b=nhYOiYDmen0up1IdvlLB26k2BbdI/k9uQV0D/fO1GVqDXYG++mH+ic4fqOGWudxaNW
         t/vu6eDVzZHhiQWxeRzMHAbGSy4FUxx6YZC1/sTY0kbCFUDCuZlaKsLjbQLMKHktWa10
         z8cRon9FD7KHsCKcMwE/SxE9Iu5VgCTbRvAH0lu5yuqOO020vwoYndc2HHPZ91IQUKqa
         HTKwB+QhVujuZixX2kAaw/F6cXNLilos5TeUZErJr4NuGG+wp0jTGt41RGhlT5s5nJQ4
         lLC0HqdKUpY213F8nujte7uItMQP53EsxHpSErE5JNgX4gOQQ4aHJ6HmmeG4viZHyI9P
         k6Ow==
X-Gm-Message-State: AOJu0YzDsh6DqsoX+go12Wg19VHt6Me/+PMIpOGmOXyaRV6E/D+alSoS
        /jX+ecEe2Ou/fm04po8KxXX4+ngXztzDF5oRu+djk++M+x2JSfddmA==
X-Google-Smtp-Source: AGHT+IFkCIlvjS3UdbaJfDthTUMuOXzDQ+rtt8Q34aeqMzb7V8/8FtAyrqc+XHMjw98FzTE3rdSrA+2aJlcqrNkLkzA=
X-Received: by 2002:a25:154:0:b0:d86:4342:290 with SMTP id 81-20020a250154000000b00d8643420290mr126206ybb.21.1697667810731;
 Wed, 18 Oct 2023 15:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
 <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
 <6da3d0b6-aaae-4586-bd71-749d6fb38708@canonical.com> <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
 <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com>
 <740fe39c-dab5-4ec9-b717-f5168e689985@canonical.com> <CAHC9VhQTbTkQzCdicPtj7WfEhJgmkX=zxPNu9cGVmHhbbzBzcg@mail.gmail.com>
 <CAHC9VhQ_i0TnA+Snsg-gsPEEb=uHyiNKDm48jmiuRc7y1-Gd=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ_i0TnA+Snsg-gsPEEb=uHyiNKDm48jmiuRc7y1-Gd=Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 18:23:20 -0400
Message-ID: <CAHC9VhTE+xCnAj-NXgCZJwYkp9i1KAJCgQDPWjE3msVYScTQCg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     John Johansen <john.johansen@canonical.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Oct 18, 2023 at 5:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Oct 18, 2023 at 4:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > It shouldn't, the only time we ever really operate on something other
> > than @current is when a fork/clone happens and we are filtering on the
> > new child process.  At least that used to be the case, I can't imagine
> > someone would audit something other than @current (not sure you could
> > with respect to this stuff?), but I guess it couldn't hurt to double
> > check on the current code base.
>
> Yes, that still looks to be the case.
>
> --
> paul-moore.com

Patch posting:

https://lore.kernel.org/audit/20231018222023.371274-2-paul@paul-moore.com

--=20
paul-moore.com
