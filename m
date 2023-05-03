Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514AC77B75
	for <audit@archiver.kernel.org>; Wed,  3 May 2023 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjECV10 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 3 May 2023 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECV10 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 3 May 2023 17:27:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB424C24
        for <audit@vger.kernel.org>; Wed,  3 May 2023 14:27:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so5730976276.1
        for <audit@vger.kernel.org>; Wed, 03 May 2023 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683149243; x=1685741243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKn+jrgf5ZZ4kjsMO+s/G7W8oD90MsZ6Rc9QWtHf4+c=;
        b=POEgpk0ZXldlHAPzkEdTescNSf+MuuPJ4r3A1Rui5lOdJ7Vq4YDchapw/yd4ddnMBc
         k5zBaaeu+gdhG5ic1AvROP9l3aqprEJxgtc3xutuEJ5b+UxwW9PKGv4WE+sTnFfUSeVZ
         oUAIFWytMamTDEaPh+y3RMYSPMgA3qB1eL5zt5Y/TJfeJZnBuGYnt2PgQGXgsay0/S1B
         Bnuv5SIymd/zs5awLHfeCqEX0SK/t4RGGc1gZfH2PAlAJJjJLVuGf0fpx4ZnZyhXemuM
         02V0QEgVAndZmQU3aDgy1/378dTLzksCeziAijdmoSW3NlFKHpY1QL/NWRWy3l/LOcJc
         uJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149243; x=1685741243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKn+jrgf5ZZ4kjsMO+s/G7W8oD90MsZ6Rc9QWtHf4+c=;
        b=RvyFY70fqn3Xjnlwl0n+FUiKlK72lk8xeLvL9llgSiJt6VTr3/WSyhiww9UcWrMjTe
         +rI3fUkni2UhLwj+Y5V33RYfA2+1H4+EOcFCiC8mxJExkSgF6SvyIqlyVnluXVBy91/J
         vEXfbJZtVQmRjWnhfpwBPVu+Zv46shJK8gvypncZRqZm/OcvmTaTj2/n1D1I4oucIa0e
         yGTPG/IcDwwQWhuBE0zIVBmgA86RJkva/hEgAUQXNDJ4UZdZUZz9mCvQm3FMq1pTZW57
         cwameYV2oY2XcSzFB/eq2qkcFYeTemAnBZwvCm7PPDubFNob3qUhUdLkdktGhii4iypx
         l7KA==
X-Gm-Message-State: AC+VfDyHAaBtfyOyJI6ct/ueeS0M+cbtJkyaR4hMpU0ggJp8/5RCqImS
        Y2S5OmQ6R2dS/NKSiIGNW/a2JmMWXJvPHNArkjnilhV7G1mrIPI+9g==
X-Google-Smtp-Source: ACHHUZ5Au2ecBwsk2/a2XW6nh7EbkJUnX+5vYeJ4vdHMe0++N7uH9a+Afe24IcmFTNIykkzGU7atqXctsrSTKpNbUq0=
X-Received: by 2002:a81:505:0:b0:55a:5323:2801 with SMTP id
 5-20020a810505000000b0055a53232801mr3600764ywf.23.1683149243701; Wed, 03 May
 2023 14:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
In-Reply-To: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 May 2023 17:27:13 -0400
Message-ID: <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
To:     Rinat Gadelshin <rgadelsh@gmail.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, May 3, 2023 at 5:14=E2=80=AFPM Rinat Gadelshin <rgadelsh@gmail.com>=
 wrote:
> Hello there =3D)
>
> My name is Rinat.
> I'm a newbie here (at Linux kernel developer community).
>
> My current job is to work with audit subsystem on different
> versions of Linux (and different kernel versions from 3.10 to the latest)
> with and without auditd.
>
> My program works behalf of root account and uses netlink
> (unicast or multicast depends of  the kernel's version)
> to communicate with audit subsystem of the kernel.
>
> If actual audit rule list has been changed
> then my program should restore the configured audit rule list.
>
> To do it the program periodically (with 60 seconds interval)
> requests the actual rule list be sending AUDIT_LIST_RULES.
>
> All rules are receiving perfectly.
>
> But I've noticed that there are many (2K+ for 5 minutes test)
> kthreadd process have been spawned after that request
> (I've stubbed the poll code and compare logs).

Hi Rinat,

First, a quick note that audit discussions involving the upstream
Linux Kernel have moved to the audit@vger.kernel.org list (CC'd),
please direct future emails there.

Can you be more specific about the kernel threads you are seeing, are
you seeing multiple "kauditd" threads?

% ps -fC kauditd
UID          PID    PPID  C STIME TTY          TIME CMD
root          89       2  0 Apr28 ?        00:00:00 [kauditd]

> Please, can you point me, what can I do to avoid this kthreadd-spam.
>
> Thank you.
>
> Best regards
> Rinath

--=20
paul-moore.com
