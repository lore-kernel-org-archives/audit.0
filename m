Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1729CDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 21:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJRVLi (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjJRVLP (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 17:11:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534742719
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 14:01:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so7922919276.3
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697662868; x=1698267668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYXqAsbDi3AzucY0bCRg3cr8J2sflQDP75mtfuQhHRw=;
        b=Kpc4HRot6CXCVgeManj5M8ejXQJQ6VGaVtERJM8SsH1jfFeKR3fby1xWhXvRcIDbfj
         +mQ8XQHfbt4ive++P4myktPF8uZsJ1EYK05NLi3n0GIncGqvTVyVHlvsGwuZ2jbKUUrK
         ykiDLO8URLHHhYegPZ8ECDbS7KlKsM3B+bY/nlBmahWgL8ZGWSX2wDCGS3CA/ACFzBww
         /vcanskp7WhL5KCW4ynsaY0Lhzdzr/Kfi3ZkCVZcxNswXu6Om59Abnsct7DonisTfis9
         oBNZo2SiCXtkBKx7Rq6T6IC5lgHL7oldwsNbsLNbF1F+IDUnAHFd0SkSr58SfsxhT4yF
         UhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662868; x=1698267668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYXqAsbDi3AzucY0bCRg3cr8J2sflQDP75mtfuQhHRw=;
        b=cbklsIHj8hUqTvvUWNNumDGmzlGh2gKvYzH1HvMtewi2HUp0CslO+Uik1o3fLhWFgS
         2PZAzmQtU4Kn3TBtDs+Yx/AUpo8ERhnmiNYlw/b8+3BM7bRikk7a+2KDKdgZP4NsbaWf
         tK2VPU4ttBS9QbBL7dcxrL55bsOho5qO6XSKCsPoTk8WfL8KZOVqJ/DX+9vxnDrXV9SL
         CfO12lO/3vh3892wAdGfiWyFZDMnHbcY5G4ekxu6qd7tH7IsR5gpwkEA1dwvaLom52mY
         Ia7LKw70TbpGKCV99zvQFW3Gs80iV4hBRy9MupL7/ywExYy4bovKbW+vfGGZ5Zum4qqK
         KEWg==
X-Gm-Message-State: AOJu0YxfiYL7llRWbbsEiY5ui7URLEJvpsAzIAaBHcNyTEoHq+6+YY1K
        n+L55g7Cy0DD8KRfwZrVOrBThC81YXM4m3CUHkKS
X-Google-Smtp-Source: AGHT+IF1b55IhBbDn49IIjzbpXWSvhQXGlj5HU3gwePoV260AYV5B9HuW+0+GaRXNuhzh0NEN49RMRCtco7xjBe3XtI=
X-Received: by 2002:a25:cf0d:0:b0:d9a:4645:abff with SMTP id
 f13-20020a25cf0d000000b00d9a4645abffmr613343ybg.62.1697662868291; Wed, 18 Oct
 2023 14:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
 <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
 <6da3d0b6-aaae-4586-bd71-749d6fb38708@canonical.com> <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
 <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com>
 <740fe39c-dab5-4ec9-b717-f5168e689985@canonical.com> <CAHC9VhQTbTkQzCdicPtj7WfEhJgmkX=zxPNu9cGVmHhbbzBzcg@mail.gmail.com>
In-Reply-To: <CAHC9VhQTbTkQzCdicPtj7WfEhJgmkX=zxPNu9cGVmHhbbzBzcg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 17:00:57 -0400
Message-ID: <CAHC9VhQ_i0TnA+Snsg-gsPEEb=uHyiNKDm48jmiuRc7y1-Gd=Q@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     John Johansen <john.johansen@canonical.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Oct 18, 2023 at 4:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> It shouldn't, the only time we ever really operate on something other
> than @current is when a fork/clone happens and we are filtering on the
> new child process.  At least that used to be the case, I can't imagine
> someone would audit something other than @current (not sure you could
> with respect to this stuff?), but I guess it couldn't hurt to double
> check on the current code base.

Yes, that still looks to be the case.

--=20
paul-moore.com
