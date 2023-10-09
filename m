Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB6CD610E
	for <audit@archiver.kernel.org>; Mon,  9 Oct 2023 17:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbjJIRGp (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377138AbjJIRGo (ORCPT
        <rfc822;audit@vger.kernel.org>); Mon, 9 Oct 2023 13:06:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1AF9E
        for <audit@vger.kernel.org>; Mon,  9 Oct 2023 10:06:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59f6441215dso58482737b3.2
        for <audit@vger.kernel.org>; Mon, 09 Oct 2023 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696871201; x=1697476001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmBGAJnoCJZMD5YkqMwKQjBZ8gmjJXPMwQU2it649Nk=;
        b=X26hFhPoAubOCzejEUrNQ4U28F7KUyFQjmbKP9KnC3Wq3/JT9Gd1AYZ0RFHsPOL69B
         N2zGjPPBUunCsGin7DWtSx/659CfXtC4Bq1UR2TXru0WlJS0ENSxn3p6D3Y7tqzIhZ+n
         3SGvwVjA0DIbHZPGnaqRx6qx0MBsSayN91Gq5aiCvAJ4RU21u7sH3QOpGaN2Oj51iHVz
         DqMrEGc6+0YxSoV/xDpiDejlaEel14Xh8SqWFgdtSZ1/6ApCbCA7ailZEcZePhEA1+DQ
         bPrvHuH/rm27BJeOyrN+0+nNjgU5BCPkl8dKn2xcebvg0j1sJsQ8O/3JsI7981EEsnvK
         EkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871201; x=1697476001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmBGAJnoCJZMD5YkqMwKQjBZ8gmjJXPMwQU2it649Nk=;
        b=pnlLI7RUUfISp29l/W5k6tZ0h48FOZ5Pnw4voIgGK3b0IjnS++yQ2weYG+Tomh4m+F
         JbPBapd+mwTgj8Tsw/QRvpvO4Eo+W7v7hcODrPnCplKC2E3uagDk9lSldeY6+arVZYoK
         1OGbZcl4XPtbtqJE+iWnn+J7mKhMl70rrBrTW0g1WPDFbLYHQF1yFylqhbiY04xWJOST
         Hi//amt8VvKjDTpihbqcXnWh2gq+7NF4pYXUHrgoFYKiMQCA8KnZovt0gvyNEHtcqM9v
         ijaNrrLRZZrxCbyG7zZHoj4ETlTDNBKJtG0sHhWi4y3fII2XA0D1QckFU4p6+4iYc6xI
         +x+w==
X-Gm-Message-State: AOJu0YyIZdQo+0XW/rRfJep9unheWjgAz7l5JBkhJnuAsE3WdyKyp2Hz
        twd3YPMBSohKmgGTIlBCaEklkkvodA8NmWBD/kau
X-Google-Smtp-Source: AGHT+IE5PKJos/UIw4ogaiRRWK6MhbP/Qvn+9ULjQlKUUqbiBU7ekAkM+Ke/DdukZv5OnKha5fea9lOzZBCehUKdX4k=
X-Received: by 2002:a25:9703:0:b0:d9a:3bf2:54a6 with SMTP id
 d3-20020a259703000000b00d9a3bf254a6mr1067676ybo.46.1696871201413; Mon, 09 Oct
 2023 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com> <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
In-Reply-To: <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Oct 2023 13:06:30 -0400
Message-ID: <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
Subject: Re: [apparmor] AppArmor kernel audit locks up system
To:     Andreas Steinmetz <anstein99@googlemail.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, Oct 9, 2023 at 2:40=E2=80=AFAM Andreas Steinmetz
<anstein99@googlemail.com> wrote:
> On Sat, Oct 7, 2023 at 12:07=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Does anyone else have any bright ideas or crazy thoughts on this?
> >
>
> Well, not really an idea and for sure either crazy or dumb:
>
> Why not use the data already available from DEFINE_AUDIT_DATA() to
> determine the call path (or add a modifiable field to the struct) and
> handle locking accordingly?

It's possible I'm missing something as I'm not very familiar with the
AppArmor details, but I'm not sure how this would solve the problem;
can you elaborate on this?

> Anyway, this problem can be seen as a DoS vector. Any malicious code
> could trigger some audit causing a system lockup. So however ugly the
> solution this needs to be solved.

I don't think anyone is objecting to resolving this, it's more a
matter of *how* we can resolve it.

--=20
paul-moore.com
