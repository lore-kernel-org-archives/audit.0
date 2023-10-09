Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A9E95A8E
	for <audit@archiver.kernel.org>; Mon,  9 Oct 2023 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbjJIGkI (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 9 Oct 2023 02:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345293AbjJIGkH (ORCPT
        <rfc822;audit@vger.kernel.org>); Mon, 9 Oct 2023 02:40:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BAAA3
        for <audit@vger.kernel.org>; Sun,  8 Oct 2023 23:40:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65af7d102b3so28381206d6.1
        for <audit@vger.kernel.org>; Sun, 08 Oct 2023 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1696833603; x=1697438403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYs39h2lhFi7LbUTeSxWbxj8l2RGyZpAouEnC3PVDOU=;
        b=F89Ki4cO49zDER8HKQxnbbwv98FtB0hlICpUjCs0qRynvYb3njwikJG0jVbE6C2yDI
         R528cwBt/BVjlEqbGcfCWtV5jPDiHXbXhywMPsrU5jtVOOIZY7I3TvtFNTe45yTXp+rk
         DEMqBpZKI8og2ie2e/XXqoyNkXpmoTSKVg8fu59uq6naS6toapkhTeChassBqSTaUA5C
         naKdIMkws+dEd1ZUdZRRikRQLr6M9yhyF2dSsRR8aX1Ivq5L9VuL2aAlquP1ZCZAD0nN
         L6BYe+0vmjghI8hSPIFsPNKwwaxgtt/0ACiCa3Asa1q/yamkPaU6l4VQmWctl7JxOfvu
         Kt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833603; x=1697438403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYs39h2lhFi7LbUTeSxWbxj8l2RGyZpAouEnC3PVDOU=;
        b=NURxu+lcDspwEMzs1D52zFUXLnJXIuR3sGl/el9VgRjUI9CZa5/J7BGCW4ZePyc61k
         tUWTbMKc7uteQw4vHS8Dr76EzKQzhD1ZPrQrbETXYNjdzm3t3hlaUZ7I0RThmDEigWGC
         gxSrT1W8svWp65iboQsipaZfVoB3rmD8G4kE/mLAoMxiL8symgfisqQuI5zgeIGn+uIy
         Xf2EW10B8SxjBTzuRWuqtB6hlaihWAeRdZsI7xb1tsOf6wx+ZOZwEgjamljGVf+Ry+FM
         RsevGAVdrd/vwyxnN3uQmC1+mIxkLM25cI4HPxC+XhHANqLxXQluOI8iJl2GlS1kvBfm
         10Mw==
X-Gm-Message-State: AOJu0YwfqeorFv4wa9SIIuvzbpRLMCe0p7wMemU59XLP3uX1E/6O5K+G
        4S5w1+KrXVZnDF4/XELbu0+DW3USai+yqVglDjF08cmrT9U=
X-Google-Smtp-Source: AGHT+IE7HBxVWoUrBwss3vbYcO50HuTN5F1bO6E4+Ef1lpkpfJEKmmW5RLABBviYVYgUMwx24jCDskNCqwzRyEQSJCw=
X-Received: by 2002:a0c:b3cf:0:b0:659:71ac:84df with SMTP id
 b15-20020a0cb3cf000000b0065971ac84dfmr13410053qvf.26.1696833603098; Sun, 08
 Oct 2023 23:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
In-Reply-To: <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
From:   Andreas Steinmetz <anstein99@googlemail.com>
Date:   Mon, 9 Oct 2023 06:39:51 +0000
Message-ID: <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Sat, Oct 7, 2023 at 12:07=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Does anyone else have any bright ideas or crazy thoughts on this?
>

Well, not really an idea and for sure either crazy or dumb:

Why not use the data already available from DEFINE_AUDIT_DATA() to
determine the call path (or add a modifiable field to the struct) and
handle locking accordingly?

Anyway, this problem can be seen as a DoS vector. Any malicious code
could trigger some audit causing a system lockup. So however ugly the
solution this needs to be solved.
