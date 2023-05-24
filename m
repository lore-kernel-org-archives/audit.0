Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B7CC7EE2C
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjEXOyV (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 24 May 2023 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjEXOx6 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 24 May 2023 10:53:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCE12F
        for <audit@vger.kernel.org>; Wed, 24 May 2023 07:53:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-561c1768bacso9187727b3.1
        for <audit@vger.kernel.org>; Wed, 24 May 2023 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684939998; x=1687531998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE6lNBuu4YoKMISZcORQzNf+nJW+X1mV2jIw3RSCm5Q=;
        b=VLpOj2Q75ywxJcD1A8kD356+zP6lSnelrT/3HlzvZwr7DvCe/6Ncuye7jmWE90wXkP
         7rweb9vZlyIh/apT/UADiuH7p2MNeaJesN0vl3x4lJlEbqnovqA0qni52LwPdWboRym8
         qLmQ2K2wGoLacK/muSclPj0j3cRXpAvtKhLcnMEq3RNvV9jboKuzerhJoGWP/LsgNEKP
         youAcq/xLtHirjRkFzjX2jbPANkVQteQZ/1XOQi+d07gmAbbWkZFsp5cihwN5UtUoXmP
         E/h5OU4PHyxHlWV4lY2KH3IiptBP24X5mGc8tsyMW0LZ+3cxod7vZmcpcMJTT/krH1JA
         tIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939998; x=1687531998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE6lNBuu4YoKMISZcORQzNf+nJW+X1mV2jIw3RSCm5Q=;
        b=IJRBUkfYYbnZjlpwHDwjjLDHUDbh18AVZPqhov05eOCn6ywXs4Tr4B9vGwH8vrA9kk
         r3zGWQ2j8NmCR9uJ+OQOsZjlndx94SuVDXbN+sjOF6PR5h7gW6B6LBSXauX3261QYPG3
         OF6FF1cC+1Zn2XjZfVtlaXKmAhtDuep1l4JbX/0BgYKg2bs+N7kg5FwWrWslBUI3UdJ2
         7T9x3e81m4YCxlY2OkwmP3PtvlXSAD5FWqRnwimBAovBPIPL5zgFEhkCFFSUOqSLol0F
         tNXXXfsW951Hc3idhe4yYvCzxCN9b6ykgY9i5ysrA1z5ekZ1TVSyMTQAr39Z2zO4RGVq
         jI/A==
X-Gm-Message-State: AC+VfDyec78EyQ3/xvBC7vVaI07csDR4jmNbl60rH15P/8zhCsbZqg15
        DIt5BkIhaILt7M9jG7by1g62HK/Lubi42+VaMZ5F
X-Google-Smtp-Source: ACHHUZ77Rq4elY0z3/4AT5NhEIQGxI8/zjnClKywexRa7FId94N0oB/LlqzNEOOSQ8hSqkeUgVb9IBw55edGc3/FZlA=
X-Received: by 2002:a81:6c57:0:b0:562:b9b:2a95 with SMTP id
 h84-20020a816c57000000b005620b9b2a95mr20488652ywc.3.1684939998476; Wed, 24
 May 2023 07:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <b5e87a11-7605-6745-516a-8004569bbe5d@gmail.com> <2151809.irdbgypaU6@x2>
In-Reply-To: <2151809.irdbgypaU6@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 May 2023 10:53:07 -0400
Message-ID: <CAHC9VhThSLtni=JuStofi78=18SdH+VCUA4eGdOkbM9=J+wzLA@mail.gmail.com>
Subject: Re: Auditd doesn't receive syscalls after installation for the
 current shell.
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Rinat Gadelshin <rgadelsh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, May 24, 2023 at 10:46=E2=80=AFAM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Wednesday, May 24, 2023 7:37:27 AM EDT Rinat Gadelshin wrote:
> > Hello there.
> >
> > It seems that the kernel doesn't send messages for syscalls of the shel=
l
> > process from which auditd is installed.
> >
> > Reproducing steps (performed on Ubuntu 22.04 x86_64 on virtual box by
> > `root`):
> >
> > step #1: $ apt install auditd
> > step #2: $ auditctl -a always,exit -F arch=3Db64 -S openat,renameat2,un=
linkat
> > step #3: $ echo t>delme;echo t2>>delme;cat delme;mv delme d;mv d
> > delme;rm delme
> > step #4: $ service auditd stop
> > step #5: $ ausearch -f delme
> >
> > There are syscalls from /usr/bin/cat, /usr/bin/mv, /usr/bin/rm but ther=
e
> > are no any syscalls (openat expected)
> > for /usr/bin/bash (current shell process) for the file.
> >
> > If step #3 is performed from another tty, then openat syscalls
> > (CREATE for the first echo and NORMAL for the second one)
> > is logged for the /usr/bin/bash process.
> >
> > `uname -a` returns: Linux grin-vb-ubuntu-22-0-4 5.19.0-41-generic
> > #42~22.04.01-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 18 17:40:00 UTC 2 x86_6=
4
> > x86_64 x86_64 GNU/Linux
> >
> > Should I open an issue for the case at
> > https://github.com/linux-audit/audit-kernel ?
>
> Are you booting with audit=3D1 ? If not, the install process and any befo=
re it
> are not auditable. You will only get events for processes started after a=
udit
> enabled =3D 1.

It is also worth noting that some distributions (I'm not sure if this
applies to Ubuntu) effectively limit auditing with their default
runtime configuration, see the wiki page below for more information:

* https://github.com/linux-audit/audit-documentation/wiki/HOWTO-Fedora-Enab=
le-Auditing

--=20
paul-moore.com
